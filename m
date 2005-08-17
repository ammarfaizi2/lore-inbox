Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVHQGbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVHQGbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVHQGbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:31:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65153 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1750917AbVHQGbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:31:33 -0400
Date: Wed, 17 Aug 2005 08:31:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ryan Brown <some.nzguy@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Message-ID: <20050817063138.GA5689@elte.hu>
References: <20050816161226.GA2826@elte.hu> <Pine.LNX.4.44L0.0508161247030.18302-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0508161247030.18302-100000@iolanthe.rowland.org>
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

> P.S.: Another routine worth examining is async_completed() in 
> drivers/usb/core/devio.c.

i've added the patch below to be on the safe side.

	Ingo

Index: linux/drivers/usb/core/devio.c
===================================================================
--- linux.orig/drivers/usb/core/devio.c
+++ linux/drivers/usb/core/devio.c
@@ -274,10 +274,11 @@ static void async_completed(struct urb *
         struct async *as = (struct async *)urb->context;
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
