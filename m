Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUIBNSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUIBNSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIBNSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:18:44 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:17218 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S268300AbUIBNSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:18:30 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Thomas Charbonnel <thomas@undata.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF4A93C101.C3FFA1E6-ON86256F03.004851E5@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 2 Sep 2004 08:18:02 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/02/2004 08:18:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>(you mean 500+ usec, correct?)
>
>there's no way the scheduler can have 500 usecs of overhead going from
>dequeue_task() to __switch_to(): we have all interrupts disabled and
>take zero locks! This is almost certainly some hardware effect (i
>described some possibilities and tests a couple of mails earlier).
>
>In any case, please enable nmi_watchdog=1 so that we can see (in -Q7)
>what happens on the other CPUs during such long delays.

Booted with nmi_watchdog=1, saw the kernel message indicating that
NMI was checked OK.

The first trace looks something like this...

latency 518 us, entries: 79
...
started at schedule+0x51/0x740
ended at schedule+0x337/0x740

00000001 0.000ms (+0.000ms): schedule (io_schedule)
00000001 0.000ms (+0.000ms): sched_clock (schedule)
00010001 0.478ms (+0.478ms): do_nmi (sched_clock)
00010001 0.478ms (+0.000ms): do_nmi (<08049b21>)
00010001 0.482ms (+0.003ms): profile_tick (nmi_watchdog_tick)
...
and a few entries later ends up at do_IRQ (sched_clock).

The second trace goes from dequeue_task to __switch_to with a
similar pattern - the line with do_nmi has +0.282ms duration and
the line notifier_call_chain (profile_hook) as +0.135ms duration.

I don't see how this provides any additional information but will
provide several additional traces when the test gets done in a
few minutes.


--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

