Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262952AbTCSJSZ>; Wed, 19 Mar 2003 04:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262953AbTCSJSZ>; Wed, 19 Mar 2003 04:18:25 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:3829 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262952AbTCSJSV>;
	Wed, 19 Mar 2003 04:18:21 -0500
Message-ID: <3E78384A.6040406@mvista.com>
Date: Wed, 19 Mar 2003 01:28:42 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
References: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>
Content-Type: multipart/mixed;
 boundary="------------020000020701020809090405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020000020701020809090405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is for 2.5.65.  As of this moment, the bk patch has 
not been posted to the snapshots directory.  I will wait for that to 
update.

For what its worth, can someone explain how the add_timer call from 
run_timers was causing a problem.  The code looks right to me, unless 
the caller is so nasty as to continue to do the same thing (which 
would loop forever).  In this case, the simple fix is to bump the 
base->timer_jiffies at the beginning of the loop rather than the end. 
   This would cause the new timer to be put in the next jiffie instead 
of the current one AND it is free!

-g



Tim Schmielau wrote:
> 
> On Tue, 18 Mar 2003, Andrew Morton wrote:
> 
> 
>>george anzinger <george@mvista.com> wrote:
>>
>>>Here is a fix for the problem that eliminates the index from the
>>>structure.
> 
> [...]
> 
>>Seems to be a nice change.  I think it would be better to get Tim's fix into
>>Linus's tree and let your rationalisation bake for a while in -mm.
> 
> 
> I'm all for this way. Push my quick'n ugly patch to mainline soon to get
> thinks working again. Have at least one mainline release before changing
> again to start off from something working. Then add George's patch when
> it has matured.
> 
> 
>>There is currently a mysterious timer lockup happening on power4 machines.
>>I'd like to keep these changes well-separated in time so we can get an
>>understanding of what code changes correlate with changed behaviour.
> 
> 
> Can this problem be reproduced with INITIAL_JIFFIES=0? Just to make sure I
> didn't break something more.
> 
> 
> On Tue, 18 Mar 2003, George Anzinger wrote:
> 
> 
>>Here is a fix for the problem that eliminates the index from the
>>structure.  The index ALWAYS depends on the current value of
>>base->timer_jiffies in a rather simple way which is I exploit.  Either
>>patch works, but this seems much simpler...
> 
> [...]
> 
>>@@ -384,22 +382,26 @@
>>  * This function cascades all vectors and executes all expired timer
>>  * vectors.
>>  */
>>+#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) &
> 
> TVN_MASK
> 
> No, with the current implementation we need
>  #define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS) +1) &
>  TVN_MASK
> although I'd like to see that cleaned up.

I tried with the +1 and boot hangs trying to set up networking.  I 
think the difference is that the init code is trying to set things up 
the way they would look AFTER cascade executes and this is doing it 
BEFORE the cascade call.
> 
> 
>>+
>>static inline void __run_timers(tvec_base_t *base)
>> {
>>+	int index = base->timer_jiffies & TVR_MASK;
>> 	spin_lock_irq(&base->lock);
>>+	if(jiffies - base->timer_jiffies > 0)
>> 	while ((long)(jiffies - base->timer_jiffies) >= 0) {
>> 		struct list_head *head, *curr;
>>
> 
> 
> Are the doubled 'if' and 'while' really what you meant?

Remove in the attached patch :)
> 
> 
>>@@ -1181,12 +1182,7 @@
>> 	for (j = 0; j < TVR_SIZE; j++)
>> 		INIT_LIST_HEAD(base->tv1.vec + j);
>>
>>-	base->timer_jiffies = INITIAL_JIFFIES;
>>-	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
>>-	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
>>-	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) &
> 
> TVN_MASK;
> 
>>-	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) &
> 
> TVN_MASK;
> 
>>-	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) &
> 
> TVN_MASK;
> 
>>+	base->timer_jiffies = jiffies -1;
>> }
>>
>> static int __devinit timer_cpu_notify(struct notifier_block *self,
> 
> 
> Why 'jiffies -1'? This will just be made up for in the first
> timer interrupt, where timer_jiffies will get incremented twice.

Again, I removed the -1 in the attached.
> 
> 
> Did you bother to test the patch? It doesn't even boot for me, and I don't
> see how it is supposed to.
> I'll look into it more closely in the evening. Have to go to work now.

The old one ran on 2.5.64 but not 2.5.65 ???  I found and fixed a bug 
(index needs to be caculated INSIDE the while loop) that seems to have 
been the cause.
> 
> Tim


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------020000020701020809090405
Content-Type: text/plain;
 name="hrtimers-runtimer-2.5.65.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-runtimer-2.5.65.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.65-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.65-kb/kernel/timer.c	2003-03-05 15:10:40.000000000 -0800
+++ linux/kernel/timer.c	2003-03-19 01:08:24.000000000 -0800
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
 
@@ -117,7 +115,7 @@
 		 * Can happen if you add a timer with expires == jiffies,
 		 * or you set a timer to go off in the past
 		 */
-		vec = base->tv1.vec + base->tv1.index;
+		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
 	} else if (idx <= 0xffffffffUL) {
 		int i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
@@ -351,12 +349,12 @@
 #endif
 
 
-static int cascade(tvec_base_t *base, tvec_t *tv)
+static int cascade(tvec_base_t *base, tvec_t *tv, int index)
 {
 	/* cascade all the timers from tv up one level */
 	struct list_head *head, *curr, *next;
 
-	head = tv->vec + tv->index;
+	head = tv->vec + index;
 	curr = head->next;
 	/*
 	 * We are removing _all_ timers from the list, so we don't  have to
@@ -374,7 +372,7 @@
 	}
 	INIT_LIST_HEAD(head);
 
-	return tv->index = (tv->index + 1) & TVN_MASK;
+	return index  & TVN_MASK;
 }
 
 /***
@@ -384,22 +382,25 @@
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
+#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+
 static inline void __run_timers(tvec_base_t *base)
 {
 	spin_lock_irq(&base->lock);
 	while ((long)(jiffies - base->timer_jiffies) >= 0) {
 		struct list_head *head, *curr;
+		int index = base->timer_jiffies & TVR_MASK;
 
 		/*
 		 * Cascade timers:
 		 */
-		if (!base->tv1.index &&
-			(cascade(base, &base->tv2) == 1) &&
-				(cascade(base, &base->tv3) == 1) &&
-					cascade(base, &base->tv4) == 1)
-			cascade(base, &base->tv5);
+		if (!index &&
+			(cascade(base, &base->tv2, INDEX(0)) == 1) &&
+				(cascade(base, &base->tv3, INDEX(1)) == 1) &&
+					cascade(base, &base->tv4, INDEX(2)) == 1)
+			cascade(base, &base->tv5, INDEX(3));
 repeat:
-		head = base->tv1.vec + base->tv1.index;
+		head = base->tv1.vec + index;
 		curr = head->next;
 		if (curr != head) {
 			void (*fn)(unsigned long);
@@ -424,7 +425,6 @@
 			goto repeat;
 		}
 		++base->timer_jiffies; 
-		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
 #if CONFIG_SMP
 	base->running_timer = NULL;
@@ -1181,12 +1181,7 @@
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

--------------020000020701020809090405--

