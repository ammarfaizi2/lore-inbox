Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUHWTWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUHWTWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUHWTU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:20:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:4036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267248AbUHWSgu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:50 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860842875@kroah.com>
Date: Mon, 23 Aug 2004 11:34:44 -0700
Message-Id: <109328608438@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.6, 2004/08/04 07:54:19-04:00, dwmw2@shinybook.infradead.org

[1/3] Split pci quirks array to allow separate declarations.

It's a pain in the arse to set up platform-specific PCI quirks -- you
have to put your platform-specific quirk into the generic (or at least
the architecture) array. This patch fixes that, allowing you to
DECLARE_PCI_FIXUP_HEADER() or DECLARE_PCI_FIXUP_FINAL() anywhere you
like.

Note that a lot of the quirks can now be moved out of
drivers/pci/quirks.c and put somewhere closer to where they belong.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c              |  261 ++++++++++++++++++--------------------
 include/asm-generic/vmlinux.lds.h |   10 +
 include/linux/pci.h               |   15 +-
 3 files changed, 148 insertions(+), 138 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-08-23 11:06:45 -07:00
+++ b/drivers/pci/quirks.c	2004-08-23 11:06:45 -07:00
@@ -39,6 +39,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release );
 
 /*  The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a workaround
     but VIA don't answer queries. If you happen to have good contacts at VIA
@@ -57,6 +58,17 @@
 		printk(KERN_INFO "Activating ISA DMA hang workarounds.\n");
 	}
 }
+	/*
+	 * Its not totally clear which chipsets are the problematic ones
+	 * We know 82C586 and 82C596 variants are affected.
+	 */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1533, 	quirk_isa_dma_hangs );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs );
 
 int pci_pci_problems;
 
@@ -72,6 +84,8 @@
 		pci_pci_problems|=PCIPCI_FAIL;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );
 
 /*
  *	Triton requires workarounds to be used by the drivers
@@ -85,6 +99,10 @@
 		pci_pci_problems|=PCIPCI_TRITON;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437VX, 	quirk_triton ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439, 	quirk_triton ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82439TX, 	quirk_triton ); 
 
 /*
  *	VIA Apollo KT133 needs PCI latency patch
@@ -145,6 +163,9 @@
 	pci_write_config_byte(dev, 0x76, busarb);
 	printk(KERN_INFO "Applying VIA southbridge workaround.\n");
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency );
 
 /*
  *	VIA Apollo VP3 needs ETBF on BT848/878
@@ -158,6 +179,8 @@
 		pci_pci_problems|=PCIPCI_VIAETBF;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf );
+
 static void __devinit quirk_vsfx(struct pci_dev *dev)
 {
 	if((pci_pci_problems&PCIPCI_VSFX)==0)
@@ -166,6 +189,7 @@
 		pci_pci_problems|=PCIPCI_VSFX;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx );
 
 /*
  *	Ali Magik requires workarounds to be used by the drivers
@@ -182,6 +206,8 @@
 		pci_pci_problems|=PCIPCI_ALIMAGIK|PCIPCI_TRITON;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1647, 	quirk_alimagik );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1651, 	quirk_alimagik );
 
 
 /*
@@ -197,6 +223,12 @@
 		pci_pci_problems|=PCIPCI_NATOMA;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82441, 	quirk_natoma ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443LX_0, 	quirk_natoma ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443LX_1, 	quirk_natoma ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_0, 	quirk_natoma ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_1, 	quirk_natoma ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma );
 
 /*
  *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
@@ -212,6 +244,8 @@
 		r->end = 0x3ffffff;
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M );
 
 static void __devinit quirk_io_region(struct pci_dev *dev, unsigned region, unsigned size, int nr)
 {
@@ -239,6 +273,7 @@
 	request_region(0x3b0, 0x0C, "RadeonIGP");
 	request_region(0x3d3, 0x01, "RadeonIGP");
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce );
 
 /*
  * Let's make the southbridge information explicit instead
@@ -260,6 +295,7 @@
 	pci_read_config_word(dev, 0xE2, &region);
 	quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi );
 
 /*
  * PIIX4 ACPI: Two IO regions pointed to by longwords at
@@ -275,6 +311,7 @@
 	pci_read_config_dword(dev, 0x90, &region);
 	quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
 
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
@@ -291,6 +328,15 @@
 	pci_read_config_dword(dev, 0x58, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_10,	quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_12,	quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
 
 /*
  * VIA ACPI: One IO region pointed to by longword at
@@ -308,6 +354,7 @@
 		quirk_io_region(dev, region, 256, PCI_BRIDGE_RESOURCES);
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi );
 
 /*
  * VIA VT82C686 ACPI: Three IO region pointed to by (long)words at
@@ -330,6 +377,7 @@
 	smb &= PCI_BASE_ADDRESS_IO_MASK;
 	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 2);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi );
 
 
 #ifdef CONFIG_X86_IO_APIC 
@@ -358,6 +406,7 @@
 	/* Offset 0x58: External APIC IRQ output control */
 	pci_write_config_byte (dev, 0x58, tmp);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic );
 
 /*
  * The AMD io apic can hang the box when an apic irq is masked.
@@ -380,12 +429,14 @@
 		printk(KERN_WARNING "        : booting with the \"noapic\" option.\n");
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic );
 
 static void __init quirk_ioapic_rmw(struct pci_dev *dev)
 {
 	if (dev->devfn == 0 && dev->bus->number == 0)
 		sis_apic_bug = 1;
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw );
 
 #define AMD8131_revA0        0x01
 #define AMD8131_revB0        0x11
@@ -407,6 +458,7 @@
                 pci_write_config_byte( dev, AMD8131_MISC, tmp);
         }
 } 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,         quirk_amd_8131_ioapic ); 
 
 #endif /* CONFIG_X86_IO_APIC */
 
@@ -444,6 +496,8 @@
 	if (irq && (irq != 2))
 		d->irq = irq;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
 static void __devinit quirk_via_irqpic(struct pci_dev *dev)
 {
@@ -459,6 +513,9 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic );
 
 
 /*
@@ -480,6 +537,8 @@
 	legsup &= 0x50ef;
 	pci_write_config_word(dev, 0xc0, legsup);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb );
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes
@@ -492,6 +551,7 @@
 	pci_write_config_byte(dev, 0xfc, 0);
 	pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id );
 
 /*
  * CardBus controllers have a legacy base address that enables them
@@ -505,6 +565,7 @@
 		return;
 	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy );
 
 /*
  * Following the PCI ordering rules is optional on the AMD762. I'm not
@@ -528,6 +589,7 @@
 		pci_write_config_dword(dev, 0x84, pcic);
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering );
 
 /*
  *	DreamWorks provided workaround for Dunord I-3000 problem
@@ -543,11 +605,21 @@
 	r -> start = 0;
 	r -> end = 0xffffff;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord );
 
+/*
+ * i82380FB mobile docking controller: its PCI-to-PCI bridge
+ * is subtractive decoding (transparent), and does indicate this
+ * in the ProgIf. Unfortunately, the ProgIf value is wrong - 0x80
+ * instead of 0x01.
+ */
 static void __devinit quirk_transparent_bridge(struct pci_dev *dev)
 {
 	dev->transparent = 1;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge );
+
 
 /*
  * Common misconfiguration of the MediaGX/Geode PCI master that will
@@ -566,6 +638,8 @@
                 pci_write_config_byte(dev, 0x41, reg);
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
+
 
 /*
  * As per PCI spec, ignore base address registers 0-3 of the IDE controllers
@@ -616,6 +690,7 @@
        printk(KERN_INFO "PCI: Ignoring BAR%d-%d of IDE controller %s\n",
               first_bar, last_bar, pci_name(dev));
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,             PCI_ANY_ID,                     quirk_ide_bases );
 
 /*
  *	Ensure C0 rev restreaming is off. This is normally done by
@@ -639,6 +714,7 @@
 		printk(KERN_INFO "PCI: C0 revision 450NX. Disabling PCI restreaming.\n");
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
 
 /*
  *	VIA northbridges care about PCI_INTERRUPT_LINE
@@ -651,6 +727,7 @@
 	if(pdev->devfn == 0)
 		interrupt_line_quirk = 1;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
@@ -667,6 +744,7 @@
 		quirk_ide_bases(pdev);
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );
 
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
@@ -676,6 +754,7 @@
 {
 	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge );
 
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
@@ -732,6 +811,12 @@
 			}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge );
 
 static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
 {
@@ -750,6 +835,9 @@
 			printk(KERN_INFO "PCI: Enabled i801 SMBus device\n");
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
@@ -803,6 +891,19 @@
 {
 	sis_96x_compatible = 1;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_645,		quirk_sis_96x_compatible );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_646,		quirk_sis_96x_compatible );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_648,		quirk_sis_96x_compatible );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_650,		quirk_sis_96x_compatible );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
 
 #ifdef CONFIG_X86_IO_APIC
 static void __init quirk_alder_ioapic(struct pci_dev *pdev)
@@ -825,6 +926,7 @@
 	}
 
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
 #ifdef CONFIG_SCSI_SATA
@@ -898,6 +1000,7 @@
 	else
 		request_region(0x170, 8, "libata");	/* port 1 */
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
 #endif /* CONFIG_SCSI_SATA */
 
 int pciehp_msi_quirk;
@@ -906,6 +1009,7 @@
 {
 	pciehp_msi_quirk = 1;
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_SMCH,	quirk_pciehp_msi );
 
 /*
  *  The main table of quirks.
@@ -914,141 +1018,11 @@
  *        be declared __init.
  */
 
-static struct pci_fixup pci_fixups[] __devinitdata = {
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
-	/*
-	 * Its not totally clear which chipsets are the problematic ones
-	 * We know 82C586 and 82C596 variants are affected.
-	 */
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
-	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1533, 	quirk_isa_dma_hangs },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
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
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_645,		quirk_sis_96x_compatible },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_646,		quirk_sis_96x_compatible },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_648,		quirk_sis_96x_compatible },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_650,		quirk_sis_96x_compatible },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1647, 	quirk_alimagik },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1651, 	quirk_alimagik },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	quirk_vialatency },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt82c586_acpi },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi },
-
-	/* Intel LPC interface bridges all have 128 bytes of magic ACPI/TCO regs and 64 bytes of GPIO */
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_0,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801BA_10,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_0,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801CA_12,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,	quirk_ich4_lpc_acpi },
-
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi },
- 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb },
-	{ PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,                     quirk_ide_bases },
-	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge },
-	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy },
-
-#ifdef CONFIG_X86_IO_APIC 
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
-	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw },
-        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,
-          quirk_amd_8131_ioapic }, 
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic },
-#endif
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic },
-
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce },
-	/*
-	 * i82380FB mobile docking controller: its PCI-to-PCI bridge
-	 * is subtractive decoding (transparent), and does indicate this
-	 * in the ProgIf. Unfortunately, the ProgIf value is wrong - 0x80
-	 * instead of 0x01.
-	 */
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge },
-
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
-
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide },
-
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge },
-
-	/*
-	 * on Asus P4B boards, the i801SMBus device is disabled at startup.
-	 * this also goes for boards in HP Compaq nc6000 and nc8000 notebooks.
-	 */
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc },
-
-#ifdef CONFIG_SCSI_SATA
-	/* Fixup BIOSes that configure Parallel ATA (PATA / IDE) and
-	 * Serial ATA (SATA) into the same PCI ID.
-	 */
-	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,
-	  quirk_intel_ide_combined },
-#endif /* CONFIG_SCSI_SATA */
 
-	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_SMCH,	quirk_pciehp_msi },
-
-	{ 0 }
-};
-
-
-static void pci_do_fixups(struct pci_dev *dev, int pass, struct pci_fixup *f)
+static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
-	while (f->pass) {
-		if (f->pass == pass &&
- 		    (f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
+	while (f < end) {
+		if ((f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
  		    (f->device == dev->device || f->device == (u16) PCI_ANY_ID)) {
 #ifdef DEBUG
 			printk(KERN_INFO "PCI: Calling quirk %p for %s\n", f->hook, pci_name(dev));
@@ -1059,10 +1033,27 @@
 	}
 }
 
+extern struct pci_fixup __start_pci_fixups_header[];
+extern struct pci_fixup __end_pci_fixups_header[];
+extern struct pci_fixup __start_pci_fixups_final[];
+extern struct pci_fixup __end_pci_fixups_final[];
+
 void pci_fixup_device(int pass, struct pci_dev *dev)
 {
-	pci_do_fixups(dev, pass, pcibios_fixups);
-	pci_do_fixups(dev, pass, pci_fixups);
+	struct pci_fixup *start, *end;
+
+	switch(pass) {
+	case PCI_FIXUP_HEADER:
+		start = __start_pci_fixups_header;
+		end = __end_pci_fixups_header;
+		break;
+
+	case PCI_FIXUP_FINAL:
+		start = __start_pci_fixups_final;
+		end = __end_pci_fixups_final;
+		break;
+	}
+	pci_do_fixups(dev, start, end);
 }
 
 EXPORT_SYMBOL(pciehp_msi_quirk);
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	2004-08-23 11:06:45 -07:00
+++ b/include/asm-generic/vmlinux.lds.h	2004-08-23 11:06:45 -07:00
@@ -16,6 +16,16 @@
 		*(.rodata1)						\
 	}								\
 									\
+	/* PCI quirks */						\
+	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
+		*(.pci_fixup_header)					\
+		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
+		*(.pci_fixup_final)					\
+		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
+	}								\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-08-23 11:06:45 -07:00
+++ b/include/linux/pci.h	2004-08-23 11:06:45 -07:00
@@ -1001,15 +1001,24 @@
  */
 
 struct pci_fixup {
-	int pass;
 	u16 vendor, device;			/* You can use PCI_ANY_ID here of course */
 	void (*hook)(struct pci_dev *dev);
 };
 
-extern struct pci_fixup pcibios_fixups[];
-
 #define PCI_FIXUP_HEADER	1		/* Called immediately after reading configuration header */
 #define PCI_FIXUP_FINAL		2		/* Final phase of device fixups */
+
+/* Anonymous variables would be nice... */
+#define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)					\
+	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
+	__attribute__((__section__(".pci_fixup_header"))) = {				\
+		vendor, device, hook };
+
+#define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)				\
+	static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_used__	\
+	__attribute__((__section__(".pci_fixup_final"))) = {				\
+		vendor, device, hook };
+
 
 void pci_fixup_device(int pass, struct pci_dev *dev);
 

