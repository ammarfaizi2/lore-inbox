Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284299AbRLEMXB>; Wed, 5 Dec 2001 07:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284301AbRLEMWv>; Wed, 5 Dec 2001 07:22:51 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:45266 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S284299AbRLEMWi>; Wed, 5 Dec 2001 07:22:38 -0500
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH] task_struct + kernel stack colouring ...
In-Reply-To: <Pine.LNX.4.40.0112031248260.1381-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0112031248260.1381-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011205212200H.yamamura@flab.fujitsu.co.jp>
Date: Wed, 05 Dec 2001 21:22:00 +0900
From: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Your patch achieved very good performance in our benchmark test, but
I would like to say the following two points about your implementation
for kernel stack colouring.

 1. Your patch could implement coloured kernel stack, but not
    reduce cache line conflicts.
 2. I couldn't see the performance difference whether stack colouring
    is done or not.

[1] get_stack_jitter() in arch/i386/kernel/process.c selects 3 bits
from the cache line index bits. So, cache conflicts still occurs at
shifted line.

Suppose the cache profile is 256KB 4-way, the address distance between
the data on a some block and the data on the other block on the same
set is multiple of 64KB. This means, the lower 16 bits of such
addresses are always same.
  The patch uses 3 bits, from bit position 13 to 15, the data of set
has always the same colour as describe above. From the viewpoint of
cache miss reduction this colouring has no effect.

The patch which I have posted before uses 3bits, from bit
position 18 to 20 (1MB 4-way L2-cache) for task_structs colouring.

I suggest you the following two ways for stack colouring.

(a) Using upper bits than the cache index bits.(ex. On 256KB L2-cache
    system, STACK_SHIFT_BITS should be 16(11 index bits + 5 offset
    bits).

(b) Using modulo operation for colouring.

in get_stack_jitter() (arch/i386/kernel/process.c)
+#define NUM_COLOUR 9  /* the number of colouring (an odd number) */
static inline unsigned long get_stack_jitter(struct task_struct *p)
{
-	return ((TSK_TO_KSTACK(p) >> STACK_SHIFT_BITS) & STACK_COLOUR_MASK) << L1_CACHE_SHIFT;
+	return ((TSK_TO_KSTACK(p) >> STACK_SHIFT_BITS) % NUM_COLOUR) << L1_CACHE_SHIFT;
}

[2] I measured the effects of your patch on 4-way PIII-Xeon with 1MB
L2-Cache systems using web-bench (apache 1.3.19), and also measured
the performance of the modified version(*), which uses 3 bits, from
bit position 16 to 18 to avoid cache conflicts.

[Benchmarking Result] request processing performance improvement,
                      compared to the original kernel(2.5.0)>
  2.5.0 + Davide's Patch  ...  +11.8%up
  2.5.0 + Davide's Patch  ...  +11.8%up
           (STACK_COLOUR_BITS = 0) 
  2.5.0 + Davide's Patch* ...  +11.9%up
           (alternate version with [1](a))

Considering these result, the effects of stack colouring is very
slightly(+0.1%). This patch's major effects is task_struct colouring,
and we had no performance gains by the stack colouring at least in our
experimentation.

-----
Computer Systems Laboratories, Fujitsu Labs.
Shuji YAMAMURA (yamamura@flab.fujitsu.co.jp)
