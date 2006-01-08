Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWAHW5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWAHW5W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbWAHW5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:57:22 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:3287 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1161225AbWAHW5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:57:22 -0500
Date: Sun, 8 Jan 2006 23:07:24 +0000
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.15-rt2 x86_64 SMP instability
Message-ID: <20060108230724.GA4197@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just compiled 2.6.15-rt2 on x86_64 SMP (dual Opteron) and it's giving
a lot of weird instabilities. If I start jackd (this is an audio workstation)
with realtime privileges from an xterm I get a lot of spurious xruns. When I
first start it, moving the mouse makes the xruns scroll off the screen.
That stops for a couple of minutes, during which there's a slow but
steady stream of xruns. After two or three minutes the xruns suddenly
scroll off the screen too quickly to read, and keep going until the jack
watchdog timer kills jackd (the latter is usually caused by the two
wordclock-locked sound cards losing sync with each other, which
shouldn't happen). Sometimes X locks up shortly after this and it needs
a hard reboot.

None of the above happens with a non-rt kernel, and I've had the same
thing with 2.6.15-rt1 and every 2.6.15-rcx-rtx kernel I tried.

Here's an excerpt from dmesg that may shed some light on this:

<snip>
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Time: tsc clocksource has been installed.
check_monotonic_clock: monotonic inconsistency detected!
	from         26cbf3ad (650900397) to         260079b7 (637565367).
softirq-timer/1/13[CPU#1]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160

Call Trace:<ffffffff801361e2>{__WARN_ON+114} <ffffffff8015141d>{check_monotonic_clock+109}
       <ffffffff80151cfc>{get_realtime_clock+92} <ffffffff8014eed1>{hrtimer_run_queues+49}
       <ffffffff8013fc87>{run_timer_softirq+455} <ffffffff8013b4c0>{ksoftirqd+304}
       <ffffffff8013b390>{ksoftirqd+0} <ffffffff8013b390>{ksoftirqd+0}
       <ffffffff8014c009>{kthread+217} <ffffffff80131258>{schedule_tail+136}
       <ffffffff8010f076>{child_rip+8} <ffffffff8014bf30>{kthread+0}
       <ffffffff8010f06e>{child_rip+0} 
read_tsc: ACK! TSC went backward! Unsynced TSCs?
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
...
...
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
    ide0: BM-DMA at 0xd000-0xd007check_periodic_interval: Long interval! 158008629.
		Something may be blocking interrupts.
, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6K040L0, ATA DISK drive
</snip>

Is there any more info I can supply to help debug this?

John
