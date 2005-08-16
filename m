Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVHPQ4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVHPQ4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVHPQ4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:56:14 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:30128 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030236AbVHPQ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:56:13 -0400
Date: Tue, 16 Aug 2005 12:56:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Ingo Molnar <mingo@elte.hu>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ryan Brown <some.nzguy@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
In-Reply-To: <20050816161226.GA2826@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0508161247030.18302-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, Ingo Molnar wrote:

> * Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > Interrupts are disabled during usb_hcd_giveback_urb because that's how 
> > it was done originally and nobody has made an effort to remove this 
> > assumption from the USB device drivers.  There's no real reason for it 
> > other than historical inertia.  It's not done for serialization -- 
> > there's no need for serialization since an URB can't be resubmitted 
> > before the previous callback occurs (unless a driver is badly broken).  
> > The "detached" method is used simply to avoid an extra pair of 
> > enable/disable instructions.
> 
> so we can remove it altogether, via the patch below? (If there's any 
> unsafe driver, it should already be unsafe on SMP, and with the 
> proliferation of HT and dual-core CPUs, SMP will be the norm within a 
> year or so - so the sooner we trigger any breakages, the better i 
> guess.)
> 
> i'll give it a whirl in the -RT tree.

In general yes, the patch should be okay.  But there are a few things to
check for.  Perhaps most of the USB drivers don't care whether interrupts
are enabled or not in their completion routines.  However I know of at
least one where it does matter.  The current code _is_ SMP-safe, but it
won't remain UP-safe unless you add this patch in addition to your own.

Alan Stern

P.S.: Another routine worth examining is async_completed() in 
drivers/usb/core/devio.c.



Index: usb-2.6/drivers/usb/core/message.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/message.c
+++ usb-2.6/drivers/usb/core/message.c
@@ -224,8 +224,9 @@ static void sg_clean (struct usb_sg_requ
 static void sg_complete (struct urb *urb, struct pt_regs *regs)
 {
 	struct usb_sg_request	*io = (struct usb_sg_request *) urb->context;
+	unsigned long flags;
 
-	spin_lock (&io->lock);
+	spin_lock_irqsave (&io->lock, flags);
 
 	/* In 2.5 we require hcds' endpoint queues not to progress after fault
 	 * reports, until the completion callback (this!) returns.  That lets
@@ -259,7 +260,7 @@ static void sg_complete (struct urb *urb
 		 * unlink pending urbs so they won't rx/tx bad data.
 		 * careful: unlink can sometimes be synchronous...
 		 */
-		spin_unlock (&io->lock);
+		spin_unlock_irqrestore (&io->lock, flags);
 		for (i = 0, found = 0; i < io->entries; i++) {
 			if (!io->urbs [i] || !io->urbs [i]->dev)
 				continue;
@@ -272,7 +273,7 @@ static void sg_complete (struct urb *urb
 			} else if (urb == io->urbs [i])
 				found = 1;
 		}
-		spin_lock (&io->lock);
+		spin_lock_irqsave (&io->lock, flags);
 	}
 	urb->dev = NULL;
 
@@ -282,7 +283,7 @@ static void sg_complete (struct urb *urb
 	if (!io->count)
 		complete (&io->complete);
 
-	spin_unlock (&io->lock);
+	spin_unlock_irqrestore (&io->lock, flags);
 }
 
 

