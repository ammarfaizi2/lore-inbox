Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263162AbTCSVUG>; Wed, 19 Mar 2003 16:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263164AbTCSVUG>; Wed, 19 Mar 2003 16:20:06 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:52467 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263162AbTCSVUD>;
	Wed, 19 Mar 2003 16:20:03 -0500
Message-ID: <3E78E16E.7090602@mvista.com>
Date: Wed, 19 Mar 2003 13:30:22 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
References: <Pine.LNX.4.33.0303191030540.346-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0303191030540.346-100000@gans.physik3.uni-rostock.de>
Content-Type: multipart/mixed;
 boundary="------------030508040305070207050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------030508040305070207050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I found a problem with the last version.  The attached is for 
2.5.65-1.1171 (i.e. after the other post 2.5.65 changes).  The bug is 
fixed, and the code even simpler here.

The problem in the prior patch was that cascade should return:
(index +1) &... not  index &...

Here I changed the call to cascade() to expect "index" back so it 
checks for 0 instead of 1.  Nice and simple.

-g

Tim Schmielau wrote:
> On Wed, 19 Mar 2003, george anzinger wrote:
> 
> 
>>In this case, the simple fix is to bump the
>>base->timer_jiffies at the beginning of the loop rather than the end.
>>   This would cause the new timer to be put in the next jiffie instead
>>of the current one AND it is free!
> 
> 
> Yes, doing it this way looks correct to me.
> 
> 
>>>No, with the current implementation we need
>>> #define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS) +1) &
>>> TVN_MASK
>>>although I'd like to see that cleaned up.
>>
>>I tried with the +1 and boot hangs trying to set up networking.  I
>>think the difference is that the init code is trying to set things up
>>the way they would look AFTER cascade executes and this is doing it
>>BEFORE the cascade call.
> 
> 
> With the above change, it should be correct without the +1
> 
> 
>>>Why 'jiffies -1'? This will just be made up for in the first
>>>timer interrupt, where timer_jiffies will get incremented twice.
>>
>>Again, I removed the -1 in the attached.
> 
> 
> If you really want to be conservative, we'd better start with
> INITIAL_JIFFIES. Should be the same anyways. But if not, we might lose a
> timer scheduled for INITIAL_JIFFIES (not that I think it's possible to
> insert one before timer initialisation in the first place :-)
> or even a timer cascade.
> 
> 
>>>Did you bother to test the patch? It doesn't even boot for me, and I don't
>>>see how it is supposed to.
>>>I'll look into it more closely in the evening. Have to go to work now.
>>
>>The old one ran on 2.5.64 but not 2.5.65 ???  I found and fixed a bug
>>(index needs to be caculated INSIDE the while loop) that seems to have
>>been the cause.
> 
> 
> Ok will test in the evening.
> 
> Tim
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------030508040305070207050000
Content-Type: text/plain;
 name="hrtimers-run-2.5.65-1.1171.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-run-2.5.65-1.1171.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.65-1.1171-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.65-1.1171-kb/kernel/timer.c	2003-03-19 12:32:28.000000000 -0800
+++ linux/kernel/timer.c	2003-03-19 13:08:24.000000000 -0800
@@ -44,12 +44,10 @@
 #define TVR_MASK (TVR_SIZE - 1)
 
 typedef struct tvec_s {
-	int index;
 	struct list_head vec[TVN_SIZE];
 } tvec_t;
 
 typedef struct tvec_root_s {
-	int index;
 	struct list_head vec[TVR_SIZE];
 } tvec_root_t;
 
@@ -134,7 +132,7 @@
 		 * Can happen if you add a timer with expires == jiffies,
 		 * or you set a timer to go off in the past
 		 */
-		vec = base->tv1.vec + base->tv1.index;
+		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
 	} else if (idx <= 0xffffffffUL) {
 		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
@@ -368,12 +366,12 @@
 #endif
 
 
-static int cascade(tvec_base_t *base, tvec_t *tv)
+static int cascade(tvec_base_t *base, tvec_t *tv, int index)
 {
 	/* cascade all the timers from tv up one level */
 	struct list_head *head, *curr;
 
-	head = tv->vec + tv->index;
+	head = tv->vec + index;
 	curr = head->next;
 	/*
 	 * We are removing _all_ timers from the list, so we don't  have to
@@ -389,7 +387,7 @@
 	}
 	INIT_LIST_HEAD(head);
 
-	return tv->index = (tv->index + 1) & TVN_MASK;
+	return index;
 }
 
 /***
@@ -399,6 +397,8 @@
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
+#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+
 static inline void __run_timers(tvec_base_t *base)
 {
 	struct timer_list *timer;
@@ -407,18 +407,19 @@
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		LIST_HEAD(deferred_timers);
 		struct list_head *head;
-
+ 		int index = base->timer_jiffies & TVR_MASK;
+ 
 		/*
 		 * Cascade timers:
 		 */
-		if (!base->tv1.index &&
-			(cascade(base, &base->tv2) == 1) &&
-				(cascade(base, &base->tv3) == 1) &&
-					cascade(base, &base->tv4) == 1)
-			cascade(base, &base->tv5);
+		if (!index &&
+			(! cascade(base, &base->tv2, INDEX(0))) &&
+				(! cascade(base, &base->tv3, INDEX(1))) &&
+					! cascade(base, &base->tv4, INDEX(2)))
+			cascade(base, &base->tv5, INDEX(3));
 		base->run_timer_list_running = &deferred_timers;
 repeat:
-		head = base->tv1.vec + base->tv1.index;
+		head = base->tv1.vec + index;
 		if (!list_empty(head)) {
 			void (*fn)(unsigned long);
 			unsigned long data;
@@ -437,7 +438,6 @@
 		}
 		base->run_timer_list_running = NULL;
 		++base->timer_jiffies; 
-		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 		while (!list_empty(&deferred_timers)) {
 			timer = list_entry(deferred_timers.prev,
 						struct timer_list, entry);
@@ -1198,12 +1198,7 @@
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
-	base->timer_jiffies = INITIAL_JIFFIES;
-	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
-	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
-	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
-	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
-	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
+	base->timer_jiffies = jiffies;
 }
 	
 static int __devinit timer_cpu_notify(struct notifier_block *self, 

--------------030508040305070207050000--

