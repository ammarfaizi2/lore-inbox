Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129447AbRBFOY0>; Tue, 6 Feb 2001 09:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRBFOYG>; Tue, 6 Feb 2001 09:24:06 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:2192 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129400AbRBFOXz>; Tue, 6 Feb 2001 09:23:55 -0500
Message-ID: <3A800B14.53490EA3@uow.edu.au>
Date: Wed, 07 Feb 2001 01:32:52 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Spencer <markster@linux-support.net>
CC: linux-kernel@vger.kernel.org, jim@lambdatel.com
Subject: Re: Linux interrupt latency
In-Reply-To: <Pine.LNX.4.21.0102052304170.13906-100000@hoochie.linux-support.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Spencer wrote:
> 
> Can anyone suggest what might be causing the problem on non-Intel
> chipsets, particularly what event might be occuring once per second and
> disabling interrupts for a couple of hundred microseconds?  Thanks!

I have a gizmo which will find this for you.

http://www.uow.edu.au/~andrewm/linux/#timepegs

- Grab the 2.4.1-pre10 patch and tpt.
- Apply patch.  Under `Kernel hacking', enable timepegs
  and `Interrupt latency'.  Make sure you enable IO-APIC
  on Uniprocessor. Rebuild kernel. Reboot.
- Run `tpt' to zero all the counters.
- Use the system for a few minutes in a normal manner
- Run `tpt -s | sort -nr +5'

You'll get something like this:

           do_IRQ.in:0 -> softirq.c:71  6059     7.14  18.56     8.45   51237.71
           do_IRQ.in:0 -> do_IRQ.out:0  255     11.60  16.69    13.47    3437.13
                irq.c:476 -> irq.c:481  1       14.31  14.31    14.31      14.31
              exit.c:384 -> exit.c:418  4        5.94  10.53     8.40      33.63
    ll_rw_blk.c:759 -> ll_rw_blk.c:856  3709      .64   8.96     1.01    3754.22
          3c59x.c:1835 -> 3c59x.c:1855  81405    2.53   8.63     2.92  238321.05
                ide.c:513 -> ide.c:522  3709      .52   8.10     1.42    5300.37
                irq.c:523 -> irq.c:542  1        7.14   7.14     7.14       7.14
          signal.c:528 -> signal.c:546  13       1.95   6.10     4.22      55.00
  page_alloc.c:181 -> page_alloc.c:198  4407      .41   5.86      .75    3355.55
            sched.c:541 -> sched.c:596  8238      .35   5.22     1.22   10055.84
          skbuff.c:121 -> skbuff.c:123  206065    .32   5.03      .36   74765.68
          signal.c:602 -> signal.c:604  17       1.28   5.03     2.91      49.63
              dev.c:1127 -> dev.c:1139  43268     .34   4.86      .41   17836.39
            sched.c:713 -> sched.c:748  5497      .31   4.78     1.10    6055.92
         ll_rw_blk.c:377 -> ide.c:1357  78        .93   4.63     3.36     262.83
            timer.c:205 -> timer.c:209  43465     .33   4.61      .43   19044.11
            slab.c:1298 -> slab.c:1322  129153    .32   4.59      .39   51402.35

So the worst interrupt latency path on this machine was 18 usecs,
from the entry into do_IRQ to the enabling of interrupts in do_softirq.
Traversed 6059 times, min,max,avg=7,18,8 usecs.  Aggregate irq
blockage 51 msecs.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
