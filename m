Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbQLEMmI>; Tue, 5 Dec 2000 07:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130530AbQLEMl5>; Tue, 5 Dec 2000 07:41:57 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:44006 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S129878AbQLEMlx>; Tue, 5 Dec 2000 07:41:53 -0500
Date: Tue, 5 Dec 2000 13:11:19 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Peter Samuelson <peter@cadcamlab.org>
cc: adam@yggdrasil.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ymfpci.c MODULE_DEVICE_TABLE
In-Reply-To: <14892.38320.194351.163997@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.10.10012051249170.2608-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Peter Samuelson wrote:

> Adam, could you check my work here?  I haven't done this before....  It
> compiles, but I don't have the hardware to verify anything.  And, being
> a lousy kernel hacker, I've probably introduced at least one bug.

The driver works here. I had forward ported ymfpci myself before, and I
didn't work. Now Linus' version didn't work either, so I decided to
investigate a little further.

For 2.2 I need to disable PnP OS in the BIOS, for 2.4 I had it enabled.
That apparently made the difference, the driver works only when PnP OS is
disabled (2.2 and 2.4).

Your patch works fine here, didn't make a difference, though (of course).

I noticed that pci_enable_device isn't called, so I added the following
(proposed for inclusion)

--- linux-2.4.0-test12-pre5.compile/drivers/sound/ymfpci.c~	Tue Dec  5 11:18:50 2000
+++ linux-2.4.0-test12-pre5.compile/drivers/sound/ymfpci.c	Tue Dec  5 11:21:38 2000
@@ -2256,6 +2256,10 @@
 
 	int err;
 
+	if (pci_enable_device(pcidev) < 0) {
+		printk(KERN_ERR "ymfpci: pci_enable_device failed\n");
+		return -ENODEV;
+	}
 	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "ymfpci: no core\n");
 		return -ENOMEM;

However, that didn't help either.
Driver load messages:

PCI: Enabling device 00:09.0 (0006 -> 0007)
ymfpci0: YMF744 at 0xfecf0000 IRQ 9
ac97_codec: AC97 Audio codec, id: 0x414b:0x4d02 (Unknown)

The IO regions really get enabled:

(diff lspci -vx before / after loading)

--- /root/lspci.0	Tue Dec  5 12:30:19 2000
+++ /root/lspci.1	Tue Dec  5 12:32:03 2000
@@ -63,12 +63,12 @@
 00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
 	Subsystem: Sony Corporation: Unknown device 8081
 	Flags: bus master, medium devsel, latency 64, IRQ 9
 	Memory at fecf0000 (32-bit, non-prefetchable) [size=32K]
-	I/O ports at fc00 [disabled] [size=64]
-	I/O ports at fcac [disabled] [size=4]
+	I/O ports at fc00 [size=64]
+	I/O ports at fcac [size=4]
 	Capabilities: [50] Power Management version 1
-00: 73 10 10 00 06 00 10 02 02 00 01 04 00 40 00 00
+00: 73 10 10 00 07 00 10 02 02 00 01 04 00 40 00 00
 10: 00 00 cf fe 01 fc 00 00 ad fc 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 81 80
 30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 05 19
 
but it doesn't really help, sound just doesn't work properly (it starts
out okay, but then it starts skipping after a second or so and eventually
it totally stops).

For comparison, lspci -vx output when booted with Pnp OS = no (-> sound
works properly):

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
	Subsystem: Sony Corporation: Unknown device 8081
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at fedf8000 (32-bit, non-prefetchable) [size=32K]
	I/O ports at fcc0 [size=64]
	I/O ports at fc8c [size=4]
	Capabilities: [50] Power Management version 1
00: 73 10 10 00 07 00 10 02 02 00 01 04 00 40 00 00
10: 00 80 df fe c1 fc 00 00 8d fc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 81 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 05 19

Any idea why this setup works but the previous one doesn't? But maybe the
BIOS initializes the sound chip differently depending on the selection of
PnP OS...

BTW, this is also a Sony notebook (PCG-Z600NE), not a Transmeta one,
though :-(

Talking about it, there's also yet another problem with this notebook. The
A20 patch by hpa in test12-pre broke resume from suspend/hibernation - the
notebook just silently reboots after a resume - any idea why that would
be? (The back-out patch I'm using is available on request)

--Kai

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
