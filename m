Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbTCUAdM>; Thu, 20 Mar 2003 19:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbTCUAdM>; Thu, 20 Mar 2003 19:33:12 -0500
Received: from lsanca2-ar27-4-46-143-089.lsanca2.dsl-verizon.net ([4.46.143.89]:31617
	"EHLO BL4ST") by vger.kernel.org with ESMTP id <S263374AbTCUAdL>;
	Thu, 20 Mar 2003 19:33:11 -0500
Date: Thu, 20 Mar 2003 16:44:09 -0800
From: Eric Wong <eric@yhbt.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.5.64-bk10-C4
Message-ID: <20030321004409.GA16206@bl4st.yhbt.net>
References: <Pine.LNX.4.44.0303161213200.4930-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303161213200.4930-100000@localhost.localdomain>
Organization: Tire Smokers Anonymous
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> 
> the attached patch fixes a fundamental (and long-standing) bug in the
> sleep-average estimator which is the root cause of the "contest
> process_load" problems reported by Mike Galbraith and Andrew Morton, and
> which problem is addressed by Mike's patch.

> --- linux/kernel/sched.c.orig	
> +++ linux/kernel/sched.c	
> @@ -342,10 +342,10 @@ static inline void __activate_task(task_
>   */
>  static inline int activate_task(task_t *p, runqueue_t *rq)
>  {
> -	unsigned long sleep_time = jiffies - p->last_run;
> +	long sleep_time = jiffies - p->last_run - 1;
>  	int requeue_waker = 0;
>  
> -	if (sleep_time) {
> +	if (sleep_time > 0) {
>  		int sleep_avg;
>  
>  		/*
> 

Would this be an equivalent fix for 2.4.20-ck4?

--- kernel/sched.c	2003-03-20 16:33:07.000000000 -0800
+++ kernel/sched.c.orig	2003-03-20 16:38:51.000000000 -0800
@@ -307,10 +286,10 @@
 
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	long sleep_time = jiffies - p->sleep_timestamp - 1;
+	unsigned long sleep_time = jiffies - p->sleep_timestamp;
 	prio_array_t *array = rq->active;
 
-	if (!rt_task(p) && (sleep_time > 0)) {
+	if (!rt_task(p) && sleep_time) {
 	/*
 		 * This code gives a bonus to interactive tasks. We update
 		 * an 'average sleep time' value here, based on

-- 
Eric Wong
