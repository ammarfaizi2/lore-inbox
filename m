Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbTCSIYr>; Wed, 19 Mar 2003 03:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbTCSIYr>; Wed, 19 Mar 2003 03:24:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12017 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262945AbTCSIYp>;
	Wed, 19 Mar 2003 03:24:45 -0500
Message-ID: <3E782BC7.2020009@mvista.com>
Date: Wed, 19 Mar 2003 00:35:19 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
References: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
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

As near as I can tell this is not true if done here.  I could be 
wrong, but I think the tests will fail if the "1" is added.  I will 
try it though, just to be sure.
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

Darn, you are right. The if is left over debug code.  Teach me to do 
ifs with out {}.
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

I wanted to be conservative.  Jiffies should work, but as you say it 
will be made up.  I did not want ANY possibity of getting a timer in 
the list ahead of where the list was.
> 
> 
> Did you bother to test the patch? It doesn't even boot for me, and I don't
> see how it is supposed to.

I did, and it booted and ran the clock_nanosleep test (actually a more 
rigerous verson of same).

> I'll look into it more closely in the evening. Have to go to work now.
> 
> Tim
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

