Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUFXT1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUFXT1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUFXTZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:25:13 -0400
Received: from mail3.absamail.co.za ([196.35.40.69]:57032 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S264808AbUFXTU1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:20:27 -0400
From: "Niel Lambrechts" <antispam@absamail.co.za>
To: <linux-kernel@vger.kernel.org>
Subject: Vesafb and mtrr confusion
Date: Thu, 24 Jun 2004 21:21:45 +0200
Message-ID: <000f01c45a20$7d0d8d70$fe78a8c0@MERCKX>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I am using intel-agp for Intel 855PM chipset on a Thinkpad R50P, fglrx
for FireGL T2-128 graphics and vesafb for my console using kernel
2.6.7-rc3-mm1 on SuSE 9.1. 

(I am trying to configure ATI's fglrx driver, and although my error-logs
are clean, 3d still does not work) 

vesafb seems to confuse /proc/mtrr: 
AT STARTUP: 
>cat /proc/mtrr 
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1 
reg01: base=0x1ff80000 ( 511MB), size= 512KB: uncachable, count=1 
reg02: base=0xe0000000 (3584MB), size= 2MB: write-combining, count=1 

If my info is correct, reg02 represents the video card memory - and some
posts speculate this field to be wrong, as the FireGL T2 has 128 MB of
video memory, not 2 MB: 
> cat /var/log/XFree86.0.log|grep ATI|grep PCI    
#illustrate videocard mem. address 
(--) PCI:*(1:0:0) ATI Technologies Inc unknown chipset (0x4e54) rev 128,
Mem @ 0xe0000000/27, 0xc0100000/16, I/O @ 0x3000/8 

FIX: 
> echo "disable=2" >| /proc/mtrr 
> echo "base=0xe0000000 size=0x8000000 type=write-combining" >|
/proc/mtrr 

#0x8000000 = 128MB 

AFTER STARTING X (are these values ok?): 
>cat /proc/mtrr 
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1 
reg01: base=0x1ff80000 ( 511MB), size= 512KB: uncachable, count=1 
reg02: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=1 
reg03: base=0xd0000000 (3328MB), size= 256MB: write-combining, count=1 

#reg00 = ? 
#reg01 = ? 
#reg02 = video card 
#reg03 = AGP I think 

Maybe this is significant? 
1. dmesg when I quit X: 
 ----------------------------------------- 
| mtrr: no MTRR for e0000000,400000 found | 
| mtrr: no MTRR for e0400000,200000 found | 
| mtrr: no MTRR for e0600000,100000 found | 
 ----------------------------------------- 

Other symptoms: 
- glxinfo shows "Direct Rendering = no", although DRI loads ok in the X
log. 
- fgl_glxgears and glxgears runs at measly rates (+-220FPS) 
- lsmod shows fglrx usage count = 7, intel-agp usage count = 1. (seems
too low!) 

To me, it does not seem as if the fglrx driver is using intel-agp, could
the /proc/mtrr have any role in this? (intel-agp usage count stays 1 all
the time) 

Any info would be appreciated, I have wasted days on this, also tried
2.6.5-7.75-default from SuSE with similar results.... 

Regards, 
Niel 

Other info: 
RPM Packages used: 
fglrx-3.9.0-2.1 
km_fglrx-3.9.0-2.1 

> lspci -v 
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
Controller (rev 03) 
    Subsystem: IBM: Unknown device 0529 
    Flags: bus master, fast devsel, latency 0 
    Memory at d0000000 (32-bit, prefetchable) 
    Capabilities: [e4] #09 [4104] 
    Capabilities: [a0] AGP version 2.0 

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller
(rev 03) (prog-if 00 [Normal decode]) 
    Flags: bus master, 66Mhz, fast devsel, latency 96 
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=64 
    I/O behind bridge: 00003000-00003fff 
    Memory behind bridge: c0100000-c01fffff 
    Prefetchable memory behind bridge: e0000000-e7ffffff 
    Expansion ROM at 00003000 [disabled] [size=4K] 

0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
(prog-if 00 [UHCI]) 
    Subsystem: IBM: Unknown device 052d 
    Flags: bus master, medium devsel, latency 0, IRQ 11 
    I/O ports at 1800 [size=32] 

0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
(prog-if 00 [UHCI]) 
    Subsystem: IBM: Unknown device 052d 
    Flags: bus master, medium devsel, latency 0, IRQ 11 
    I/O ports at 1820 [size=32] 

0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
(prog-if 00 [UHCI]) 
    Subsystem: IBM: Unknown device 052d 
    Flags: bus master, medium devsel, latency 0, IRQ 11 
    I/O ports at 1840 [size=32] 

0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if
20 [EHCI]) 
    Subsystem: IBM: Unknown device 052e 
    Flags: bus master, medium devsel, latency 0, IRQ 11 
    Memory at c0000000 (32-bit, non-prefetchable) 
    Capabilities: [50] Power Management version 2 
    Capabilities: [58] #0a [2080] 

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
(prog-if 00 [Normal decode]) 
    Flags: bus master, fast devsel, latency 0 
    Bus: primary=00, secondary=02, subordinate=08, sec-latency=168 
    I/O behind bridge: 00004000-00008fff 
    Memory behind bridge: c0200000-cfffffff 
    Prefetchable memory behind bridge: e8000000-efffffff 

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller
(rev 01) 
    Flags: bus master, medium devsel, latency 0 

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage
Controller (rev 01) (prog-if 8a [Master SecP PriP]) 
    Subsystem: IBM: Unknown device 052d 
    Flags: bus master, medium devsel, latency 0, IRQ 11 
    I/O ports at <unassigned> 
    I/O ports at <unassigned> 
    I/O ports at <unassigned> 
    I/O ports at <unassigned> 
    I/O ports at 1860 [size=16] 
    Memory at 20000000 (32-bit, non-prefetchable) [size=1K] 

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01) 
    Subsystem: IBM: Unknown device 052d 
    Flags: medium devsel, IRQ 5 
    I/O ports at 1880 [size=32] 

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97
Audio Controller (rev 01) 
    Subsystem: IBM: Unknown device 0554 
    Flags: bus master, medium devsel, latency 0, IRQ 5 
    I/O ports at 1c00 
    I/O ports at 18c0 [size=64] 
    Memory at c0000c00 (32-bit, non-prefetchable) [size=512] 
    Memory at c0000800 (32-bit, non-prefetchable) [size=256] 
    Capabilities: [50] Power Management version 2 

0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 01)
(prog-if 00 [Generic]) 
    Subsystem: IBM: Unknown device 0525 
    Flags: medium devsel, IRQ 5 
    I/O ports at 2400 
    I/O ports at 2000 [size=128] 
    Capabilities: [50] Power Management version 2 

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 4e54 (rev 80) (prog-if 00 [VGA]) 
    Subsystem: IBM: Unknown device 054f 
    Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 66,
IRQ 11 
    Memory at e0000000 (32-bit, prefetchable) 
    I/O ports at 3000 [size=256] 
    Memory at c0100000 (32-bit, non-prefetchable) [size=64K] 
    Capabilities: [58] AGP version 2.0 
    Capabilities: [50] Power Management version 2 

0000:02:00.0 CardBus bridge: Texas Instruments: Unknown device ac46 (rev
01) 
    Subsystem: IBM: Unknown device 0552 
    Flags: bus master, medium devsel, latency 168, IRQ 11 
    Memory at b0000000 (32-bit, non-prefetchable) 
    Bus: primary=02, secondary=03, subordinate=06, sec-latency=176 
    Memory window 0: 20400000-207ff000 (prefetchable) 
    Memory window 1: 20800000-20bff000 
    I/O window 0: 00004000-000040ff 
    I/O window 1: 00004400-000044ff 
    16-bit legacy interface ports at 03e1 

0000:02:00.1 CardBus bridge: Texas Instruments: Unknown device ac46 (rev
01) 
    Subsystem: IBM: Unknown device 0552 
    Flags: bus master, medium devsel, latency 168, IRQ 5 
    Memory at b1000000 (32-bit, non-prefetchable) 
    Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176 
    Memory window 0: 20c00000-20fff000 (prefetchable) 
    Memory window 1: 21000000-213ff000 
    I/O window 0: 00004800-000048ff 
    I/O window 1: 00004c00-00004cff 
    16-bit legacy interface ports at 03e1 

0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet
Controller (Mobile) (rev 03) 
    Subsystem: IBM: Unknown device 0549 
    Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11 
    Memory at c0220000 (32-bit, non-prefetchable) 
    Memory at c0200000 (32-bit, non-prefetchable) [size=64K] 
    I/O ports at 8000 [size=64] 
    Capabilities: [dc] Power Management version 2 
    Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable- 

0000:02:02.0 Ethernet controller: Unknown device 168c:1014 (rev 01) 
    Subsystem: Unknown device 17ab:8331 
    Flags: bus master, medium devsel, latency 80, IRQ 11 
    Memory at c0210000 (32-bit, non-prefetchable) 
    Capabilities: [44] Power Management version 2 

VesaFB: 
vesafb: framebuffer at 0xe0000000, mapped to 0xe0808000, size 3072k 
vesafb: mode is 1024x768x16, linelength=2048, pages=84 
vesafb: protected mode interface info at c000:59f1 
vesafb: scrolling: redraw 
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0 
fb0: VESA VGA frame buffer device 

AGP: 
Linux agpgart interface v0.100 (c) Dave Jones 
agpgart: Detected an Intel 855PM Chipset. 
agpgart: Maximum main memory to use for agp memory: 439M 
agpgart: AGP aperture is 256M @ 0xd0000000 
[fglrx] AGP detected, AgpState   = 0x1f000217 (hardware caps of chipset)

agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0. 
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode 
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode 
[fglrx] AGP enabled,  AgpCommand = 0x1f000314 (selected caps) 
[fglrx] free  AGP = 252440576 
[fglrx] max   AGP = 252440576 
[fglrx] free  LFB = 116391936 
[fglrx] max   LFB = 116391936 
[fglrx] total FB  = 0 
[fglrx] total AGP = 65536 
mtrr: no MTRR for e0000000,400000 found    #this comes up when I quit X.

mtrr: no MTRR for e0400000,200000 found 
mtrr: no MTRR for e0600000,100000 found 





