Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWDLWLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWDLWLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWDLWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:11:50 -0400
Received: from main.gmane.org ([80.91.229.2]:5262 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932350AbWDLWLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:11:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Linux 2.6.16 -  SATA read performance drop ~50% on Intel 82801GB/GR/GH
Date: Wed, 12 Apr 2006 17:22:12 -0400
Message-ID: <443D6F84.8060809@tmr.com>
References: <200604120136.28681.schnaiter@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: prgy-npn2.prodigy.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060410 SeaMonkey/1.5a
In-Reply-To: <200604120136.28681.schnaiter@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schnaiter wrote:
> Hi,
> 
> after upgrading from linux 2.6.15.7 to 2.6.16.2 I noticed an extreme slowdown 
> of the SATA disks on my system. Writing/reading a 8GB file showed that 
> reading performes with less than half the speed on 2.6.16 (strangely hdparm 
> shows almost no difference).
> The two affected disks are connected to the Intel 82801GB/GR/GH (ICH7 Family)  
> Serial ATA Controller.
> Disks on the Silicon Image/Intel IDE Controllers are not affected.
> I didn't have the chance yet to test if this problem also exists on the 
> Silicon Image SATA Controller.
> 
> Please tell me if there is any other useful information I can provide =)

Assuming that you reproduce this switching back to the old kernel, that 
kind of lets the hardware out as the cause. I have to do measurements on 
an SATA system to comment further.
> 
> 
> Linux 2.6.15.7
> ---
> # time dd if=/dev/zero of=/benchfile bs=1M count=8192
> 8192+0 records in
> 8192+0 records out
> 8589934592 bytes (8.6 GB) copied, 132.224 seconds, 65.0 MB/s
> 
> real	2m12.347s
> user	0m0.018s
> sys	0m18.398s
> 
> # time dd if=/benchfile of=/dev/null bs=1M
> 8192+0 records in
> 8192+0 records out
> 8589934592 bytes (8.6 GB) copied, 130.547 seconds, 65.8 MB/s
> 
> real	2m10.670s
> user	0m0.023s
> sys	0m14.238s
> 
> # hdparm -tT /dev/sdb
> 
> /dev/sdb:
>  Timing cached reads:   4488 MB in  2.00 seconds = 2244.34 MB/sec
>  Timing buffered disk reads:  212 MB in  3.02 seconds =  70.30 MB/sec
> 
> 
> Linux 2.6.16.2
> ---
> # time dd if=/dev/zero of=/benchfile bs=1M count=8192
> 8192+0 records in
> 8192+0 records out
> 8589934592 bytes (8.6 GB) copied, 122.256 seconds, 70.3 MB/s
> 
> real	2m2.460s
> user	0m0.013s
> sys	0m17.971s
> 
> # time dd if=/benchfile of=/dev/null bs=1M
> 8192+0 records in
> 8192+0 records out
> 8589934592 bytes (8.6 GB) copied, 302.452 seconds, 28.4 MB/s
> 
> real	5m3.100s
> user	0m0.021s
> sys	0m40.521s
> 
> # hdparm -tT /dev/sdb
> 
> /dev/sdb:
>  Timing cached reads:   4520 MB in  2.00 seconds = 2264.99 MB/sec
>  Timing buffered disk reads:  212 MB in  3.03 seconds =  70.03 MB/sec
> 
> 
> # lspci -v
> 00:00.0 Host bridge: Intel Corporation 955X Memory Controller Hub
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, fast devsel, latency 0
>         Capabilities: [e0] #09 [2109]
> 
> 00:01.0 PCI bridge: Intel Corporation 955X PCI Express Graphics Port (prog-if 
> 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         Memory behind bridge: 90000000-91ffffff
>         Prefetchable memory behind bridge: 0000000080000000-000000008ff00000
>         Capabilities: [88] #0d [0000]
>         Capabilities: [80] Power Management version 2
>         Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 
> Enable-
>         Capabilities: [a0] #10 [0141]
> 
> 00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition 
> Audio Controller (rev 01)
>         Subsystem: Intel Corporation: Unknown device 0013
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         Memory at 92200000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 
> Enable-
>         Capabilities: [70] #10 [0091]
> 
> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 
> (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         Memory behind bridge: 92300000-923fffff
>         Capabilities: [40] #10 [0141]
>         Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
> Enable-
>         Capabilities: [90] #0d [0000]
>         Capabilities: [a0] Power Management version 2
> 
> 00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express 
> Port 5 (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>         Memory behind bridge: 92400000-924fffff
>         Capabilities: [40] #10 [0141]
>         Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
> Enable-
>         Capabilities: [90] #0d [0000]
>         Capabilities: [a0] Power Management version 2
> 
> 00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express 
> Port 6 (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>         I/O behind bridge: 00002000-00002fff
>         Memory behind bridge: 92100000-921fffff
>         Capabilities: [40] #10 [0141]
>         Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
> Enable-
>         Capabilities: [90] #0d [0000]
>         Capabilities: [a0] Power Management version 2
> 
> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 
> (rev 01) (prog-if 00 [UHCI])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 0, IRQ 21
>         I/O ports at 3080 [size=32]
> 
> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 
> (rev 01) (prog-if 00 [UHCI])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 0, IRQ 20
>         I/O ports at 3060 [size=32]
> 
> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 
> (rev 01) (prog-if 00 [UHCI])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 0, IRQ 18
>         I/O ports at 3040 [size=32]
> 
> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 
> (rev 01) (prog-if 00 [UHCI])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 0, IRQ 16
>         I/O ports at 3020 [size=32]
> 
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
> Controller (rev 01) (prog-if 20 [EHCI])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 0, IRQ 21
>         Memory at 92204400 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] #0a [20a0]
> 
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if 01 
> [Subtractive decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
>         I/O behind bridge: 00001000-00001fff
>         Memory behind bridge: 92000000-920fffff
>         Prefetchable memory behind bridge: 0000000092500000-0000000092500000
>         Capabilities: [50] #0d [0000]
> 
> 00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface 
> Bridge (rev 01)
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 0
>         Capabilities: [e0] #09 [100c]
> 
> 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller 
> (rev 01) (prog-if 8a [Master SecP PriP])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 0, IRQ 18
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at 30b0 [size=16]
> 
> 00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial 
> ATA Storage Controllers cc=IDE (rev 01) (prog-if 8f [Master SecP SecO PriP 
> PriO])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 20
>         I/O ports at 30c8 [size=8]
>         I/O ports at 30e4 [size=4]
>         I/O ports at 30c0 [size=8]
>         I/O ports at 30e0 [size=4]
>         I/O ports at 30a0 [size=16]
>         Memory at 92204000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [70] Power Management version 2
> 
> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 
> 01)
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: medium devsel, IRQ 9
>         I/O ports at 3000 [size=32]
> 
> 01:00.0 VGA compatible controller: nVidia Corporation GeForce 6200 
> TurboCache(TM) (rev a1) (prog-if 00 [VGA])
>         Subsystem: nVidia Corporation: Unknown device 025d
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at 91000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at 80000000 (64-bit, prefetchable) [size=256M]
>         Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
>         Capabilities: [60] Power Management version 2
>         Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 
> Enable-
>         Capabilities: [78] #10 [0001]
> 
> 04:00.0 Ethernet controller: Intel Corporation 82573V Gigabit Ethernet 
> Controller (Copper) (rev 03)
>         Subsystem: Intel Corporation: Unknown device 3083
>         Flags: bus master, fast devsel, latency 0, IRQ 17
>         Memory at 92100000 (32-bit, non-prefetchable) [size=128K]
>         I/O ports at 2000 [size=32]
>         Capabilities: [c8] Power Management version 2
>         Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 
> Enable-
>         Capabilities: [e0] #10 [0001]
> 
> 05:00.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
>         Subsystem: Creative Labs SB Audigy 2 ZS (SB0350)
>         Flags: bus master, medium devsel, latency 32, IRQ 22
>         I/O ports at 1100 [size=64]
>         Capabilities: [dc] Power Management version 2
> 
> 05:00.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
> 04)
>         Subsystem: Creative Labs SB Audigy MIDI/Game Port
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at 1180 [size=8]
>         Capabilities: [dc] Power Management version 2
> 
> 05:00.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) 
> (prog-if 10 [OHCI])
>         Subsystem: Creative Labs SB Audigy FireWire Port
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         Memory at 92008800 (32-bit, non-prefetchable) [size=2K]
>         Memory at 92004000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
> 
> 05:01.0 RAID bus controller: Silicon Image, Inc. PCI0680 Ultra ATA-133 Host 
> Controller (rev 02)
>         Subsystem: Silicon Image, Inc. Winic W-680 (Silicon Image 680 based)
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         I/O ports at 1178 [size=8]
>         I/O ports at 1194 [size=4]
>         I/O ports at 1170 [size=8]
>         I/O ports at 1190 [size=4]
>         I/O ports at 1150 [size=16]
>         Memory at 92009500 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at fff80000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 2
> 
> 05:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Flags: bus master, medium devsel, latency 32, IRQ 18
>         I/O ports at 1000 [size=256]
>         Memory at 92009400 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at 92580000 [disabled] [size=64K]
>         Capabilities: [50] Power Management version 2
> 
> 05:04.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer 
> Controller (rev 01) (prog-if 10 [OHCI])
>         Subsystem: Intel Corporation: Unknown device 4b42
>         Flags: bus master, medium devsel, latency 32, IRQ 18
>         Memory at 92008000 (32-bit, non-prefetchable) [size=2K]
>         Memory at 92000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
> 
> 05:05.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] 
> Serial ATA Controller (rev 02)
>         Subsystem: Intel Corporation: Unknown device 7114
>         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 17
>         I/O ports at 1168 [size=8]
>         I/O ports at 118c [size=4]
>         I/O ports at 1160 [size=8]
>         I/O ports at 1188 [size=4]
>         I/O ports at 1140 [size=16]
>         Memory at 92009000 (32-bit, non-prefetchable) [size=1K]
>         Expansion ROM at 92500000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 2
> 
> 
> ---
> regards,
> Andreas


