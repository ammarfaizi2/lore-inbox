Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTI2C7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 22:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTI2C7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 22:59:13 -0400
Received: from science.horizon.com ([192.35.100.1]:42300 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262792AbTI2C7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 22:59:06 -0400
Date: 29 Sep 2003 02:59:06 -0000
Message-ID: <20030929025906.6939.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6, x86 mdelay() calls running 1.5% fast
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently struggling to get a Logitech ADI-protocol joystick
working on 2.6.  It would work as an analog joystick, but it wasn't
responding to the special trigger sequence used to set it to
digital mode.

This is a magically timed sequence of joystick trigger pulses.  For anyone
looking at the code in drivers/input/joystick/adi.c, adi_init_digital(),
some delays must be exact, so the code uses mdelay(), while others
just have to be the given length or longer, so the code uses wait_ms(),
which schedules.

Anyway, as part of debugging, I stuck some asm("rdtsc") code in there and
found that the mdelay() calls were consistently 1.5% fast.  Changing it to
"mdelay(delay); udelay(15*delay);" got everything working.

Anyway, the machine I'm running on is an Athlon on a KT133 motherboard
running at 10.5 * 105 MHz, 1102.5 MHz nominal, 1102.77 measured at boot.

I'm currently running a NON-premeptive 2.6 kernel (part of debugging the
timing), but the problem was first observed (although not quantitatively
measured) on a preemptive kernel.

The start of the boot messages, past the last thing I can see that
mentions timing, is as follows:

Linux version 2.6.0-test6 (root@localhost) (gcc version 3.3.2 20030908 (Debian prerelease)) #12 Sun Sep 28 04:06:29 EDT 2003
Video mode to be used for restore is f01
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffec000 (usable)
 BIOS-e820: 000000002ffec000 - 000000002ffef000 (ACPI data)
 BIOS-e820: 000000002ffef000 - 000000002ffff000 (reserved)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196588
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192492 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6a70
ACPI: RSDT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x2ffec000
ACPI: FADT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x2ffec080
ACPI: BOOT (v001 ASUS   A7V-133  0x30303031 MSFT 0x31313031) @ 0x2ffec040
ACPI: DSDT (v001   ASUS A7V-133  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6 ro root=302 parport=0x378,7,3
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1102.767 MHz processor.
Console: colour VGA+ 80x50
Memory: 774080k/786352k available (2296k kernel code, 11500k reserved, 975k data, 164k init, 0k highmem)
Calibrating delay loop... 2170.88 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1102.0349 MHz.
..... host bus clock speed is 209.0971 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813


I'm getting a little lost wandering around arch/i386/kernel/timers/*.c.
It looks like it should be using the TSC for udelay() and thus I should
not be able to measure the error using the TSC!

But there's an impressive amount of number-juggling going on with
the delay.  Multipled by 4294 (which should probably be 4295, no?
It's an approximation to 4294.967296) to seconds/2^32,
then by loops_per_jiffy/2^32, then multipled by HZ.

And loops_per_jiffy is rather intricately used.  (It's not clear that
adjust_jiffies in drivers/cpufreq/cpufreq.c is doing the right thing if
the timer in use is NOT based on the processor clock.)

Can anyone help me with the next stage of debugging?

Other notes:
- Hooking the joystick up is new, so I can't say when it broke.
  It works under 2.4.22, but I don't want to rebuild a huge list of
  2.5 kernels unless things get really desperate.

- 105 MHz is definitely a funky FSB speed, but the 1.5% error is
  consistent at 133 MHz and 120 MHz FSB.

- I'm considering hacking the code into a more-polite version that
  schedules most of the delay and then measures the time and uses
  udelay() for whatever's left.  If the schedule oversleeps, I can
  detect it and retry with less sleeping and more udelay.
  However, this probably interacts with HZ.  If anyone can offer
  any advice on expected (as opposed to worst-case) scheduling delays,
  it would be useful.
