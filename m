Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbTCSWPI>; Wed, 19 Mar 2003 17:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263054AbTCSWPI>; Wed, 19 Mar 2003 17:15:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:3311 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262632AbTCSWPF>;
	Wed, 19 Mar 2003 17:15:05 -0500
Message-ID: <3E78EE53.9090604@mvista.com>
Date: Wed, 19 Mar 2003 14:25:23 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [PATCH] Remove defered timer list in favor of moving the list
 time update
References: <Pine.LNX.4.33.0303191030540.346-100000@gans.physik3.uni-rostock.de>	<3E78E16E.7090602@mvista.com> <20030319155258.64cbc43d.akpm@digeo.com>
In-Reply-To: <20030319155258.64cbc43d.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------040601010101030600050109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040601010101030600050109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>I found a problem with the last version.  The attached is for 
>>2.5.65-1.1171 (i.e. after the other post 2.5.65 changes).  The bug is 
>>fixed, and theAndrew Morton wrote:
 > george anzinger <george@mvista.com> wrote:
 >
 >>I found a problem with the last version.  The attached is for
 >>2.5.65-1.1171 (i.e. after the other post 2.5.65 changes).  The bug is
 >>fixed, and the code even simpler here.
 >
 >
 > Thanks, I'll queue that up after Tim's stuff is merged.

And this removes the defered queue in favor of just moving the list 
time update to just prior to the repeat label.  (Apply after my 
"bumps" patch.)

Do I have the right Andrea?
 >
 >

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
  code even simpler here.
> 
> 
> Thanks, I'll queue that up after Tim's stuff is merged.
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------040601010101030600050109
Content-Type: text/plain;
 name="hrtimers-run-def.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-run-def.patch"

--- linux-2.5.65-1.1171-run/kernel/timer.cX	2003-03-19 13:08:24.000000000 -0800
+++ linux/kernel/timer.c	2003-03-19 14:16:53.000000000 -0800
@@ -55,7 +55,6 @@
 	spinlock_t lock;
 	unsigned long timer_jiffies;
 	struct timer_list *running_timer;
-	struct list_head *run_timer_list_running;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -100,12 +99,6 @@
 		check_timer_failed(timer);
 }
 
-/*
- * If a timer handler re-adds the timer with expires == jiffies, the timer
- * running code can lock up.  So here we detect that situation and park the
- * timer onto base->run_timer_list_running.  It will be added to the main timer
- * structures later, by __run_timers().
- */
 
 static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
 {
@@ -113,9 +106,7 @@
 	unsigned long idx = expires - base->timer_jiffies;
 	struct list_head *vec;
 
-	if (base->run_timer_list_running) {
-		vec = base->run_timer_list_running;
-	} else if (idx < TVR_SIZE) {
+	if (idx < TVR_SIZE) {
 		int i = expires & TVR_MASK;
 		vec = base->tv1.vec + i;
 	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
@@ -405,7 +396,6 @@
 
 	spin_lock_irq(&base->lock);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
-		LIST_HEAD(deferred_timers);
 		struct list_head *head;
  		int index = base->timer_jiffies & TVR_MASK;
  
@@ -417,7 +407,7 @@
 				(! cascade(base, &base->tv3, INDEX(1))) &&
 					! cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		base->run_timer_list_running = &deferred_timers;
+		++base->timer_jiffies; 
 repeat:
 		head = base->tv1.vec + index;
 		if (!list_empty(head)) {
@@ -436,14 +426,6 @@
 			spin_lock_irq(&base->lock);
 			goto repeat;
 		}
-		base->run_timer_list_running = NULL;
-		++base->timer_jiffies; 
-		while (!list_empty(&deferred_timers)) {
-			timer = list_entry(deferred_timers.prev,
-						struct timer_list, entry);
-			list_del(&timer->entry);
-			internal_add_timer(base, timer);
-		}
 	}
 	set_running_timer(base, NULL);
 	spin_unlock_irq(&base->lock);


--------------040601010101030600050109--

