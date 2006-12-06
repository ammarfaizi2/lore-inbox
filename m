Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760492AbWLFLOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760492AbWLFLOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 06:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760472AbWLFLOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 06:14:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:62706 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760492AbWLFLOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 06:14:37 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives
Date: Wed, 6 Dec 2006 12:11:38 +0100
User-Agent: KMail/1.9.5
References: <4570CF26.8070800@scientia.net> <20061203011737.GA2729@us.ibm.com>
In-Reply-To: <20061203011737.GA2729@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612061211.38892.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 3. Dezember 2006 02:17 schrieb Kurtis D. Rader:
> On Sat, 2006-12-02 01:56:06, Christoph Anton Mitterer wrote:
> > The issue was basically the following: I found a severe bug mainly by
> > fortune because it occurs very rarely.  My test looks like the following:
> > I have about 30GB of testing data on my harddisk,... I repeat verifying
> > sha512 sums on these files and check if errors occur.  One test pass
> > verifies the 30GB 50 times,... about one to four differences are found in
> > each pass.
>
> I'm also experiencing silent data corruption on writes to SATA disks
> connected to a Nvidia controller (nForce 4 chipset). The problem is
> 100% reproducible. Details of my configuration (mainboard model, lspci,
> etc.) are near the bottom of this message. What follows is a summation
> of my findings.
>
> I have confirmed the corruption is occurring on the writes and not the
> reads. Furthermore, if I compare the original and copy while both are
> still cached in memory no corruption is found. But as soon as I flush the
> pagecache (by reading another file larger than memory) to force the copy
> of the file to be read from disk the corruption is seen. The corruption
> occurs with direct I/O and normal buffered filesystem I/O (ext3).
>
> Booting with "mem=1g" (system has 4 GiB installed) makes no difference.
> So it isn't due to remapping memory above the 4 GiB boundary.  Booting to
> single user and ensuring no unnecessary modules (video, etc.) are loaded
> also makes no difference.
>
> The problem affects both disks attached to the nVidia SATA controller but
> not the two disks attached to the PATA side of the same controller. All
> four disks are different models. The same SATA disks attached to
> the Silicon Image 3114 SATA RAID controller (on the same mainboard)
> experiences the same corruption but at a lower probability.  The same
> disks attached to a Promise TX2 SATA controller (in the same system)
> experience no corruption.
>
> The system has run memtest86 for 24 hours with no errors.
>
> The corruption occurs with a 32-bit kernel.org 2.6.12 kernel (from a
> Knoppix CD), 64-bit kernel.org 2.6.18.1, and 64-bit kernel.org 2.6.19.
>
> The only pattern I can discern is that the corruption only affects the
> second four byte block of a sixteen byte aligned region. That is, the
> offset of the corrupted bytes always falls in the range 0x...4 to 0x...7.
> For example, here are a few representative offsets of corrupted bytes
> from one test of many:
>
>     0x020f4554
>     0x020f4555
>     0x020f4556
>     0x020f4557
>     0x020f4555
>     0x1597f1d4
>     0x23034ee5
>     0x2dfd08d4
>     0x33690b14
>     0x33690b15
>     0x33690b16
>     0x33690b17
>
> Approximately half the corruption involves all four bytes of the second
> four byte word of the 16 by aligned region. The remaining instances show
> one, two or three bytes being corrupted. There is no pattern that I can
> discern to the corruption. It is definitely not anything as simple as the
> correct bytes being replaced with zeros or specific bits being forced to
> a zero or one state or flipped.  Copying a 2 GiB file typically results
> in between five and thirty bytes being corrupted. Back to back tests
> copying the same file results in different bytes being corrupted.
>
> The problem appears to be sensitive to the data pattern. Some files can be
> copied repeatedly without corruption. But others will exhibit corruption
> 100% of the time when attached to the nVidia SATA controller and over 50%
> of the time when connected to the Sil 3114 controller.
>
> I have tried direct I/O with varying transfer sizes from 1 KiB to 128 KiB
> (I have not tried single sector I/O).  Corruption occurs with all block
> sizes. If I execute an I/O loop like this the corruption does not appear
> to occur:
>
>     while direct read 64 KiB original
>         direct write copy
>         direct read + verify copy
>     done
>
> But that is tentative as I've only done two such tests at this time.
>
> A coworker has hypothesized that this may be a consequence of bus
> crosstalk. That it doesn't happen when using the Promise TX2 controller
> suggests that if it is a HW bus problem it isn't a hypertransport or
> memory bus problem.
>
> Configuration Details
> =====================
> Mainboard: ASUS A8N-SLI Deluxe with nForce 4 chipset
> BIOS:      1016 (original) and 1805 (upgraded to in attempt to resolve)
> CPU:       AMD Athlon 64 X2 Dual Core Processor 4400+ stepping 02
> Memory:    4 x 1 GiB Kingston matched pairs lifetime warranty
> Kernel:    2.6.19 kernel.org (as well as others)
> Disks:     Western Digital WD740GD-00FL (10000 rpm "Raptor" disk)
>            Western Digital WD1600JD-32H (7200 rpm)
>
> 00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev
> a3) Subsystem: ASUSTeK Computer Inc. Unknown device 815a
> 	Flags: bus master, 66MHz, fast devsel, latency 0
> 	Capabilities: [44] HyperTransport: Slave or Primary Interface
> 	Capabilities: [e0] HyperTransport: MSI Mapping
>
> 00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev f3)
> 	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
> 	Flags: bus master, 66MHz, fast devsel, latency 0
>
> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
> 	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
> 	Flags: 66MHz, fast devsel, IRQ 3
> 	I/O ports at e000 [size=32]
> 	I/O ports at 4c00 [size=64]
> 	I/O ports at 4c40 [size=64]
> 	Capabilities: [44] Power Management version 2
>
> 00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
> (prog-if 10 [OHCI]) Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
> 	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
> 	Memory at d4003000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
>
> 00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
> (prog-if 20 [EHCI]) Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
> 	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 7
> 	Memory at feb00000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [44] Debug port
> 	Capabilities: [80] Power Management version 2
>
> 00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio
> Controller (rev a2) Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
> 	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
> 	I/O ports at d800 [size=256]
> 	I/O ports at dc00 [size=256]
> 	Memory at d4002000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
>
> 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a
> [Master SecP PriP]) Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
> 	Flags: bus master, 66MHz, fast devsel, latency 0
> 	I/O ports at f000 [size=16]
> 	Capabilities: [44] Power Management version 2
>
> 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev
> f3) (prog-if 85 [Master SecO PriO]) Subsystem: ASUSTeK Computer Inc.
> Unknown device 815a
> 	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
> 	I/O ports at 09f0 [size=8]
> 	I/O ports at 0bf0 [size=4]
> 	I/O ports at 0970 [size=8]
> 	I/O ports at 0b70 [size=4]
> 	I/O ports at d400 [size=16]
> 	Memory at d4001000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
>
> 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev
> f3) (prog-if 85 [Master SecO PriO]) Subsystem: ASUSTeK Computer Inc. K8N4-E
> Mainboard
> 	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
> 	I/O ports at 09e0 [size=8]
> 	I/O ports at 0be0 [size=4]
> 	I/O ports at 0960 [size=8]
> 	I/O ports at 0b60 [size=4]
> 	I/O ports at c000 [size=16]
> 	Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Power Management version 2
>
> 00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev f2) (prog-if
> 01 [Subtractive decode]) Flags: bus master, 66MHz, fast devsel, latency 0
> 	Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
> 	I/O behind bridge: 00007000-00009fff
> 	Memory behind bridge: d2000000-d3ffffff
> 	Prefetchable memory behind bridge: d4100000-d42fffff
>
> 00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev f3) (prog-if
> 00 [Normal decode]) Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
> 	Capabilities: [40] Power Management version 2
> 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
> 	Capabilities: [58] HyperTransport: MSI Mapping
> 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
> 	Capabilities: [100] Virtual Channel
>
> 00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev f3) (prog-if
> 00 [Normal decode]) Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> 	Capabilities: [40] Power Management version 2
> 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
> 	Capabilities: [58] HyperTransport: MSI Mapping
> 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
> 	Capabilities: [100] Virtual Channel
>
> 00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev f3) (prog-if
> 00 [Normal decode]) Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	Capabilities: [40] Power Management version 2
> 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
> 	Capabilities: [58] HyperTransport: MSI Mapping
> 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
> 	Capabilities: [100] Virtual Channel
>
> 00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if
> 00 [Normal decode]) Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000a000-0000afff
> 	Memory behind bridge: d0000000-d1ffffff
> 	Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
> 	Capabilities: [40] Power Management version 2
> 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
> 	Capabilities: [58] HyperTransport: MSI Mapping
> 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
> 	Capabilities: [100] Virtual Channel
>
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration Flags: fast devsel
> 	Capabilities: [80] HyperTransport: Host or Secondary Interface
>
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map Flags: fast devsel
>
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller Flags: fast devsel
>
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control Flags: fast devsel
>
> 01:00.0 VGA compatible controller: ATI Technologies Inc RV530 [Radeon
> X1600] (prog-if 00 [VGA]) Subsystem: VISIONTEK Unknown device 1890
> 	Flags: bus master, fast devsel, latency 0, IRQ 3
> 	Memory at c0000000 (64-bit, prefetchable) [size=256M]
> 	Memory at d1000000 (64-bit, non-prefetchable) [size=64K]
> 	I/O ports at a000 [size=256]
> 	Expansion ROM at d0000000 [disabled] [size=128K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] Express Endpoint IRQ 0
> 	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>
> 01:00.1 Display controller: ATI Technologies Inc RV530 [Radeon X1600]
> (Secondary) Subsystem: VISIONTEK Unknown device 1891
> 	Flags: fast devsel
> 	Memory at d1010000 (64-bit, non-prefetchable) [disabled] [size=64K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] Express Endpoint IRQ 0
>
> 05:07.0 Mass storage controller: Promise Technology, Inc. PDC20375 (SATA150
> TX2plus) (rev 02) Subsystem: Promise Technology, Inc. PDC20375 (SATA150
> TX2plus)
> 	Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 5
> 	I/O ports at 7000 [size=64]
> 	I/O ports at 7400 [size=16]
> 	I/O ports at 7800 [size=128]
> 	Memory at d3124000 (32-bit, non-prefetchable) [size=4K]
> 	Memory at d3100000 (32-bit, non-prefetchable) [size=128K]
> 	Expansion ROM at d4280000 [disabled] [size=16K]
> 	Capabilities: [60] Power Management version 2
>
> 05:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100]
> (rev 08) Subsystem: IBM Netfinity 10/100
> 	Flags: bus master, medium devsel, latency 32, IRQ 3
> 	Memory at d3127000 (32-bit, non-prefetchable) [size=4K]
> 	I/O ports at 7c00 [size=64]
> 	Memory at d3000000 (32-bit, non-prefetchable) [size=1M]
> 	Expansion ROM at d4100000 [disabled] [size=1M]
> 	Capabilities: [dc] Power Management version 2
>
> 05:0a.0 RAID bus controller: Silicon Image, Inc. SiI 3114
> [SATALink/SATARaid] Serial ATA Controller (rev 02) Subsystem: ASUSTeK
> Computer Inc. Unknown device 8167
> 	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 7
> 	I/O ports at 8000 [size=8]
> 	I/O ports at 8400 [size=4]
> 	I/O ports at 8800 [size=8]
> 	I/O ports at 8c00 [size=4]
> 	I/O ports at 9000 [size=16]
> 	Memory at d3125000 (32-bit, non-prefetchable) [size=1K]
> 	Expansion ROM at d4200000 [disabled] [size=512K]
> 	Capabilities: [60] Power Management version 2
>
> 05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000
> Controller (PHY/Link) (prog-if 10 [OHCI]) Subsystem: ASUSTeK Computer Inc.
> K8N4-E Mainboard
> 	Flags: bus master, medium devsel, latency 32, IRQ 3
> 	Memory at d3126000 (32-bit, non-prefetchable) [size=2K]
> 	Memory at d3120000 (32-bit, non-prefetchable) [size=16K]
> 	Capabilities: [44] Power Management version 2

Hello lkml,

I also have an nForce4 based mainboard and tried hard to reproduce your 
testcase but I found no errors so far!

Asus A8N-SLI Deluxe (nForce4)
AMD Athlon 64x2 3800 (overclocked)
2x Samsung SpinPoint 250GB (SATA2)
1x Samsung SpinPoint 400GB (SATA2)
2GB DDR1-Ram

Linux 2.6.19-rc6-mm1 #2 SMP PREEMPT Thu Nov 23 15:34:58 CET 2006 x86_64 
GNU/Linux

Filesystem is XFS on LVM on dmraid (nForce4 fakeraid)

I copied a massive amount of data (more than 500GB) several times between the 
HDDs and ran md5sum each time, but it found no errors.

Maybe it's a temperature problem? I found my board to be very vulnerable to 
higher temperatures. If the nForce4 chipset reaches a temp. over 42°C it 
tends to malfunction. First symptoms I've had was that USB ceased to work 
then came SATA hangs and finally a kernel panic or bluescreen on Windows.

lspci
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio 
Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Controller 
(rev f3)
00:08.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Controller 
(rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce 7600 GT] 
(rev a1)
05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 
Controller (PHY/Link)
05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit 
Ethernet Controller (rev 13)

-Christian
