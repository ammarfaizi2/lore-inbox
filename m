Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUCKN41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUCKN40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:56:26 -0500
Received: from dp.samba.org ([66.70.73.150]:47338 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261296AbUCKN4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:56:17 -0500
Date: Fri, 12 Mar 2004 00:52:51 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311135251.GC16751@krispykreme>
References: <20040310233140.3ce99610.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> - The CPU scheduler changes in -mm (sched-domains) have been hanging about
>   for too long.  I had been hoping that the people who care about SMT and
>   NUMA performance would have some results by now but all seems to be silent.
> 
>   I do not wish to merge these up until the big-iron guys can say that they
>   suit their requirements, with a reasonable expectation that we will not
>   need to churn this code later in the 2.6 series.
> 
>   So.  If you have been testing, please speak up.  If you have not been
>   testing, please do so.

Some quick fixes...

Anton

--

Remove unused this_rq

diff -puN kernel/sched.c~sched-fix kernel/sched.c
--- gr23_work/kernel/sched.c~sched-fix	2004-03-03 07:43:34.242850841 -0600
+++ gr23_work-anton/kernel/sched.c	2004-03-03 07:43:34.253849097 -0600
@@ -699,7 +699,6 @@ static int try_to_wake_up(task_t * p, un
 	unsigned long load, this_load;
 	int new_cpu;
 	struct sched_domain *sd;
-	runqueue_t *this_rq;
 #endif
 
 	rq = task_rq_lock(p, &flags);
@@ -730,7 +729,6 @@ static int try_to_wake_up(task_t * p, un
 		goto repeat_lock_task;
 	}
 
-	this_rq = this_rq();
 	now = sched_clock();
 	sd = cpu_sched_domain(this_cpu);
 
--

remove unused load and remove some warnings (due to type checking in
min/max macros)

diff -puN kernel/sched.c~sched-morefixes kernel/sched.c
--- gr25_work/kernel/sched.c~sched-morefixes	2004-03-11 06:42:13.895877892 -0600
+++ gr25_work-anton/kernel/sched.c	2004-03-11 06:42:41.930693672 -0600
@@ -1436,7 +1436,6 @@ nextgroup:
 
 	if (*imbalance <= SCHED_LOAD_SCALE/2) {
 		unsigned long pwr_now = 0, pwr_move = 0;
-		unsigned long load;
 		unsigned long tmp;
 
 		/*
diff -puN include/linux/sched.h~sched-morefixes include/linux/sched.h
--- gr25_work/include/linux/sched.h~sched-morefixes	2004-03-11 06:47:01.892015906 -0600
+++ gr25_work-anton/include/linux/sched.h	2004-03-11 06:47:30.533869203 -0600
@@ -531,7 +531,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 
 #ifdef CONFIG_SMP
 #define SCHED_LOAD_SHIFT 7	/* increase resolution of load calculations */
-#define SCHED_LOAD_SCALE (1 << SCHED_LOAD_SHIFT)
+#define SCHED_LOAD_SCALE (1UL << SCHED_LOAD_SHIFT)
 
 #define SD_FLAG_NEWIDLE		1	/* Balance when about to become idle */
 #define SD_FLAG_EXEC		2	/* Balance on exec */

_
