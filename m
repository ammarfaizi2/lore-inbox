Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267280AbUGVVPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267280AbUGVVPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 17:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUGVVPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 17:15:21 -0400
Received: from nevyn.them.org ([66.93.172.17]:46568 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S267280AbUGVVPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 17:15:11 -0400
Date: Thu, 22 Jul 2004 17:14:11 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Intermittent panic at boot on x86-64
Message-ID: <20040722211411.GA3575@nevyn.them.org>
Mail-Followup-To: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20040717230924.GA7174@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040717230924.GA7174@nevyn.them.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2004 at 07:09:24PM -0400, Daniel Jacobowitz wrote:
> I'm trying to set up a dual Opteron 244 system using Linux 2.4.7.  It
> doesn't reliably boot in SMP, although I've never had a problem in UP. It's
> possible that it's a hardware problem - the machine is new - but I don't
> think so.
> 
> I get a lot of different results when I boot an SMP kernel: an NMI watchdog
> reported lockup in smp_boot_cpus [first log below], a single processor boot
> [second log below], an NMI watchdog lockup in ret_from_intr, also during
> smp_boot_cpus [third log below], an OK boot (maybe 33% of the time, fourth
> log below), or an error complaining that the IO-APIC and timer don't work
> and I should go bug Ingo (couldn't reproduce this now but it's from
> check_timer in io_apic.c).
> 
> If it does boot both processors, it seems to run OK.

Really confused now... I just had a successful boot with somehow messed
up timers.  Take a look at the BogoMIPS here:

Processors: 2
Checking aperture...
CPU 0: aperture @ e0000000 size 128 MB
CPU 1: aperture @ e0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro noapic console=tty0
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1836.749 MHz processor.
Console: colour VGA+ 80x25
spurious 8259A interrupt: IRQ7.
Memory: 1023272k/1047424k available (4647k kernel code, 23416k reserve
Calibrating delay loop... 486.40 BogoMIPS
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 244 stepping 0a
per-CPU timeslice cutoff: 1024.01 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10001e69f58
Initializing CPU#1
Calibrating delay loop... 130.81 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 244 stepping 0a
Total of 2 processors activated (617.21 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.755 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
CPU0:  online


It seems to be cosmetic; there's no obvious performance drop to match
the size of the bogomips drop.  I don't know why it didn't try to
calibrate the APIC timer that time.  Sometimes the timer calibrates
wrong, too:

Jul 22 16:43:33 localhost kernel: calibrating APIC timer ...
Jul 22 16:43:33 localhost kernel: ..... CPU clock speed is 2399.0251 MHz.
Jul 22 16:43:33 localhost kernel: ..... host bus clock speed is 266.0584 MHz.
Jul 22 16:43:33 localhost kernel: Brought up 1 CPUs

[That's a 32-bit kernel showing similar symptoms; the 64-bit kernel
doesn't attempt that calibration AFAICT.  I haven't caught the 32-bit
kernel failing to boot yet, but it does sometimes come up with only one
CPU, and I haven't tried too many times.]

I'm out of ideas; something is definitely wrong with the timers or our
detection of them.

-- 
Daniel Jacobowitz
