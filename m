Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbTBFSWW>; Thu, 6 Feb 2003 13:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbTBFSWW>; Thu, 6 Feb 2003 13:22:22 -0500
Received: from fmr09.intel.com ([192.52.57.35]:60926 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id <S267509AbTBFSVn>;
	Thu, 6 Feb 2003 13:21:43 -0500
Subject: Re: [PATCH][2.5.59-bk]Sysfs interface for ZT5550 Redundant Host
	Controller
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Scott Murray <scottm@somanetworks.com>, Patrick Mochel <mochel@osdl.org>,
       Stanley Wang <stanley.wang@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030206041243.GB23837@kroah.com>
References: <Pine.LNX.4.44.0302051341490.29820-100000@rancor.yyz.somanetworks.com>
	<1044478128.2270.17.camel@vmhack>  <20030206041243.GB23837@kroah.com>
Content-Type: multipart/mixed; boundary="=-hytyV9kjOtyVB2gI2YuN"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Feb 2003 10:29:05 -0800
Message-Id: <1044556146.3098.9.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hytyV9kjOtyVB2gI2YuN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-02-05 at 20:12, Greg KH wrote:
> On Wed, Feb 05, 2003 at 12:48:48PM -0800, Rusty Lynch wrote:
> > Here is a second version of the zt5550 reduncant host controller sysfs
> > interface patch.
> 
> I couldnt get this to apply, sorry.  Can you rediff it against the
> patches I just sent to Linus?
> 
> thanks,
> 
> greg k-h

Here is my patch on today's bk tree and Scott's deadlock fix.  

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.975   -> 1.976  
#	drivers/hotplug/cpcihp_zt5550.h	1.2     -> 1.3    
#	drivers/hotplug/Kconfig	1.5     -> 1.6    
#	drivers/hotplug/cpcihp_zt5550.c	1.2     -> 1.3    
#	drivers/hotplug/Makefile	1.13    -> 1.14   
#	               (new)	        -> 1.1     drivers/hotplug/cpcihp_zt5550_rhc.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/06	rusty@penguin.co.intel.com	1.976
# Adding sysfs interface for the zt5550 redundant host controller
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/Kconfig b/drivers/hotplug/Kconfig
--- a/drivers/hotplug/Kconfig	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/Kconfig	Thu Feb  6 10:29:53 2003
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
--- a/drivers/hotplug/Makefile	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/Makefile	Thu Feb  6 10:29:53 2003
@@ -7,6 +7,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
+obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550_RHC)	+= cpcihp_zt5550_rhc.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o
diff -Nru a/drivers/hotplug/cpcihp_zt5550.c b/drivers/hotplug/cpcihp_zt5550.c
--- a/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:29:53 2003
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
@@ -277,6 +263,7 @@
 	}
 	dbg("started cPCI hotplug system");
 
+
 	return 0;
 init_register_error:
 	if(bus1)
@@ -318,13 +305,20 @@
 
 static int __init zt5550_init(void)
 {
+	int rv;
+
 	info(DRIVER_DESC " version: " DRIVER_VERSION);
-	return pci_module_init(&zt5550_hc_driver);
+	rv = pci_module_init(&zt5550_hc_driver);
+	if (!rv)
+		create_hc_files(csr_hc_index,csr_hc_data,&zt5550_hc_driver);
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
--- a/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:29:53 2003
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
+extern void create_hc_files(void *,void *,struct pci_driver *);
+extern void remove_hc_files(void);
+#else /* !CONFIG_HOTPLUG_PCI_CPCI_ZT5550_RHC */
+static inline void create_hc_files(void *i,void *d,struct pci_driver *p){}
+static inline void remove_hc_files(void){}
+#endif
+
 #endif				/* _CPCIHP_ZT5550_H */
+
diff -Nru a/drivers/hotplug/cpcihp_zt5550_rhc.c b/drivers/hotplug/cpcihp_zt5550_rhc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpcihp_zt5550_rhc.c	Thu Feb  6 10:29:53 2003
@@ -0,0 +1,365 @@
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
+		.kobj = { .name = "rhc" },
+		.ktype = &rhc_ktype,
+	}
+};
+
+/**********************************************************************
+ * Host Control Command attributes
+ * NOTE: The HCC register is by default locked. To change any
+ *       value, first unlock by writing a '1' to the UNLOCK bit
+ *       in the ISOC register.
+ */
+decl_hc_kobject(hcc);
+
+/* Diagnostics Mode Command */
+decl_hc_store_function(diagnostics_mode,HCF_HCC,HCC_DIAG_MODE_MASK);
+decl_hc_show_function(diagnostics_mode,HCF_HCC,HCC_DIAG_MODE_MASK);
+decl_hc_attribute(diagnostics_mode);
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
+/**********************************************************************
+ * Isolation Configuration register (ISOC) attributes
+ */
+decl_hc_kobject(isoc);
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
+/* HCC Unlock Command */
+decl_hc_store_function(unlock,HCF_ISOC,ISOC_UNLOCK_MASK);
+decl_hc_show_function(unlock,HCF_ISOC,ISOC_UNLOCK_MASK);
+decl_hc_attribute(unlock);
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
+void create_hc_files(void *index, void *data, struct pci_driver *d)
+{
+	if (!index || !data || !d)
+		return;
+
+	rhc_subsys.kset.kobj.parent = &(d->driver.kobj);
+	if(subsystem_register(&rhc_subsys))
+		return;
+
+	/* hcc */
+	hcc_obj.index = index;
+	hcc_obj.data = data;
+	kobj_set_kset_s(&hcc_obj, rhc_subsys);
+	kobject_register(&hcc_obj.kobj);
+	sysfs_create_file(&hcc_obj.kobj, &diagnostics_mode_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &reset_bh_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &power_down_bh_attr.attr);
+
+	/* isoc */
+	isoc_obj.index = index;
+	isoc_obj.data = data;
+	kobj_set_kset_s(&isoc_obj, rhc_subsys);
+	kobject_register(&isoc_obj.kobj);
+	sysfs_create_file(&isoc_obj.kobj, &unlock_attr.attr);
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
+	/* hcc */
+	sysfs_remove_file(&hcc_obj.kobj, &diagnostics_mode_attr.attr);
+	sysfs_remove_file(&hcc_obj.kobj, &reset_bh_attr.attr);
+	sysfs_remove_file(&hcc_obj.kobj, &power_down_bh_attr.attr);
+	kobject_unregister(&hcc_obj.kobj);
+	
+	/* isoc */
+	sysfs_remove_file(&isoc_obj.kobj, &unlock_attr.attr);
+	sysfs_remove_file(&isoc_obj.kobj, &hostile_attr.attr);
+	sysfs_remove_file(&isoc_obj.kobj, &friendly_attr.attr);
+	kobject_unregister(&isoc_obj.kobj);
+
+	/* fltc */
+	sysfs_remove_file(&fltc_obj.kobj, &wd_timeout_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &perr_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &iochk_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &nmi_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &b0_serr_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &cputemp_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &power_fail_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &eject_bh_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &eject_ah_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &soft_reset_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &hard_reset_attr.attr);
+	kobject_unregister(&fltc_obj.kobj);
+	
+	/* wdc */
+	sysfs_remove_file(&wdc_obj.kobj, &terminal_count_attr.attr);
+	sysfs_remove_file(&wdc_obj.kobj, &prescaler_attr.attr);
+	kobject_unregister(&wdc_obj.kobj);
+
+	/* diag */
+	sysfs_remove_file(&diag_obj.kobj, &diag_wd_timeout_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_perr_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_iochk_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_nmi_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_b0_serr_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_cputemp_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_power_fail_attr.attr);	
+	kobject_unregister(&diag_obj.kobj);
+
+	subsystem_unregister(&rhc_subsys);
+}
+

--=-hytyV9kjOtyVB2gI2YuN
Content-Disposition: attachment; filename=rhc.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=rhc.diff; charset=UTF-8

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.975   -> 1.976 =20
#	drivers/hotplug/cpcihp_zt5550.h	1.2     -> 1.3   =20
#	drivers/hotplug/Kconfig	1.5     -> 1.6   =20
#	drivers/hotplug/cpcihp_zt5550.c	1.2     -> 1.3   =20
#	drivers/hotplug/Makefile	1.13    -> 1.14  =20
#	               (new)	        -> 1.1     drivers/hotplug/cpcihp_zt5550_rhc=
.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/06	rusty@penguin.co.intel.com	1.976
# Adding sysfs interface for the zt5550 redundant host controller
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/Kconfig b/drivers/hotplug/Kconfig
--- a/drivers/hotplug/Kconfig	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/Kconfig	Thu Feb  6 10:29:53 2003
@@ -101,6 +101,23 @@
=20
 	  When in doubt, say N.
=20
+config HOTPLUG_PCI_CPCI_ZT5550_RHC
+	bool "Ziatech ZT5550 CompactPCI RHC Sysfs Interface"
+	depends on HOTPLUG_PCI_CPCI_ZT5550
+	help
+	  Say Y here if you have an Performance Technologies (formerly Intel,
+          formerly just Ziatech) Ziatech ZT5550 CompactPCI system card, an=
d
+          would like to have configuration access to the onboard=20
+          Redundant Host Controller.
+
+          Saying Y here will cause a new "zt5550_rhc" directory to be crea=
ted
+          in the root of your sysfs, with a directory for each of the rhc
+          indirect registers created inside the zt5550_rhc directory, and =
then
+          control files in each of those directorys giving user space acce=
ss
+          to all of the bits in those indirect registers.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_CPCI_GENERIC
 	tristate "Generic port I/O CompactPCI Hotplug driver"
 	depends on HOTPLUG_PCI_CPCI && X86
diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/Makefile	Thu Feb  6 10:29:53 2003
@@ -7,6 +7,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+=3D ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+=3D cpcihp_zt5550.o
+obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550_RHC)	+=3D cpcihp_zt5550_rhc.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+=3D cpcihp_generic.o
=20
 pci_hotplug-objs	:=3D	pci_hotplug_core.o
diff -Nru a/drivers/hotplug/cpcihp_zt5550.c b/drivers/hotplug/cpcihp_zt5550=
.c
--- a/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:29:53 2003
@@ -35,6 +35,8 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
+#include <linux/kobject.h>
+#include <linux/bitops.h>
 #include "cpci_hotplug.h"
 #include "cpcihp_zt5550.h"
=20
@@ -42,22 +44,6 @@
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"ZT5550 CompactPCI Hot Plug Driver"
=20
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
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , =
## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME =
, ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NA=
ME , ## arg)
-
 /* local variables */
 static int debug;
 static int poll;
@@ -75,8 +61,8 @@
=20
 /* Host controller register addresses */
 static void *hc_registers;
-static void *csr_hc_index;
-static void *csr_hc_data;
+void *csr_hc_index;
+void *csr_hc_data;
 static void *csr_intstat;
 static void *csr_intmask;
=20
@@ -259,12 +245,12 @@
 	}
 	dbg("registered controller");
=20
-	if(hcf_hcs & HCS_BUS1_ACTIVE) {
+	if(hcf_hcs & HCS_BUS1_ACTIVE_MASK) {
 		status =3D zt5550_register_bus(BUS1_SLOT, &bus1_dev, &bus1);
 		if(status)
 			goto init_register_error;
 	}
-	if(hcf_hcs & HCS_BUS2_ACTIVE) {
+	if(hcf_hcs & HCS_BUS2_ACTIVE_MASK) {
 		status =3D zt5550_register_bus(BUS2_SLOT, &bus2_dev, &bus2);
 		if(status)
 			goto init_register_error;
@@ -277,6 +263,7 @@
 	}
 	dbg("started cPCI hotplug system");
=20
+
 	return 0;
 init_register_error:
 	if(bus1)
@@ -318,13 +305,20 @@
=20
 static int __init zt5550_init(void)
 {
+	int rv;
+
 	info(DRIVER_DESC " version: " DRIVER_VERSION);
-	return pci_module_init(&zt5550_hc_driver);
+	rv =3D pci_module_init(&zt5550_hc_driver);
+	if (!rv)
+		create_hc_files(csr_hc_index,csr_hc_data,&zt5550_hc_driver);
+
+	return rv;
 }
=20
 static void __exit
 zt5550_exit(void)
 {
+	remove_hc_files();
 	pci_unregister_driver(&zt5550_hc_driver);
 	release_region(ENUM_PORT, 1);
 }
diff -Nru a/drivers/hotplug/cpcihp_zt5550.h b/drivers/hotplug/cpcihp_zt5550=
.h
--- a/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:29:53 2003
+++ b/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:29:53 2003
@@ -33,6 +33,22 @@
 #ifndef _CPCIHP_ZT5550_H
 #define _CPCIHP_ZT5550_H
=20
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
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , =
## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME =
, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NA=
ME , ## arg)
+
 /* Direct registers */
 #define CSR_HCINDEX		0x00
 #define CSR_HCDATA		0x04
@@ -44,12 +60,40 @@
 #define CSR_TIM0		0x10
 #define CSR_TIM1		0x14
=20
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
=20
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
=20
-/* Masks for interrupt bits in HCF_HCI indexed register */
+/* Masks for interrupt bits in HCF_HCI          */
+/* (host controller interrupt) indexed register */
 #define HCI_SERIAL_INT_MASK	0x01
 #define HCI_FAULT_INT_MASK	0x02
 #define HCI_HCF_INT_MASK	0x04
 #define HCI_ALL_INTS_MASK	0x07
=20
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
+/* Masks for the bits in the HCF_FLTC (fault configuration) indexed regist=
er */
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
+/* Masks for the bits in the HCF_WDC (watchdog control) indexed register *=
/
+#define WDC_TERMINAL_COUNT_MASK 0x0000003f
+#define WDC_PRESCALER_MASK      0x000000c0
+
+/* Masks for the bits in the HCF_DIAG (diagnostics command) indexed regist=
er */
+#define DIAG_WD_TIMEOUT_MASK    0x00000001
+#define DIAG_PERR_MASK          0x00000002
+#define DIAG_IOCHK_MASK         0x00000004
+#define DIAG_NMI_MASK           0x00000008
+#define DIAG_B0_SERR_MASK       0x00000010
+#define DIAG_CPUTEMP_MASK       0x00000040
+#define DIAG_POWER_FAIL_MASK    0x00000080
+
+/* Masks for the bits in the HCF_SERC (diagnostics command) indexed regist=
er */
+#define SERC_DATA_SENT          0x00000001
+#define SERC_DATA_RECIEVED      0x00000002
+#define SERC_SDO_FLAG_ENABLE    0x00000004
+#define SERC_SDI_FLAG_ENABLE    0x00000008
+#define SERC_HCSI_OFF           0x00000010
+#define SERC_FIND_TOKEN         0x00000020
=20
 /* CompactPCI bus segment device slot numbers */
 #define BUS1_SLOT		0x08
 #define BUS2_SLOT		0x0C
=20
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
=20
+#define hcf_read(index, value, csr_hc_index, csr_hc_data) \
+        { \
+                writeb((u8) index, csr_hc_index); \
+                value =3D readl(csr_hc_data); \
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
+               =20
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
+		request =3D request << (generic_ffs(mask) - 1); \
+		request &=3D mask; \
+		request |=3D ~mask; \
+		hcf_read(index, tmp, csr_hc_index, csr_hc_data); \
+		tmp |=3D mask; \
+		tmp &=3D request; \
+		hcf_write(index, tmp, csr_hc_index, csr_hc_data); \
+	}
+
+#define hcf_read_bits(index, mask, value, csr_hc_index, csr_hc_data) \
+        { \
+                hcf_read(index, value, csr_hc_index, csr_hc_data); \
+                value =3D (mask&value)>>(generic_ffs(mask) - 1); \
+                dbg("hcf_read_bits(0x%08x, 0x%08x, 0x%08x)", \
+                     index,mask,value); \
+	}=20
+
+#define decl_hc_attribute(_name) \
+static struct rhc_attribute _name##_attr =3D { \
+	.attr	=3D { .name =3D __stringify(_name), .mode =3D 0644 }, \
+	.show	=3D _name##_show, \
+	.store  =3D _name##_store, \
+}
+
+#define decl_hc_kobject(_name) \
+static struct rhc _name##_obj =3D { \
+	.kobj.name =3D __stringify(_name), \
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
+static ssize_t _name##_store(struct rhc * p, const char * page, size_t cou=
nt) \
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
+extern void create_hc_files(void *,void *,struct pci_driver *);
+extern void remove_hc_files(void);
+#else /* !CONFIG_HOTPLUG_PCI_CPCI_ZT5550_RHC */
+static inline void create_hc_files(void *i,void *d,struct pci_driver *p){}
+static inline void remove_hc_files(void){}
+#endif
+
 #endif				/* _CPCIHP_ZT5550_H */
+
diff -Nru a/drivers/hotplug/cpcihp_zt5550_rhc.c b/drivers/hotplug/cpcihp_zt=
5550_rhc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpcihp_zt5550_rhc.c	Thu Feb  6 10:29:53 2003
@@ -0,0 +1,365 @@
+/*
+ * cpcihp_zt5550.c
+ *
+ * Intel/Ziatech ZT5550 CompactPCI Redundant Host Controller Sysfs Interfa=
ce
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
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES=
,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILIT=
Y=20
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL=20
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,=20
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=20
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR=20
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF=20
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING=20
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS=20
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
+static ssize_t rhc_attr_show(struct kobject * kobj,=20
+			     struct attribute * attr,
+			     char * page)
+{
+	struct rhc * i =3D container_of(kobj,struct rhc,kobj);
+	struct rhc_attribute * rhc_attr =3D=20
+		container_of(attr,struct rhc_attribute,attr);
+=09
+	return rhc_attr->show ? rhc_attr->show(i,page) : 0;
+}
+
+static ssize_t rhc_attr_store(struct kobject * kobj,=20
+			      struct attribute * attr,
+			      const char * page,
+			      size_t count)
+{
+	struct rhc * i =3D container_of(kobj,struct rhc,kobj);
+	struct rhc_attribute * rhc_attr =3D=20
+		container_of(attr,struct rhc_attribute,attr);
+
+	return rhc_attr->store ? rhc_attr->store(i,page,count) : 0;
+}
+
+static struct sysfs_ops rhc_sysfs_ops =3D {
+	.show	=3D rhc_attr_show,
+	.store  =3D rhc_attr_store,
+};
+
+static struct kobj_type rhc_ktype =3D {
+	.sysfs_ops =3D &rhc_sysfs_ops
+};
+
+static struct subsystem rhc_subsys =3D {
+	.kset =3D {
+		.kobj =3D { .name =3D "rhc" },
+		.ktype =3D &rhc_ktype,
+	}
+};
+
+/**********************************************************************
+ * Host Control Command attributes
+ * NOTE: The HCC register is by default locked. To change any
+ *       value, first unlock by writing a '1' to the UNLOCK bit
+ *       in the ISOC register.
+ */
+decl_hc_kobject(hcc);
+
+/* Diagnostics Mode Command */
+decl_hc_store_function(diagnostics_mode,HCF_HCC,HCC_DIAG_MODE_MASK);
+decl_hc_show_function(diagnostics_mode,HCF_HCC,HCC_DIAG_MODE_MASK);
+decl_hc_attribute(diagnostics_mode);
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
+/**********************************************************************
+ * Isolation Configuration register (ISOC) attributes
+ */
+decl_hc_kobject(isoc);
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
+/* HCC Unlock Command */
+decl_hc_store_function(unlock,HCF_ISOC,ISOC_UNLOCK_MASK);
+decl_hc_show_function(unlock,HCF_ISOC,ISOC_UNLOCK_MASK);
+decl_hc_attribute(unlock);
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
+void create_hc_files(void *index, void *data, struct pci_driver *d)
+{
+	if (!index || !data || !d)
+		return;
+
+	rhc_subsys.kset.kobj.parent =3D &(d->driver.kobj);
+	if(subsystem_register(&rhc_subsys))
+		return;
+
+	/* hcc */
+	hcc_obj.index =3D index;
+	hcc_obj.data =3D data;
+	kobj_set_kset_s(&hcc_obj, rhc_subsys);
+	kobject_register(&hcc_obj.kobj);
+	sysfs_create_file(&hcc_obj.kobj, &diagnostics_mode_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &reset_bh_attr.attr);
+	sysfs_create_file(&hcc_obj.kobj, &power_down_bh_attr.attr);
+
+	/* isoc */
+	isoc_obj.index =3D index;
+	isoc_obj.data =3D data;
+	kobj_set_kset_s(&isoc_obj, rhc_subsys);
+	kobject_register(&isoc_obj.kobj);
+	sysfs_create_file(&isoc_obj.kobj, &unlock_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &hostile_attr.attr);
+	sysfs_create_file(&isoc_obj.kobj, &friendly_attr.attr);
+
+	/* fltc */
+        fltc_obj.index =3D index;
+	fltc_obj.data =3D data;
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
+	/* wdc */
+	wdc_obj.index =3D index;
+	wdc_obj.data =3D data;
+	kobj_set_kset_s(&wdc_obj, rhc_subsys);
+	kobject_register(&wdc_obj.kobj);
+	sysfs_create_file(&wdc_obj.kobj, &terminal_count_attr.attr);
+	sysfs_create_file(&wdc_obj.kobj, &prescaler_attr.attr);
+
+	/* diag */
+	diag_obj.index =3D index;
+	diag_obj.data =3D data;
+	kobj_set_kset_s(&diag_obj, rhc_subsys);
+	kobject_register(&diag_obj.kobj);
+	sysfs_create_file(&diag_obj.kobj, &diag_wd_timeout_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_perr_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_iochk_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_nmi_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_b0_serr_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_cputemp_attr.attr);
+	sysfs_create_file(&diag_obj.kobj, &diag_power_fail_attr.attr);=09
+}
+
+void remove_hc_files(void)
+{
+	/* hcc */
+	sysfs_remove_file(&hcc_obj.kobj, &diagnostics_mode_attr.attr);
+	sysfs_remove_file(&hcc_obj.kobj, &reset_bh_attr.attr);
+	sysfs_remove_file(&hcc_obj.kobj, &power_down_bh_attr.attr);
+	kobject_unregister(&hcc_obj.kobj);
+=09
+	/* isoc */
+	sysfs_remove_file(&isoc_obj.kobj, &unlock_attr.attr);
+	sysfs_remove_file(&isoc_obj.kobj, &hostile_attr.attr);
+	sysfs_remove_file(&isoc_obj.kobj, &friendly_attr.attr);
+	kobject_unregister(&isoc_obj.kobj);
+
+	/* fltc */
+	sysfs_remove_file(&fltc_obj.kobj, &wd_timeout_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &perr_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &iochk_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &nmi_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &b0_serr_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &cputemp_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &power_fail_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &eject_bh_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &eject_ah_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &soft_reset_attr.attr);
+	sysfs_remove_file(&fltc_obj.kobj, &hard_reset_attr.attr);
+	kobject_unregister(&fltc_obj.kobj);
+=09
+	/* wdc */
+	sysfs_remove_file(&wdc_obj.kobj, &terminal_count_attr.attr);
+	sysfs_remove_file(&wdc_obj.kobj, &prescaler_attr.attr);
+	kobject_unregister(&wdc_obj.kobj);
+
+	/* diag */
+	sysfs_remove_file(&diag_obj.kobj, &diag_wd_timeout_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_perr_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_iochk_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_nmi_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_b0_serr_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_cputemp_attr.attr);
+	sysfs_remove_file(&diag_obj.kobj, &diag_power_fail_attr.attr);=09
+	kobject_unregister(&diag_obj.kobj);
+
+	subsystem_unregister(&rhc_subsys);
+}
+

--=-hytyV9kjOtyVB2gI2YuN--

