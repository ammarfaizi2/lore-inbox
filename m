Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132005AbQLQJXD>; Sun, 17 Dec 2000 04:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbQLQJWx>; Sun, 17 Dec 2000 04:22:53 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:35473 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132005AbQLQJWo>; Sun, 17 Dec 2000 04:22:44 -0500
Date: Sun, 17 Dec 2000 00:52:59 -0800 (PST)
From: Drew Hess <dhess@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i850 support
Message-ID: <Pine.GSO.4.21.0012170028520.6727-100000@Xenon.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

This small patch to linux-2.4.0-test12 adds the Intel i850 chipset MCH and
AGP IDs to pci.ids so that they can be properly identified by the kernel.

It also contains an experimental patch to drivers/pci/quirks.c that forces
standby mode for pool C RDRAM devices.  I've seen some benchmarks
comparing the Intel D850GB motherboard to the ASUS P4T and attributing the
better performance of the P4T to the fact that Intel's BIOS puts pool C
RDRAM in nap mode and has no option to change it, whereas the P4T does.  
On my D850GB, the patch doesn't seem to change the performance of STREAM
one way or the other; but when I change the value written into the RDST
register to set nap mode and shrink the A and B pools to 1 device each, I
see about a 20-30MB/s drop-off on STREAM, so I'm pretty sure the code does
what it's supposed to.

This code isn't strictly a 'quirk' in the sense that some of the bug
workarounds in drivers/pci/quirks.c are, but I didn't see a more
appropriate place to put it.  Suggestions are welcome.

Anyway, if those of you with i850 boards could try this out and email back
to me a) what make of board you have, b) the output of the printk message
that reports the value of RDST as set by the BIOS, and c) whether you see
any performance difference on STREAM before and after applying the patch,
that would be great.

You can get a pre-compiled STREAM binary from here:

ftp://ftp.cs.virginia.edu/pub/stream/Contrib/MasonCabot/linux/stream_l

thanks!

-dwh-

p.s. I've also mailed a patch for i850 agpgart support to the DRM
maintainers, so hopefully that will be showing up soon, too.


diff -u -r linux-2.4.0-test12/drivers/pci/pci.ids linux/drivers/pci/pci.ids
--- linux-2.4.0-test12/drivers/pci/pci.ids	Sat Dec 16 18:33:27 2000
+++ linux/drivers/pci/pci.ids	Sat Dec 16 20:57:45 2000
@@ -4598,6 +4598,8 @@
 	250f  82820 820 (Camino) Chipset PCI to AGP Bridge
 	2520  82805AA MTH Memory Translator Hub
 	2521  82804AA MRH-S Memory Repeater Hub for SDRAM
+	2530  82850 850 (Tehama) Chipset Host Bridge (MCH)
+	2532  82850 850 (Tehama) Chipset AGP Bridge
 	5200  EtherExpress PRO/100
 	5201  EtherExpress PRO/100
 		8086 0001  EtherExpress PRO/100 Server Ethernet Adapter
diff -u -r linux-2.4.0-test12/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux-2.4.0-test12/drivers/pci/quirks.c	Thu Oct 26 14:23:53 2000
+++ linux/drivers/pci/quirks.c	Sat Dec 16 23:41:37 2000
@@ -235,6 +235,40 @@
 }
 
 /*
+ * The BIOS on some Intel i850 motherboards (notably the D850GB) 
+ * may configure pool C RDRAM devices to run in nap mode due to thermal 
+ * concerns. We set up pool C to run in standby mode for better
+ * performance and set pools A and B to their max sizes.  Then we
+ * write (but don't commit) a "safe" value in case an over-temperature
+ * condition occurs.
+ */
+static void __init quirk_tehama(struct pci_dev *dev)
+{
+	u8 rdps;
+
+	printk(KERN_INFO "i850: Configuring pool C RDRAM devices to run in standby mode\n");
+	pci_read_config_byte(dev, 0x88, &rdps);
+	printk(KERN_INFO "i850: BIOS set RDPS to 0x%02x\n", rdps);
+
+	/* 
+	 * i850 docs are unclear about how to unlock/set RDPS and
+	 * then initialize the pool logic, so do it one step at a time.
+	 * Wait for poolinit bit to clear for indication that pools
+	 * are running in new mode.
+	 */
+	pci_write_config_byte(dev, 0x88, 0x0);
+	pci_write_config_byte(dev, 0x88, 0x0f);
+	pci_write_config_byte(dev, 0x88, 0x2f);
+	do {
+		pci_read_config_byte(dev, 0x88, &rdps);
+	}
+	while (rdps & 0x20);
+
+	/* prep for nap mode in case of over-temperature condition */
+	pci_write_config_byte(dev, 0x88, 0x19);
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -269,6 +303,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_MC1,	quirk_tehama },
 	{ 0 }
 };
 
diff -u -r linux-2.4.0-test12/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.4.0-test12/include/linux/pci_ids.h	Sat Dec 16 18:33:35 2000
+++ linux/include/linux/pci_ids.h	Sat Dec 16 21:10:47 2000
@@ -1378,6 +1378,7 @@
 #define PCI_DEVICE_ID_INTEL_82820FW_4	0x2449
 #define PCI_DEVICE_ID_INTEL_82820FW_5	0x244b
 #define PCI_DEVICE_ID_INTEL_82820FW_6	0x244e
+#define PCI_DEVICE_ID_INTEL_82850_MC1	0x2530
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
