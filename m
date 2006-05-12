Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWELL4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWELL4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWELL4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:56:42 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:37590 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751254AbWELL4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:56:41 -0400
Date: Fri, 12 May 2006 13:56:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Hounschell <markh@compro.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
Message-ID: <20060512115614.GA28377@elte.hu>
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com> <20060512055025.GA25824@elte.hu> <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com> <4464740C.8060305@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4464740C.8060305@compro.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Hounschell <markh@compro.net> wrote:

> Steven Rostedt wrote:
> > 
> > On Fri, 12 May 2006, Ingo Molnar wrote:
> > 
> >> ah. This actually uncovered a real bug. We were calling __do_softirq()
> >> with interrupts enabled (and being preemptible) - which is certainly
> >> bad.
> > 
> > Hmm, I wonder if this is also affecting Mark's problem.
> 
> I thought the same thing when I read it??

could you try the patch below?

	Ingo

----

* Steven Rostedt <rostedt@goodmis.org> wrote:

> > one solution would be to forbid disable_irq() from softirq contexts, and
> > to convert the vortex timeout function to a workqueue and use the
> > *_delayed_work() APIs to drive it - and cross fingers there's not many
> > places to fix.
> 
> I prefer the above. Maybe even add a WARN_ON(in_softirq()) in 
> disable_irq.
> 
> But I must admit, I wouldn't know how to make that change without 
> spending more time on it then I have for this.

the simplest fix for now would be to use the _nosync variant in the 
vortex timeout function.

Mark, does this fix the problem?

	Ingo

Index: linux-rt.q/drivers/net/3c59x.c
===================================================================
--- linux-rt.q.orig/drivers/net/3c59x.c
+++ linux-rt.q/drivers/net/3c59x.c
@@ -1897,7 +1897,8 @@ vortex_timer(unsigned long data)
 
 	if (vp->medialock)
 		goto leave_media_alone;
-	disable_irq(dev->irq);
+	/* hack! */
+	disable_irq_nosync(dev->irq);
 	old_window = ioread16(ioaddr + EL3_CMD) >> 13;
 	EL3WINDOW(4);
 	media_status = ioread16(ioaddr + Wn4_Media);
