Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUICPh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUICPh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUICPh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:37:58 -0400
Received: from lax-gate2.raytheon.com ([199.46.200.231]:42678 "EHLO
	lax-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S268989AbUICPeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:34:36 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Date: Fri, 3 Sep 2004 10:33:07 -0500
Message-ID: <OFACA329EE.63AC9924-ON86256F04.00556E19-86256F04.00556E29@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/03/2004 10:33:21 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In the meantime, I will build a kernel with -R1 and leave the latency
trace
>on (now running a -Q7 kernel with both CPUs active) to see if it shows
>anything interesting before attempting any more tests.

Well - THAT was special. Another crash but I may have a clue on both that
and the "general slow down" in sched.c.

The crash is likely due to a problem with X. I caused it this time when
I was trying to open / hide Mozilla windows (again preparing to send email
with a web based client). The last operation that worked was the window
hide. The one that locked everything up was a click to restore a Mozilla
window onto the screen. I don't know if this is relevant, but the last
trace in /var/log/messages was a latency trace caused by X.

Sep  3 09:57:11 dws77 kernel: (X/2382): new 329 us maximum-latency critical
section.
Sep  3 09:57:11 dws77 kernel:  => started at: <kmap_atomic+0x23/0xe0>
Sep  3 09:57:11 dws77 kernel:  => ended at:   <kunmap_atomic+0x7b/0xa0>

I am not sure this is relevant since all the data for it was written
to disk (my script picked up the latency trace as well). Let me know
if you want the trace data.

The slow down in sched.c may be due to disk DMA activities.
When I started the kernel build, I forgot to run my script that sets
a number of /proc values. In specific, the values were:
cat /sys/block/hda/queue/max_sectors_kb
128
cat /sys/block/hda/queue/read_ahead_kb
128
cat /proc/sys/net/core/netdev_max_backlog
300
cat '/proc/irq/10/Ensoniq AudioPCI/threaded'
1

and in my other tests, they are:
echo 32 > /sys/block/hda/queue/max_sectors_kb
echo 32 > /sys/block/hda/queue/read_ahead_kb
echo 8 > /proc/sys/net/core/netdev_max_backlog
echo 0 > '/proc/irq/10/Ensoniq AudioPCI/threaded'

Note - no audio and only light network activity during the kernel
build.

With the default settings, I had latencies in sched.c over 2 msec
(longest was 2305 us). For example:

preemption latency trace v1.0.3
-------------------------------
 latency: 2305 us, entries: 137 (137)
    -----------------
    | task: ksoftirqd/0/3, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: schedule+0x51/0x740
 => ended at:   schedule+0x337/0x740
=======>
00000001 0.000ms (+0.000ms): schedule (worker_thread)
00000001 0.000ms (+0.000ms): sched_clock (schedule)
00000001 0.000ms (+0.000ms): spin_lock_irq (schedule)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
00000002 0.001ms (+0.000ms): deactivate_task (schedule)
00000002 0.001ms (+0.000ms): dequeue_task (deactivate_task)
04000002 0.765ms (+0.764ms): __switch_to (schedule)
04000002 0.800ms (+0.034ms): finish_task_switch (schedule)
04010002 1.116ms (+0.316ms): do_IRQ (finish_task_switch)
04010002 1.116ms (+0.000ms): spin_lock (do_IRQ)
04010003 1.117ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
04010003 1.118ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
04010002 1.328ms (+0.210ms): generic_handle_IRQ_event (do_IRQ)
04010002 1.797ms (+0.468ms): timer_interrupt (generic_handle_IRQ_event)
04010002 1.840ms (+0.043ms): spin_lock (timer_interrupt)
04010003 1.842ms (+0.001ms): mark_offset_tsc (timer_interrupt)
04010003 1.842ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010003 1.842ms (+0.000ms): spin_lock (mark_offset_tsc)
04010004 1.890ms (+0.048ms): mark_offset_tsc (timer_interrupt)
04010004 2.236ms (+0.345ms): mark_offset_tsc (timer_interrupt)
04010004 2.236ms (+0.000ms): spin_lock (mark_offset_tsc)
04010005 2.236ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010005 2.240ms (+0.003ms): mark_offset_tsc (timer_interrupt)
04010005 2.244ms (+0.004ms): mark_offset_tsc (timer_interrupt)
04010005 2.246ms (+0.002ms): mark_offset_tsc (timer_interrupt)
04010005 2.247ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010004 2.247ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010004 2.247ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010004 2.248ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010003 2.249ms (+0.001ms): timer_interrupt (generic_handle_IRQ_event)
...

So this trace shows a number of the symptoms I have previously
reported.

When I used the lower disk settings, the latencies went way
down [at least up to the crash...] with a maximum of 618 us.
I looked through several traces and could not find a similar
sequence for comparison.

So we may be both right.
 - there is hardware overhead that needs to be accounted for; this
pair of runs seems to point to disk I/O which we previously checked
is DMA to/from an IDE disk.
 - there may be steps in the code that cause longer latency and
we want to avoid if possible.

It may be a combination of effects. A question for others doing
testing (like Lee) - have you been doing any other activity in
the background when doing your tests? For example, I have found
that something as simple as
  head -c $1 /dev/zero >tmpfile  [$1 is a > physical memory size]
or
  cat tmpfile > /dev/null
can cause significantly increased latencies in the 2.6 kernels.

  --Mark

