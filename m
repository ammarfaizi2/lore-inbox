Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVJYRvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVJYRvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVJYRva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:51:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932255AbVJYRva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:51:30 -0400
Date: Tue, 25 Oct 2005 10:51:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Call for PIIX4 chipset testers
Message-ID: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While trying to figure out why one of Alan's laptops didn't like certain 
resource allocations, it dawned on Ivan and me that the PIIX4 (aka 
"82371AB PCI-TO-ISA/IDE Xcelerator", aka "old venerable Intel core 
chipset") actually has a lot more PCI resources that it decodes than the 
two big special cases we had been quirking out.

It's an old chipset by now, but it was very very common, so I bet people 
still have them around. If doing /sbin/lspci on your machine mentions 
something like

	Intel Corporation 82371AB/EB/MB PIIX4 ISA

can you please test out this patch and report what it says in dmesg?

It should report a number of quirks, and the easiest way to get them all 
is to just do

	dmesg -s 1000000 | grep PIIX4

and send it to me (and you might as well cc linux-kernel too in this 
thread, so that we'll get the thing archived for later). Preferably 
together with the output of "cat /proc/ioport" and "/sbin/lspci -xxx".

The patch shouldn't actually change any allocations - right now it only 
prints out the new PCI quirks it tries to decode. And before I make the 
PCI layer actually know about these quirks, I'd want to have several 
reports about the output, just to verify that the code works. I don't 
actually have any PIIX4-based machine myself any more (the curse of 
frequent upgrades).

Thanks,

		Linus

---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a6a630a..3300dd0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -241,7 +241,8 @@ static void __devinit quirk_s3_64M(struc
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M );
 
-static void __devinit quirk_io_region(struct pci_dev *dev, unsigned region, unsigned size, int nr)
+static void __devinit quirk_io_region(struct pci_dev *dev, unsigned region,
+	unsigned size, int nr, const char *name)
 {
 	region &= ~(size-1);
 	if (region) {
@@ -259,6 +260,7 @@ static void __devinit quirk_io_region(st
 		pcibios_bus_to_resource(dev, res, &bus_region);
 
 		pci_claim_resource(dev, nr);
+		printk("PCI quirk: region %04x-%04x claimed by %s\n", region, region + size - 1, name);
 	}
 }	
 
@@ -291,25 +293,96 @@ static void __devinit quirk_ali7101_acpi
 	u16 region;
 
 	pci_read_config_word(dev, 0xE0, &region);
-	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES);
+	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES, "ali7101 ACPI");
 	pci_read_config_word(dev, 0xE2, &region);
-	quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1);
+	quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi );
 
+static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
+{
+	u32 devres;
+	u32 mask, size, base;
+
+	pci_read_config_dword(dev, port, &devres);
+	if ((devres & enable) != enable)
+		return;
+	mask = (devres >> 16) & 15;
+	base = devres & 0xffff;
+	size = 16;
+	for (;;) {
+		unsigned bit = size >> 1;
+		if ((bit & mask) == bit)
+			break;
+		size = bit;
+	}
+	/*
+	 * For now we only print it out. Eventually we'll want to
+	 * reserve it (at least if it's in the 0x1000+ range), but
+	 * let's get enough confirmation reports first. 
+	 */
+	printk("%s PIO at %04x-%04x\n", name, base, base + size - 1);
+}
+
+static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
+{
+	u32 devres;
+	u32 mask, size, base;
+
+	pci_read_config_dword(dev, port, &devres);
+	if ((devres & enable) != enable)
+		return;
+	base = devres & 0xffff0000;
+	mask = (devres & 0x3f) << 16;
+	size = 128 << 16;
+	for (;;) {
+		unsigned bit = size >> 1;
+		if ((bit & mask) == bit)
+			break;
+		size = bit;
+	}
+	/*
+	 * For now we only print it out. Eventually we'll want to
+	 * reserve it, but let's get enough confirmation reports first. 
+	 */
+	printk("%s MMIO at %04x-%04x\n", name, base, base + size - 1);
+}
+
 /*
  * PIIX4 ACPI: Two IO regions pointed to by longwords at
  *	0x40 (64 bytes of ACPI registers)
  *	0x90 (32 bytes of SMB registers)
+ * and a few strange programmable PIIX4 device resources.
  */
 static void __devinit quirk_piix4_acpi(struct pci_dev *dev)
 {
-	u32 region;
+	u32 region, res_a;
 
 	pci_read_config_dword(dev, 0x40, &region);
-	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES);
+	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES, "PIIX4 ACPI");
 	pci_read_config_dword(dev, 0x90, &region);
-	quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1);
+	quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1, "PIIX4 SMB");
+
+	/* Device resource A has enables for some of the other ones */
+	pci_read_config_dword(dev, 0x5c, &res_a);
+
+	piix4_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
+	piix4_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
+
+	/* Device resource D is just bitfields for static resources */
+
+	/* Device 12 enabled? */
+	if (res_a & (1 << 29)) {
+		piix4_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
+		piix4_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
+	}
+	/* Device 13 enabled? */
+	if (res_a & (1 << 30)) {
+		piix4_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
+		piix4_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
+	}
+	piix4_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
+	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
 
@@ -323,10 +396,10 @@ static void __devinit quirk_ich4_lpc_acp
 	u32 region;
 
 	pci_read_config_dword(dev, 0x40, &region);
-	quirk_io_region(dev, region, 128, PCI_BRIDGE_RESOURCES);
+	quirk_io_region(dev, region, 128, PCI_BRIDGE_RESOURCES, "ICH4 ACPI/GPIO/TCO");
 
 	pci_read_config_dword(dev, 0x58, &region);
-	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
+	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1, "ICH4 GPIO");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi );
@@ -352,7 +425,7 @@ static void __devinit quirk_vt82c586_acp
 	if (rev & 0x10) {
 		pci_read_config_dword(dev, 0x48, &region);
 		region &= PCI_BASE_ADDRESS_IO_MASK;
-		quirk_io_region(dev, region, 256, PCI_BRIDGE_RESOURCES);
+		quirk_io_region(dev, region, 256, PCI_BRIDGE_RESOURCES, "vt82c586 ACPI");
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi );
@@ -372,11 +445,11 @@ static void __devinit quirk_vt82c686_acp
 
 	pci_read_config_word(dev, 0x70, &hm);
 	hm &= PCI_BASE_ADDRESS_IO_MASK;
-	quirk_io_region(dev, hm, 128, PCI_BRIDGE_RESOURCES + 1);
+	quirk_io_region(dev, hm, 128, PCI_BRIDGE_RESOURCES + 1, "vt82c868 HW-mon");
 
 	pci_read_config_dword(dev, 0x90, &smb);
 	smb &= PCI_BASE_ADDRESS_IO_MASK;
-	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2);
+	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2, "vt82c868 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi );
 
@@ -391,11 +464,11 @@ static void __devinit quirk_vt8235_acpi(
 
 	pci_read_config_word(dev, 0x88, &pm);
 	pm &= PCI_BASE_ADDRESS_IO_MASK;
-	quirk_io_region(dev, pm, 128, PCI_BRIDGE_RESOURCES);
+	quirk_io_region(dev, pm, 128, PCI_BRIDGE_RESOURCES, "vt8235 PM");
 
 	pci_read_config_word(dev, 0xd0, &smb);
 	smb &= PCI_BASE_ADDRESS_IO_MASK;
-	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 1);
+	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 1, "vt8235 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,	quirk_vt8235_acpi);
 
