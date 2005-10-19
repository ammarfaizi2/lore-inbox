Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVJSKuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVJSKuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 06:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVJSKuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 06:50:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:10717 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964787AbVJSKuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 06:50:01 -0400
Date: Wed, 19 Oct 2005 12:49:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: kernel/timer.c design (was: Re: ktimers subsystem)
Message-ID: <20051019104938.GA30185@elte.hu>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com> <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu> <Pine.LNX.4.61.0510172227010.1386@scrub.home> <20051018084655.GA28933@elte.hu> <Pine.LNX.4.61.0510190311140.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510190311140.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roman Zippel <zippel@linux-m68k.org> wrote:

> Whether the timer event is delivered or not is completely unimportant, 
> as at some point the event has to be removed anyway, so that 
> optimizing a timer for (non)delivery is complete nonsense.

completely wrong! To explain this, let me first give you an introduction 
to the design goals and implementation/optimization details of the 
upstream kernel/timer.c code:

The current design has remained largely unchanged since Finn Arne 
Gangstad implemented timer wheels in 1997.

The code implements 'struct timer_list' objects, which can be 'added'
via add_timer() to 'expire' in N jiffies, and can be 'removed' via
del_timer() before expiry. If timers are not removed before expiry then
they will expire, at which point the kernel has to call
timer->fn(timer->data). Time has a granularity of 1/HZ and timeouts are
32 bits.

[ sidenote: there are other details, like timer modification and other
  API variants, SMP scalability and other issues - in that sense this
  writeup is simplified, but the essence of the algorithms is still the
  same. ]

since timers can be added in arbitrary time order (a timer that will
expire sooner can be added after a timer has been added that will expire
later, etc.), the kernel has to have timers sorted when they expire.
Note: there is no requirement to sort timers _before_ expiry!

the initial Linux timer implementation did not (have to) bother about 
the 'millions of timers' workloads yet, so it went for the simplest 
model: it has put all timers into a doubly-linked list, and sorted 
timers at insertion time, which made addition O(N). It also had an O(N) 
removal function, only expiry was O(1).

[ the name 'struct timer_list' originates from this linked-list model, 
  and this name has survived 15 years. The reason for the O(N) removal 
  overhead of the original implementation was that it maintained a 'next 
  timer will expire in N jiffies' value for every timer on the list, 
  which the kernel could have used to implement dynamic timer ticks. We 
  never ended up using that particular aspect of the implementation, and 
  future timer implementations removed that property altogether. ]

one could implement a add:O(N)/del:O(1)/exp:O(1) algorithm for sorted 
linked lists, the original implementation was suboptimal in doing a O(N) 
del_timer().

one could also implement a add:O(1)/del:O(1)/exp:O(N) algorithm via an 
unsorted linked list. In any case, if there's only a single list then 
either insertion or expiry has to carry the O(N) linear sorting 
overhead.

another canonical 'computer science' way of dealing with timers is to 
put them into a binary tree that sorts by expiry-time: this means that 
at add_timer() time we have to insert the timer into the binary tree 
(O(log(N)) overhead), removal and expiry is O(1).

the fastest theoretical timer algorithm is to have a linear array of 
lists [timer buckets] for every future jiffy (and a running index to 
represent the current jiffy): then adding a timer is a simple add_list() 
for the array entry indexed by the target timeout. Removing a timer is a 
simple list_del(), and expiring the timer is a matter of advancing the 
'current time' index by one and expiring all (if any) timers that are in 
the next slot. Thus adding, removing and expiring a timer has constant 
O(1) overhead, and the worst-case behavior is constant bounded too.

what makes this algorithm impossible in practice is its huge RAM 
footprint: tens of gigabytes of RAM to represent all ~2^32 jiffies.  
(Some OSs still do this, at the price of restricting either timer 
granularity, or the maximum possible timeout)

it can be proven that under our assumptions this 'linear array of time' 
approach is the best fully O(1) algorithm [with constant worst-case 
behavior as well], so whatever other solution we choose to significantly 
reduce the RAM footprint, it wont be fully O(1).

we've seen two practical approaches so far: the 'historical Linux 
implementation' which was add:O(N)/del:O(N)/exp:O(1), and the 'timer 
tree' solution which is add:O(log(N))/del:O(1)/exp:O(1).

but the current Linux kernel uses a third algorithm: the timer wheels.  
This is a variant of the simple 'array of future jiffies' model, but 
instead of representing every future jiffy in a bucket, it categorizes 
future jiffies into a 'logarithmic array of arrays' where the arrays 
represent buckets with larger and larger 'scope/granularity': the 
further a jiffy is in the future, the more jiffies belong to the same 
single bucket.

In practice it's done by categorizing all future jiffies into 5 groups:

1..256, 257..16384, 16385..1048576, 1048577..67108864, 67108865..4294967295

the first category consists of 256 buckets (each bucket representing a 
single jiffy), the second category consists of 64 buckets equally 
divided (each bucket represents 256 subsequent jiffies), the third 
category consists of 64 buckets too (each bucket representing 256*64 == 
16384 jiffies), the fourth category consists of 64 buckets too (each 
bucket representing 256*64*64 == 1048576 jiffies), the fifth category 
consists of 64 buckets too (each bucket representing 67108864 jiffies).

the buckets of each category are put into a per-category fixed-size 
array, called the "timer vector" - named tv1, tv2, tv3, tv4 and tv5.

as you can see, we only used 256+64+64+64+64 == 512 buckets, but we've 
managed to map all 4294967295 future jiffies to these buckets! In other 
words: we've split up the 32 bits of 'timeout' value into 8+6+6+6+6 
bits.

[ you might ask: why dont we use an even number of buckets such as 
  8+8+8+8, which would simplify the code? The reason is mostly RAM 
  footprint optimizations: an 8+8+8+8 splitup gives a total of 
  256+256+256+256 == 1024 buckets, which was considered a bit too high 
  back when this code was designed. In fact, in recent 2.6 kernels, if 
  CONFIG_BASE_SMALL is specified then we use a 6+4+4+4+4 splitup and 
  round down the remaining 10 bits, which gives an embedded-friendly RAM 
  footprint of 128 buckets. The 'splitup' is under constant revision and 
  we might switch to the simpler (and slightly faster) 8+8+8+8 model in 
  the future, for servers. ]

how do we insert timers? In add_timer() we can calculate their "target 
category" in constant overhead (with at most 5 comparisons), and put the 
timer into that bucket. Note: unless it's in the first category, timers 
with different timeout values can end up in the same bucket. E.g. timers 
expiring at jiffy 260 and 265 will be both put into the first bucket of 
category 2. This means that timers in these buckets are 'partially 
sorted': they are only sorted in their highest bits, initially. So 
add_timer() is O(1) overhead.

removal is simple: we remove the timer from the bucket, which is a 
list_del(), so O(1) overhead too.

we knew that there's no free lunch, right? The main complication is how 
we do expiry. The first 256 jiffies are not a problem, because they are 
represented by the first array of buckets, so the expiry code only has 
to check whether there are any timers to be expired in that bucket.  
Expiry overhead is O(1) for these steps. But at jiffy 257 we do 
something special: the expiry code 'cascades' the first bucket of the 
second array 'down into' the first 256 buckets. It does it the hard way: 
walks the list of timers in that bucket (if any), and removes them from 
that list and inserts them into one of the first 256 buckets (depending 
on what the timeout value of that timer is). Then the expiry code goes 
back to bucket 1, and expires the timers there (if any). The expiry code 
keeps a persistent running index for every category, and if that index 
overflows back to 1, it increments the next category's index by one and 
'cascades down' timers from that bucket into the previous category.

in other words: what happens is that we sort timers "piecemail wise", 
first we order by the highest bits of their timeout value, then we sort 
by the lower bits too - in the end they are fully sorted. If all timers 
expire and are never removed then still we have won relative to the 
fully-sorted-list approach: all timers will end up fully sorted, and 
average per-timer expiry overhead is still O(1)! But expiry worst-case 
is not bounded, it is O(N).

One cost is the burstiness of processing: a single step of cascading can 
take many timers to be processed (if they happen to be in that same 
bucket), and no timers may expire while we do that processing. The 
worst-case expiry behavior is O(N). (The average cost is still O(1), 
because we process every timer at most 5 times.) Another cost is that we 
touch (and dirty) the timers again and again during their lifetime, 
bringing them into cache multiple times.

But there's a hidden win as well from this approach: if a timer is 
removed before it expires, we've saved the remaining cascading steps!  
This happens surprisingly often: on a busy networked server, the 
majority of the timers never expire, and are removed before they have to 
be cascaded even once.

in other words: we 'lazy sort' timers, and we push most of the sorting 
overhead as much into the future as possible, in the hope of the problem 
of having to sort them going away, because they get removed before they 
expire. (and even if we wanted, we couldnt sort earlier in this model, 
due to the RAM footprint limits)

with all these details in mind, lets go back to Roman's assertion:

> Whether the timer event is delivered or not is completely unimportant, 
> as at some point the event has to be removed anyway, so that 
> optimizing a timer for (non)delivery is complete nonsense.

it is very much crutial whether a timer event is delivered. Think about 
the 'millions of network timers' case: most of them are removed before 
cascaded even once! By removing early we might not have to propagate and 
sort the timer in any way: it is added to a bucket and soon removed from 
the same bucket.

	Ingo
