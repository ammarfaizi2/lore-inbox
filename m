Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284608AbRLETPg>; Wed, 5 Dec 2001 14:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284576AbRLETM7>; Wed, 5 Dec 2001 14:12:59 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:39691 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284592AbRLETMj>; Wed, 5 Dec 2001 14:12:39 -0500
Date: Wed, 5 Dec 2001 11:23:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
cc: lkml <linux-kernel@vger.kernel.org>, <manfred@colorfullife.com>
Subject: Re: [PATCH] task_struct + kernel stack colouring ...
In-Reply-To: <20011205212200H.yamamura@flab.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.40.0112051103100.1644-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Shuji YAMAMURA wrote:

> Hi,
>
> Your patch achieved very good performance in our benchmark test, but
> I would like to say the following two points about your implementation
> for kernel stack colouring.
>
>  1. Your patch could implement coloured kernel stack, but not
>     reduce cache line conflicts.
>  2. I couldn't see the performance difference whether stack colouring
>     is done or not.
>
> [1] get_stack_jitter() in arch/i386/kernel/process.c selects 3 bits
> from the cache line index bits. So, cache conflicts still occurs at
> shifted line.
>
> Suppose the cache profile is 256KB 4-way, the address distance between
> the data on a some block and the data on the other block on the same
> set is multiple of 64KB. This means, the lower 16 bits of such
> addresses are always same.
>   The patch uses 3 bits, from bit position 13 to 15, the data of set
> has always the same colour as describe above. From the viewpoint of
> cache miss reduction this colouring has no effect.
>
> The patch which I have posted before uses 3bits, from bit
> position 18 to 20 (1MB 4-way L2-cache) for task_structs colouring.
>
> I suggest you the following two ways for stack colouring.
>
> (a) Using upper bits than the cache index bits.(ex. On 256KB L2-cache
>     system, STACK_SHIFT_BITS should be 16(11 index bits + 5 offset
>     bits).
>
> (b) Using modulo operation for colouring.
>
> in get_stack_jitter() (arch/i386/kernel/process.c)
> +#define NUM_COLOUR 9  /* the number of colouring (an odd number) */
> static inline unsigned long get_stack_jitter(struct task_struct *p)
> {
> -	return ((TSK_TO_KSTACK(p) >> STACK_SHIFT_BITS) & STACK_COLOUR_MASK) << L1_CACHE_SHIFT;
> +	return ((TSK_TO_KSTACK(p) >> STACK_SHIFT_BITS) % NUM_COLOUR) << L1_CACHE_SHIFT;
> }

Whatever bits you take it's a random move with a limited memory address
space and does not change the picture.
Stack colouring become evident when you have a quite big number of
processes waiting for the same event inside the kernel ( accept, ... )
that means that they're going to walk the same path in their way in/out of
the kernel.
By simplifying the pattern, with the current implementation with your
example 256Kb 4 way associative and 8Kb kernel stack you've ( statistically ):

        W0        W1        W2        W3

64Kb --------  --------  --------  --------
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
sp ->|      |->|      |->|      |->|      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
56Kb ........  ........  ........  ........
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
sp ->|      |->|      |->|      |->|      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
48Kb ........  ........  ........  ........

     !      !  !      !  !      !  !      !

8Kb  ........  ........  ........  ........
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
sp ->|      |->|      |->|      |->|      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
     |      |  |      |  |      |  |      |
0Kb  ........  ........  ........  ........


By adding three bits of colouring you're going to cut the collision of
about 1/8.




- Davide


