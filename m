Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271237AbRHTOaS>; Mon, 20 Aug 2001 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271214AbRHTOaJ>; Mon, 20 Aug 2001 10:30:09 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:5127 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271241AbRHTO3u>;
	Mon, 20 Aug 2001 10:29:50 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
Date: 20 Aug 2001 14:17:58 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9o270m.rg.kraxel@bytesex.org>
In-Reply-To: <Pine.LNX.4.21.0107171610120.31029-100000@cobalt.deepthought.org> from "Martin Murray" at Jul 18, 1 00:45:20 am <200107211335.RAA13657@ms2.inr.ac.ru>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 998317078 943 127.0.0.1 (20 Aug 2001 14:17:58 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Seems, you are right, yenta.c corrupts something in hardware
>  and the problem is not related to irqs.

It is not IRQ-related at all.

>  Observations are:
>  
>  * No irqs are generated at all after lockup. Printk added at do_IRQ, no activity.
>    (Moreover, here yenta irq is not shared with vga, but shared with firewire
>     port though.) Nothing. I did not find any software activity at all.
>  * No activity at pcmcia is required to lockup. Loading yenta_socket is enough.
>  * Unloading yenta before lockup happened does not help, i.e. something
>    is corrupted at time of yenta_init().
>  * Lockup _inevitably_ happens when yenta_init was executed once
>    and I make any operation from set:
>    1. any call to APM bios, except for cpu idle.
>    2. Pressing any hotkey, including change of LCD brightness
>       (Sic! The last event is _absolutely_ invisible to software,
>        so that yenta_init does something terrible with hardware).

Same problem here.  I've spend some time today to figure what is going
on.  Workaround:

---------------------------- cut here -----------------------------
--- 2.4.9/drivers/pcmcia/yenta.c.fix	Mon Aug 20 11:02:23 2001
+++ 2.4.9/drivers/pcmcia/yenta.c	Mon Aug 20 14:21:33 2001
@@ -729,7 +729,7 @@
 	if (type & IORESOURCE_IO) {
 		align = 1024;
 		size = 256;
-		min = PCIBIOS_MIN_IO;
+		min = 0x4000 /* PCIBIOS_MIN_IO */;
 		max = 0xffff;
 	}
 		
---------------------------- cut here -----------------------------

Looks like a ressource conflict to me.  The kernel gives I/O ranges to
the cardbus socket which it thinks are free but which are *not* free for
some reason (and probably used for APM stuff).  BIOS bug?  PCI quirks
time?

/proc/ioports looks like this (with patch):

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : nsc-ircc
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1100-110f : Intel Corporation 82440MX EIDE Controller
  1100-1107 : ide0
1200-121f : Intel Corporation 82440MX USB Universal Host Controller
  1200-121f : usb-uhci
1500-153f : Intel Corporation 82440MX AC'97 Audio Controller
  1500-153f : Intel 440MX
1600-16ff : Intel Corporation 82440MX AC'97 Audio Controller
  1600-16ff : Intel 440MX
1700-177f : PCI device 8086:7196 (Intel Corporation)
1800-18ff : PCI device 8086:7196 (Intel Corporation)
3000-30ff : ATI Technologies Inc 3D Rage P/M Mobility
3e00-3eff : Realtek Semiconductor Co., Ltd. RTL-8139
  3e00-3eff : 8139too
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01

lspci says:

00:00.0 Host bridge: Intel Corporation 82440MX I/O Controller (rev 01)
	Subsystem: Mitac: Unknown device 7722
	Flags: bus master, medium devsel, latency 64

00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97 Audio Controller
	Subsystem: Mitac: Unknown device 7722
	Flags: bus master, fast devsel, latency 0, IRQ 5
	I/O ports at 1600 [size=256]
	I/O ports at 1500 [size=64]

00:00.2 Modem: Intel Corporation: Unknown device 7196 (prog-if 00 [Generic])
	Subsystem: Mitac: Unknown device 7722
	Flags: bus master, fast devsel, latency 0, IRQ 5
	I/O ports at 1800 [size=256]
	I/O ports at 1700 [size=128]

00:07.0 ISA bridge: Intel Corporation 82440MX PCI to ISA Bridge (rev 01)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82440MX EIDE Controller (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1100 [size=16]

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 240, IRQ 11
	I/O ports at 1200 [size=32]

00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
	Flags: medium devsel

00:08.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Mitac: Unknown device 7722
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:09.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility (rev 64) (prog-if 00 [VGA])
	Subsystem: Mitac: Unknown device 7722
	Flags: bus master, stepping, medium devsel, latency 0
	Memory at c0000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at 3000 [size=256]
	Memory at c1000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Mitac: Unknown device 7722
	Flags: bus master, medium devsel, latency 128, IRQ 11
	I/O ports at 3e00 [size=256]
	Memory at e9100000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:0b.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 02) (prog-if 10 [OHCI])
	Subsystem: Mitac: Unknown device 7722
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 1

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
