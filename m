Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTBDWZz>; Tue, 4 Feb 2003 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbTBDWZz>; Tue, 4 Feb 2003 17:25:55 -0500
Received: from fmr02.intel.com ([192.55.52.25]:48341 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267500AbTBDWZM>; Tue, 4 Feb 2003 17:25:12 -0500
Subject: [PATCH][2.5.59-bk]Sysfs interface for ZT5550 Redundant Host
	Controller
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Scott Murray <scottm@somanetworks.com>, Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Stanley Wang <stanley.wang@linux.co.intel.com>
Content-Type: multipart/mixed; boundary="=-cZ23kW2RW4/b/0VQ0pSe"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Feb 2003 14:33:15 -0800
Message-Id: <1044397997.1114.6.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cZ23kW2RW4/b/0VQ0pSe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Last week I finally got access to a decent (but old) technical specification
for the ZT5550 redundant host controller.  The document was published for
the ZT5550C, but I am hoping that newer versions of the RHC just add more
functionality to all the documented reserved bits in the document I am looking
at.

The following patch adds a sysfs interface to most of the bits accessible
via the indirect register (through the HCINDEX and HCDATA addresses in the
Command and Status Register (CSR).  The only bits I did not add access to
were the ones that are cleared by reading. There are a lot of bits to get 
access to, which makes this patch a little bigger then I first expected, 
so I created a new config option so only people who actually want to mess 
with the RHC would pay for it.

Enabling this code will cause a new directory called zt5550_rhc to be
created in the root of sysfs, with the following tree:

[rusty@penguin sysfs]$ tree zt5550_rhc
zt5550_rhc/
|-- diag                 <== fault injection capabilities
|   |-- diag_b0_serr
|   |-- diag_cputemp
|   |-- diag_iochk
|   |-- diag_nmi
|   |-- diag_perr
|   |-- diag_power_fail
|   `-- diag_wd_timeout
|-- fltc                 <== configurable actions for given faults
|   |-- b0_serr
|   |-- cputemp
|   |-- eject_ah
|   |-- eject_bh
|   |-- hard_reset
|   |-- iochk
|   |-- nmi
|   |-- perr
|   |-- power_fail
|   |-- soft_reset
|   `-- wd_timeout
|-- hcc                 <== various commands
|   |-- ah_s1_response
|   |-- bh_s1_response
|   |-- configuration_mode
|   |-- diagnostics_mode
|   |-- initiate_takeover
|   |-- power_down_bh
|   |-- reset
|   |-- reset_bh
|   |-- s1_bp_reset
|   |-- s2_bp_reset
|   |-- warm_boot
|   `-- wd_enable
|-- hci                 <== interrupt mask settings
|   |-- fault_interrupt_mask
|   |-- hcf_interrupt_mask
|   `-- serial_interrupt_mask
|-- isoc                <== isolation configuration
|   |-- bp_interrupt_mask
|   |-- friendly
|   |-- hostile
|   |-- s1_bp_reset_mask
|   |-- s2_bp_reset_mask
|   `-- unlock
|-- pmcc               <== control of PCI Mezzanine Cards
|   |-- pmc1_command2
|   |-- pmc1_command4
|   |-- pmc1_status
|   |-- pmc2_command2
|   |-- pmc2_command4
|   `-- pmc2_status
`-- wdc                <== watchdog timer configuration
    |-- prescaler
    `-- terminal_count

This provides all kind of rope to hang yourself with, but it was 
fun messing with it.  This also points out other areas where an interested
party could further enable this particular board, for example adding the
code to respond to a fault condition (after enabling fault handling
through sysfs).

This patch was generated off of today's bk tree with the previously posted 
patch by Scott to fix the deadlock issue and the patch posted by Stanley 
to add sysfs support.  Both of these patches are attached as a single
patch to this email message.

			       --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.982   -> 1.983  
#	drivers/hotplug/cpcihp_zt5550.h	1.2     -> 1.3    
#	drivers/hotplug/Kconfig	1.5     -> 1.6    
#	drivers/hotplug/cpcihp_zt5550.c	1.2     -> 1.3    
#	drivers/hotplug/Makefile	1.12    -> 1.13   
#	               (new)	        -> 1.1     drivers/hotplug/cpcihp_zt5550_rhc.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/04	rusty@penguin.co.intel.com	1.983
# Adding a sysfs inteface for the zt5550 redundant host controller
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/Kconfig b/drivers/hotplug/Kconfig
--- a/drivers/hotplug/Kconfig	Tue Feb  4 13:50:01 2003
+++ b/drivers/hotplug/Kconfig	Tue Feb  4 13:50:01 2003
@@ -101,6 +101,23 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_CPCI_ZT5550_RHC
+	bool "Ziatech ZT5550 CompactPCI RHC Sysfs Interface"
+	depends on HOTPLUG_PCI_CPCI_ZT5550
+	help
+	  Say Y here if you have an Performance Technologies (formerly Intel,
+          formerly just Ziatech) Ziatech ZT5550 CompactPCI system card, and
+          would like to have configuration access to the onboard 
+          Redundant Host Controller.
+
+          Saying Y here will cause a new "zt5550_rhc" directory to be created
+          in the root of your sysfs, with a directory for each of the rhc
+          indirect registers created inside the zt5550_rhc directory, and then
+          control files in each of those directorys giving user space access
+          to all of the bits in those indirect registers.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_CPCI_GENERIC
 	tristate "Generic port I/O CompactPCI Hotplug driver"
 	depends on HOTPLUG_PCI_CPCI && X86
diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Tue Feb  4 13:50:01 2003
+++ b/drivers/hotplug/Makefile	Tue Feb  4 13:50:01 2003
@@ -7,6 +7,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
+obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550_RHC)	+= cpcihp_zt5550_rhc.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o	\
diff -Nru a/drivers/hotplug/cpcihp_zt5550.c b/drivers/hotplug/cpcihp_zt5550.c
--- a/drivers/hotplug/cpcihp_zt5550.c	Tue Feb  4 13:50:01 2003
+++ b/drivers/hotplug/cpcihp_zt5550.c	Tue Feb  4 13:50:01 2003
@@ -35,6 +35,8 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <linux/kobject.h>
+#include <linux/bitops.h>
 #include "cpci_hotplug.h"
 #include "cpcihp_zt5550.h"
 
@@ -42,22 +44,6 @@
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"ZT5550 CompactPCI Hot Plug Driver"
 
-#if !defined(CONFIG_HOTPLUG_PCI_CPCI_ZT5550_MODULE)
-#define MY_NAME	"cpcihp_zt5550"
-#else
-#define MY_NAME	THIS_MODULE->name
-#endif
-
-#define dbg(format, arg...)					\
-	do {							\
-		if(debug)					\
-			printk (KERN_DEBUG "%s: " format "\n",	\
-				MY_NAME , ## arg); 		\
-	} while(0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
-
 /* local variables */
 static int debug;
 static int poll;
@@ -75,8 +61,8 @@
 
 /* Host controller register addresses */
 static void *hc_registers;
-static void *csr_hc_index;
-static void *csr_hc_data;
+void *csr_hc_index;
+void *csr_hc_data;
 static void *csr_intstat;
 static void *csr_intmask;
 
@@ -259,12 +245,12 @@
 	}
 	dbg("registered controller");
 
-	if(hcf_hcs & HCS_BUS1_ACTIVE) {
+	if(hcf_hcs & HCS_BUS1_ACTIVE_MASK) {
 		status = zt5550_register_bus(BUS1_SLOT, &bus1_dev, &bus1);
 		if(status)
 			goto init_register_error;
 	}
-	if(hcf_hcs & HCS_BUS2_ACTIVE) {
+	if(hcf_hcs & HCS_BUS2_ACTIVE_MASK) {
 		status = zt5550_register_bus(BUS2_SLOT, &bus2_dev, &bus2);
 		if(status)
 			goto init_register_error;
@@ -318,13 +304,20 @@
 
 static int __init zt5550_init(void)
 {
+	int rv;
+
 	info(DRIVER_DESC " version: " DRIVER_VERSION);
-	return pci_module_init(&zt5550_hc_driver);
+	rv = pci_module_init(&zt5550_hc_driver);
+	if (!rv)
+		create_hc_files(csr_hc_index,csr_hc_data);
+
+	return rv;
 }
 
 static void __exit
 zt5550_exit(void)
 {
+	remove_hc_files();
 	pci_unregister_driver(&zt5550_hc_driver);
 	release_region(ENUM_PORT, 1);
 }
diff -Nru a/drivers/hotplug/cpcihp_zt5550.h b/drivers/hotplug/cpcihp_zt5550.h
--- a/drivers/hotplug/cpcihp_zt5550.h	Tue Feb  4 13:50:01 2003
+++ b/drivers/hotplug/cpcihp_zt5550.h	Tue Feb  4 13:50:01 2003
@@ -33,6 +33,22 @@
 #ifndef _CPCIHP_ZT5550_H
 #define _CPCIHP_ZT5550_H
 
+#if !defined(CONFIG_HOTPLUG_PCI_CPCI_ZT5550_MODULE)
+#define MY_NAME	"cpcihp_zt5550"
+#else
+#define MY_NAME	THIS_MODULE->name
+#endif
+
+#define dbg(format, arg...)					\
+	do {							\
+		if(debug)					\
+			printk (KERN_DEBUG "%s: " format "\n",	\
+				MY_NAME , ## arg); 		\
+	} while(0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+
 /* Direct registers */
 #define CSR_HCINDEX		0x00
 #define CSR_HCDATA		0x04
@@ -44,12 +60,40 @@
 #define CSR_TIM0		0x10
 #define CSR_TIM1		0x14
 
+/* Masks for bits in CSR_INTSTAT (interrupt status) direct register */
+#define INTSTAT_SERIAL_FLAG     0x01
+#define INTSTAT_FAULT_FLAG      0x02
+#define INTSTAT_HCS_FLAG        0x04
+#define INTSTAT_TIM0_FLAG       0x08
+#define INTSTAT_TIM1_FLAG       0x10
+#define INTSTAT_ENUM_FLAG       0x20
+
 /* Masks for interrupt bits in CSR_INTMASK direct register */
 #define INTMASK_TIM0_INT_MASK	0x01
 #define INTMASK_TIM1_INT_MASK	0x02
 #define INTMASK_ENUM_INT_MASK	0x04
 #define INTMASK_ALL_INTS_MASK	0x07
 
+/* Mask for bits in CSR_ENET (ethernet routing) direct register */
+#define ENET_A_REAR             0x01
+#define ENET_B_ROUTING          0x60
+
+/* Mask for bits in the CSR_T0_C (timer #0 control) direct register */
+#define T0_C_ENABLE             0x0001
+#define T0_C_TIMEOUT_MODE       0x0002
+#define T0_C_CLOCK_SOURCE       0x000c
+#define T0_C_READ_MODE          0x0030
+#define T0_C_WRITE_MODE         0x0040
+#define T0_C_OUTPUT_FLAG        0x0080
+
+/* Mask for bits in the CSR_T1_C (timer #1 control) direct register */
+#define T1_C_ENABLE             0x0001
+#define T1_C_TIMEOUT_MODE       0x0002
+#define T1_C_CLOCK_SOURCE       0x000c
+#define T1_C_READ_MODE          0x0030
+#define T1_C_WRITE_MODE         0x0040
+#define T1_C_OUTPUT_FLAG        0x0080
+
 /* Indexed registers (through CSR_HCINDEX, CSR_HCDATA) */
 #define HCF_HCI			0x04
 #define HCF_HCS			0x08
@@ -65,32 +109,233 @@
 #define HCF_SDO			0x38
 #define HCF_SDI			0x3C
 
-/* Masks for interrupt bits in HCF_HCI indexed register */
+/* Masks for interrupt bits in HCF_HCI          */
+/* (host controller interrupt) indexed register */
 #define HCI_SERIAL_INT_MASK	0x01
 #define HCI_FAULT_INT_MASK	0x02
 #define HCI_HCF_INT_MASK	0x04
 #define HCI_ALL_INTS_MASK	0x07
 
-/* Masks for the bits in the HCF_HCS indexed register */
-#define HCS_HA			0x00000001
-#define HCS_ACTIVE		0x00000002
-#define HCS_RH_STATE		0x00000004
-#define HCS_HARD_RESET		0x00000008
-#define HCS_SOFT_RESET		0x00000010
-#define HCS_RH_ALIVE		0x00000020
-#define HCS_SWITCH_OVER		0x00000040
-#define HCS_TAKEOVER_TYPE	0x00000080
-#define HCS_BUS1_ACTIVE		0x00000100
-#define HCS_BUS2_ACTIVE		0x00000200
-#define HCS_SPLIT_MODE_ERROR	0x00000400
+/* Masks for the bits in the HCF_HCS         */
+/* (host controller status) indexed register */
+#define HCS_HA_MASK     	0x00000001
+#define HCS_ACTIVE_MASK		0x00000002
+#define HCS_RH_STATE_MASK	0x00000004
+#define HCS_HARD_RESET_MASK	0x00000008
+#define HCS_SOFT_RESET_MASK	0x00000010
+#define HCS_RH_ALIVE_MASK	0x00000020
+#define HCS_SWITCH_OVER_MASK	0x00000040
+#define HCS_TAKEOVER_TYPE_MASK	0x00000080
+#define HCS_BUS1_ACTIVE_MASK	0x00000100
+#define HCS_BUS2_ACTIVE_MASK	0x00000200
+#define HCS_SPLIT_MODE_ERR_MASK	0x00000400
+
+/* Masks for the bits in the HCF_HCC          */
+/* (host controller command) indexed register */
+#define HCC_RESET_MASK          0x00000001
+#define HCC_DIAG_MODE_MASK      0x00000002
+#define HCC_CONFIG_MODE_MASK    0x00000004
+#define HCC_S2_BP_RESET_MASK    0x00000008
+#define HCC_S1_BP_RESET_MASK    0x00000010
+#define HCC_WARM_BOOT_MASK      0x00000020
+#define HCC_INIT_TAKEOVER_MASK  0x00000040
+#define HCC_WD_ENABLE_MASK      0x00000080
+#define HCC_RESET_BH_MASK       0x00000100
+#define HCC_POWER_DOWN_BH_MASK  0x00000200
+#define HCC_BH_S1_RESPONSE_MASK 0x00001000
+#define HCC_AH_S1_RESPONSE_MASK 0x00002000
+
+/* Masks for the bits in the HCF_ARBC           */
+/* (arbitration configuration) indexed register */
+#define ARBC_S1_GNT0_MASK       0x00000001
+#define ARBC_S1_GNT1_MASK       0x00000002
+#define ARBC_S1_GNT2_MASK       0x00000004
+#define ARBC_S1_GNT3_MASK       0x00000008
+#define ARBC_S1_GNT4_MASK       0x00000010
+#define ARBC_S1_GNT5_MASK       0x00000020
+#define ARBC_S1_GNT6_MASK       0x00000040
+#define ARBC_S1_GNT7_MASK       0x00000080
+#define ARBC_S2_GNT0_MASK       0x00000100
+#define ARBC_S2_GNT1_MASK       0x00000200
+#define ARBC_S2_GNT2_MASK       0x00000400
+#define ARBC_S2_GNT3_MASK       0x00000800
+#define ARBC_S2_GNT4_MASK       0x00001000
+#define ARBC_S2_GNT5_MASK       0x00002000
+#define ARBC_S2_GNT6_MASK       0x00004000
+#define ARBC_S2_GNT7_MASK       0x00008000
+
+/* Masks for the bits in the HCF_ISOC         */
+/* (isolation configuration) indexed register */
+#define ISOC_UNLOCK_MASK        0x00000001
+#define ISOC_S1_BP_RESET_MASK   0x00000002
+#define ISOC_S2_BP_RESET_MASK   0x00000004
+#define ISOC_BP_INTERRUPT_MASK  0x00000008
+#define ISOC_HOSTILE_MASK       0x00000030
+#define ISOC_FRIENDLY_MASK      0x000000c0
+
+/* Masks for the bits in the HCF_FLTS (fault status) indexed register */
+#define FLTS_WD_TIMEOUT_MASK    0x00000001
+#define FLTS_PERR_MASK          0x00000002
+#define FLTS_IOCHK_MASK         0x00000004
+#define FLTS_NMI_MASK           0x00000008
+#define FLTS_B0_SERR_MASK       0x00000010
+#define FLTS_CPUTEMP_MASK       0x00000040
+#define FLTS_POWER_FAIL_MASK    0x00000080
+#define FLTS_EJECT_BH_MASK      0x00000100
+#define FLTS_EJECT_AH_MASK      0x00000200
+
+/* Masks for the bits in the HCF_FLTC (fault configuration) indexed register */
+#define FLTC_WD_TIMEOUT_MASK    0x00000007
+#define FLTC_PERR_MASK          0x00000038
+#define FLTC_IOCHK_MASK         0x000001c0
+#define FLTC_NMI_MASK           0x00000e00
+#define FLTC_B0_SERR_MASK       0x00007000
+#define FLTC_CPUTEMP_MASK       0x001c0000
+#define FLTC_POWER_FAIL_MASK    0x00e00000
+#define FLTC_EJECT_BH_MASK      0x07000000
+#define FLTC_EJECT_AH_MASK      0x38000000
+#define FLTC_SOFT_RESET_MASK    0x40000000
+#define FLTC_HARD_RESET_MASK    0x80000000
+
+/* Masks for the bits in the HCF_PMCC (PMC control) indexed register */
+#define PMCC_PMC1_STATUS_MASK   0x00000001
+#define PMCC_PMC1_COMMAND2_MASK 0x00000002
+#define PMCC_PMC1_COMMAND4_MASK 0x00000004
+#define PMCC_PMC2_STATUS_MASK   0x00000010
+#define PMCC_PMC2_COMMAND2_MASK 0x00000020
+#define PMCC_PMC2_COMMAND4_MASK 0x00000040
+
+/* Masks for the bits in the HCF_WDC (watchdog control) indexed register */
+#define WDC_TERMINAL_COUNT_MASK 0x0000003f
+#define WDC_PRESCALER_MASK      0x000000c0
+
+/* Masks for the bits in the HCF_DIAG (diagnostics command) indexed register */
+#define DIAG_WD_TIMEOUT_MASK    0x00000001
+#define DIAG_PERR_MASK          0x00000002
+#define DIAG_IOCHK_MASK         0x00000004
+#define DIAG_NMI_MASK           0x00000008
+#define DIAG_B0_SERR_MASK       0x00000010
+#define DIAG_CPUTEMP_MASK       0x00000040
+#define DIAG_POWER_FAIL_MASK    0x00000080
+
+/* Masks for the bits in the HCF_SERC (diagnostics command) indexed register */
+#define SERC_DATA_SENT          0x00000001
+#define SERC_DATA_RECIEVED      0x00000002
+#define SERC_SDO_FLAG_ENABLE    0x00000004
+#define SERC_SDI_FLAG_ENABLE    0x00000008
+#define SERC_HCSI_OFF           0x00000010
+#define SERC_FIND_TOKEN         0x00000020
 
 /* CompactPCI bus segment device slot numbers */
 #define BUS1_SLOT		0x08
 #define BUS2_SLOT		0x0C
 
+/* I/O port for setting and configuring watchdog timer */
+#define WDT_PORT       0x79
+
+/* Masks for bits written/read from the watchdog timer port */
+#define WDT_TERMINAL_COUNT      0x07
+#define WDT_FIRST_STAGE_ENABLE  0x10
+#define WDT_RESET_ENABLE        0x20
+#define WDT_FIRST_STAGE_MONITOR 0x40
+#define WDT_RESET_MONITOR       0x80
+
 /* Digital I/O port storing ENUM# */
 #define ENUM_PORT	0xE1
 /* Mask to get to the ENUM# bit on the bus */
 #define ENUM_MASK	0x40
 
+#define hcf_read(index, value, csr_hc_index, csr_hc_data) \
+        { \
+                writeb((u8) index, csr_hc_index); \
+                value = readl(csr_hc_data); \
+                dbg("hcf_read(0x%08x, 0x%08x)",index,value); \
+        }
+
+#define hcf_write(index, value, csr_hc_index, csr_hc_data) \
+        { \
+                writeb((u8) index, csr_hc_index); \
+                writel(value, csr_hc_data); \
+                dbg("hcf_write(0x%08x, 0x%08x)",index,value); \
+        }
+
+#define hcf_set_bit(index, bit, csr_hc_index, csr_hc_data) \
+        { \
+                int tmp; \
+		hcf_read(index, tmp, csr_hc_index, csr_hc_data); \
+		hcf_write(index, tmp|bit, csr_hc_index, csr_hc_data); \
+                dbg("hcf_set_bit(0x%08x, 0x%08x)",index,bit); \
+	}
+                
+#define hcf_clear_bit(index, bit, csr_hc_index, csr_hc_data) \
+        { \
+                int tmp; \
+		hcf_read(index, tmp, csr_hc_index, csr_hc_data); \
+		hcf_write(index, tmp & ~bit, csr_hc_index, csr_hc_data); \
+                dbg("hcf_clear_bit(0x%08x, 0x%08x)",index,bit); \
+	}
+
+#define hcf_write_bits(index, mask, request, csr_hc_index, csr_hc_data) \
+        { \
+		int tmp; \
+                dbg("hcf_write_bits(0x%08x, 0x%08x, 0x%08x)", \
+                     index,mask,request); \
+		request = request << (generic_ffs(mask) - 1); \
+		request &= mask; \
+		request |= ~mask; \
+		hcf_read(index, tmp, csr_hc_index, csr_hc_data); \
+		tmp |= mask; \
+		tmp &= request; \
+		hcf_write(index, tmp, csr_hc_index, csr_hc_data); \
+	}
+
+#define hcf_read_bits(index, mask, value, csr_hc_index, csr_hc_data) \
+        { \
+                hcf_read(index, value, csr_hc_index, csr_hc_data); \
+                value = (mask&value)>>(generic_ffs(mask) - 1); \
+                dbg("hcf_read_bits(0x%08x, 0x%08x, 0x%08x)", \
+                     index,mask,value); \
+	} 
+
+#define decl_hc_attribute(_name) \
+static struct rhc_attribute _name##_attr = { \
+	.attr	= { .name = __stringify(_name), .mode = 0644 }, \
+	.show	= _name##_show, \
+	.store  = _name##_store, \
+}
+
+#define decl_hc_kobject(_name) \
+static struct rhc _name##_obj = { \
+	.kobj.name = __stringify(_name), \
+}
+
+
+#define decl_hc_show_function(_name, _index, _mask) \
+static ssize_t _name##_show(struct rhc * p, char * page) \
+{ \
+	int tmp; \
+	hcf_read_bits(_index, _mask, tmp, p->index, p->data); \
+	return sprintf(page,"%d\n", tmp); \
+}
+
+#define decl_hc_store_function(_name, _index, _mask) \
+static ssize_t _name##_store(struct rhc * p, const char * page, size_t count) \
+{ \
+	int request; \
+	if (sscanf(page, "%i", &request)) {\
+		hcf_write_bits(_index, _mask, request, p->index, p->data); \
+		return count; \
+	} \
+	return -EINVAL; \
+}
+
+#ifdef CONFIG_HOTPLUG_PCI_CPCI_ZT5550_RHC
+extern void create_hc_files(void *index,void *data);
+extern void remove_hc_files(void);
+#else /* !CONFIG_HOTPLUG_PCI_CPCI_ZT5550_RHC */
+static inline void create_hc_files(void *index,void *data){}
+static inline void remove_hc_files(void){}
+#endif
+
 #endif				/* _CPCIHP_ZT5550_H */
+
diff -Nru a/drivers/hotplug/cpcihp_zt5550_rhc.c b/drivers/hotplug/cpcihp_zt5550_rhc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpcihp_zt5550_rhc.c	Tue Feb  4 13:50:01 2003
@@ -0,0 +1,538 @@
+/*
+ * cpcihp_zt5550.c
+ *
+ * Intel/Ziatech ZT5550 CompactPCI Redundant Host Controller Sysfs Interface
+ *
+ * Copyright 2002 SOMA Networks, Inc.
+ * Copyright 2001 Intel San Luis Obispo
+ * Copyright 2000,2001 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/kobject.h>
+#include <linux/bitops.h>
+#include "cpci_hotplug.h"
+#include "cpcihp_zt5550.h"
+
+extern int debug;
+extern void *csr_hc_index;
+extern void *csr_hc_data;
+
+struct rhc {
+	void *index;
+	void *data;
+	struct kobject kobj;
+};
+struct rhc_attribute {
+	struct attribute attr;
+	ssize_t (*show) (struct rhc *,char *);
+	ssize_t (*store)(struct rhc *,const char *, size_t);
+};
+
+static ssize_t rhc_attr_show(struct kobject * kobj, 
+			     struct attribute * attr,
+			     char * page)
+{
+	struct rhc * i = container_of(kobj,struct rhc,kobj);
+	struct rhc_attribute * rhc_attr = 
+		container_of(attr,struct rhc_attribute,attr);
+	
+	return rhc_attr->show ? rhc_attr->show(i,page) : 0;
+}
+
+static ssize_t rhc_attr_store(struct kobject * kobj, 
+			      struct attribute * attr,
+			      const char * page,
+			      size_t count)
+{
+	struct rhc * i = container_of(kobj,struct rhc,kobj);
+	struct rhc_attribute * rhc_attr = 
+		container_of(attr,struct rhc_attribute,attr);
+
+	return rhc_attr->store ? rhc_attr->store(i,page,count) : 0;
+}
+
+static struct sysfs_ops rhc_sysfs_ops = {
+	.show	= rhc_attr_show,
+	.store  = rhc_attr_store,
+};
+
+static struct kobj_type rhc_ktype = {
+	.sysfs_ops = &rhc_sysfs_ops
+};
+
+static struct subsystem rhc_subsys = {
+	.kset = {
+		.kobj = { .name = "zt5550_rhc" },
+		.ktype = &rhc_ktype,
+	}
+};
+
+/**********************************************************************
+ * Host Control Interrupt register attributes
+ */
+decl_hc_kobject(hci);
+
+/* Host Control Function Interrupt Mask */
+decl_hc_store_function(hcf_interrupt_mask,HCF_HCI,HCI_HCF_INT_MASK);
+decl_hc_show_function(hcf_interrupt_mask,HCF_HCI,HCI_HCF_INT_MASK);
+decl_hc_attribute(hcf_interrupt_mask);
+
+/* Fault Interrupt Mask */
+decl_hc_store_function(fault_interrupt_mask,HCF_HCI,HCI_FAULT_INT_MASK);
+decl_hc_show_function(fault_interrupt_mask,HCF_HCI,HCI_FAULT_INT_MASK);
+decl_hc_attribute(fault_interrupt_mask);
+
+/* Serial Communications Interrupt Mask */
+decl_hc_store_function(serial_interrupt_mask,HCF_HCI,HCI_SERIAL_INT_MASK);
+decl_hc_show_function(serial_interrupt_mask,HCF_HCI,HCI_SERIAL_INT_MASK);
+decl_hc_attribute(serial_interrupt_mask);
+
+/**********************************************************************
+ * Host Control Command attributes
+ * NOTE: The HCC register is by default locked. To change any
+ *       value, first unlock by writing a '1' to the UNLOCK bit
+ *       in the ISOC register.
+ */
+decl_hc_kobject(hcc);
+
+/* Reset Command */
+decl_hc_store_function(reset,HCF_HCC,HCC_RESET_MASK);
+decl_hc_show_function(reset,HCF_HCC,HCC_RESET_MASK);
+decl_hc_attribute(reset);
+
+/* Diagnostics Mode Command */
+decl_hc_store_function(diagnostics_mode,HCF_HCC,HCC_DIAG_MODE_MASK);
+decl_hc_show_function(diagnostics_mode,HCF_HCC,HCC_DIAG_MODE_MASK);
+decl_hc_attribute(diagnostics_mode);
+
+/* Configuration Mode Command */
+decl_hc_store_function(configuration_mode,HCF_HCC,HCC_CONFIG_MODE_MASK);
+decl_hc_show_function(configuration_mode,HCF_HCC,HCC_CONFIG_MODE_MASK);
+decl_hc_attribute(configuration_mode);
+
+/* S1 Backplane Reset Command */
+decl_hc_store_function(s1_bp_reset,HCF_HCC,HCC_S1_BP_RESET_MASK);
+decl_hc_show_function(s1_bp_reset,HCF_HCC,HCC_S1_BP_RESET_MASK);
+decl_hc_attribute(s1_bp_reset);
+
+/* S2 Backplane Reset Command */
+decl_hc_store_function(s2_bp_reset,HCF_HCC,HCC_S2_BP_RESET_MASK);
+decl_hc_show_function(s2_bp_reset,HCF_HCC,HCC_S2_BP_RESET_MASK);
+decl_hc_attribute(s2_bp_reset);
+
+/* Warm Boot Flag */
+decl_hc_store_function(warm_boot,HCF_HCC,HCC_WARM_BOOT_MASK);
+decl_hc_show_function(warm_boot,HCF_HCC,HCC_WARM_BOOT_MASK);
+decl_hc_attribute(warm_boot);
+
+/* Initiate Takeover Command */
+decl_hc_store_function(initiate_takeover,HCF_HCC,HCC_INIT_TAKEOVER_MASK);
+decl_hc_show_function(initiate_takeover,HCF_HCC,HCC_INIT_TAKEOVER_MASK);
+decl_hc_attribute(initiate_takeover);
+
+/* Watchdog Enable Command */
+decl_hc_store_function(wd_enable,HCF_HCC,HCC_WD_ENABLE_MASK);
+decl_hc_show_function(wd_enable,HCF_HCC,HCC_WD_ENABLE_MASK);
+decl_hc_attribute(wd_enable);
+
+/* Reset Backup Host Command*/
+decl_hc_store_function(reset_bh,HCF_HCC,HCC_RESET_BH_MASK);
+decl_hc_show_function(reset_bh,HCF_HCC,HCC_RESET_BH_MASK);
+decl_hc_attribute(reset_bh);
+
+/* Power Down Backup Host Command */
+decl_hc_store_function(power_down_bh,HCF_HCC,HCC_POWER_DOWN_BH_MASK);
+decl_hc_show_function(power_down_bh,HCF_HCC,HCC_POWER_DOWN_BH_MASK);
+decl_hc_attribute(power_down_bh);
+
+/* Backup Host S1 PRST Response (1=hard reset, 0=ignore)*/
+decl_hc_store_function(bh_s1_response,HCF_HCC,HCC_BH_S1_RESPONSE_MASK);
+decl_hc_show_function(bh_s1_response,HCF_HCC,HCC_BH_S1_RESPONSE_MASK);
+decl_hc_attribute(bh_s1_response);
+
+/* Active Host S1 PRST Response (1=hard reset, 0=ignore)*/
+decl_hc_store_function(ah_s1_response,HCF_HCC,HCC_AH_S1_RESPONSE_MASK);
+decl_hc_show_function(ah_s1_response,HCF_HCC,HCC_AH_S1_RESPONSE_MASK);
+decl_hc_attribute(ah_s1_response);
+
+/**********************************************************************
+ * Isolation Configuration register (ISOC) attributes
+ */
+decl_hc_kobject(isoc);
+
+/* HCC Unlock Command */
+decl_hc_store_function(unlock,HCF_ISOC,ISOC_UNLOCK_MASK);
+decl_hc_show_function(unlock,HCF_ISOC,ISOC_UNLOCK_MASK);
+decl_hc_attribute(unlock);
+
+/* S1 Backplane Reset Mask */
+decl_hc_store_function(s1_bp_reset_mask,HCF_ISOC,ISOC_S1_BP_RESET_MASK);
+decl_hc_show_function(s1_bp_reset_mask,HCF_ISOC,ISOC_S1_BP_RESET_MASK);
+decl_hc_attribute(s1_bp_reset_mask);
+
+/* S2 Backplane Reset Mask */
+decl_hc_store_function(s2_bp_reset_mask,HCF_ISOC,ISOC_S2_BP_RESET_MASK);
+decl_hc_show_function(s2_bp_reset_mask,HCF_ISOC,ISOC_S2_BP_RESET_MASK);
+decl_hc_attribute(s2_bp_reset_mask);
+
+/* Backplane Interrupt Mask */
+decl_hc_store_function(bp_interrupt_mask,HCF_ISOC,ISOC_BP_INTERRUPT_MASK);
+decl_hc_show_function(bp_interrupt_mask,HCF_ISOC,ISOC_BP_INTERRUPT_MASK);
+decl_hc_attribute(bp_interrupt_mask);
+
+/* Hostile Configuration (what happens on a hostile takeover)*/
+decl_hc_store_function(hostile,HCF_ISOC,ISOC_HOSTILE_MASK);
+decl_hc_show_function(hostile,HCF_ISOC,ISOC_HOSTILE_MASK);
+decl_hc_attribute(hostile);
+
+/* Friendly Configuration (what happens on a friendly takeover)*/
+decl_hc_store_function(friendly,HCF_ISOC,ISOC_FRIENDLY_MASK);
+decl_hc_show_function(friendly,HCF_ISOC,ISOC_FRIENDLY_MASK);
+decl_hc_attribute(friendly);
+
+
+/**********************************************************************
+ * Fault Configuration register (FLTC) attributes
+ */
+decl_hc_kobject(fltc);
+
+/* Watchdog Timeout Configuration */
+decl_hc_store_function(wd_timeout,HCF_FLTC,FLTC_WD_TIMEOUT_MASK);
+decl_hc_show_function(wd_timeout,HCF_FLTC,FLTC_WD_TIMEOUT_MASK);
+decl_hc_attribute(wd_timeout);
+
+/* PERR Configuration */
+decl_hc_store_function(perr,HCF_FLTC,FLTC_PERR_MASK);
+decl_hc_show_function(perr,HCF_FLTC,FLTC_PERR_MASK);
+decl_hc_attribute(perr);
+
+/* IOCHK Configuration */
+decl_hc_store_function(iochk,HCF_FLTC,FLTC_IOCHK_MASK);
+decl_hc_show_function(iochk,HCF_FLTC,FLTC_IOCHK_MASK);
+decl_hc_attribute(iochk);
+
+/* NMI Configuration */
+decl_hc_store_function(nmi,HCF_FLTC,FLTC_NMI_MASK);
+decl_hc_show_function(nmi,HCF_FLTC,FLTC_NMI_MASK);
+decl_hc_attribute(nmi);
+
+/* B0_SERR Configuration */
+decl_hc_store_function(b0_serr,HCF_FLTC,FLTC_B0_SERR_MASK);
+decl_hc_show_function(b0_serr,HCF_FLTC,FLTC_B0_SERR_MASK);
+decl_hc_attribute(b0_serr);
+
+/* CPUTEMP Configuration */
+decl_hc_store_function(cputemp,HCF_FLTC,FLTC_CPUTEMP_MASK);
+decl_hc_show_function(cputemp,HCF_FLTC,FLTC_CPUTEMP_MASK);
+decl_hc_attribute(cputemp);
+
+/* Power Fail Configuration */
+decl_hc_store_function(power_fail,HCF_FLTC,FLTC_POWER_FAIL_MASK);
+decl_hc_show_function(power_fail,HCF_FLTC,FLTC_POWER_FAIL_MASK);
+decl_hc_attribute(power_fail);
+
+/* Eject BH Configuration */
+decl_hc_store_function(eject_bh,HCF_FLTC,FLTC_EJECT_BH_MASK);
+decl_hc_show_function(eject_bh,HCF_FLTC,FLTC_EJECT_BH_MASK);
+decl_hc_attribute(eject_bh);
+
+/* Eject AH Configuration */
+decl_hc_store_function(eject_ah,HCF_FLTC,FLTC_EJECT_AH_MASK);
+decl_hc_show_function(eject_ah,HCF_FLTC,FLTC_EJECT_AH_MASK);
+decl_hc_attribute(eject_ah);
+
+/* Soft Reset Configuration */
+decl_hc_store_function(soft_reset,HCF_FLTC,FLTC_SOFT_RESET_MASK);
+decl_hc_show_function(soft_reset,HCF_FLTC,FLTC_SOFT_RESET_MASK);
+decl_hc_attribute(soft_reset);
+
+/* Hard Reset Configuration */
+decl_hc_store_function(hard_reset,HCF_FLTC,FLTC_HARD_RESET_MASK);
+decl_hc_show_function(hard_reset,HCF_FLTC,FLTC_HARD_RESET_MASK);
+decl_hc_attribute(hard_reset);
+
+/**********************************************************************
+ * PCI Mezzanine Card (PMC) Control register
+ */
+decl_hc_kobject(pmcc);
+
+/* Input from PMC1 BUSMODE[1] (cleared if present and configured) */
+decl_hc_store_function(pmc1_status,HCF_PMCC,PMCC_PMC1_STATUS_MASK);
+decl_hc_show_function(pmc1_status,HCF_PMCC,PMCC_PMC1_STATUS_MASK);
+decl_hc_attribute(pmc1_status);
+
+/* Set to enable PMC1 as a PCI device */
+decl_hc_store_function(pmc1_command2,HCF_PMCC,PMCC_PMC1_COMMAND2_MASK);
+decl_hc_show_function(pmc1_command2,HCF_PMCC,PMCC_PMC1_COMMAND2_MASK);
+decl_hc_attribute(pmc1_command2);
+
+/* Clear to enable PMC1 as a PCI device */
+decl_hc_store_function(pmc1_command4,HCF_PMCC,PMCC_PMC1_COMMAND4_MASK);
+decl_hc_show_function(pmc1_command4,HCF_PMCC,PMCC_PMC1_COMMAND4_MASK);
+decl_hc_attribute(pmc1_command4);
+
+/* Input from PMC2 BUSMODE[1] (cleared if present and configured) */
+decl_hc_store_function(pmc2_status,HCF_PMCC,PMCC_PMC2_STATUS_MASK);
+decl_hc_show_function(pmc2_status,HCF_PMCC,PMCC_PMC2_STATUS_MASK);
+decl_hc_attribute(pmc2_status);
+
+/* Set to enable PMC2 as a PCI device */
+decl_hc_store_function(pmc2_command2,HCF_PMCC,PMCC_PMC2_COMMAND2_MASK);
+decl_hc_show_function(pmc2_command2,HCF_PMCC,PMCC_PMC2_COMMAND2_MASK);
+decl_hc_attribute(pmc2_command2);
+
+/* Clear to enable PMC2 as a PCI device */
+decl_hc_store_function(pmc2_command4,HCF_PMCC,PMCC_PMC2_COMMAND4_MASK);
+decl_hc_show_function(pmc2_command4,HCF_PMCC,PMCC_PMC2_COMMAND4_MASK);
+decl_hc_attribute(pmc2_command4);
+
+/**********************************************************************
+ * Watchdog Control (WDC) register attributes
+ */
+decl_hc_kobject(wdc);
+
+/* Watchdog Terminal Count (prescaler counts to timeout) */
+decl_hc_store_function(terminal_count,HCF_WDC,WDC_TERMINAL_COUNT_MASK);
+decl_hc_show_function(terminal_count,HCF_WDC,WDC_TERMINAL_COUNT_MASK);
+decl_hc_attribute(terminal_count);
+
+/* Watchdog Prescaler (clock period) */
+decl_hc_store_function(prescaler,HCF_WDC,WDC_PRESCALER_MASK);
+decl_hc_show_function(prescaler,HCF_WDC,WDC_PRESCALER_MASK);
+decl_hc_attribute(prescaler);
+
+/**********************************************************************
+ * Diagnostics (DIAG) register attributes: Setting any of these bits
+ * will cause the associated fault to be simulated.
+ */
+decl_hc_kobject(diag);
+
+/* Watchdog Timeout Diagnostic */
+decl_hc_store_function(diag_wd_timeout,HCF_DIAG,DIAG_WD_TIMEOUT_MASK);
+decl_hc_show_function(diag_wd_timeout,HCF_DIAG,DIAG_WD_TIMEOUT_MASK);
+decl_hc_attribute(diag_wd_timeout);
+
+/* PERR Diagnostic  */
+decl_hc_store_function(diag_perr,HCF_DIAG,DIAG_PERR_MASK);
+decl_hc_show_function(diag_perr,HCF_DIAG,DIAG_PERR_MASK);
+decl_hc_attribute(diag_perr);
+
+/* IOCHK Diagnostic */
+decl_hc_store_function(diag_iochk,HCF_DIAG,DIAG_IOCHK_MASK);
+decl_hc_show_function(diag_iochk,HCF_DIAG,DIAG_IOCHK_MASK);
+decl_hc_attribute(diag_iochk);
+
+/* NMI Diagnostic  */
+decl_hc_store_function(diag_nmi,HCF_DIAG,DIAG_NMI_MASK);
+decl_hc_show_function(diag_nmi,HCF_DIAG,DIAG_NMI_MASK);
+decl_hc_attribute(diag_nmi);
+
+/* B0 SERR Diagnostic */
+decl_hc_store_function(diag_b0_serr,HCF_DIAG,DIAG_B0_SERR_MASK);
+decl_hc_show_function(diag_b0_serr,HCF_DIAG,DIAG_B0_SERR_MASK);
+decl_hc_attribute(diag_b0_serr);
+
+/* CPUTEMP Diagnostic */
+decl_hc_store_function(diag_cputemp,HCF_DIAG,DIAG_CPUTEMP_MASK);
+decl_hc_show_function(diag_cputemp,HCF_DIAG,DIAG_CPUTEMP_MASK);
+decl_hc_attribute(diag_cputemp);
+
+/* Power Fail Diagnostic */
+decl_hc_store_function(diag_power_fail,HCF_DIAG,DIAG_POWER_FAIL_MASK);
+decl_hc_show_function(diag_power_fail,HCF_DIAG,DIAG_POWER_FAIL_MASK);
+decl_hc_attribute(diag_power_fail);
+
+void create_hc_files(void *index, void *data)
+{
+	if(subsystem_register(&rhc_subsys))
+		return;
+
+	/* hci */
+	hci_obj.index = index;
+	hci_obj.data = data;
+	kobj_set_kset_s(&hci_obj, rhc_subsys);
+	kobject_register(&hci_obj.kobj);
+	sysfs_create_file(&hci_obj.kobj, &hcf_interrupt_mask_attr.attr);
+	sysfs_create_file(&hci_obj.kobj, &fault_interrupt_mask_attr.attr);
+	sysfs_create_file(&hci_obj.kobj, &serial_interrupt_mask_attr.attr);
+
+	/* hcc */
+	hcc_obj.index = index;
+	hcc_obj.data = data;
+	kobj_set_kset_s(&hcc_obj, rhc_subsys);
+	kobject_register(&hcc_obj.kobj);
+	sysfs_create_file(&hcc_obj.kobj, &reset_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &diagnostics_mode_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &configuration_mode_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &s2_bp_reset_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &s1_bp_reset_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &warm_boot_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &initiate_takeover_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &wd_enable_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &reset_bh_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &power_down_bh_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &bh_s1_response_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &ah_s1_response_attr.attr);
+
+	/* isoc */
+	isoc_obj.index = index;
+	isoc_obj.data = data;
+	kobj_set_kset_s(&isoc_obj, rhc_subsys);
+	kobject_register(&isoc_obj.kobj);
+	sysfs_create_file(&isoc_obj.kobj, &unlock_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &s1_bp_reset_mask_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &s2_bp_reset_mask_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &bp_interrupt_mask_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &hostile_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &friendly_attr.attr);
+
+	/* fltc */
+        fltc_obj.index = index;
+	fltc_obj.data = data;
+	kobj_set_kset_s(&fltc_obj, rhc_subsys);
+	kobject_register(&fltc_obj.kobj);
+	sysfs_create_file(&fltc_obj.kobj, &wd_timeout_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &perr_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &iochk_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &nmi_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &b0_serr_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &cputemp_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &power_fail_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &eject_bh_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &eject_ah_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &soft_reset_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &hard_reset_attr.attr);
+
+	/* pmcc */
+	pmcc_obj.index = index;
+	pmcc_obj.data = data;
+	kobj_set_kset_s(&pmcc_obj, rhc_subsys);
+	kobject_register(&pmcc_obj.kobj);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc1_status_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc1_command2_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc1_command4_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc2_status_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc2_command2_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc2_command4_attr.attr);
+
+	/* wdc */
+	wdc_obj.index = index;
+	wdc_obj.data = data;
+	kobj_set_kset_s(&wdc_obj, rhc_subsys);
+	kobject_register(&wdc_obj.kobj);
+	sysfs_create_file(&wdc_obj.kobj, &terminal_count_attr.attr);
+	sysfs_create_file(&wdc_obj.kobj, &prescaler_attr.attr);
+
+	/* diag */
+	diag_obj.index = index;
+	diag_obj.data = data;
+	kobj_set_kset_s(&diag_obj, rhc_subsys);
+	kobject_register(&diag_obj.kobj);
+	sysfs_create_file(&diag_obj.kobj, &diag_wd_timeout_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_perr_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_iochk_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_nmi_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_b0_serr_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_cputemp_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_power_fail_attr.attr);	
+}
+
+void remove_hc_files(void)
+{
+	/* hci */
+	sysfs_create_file(&hci_obj.kobj, &hcf_interrupt_mask_attr.attr);
+	sysfs_create_file(&hci_obj.kobj, &fault_interrupt_mask_attr.attr);
+	sysfs_create_file(&hci_obj.kobj, &serial_interrupt_mask_attr.attr);
+	kobject_unregister(&hci_obj.kobj);
+
+	/* hcc */
+	sysfs_create_file(&hcc_obj.kobj, &reset_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &diagnostics_mode_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &configuration_mode_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &s2_bp_reset_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &s1_bp_reset_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &warm_boot_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &initiate_takeover_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &wd_enable_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &reset_bh_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &power_down_bh_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &bh_s1_response_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &ah_s1_response_attr.attr);
+	kobject_unregister(&hcc_obj.kobj);
+	
+	/* isoc */
+	sysfs_create_file(&isoc_obj.kobj, &unlock_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &s1_bp_reset_mask_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &s2_bp_reset_mask_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &bp_interrupt_mask_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &hostile_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &friendly_attr.attr);
+	kobject_unregister(&isoc_obj.kobj);
+
+	/* fltc */
+	sysfs_create_file(&fltc_obj.kobj, &wd_timeout_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &perr_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &iochk_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &nmi_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &b0_serr_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &cputemp_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &power_fail_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &eject_bh_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &eject_ah_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &soft_reset_attr.attr);
+	sysfs_create_file(&fltc_obj.kobj, &hard_reset_attr.attr);
+	kobject_unregister(&fltc_obj.kobj);
+	
+	/* pmcc */
+	sysfs_create_file(&pmcc_obj.kobj, &pmc1_status_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc1_command2_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc1_command4_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc2_status_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc2_command2_attr.attr);
+	sysfs_create_file(&pmcc_obj.kobj, &pmc2_command4_attr.attr);
+	kobject_unregister(&pmcc_obj.kobj);
+
+	/* wdc */
+	sysfs_create_file(&wdc_obj.kobj, &terminal_count_attr.attr);
+	sysfs_create_file(&wdc_obj.kobj, &prescaler_attr.attr);
+	kobject_unregister(&wdc_obj.kobj);
+
+	/* diag */
+	sysfs_create_file(&diag_obj.kobj, &diag_wd_timeout_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_perr_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_iochk_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_nmi_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_b0_serr_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_cputemp_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_power_fail_attr.attr);	
+	kobject_unregister(&diag_obj.kobj);
+
+
+	subsystem_unregister(&rhc_subsys);
+}
+



--=-cZ23kW2RW4/b/0VQ0pSe
Content-Disposition: attachment; filename=cpci-latest-2.5.59-bk.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=cpci-latest-2.5.59-bk.diff; charset=UTF-8

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.981   -> 1.982 =20
#	drivers/hotplug/cpcihp_zt5550.h	1.1     -> 1.2   =20
#	drivers/hotplug/cpci_hotplug.h	1.1     -> 1.2   =20
#	drivers/hotplug/pci_hotplug.h	1.4     -> 1.5   =20
#	drivers/hotplug/cpci_hotplug_core.c	1.2     -> 1.3   =20
#	drivers/hotplug/cpcihp_zt5550.c	1.1     -> 1.2   =20
#	drivers/hotplug/cpci_hotplug_pci.c	1.3     -> 1.4   =20
#	drivers/hotplug/pci_hotplug_core.c	1.31    -> 1.32  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/04	rusty@penguin.co.intel.com	1.982
# Adding Scott's latest changes and the sysfs interface for hotplug
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpci_hotplug.h b/drivers/hotplug/cpci_hotplug.h
--- a/drivers/hotplug/cpci_hotplug.h	Tue Feb  4 13:51:54 2003
+++ b/drivers/hotplug/cpci_hotplug.h	Tue Feb  4 13:51:54 2003
@@ -75,7 +75,6 @@
 extern int cpci_hp_unregister_controller(struct cpci_hp_controller *contro=
ller);
 extern int cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last);
 extern int cpci_hp_unregister_bus(struct pci_bus *bus);
-extern struct slot *cpci_find_slot(struct pci_bus *bus, unsigned int devfn=
);
 extern int cpci_hp_start(void);
 extern int cpci_hp_stop(void);
=20
diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotp=
lug_core.c
--- a/drivers/hotplug/cpci_hotplug_core.c	Tue Feb  4 13:51:54 2003
+++ b/drivers/hotplug/cpci_hotplug_core.c	Tue Feb  4 13:51:54 2003
@@ -417,34 +417,6 @@
 	return 0;
 }
=20
-struct slot *
-cpci_find_slot(struct pci_bus *bus, unsigned int devfn)
-{
-	struct slot *slot;
-	struct slot *found;
-	struct list_head *tmp;
-
-	if(!bus) {
-		return NULL;
-	}
-
-	spin_lock(&list_lock);
-	if(!slots) {
-		spin_unlock(&list_lock);
-		return NULL;
-	}
-	found =3D NULL;
-	list_for_each(tmp, &slot_list) {
-		slot =3D list_entry(tmp, struct slot, slot_list);
-		if(slot->bus =3D=3D bus && slot->devfn =3D=3D devfn) {
-			found =3D slot;
-			break;
-		}
-	}
-	spin_unlock(&list_lock);
-	return found;
-}
-
 /* This is the interrupt mode interrupt handler */
 void
 cpci_hp_intr(int irq, void *data, struct pt_regs *regs)
@@ -915,6 +887,5 @@
 EXPORT_SYMBOL_GPL(cpci_hp_unregister_controller);
 EXPORT_SYMBOL_GPL(cpci_hp_register_bus);
 EXPORT_SYMBOL_GPL(cpci_hp_unregister_bus);
-EXPORT_SYMBOL_GPL(cpci_find_slot);
 EXPORT_SYMBOL_GPL(cpci_hp_start);
 EXPORT_SYMBOL_GPL(cpci_hp_stop);
diff -Nru a/drivers/hotplug/cpci_hotplug_pci.c b/drivers/hotplug/cpci_hotpl=
ug_pci.c
--- a/drivers/hotplug/cpci_hotplug_pci.c	Tue Feb  4 13:51:54 2003
+++ b/drivers/hotplug/cpci_hotplug_pci.c	Tue Feb  4 13:51:54 2003
@@ -446,7 +446,7 @@
 }
=20
 static int configure_visit_pci_dev(struct pci_dev_wrapped *wrapped_dev,
-			struct pci_bus_wrapped *wrapped_bus)
+				   struct pci_bus_wrapped *wrapped_bus)
 {
 	int rc;
 	struct pci_dev *dev =3D wrapped_dev->dev;
@@ -459,8 +459,8 @@
 	 * We need to fix up the hotplug representation with the Linux
 	 * representation.
 	 */
-	slot =3D cpci_find_slot(dev->bus, dev->devfn);
-	if(slot) {
+	if(wrapped_dev->data) {
+		slot =3D (struct slot*) wrapped_dev->data;
 		slot->dev =3D dev;
 	}
=20
@@ -482,7 +482,7 @@
 }
=20
 static int unconfigure_visit_pci_dev_phase1(struct pci_dev_wrapped *wrappe=
d_dev,
-				 struct pci_bus_wrapped *wrapped_bus)
+					    struct pci_bus_wrapped *wrapped_bus)
 {
 	struct pci_dev *dev =3D wrapped_dev->dev;
=20
@@ -525,8 +525,8 @@
 	/*
 	 * Now remove the hotplug representation.
 	 */
-	slot =3D cpci_find_slot(dev->bus, dev->devfn);
-	if(slot) {
+	if(wrapped_dev->data) {
+		slot =3D (struct slot*) wrapped_dev->data;
 		slot->dev =3D NULL;
 	} else {
 		dbg("No hotplug representation for %02x:%02x.%x",
@@ -634,6 +634,10 @@
 				continue;
 			wrapped_dev.dev =3D dev;
 			wrapped_bus.bus =3D slot->dev->bus;
+			if(i)
+				wrapped_dev.data =3D NULL;
+			else
+				wrapped_dev.data =3D (void*) slot;
 			rc =3D pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
 		}
 	}
@@ -666,16 +670,21 @@
 		if(dev) {
 			wrapped_dev.dev =3D dev;
 			wrapped_bus.bus =3D dev->bus;
+			if(i)
+				wrapped_dev.data =3D NULL;
+			else
+				wrapped_dev.data =3D (void*) slot;
 			dbg("%s - unconfigure phase 1", __FUNCTION__);
 			rc =3D pci_visit_dev(&unconfigure_functions_phase1,
-					   &wrapped_dev, &wrapped_bus);
-			if(rc) {
+					   &wrapped_dev,
+					   &wrapped_bus);
+			if(rc)
 				break;
-			}
=20
 			dbg("%s - unconfigure phase 2", __FUNCTION__);
 			rc =3D pci_visit_dev(&unconfigure_functions_phase2,
-					   &wrapped_dev, &wrapped_bus);
+					   &wrapped_dev,
+					   &wrapped_bus);
 			if(rc)
 				break;
 		}
diff -Nru a/drivers/hotplug/cpcihp_zt5550.c b/drivers/hotplug/cpcihp_zt5550=
.c
--- a/drivers/hotplug/cpcihp_zt5550.c	Tue Feb  4 13:51:54 2003
+++ b/drivers/hotplug/cpcihp_zt5550.c	Tue Feb  4 13:51:54 2003
@@ -38,7 +38,7 @@
 #include "cpci_hotplug.h"
 #include "cpcihp_zt5550.h"
=20
-#define DRIVER_VERSION	"0.2"
+#define DRIVER_VERSION	"0.3"
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"ZT5550 CompactPCI Hot Plug Driver"
=20
@@ -64,9 +64,11 @@
 static struct cpci_hp_controller_ops zt5550_hpc_ops;
 static struct cpci_hp_controller zt5550_hpc;
=20
-/* Primary cPCI bus bridge device */
-static struct pci_dev *bus0_dev;
-static struct pci_bus *bus0;
+/* cPCI bus bridge devices */
+static struct pci_dev *bus1_dev;
+static struct pci_bus *bus1;
+static struct pci_dev *bus2_dev;
+static struct pci_bus *bus2;
=20
 /* Host controller device */
 static struct pci_dev *hc_dev;
@@ -75,9 +77,11 @@
 static void *hc_registers;
 static void *csr_hc_index;
 static void *csr_hc_data;
-static void *csr_int_status;
-static void *csr_int_mask;
+static void *csr_intstat;
+static void *csr_intmask;
=20
+/* Host controller status register */
+static u32 hcf_hcs;
=20
 static int zt5550_hc_config(struct pci_dev *pdev)
 {
@@ -109,23 +113,28 @@
=20
 	csr_hc_index =3D hc_registers + CSR_HCINDEX;
 	csr_hc_data =3D hc_registers + CSR_HCDATA;
-	csr_int_status =3D hc_registers + CSR_INTSTAT;
-	csr_int_mask =3D hc_registers + CSR_INTMASK;
+	csr_intstat =3D hc_registers + CSR_INTSTAT;
+	csr_intmask =3D hc_registers + CSR_INTMASK;
+
+	/* Read Host Control Status register */
+	writeb((u8) HCF_HCS, csr_hc_index);
+	hcf_hcs =3D readl(csr_hc_data);
+	info("HCF_HCS =3D 0x%08x", hcf_hcs);
=20
 	/*
 	 * Disable host control, fault and serial interrupts
 	 */
 	dbg("disabling host control, fault and serial interrupts");
-	writeb((u8) HC_INT_MASK_REG, csr_hc_index);
-	writeb((u8) ALL_INDEXED_INTS_MASK, csr_hc_data);
+	writeb((u8) HCF_HCI, csr_hc_index);
+	writeb((u8) HCI_ALL_INTS_MASK, csr_hc_data);
 	dbg("disabled host control, fault and serial interrupts");
=20
 	/*
-	 * Disable timer0, timer1 and ENUM interrupts
+	 * Disable timer0, timer1 and ENUM# interrupts
 	 */
-	dbg("disabling timer0, timer1 and ENUM interrupts");
-	writeb((u8) ALL_DIRECT_INTS_MASK, csr_int_mask);
-	dbg("disabled timer0, timer1 and ENUM interrupts");
+	dbg("disabling timer0, timer1 and ENUM# interrupts");
+	writeb((u8) INTMASK_ALL_INTS_MASK, csr_intmask);
+	dbg("disabled timer0, timer1 and ENUM# interrupts");
 	return 0;
 }
=20
@@ -153,7 +162,7 @@
=20
 	ret =3D 0;
 	if(dev_id =3D=3D zt5550_hpc.dev_id) {
-		reg =3D readb(csr_int_status);
+		reg =3D readb(csr_intstat);
 		if(reg)
 			ret =3D 1;
 	}
@@ -167,9 +176,9 @@
 	if(hc_dev =3D=3D NULL) {
 		return -ENODEV;
 	}
-	reg =3D readb(csr_int_mask);
-	reg =3D reg & ~ENUM_INT_MASK;
-	writeb(reg, csr_int_mask);
+	reg =3D readb(csr_intmask);
+	reg =3D reg & ~INTMASK_ENUM_INT_MASK;
+	writeb(reg, csr_intmask);
 	return 0;
 }
=20
@@ -181,16 +190,42 @@
 		return -ENODEV;
 	}
=20
-	reg =3D readb(csr_int_mask);
-	reg =3D reg | ENUM_INT_MASK;
-	writeb(reg, csr_int_mask);
+	reg =3D readb(csr_intmask);
+	reg =3D reg | INTMASK_ENUM_INT_MASK;
+	writeb(reg, csr_intmask);
 	return 0;
 }
=20
+static int __devinit zt5550_register_bus(unsigned int slot,
+					 struct pci_dev **dev,
+					 struct pci_bus **bus)
+{
+	int status;
+
+	/* Look for slot's device */
+	if(!(*dev =3D pci_find_slot(0, PCI_DEVFN(slot, 0)))) {
+		return -ENODEV;
+	}
+	if(!((*dev)->vendor =3D=3D PCI_VENDOR_ID_DEC && \
+	     (*dev)->device =3D=3D PCI_DEVICE_ID_DEC_21154)) {
+		return -ENODEV;
+	}
+	*bus =3D (*dev)->subordinate;
+
+	status =3D cpci_hp_register_bus(*bus, 0x0a, 0x0f);
+	if(status) {
+		err("could not register cPCI hotplug bus %d", (*bus)->number);
+	} else {
+		dbg("registered bus %d", (*bus)->number);
+	}
+	return status;
+}
+
 static int __devinit zt5550_hc_init_one (struct pci_dev *pdev,
 					 const struct pci_device_id *ent)
 {
 	int status;
+	struct resource* r;
=20
 	status =3D zt5550_hc_config(pdev);
 	if(status !=3D 0) {
@@ -198,6 +233,10 @@
 	}
 	dbg("returned from zt5550_hc_config");
=20
+	r =3D request_region(ENUM_PORT, 1, "ENUM# hotswap signal register");
+	if(!r)
+		return -EBUSY;
+
 	memset(&zt5550_hpc, 0, sizeof (struct cpci_hp_controller));
 	zt5550_hpc_ops.query_enum =3D zt5550_hc_query_enum;
 	zt5550_hpc.ops =3D &zt5550_hpc_ops;
@@ -220,31 +259,30 @@
 	}
 	dbg("registered controller");
=20
-	/* Look for first device matching cPCI bus's bridge vendor and device IDs=
 */
-	if(!(bus0_dev =3D pci_find_device(PCI_VENDOR_ID_DEC,
-					 PCI_DEVICE_ID_DEC_21154, NULL))) {
-		status =3D -ENODEV;
-		goto init_register_error;
-	}
-	bus0 =3D bus0_dev->subordinate;
-
-	status =3D cpci_hp_register_bus(bus0, 0x0a, 0x0f);
-	if(status !=3D 0) {
-		err("could not register cPCI hotplug bus");
-		goto init_register_error;
+	if(hcf_hcs & HCS_BUS1_ACTIVE) {
+		status =3D zt5550_register_bus(BUS1_SLOT, &bus1_dev, &bus1);
+		if(status)
+			goto init_register_error;
+	}
+	if(hcf_hcs & HCS_BUS2_ACTIVE) {
+		status =3D zt5550_register_bus(BUS2_SLOT, &bus2_dev, &bus2);
+		if(status)
+			goto init_register_error;
 	}
-	dbg("registered bus");
=20
 	status =3D cpci_hp_start();
 	if(status !=3D 0) {
 		err("could not started cPCI hotplug system");
-		cpci_hp_unregister_bus(bus0);
 		goto init_register_error;
 	}
-	dbg("started cpci hp system");
+	dbg("started cPCI hotplug system");
=20
 	return 0;
 init_register_error:
+	if(bus1)
+		cpci_hp_unregister_bus(bus1);
+	if(bus2)
+		cpci_hp_unregister_bus(bus2);
 	cpci_hp_unregister_controller(&zt5550_hpc);
 init_hc_error:
 	err("status =3D %d", status);
@@ -256,7 +294,10 @@
 static void __devexit zt5550_hc_remove_one(struct pci_dev *pdev)
 {
 	cpci_hp_stop();
-	cpci_hp_unregister_bus(bus0);
+	if(bus1)
+		cpci_hp_unregister_bus(bus1);
+	if(bus2)
+		cpci_hp_unregister_bus(bus2);
 	cpci_hp_unregister_controller(&zt5550_hpc);
 	zt5550_hc_cleanup();
 }
@@ -277,13 +318,7 @@
=20
 static int __init zt5550_init(void)
 {
-	struct resource* r;
-
 	info(DRIVER_DESC " version: " DRIVER_VERSION);
-	r =3D request_region(ENUM_PORT, 1, "#ENUM hotswap signal register");
-	if(!r)
-		return -EBUSY;
-
 	return pci_module_init(&zt5550_hc_driver);
 }
=20
@@ -303,4 +338,4 @@
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 MODULE_PARM(poll, "i");
-MODULE_PARM_DESC(poll, "#ENUM polling mode enabled or not");
+MODULE_PARM_DESC(poll, "ENUM# polling mode enabled or not");
diff -Nru a/drivers/hotplug/cpcihp_zt5550.h b/drivers/hotplug/cpcihp_zt5550=
.h
--- a/drivers/hotplug/cpcihp_zt5550.h	Tue Feb  4 13:51:54 2003
+++ b/drivers/hotplug/cpcihp_zt5550.h	Tue Feb  4 13:51:54 2003
@@ -38,38 +38,55 @@
 #define CSR_HCDATA		0x04
 #define CSR_INTSTAT		0x08
 #define CSR_INTMASK		0x09
-#define CSR_CNT0CMD		0x0C
-#define CSR_CNT1CMD		0x0E
-#define CSR_CNT0		0x10
-#define CSR_CNT1		0x14
+#define CSR_ENET		0x0A
+#define CSR_T0_C		0x0C
+#define CSR_T1_C		0x0E
+#define CSR_TIM0		0x10
+#define CSR_TIM1		0x14
=20
 /* Masks for interrupt bits in CSR_INTMASK direct register */
-#define CNT0_INT_MASK		0x01
-#define CNT1_INT_MASK		0x02
-#define ENUM_INT_MASK		0x04
-#define ALL_DIRECT_INTS_MASK	0x07
+#define INTMASK_TIM0_INT_MASK	0x01
+#define INTMASK_TIM1_INT_MASK	0x02
+#define INTMASK_ENUM_INT_MASK	0x04
+#define INTMASK_ALL_INTS_MASK	0x07
=20
-/* Indexed registers (through CSR_INDEX, CSR_DATA) */
-#define HC_INT_MASK_REG		0x04
-#define HC_STATUS_REG		0x08
-#define HC_CMD_REG		0x0C
-#define ARB_CONFIG_GNT_REG	0x10
-#define ARB_CONFIG_CFG_REG	0x12
-#define ARB_CONFIG_REG	 	0x10
-#define ISOL_CONFIG_REG		0x18
-#define FAULT_STATUS_REG	0x20
-#define FAULT_CONFIG_REG	0x24
-#define WD_CONFIG_REG		0x2C
-#define HC_DIAG_REG		0x30
-#define SERIAL_COMM_REG		0x34
-#define SERIAL_OUT_REG		0x38
-#define SERIAL_IN_REG		0x3C
+/* Indexed registers (through CSR_HCINDEX, CSR_HCDATA) */
+#define HCF_HCI			0x04
+#define HCF_HCS			0x08
+#define HCF_HCC			0x0C
+#define HCF_ARBC		0x10
+#define HCF_ISOC		0x18
+#define HCF_FLTS		0x20
+#define HCF_FLTC		0x24
+#define HCF_PMCC		0x28
+#define HCF_WDC			0x2C
+#define HCF_DIAG		0x30
+#define HCF_SERC		0x34
+#define HCF_SDO			0x38
+#define HCF_SDI			0x3C
=20
-/* Masks for interrupt bits in HC_INT_MASK_REG indexed register */
-#define SERIAL_INT_MASK		0x01
-#define FAULT_INT_MASK		0x02
-#define HCF_INT_MASK		0x04
-#define ALL_INDEXED_INTS_MASK	0x07
+/* Masks for interrupt bits in HCF_HCI indexed register */
+#define HCI_SERIAL_INT_MASK	0x01
+#define HCI_FAULT_INT_MASK	0x02
+#define HCI_HCF_INT_MASK	0x04
+#define HCI_ALL_INTS_MASK	0x07
+
+/* Masks for the bits in the HCF_HCS indexed register */
+#define HCS_HA			0x00000001
+#define HCS_ACTIVE		0x00000002
+#define HCS_RH_STATE		0x00000004
+#define HCS_HARD_RESET		0x00000008
+#define HCS_SOFT_RESET		0x00000010
+#define HCS_RH_ALIVE		0x00000020
+#define HCS_SWITCH_OVER		0x00000040
+#define HCS_TAKEOVER_TYPE	0x00000080
+#define HCS_BUS1_ACTIVE		0x00000100
+#define HCS_BUS2_ACTIVE		0x00000200
+#define HCS_SPLIT_MODE_ERROR	0x00000400
+
+/* CompactPCI bus segment device slot numbers */
+#define BUS1_SLOT		0x08
+#define BUS2_SLOT		0x0C
=20
 /* Digital I/O port storing ENUM# */
 #define ENUM_PORT	0xE1
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Tue Feb  4 13:51:54 2003
+++ b/drivers/hotplug/pci_hotplug.h	Tue Feb  4 13:51:54 2003
@@ -46,8 +46,11 @@
 };
=20
 struct hotplug_slot;
-struct hotplug_slot_core;
-
+struct hotplug_slot_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct hotplug_slot *, char *);
+	ssize_t (*store)(struct hotplug_slot *, const char *, size_t);
+};
 /**
  * struct hotplug_slot_ops -the callbacks that the hotplug pci core can us=
e
  * @owner: The module owner of this structure
@@ -131,7 +134,7 @@
=20
 	/* Variables below this are for use only by the hotplug pci core. */
 	struct list_head		slot_list;
-	struct hotplug_slot_core	*core_priv;
+	struct kobject			kobj;
 };
=20
 extern int pci_hp_register		(struct hotplug_slot *slot);
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplu=
g_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Tue Feb  4 13:51:54 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Tue Feb  4 13:51:54 2003
@@ -40,8 +40,9 @@
 #include <linux/namei.h>
 #include <linux/pci.h>
 #include <linux/dnotify.h>
-#include <linux/proc_fs.h>
 #include <asm/uaccess.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 #include "pci_hotplug.h"
=20
=20
@@ -67,29 +68,43 @@
=20
 //////////////////////////////////////////////////////////////////
=20
-/* Random magic number */
-#define PCIHPFS_MAGIC 0x52454541
+static spinlock_t list_lock;
+
+static LIST_HEAD(pci_hotplug_slot_list);
+
+static struct subsystem hotplug_slots_subsys;
+
+static ssize_t hotplug_slot_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct hotplug_slot *slot=3Dcontainer_of(kobj,
+			struct hotplug_slot,kobj);
+	struct hotplug_slot_attribute *attribute =3D
+		container_of(attr, struct hotplug_slot_attribute, attr);
+	return attribute->show ? attribute->show(slot, buf) : 0;
+}
+
+static ssize_t hotplug_slot_attr_store(struct kobject *kobj,
+		struct attribute *attr, const char *buf, size_t len)
+{
+	struct hotplug_slot *slot=3Dcontainer_of(kobj,
+			struct hotplug_slot,kobj);
+	struct hotplug_slot_attribute *attribute =3D
+		container_of(attr, struct hotplug_slot_attribute, attr);
+	return attribute->store ? attribute->store(slot, buf, len) : 0;
+}
=20
-struct hotplug_slot_core {
-	struct dentry	*dir_dentry;
-	struct dentry	*power_dentry;
-	struct dentry	*attention_dentry;
-	struct dentry	*latch_dentry;
-	struct dentry	*adapter_dentry;
-	struct dentry	*test_dentry;
-	struct dentry	*max_bus_speed_dentry;
-	struct dentry	*cur_bus_speed_dentry;
+static struct sysfs_ops hotplug_slot_sysfs_ops =3D {
+	.show =3D hotplug_slot_attr_show,
+	.store =3D hotplug_slot_attr_store,
 };
=20
-static struct super_operations pcihpfs_ops;
-static struct file_operations default_file_operations;
-static struct inode_operations pcihpfs_dir_inode_operations;
-static struct vfsmount *pcihpfs_mount;	/* one of the mounts of our fs for =
reference counting */
-static int pcihpfs_mount_count;		/* times we have mounted our fs */
-static spinlock_t mount_lock;		/* protects our mount_count */
-static spinlock_t list_lock;
+static struct kobj_type hotplug_slot_ktype =3D {
+	.sysfs_ops =3D &hotplug_slot_sysfs_ops
+};
+
+static decl_subsys(hotplug_slots, &hotplug_slot_ktype);
=20
-static LIST_HEAD(pci_hotplug_slot_list);
=20
 /* these strings match up with the values in pci_bus_speed */
 static char *pci_bus_speed_strings[] =3D {
@@ -115,12 +130,6 @@
 	"133 MHz PCIX 533",	/* 0x13 */
 };
=20
-#ifdef CONFIG_PROC_FS	=09
-extern struct proc_dir_entry *proc_bus_pci_dir;
-static struct proc_dir_entry *slotdir =3D NULL;
-static const char *slotdir_name =3D "slots";
-#endif
-
 #ifdef CONFIG_HOTPLUG_PCI_CPCI
 extern int cpci_hotplug_init(int debug);
 extern void cpci_hotplug_exit(void);
@@ -129,438 +138,6 @@
 static inline void cpci_hotplug_exit(void) { }
 #endif
=20
-static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, =
dev_t dev)
-{
-	struct inode *inode =3D new_inode(sb);
-
-	if (inode) {
-		inode->i_mode =3D mode;
-		inode->i_uid =3D current->fsuid;
-		inode->i_gid =3D current->fsgid;
-		inode->i_blksize =3D PAGE_CACHE_SIZE;
-		inode->i_blocks =3D 0;
-		inode->i_rdev =3D NODEV;
-		inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D CURRENT_TIME;
-		switch (mode & S_IFMT) {
-		default:
-			init_special_inode(inode, mode, dev);
-			break;
-		case S_IFREG:
-			inode->i_fop =3D &default_file_operations;
-			break;
-		case S_IFDIR:
-			inode->i_op =3D &pcihpfs_dir_inode_operations;
-			inode->i_fop =3D &simple_dir_operations;
-
-			/* directory inodes start off with i_nlink =3D=3D 2 (for "." entry) */
-			inode->i_nlink++;
-			break;
-		}
-	}
-	return inode;=20
-}
-
-/* SMP-safe */
-static int pcihpfs_mknod (struct inode *dir, struct dentry *dentry, int mo=
de, dev_t dev)
-{
-	struct inode *inode =3D pcihpfs_get_inode(dir->i_sb, mode, dev);
-	int error =3D -ENOSPC;
-
-	if (inode) {
-		d_instantiate(dentry, inode);
-		dget(dentry);
-		error =3D 0;
-	}
-	return error;
-}
-
-static int pcihpfs_mkdir (struct inode *dir, struct dentry *dentry, int mo=
de)
-{
-	return pcihpfs_mknod (dir, dentry, mode | S_IFDIR, 0);
-}
-
-static int pcihpfs_create (struct inode *dir, struct dentry *dentry, int m=
ode)
-{
- 	return pcihpfs_mknod (dir, dentry, mode | S_IFREG, 0);
-}
-
-static inline int pcihpfs_positive (struct dentry *dentry)
-{
-	return dentry->d_inode && !d_unhashed(dentry);
-}
-
-static int pcihpfs_empty (struct dentry *dentry)
-{
-	struct list_head *list;
-
-	spin_lock(&dcache_lock);
-
-	list_for_each(list, &dentry->d_subdirs) {
-		struct dentry *de =3D list_entry(list, struct dentry, d_child);
-		if (pcihpfs_positive(de)) {
-			spin_unlock(&dcache_lock);
-			return 0;
-		}
-	}
-
-	spin_unlock(&dcache_lock);
-	return 1;
-}
-
-static int pcihpfs_unlink (struct inode *dir, struct dentry *dentry)
-{
-	int error =3D -ENOTEMPTY;
-
-	if (pcihpfs_empty(dentry)) {
-		struct inode *inode =3D dentry->d_inode;
-
-		lock_kernel();
-		inode->i_nlink--;
-		unlock_kernel();
-		dput(dentry);
-		error =3D 0;
-	}
-	return error;
-}
-
-#define pcihpfs_rmdir pcihpfs_unlink
-
-/* default file operations */
-static ssize_t default_read_file (struct file *file, char *buf, size_t cou=
nt, loff_t *ppos)
-{
-	dbg ("\n");
-	return 0;
-}
-
-static ssize_t default_write_file (struct file *file, const char *buf, siz=
e_t count, loff_t *ppos)
-{
-	dbg ("\n");
-	return count;
-}
-
-static loff_t default_file_lseek (struct file *file, loff_t offset, int or=
ig)
-{
-	loff_t retval =3D -EINVAL;
-
-	lock_kernel();
-	switch(orig) {
-	case 0:
-		if (offset > 0) {
-			file->f_pos =3D offset;
-			retval =3D file->f_pos;
-		}=20
-		break;
-	case 1:
-		if ((offset + file->f_pos) > 0) {
-			file->f_pos +=3D offset;
-			retval =3D file->f_pos;
-		}=20
-		break;
-	default:
-		break;
-	}
-	unlock_kernel();
-	return retval;
-}
-
-static int default_open (struct inode *inode, struct file *filp)
-{
-	if (inode->u.generic_ip)
-		filp->private_data =3D inode->u.generic_ip;
-
-	return 0;
-}
-
-static struct file_operations default_file_operations =3D {
-	.read =3D		default_read_file,
-	.write =3D	default_write_file,
-	.open =3D		default_open,
-	.llseek =3D	default_file_lseek,
-};
-
-/* file ops for the "power" files */
-static ssize_t power_read_file (struct file *file, char *buf, size_t count=
, loff_t *offset);
-static ssize_t power_write_file (struct file *file, const char *buf, size_=
t count, loff_t *ppos);
-static struct file_operations power_file_operations =3D {
-	.read =3D		power_read_file,
-	.write =3D	power_write_file,
-	.open =3D		default_open,
-	.llseek =3D	default_file_lseek,
-};
-
-/* file ops for the "attention" files */
-static ssize_t attention_read_file (struct file *file, char *buf, size_t c=
ount, loff_t *offset);
-static ssize_t attention_write_file (struct file *file, const char *buf, s=
ize_t count, loff_t *ppos);
-static struct file_operations attention_file_operations =3D {
-	.read =3D		attention_read_file,
-	.write =3D	attention_write_file,
-	.open =3D		default_open,
-	.llseek =3D	default_file_lseek,
-};
-
-/* file ops for the "latch" files */
-static ssize_t latch_read_file (struct file *file, char *buf, size_t count=
, loff_t *offset);
-static struct file_operations latch_file_operations =3D {
-	.read =3D		latch_read_file,
-	.write =3D	default_write_file,
-	.open =3D		default_open,
-	.llseek =3D	default_file_lseek,
-};
-
-/* file ops for the "presence" files */
-static ssize_t presence_read_file (struct file *file, char *buf, size_t co=
unt, loff_t *offset);
-static struct file_operations presence_file_operations =3D {
-	.read =3D		presence_read_file,
-	.write =3D	default_write_file,
-	.open =3D		default_open,
-	.llseek =3D	default_file_lseek,
-};
-
-/* file ops for the "max bus speed" files */
-static ssize_t max_bus_speed_read_file (struct file *file, char *buf, size=
_t count, loff_t *offset);
-static struct file_operations max_bus_speed_file_operations =3D {
-	.read		=3D max_bus_speed_read_file,
-	.write		=3D default_write_file,
-	.open		=3D default_open,
-	.llseek		=3D default_file_lseek,
-};
-
-/* file ops for the "current bus speed" files */
-static ssize_t cur_bus_speed_read_file (struct file *file, char *buf, size=
_t count, loff_t *offset);
-static struct file_operations cur_bus_speed_file_operations =3D {
-	.read		=3D cur_bus_speed_read_file,
-	.write		=3D default_write_file,
-	.open		=3D default_open,
-	.llseek		=3D default_file_lseek,
-};
-
-/* file ops for the "test" files */
-static ssize_t test_write_file (struct file *file, const char *buf, size_t=
 count, loff_t *ppos);
-static struct file_operations test_file_operations =3D {
-	.read =3D		default_read_file,
-	.write =3D	test_write_file,
-	.open =3D		default_open,
-	.llseek =3D	default_file_lseek,
-};
-
-static struct inode_operations pcihpfs_dir_inode_operations =3D {
-	.create =3D	pcihpfs_create,
-	.lookup =3D	simple_lookup,
-	.unlink =3D	pcihpfs_unlink,
-	.mkdir =3D	pcihpfs_mkdir,
-	.rmdir =3D	pcihpfs_rmdir,
-	.mknod =3D	pcihpfs_mknod,
-};
-
-static struct super_operations pcihpfs_ops =3D {
-	.statfs =3D	simple_statfs,
-	.drop_inode =3D	generic_delete_inode,
-};
-
-static int pcihpfs_fill_super(struct super_block *sb, void *data, int sile=
nt)
-{
-	struct inode *inode;
-	struct dentry *root;
-
-	sb->s_blocksize =3D PAGE_CACHE_SIZE;
-	sb->s_blocksize_bits =3D PAGE_CACHE_SHIFT;
-	sb->s_magic =3D PCIHPFS_MAGIC;
-	sb->s_op =3D &pcihpfs_ops;
-	inode =3D pcihpfs_get_inode(sb, S_IFDIR | 0755, 0);
-
-	if (!inode) {
-		dbg("%s: could not get inode!\n",__FUNCTION__);
-		return -ENOMEM;
-	}
-
-	root =3D d_alloc_root(inode);
-	if (!root) {
-		dbg("%s: could not get root dentry!\n",__FUNCTION__);
-		iput(inode);
-		return -ENOMEM;
-	}
-	sb->s_root =3D root;
-	return 0;
-}
-
-static struct super_block *pcihpfs_get_sb(struct file_system_type *fs_type=
,
-	int flags, char *dev_name, void *data)
-{
-	return get_sb_single(fs_type, flags, data, pcihpfs_fill_super);
-}
-
-static struct file_system_type pcihpfs_type =3D {
-	.owner =3D	THIS_MODULE,
-	.name =3D		"pcihpfs",
-	.get_sb =3D	pcihpfs_get_sb,
-	.kill_sb =3D	kill_litter_super,
-};
-
-static int get_mount (void)
-{
-	struct vfsmount *mnt;
-
-	spin_lock (&mount_lock);
-	if (pcihpfs_mount) {
-		mntget(pcihpfs_mount);
-		++pcihpfs_mount_count;
-		spin_unlock (&mount_lock);
-		goto go_ahead;
-	}
-
-	spin_unlock (&mount_lock);
-	mnt =3D kern_mount (&pcihpfs_type);
-	if (IS_ERR(mnt)) {
-		err ("could not mount the fs...erroring out!\n");
-		return -ENODEV;
-	}
-	spin_lock (&mount_lock);
-	if (!pcihpfs_mount) {
-		pcihpfs_mount =3D mnt;
-		++pcihpfs_mount_count;
-		spin_unlock (&mount_lock);
-		goto go_ahead;
-	}
-	mntget(pcihpfs_mount);
-	++pcihpfs_mount_count;
-	spin_unlock (&mount_lock);
-	mntput(mnt);
-
-go_ahead:
-	dbg("pcihpfs_mount_count =3D %d\n", pcihpfs_mount_count);
-	return 0;
-}
-
-static void remove_mount (void)
-{
-	struct vfsmount *mnt;
-
-	spin_lock (&mount_lock);
-	mnt =3D pcihpfs_mount;
-	--pcihpfs_mount_count;
-	if (!pcihpfs_mount_count)
-		pcihpfs_mount =3D NULL;
-
-	spin_unlock (&mount_lock);
-	mntput(mnt);
-	dbg("pcihpfs_mount_count =3D %d\n", pcihpfs_mount_count);
-}
-
-
-/**
- * pcihpfs_create_by_name - create a file, given a name
- * @name:	name of file
- * @mode:	type of file
- * @parent:	dentry of directory to create it in
- * @dentry:	resulting dentry of file
- *
- * There is a bit of overhead in creating a file - basically, we=20
- * have to hash the name of the file, then look it up. This will
- * prevent files of the same name.=20
- * We then call the proper vfs_ function to take care of all the=20
- * file creation details.=20
- * This function handles both regular files and directories.
- */
-static int pcihpfs_create_by_name (const char *name, mode_t mode,
-				   struct dentry *parent, struct dentry **dentry)
-{
-	struct dentry *d =3D NULL;
-	struct qstr qstr;
-	int error;
-
-	/* If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super=20
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent ) {
-		if (pcihpfs_mount && pcihpfs_mount->mnt_sb) {
-			parent =3D pcihpfs_mount->mnt_sb->s_root;
-		}
-	}
-
-	if (!parent) {
-		dbg("Ah! can not find a parent!\n");
-		return -EINVAL;
-	}
-
-	*dentry =3D NULL;
-	qstr.name =3D name;
-	qstr.len =3D strlen(name);
- 	qstr.hash =3D full_name_hash(name,qstr.len);
-
-	parent =3D dget(parent);
-
-	down(&parent->d_inode->i_sem);
-
-	d =3D lookup_hash(&qstr,parent);
-
-	error =3D PTR_ERR(d);
-	if (!IS_ERR(d)) {
-		switch(mode & S_IFMT) {
-		case 0:=20
-		case S_IFREG:
-			error =3D vfs_create(parent->d_inode,d,mode);
-			break;
-		case S_IFDIR:
-			error =3D vfs_mkdir(parent->d_inode,d,mode);
-			break;
-		default:
-			err("cannot create special files\n");
-		}
-		*dentry =3D d;
-	}
-	up(&parent->d_inode->i_sem);
-
-	dput(parent);
-	return error;
-}
-
-static struct dentry *fs_create_file (const char *name, mode_t mode,
-				      struct dentry *parent, void *data,
-				      struct file_operations *fops)
-{
-	struct dentry *dentry;
-	int error;
-
-	dbg("creating file '%s'\n",name);
-
-	error =3D pcihpfs_create_by_name(name,mode,parent,&dentry);
-	if (error) {
-		dentry =3D NULL;
-	} else {
-		if (dentry->d_inode) {
-			if (data)
-				dentry->d_inode->u.generic_ip =3D data;
-			if (fops)
-			dentry->d_inode->i_fop =3D fops;
-		}
-	}
-
-	return dentry;
-}
-
-static void fs_remove_file (struct dentry *dentry)
-{
-	struct dentry *parent =3D dentry->d_parent;
-=09
-	if (!parent || !parent->d_inode)
-		return;
-
-	down(&parent->d_inode->i_sem);
-	if (pcihpfs_positive(dentry)) {
-		if (dentry->d_inode) {
-			if (S_ISDIR(dentry->d_inode->i_mode))
-				vfs_rmdir(parent->d_inode,dentry);
-			else
-				vfs_unlink(parent->d_inode,dentry);
-		}
-
-		dput(dentry);
-	}
-	up(&parent->d_inode->i_sem);
-}
-
 /* Weee, fun with macros... */
 #define GET_STATUS(name,type)	\
 static int get_##name (struct hotplug_slot *slot, type *value)		\
@@ -584,80 +161,27 @@
 GET_STATUS(max_bus_speed, enum pci_bus_speed)
 GET_STATUS(cur_bus_speed, enum pci_bus_speed)
=20
-static ssize_t power_read_file (struct file *file, char *buf, size_t count=
, loff_t *offset)
+static ssize_t power_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
=20
-	dbg(" count =3D %d, offset =3D %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count =3D=3D 0 || count > 16384)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	page =3D (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval =3D get_power_status (slot, &value);
 	if (retval)
 		goto exit;
-	len =3D sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-	*offset +=3D len;
-	retval =3D len;
-
+	retval =3D sprintf (buf, "%d\n", value);
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
=20
-static ssize_t power_write_file (struct file *file, const char *ubuff, siz=
e_t count, loff_t *offset)
+static ssize_t power_write_file (struct hotplug_slot *slot, const char *bu=
f,
+		size_t count)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	char *buff;
 	unsigned long lpower;
 	u8 power;
 	int retval =3D 0;
=20
-	if (*offset < 0)
-		return -EINVAL;
-	if (count =3D=3D 0 || count > 16384)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	buff =3D kmalloc (count + 1, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-	memset (buff, 0x00, count + 1);
-=20
-	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-=09
-	lpower =3D simple_strtoul (buff, NULL, 10);
+	lpower =3D simple_strtoul (buf, NULL, 10);
 	power =3D (u8)(lpower & 0xff);
 	dbg ("power =3D %d\n", power);
=20
@@ -683,87 +207,39 @@
 	module_put(slot->ops->owner);
=20
 exit:=09
-	kfree (buff);
-
 	if (retval)
 		return retval;
 	return count;
 }
=20
-static ssize_t attention_read_file (struct file *file, char *buf, size_t c=
ount, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_power =3D {
+	.attr =3D {.name =3D "power", .mode =3D S_IFREG | S_IRUGO | S_IWUSR},
+	.show =3D power_read_file,
+	.store =3D power_write_file
+};
+
+static ssize_t attention_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
=20
-	dbg("count =3D %d, offset =3D %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <=3D 0)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	page =3D (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval =3D get_attention_status (slot, &value);
 	if (retval)
 		goto exit;
-	len =3D sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-	*offset +=3D len;
-	retval =3D len;
+	retval =3D sprintf (buf, "%d\n", value);
=20
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
=20
-static ssize_t attention_write_file (struct file *file, const char *ubuff,=
 size_t count, loff_t *offset)
+static ssize_t attention_write_file (struct hotplug_slot *slot, const char=
 *buf,
+		size_t count)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	char *buff;
 	unsigned long lattention;
 	u8 attention;
 	int retval =3D 0;
=20
-	if (*offset < 0)
-		return -EINVAL;
-	if (count =3D=3D 0 || count > 16384)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	buff =3D kmalloc (count + 1, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-	memset (buff, 0x00, count + 1);
-
-	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-=09
-	lattention =3D simple_strtoul (buff, NULL, 10);
+	lattention =3D simple_strtoul (buf, NULL, 10);
 	attention =3D (u8)(lattention & 0xff);
 	dbg (" - attention =3D %d\n", attention);
=20
@@ -776,128 +252,63 @@
 	module_put(slot->ops->owner);
=20
 exit:=09
-	kfree (buff);
-
 	if (retval)
 		return retval;
 	return count;
 }
=20
-static ssize_t latch_read_file (struct file *file, char *buf, size_t count=
, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_attention =3D {
+	.attr =3D {.name =3D "attention", .mode =3D S_IFREG | S_IRUGO | S_IWUSR},
+	.show =3D attention_read_file,
+	.store =3D attention_write_file
+};
+
+static ssize_t latch_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
=20
-	dbg("count =3D %d, offset =3D %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <=3D 0)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	page =3D (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval =3D get_latch_status (slot, &value);
 	if (retval)
 		goto exit;
-	len =3D sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-	*offset +=3D len;
-	retval =3D len;
+	retval =3D sprintf (buf, "%d\n", value);
=20
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
=20
-static ssize_t presence_read_file (struct file *file, char *buf, size_t co=
unt, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_latch =3D {
+	.attr =3D {.name =3D "latch", .mode =3D S_IFREG | S_IRUGO | S_IWUSR},
+	.show =3D latch_read_file,
+};
+
+static ssize_t presence_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
=20
-	dbg("count =3D %d, offset =3D %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <=3D 0)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	page =3D (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval =3D get_adapter_status (slot, &value);
 	if (retval)
 		goto exit;
-	len =3D sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-	*offset +=3D len;
-	retval =3D len;
+	retval =3D sprintf (buf, "%d\n", value);
=20
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
=20
+static struct hotplug_slot_attribute hotplug_slot_attr_presence =3D {
+	.attr =3D {.name =3D "adapter", .mode =3D S_IFREG | S_IRUGO | S_IWUSR},
+	.show =3D presence_read_file,
+};
+
 static char *unknown_speed =3D "Unknown bus speed";
=20
-static ssize_t max_bus_speed_read_file (struct file *file, char *buf, size=
_t count, loff_t *offset)
+static ssize_t max_bus_speed_read_file (struct hotplug_slot *slot, char *b=
uf)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	unsigned char *page;
 	char *speed_string;
 	int retval;
-	int len =3D 0;
 	enum pci_bus_speed value;
 =09
-	dbg ("count =3D %d, offset =3D %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <=3D 0)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	page =3D (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval =3D get_max_bus_speed (slot, &value);
 	if (retval)
 		goto exit;
@@ -907,47 +318,23 @@
 	else
 		speed_string =3D pci_bus_speed_strings[value];
 =09
-	len =3D sprintf (page, "%s\n", speed_string);
-
-	if (copy_to_user (buf, page, len)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-	*offset +=3D len;
-	retval =3D len;
+	retval =3D sprintf (buf, "%s\n", speed_string);
=20
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
=20
-static ssize_t cur_bus_speed_read_file (struct file *file, char *buf, size=
_t count, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_max_bus_speed =3D {
+	.attr =3D {.name =3D "max_bus_speed", .mode =3D S_IFREG | S_IRUGO | S_IWU=
SR},
+	.show =3D max_bus_speed_read_file,
+};
+
+static ssize_t cur_bus_speed_read_file (struct hotplug_slot *slot, char *b=
uf)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	unsigned char *page;
 	char *speed_string;
 	int retval;
-	int len =3D 0;
 	enum pci_bus_speed value;
=20
-	dbg ("count =3D %d, offset =3D %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <=3D 0)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	page =3D (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval =3D get_cur_bus_speed (slot, &value);
 	if (retval)
 		goto exit;
@@ -957,51 +344,25 @@
 	else
 		speed_string =3D pci_bus_speed_strings[value];
 =09
-	len =3D sprintf (page, "%s\n", speed_string);
-
-	if (copy_to_user (buf, page, len)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-	*offset +=3D len;
-	retval =3D len;
+	retval =3D sprintf (buf, "%s\n", speed_string);
=20
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
=20
-static ssize_t test_write_file (struct file *file, const char *ubuff, size=
_t count, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_cur_bus_speed =3D {
+	.attr =3D {.name =3D "cur_bus_speed", .mode =3D S_IFREG | S_IRUGO | S_IWU=
SR},
+	.show =3D cur_bus_speed_read_file,
+};
+
+static ssize_t test_write_file (struct hotplug_slot *slot, const char *buf=
,
+		size_t count)
 {
-	struct hotplug_slot *slot =3D file->private_data;
-	char *buff;
 	unsigned long ltest;
 	u32 test;
 	int retval =3D 0;
=20
-	if (*offset < 0)
-		return -EINVAL;
-	if (count =3D=3D 0 || count > 16384)
-		return 0;
-	if (*offset !=3D 0)
-		return 0;
-
-	if (slot =3D=3D NULL) {
-		dbg("slot =3D=3D NULL???\n");
-		return -ENODEV;
-	}
-
-	buff =3D kmalloc (count + 1, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-	memset (buff, 0x00, count + 1);
-
-	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
-		retval =3D -EFAULT;
-		goto exit;
-	}
-=09
-	ltest =3D simple_strtoul (buff, NULL, 10);
+        ltest =3D simple_strtoul (buf, NULL, 10);
 	test =3D (u32)(ltest & 0xffffffff);
 	dbg ("test =3D %d\n", test);
=20
@@ -1014,104 +375,69 @@
 	module_put(slot->ops->owner);
=20
 exit:=09
-	kfree (buff);
-
 	if (retval)
 		return retval;
 	return count;
 }
=20
+static struct hotplug_slot_attribute hotplug_slot_attr_test =3D {
+	.attr =3D {.name =3D "test", .mode =3D S_IFREG | S_IRUGO | S_IWUSR},
+	.store =3D test_write_file
+};
+
 static int fs_add_slot (struct hotplug_slot *slot)
 {
-	struct hotplug_slot_core *core =3D slot->core_priv;
-	int result;
+	if ((slot->ops->enable_slot) ||
+	    (slot->ops->disable_slot) ||
+	    (slot->ops->get_power_status))
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+
+	if ((slot->ops->set_attention_status) ||
+	    (slot->ops->get_attention_status))
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
+
+	if (slot->ops->get_latch_status)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
=20
-	result =3D get_mount();
-	if (result)
-		return result;
-
-	core->dir_dentry =3D fs_create_file (slot->name,
-					   S_IFDIR | S_IXUGO | S_IRUGO,
-					   NULL, NULL, NULL);
-	if (core->dir_dentry !=3D NULL) {
-		if ((slot->ops->enable_slot) ||
-		    (slot->ops->disable_slot) ||
-		    (slot->ops->get_power_status))
-			core->power_dentry =3D=20
-				fs_create_file ("power",
-						S_IFREG | S_IRUGO | S_IWUSR,
-						core->dir_dentry, slot,
-						&power_file_operations);
-
-		if ((slot->ops->set_attention_status) ||
-		    (slot->ops->get_attention_status))
-			core->attention_dentry =3D
-				fs_create_file ("attention",
-						S_IFREG | S_IRUGO | S_IWUSR,
-						core->dir_dentry, slot,
-						&attention_file_operations);
-
-		if (slot->ops->get_latch_status)
-			core->latch_dentry =3D=20
-				fs_create_file ("latch",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&latch_file_operations);
-
-		if (slot->ops->get_adapter_status)
-			core->adapter_dentry =3D=20
-				fs_create_file ("adapter",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&presence_file_operations);
-
-		if (slot->ops->get_max_bus_speed)
-			core->max_bus_speed_dentry =3D=20
-				fs_create_file ("max_bus_speed",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&max_bus_speed_file_operations);
-
-		if (slot->ops->get_cur_bus_speed)
-			core->cur_bus_speed_dentry =3D
-				fs_create_file ("cur_bus_speed",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&cur_bus_speed_file_operations);
-
-		if (slot->ops->hardware_test)
-			core->test_dentry =3D
-				fs_create_file ("test",
-						S_IFREG | S_IRUGO | S_IWUSR,
-						core->dir_dentry, slot,
-						&test_file_operations);
-	}
+	if (slot->ops->get_adapter_status)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
+
+	if (slot->ops->get_max_bus_speed)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
+
+	if (slot->ops->get_cur_bus_speed)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
+
+	if (slot->ops->hardware_test)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_test.attr);
 	return 0;
 }
=20
 static void fs_remove_slot (struct hotplug_slot *slot)
 {
-	struct hotplug_slot_core *core =3D slot->core_priv;
+	if ((slot->ops->enable_slot) ||
+	    (slot->ops->disable_slot) ||
+	    (slot->ops->get_power_status))
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+
+	if ((slot->ops->set_attention_status) ||
+	    (slot->ops->get_attention_status))
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
+
+	if (slot->ops->get_latch_status)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
=20
-	if (core->dir_dentry) {
-		if (core->power_dentry)
-			fs_remove_file (core->power_dentry);
-		if (core->attention_dentry)
-			fs_remove_file (core->attention_dentry);
-		if (core->latch_dentry)
-			fs_remove_file (core->latch_dentry);
-		if (core->adapter_dentry)
-			fs_remove_file (core->adapter_dentry);
-		if (core->max_bus_speed_dentry)
-			fs_remove_file (core->max_bus_speed_dentry);
-		if (core->cur_bus_speed_dentry)
-			fs_remove_file (core->cur_bus_speed_dentry);
-		if (core->test_dentry)
-			fs_remove_file (core->test_dentry);
-		fs_remove_file (core->dir_dentry);
-	}
+	if (slot->ops->get_adapter_status)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
=20
-	remove_mount();
+	if (slot->ops->get_max_bus_speed)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
+
+	if (slot->ops->get_cur_bus_speed)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
+
+	if (slot->ops->hardware_test)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_test.attr);
 }
=20
 static struct hotplug_slot *get_slot_from_name (const char *name)
@@ -1138,7 +464,6 @@
  */
 int pci_hp_register (struct hotplug_slot *slot)
 {
-	struct hotplug_slot_core *core;
 	int result;
=20
 	if (slot =3D=3D NULL)
@@ -1146,21 +471,21 @@
 	if ((slot->info =3D=3D NULL) || (slot->ops =3D=3D NULL))
 		return -EINVAL;
=20
-	core =3D kmalloc (sizeof (struct hotplug_slot_core), GFP_KERNEL);
-	if (!core)
-		return -ENOMEM;
-
 	/* make sure we have not already registered this slot */
 	spin_lock (&list_lock);
 	if (get_slot_from_name (slot->name) !=3D NULL) {
 		spin_unlock (&list_lock);
-		kfree (core);
 		return -EINVAL;
 	}
=20
-	memset (core, 0, sizeof (struct hotplug_slot_core));
-	slot->core_priv =3D core;
+	strncpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
+	kobj_set_kset_s(slot, hotplug_slots_subsys);
=20
+	if (kobject_register(&slot->kobj)) {
+		err("Unable to register kobject");
+		return -EINVAL;
+	}
+	=09
 	list_add (&slot->slot_list, &pci_hotplug_slot_list);
 	spin_unlock (&list_lock);
=20
@@ -1197,20 +522,11 @@
 	spin_unlock (&list_lock);
=20
 	fs_remove_slot (slot);
-	kfree(slot->core_priv);
 	dbg ("Removed slot %s from the list\n", slot->name);
+	kobject_unregister(&slot->kobj);
 	return 0;
 }
=20
-static inline void update_dentry_inode_time (struct dentry *dentry)
-{
-	struct inode *inode =3D dentry->d_inode;
-	if (inode) {
-		inode->i_mtime =3D CURRENT_TIME;
-		dnotify_parent(dentry, DN_MODIFY);
-	}
-}
-
 /**
  * pci_hp_change_slot_info - changes the slot's information structure in t=
he core
  * @name: the name of the slot whose info has changed
@@ -1224,7 +540,6 @@
 int pci_hp_change_slot_info (const char *name, struct hotplug_slot_info *i=
nfo)
 {
 	struct hotplug_slot *temp;
-	struct hotplug_slot_core *core;
=20
 	if (info =3D=3D NULL)
 		return -ENODEV;
@@ -1240,22 +555,16 @@
 	 * check all fields in the info structure, and update timestamps
 	 * for the files referring to the fields that have now changed.
 	 */
-	core =3D temp->core_priv;
-	if ((core->power_dentry) &&
-	    (temp->info->power_status !=3D info->power_status))
-		update_dentry_inode_time (core->power_dentry);
-	if ((core->attention_dentry) &&
-	    (temp->info->attention_status !=3D info->attention_status))
-		update_dentry_inode_time (core->attention_dentry);
-	if ((core->latch_dentry) &&
-	    (temp->info->latch_status !=3D info->latch_status))
-		update_dentry_inode_time (core->latch_dentry);
-	if ((core->adapter_dentry) &&
-	    (temp->info->adapter_status !=3D info->adapter_status))
-		update_dentry_inode_time (core->adapter_dentry);
-	if ((core->cur_bus_speed_dentry) &&
-	    (temp->info->cur_bus_speed !=3D info->cur_bus_speed))
-		update_dentry_inode_time (core->cur_bus_speed_dentry);
+	if (temp->info->power_status !=3D info->power_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->attention_status !=3D info->attention_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->latch_status !=3D info->latch_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->adapter_status !=3D info->adapter_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->cur_bus_speed !=3D info->cur_bus_speed)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
=20
 	memcpy (temp->info, info, sizeof (struct hotplug_slot_info));
 	spin_unlock (&list_lock);
@@ -1266,32 +575,25 @@
 {
 	int result;
=20
-	spin_lock_init(&mount_lock);
 	spin_lock_init(&list_lock);
=20
-	dbg("registering filesystem.\n");
-	result =3D register_filesystem(&pcihpfs_type);
+	kset_set_kset_s(&hotplug_slots_subsys, pci_bus_type.subsys);
+	result =3D subsystem_register(&hotplug_slots_subsys);
 	if (result) {
-		err("register_filesystem failed with %d\n", result);
+		err("Register subsys with error %d\n", result);
 		goto exit;
 	}
-
 	result =3D cpci_hotplug_init(debug);
 	if (result) {
 		err ("cpci_hotplug_init with error %d\n", result);
-		goto error_fs;
+		goto err_subsys;
 	}
=20
-#ifdef CONFIG_PROC_FS
-	/* create mount point for pcihpfs */
-	slotdir =3D proc_mkdir(slotdir_name, proc_bus_pci_dir);
-#endif
-
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	goto exit;
 =09
-error_fs:
-	unregister_filesystem(&pcihpfs_type);
+err_subsys:
+	subsystem_unregister(&hotplug_slots_subsys);
 exit:
 	return result;
 }
@@ -1299,13 +601,7 @@
 static void __exit pci_hotplug_exit (void)
 {
 	cpci_hotplug_exit();
-
-	unregister_filesystem(&pcihpfs_type);
-
-#ifdef CONFIG_PROC_FS
-	if (slotdir)
-		remove_proc_entry(slotdir_name, proc_bus_pci_dir);
-#endif
+	subsystem_unregister(&hotplug_slots_subsys);
 }
=20
 module_init(pci_hotplug_init);
@@ -1320,4 +616,3 @@
 EXPORT_SYMBOL_GPL(pci_hp_register);
 EXPORT_SYMBOL_GPL(pci_hp_deregister);
 EXPORT_SYMBOL_GPL(pci_hp_change_slot_info);
-

--=-cZ23kW2RW4/b/0VQ0pSe--

