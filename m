Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVERUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVERUBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVERUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:01:54 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:59350 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262336AbVERT56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:57:58 -0400
Date: Wed, 18 May 2005 14:57:20 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: shall@mvista.com, linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Add VIA IDE support to MPC8555 CDS platform
Message-ID: <Pine.LNX.4.61.0505181456390.30482@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the VIA IDE controller that exists on the MPC8555 CDS system.
Updated the config for the system to enable support by default.

Signed-off-by: Scott Hall <shall@mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>


---
commit 0fb96253fc9ba2b9b348a2cc3c848334aa1643a2
tree b9da5c64c03fa695686baaa34e15cf0ca1bc48fd
parent ff96b3d4b840e8aa126e0a60fd743417ffdee178
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 18 May 2005 14:55:44 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 18 May 2005 14:55:44 -0500

 ppc/configs/mpc8555_cds_defconfig       |  117 +++++++++++++++++++++------
 ppc/platforms/85xx/mpc85xx_cds_common.c |  138 +++++++++++++++++++++++++++++++-
 ppc/platforms/85xx/mpc85xx_cds_common.h |    3 
 ppc/syslib/Makefile                     |    2 
 ppc/syslib/ppc85xx_setup.c              |   16 +++
 5 files changed, 248 insertions(+), 28 deletions(-)

Index: arch/ppc/configs/mpc8555_cds_defconfig
===================================================================
--- bf16c711040aa5a00e5a6d6675869526b4dbfbb5/arch/ppc/configs/mpc8555_cds_defconfig  (mode:100644)
+++ b9da5c64c03fa695686baaa34e15cf0ca1bc48fd/arch/ppc/configs/mpc8555_cds_defconfig  (mode:100644)
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc1
-# Thu Jan 20 01:25:35 2005
+# Linux kernel version: 2.6.12-rc4
+# Tue May 17 11:56:01 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -11,6 +11,7 @@
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 
 #
 # Code maturity level options
@@ -18,6 +19,7 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -29,12 +31,14 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +48,7 @@
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -62,10 +67,12 @@
 CONFIG_E500=y
 CONFIG_BOOKE=y
 CONFIG_FSL_BOOKE=y
+# CONFIG_PHYS_64BIT is not set
 CONFIG_SPE=y
 CONFIG_MATH_EMULATION=y
 # CONFIG_CPU_FREQ is not set
 CONFIG_PPC_GEN550=y
+# CONFIG_PM is not set
 CONFIG_85xx=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
 
@@ -76,6 +83,7 @@
 CONFIG_MPC8555_CDS=y
 # CONFIG_MPC8560_ADS is not set
 # CONFIG_SBC8560 is not set
+# CONFIG_STX_GP3 is not set
 CONFIG_MPC8555=y
 CONFIG_85xx_PCI2=y
 
@@ -90,6 +98,7 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_CMDLINE_BOOL is not set
+CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
@@ -105,10 +114,6 @@
 # CONFIG_PCCARD is not set
 
 #
-# PC-card bridges
-#
-
-#
 # Advanced setup
 #
 # CONFIG_ADVANCED_OPTIONS is not set
@@ -180,7 +185,59 @@
 #
 # ATA/ATAPI/MFM/RLL support
 #
-# CONFIG_IDE is not set
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+# CONFIG_BLK_DEV_OFFBOARD is not set
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+CONFIG_BLK_DEV_VIA82CXXX=y
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
@@ -220,7 +277,6 @@
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -370,14 +426,6 @@
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
-# CONFIG_SERIO_I8042 is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -387,6 +435,13 @@
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -406,6 +461,7 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_CPM is not set
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -434,6 +490,11 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
 # I2C support
 #
 CONFIG_I2C=y
@@ -456,11 +517,11 @@
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_ISA is not set
 CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
-# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_SCx200_ACB is not set
@@ -483,7 +544,9 @@
 # CONFIG_SENSORS_ASB100 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
 # CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
 # CONFIG_SENSORS_LM75 is not set
@@ -494,9 +557,11 @@
 # CONFIG_SENSORS_LM85 is not set
 # CONFIG_SENSORS_LM87 is not set
 # CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
@@ -506,10 +571,12 @@
 #
 # Other I2C Chip support
 #
+# CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_SENSORS_M41T00 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -538,7 +605,6 @@
 # Graphics support
 #
 # CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -548,13 +614,9 @@
 #
 # USB support
 #
-# CONFIG_USB is not set
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
+# CONFIG_USB is not set
 
 #
 # USB Gadget Support
@@ -585,6 +647,10 @@
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -646,7 +712,6 @@
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -698,7 +763,9 @@
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_KGDB_CONSOLE is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 
Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- bf16c711040aa5a00e5a6d6675869526b4dbfbb5/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
+++ b9da5c64c03fa695686baaa34e15cf0ca1bc48fd/arch/ppc/platforms/85xx/mpc85xx_cds_common.c  (mode:100644)
@@ -44,6 +44,7 @@
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/open_pic.h>
+#include <asm/i8259.h>
 #include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc85xx.h>
@@ -181,6 +182,7 @@
 mpc85xx_cds_init_IRQ(void)
 {
 	bd_t *binfo = (bd_t *) __res;
+	int i;
 
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
@@ -198,6 +200,13 @@
 	 */
 	openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
 
+	openpic_hookup_cascade(PIRQ0A, "82c59 cascade", i8259_irq);
+
+	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
+		irq_desc[i].handler = &i8259_pic;
+
+	i8259_init(0);
+
 #ifdef CONFIG_CPM2
 	/* Setup CPM2 PIC */
         cpm2_init_IRQ();
@@ -231,7 +240,7 @@
 			 * interrupt on slot */
 		{
 			{ 0, 1, 2, 3 }, /* 16 - PMC */
-			{ 3, 0, 0, 0 }, /* 17 P2P (Tsi320) */
+			{ 0, 1, 2, 3 }, /* 17 P2P (Tsi320) */
 			{ 0, 1, 2, 3 }, /* 18 - Slot 1 */
 			{ 1, 2, 3, 0 }, /* 19 - Slot 2 */
 			{ 2, 3, 0, 1 }, /* 20 - Slot 3 */
@@ -280,13 +289,135 @@
 			return PCIBIOS_DEVICE_NOT_FOUND;
 #endif
 	/* We explicitly do not go past the Tundra 320 Bridge */
-	if (bus == 1)
+	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	else
 		return PCIBIOS_SUCCESSFUL;
 }
+
+void __init
+mpc85xx_cds_enable_via(struct pci_controller *hose)
+{
+	u32 pci_class;
+	u16 vid, did;
+ 
+	early_read_config_dword(hose, 0, 0x88, PCI_CLASS_REVISION, &pci_class);
+	if ((pci_class >> 16) != PCI_CLASS_BRIDGE_PCI)
+		return;
+
+	/* Configure P2P so that we can reach bus 1 */
+	early_write_config_byte(hose, 0, 0x88, PCI_PRIMARY_BUS, 0);
+	early_write_config_byte(hose, 0, 0x88, PCI_SECONDARY_BUS, 1);
+	early_write_config_byte(hose, 0, 0x88, PCI_SUBORDINATE_BUS, 0xff);
+
+	early_read_config_word(hose, 1, 0x10, PCI_VENDOR_ID, &vid);
+	early_read_config_word(hose, 1, 0x10, PCI_DEVICE_ID, &did);
+
+	if ((vid != PCI_VENDOR_ID_VIA) || 
+			(did != PCI_DEVICE_ID_VIA_82C686))
+		return;
+
+	/* Enable USB and IDE functions */
+	early_write_config_byte(hose, 1, 0x10, 0x48, 0x08);
+}
+
+void __init
+mpc85xx_cds_fixup_via(struct pci_controller *hose)
+{
+	u32 pci_class;
+	u16 vid, did;
+
+	early_read_config_dword(hose, 0, 0x88, PCI_CLASS_REVISION, &pci_class);
+	if ((pci_class >> 16) != PCI_CLASS_BRIDGE_PCI)
+		return;
+
+	/*
+	 * Force the backplane P2P bridge to have a window
+	 * open from 0x00000000-0x00001fff in PCI I/O space.
+	 * This allows legacy I/O (i8259, etc) on the VIA
+	 * southbridge to be accessed.
+	 */
+	early_write_config_byte(hose, 0, 0x88, PCI_IO_BASE, 0x00);
+	early_write_config_word(hose, 0, 0x88, PCI_IO_BASE_UPPER16, 0x0000);
+	early_write_config_byte(hose, 0, 0x88, PCI_IO_LIMIT, 0x10);
+	early_write_config_word(hose, 0, 0x88, PCI_IO_LIMIT_UPPER16, 0x0000);
+
+	early_read_config_word(hose, 1, 0x10, PCI_VENDOR_ID, &vid);
+	early_read_config_word(hose, 1, 0x10, PCI_DEVICE_ID, &did);
+	if ((vid != PCI_VENDOR_ID_VIA) || 
+			(did != PCI_DEVICE_ID_VIA_82C686))
+		return;
+
+	/*
+	 * Since the P2P window was forced to cover the fixed
+	 * legacy I/O addresses, it is necessary to manually
+	 * place the base addresses for the IDE and USB functions
+	 * within this window.
+	 */
+	/* Function 1, IDE */
+	early_write_config_dword(hose, 1, 0x11, PCI_BASE_ADDRESS_0, 0x1ff8); 
+	early_write_config_dword(hose, 1, 0x11, PCI_BASE_ADDRESS_1, 0x1ff4); 
+	early_write_config_dword(hose, 1, 0x11, PCI_BASE_ADDRESS_2, 0x1fe8); 
+	early_write_config_dword(hose, 1, 0x11, PCI_BASE_ADDRESS_3, 0x1fe4); 
+	early_write_config_dword(hose, 1, 0x11, PCI_BASE_ADDRESS_4, 0x1fd0); 
+
+	/* Function 2, USB ports 0-1 */
+	early_write_config_dword(hose, 1, 0x12, PCI_BASE_ADDRESS_4, 0x1fa0); 
+
+	/* Function 3, USB ports 2-3 */
+	early_write_config_dword(hose, 1, 0x13, PCI_BASE_ADDRESS_4, 0x1f80); 
+
+	/* Function 5, Power Management */
+	early_write_config_dword(hose, 1, 0x15, PCI_BASE_ADDRESS_0, 0x1e00); 
+	early_write_config_dword(hose, 1, 0x15, PCI_BASE_ADDRESS_1, 0x1dfc); 
+	early_write_config_dword(hose, 1, 0x15, PCI_BASE_ADDRESS_2, 0x1df8); 
+
+	/* Function 6, AC97 Interface */
+	early_write_config_dword(hose, 1, 0x16, PCI_BASE_ADDRESS_0, 0x1c00); 
+}
+
+void __init
+mpc85xx_cds_pcibios_fixup(void)
+{
+        struct pci_dev *dev = NULL;
+	u_char		c;
+
+        if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+                                        PCI_DEVICE_ID_VIA_82C586_1, NULL))) {
+                /*
+                 * U-Boot does not set the enable bits
+                 * for the IDE device. Force them on here.
+                 */
+                pci_read_config_byte(dev, 0x40, &c);
+                c |= 0x03; /* IDE: Chip Enable Bits */
+                pci_write_config_byte(dev, 0x40, c);
+
+		/*
+		 * Since only primary interface works, force the
+		 * IDE function to standard primary IDE interrupt
+		 * w/ 8259 offset
+		 */ 
+                dev->irq = 14;
+                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+        }
+
+	/*
+	 * Force legacy USB interrupt routing
+	 */
+        if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+                                        PCI_DEVICE_ID_VIA_82C586_2, NULL))) {
+                dev->irq = 10;
+                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
+        }
+
+        if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+                                        PCI_DEVICE_ID_VIA_82C586_2, dev))) {
+                dev->irq = 11;
+                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+        }
+}
 #endif /* CONFIG_PCI */
 
 TODC_ALLOC();
@@ -307,6 +438,9 @@
 	freq = binfo->bi_intfreq;
 
 	printk("mpc85xx_cds_setup_arch\n");
+
+	/* VIA IDE configuration */
+        ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
 
 #ifdef CONFIG_CPM2
 	cpm2_reset();
Index: arch/ppc/platforms/85xx/mpc85xx_cds_common.h
===================================================================
--- bf16c711040aa5a00e5a6d6675869526b4dbfbb5/arch/ppc/platforms/85xx/mpc85xx_cds_common.h  (mode:100644)
+++ b9da5c64c03fa695686baaa34e15cf0ca1bc48fd/arch/ppc/platforms/85xx/mpc85xx_cds_common.h  (mode:100644)
@@ -77,4 +77,7 @@
 
 #define MPC85XX_PCI2_IO_SIZE         0x01000000
 
+#define NR_8259_INTS		     16
+#define CPM_IRQ_OFFSET		     NR_8259_INTS
+
 #endif /* __MACH_MPC85XX_CDS_H__ */
Index: arch/ppc/syslib/Makefile
===================================================================
--- bf16c711040aa5a00e5a6d6675869526b4dbfbb5/arch/ppc/syslib/Makefile  (mode:100644)
+++ b9da5c64c03fa695686baaa34e15cf0ca1bc48fd/arch/ppc/syslib/Makefile  (mode:100644)
@@ -97,7 +97,7 @@
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
 obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
-					ppc_sys.o mpc85xx_sys.o \
+					ppc_sys.o i8259.o mpc85xx_sys.o \
 					mpc85xx_devices.o
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
Index: arch/ppc/syslib/ppc85xx_setup.c
===================================================================
--- bf16c711040aa5a00e5a6d6675869526b4dbfbb5/arch/ppc/syslib/ppc85xx_setup.c  (mode:100644)
+++ b9da5c64c03fa695686baaa34e15cf0ca1bc48fd/arch/ppc/syslib/ppc85xx_setup.c  (mode:100644)
@@ -132,6 +132,12 @@
 }
 
 #ifdef CONFIG_PCI
+
+#if defined(CONFIG_MPC8555_CDS)
+extern void mpc85xx_cds_enable_via(struct pci_controller *hose);
+extern void mpc85xx_cds_fixup_via(struct pci_controller *hose);
+#endif
+
 static void __init
 mpc85xx_setup_pci1(struct pci_controller *hose)
 {
@@ -302,7 +308,17 @@
 
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 
+#if defined(CONFIG_MPC8555_CDS)
+	/* Pre pciauto_bus_scan VIA init */
+	mpc85xx_cds_enable_via(hose_a);
+#endif
+
 	hose_a->last_busno = pciauto_bus_scan(hose_a, hose_a->first_busno);
+
+#if defined(CONFIG_MPC8555_CDS)
+	/* Post pciauto_bus_scan VIA fixup */
+	mpc85xx_cds_fixup_via(hose_a);
+#endif
 
 #ifdef CONFIG_85xx_PCI2
 	hose_b = pcibios_alloc_controller();
