Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVHPQL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVHPQL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVHPQL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:11:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16827 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1030212AbVHPQL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:11:58 -0400
Date: Tue, 16 Aug 2005 18:12:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ryan Brown <some.nzguy@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Message-ID: <20050816161226.GA2826@elte.hu>
References: <20050816035353.GA8411@elte.hu> <Pine.LNX.4.44L0.0508161009010.4823-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0508161009010.4823-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Stern <stern@rowland.harvard.edu> wrote:

> Interrupts are disabled during usb_hcd_giveback_urb because that's how 
> it was done originally and nobody has made an effort to remove this 
> assumption from the USB device drivers.  There's no real reason for it 
> other than historical inertia.  It's not done for serialization -- 
> there's no need for serialization since an URB can't be resubmitted 
> before the previous callback occurs (unless a driver is badly broken).  
> The "detached" method is used simply to avoid an extra pair of 
> enable/disable instructions.

so we can remove it altogether, via the patch below? (If there's any 
unsafe driver, it should already be unsafe on SMP, and with the 
proliferation of HT and dual-core CPUs, SMP will be the norm within a 
year or so - so the sooner we trigger any breakages, the better i 
guess.)

i'll give it a whirl in the -RT tree.

	Ingo

----

remove unnecessarily irqs-off sections from hcd.c.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/usb/core/hcd.c
===================================================================
--- linux.orig/drivers/usb/core/hcd.c
+++ linux/drivers/usb/core/hcd.c
@@ -506,13 +506,11 @@ error:
 	}
 
 	/* any errors get returned through the urb completion */
-	local_irq_save (flags);
-	spin_lock (&urb->lock);
+	spin_lock_irqsave(&urb->lock, flags);
 	if (urb->status == -EINPROGRESS)
 		urb->status = status;
-	spin_unlock (&urb->lock);
+	spin_unlock_irqrestore(&urb->lock, flags);
 	usb_hcd_giveback_urb (hcd, urb, NULL);
-	local_irq_restore (flags);
 	return 0;
 }
 
@@ -540,8 +538,7 @@ void usb_hcd_poll_rh_status(struct usb_h
 	if (length > 0) {
 
 		/* try to complete the status urb */
-		local_irq_save (flags);
-		spin_lock(&hcd_root_hub_lock);
+		spin_lock_irqsave(&hcd_root_hub_lock, flags);
 		urb = hcd->status_urb;
 		if (urb) {
 			spin_lock(&urb->lock);
@@ -557,14 +554,13 @@ void usb_hcd_poll_rh_status(struct usb_h
 			spin_unlock(&urb->lock);
 		} else
 			length = 0;
-		spin_unlock(&hcd_root_hub_lock);
+		spin_unlock_irqrestore(&hcd_root_hub_lock, flags);
 
 		/* local irqs are always blocked in completions */
 		if (length > 0)
 			usb_hcd_giveback_urb (hcd, urb, NULL);
 		else
 			hcd->poll_pending = 1;
-		local_irq_restore (flags);
 	}
 
 	/* The USB 2.0 spec says 256 ms.  This is close enough and won't
@@ -647,17 +643,15 @@ static int usb_rh_urb_dequeue (struct us
 	} else {				/* Status URB */
 		if (!hcd->uses_new_polling)
 			del_timer_sync (&hcd->rh_timer);
-		local_irq_disable ();
-		spin_lock (&hcd_root_hub_lock);
+		spin_lock_irq(&hcd_root_hub_lock);
 		if (urb == hcd->status_urb) {
 			hcd->status_urb = NULL;
 			urb->hcpriv = NULL;
 		} else
 			urb = NULL;		/* wasn't fully queued */
-		spin_unlock (&hcd_root_hub_lock);
+		spin_unlock_irq(&hcd_root_hub_lock);
 		if (urb)
 			usb_hcd_giveback_urb (hcd, urb, NULL);
-		local_irq_enable ();
 	}
 
 	return 0;
@@ -1367,15 +1361,13 @@ hcd_endpoint_disable (struct usb_device 
 	WARN_ON (!HC_IS_RUNNING (hcd->state) && hcd->state != HC_STATE_HALT &&
 			udev->state != USB_STATE_NOTATTACHED);
 
-	local_irq_disable ();
-
 	/* FIXME move most of this into message.c as part of its
 	 * endpoint disable logic
 	 */
 
 	/* ep is already gone from udev->ep_{in,out}[]; no more submits */
 rescan:
-	spin_lock (&hcd_data_lock);
+	spin_lock_irq(&hcd_data_lock);
 	list_for_each_entry (urb, &ep->urb_list, urb_list) {
 		int	tmp;
 
@@ -1388,13 +1380,13 @@ rescan:
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
@@ -1417,8 +1409,7 @@ rescan:
 		/* list contents may have changed */
 		goto rescan;
 	}
-	spin_unlock (&hcd_data_lock);
-	local_irq_enable ();
+	spin_unlock_irq(&hcd_data_lock);
 
 	/* synchronize with the hardware, so old configuration state
 	 * clears out immediately (and will be freed).
