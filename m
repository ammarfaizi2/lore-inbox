Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265770AbSKYWbI>; Mon, 25 Nov 2002 17:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSKYWbI>; Mon, 25 Nov 2002 17:31:08 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:458 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265770AbSKYWbF>; Mon, 25 Nov 2002 17:31:05 -0500
Subject: [RFC] [PATCH] quirks.c
From: Emmanuel Fuste <e.fuste@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1038264914.904.63.camel@rafale.worldnet.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Nov 2002 23:55:15 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is this patch acceptable?
Marcello, Alan, do you think this patch could be included is 2.4.x or
-ac kernel ?

Regards,

Emmanuel.

--------Original message---------------
Ok,

Since I've got no solutions, I took Intel specs and start some hacks.

I found many problems in my bios:

First there is an options about DRam comfig which should not normally be
accessible in your bios : Turbo Read Leadoff.
If you have this option in your bios on a 439HX mother board, YOU SHOULD
DISABLE IT!
It is only valid to enable it with L2 cache disable.... Otherwise you
machine go crazy like mine.
Now performance are ... well ... like jumping from a 8086 to a 386...

Second problem: my bios is buggy in regards to the DRam ECC config.
Before I upgrade my computer with more ram, I've got only ECC ram.
I replace all with non ECC EDO Ram without modifying my bios config.
At boot, the bios detect non ECC ram and switch to integrity check mode.
But in that case not all the chipset config bits gets right....
Switching the conf in the bios solve that.

Now, my machine is fast, pci errors are more difficult to trigger but
still here.
The errors occurred more frequently when there is some dma stress on the
isa bus (old isa awe32 with full duplex operations with alsa and
gnomemeeting or linphone). So I started to check the PIIX3 pci conf
bits.
First, according to Intel errata, the dma hang bug is not present on B0
stepping of the chip. So the first part of the patch test this.
Next, to be in full PCI 2.1 compliant mode:
 - passive release and delayed transactions should be enable on PIIX3.
 - NBRE bit could now be enable.
 - So we could turn on extended pci signaling in the host bridge
All is now PCI 2.1 compliant.
This is the second part of the patch.

Ok, now if you look at it, you will see that delayed transaction is
unconditionally enable with all stepping of the chip, which should
trigger the Isa dma bug on previous revisions. But looking at the
workaround, it seems that linux use another strategy to work around the
bug and not need to have the delayed transaction disable.

So, after some tests with good results (no more pci errors), I swap my
2940uw with my long awaited 2940u2w.

00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)
00:01.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:01.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:01.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
00:09.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II]
00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 (rev 01)
00:0d.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 02)

Yes, now all work like a charm !!!

My apologies to Justin to have suspected his driver !

Could this patch be applied to 2.4.x (generated against 2.4.20-rc1)and
2.5 ?
In my case, this is not PCI performance tweak, my machine wont boot with
a 2940u2w without it.

Emmanuel.

Ps: I remove a duplicate line too.


--- linux-2.4.20-rc1/drivers/pci/quirks.c	2002-11-21 23:06:15.000000000 +0100
+++ linux-2.4.20-rc1-manu/drivers/pci/quirks.c	2002-11-21 22:55:45.000000000 +0100
@@ -52,12 +52,50 @@
     
 static void __init quirk_isa_dma_hangs(struct pci_dev *dev)
 {
+	u8 rev;
+	
+	if ((dev->vendor==PCI_VENDOR_ID_INTEL)
+	    && (dev->device==PCI_DEVICE_ID_INTEL_82371SB_0)) {
+		pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+		if (rev == 0x01) {
+			printk(KERN_INFO "PIIX3 rev B0: ISA DMA hang workarounds not need.\n");
+			return;
+		}
+	}
+
 	if (!isa_dma_bridge_buggy) {
 		isa_dma_bridge_buggy=1;
 		printk(KERN_INFO "Activating ISA DMA hang workarounds.\n");
 	}
 }
 
+/*  Somme BIOS seems to not turn on all PCI v2.1 compliant options on 82439HX/PIIX3.
+ *  PCI data corruption appear under ISA DMA load and somme PCI devices like AHA-2940U2/W
+ *  are completely unusable.
+ */
+
+static void __init quirk_txc_pci(struct pci_dev *dev)
+{
+	struct pci_dev *p;
+	u8 val;
+
+	p=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, NULL);
+	if (p != NULL) {
+		pci_read_config_byte(p, 0x82, &val);
+		val |= 0x07;
+		pci_write_config_byte(p, 0x82, val);
+		printk(KERN_INFO "PIIX3: Enabling ISA and USB passive release and delayed transaction.\n");
+		pci_read_config_byte(p, 0x6a, &val);
+		val |= 0x80;
+		pci_write_config_byte(p, 0x6a, val);
+		printk(KERN_INFO "PIIX3: Enabling north bridge retry enable bit.\n");
+		pci_read_config_byte(dev, 0x4f, &val);
+		val |= 0x80;
+		pci_write_config_byte(dev, 0x4f, val);
+		printk(KERN_INFO "82439HX: Enabling north bridge delayed transaction.\n");
+	}
+}
+
 int pci_pci_problems;
 
 /*
@@ -501,7 +539,6 @@
 static struct pci_fixup pci_fixups[] __initdata = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
 	/*
 	 * Its not totally clear which chipsets are the problematic ones
 	 * We know 82C586 and 82C596 variants are affected.
@@ -514,6 +551,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437VX, 	quirk_triton }, 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439, 	quirk_triton }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439, 	quirk_txc_pci }, 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439TX, 	quirk_triton }, 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82441, 	quirk_natoma }, 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443LX_0, 	quirk_natoma }, 



