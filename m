Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSDMQPZ>; Sat, 13 Apr 2002 12:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSDMQPY>; Sat, 13 Apr 2002 12:15:24 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:50954 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S289272AbSDMQPW>; Sat, 13 Apr 2002 12:15:22 -0400
Date: Sat, 13 Apr 2002 12:15:22 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Stanislav Meduna <stano@meduna.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: uhci locks up in 2.4.19-pre6
Message-ID: <20020413121522.A8314@sventech.com>
In-Reply-To: <20020413140246.A1701@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002, Stanislav Meduna <stano@meduna.org> wrote:
> trying to load a uhci module from 2.4.19-pre6 at boot locks my computer.
> 
> In 2.4.18 I noticed that the USB printing stopped to work
> (see the thread "USB printing via ptal broke between 2.4.17 and .18"
> started on 29 Mar). I the tested 2.4.19-pre5 and loading the uhci
> module locked the machine. In -pre6 the behaviour is the same.
> 
> Can I switch some debug mode on to help you seeing where the thing
> locks?
> 
> This is on the Abit BP6 motherboard (Celeron SMP box). I see that
> there are quite a few changes in the uhci area - please, don't
> make final 2.4.19 until these issues are resolved.
> 
> Using usb-uhci is not an option for me, as it is causing lockups
> when printing to a USB printer (and ever did so). uhci was OK
> in this regard up to 2.4.17.

Apply these patches. They should be in -pre7 (or -rc1, depending on what
Marcelo calls it).

This should fix all outstanding lockups and performance problems with
uhci.c. Let me know how it goes for you.

JE

--- linux-2.4.19-pre6.orig/drivers/usb/uhci.c	Sun Apr  7 13:22:10 2002
+++ linux-2.4.19-pre6/drivers/usb/uhci.c	Sun Apr  7 13:25:27 2002
@@ -1811,6 +1811,9 @@
 		} else {
 			urb->status = -ENOENT;
 
+			spin_unlock(&urb->lock);
+			spin_unlock_irqrestore(&uhci->urb_list_lock, flags);
+
 			if (in_interrupt()) {	/* wait at least 1 frame */
 				static int errorcount = 10;
 
@@ -1820,9 +1823,6 @@
 			} else
 				schedule_timeout(1+1*HZ/1000); 
 
-			spin_unlock(&urb->lock);
-			spin_unlock_irqrestore(&uhci->urb_list_lock, flags);
-
 			uhci_call_completion(urb);
 		}
 	}
@@ -2193,12 +2193,12 @@
 			OK(0);
 		case RH_PORT_RESET:
 			SET_RH_PORTSTAT(USBPORTSC_PR);
-			wait_ms(50);	/* USB v1.1 7.1.7.3 */
+			mdelay(50);	/* USB v1.1 7.1.7.3 */
 			uhci->rh.c_p_r[wIndex - 1] = 1;
 			CLR_RH_PORTSTAT(USBPORTSC_PR);
 			udelay(10);
 			SET_RH_PORTSTAT(USBPORTSC_PE);
-			wait_ms(10);
+			mdelay(10);
 			SET_RH_PORTSTAT(0xa);
 			OK(0);
 		case RH_PORT_POWER:


--- linux-2.4.19-pre6.orig/drivers/usb/uhci.c	Sun Apr  7 16:21:04 2002
+++ linux-2.4.19-pre6/drivers/usb/uhci.c	Sun Apr  7 16:24:03 2002
@@ -748,7 +748,7 @@
 
 	if ((!(urb->transfer_flags & USB_NO_FSBR)) && !urbp->fsbr) {
 		urbp->fsbr = 1;
-		if (!uhci->fsbr++)
+		if (!uhci->fsbr++ && !uhci->fsbrtimeout)
 			uhci->skel_term_qh->link = uhci->skel_hs_control_qh->dma_handle | UHCI_PTR_QH;
 	}
 
@@ -2739,6 +2739,11 @@
 	/* Reset here so we don't get any interrupts from an old setup */
 	/*  or broken setup */
 	reset_hc(uhci);
+
+	uhci->fsbr = 0;
+	uhci->fsbrtimeout = 0;
+
+	uhci->is_suspended = 0;
 
 	spin_lock_init(&uhci->qh_remove_list_lock);
 	INIT_LIST_HEAD(&uhci->qh_remove_list);


--- linux-2.4.19-pre6.orig/drivers/usb/uhci.c	Sun Apr  7 16:27:23 2002
+++ linux-2.4.19-pre6/drivers/usb/uhci.c	Sun Apr  7 16:28:23 2002
@@ -1837,10 +1837,6 @@
 
 	uhci_dec_fsbr(uhci, urb);
 
-	/* There is a race with updating IOC in here, but it's not worth */
-	/*  trying to fix since this is merely an optimization. The only */
-	/*  time we'd lose is if the status of the packet got updated */
-	/*  and we'd be turning on FSBR next frame anyway, so it's a wash */
 	urbp->fsbr_timeout = 1;
 
 	head = &urbp->td_list;
@@ -2004,23 +2000,23 @@
 	tmp = head->next;
 	while (tmp != head) {
 		struct urb *u = list_entry(tmp, struct urb, urb_list);
-		struct urb_priv *urbp = (struct urb_priv *)u->hcpriv;
+		struct urb_priv *up = (struct urb_priv *)u->hcpriv;
 
 		tmp = tmp->next;
 
-		spin_lock(&urb->lock);
+		spin_lock(&u->lock);
 
 		/* Check if the FSBR timed out */
-		if (urbp->fsbr && !urbp->fsbr_timeout && time_after_eq(jiffies, urbp->fsbrtime + IDLE_TIMEOUT))
+		if (up->fsbr && !up->fsbr_timeout && time_after_eq(jiffies, up->fsbrtime + IDLE_TIMEOUT))
 			uhci_fsbr_timeout(uhci, u);
 
 		/* Check if the URB timed out */
-		if (u->timeout && time_after_eq(jiffies, urbp->inserttime + u->timeout)) {
+		if (u->timeout && time_after_eq(jiffies, up->inserttime + u->timeout)) {
 			list_del(&u->urb_list);
 			list_add_tail(&u->urb_list, &list);
 		}
 
-		spin_unlock(&urb->lock);
+		spin_unlock(&u->lock);
 	}
 	spin_unlock_irqrestore(&uhci->urb_list_lock, flags);
 

--- linux-2.4.19-pre6.orig/drivers/usb/uhci.c	Sun Apr  7 16:29:57 2002
+++ linux-2.4.19-pre6/drivers/usb/uhci.c	Sun Apr  7 16:22:49 2002
@@ -1622,8 +1622,7 @@
 
 	if (urb->status != -EINPROGRESS) {
 		info("uhci_transfer_result: called for URB %p not in flight?", urb);
-		spin_unlock_irqrestore(&urb->lock, flags);
-		return;
+		goto out;
 	}
 
 	switch (usb_pipetype(urb->pipe)) {
@@ -1643,10 +1642,8 @@
 
 	urbp->status = ret;
 
-	if (ret == -EINPROGRESS) {
-		spin_unlock_irqrestore(&urb->lock, flags);
-		return;
-	}
+	if (ret == -EINPROGRESS)
+		goto out;
 
 	switch (usb_pipetype(urb->pipe)) {
 	case PIPE_CONTROL:
@@ -1660,11 +1657,8 @@
 		break;
 	case PIPE_INTERRUPT:
 		/* Interrupts are an exception */
-		if (urb->interval) {
-			uhci_add_complete(urb);
-			spin_unlock_irqrestore(&urb->lock, flags);
-			return;		/* <-- note return */
-		}
+		if (urb->interval)
+			goto out_complete;
 
 		/* Release bandwidth for Interrupt or Isoc. transfers */
 		/* Spinlock needed ? */
@@ -1680,8 +1674,10 @@
 	/* Remove it from uhci->urb_list */
 	list_del_init(&urb->urb_list);
 
+out_complete:
 	uhci_add_complete(urb);
 
+out:
 	spin_unlock_irqrestore(&urb->lock, flags);
 }
 
@@ -2710,6 +2706,7 @@
 	}
 
 	uhci->dev = dev;
+	uhci->irq = dev->irq;
 	uhci->io_addr = io_addr;
 	uhci->io_size = io_size;
 	pci_set_drvdata(dev, uhci);
@@ -2922,8 +2919,6 @@
 
 	if (request_irq(dev->irq, uhci_interrupt, SA_SHIRQ, "usb-uhci", uhci))
 		goto err_request_irq;
-
-	uhci->irq = dev->irq;
 
 	/* disable legacy emulation */
 	pci_write_config_word(uhci->dev, USBLEGSUP, USBLEGSUP_DEFAULT);
--- linux-2.4.19-pre6.orig/drivers/usb/uhci.h	Sun Apr  7 13:22:10 2002
+++ linux-2.4.19-pre6/drivers/usb/uhci.h	Sun Apr  7 16:16:55 2002
@@ -287,16 +287,16 @@
 struct uhci {
 	struct pci_dev *dev;
 
+#ifdef CONFIG_PROC_FS
 	/* procfs */
 	int num;
 	struct proc_dir_entry *proc_entry;
+#endif
 
 	/* Grabbed from PCI */
 	int irq;
 	unsigned int io_addr;
 	unsigned int io_size;
-
-	struct list_head uhci_list;
 
 	struct pci_pool *qh_pool;
 	struct pci_pool *td_pool;
