Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUHNGih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUHNGih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 02:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUHNGif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 02:38:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31886 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266139AbUHNGiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 02:38:25 -0400
Date: Sat, 14 Aug 2004 08:39:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O7
Message-ID: <20040814063948.GA4355@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092458772.803.64.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092458772.803.64.camel@krustophenia.net>
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

> In some of the traces, like this one:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7#/var/www/2.6.8-rc4-bk3-O7/mount_reiserfs_latency_trace.txt
> 
> there are calls to voluntary_resched.  How is this possible?  Does it
> mean that we called voluntary_resched while holding a spinlock, where
> we needed to call voluntary_preempt_lock(&foo_lock), and thus failed
> to reschedule?

voluntary_resched() was probably called as part of the might_sleep_if()
done in mm/slab.c. If you have CONFIG_DEBUG_SPINLOCK_SLEEP enabled then
the kernel should have complained about 'Debug: sleeping function ...'.

but what i think happened here is that reiserfs still uses
lock_kernel()/unlock_kernel() quite alot (eg. ext3 or xfs doesnt), which
from a preemptability POV is just as much of a critical section as a
spinlock, but processes can sleep (the scheduler auto-releases and
auto-reacquires the big kernel lock).

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -3210,11 +3210,11 @@ __setup("voluntary-preempt=", voluntary_
 
 int __sched voluntary_resched(void)
 {
-	if (kernel_preemption || !voluntary_preemption)
-		return 0;
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
 	__might_sleep(__FILE__, __LINE__);
 #endif
+	if (kernel_preemption || !voluntary_preemption)
+		return 0;
 	/*
 	 * The system_state check is somewhat ugly but we might be
 	 * called during early boot when we are not yet ready to reschedule.
