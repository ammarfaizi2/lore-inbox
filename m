Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUH3TPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUH3TPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUH3TPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:15:05 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:35165 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S267664AbUH3TOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:14:22 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 30 Aug 2004 14:13:42 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 08/30/2004 02:13:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've uploaded -Q5 to:
> [snip the rest...]

Thanks.

This appears to be the first 2.6.x kernel I've run that has results
comparable to 2.4.x kernels with low latency patches and kernel preemption.
The few remaining symptoms I see include:

 - a few long (> 1 msec) delays in the real time CPU loop (no system calls)
 - varying time to complete the write system call (for audio) - much
different than 2.4
 - a couple latency traces (> 700 usec) in the network driver

For reference, these tests were performed on the following SMP system:
  Dual 866 Mhz Pentium III
  512 Mbyte memory
  IDE system disk (DMA enabled)
The basic test is Benno's latency test
(http://www.gardena.net/benno/linux/audio) with some slight modifications
to the tests to keep the second CPU busy (non real time CPU burner) and to
add network I/O tests. The 2.4 tests were run with 2.4.20, the 2.6 tests
were run with 2.4.9-rc1-Q5. On 2.6, voluntary_preemption,
kernel_preemption, hardirq_preemption, and softirq_preemption are all 1. I
also set
  /sys/block/hda/queue/max_sectors_kb = 32
  /sys/block/hda/queue/read_ahead_kb = 32
  /proc/sys/net/core/netdev_max_backlog = 8
and the audio driver was set to be non-threaded.

BASIC RESULTS
=============
Comparison of results between 2.6.x and 2.4.x; values in milliseconds.
Nominal values for the write operation is 1.45 msec; the CPU loop is 1.16
msec.

          Max CPU Delta     Max Write Delta
Test     2.4.x     2.6.x    2.4.x     2.6.x
X11       0.10      0.16     0.05      0.65
/proc     0.07      0.17     0.05      0.65
net out   0.15      0.19     0.05      0.75
net in    0.17      0.23     0.05      0.95
dsk wrt   0.49      0.18     0.25      1.05
dsk copy  2.48      0.68     2.25      1.25
disk rd   3.03      1.61     2.75      1.35

LONG DELAYS
===========

Note I still see over 110% worst case overhead on a max priority real time
CPU task (no system calls) when doing heavy disk I/O on 2.6. It is much
better than 2.4, but still disturbing. What I would hope would happen on a
dual CPU system like mine, is that the real time task tends to be on one
CPU and the other system activity would tend to stay on the other CPU.
However, the results do not seem to indicate that behavior.

VARYING SYSTEM CALL TIMES
=========================

In 2.4, it appears that the duration of the write system call is basically
fixed and dependent on the duration of the audio fragment. In 2.6, this
behavior is now different. If I look at the chart in detail, it appears the
system is queueing up several write operations during the first few seconds
of testing. You can see this by consistently low elapsed times for the
write system call. Then the elapsed time for the write bounces up / down in
a sawtooth pattern over a 1 msec range. Could someone explain the cause of
this new behavior and if there is a setting to restore the old behavior? I
am concerned that this queueing adds latency to audio operations (when
trying to synchronize audio with other real time behavior).

LONG NETWORK LATENCIES
======================

In about 25 minutes of heavy testing, I had two latency traces with
/proc/sys/kernel/preempt_max_latency set to 700. They had the same start /
end location with the long delay as follows:
  730 us, entries: 361
  ...
  started at rtl8139_poll+0x3c/0x160
  ended at   rtl8139_poll+0x100/0x160
  00000001 0.000ms (+0.000ms): rtl8139_poll (net_rx_action)
  00000001 0.140ms (+0.140ms): rtl8139_rx (rtl8139_poll)
  00000001 0.556ms (+0.416ms): alloc_skb (rtl8139_rx)
  ... remaining items all > +0.005ms ...

  731 us, entries: 360
  ...
  started at rtl8139_poll+0x3c/0x160
  ended at   rtl8139_poll+0x100/0x160
  00000001 0.000ms (+0.000ms): rtl8139_poll (net_rx_action)
  00000001 0.000ms (+0.000ms): rtl8139_rx (rtl8139_poll)
  00000001 0.002ms (+0.001ms): alloc_skb (rtl8139_rx)
  00000001 0.141ms (+0.139ms): kmem_cache_alloc (alloc_skb)
  00000001 0.211ms (+0.070ms): __kmalloc (alloc_skb)
  00000001 0.496ms (+0.284ms): eth_type_trans (rtl8139_rx)
  00000001 0.565ms (+0.068ms): netif_receive_skb (rtl8139_rx)
  ... remaining items all > +0.005ms ...

Still much better than my previous results (before setting
netdev_max_backlog).

I will be running some additional tests
 - reducing preempt_max_latency
 - running with sortirq and hardirq_preemption=0
to see if these uncover any further problems.

Thanks again for the good work.
--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

