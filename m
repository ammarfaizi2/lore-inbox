Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTAJQlW>; Fri, 10 Jan 2003 11:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAJQlV>; Fri, 10 Jan 2003 11:41:21 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:4622 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S265532AbTAJQlS>;
	Fri, 10 Jan 2003 11:41:18 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.55, PCI, PCMCIA, XIRCOM]
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 10 Jan 2003 17:21:51 +0100
Message-ID: <87znq9ynz4.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



With 2.4.20 the xircom_cb driver works perfectly on my Thinkpad 600.
Loading the driver with 2.5.55 for my IBM ethernet card I get:

Jan 10 11:35:24 gswi1164 kernel: Linux Kernel Card Services 3.1.22
Jan 10 11:35:24 gswi1164 kernel:   options:  [pci] [cardbus] [pm]
Jan 10 11:35:24 gswi1164 kernel: PCI: Found IRQ 11 for device 00:02.0
Jan 10 11:35:24 gswi1164 kernel: PCI: Sharing IRQ 11 with 00:03.0
Jan 10 11:35:24 gswi1164 kernel: Module yenta_socket cannot be unloaded due to unsafe usage in include/linux/module.h:420
Jan 10 11:35:24 gswi1164 kernel: Yenta IRQ list 06b8, PCI irq11
Jan 10 11:35:24 gswi1164 kernel: Socket status: 30000020
Jan 10 11:35:24 gswi1164 kernel: PCI: Found IRQ 11 for device 00:02.1
Jan 10 11:35:24 gswi1164 kernel: Yenta IRQ list 06b0, PCI irq11
Jan 10 11:35:24 gswi1164 kernel: Socket status: 30000006
Jan 10 11:35:24 gswi1164 kernel: cs: cb_alloc(bus 1): vendor 0x115d, device 0x0003
Jan 10 11:35:24 gswi1164 kernel: PCI: Device 01:00.0 not available because of resource collisions

The message is not helpful at all.  Looking at the source in
arch/i386/pci/i386.c I find:

246 int pcibios_enable_resources(struct pci_dev *dev, int mask)
247 {
248         u16 cmd, old_cmd;
249         int idx;
250         struct resource *r;
251
252         pci_read_config_word(dev, PCI_COMMAND, &cmd);
253         old_cmd = cmd;
254         for(idx=0; idx<6; idx++) {
255                 /* Only set up the requested stuff */
256                 if (!(mask & (1<<idx)))
257                         continue;
258
259                 r = &dev->resource[idx];
260                 if (!r->start && r->end) {
261                         printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", dev->slot_name)        ;
262                         return -EINVAL;
263                 }

The following patch should provide some useful hints, why it is
failing:

--- linux-2.5.55/arch/i386/pci/i386.c.jh	2003-01-10 13:57:44.000000000 +0100
+++ linux-2.5.55/arch/i386/pci/i386.c	2003-01-10 14:39:34.000000000 +0100
@@ -258,7 +258,7 @@
 
 		r = &dev->resource[idx];
 		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", dev->slot_name);
+			printk(KERN_ERR "PCI: Device %s not available because of resource collisions (start: %08lx, end: %08lx)\n", dev->slot_name, r->start, r->end);
 			return -EINVAL;
 		}
 		if (r->flags & IORESOURCE_IO)


Now I get the message:

PCI: Device 01:00.0 not available because of resource collisions (start: 00000000, end: 0000007f) 

Looking at the reserved regions:

root@gswi1164:/usr/src# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vesafb
03e8-03ef : serial
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #01
1400-14ff : PCI CardBus #01
1800-18ff : PCI CardBus #04
1c00-1cff : PCI CardBus #04
8400-841f : Intel Corp. 82371AB/EB/MB PIIX4
  8400-841f : uhci-hcd
ef00-ef3f : Intel Corp. 82371AB/EB/MB PIIX4
efa0-efbf : Intel Corp. 82371AB/EB/MB PIIX4
fcf0-fcff : Intel Corp. 82371AB/EB/MB PIIX4
  fcf0-fcf7 : ide0
  fcf8-fcff : ide1

I don't understand, why the PCMCIA services try to claim these io
resources.  The /proc/ioports of 2.4.20 are:

root@gswi1164:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03e8-03ef : serial(set)
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #01
  4000-407f : PCI device 115d:0003
    4000-407f : xircom_cb
4400-44ff : PCI CardBus #01
4800-48ff : PCI CardBus #04
4c00-4cff : PCI CardBus #04
8400-841f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  8400-841f : usb-uhci
ef00-ef3f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
efa0-efbf : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
fcf0-fcff : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  fcf0-fcf7 : ide0
  fcf8-fcff : ide1

I don't know who is to blame, but I guess it's the xircom driver or
the pcmcia layer.  Any ideas?

Jochen

-- 
#include <~/.signature>: permission denied
