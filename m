Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVLNIlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVLNIlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLNIlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:41:24 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:50092 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932158AbVLNIlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:41:20 -0500
Date: Wed, 14 Dec 2005 09:40:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution patches
Message-ID: <20051214084019.GA18708@elte.hu>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de> <1134507927.18921.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134507927.18921.26.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Thomas and Ingo,
> 
> I found a bug in 2.6.15-rc5-rt1 that was due to a race in the hrtimers 
> code.  This bug is most likely in the vanilla hrtimers code as well.
> 
> I added a HRTIMER_RUNNING state because there's a moment in the 
> run_hrtimer_queues that turns interrupts on and releases the base 
> lock. In this time, a remove_hrtimer can be called while the state is 
> still HRTIMER_PENDING_CALLBACK, but it has been removed off the list.  
> The remove_hrtimer will then try to remove this again.
> 
> Since I couldn't think of which state to use, I created the 
> HRTIMER_RUNNING, and used that instead.
> 
> I have a program (a simple jitter test) that, with out the patch, 
> reliably crashes the 2.6.15-rc5-rt1 on a slow UP machine.  With the 
> patch, it runs solidly, so I know this is the reason for the crash.

hm, in that case it should be base->running that protects against this 
case. Did you run an UP PREEMPT_RT kernel? In that case could you check 
whether the fix below resolves the crash too?

	Ingo

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -118,7 +118,7 @@ static DEFINE_PER_CPU(struct hrtimer_bas
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
  */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(PREEMPT_RT)
 
 #define set_curr_timer(b, t)		do { (b)->curr_timer = (t); } while (0)
 
