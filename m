Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVFKSwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVFKSwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVFKSwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:52:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9883 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261776AbVFKSwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:52:17 -0400
Date: Sat, 11 Jun 2005 20:48:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050611184819.GA21033@elte.hu>
References: <20050608112801.GA31084@elte.hu> <1118507720.12860.8.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118507720.12860.8.camel@twins>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Hi Ingo,
> 
> I'm having some difficulty with your latest patches; more specifically
> linux-2.6.12-rc6-git4-RT-V0.7.48-10 floods me with BUGs like these:

> I gather these are because of:
> 
> drivers/usb/code/hcd.c:rh_report_status
> 
> static void rh_report_status (unsigned long ptr)

does the patch below help?

> On another note; X seems to have trouble getting up. It consumes a 
> full CPU right after mode switching (afaict) without getting any 
> progress. I'll try and get a nice trace of X using sysrq-t.

could this be due to the messages spamming the console?

	Ingo

--- usb/core/hcd.c.orig
+++ usb/core/hcd.c
@@ -353,7 +353,9 @@ static int rh_call_control (struct usb_h
 	const u8	*bufp = tbuf;
 	int		len = 0;
 	int		patch_wakeup = 0;
+#ifndef CONFIG_PREEMPT_RT
 	unsigned long	flags;
+#endif
 	int		status = 0;
 	int		n;
 
@@ -506,13 +508,17 @@ error:
 	}
 
 	/* any errors get returned through the urb completion */
+#ifndef CONFIG_PREEMPT_RT
 	local_irq_save (flags);
+#endif
 	spin_lock (&urb->lock);
 	if (urb->status == -EINPROGRESS)
 		urb->status = status;
 	spin_unlock (&urb->lock);
 	usb_hcd_giveback_urb (hcd, urb, NULL);
+#ifndef CONFIG_PREEMPT_RT
 	local_irq_restore (flags);
+#endif
 	return 0;
 }
 
@@ -562,15 +568,13 @@ static void rh_report_status (unsigned l
 	unsigned long	flags;
 
 	urb = (struct urb *) ptr;
-	local_irq_save (flags);
-	spin_lock (&urb->lock);
+	spin_lock_irqsave (&urb->lock, flags);
 
 	/* do nothing if the urb's been unlinked */
 	if (!urb->dev
 			|| urb->status != -EINPROGRESS
 			|| (hcd = urb->dev->bus->hcpriv) == NULL) {
-		spin_unlock (&urb->lock);
-		local_irq_restore (flags);
+		spin_unlock_irqrestore (&urb->lock, flags);
 		return;
 	}
 
@@ -588,12 +592,12 @@ static void rh_report_status (unsigned l
 			mod_timer (&hcd->rh_timer, jiffies + HZ/4);
 	}
 	spin_unlock (&hcd_data_lock);
-	spin_unlock (&urb->lock);
 
 	/* local irqs are always blocked in completions */
 	if (length > 0)
 		usb_hcd_giveback_urb (hcd, urb, NULL);
-	local_irq_restore (flags);
+
+	spin_unlock_irqrestore (&urb->lock, flags);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -619,17 +623,23 @@ static int rh_urb_enqueue (struct usb_hc
 
 static int usb_rh_urb_dequeue (struct usb_hcd *hcd, struct urb *urb)
 {
+#ifndef CONFIG_PREEMPT_RT
 	unsigned long	flags;
+#endif
 
 	/* note:  always a synchronous unlink */
 	if ((unsigned long) urb == hcd->rh_timer.data) {
 		del_timer_sync (&hcd->rh_timer);
 		hcd->rh_timer.data = 0;
 
+#ifndef CONFIG_PREEMPT_RT
 		local_irq_save (flags);
+#endif
 		urb->hcpriv = NULL;
 		usb_hcd_giveback_urb (hcd, urb, NULL);
+#ifndef CONFIG_PREEMPT_RT
 		local_irq_restore (flags);
+#endif
 
 	} else if (usb_pipeendpoint(urb->pipe) == 0) {
 		spin_lock_irq(&urb->lock);	/* from usb_kill_urb */
@@ -1357,15 +1367,13 @@ hcd_endpoint_disable (struct usb_device 
 
 	WARN_ON (!HC_IS_RUNNING (hcd->state) && hcd->state != HC_STATE_HALT);
 
-	local_irq_disable ();
-
 	/* FIXME move most of this into message.c as part of its
 	 * endpoint disable logic
 	 */
 
 	/* ep is already gone from udev->ep_{in,out}[]; no more submits */
 rescan:
-	spin_lock (&hcd_data_lock);
+	spin_lock_irq (&hcd_data_lock);
 	list_for_each_entry (urb, &ep->urb_list, urb_list) {
 		int	tmp;
 
@@ -1378,13 +1386,13 @@ rescan:
 		if (urb->status != -EINPROGRESS)
 			continue;
 		usb_get_urb (urb);
-		spin_unlock (&hcd_data_lock);
+		spin_unlock_irq (&hcd_data_lock);
 
-		spin_lock (&urb->lock);
+		spin_lock_irq (&urb->lock);
 		tmp = urb->status;
 		if (tmp == -EINPROGRESS)
 			urb->status = -ESHUTDOWN;
-		spin_unlock (&urb->lock);
+		spin_unlock_irq (&urb->lock);
 
 		/* kick hcd unless it's already returning this */
 		if (tmp == -EINPROGRESS) {
@@ -1407,8 +1415,7 @@ rescan:
 		/* list contents may have changed */
 		goto rescan;
 	}
-	spin_unlock (&hcd_data_lock);
-	local_irq_enable ();
+	spin_unlock_irq (&hcd_data_lock);
 
 	/* synchronize with the hardware, so old configuration state
 	 * clears out immediately (and will be freed).
