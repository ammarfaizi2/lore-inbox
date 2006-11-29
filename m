Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935336AbWK2HKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935336AbWK2HKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935380AbWK2HKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:10:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39300 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935336AbWK2HKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:10:24 -0500
Date: Wed, 29 Nov 2006 08:06:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.19-rc6-rt8
Message-ID: <20061129070649.GA32455@elte.hu>
References: <20061127094927.GA7339@elte.hu> <200611282340.21317.fzu@wemgehoertderstaat.de> <200611290104.51731.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611290104.51731.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> After estimated 15 minutes more it bugged again.
> Related dmesg translates to linux error
> 	-EXDEV
> propably caused by the following lines:
> 
> <snip>
> static int uhci_result_isochronous(struct uhci_hcd *uhci, struct urb *urb)

hm. Below are all the USB changes done by -rt. Maybe one of them has 
some side-effect?

	Ingo

Index: linux/drivers/usb/core/devio.c
===================================================================
--- linux.orig/drivers/usb/core/devio.c
+++ linux/drivers/usb/core/devio.c
@@ -309,10 +309,11 @@ static void async_completed(struct urb *
         struct async *as = urb->context;
         struct dev_state *ps = as->ps;
 	struct siginfo sinfo;
+	unsigned long flags;
 
-        spin_lock(&ps->lock);
-        list_move_tail(&as->asynclist, &ps->async_completed);
-        spin_unlock(&ps->lock);
+	spin_lock_irqsave(&ps->lock, flags);
+	list_move_tail(&as->asynclist, &ps->async_completed);
+	spin_unlock_irqrestore(&ps->lock, flags);
 	if (as->signr) {
 		sinfo.si_signo = as->signr;
 		sinfo.si_errno = as->urb->status;
Index: linux/drivers/usb/core/hcd.c
===================================================================
--- linux.orig/drivers/usb/core/hcd.c
+++ linux/drivers/usb/core/hcd.c
@@ -517,13 +517,11 @@ error:
 	}
 
 	/* any errors get returned through the urb completion */
-	local_irq_save (flags);
-	spin_lock (&urb->lock);
+	spin_lock_irqsave(&urb->lock, flags);
 	if (urb->status == -EINPROGRESS)
 		urb->status = status;
-	spin_unlock (&urb->lock);
+	spin_unlock_irqrestore(&urb->lock, flags);
 	usb_hcd_giveback_urb (hcd, urb);
-	local_irq_restore (flags);
 	return 0;
 }
 
@@ -551,8 +549,7 @@ void usb_hcd_poll_rh_status(struct usb_h
 	if (length > 0) {
 
 		/* try to complete the status urb */
-		local_irq_save (flags);
-		spin_lock(&hcd_root_hub_lock);
+		spin_lock_irqsave(&hcd_root_hub_lock, flags);
 		urb = hcd->status_urb;
 		if (urb) {
 			spin_lock(&urb->lock);
@@ -568,14 +565,13 @@ void usb_hcd_poll_rh_status(struct usb_h
 			spin_unlock(&urb->lock);
 		} else
 			length = 0;
-		spin_unlock(&hcd_root_hub_lock);
+		spin_unlock_irqrestore(&hcd_root_hub_lock, flags);
 
 		/* local irqs are always blocked in completions */
 		if (length > 0)
 			usb_hcd_giveback_urb (hcd, urb);
 		else
 			hcd->poll_pending = 1;
-		local_irq_restore (flags);
 	}
 
 	/* The USB 2.0 spec says 256 ms.  This is close enough and won't
@@ -647,17 +643,15 @@ static int usb_rh_urb_dequeue (struct us
 	} else {				/* Status URB */
 		if (!hcd->uses_new_polling)
 			del_timer (&hcd->rh_timer);
-		local_irq_save (flags);
-		spin_lock (&hcd_root_hub_lock);
+		spin_lock_irqsave(&hcd_root_hub_lock, flags);
 		if (urb == hcd->status_urb) {
 			hcd->status_urb = NULL;
 			urb->hcpriv = NULL;
 		} else
 			urb = NULL;		/* wasn't fully queued */
-		spin_unlock (&hcd_root_hub_lock);
+		spin_unlock_irqrestore(&hcd_root_hub_lock, flags);
 		if (urb)
 			usb_hcd_giveback_urb (hcd, urb);
-		local_irq_restore (flags);
 	}
 
 	return 0;
@@ -1311,11 +1305,9 @@ void usb_hcd_endpoint_disable (struct us
 	WARN_ON (!HC_IS_RUNNING (hcd->state) && hcd->state != HC_STATE_HALT &&
 			udev->state != USB_STATE_NOTATTACHED);
 
-	local_irq_disable ();
-
 	/* ep is already gone from udev->ep_{in,out}[]; no more submits */
 rescan:
-	spin_lock (&hcd_data_lock);
+	spin_lock_irq(&hcd_data_lock);
 	list_for_each_entry (urb, &ep->urb_list, urb_list) {
 		int	tmp;
 
@@ -1323,13 +1315,13 @@ rescan:
 		if (urb->status != -EINPROGRESS)
 			continue;
 		usb_get_urb (urb);
-		spin_unlock (&hcd_data_lock);
+		spin_unlock_irq(&hcd_data_lock);
 
-		spin_lock (&urb->lock);
+		spin_lock_irq(&urb->lock);
 		tmp = urb->status;
 		if (tmp == -EINPROGRESS)
 			urb->status = -ESHUTDOWN;
-		spin_unlock (&urb->lock);
+		spin_unlock_irq(&urb->lock);
 
 		/* kick hcd unless it's already returning this */
 		if (tmp == -EINPROGRESS) {
@@ -1352,8 +1344,7 @@ rescan:
 		/* list contents may have changed */
 		goto rescan;
 	}
-	spin_unlock (&hcd_data_lock);
-	local_irq_enable ();
+	spin_unlock_irq(&hcd_data_lock);
 
 	/* synchronize with the hardware, so old configuration state
 	 * clears out immediately (and will be freed).
Index: linux/drivers/usb/core/message.c
===================================================================
--- linux.orig/drivers/usb/core/message.c
+++ linux/drivers/usb/core/message.c
@@ -249,8 +249,9 @@ static void sg_clean (struct usb_sg_requ
 static void sg_complete (struct urb *urb)
 {
 	struct usb_sg_request	*io = urb->context;
+	unsigned long flags;
 
-	spin_lock (&io->lock);
+	spin_lock_irqsave (&io->lock, flags);
 
 	/* In 2.5 we require hcds' endpoint queues not to progress after fault
 	 * reports, until the completion callback (this!) returns.  That lets
@@ -284,7 +285,7 @@ static void sg_complete (struct urb *urb
 		 * unlink pending urbs so they won't rx/tx bad data.
 		 * careful: unlink can sometimes be synchronous...
 		 */
-		spin_unlock (&io->lock);
+		spin_unlock_irqrestore (&io->lock, flags);
 		for (i = 0, found = 0; i < io->entries; i++) {
 			if (!io->urbs [i] || !io->urbs [i]->dev)
 				continue;
@@ -299,7 +300,7 @@ static void sg_complete (struct urb *urb
 			} else if (urb == io->urbs [i])
 				found = 1;
 		}
-		spin_lock (&io->lock);
+		spin_lock_irqsave (&io->lock, flags);
 	}
 	urb->dev = NULL;
 
@@ -309,7 +310,7 @@ static void sg_complete (struct urb *urb
 	if (!io->count)
 		complete (&io->complete);
 
-	spin_unlock (&io->lock);
+	spin_unlock_irqrestore (&io->lock, flags);
 }
 
 
@@ -571,7 +572,7 @@ void usb_sg_cancel (struct usb_sg_reques
 				dev_warn (&io->dev->dev, "%s, unlink --> %d\n",
 					__FUNCTION__, retval);
 		}
-		spin_lock (&io->lock);
+		spin_lock_irqsave (&io->lock, flags);
 	}
 	spin_unlock_irqrestore (&io->lock, flags);
 }
Index: linux/drivers/usb/net/usbnet.c
===================================================================
--- linux.orig/drivers/usb/net/usbnet.c
+++ linux/drivers/usb/net/usbnet.c
@@ -898,6 +898,8 @@ static void tx_complete (struct urb *urb
 
 	urb->dev = NULL;
 	entry->state = tx_done;
+	spin_lock_rt(&dev->txq.lock);
+	spin_unlock_rt(&dev->txq.lock);
 	defer_bh(dev, skb, &dev->txq);
 }
 
