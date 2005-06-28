Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVF1Dfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVF1Dfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 23:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVF1Dfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 23:35:55 -0400
Received: from unused.mind.net ([69.9.134.98]:724 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262498AbVF1De3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 23:34:29 -0400
Date: Mon, 27 Jun 2005 20:32:37 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050627081542.GA15096@elte.hu>
Message-ID: <Pine.LNX.4.58.0506272001190.5720@echo.lysdexia.org>
References: <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org>
 <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org>
 <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org>
 <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu>
 <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu>
 <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org> <20050627081542.GA15096@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Ingo Molnar wrote:

> > I still haven't been able to get any NMI watchdog traces with the 
> > lockups induced by VLC and burnP6.  Early printk is enabled on the 
> > serial console. I have noticed, however, that scheduling performance 
> > slowly degrades during the ~1 minute before locking up.  Once I was 
> > able to get a delayed SysRq response (~30s) from the serial console 
> > after the X console became unresponsive.  Is this possibly a scheduler 
> > starvation issue that affects everything, including the NMI watchdog?  
> > Any more suggestions for catching a trace?
> 
> hm. Nothing should starve the NMI watchdog. Only a nasty, complete 
> kernel crash or a hardware failure can lock up the box in a way that not 
> even the NMI watchdog can get some message out to the console. Just in 
> case, could you try the latest patch (-50-24 or later), there were a 
> couple of bugs fixed.

OK.  Running on -50-25 now.  The burnP6 starvation doesn't seem to affect
the whole system, but comes close enough to require the reset button every
time.  I usually, but not always, lose network, X, the keyboard, mouse,
and serial console.  I'm still unable to get any sort of a trace from
these lockups, since it's looking more like a bunch of processes starving 
than a kernel crash or a full lockup.

Once, with VLC (viewing a 5mbit/s mcast/udp stream) and two burnP6
instances running, I was able to fire up top on the serial console and
found out that the IRQ thread for the ns83820 nic was using 99% of one
CPU.

Once, two burnP6 instances made the system unresponsive without running 
VLC.  Everything froze as soon as I fired the second one up.  This may be 
a good one to try to reproduce on an HT machine, since it doesn't require 
VLC and a multicast video stream to make the system unresponsive.

Once, with a normal desktop load and a yum update, this came across on the 
serial console:

cat/2100[CPU#1]: BUG in update_out_trace at kernel/latency.c:587
 [<c01041b3>] dump_stack+0x23/0x30 (20)
 [<c0122e0b>] __WARN_ON+0x6b/0x90 (52)
 [<c0140530>] update_out_trace+0x3d0/0x440 (104)
 [<c0140881>] l_stax2e1/0x310 (72)
 [<c0191eab>] seq_read+0x7b/0x2d0 (60)
 [<c016ecd4>] vfs_read+0xd4/0x140 (36)
 [<c016efb0>] sys_read+0x50/0x80 (44)
 [<c01031c0>] sysenter_past_esp+0x61/0x89 (-8116)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c038dd9f>] .... _raw_spin_lock_irqsave+0x1f/0xb0
.....[<c0122dc7>] ..   ( <= __WARN_ON+0x27/0x90)
.. [<c014280d>] .... print_traces+0x1d/0x60
.....[<c01040b2>] ..   ( <= show_trace+0xc2/0xf0)

------------------------------
| showing all locks held by: |  (cat/2100 [deca9320, 117]):
------------------------------

#001:             [d9ac47a4] {(struct semaphore *)(&p->sem)}
... acquired at:  seq_read+0x2b/0x2d0

#002:             [c03fb264] {out_mutex.lock}
... acquired at:  l_start+0x1b/0x310

#003:             [c04d1404] {max_mutex.lock}
... acquired at:  l_start+0x2dc/0x310

CPU0: 000000abfe71626e (000000abfe71654e) ... #3 (000000abfe71654e) 000000abfe7176be
CPU1: 000000abfe6d3f0e (000000abfe6d4efe) ... #41 (000000abfe70fa46) 000000abfe71227e
CPU1 entries: 41
first stamp: 000000abfe71626e
 last stamp: 000000abfe71626e
cat/2101[CPU#1]: BUG in update_out_trace at kernel/latency.c:587
 [<c01041b3>] dump_stack+0x23/0x30 (20)
 [<c0122e0b>] __WARN_ON+0x6b/0x90 (52)
 [<c0140530>] update_out_trace+0x3d0/0x440 (104)
 [<c0140881>] l_start+0x2e1/0x310 (72)
 [<c0191eab>] seq_read+0x7b/0x2d0 (60)
 [<c016ecd4>] vfs_read+0xd4/0x140 (36)
 [<c016efb0>] sys_read+0x50/0x80 (44)
 [<c01031c0>] sysenter_past_esp+0x61/0x89 (-8116)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c038dd9f>] .... _raw_spin_lock_irqsave+0x1f/0xb0
.....[<c0122dc7>] ..   ( <= __WARN_ON+0x27/0x90)
.. [<c014280d>] .... print_traces+0x1d/0x60
.....[<c01040b2>] ..   ( <= show_trace+0xc2/0xf0)

------------------------------
| showing all locks held by: |  (cat/2101 [deca9320, 116]):
------------------------------

#001:             [d9ac47a4] {(struct semaphore *)(&p->sem)}
... acquired at:  seq_read+0x2b/0x2d0

#002:             [c04d1404] {max_mutex.lock}
... acquired at:  l_start+0x2dc/0x310

CPU0: 000000abfe71626e (000000abfe71654e) ... #3 (00000071654e) 000000abfe7176be
CPU1: 000000abfe6d3f0e (000000abfe6d4efe) ... #41 (000000abfe70fa46) 000000abfe71227e
CPU1 entries: 41
first stamp: 000000abfe71626e
 last stamp: 000000abfe71626e


Best Regards,
--ww

