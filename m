Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262255AbSJ0DWB>; Sat, 26 Oct 2002 23:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSJ0DWB>; Sat, 26 Oct 2002 23:22:01 -0400
Received: from chardonnay.math.bme.hu ([152.66.83.144]:45541 "HELO
	chardonnay.math.bme.hu") by vger.kernel.org with SMTP
	id <S262255AbSJ0DV6>; Sat, 26 Oct 2002 23:21:58 -0400
Date: Sun, 27 Oct 2002 04:28:11 +0100
From: KORN Andras <korn-linuxkernel@chardonnay.math.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.4 very slow memory access on abit kd7raid (kt400); ten times slower than on kg7raid
Message-ID: <20021027032811.GM27554@nilus-2690.adsl.datanet.hu>
Reply-To: korn-linuxkernel@chardonnay.math.bme.hu
Mail-Followup-To: korn-linuxkernel@chardonnay.math.bme.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently upgraded the motherboard in a small server. Everything else
stayed the same (discussed below).

Everything slowed down. The easiest way to demontsrate this is by looking at
these figures:

 raid5: measuring checksumming speed
-   8regs     :  2343.600 MB/sec
-   32regs    :  1944.000 MB/sec
-   pIII_sse  :  4163.600 MB/sec
-   pII_mmx   :  3584.400 MB/sec
-   p5_mmx    :  4600.800 MB/sec
-raid5: using function: pIII_sse (4163.600 MB/sec)
+   8regs     :   228.400 MB/sec
+   32regs    :   199.200 MB/sec
+   pIII_sse  :   352.000 MB/sec
+   pII_mmx   :   316.800 MB/sec
+   p5_mmx    :   432.800 MB/sec
+raid5: using function: pIII_sse (352.000 MB/sec)

Old motherboard above, new below. (Why it chose pIII_sse even when p5_mmx
was faster is also an interesting question... :)

What could be causing this? I believe it is a kernel issue because memtest86
reports realistic memory bandwidths (about 590MB/s).

I'm now seeing obscene load averages (in excess of 50 not uncommon), and
'system' usage according to 'top' is almost always over 50 percent (used to
be around 15-20 with old motherboard).

Switching back to the old motherboard solves the problem. Load drops back to
the usual 0.2-2.

I use a 2.4.20-pre10-ac2 kernel now; I can't easily try a stock kernel
because they tend to fail during boot in spectacular ways (perhaps the MB is
too new?).

The box has four NICs, moderate network traffic (less than 10Mb/s total, on
average; I'm routing and firewalling between the subnets). CPU is an AMD
AthlonXP1800+. I have 1GB of DDR266 RAM.

I use LVM1 (so I guess I can't easily try a 2.5 kernel until the devmapper
stuff gets sorted out); I have two ATA133 disks sitting on the HPT372 that's
integrated on the MB (one disk on each channel). A single EIDE CDROM drive
is hooked up to the VIA IDE controller.

Three of the NICs are tulip cards from KTI (Intel 21143PD); the fourth is
the VIA Rhine integrated on the MB.

I compiled the kernel optimizing for K7; highmem is enabled; I tried both
with APIC enabled and disabled (the MB has one). USB support is compiled as
a module; it doesn't matter whether it's loaded or not. I don't use a
graphical framebuffer (card is an Ati Rage 128). MTRRs are enabled;
/proc/mtrr contains this:

reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0xc0000000 (3072MB), size= 256MB: write-combining, count=1
reg05: base=0xc0000000 (3072MB), size= 256MB: write-combining, count=1

I'm running Debian unstable, a Domino server (yuck), tomcat 3 and apache
1.3.

A google search for 'kt400 linux slow' and similar phrases turned up nothing
that looked useful.

A diff between the bootup messages of the old and the new mb looks like this
(I omit stuff that doesn't seem relevant):

- BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
+ BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
+ BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
+ BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
+ BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
...
 CPU: L2 Cache: 256K (64 bytes/line)
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
-CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
-CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
+CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
+CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
 CPU: AMD Athlon(tm) XP 1800+ stepping 02
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
...
 PCI: Using configuration type 1
...
 Bus scan for 01 returning with max=01
 Scanning behind PCI bridge 00:01.0, config 010100, pass 1
 Bus scan for 00 returning with max=01
-PCI: Bus 01 already known
-PCI: Using IRQ router VIA [1106/0686] at 00:07.0
+PCI: Using IRQ router VIA [1106/3177] at 00:11.0
...
 ACPI: Core Subsystem version [20011018]
 ACPI: Subsystem enabled
 ACPI: System firmware supports S0 S1 S4 S5
-Processor[0]: C0 C1, 2 throttling states
+Processor[0]: C0 C1 C2, 2 throttling states
 ACPI: Power Button (FF) found
 ACPI: Multiple power buttons detected, ignoring fixed-feature
 ACPI: Power Button (CM) found
 ACPI: Sleep Button (CM) found
+ACPI: Thermal Zone found
...
-VP_IDE: IDE controller at PCI slot 00:07.1
+VP_IDE: IDE controller at PCI slot 00:11.1
+PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
(NB: I did that and it didn't help.)
 VP_IDE: chipset revision 6
 VP_IDE: not 100% native mode: will probe irqs later
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
-VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
-    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
-    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
-HPT370A: IDE controller at PCI slot 00:13.0
-PCI: Found IRQ 11 for device 00:13.0
-HPT370A: chipset revision 4
-HPT370A: not 100% native mode: will probe irqs later
+VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
+    ide0: BM-DMA at 0xc800-0xc807, BIOS settings: hda:DMA, hdb:pio
+    ide1: BM-DMA at 0xc808-0xc80f, BIOS settings: hdc:pio, hdd:pio
+HPT372: IDE controller at PCI slot 00:13.0
+PCI: Found IRQ 10 for device 00:13.0
+PCI: Sharing IRQ 10 with 00:10.2
+HPT372: chipset revision 5
+HPT372: not 100% native mode: will probe irqs later
 HPT37X: using 33MHz PCI clock
...

What can I do to fix or narrow down the problem with the new motherboard?

Is there any patch that might help?

I tried playing with the BIOS settings for memory access, but that didn't
buy me anything either.

Thanks in advance for any suggestions.

Andrew

Ps. I'm not subscribed; I'll check the archives, but I'd be obliged if you
could Cc: me with replies anyway.

-- 
          Andrew Korn (Korn Andras) <korn at chardonnay.math.bme.hu>
           Finger korn at chardonnay.math.bme.hu for pgp key. QOTD:
               "Make love not war." - "I'm married and do both."
