Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUGUJuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUGUJuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 05:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUGUJuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 05:50:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64478 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264997AbUGUJuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 05:50:18 -0400
Date: Wed, 21 Jul 2004 10:22:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721082218.GA19013@elte.hu>
References: <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090389791.901.31.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I can also add that La Monte H. P. Yarroll's patch to daemonize
> softirqs seems to provide major improvements in latency (does not help
> this problem of course).  There has been at least one other patch
> posted to LKML that that does the same thing.  Will this feature be in
> the kernel anytime soon?

we already 'daemonize' softirqs in the stock kernel if the load is high
enough. (this is what ksoftirqd does) So the only question is a tunable
to make this deferring of softirq load mandatory. Yarroll's patch is
quite complex, i dont think that is necessary. It also has at least one
conceptual problem, the NOP-ing of local_bh_disable/enable in case of
CONFIG_SOFTIRQ_THREADS is clearly wrong. Yarroll?

I've added a very simple solution to daemonize softirqs similar to
Yarroll's patch to the -H5 version of voluntary-preempt:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-H5

the 'level' of preemption is controlled via the value of
voluntary_preempt - a level of 2 (default) means that softirq-deferring
is done too. A level of 1 means only the extra preemption points are
activated, level 0 means the vanilla scheduling and softirq behavior.

below i've also attached a softirq.c patch against 2.6.8-rc2 that does
unconditional deferring. (this patch is of course not intended to be
merged upstream as-is, since normally we want to process softirqs right
after the irq context.)

	Ingo

--- linux/kernel/softirq.c.orig	
+++ linux/kernel/softirq.c	
@@ -70,7 +70,7 @@ static inline void wakeup_softirqd(void)
  */
 #define MAX_SOFTIRQ_RESTART 10
 
-asmlinkage void __do_softirq(void)
+asmlinkage void ___do_softirq(void)
 {
 	struct softirq_action *h;
 	__u32 pending;
@@ -106,6 +106,23 @@ restart:
 	__local_bh_enable();
 }
 
+asmlinkage void __do_softirq(void)
+{
+	/*
+	 * 'preempt harder'. Push all softirq processing off to ksoftirqd.
+	 */
+	if (local_softirq_pending())
+		wakeup_softirqd();
+}
+
+asmlinkage void _do_softirq(void)
+{
+	local_irq_disable();
+	___do_softirq();
+	local_irq_enable();
+}
+
+
 #ifndef __ARCH_HAS_DO_SOFTIRQ
 
 asmlinkage void do_softirq(void)
@@ -340,7 +363,7 @@ static int ksoftirqd(void * __bind_cpu)
 			preempt_disable();
 			if (cpu_is_offline((long)__bind_cpu))
 				goto wait_to_die;
-			do_softirq();
+			_do_softirq();
 			preempt_enable();
 			cond_resched();
 		}
