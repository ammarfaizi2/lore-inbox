Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbTCSB5x>; Tue, 18 Mar 2003 20:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbTCSB5x>; Tue, 18 Mar 2003 20:57:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64239 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262888AbTCSB5t>;
	Tue, 18 Mar 2003 20:57:49 -0500
Message-ID: <3E77D107.30406@mvista.com>
Date: Tue, 18 Mar 2003 18:08:07 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
References: <Pine.LNX.4.33.0303182123510.30255-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0303182123510.30255-100000@gans.physik3.uni-rostock.de>
Content-Type: multipart/mixed;
 boundary="------------030400090006040100070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------030400090006040100070907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Here is a fix for the problem that eliminates the index from the 
structure.  The index ALWAYS depends on the current value of 
base->timer_jiffies in a rather simple way which is I exploit.  Either 
patch works, but this seems much simpler...

-g


Tim Schmielau wrote:
> On Tue, 18 Mar 2003, Tim Schmielau wrote:
> 
> 
>>Please don't yet forward to Linus. After twisting my little brain a bit
>>further, I see that the patch is still wrong if the lowest TVR_BITS of
>>INITIAL_JIFFIES happen to be zero while others are not.
> 
> 
> OK, this one looks ugly but should be correct, even in the case of a
> partial timer cascade on the first timer interrupt:
> 
> 
> --- linux-2.5.65/kernel/timer.c.orig	Tue Mar 18 13:02:39 2003
> +++ linux-2.5.65/kernel/timer.c	Tue Mar 18 13:41:53 2003
> @@ -1182,11 +1182,23 @@
>  		INIT_LIST_HEAD(base->tv1.vec + j);
> 
>  	base->timer_jiffies = INITIAL_JIFFIES;
> -	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
> -	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
> -	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
> -	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
> -	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
> +	/*
> +	 * The tv indices are always larger by one compared to the
> +	 * respective parts of timer_jiffies. If all lower indices are
> +	 * zero at initialisation, this is achieved by an (otherwise
> +	 * unneccessary) invocation of the timer cascade on the first
> +	 * timer interrupt. If not, we need to take it into account
> +	 * here:
> +	 */
> +	j  = (base->tv1.index = INITIAL_JIFFIES & TVR_MASK) !=0;
> +	j |= (base->tv2.index = ((INITIAL_JIFFIES >> TVR_BITS) + j)
> +	                        & TVN_MASK) !=0;
> +	j |= (base->tv3.index = ((INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) + j)
> +	                        & TVN_MASK) !=0;
> +	j |= (base->tv4.index = ((INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) + j)
> +	                        & TVN_MASK) !=0;
> +	      base->tv5.index = ((INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) + j)
> +	                        & TVN_MASK;
>  }
> 
>  static int __devinit timer_cpu_notify(struct notifier_block *self,
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------030400090006040100070907
Content-Type: text/plain;
 name="hrtimers-runtimer-2.5.64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-runtimer-2.5.64.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.64-kb/kernel/timer.c	2003-03-05 15:10:40.000000000 -0800
+++ linux/kernel/timer.c	2003-03-18 17:59:02.000000000 -0800
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
@@ -384,22 +382,26 @@
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
+#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+
 static inline void __run_timers(tvec_base_t *base)
 {
+	int index = base->timer_jiffies & TVR_MASK;
 	spin_lock_irq(&base->lock);
+	if(jiffies - base->timer_jiffies > 0)
 	while ((long)(jiffies - base->timer_jiffies) >= 0) {
 		struct list_head *head, *curr;
 
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
@@ -424,7 +426,6 @@
 			goto repeat;
 		}
 		++base->timer_jiffies; 
-		base->tv1.index = (base->tv1.index + 1) & TVR_MASK;
 	}
 #if CONFIG_SMP
 	base->running_timer = NULL;
@@ -1181,12 +1182,7 @@
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
-	base->timer_jiffies = INITIAL_JIFFIES;
-	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
-	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
-	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
-	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
-	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
+	base->timer_jiffies = jiffies -1;
 }
 	
 static int __devinit timer_cpu_notify(struct notifier_block *self, 

--------------030400090006040100070907--

