Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSK1Qzm>; Thu, 28 Nov 2002 11:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSK1Qzm>; Thu, 28 Nov 2002 11:55:42 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:6405 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265939AbSK1Qze>; Thu, 28 Nov 2002 11:55:34 -0500
Date: Thu, 28 Nov 2002 20:02:07 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sebastian Benoit <benoit-lists@fb12.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: drivers/pci/quirks.c / Re: Linux v2.5.50
Message-ID: <20021128200207.A23822@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com> <20021128111528.A28437@turing.fb12.de> <1038500743.10021.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1038500743.10021.1.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 28, 2002 at 04:25:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 04:25:43PM +0000, Alan Cox wrote:
> On Thu, 2002-11-28 at 10:15, Sebastian Benoit wrote:
> > make[2]: *** [drivers/pci/quirks.o] Error 1
> > make[1]: *** [drivers/pci] Error 2
> > make: *** [drivers] Error 2
> >
> 
> I'll send Linus the code I actually originally meant to send him, that
> tidies this stuff up IMHO a lot better

Actually a LOT of fixups in drivers/pci/quirks.c are 100% x86 specific
and therefore don't belong in there.
What about this patch?
It moves most obvious stuff (northbridges quirks) to the proper
place (arch/i386/pci/fixups.c).

Ivan.

--- 2.5.50/arch/i386/pci/fixup.c	Thu Nov 28 01:36:15 2002
+++ linux/arch/i386/pci/fixup.c	Thu Nov 28 19:21:30 2002
@@ -187,6 +187,179 @@ static void __devinit pci_fixup_transpar
 		dev->transparent = 1;
 }
 
+/* Deal with broken BIOS'es that neglect to enable passive release,
+   which can cause problems in combination with the 82441FX/PPro MTRRs */
+static void __devinit quirk_passive_release(struct pci_dev *dev)
+{
+	struct pci_dev *d = NULL;
+	unsigned char dlc;
+
+	/* We have to make sure a particular bit is set in the PIIX3
+	   ISA bridge, so we have to go out and find it. */
+	while ((d = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
+		pci_read_config_byte(d, 0x82, &dlc);
+		if (!(dlc & 1<<1)) {
+			printk(KERN_ERR "PCI: PIIX3: Enabling Passive Release on %s\n", d->slot_name);
+			dlc |= 1<<1;
+			pci_write_config_byte(d, 0x82, dlc);
+		}
+	}
+}
+
+/*
+ *	Triton requires workarounds to be used by the drivers
+ */
+ 
+static void __devinit quirk_triton(struct pci_dev *dev)
+{
+	if((pci_pci_problems&PCIPCI_TRITON)==0)
+	{
+		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
+		pci_pci_problems|=PCIPCI_TRITON;
+	}
+}
+
+/*
+ *	VIA Apollo VP3 needs ETBF on BT848/878
+ */
+ 
+static void __devinit quirk_viaetbf(struct pci_dev *dev)
+{
+	if((pci_pci_problems&PCIPCI_VIAETBF)==0)
+	{
+		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
+		pci_pci_problems|=PCIPCI_VIAETBF;
+	}
+}
+
+static void __devinit quirk_vsfx(struct pci_dev *dev)
+{
+	if((pci_pci_problems&PCIPCI_VSFX)==0)
+	{
+		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
+		pci_pci_problems|=PCIPCI_VSFX;
+	}
+}
+
+
+/*
+ *	Natoma has some interesting boundary conditions with Zoran stuff
+ *	at least
+ */
+ 
+static void __devinit quirk_natoma(struct pci_dev *dev)
+{
+	if((pci_pci_problems&PCIPCI_NATOMA)==0)
+	{
+		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
+		pci_pci_problems|=PCIPCI_NATOMA;
+	}
+}
+
+/*
+ *	ATI Northbridge setups MCE the processor if you even
+ *	read somewhere between 0x3b0->0x3bb or read 0x3d3
+ */
+ 
+static void __devinit quirk_ati_exploding_mce(struct pci_dev *dev)
+{
+	printk(KERN_INFO "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.\n");
+	/* Mae rhaid in i beidio a edrych ar y lleoliad I/O hyn */
+	request_region(0x3b0, 0x0C, "RadeonIGP");
+	request_region(0x3d3, 0x01, "RadeonIGP");
+}
+
+#ifdef CONFIG_X86_IO_APIC 
+extern int nr_ioapics;
+
+/*
+ * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
+ * devices to the external APIC.
+ *
+ * TODO: When we have device-specific interrupt routers,
+ * this code will go away from quirks.
+ */
+static void __devinit quirk_via_ioapic(struct pci_dev *dev)
+{
+	u8 tmp;
+	
+	if (nr_ioapics < 1)
+		tmp = 0;    /* nothing routed to external APIC */
+	else
+		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
+		
+	printk(KERN_INFO "PCI: %sbling Via external APIC routing\n",
+	       tmp == 0 ? "Disa" : "Ena");
+
+	/* Offset 0x58: External APIC IRQ output control */
+	pci_write_config_byte (dev, 0x58, tmp);
+}
+
+/*
+ * The AMD io apic can hang the box when an apic irq is masked.
+ * We check all revs >= B0 (yet not in the pre production!) as the bug
+ * is currently marked NoFix
+ *
+ * We have multiple reports of hangs with this chipset that went away with
+ * noapic specified. For the moment we assume its the errata. We may be wrong
+ * of course. However the advice is demonstrably good even if so..
+ */
+ 
+static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
+{
+	u8 rev;
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+	if(rev >= 0x02)
+	{
+		printk(KERN_WARNING "I/O APIC: AMD Errata #22 may be present. In the event of instability try\n");
+		printk(KERN_WARNING "        : booting with the \"noapic\" option.\n");
+	}
+}
+
+static void __devinit quirk_ioapic_rmw(struct pci_dev *dev)
+{
+	if (dev->devfn == 0 && dev->bus->number == 0)
+		sis_apic_bug = 1;
+}
+
+#endif /* CONFIG_X86_IO_APIC */
+
+/*
+ * VIA VT82C598 has its device ID settable and many BIOSes
+ * set it to the ID of VT82C597 for backward compatibility.
+ * We need to switch it off to be able to recognize the real
+ * type of the chip.
+ */
+static void __devinit quirk_vt82c598_id(struct pci_dev *dev)
+{
+	pci_write_config_byte(dev, 0xfc, 0);
+	pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
+}
+
+/*
+ * Following the PCI ordering rules is optional on the AMD762. I'm not
+ * sure what the designers were smoking but let's not inhale...
+ *
+ * To be fair to AMD, it follows the spec by default, its BIOS people
+ * who turn it off!
+ */
+ 
+static void __devinit quirk_amd_ordering(struct pci_dev *dev)
+{
+	u32 pcic;
+	pci_read_config_dword(dev, 0x4C, &pcic);
+	if((pcic&6)!=6)
+	{
+		pcic |= 6;
+		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, fixing this error.\n");
+		pci_write_config_dword(dev, 0x4C, pcic);
+		pci_read_config_dword(dev, 0x84, &pcic);
+		pcic |= (1<<23);	/* Required in this mode */
+		pci_write_config_dword(dev, 0x84, pcic);
+	}
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -199,11 +372,33 @@ struct pci_fixup pcibios_fixups[] = {
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_10,	pci_fixup_ide_trash },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_11,	pci_fixup_ide_trash },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_9,	pci_fixup_ide_trash },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
+
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8622,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437VX, 	quirk_triton }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439, 	quirk_triton }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439TX, 	quirk_triton }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82441, 	quirk_natoma }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443LX_0, 	quirk_natoma }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443LX_1, 	quirk_natoma }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_0, 	quirk_natoma }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_1, 	quirk_natoma }, 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf },
+#ifdef CONFIG_X86_IO_APIC 
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
+	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SIS,	PCI_ANY_ID,			quirk_ioapic_rmw },
+#endif
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RADEON_IGP,   quirk_ati_exploding_mce },
 	{ 0 }
 };
--- 2.5.50/drivers/pci/quirks.c	Thu Nov 28 01:35:48 2002
+++ linux/drivers/pci/quirks.c	Thu Nov 28 15:57:19 2002
@@ -21,25 +21,6 @@
 
 #undef DEBUG
 
-/* Deal with broken BIOS'es that neglect to enable passive release,
-   which can cause problems in combination with the 82441FX/PPro MTRRs */
-static void __devinit quirk_passive_release(struct pci_dev *dev)
-{
-	struct pci_dev *d = NULL;
-	unsigned char dlc;
-
-	/* We have to make sure a particular bit is set in the PIIX3
-	   ISA bridge, so we have to go out and find it. */
-	while ((d = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
-		pci_read_config_byte(d, 0x82, &dlc);
-		if (!(dlc & 1<<1)) {
-			printk(KERN_ERR "PCI: PIIX3: Enabling Passive Release on %s\n", d->slot_name);
-			dlc |= 1<<1;
-			pci_write_config_byte(d, 0x82, dlc);
-		}
-	}
-}
-
 /*  The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a workaround
     but VIA don't answer queries. If you happen to have good contacts at VIA
     ask them for me please -- Alan 
@@ -74,19 +55,6 @@ static void __devinit quirk_nopcipci(str
 }
 
 /*
- *	Triton requires workarounds to be used by the drivers
- */
- 
-static void __devinit quirk_triton(struct pci_dev *dev)
-{
-	if((pci_pci_problems&PCIPCI_TRITON)==0)
-	{
-		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_TRITON;
-	}
-}
-
-/*
  *	VIA Apollo KT133 needs PCI latency patch
  *	Made according to a windows driver based patch by George E. Breese
  *	see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
@@ -147,42 +115,6 @@ static void __devinit quirk_vialatency(s
 }
 
 /*
- *	VIA Apollo VP3 needs ETBF on BT848/878
- */
- 
-static void __devinit quirk_viaetbf(struct pci_dev *dev)
-{
-	if((pci_pci_problems&PCIPCI_VIAETBF)==0)
-	{
-		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_VIAETBF;
-	}
-}
-static void __devinit quirk_vsfx(struct pci_dev *dev)
-{
-	if((pci_pci_problems&PCIPCI_VSFX)==0)
-	{
-		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_VSFX;
-	}
-}
-
-
-/*
- *	Natoma has some interesting boundary conditions with Zoran stuff
- *	at least
- */
- 
-static void __devinit quirk_natoma(struct pci_dev *dev)
-{
-	if((pci_pci_problems&PCIPCI_NATOMA)==0)
-	{
-		printk(KERN_INFO "Limiting direct PCI/PCI transfers.\n");
-		pci_pci_problems|=PCIPCI_NATOMA;
-	}
-}
-
-/*
  *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
  *  If it's needed, re-allocate the region.
  */
@@ -212,19 +144,6 @@ static void __devinit quirk_io_region(st
 }	
 
 /*
- *	ATI Northbridge setups MCE the processor if you even
- *	read somewhere between 0x3b0->0x3bb or read 0x3d3
- */
- 
-static void __devinit quirk_ati_exploding_mce(struct pci_dev *dev)
-{
-	printk(KERN_INFO "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.\n");
-	/* Mae rhaid in i beidio a edrych ar y lleoliad I/O hyn */
-	request_region(0x3b0, 0x0C, "RadeonIGP");
-	request_region(0x3d3, 0x01, "RadeonIGP");
-}
-
-/*
  * Let's make the southbridge information explicit instead
  * of having to worry about people probing the ACPI areas,
  * for example.. (Yes, it happens, and if you read the wrong
@@ -300,64 +219,6 @@ static void __devinit quirk_vt82c686_acp
 }
 
 
-#ifdef CONFIG_X86_IO_APIC 
-extern int nr_ioapics;
-
-/*
- * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
- * devices to the external APIC.
- *
- * TODO: When we have device-specific interrupt routers,
- * this code will go away from quirks.
- */
-static void __devinit quirk_via_ioapic(struct pci_dev *dev)
-{
-	u8 tmp;
-	
-	if (nr_ioapics < 1)
-		tmp = 0;    /* nothing routed to external APIC */
-	else
-		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
-		
-	printk(KERN_INFO "PCI: %sbling Via external APIC routing\n",
-	       tmp == 0 ? "Disa" : "Ena");
-
-	/* Offset 0x58: External APIC IRQ output control */
-	pci_write_config_byte (dev, 0x58, tmp);
-}
-
-/*
- * The AMD io apic can hang the box when an apic irq is masked.
- * We check all revs >= B0 (yet not in the pre production!) as the bug
- * is currently marked NoFix
- *
- * We have multiple reports of hangs with this chipset that went away with
- * noapic specified. For the moment we assume its the errata. We may be wrong
- * of course. However the advice is demonstrably good even if so..
- */
- 
-static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
-{
-	u8 rev;
-
-	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
-	if(rev >= 0x02)
-	{
-		printk(KERN_WARNING "I/O APIC: AMD Errata #22 may be present. In the event of instability try\n");
-		printk(KERN_WARNING "        : booting with the \"noapic\" option.\n");
-	}
-}
-
-static void __init quirk_ioapic_rmw(struct pci_dev *dev)
-{
-	if (dev->devfn == 0 && dev->bus->number == 0)
-		sis_apic_bug = 1;
-}
-
-
-#endif /* CONFIG_X86_IO_APIC */
-
-
 /*
  * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
  * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
@@ -429,18 +290,6 @@ static void __devinit quirk_piix3_usb(st
 }
 
 /*
- * VIA VT82C598 has its device ID settable and many BIOSes
- * set it to the ID of VT82C597 for backward compatibility.
- * We need to switch it off to be able to recognize the real
- * type of the chip.
- */
-static void __devinit quirk_vt82c598_id(struct pci_dev *dev)
-{
-	pci_write_config_byte(dev, 0xfc, 0);
-	pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
-}
-
-/*
  * CardBus controllers have a legacy base address that enables them
  * to respond as i82365 pcmcia controllers.  We don't want them to
  * do this even if the Linux CardBus driver is not loaded, because
@@ -454,29 +303,6 @@ static void __devinit quirk_cardbus_lega
 }
 
 /*
- * Following the PCI ordering rules is optional on the AMD762. I'm not
- * sure what the designers were smoking but let's not inhale...
- *
- * To be fair to AMD, it follows the spec by default, its BIOS people
- * who turn it off!
- */
- 
-static void __devinit quirk_amd_ordering(struct pci_dev *dev)
-{
-	u32 pcic;
-	pci_read_config_dword(dev, 0x4C, &pcic);
-	if((pcic&6)!=6)
-	{
-		pcic |= 6;
-		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, fixing this error.\n");
-		pci_write_config_dword(dev, 0x4C, pcic);
-		pci_read_config_dword(dev, 0x84, &pcic);
-		pcic |= (1<<23);	/* Required in this mode */
-		pci_write_config_dword(dev, 0x84, pcic);
-	}
-}
-
-/*
  *	DreamWorks provided workaround for Dunord I-3000 problem
  *
  *	This card decodes and responds to addresses not apparently
@@ -520,8 +346,6 @@ static void __init quirk_mediagx_master(
 
 static struct pci_fixup pci_fixups[] __devinitdata = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
 	/*
 	 * Its not totally clear which chipsets are the problematic ones
 	 * We know 82C586 and 82C596 variants are affected.
@@ -532,24 +356,12 @@ static struct pci_fixup pci_fixups[] __d
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437VX, 	quirk_triton }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439, 	quirk_triton }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439TX, 	quirk_triton }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82441, 	quirk_natoma }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443LX_0, 	quirk_natoma }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443LX_1, 	quirk_natoma }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_0, 	quirk_natoma }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_1, 	quirk_natoma }, 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	quirk_vialatency },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency },
+
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi },
@@ -557,20 +369,11 @@ static struct pci_fixup pci_fixups[] __d
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb },
 	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy },
-
-#ifdef CONFIG_X86_IO_APIC 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
-	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SIS,	PCI_ANY_ID,			quirk_ioapic_rmw },
-#endif
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic },
-
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RADEON_IGP,   quirk_ati_exploding_mce },
 	/*
 	 * i82380FB mobile docking controller: its PCI-to-PCI bridge
 	 * is subtractive decoding (transparent), and does indicate this
