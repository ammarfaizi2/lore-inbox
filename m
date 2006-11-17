Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161829AbWKQHfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161829AbWKQHfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162414AbWKQHfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:35:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56962 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161829AbWKQHfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:35:18 -0500
Date: Fri, 17 Nov 2006 07:59:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -rt patch scheduler w/ BKL
Message-ID: <20061117065921.GA12502@elte.hu>
References: <1163557533.9173.121.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163557533.9173.121.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2154]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> The current -rt patch changes the scheduler so that the BKL is no 
> longer properly reacquired. If SPINLOCK_BKL is selected it's possible 
> for reacquire_kernel_lock() to return without acquiring the BKL, in 
> vanilla linux the return value of that function is evaluated, but in 
> -rt that code is removed. The result is that if __schedule gets 
> recalled on TIF_NEED_RESCHED the BKL will be released unconditionally 
> ..

The patch below should fix this. This trylock-the-BKL code predates the 
semaphore-based CONFIG_PREEMPT_BKL code - and it's alot better to use 
the semaphore than to do a clever trylock loop.

	Ingo

Index: linux/lib/kernel_lock.c
===================================================================
--- linux.orig/lib/kernel_lock.c
+++ linux/lib/kernel_lock.c
@@ -128,11 +128,7 @@ static  __cacheline_aligned_in_smp DEFIN
 int __lockfunc __reacquire_kernel_lock(void)
 {
 	local_irq_enable();
-	while (!_raw_spin_trylock(&kernel_flag)) {
-		if (test_thread_flag(TIF_NEED_RESCHED))
-			return -EAGAIN;
-		cpu_relax();
-	}
+	_raw_spin_lock(&kernel_flag);
 	local_irq_disable();
 	preempt_disable();
 	return 0;
