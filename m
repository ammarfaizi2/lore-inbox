Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbTAJWAQ>; Fri, 10 Jan 2003 17:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbTAJWAQ>; Fri, 10 Jan 2003 17:00:16 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:18414 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S266270AbTAJWAJ>; Fri, 10 Jan 2003 17:00:09 -0500
Date: Fri, 10 Jan 2003 17:08:49 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Greg KH <greg@kroah.com>, "Yang, Harold" <harold.yang@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Re:[BUG] cpci patch for kernel 2.4.19 bug
In-Reply-To: <007d01c2b758$c73d17b0$79d40a0a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0301101645340.4685-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Rusty Lynch wrote:

> Just realized that the data I attached was for a 2.5.54
> kernel with my patch to register both cpci buses.  Here
> is the same output for a normal 2.5.54 kernel.

Could you try the included patch against the ZT5550 driver out and let
me know if it works better for you?  I dug through the host controller 
docs that Performance Tech provided me, so now the driver only registers 
the appropiate cPCI buses that are active.  I think this suffices for
now, but things  will become more complicated if/when someone wants to 
expand the driver to do redundant system slot stuff.

Note that the patch is also available from:

ftp://oss.somanetworks.com/pub/linux/cpci/v2.5/linux-2.5.55-cpcihp_zt5550-1.patch

and while it's against 2.5.55, should also apply cleanly against 2.5.54
and probably against the 2.4.19 patch I released on pcihpd-discuss a
while back.

Scott


diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/hotplug/cpcihp_zt5550.c linux-2.5-dev/drivers/hotplug/cpcihp_zt5550.c
--- linux-2.5/drivers/hotplug/cpcihp_zt5550.c	Thu Jan  9 13:45:31 2003
+++ linux-2.5-dev/drivers/hotplug/cpcihp_zt5550.c	Thu Jan  9 22:53:52 2003
@@ -38,7 +38,7 @@
 #include "cpci_hotplug.h"
 #include "cpcihp_zt5550.h"
 
-#define DRIVER_VERSION	"0.2"
+#define DRIVER_VERSION	"0.3"
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"ZT5550 CompactPCI Hot Plug Driver"
 
@@ -64,9 +64,11 @@
 static struct cpci_hp_controller_ops zt5550_hpc_ops;
 static struct cpci_hp_controller zt5550_hpc;
 
-/* Primary cPCI bus bridge device */
-static struct pci_dev *bus0_dev;
-static struct pci_bus *bus0;
+/* cPCI bus bridge devices */
+static struct pci_dev *bus1_dev;
+static struct pci_bus *bus1;
+static struct pci_dev *bus2_dev;
+static struct pci_bus *bus2;
 
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
 
+/* Host controller status register */
+static u32 hcf_hcs;
 
 static int zt5550_hc_config(struct pci_dev *pdev)
 {
@@ -109,23 +113,28 @@
 
 	csr_hc_index = hc_registers + CSR_HCINDEX;
 	csr_hc_data = hc_registers + CSR_HCDATA;
-	csr_int_status = hc_registers + CSR_INTSTAT;
-	csr_int_mask = hc_registers + CSR_INTMASK;
+	csr_intstat = hc_registers + CSR_INTSTAT;
+	csr_intmask = hc_registers + CSR_INTMASK;
+
+	/* Read Host Control Status register */
+	writeb((u8) HCF_HCS, csr_hc_index);
+	hcf_hcs = readl(csr_hc_data);
+	info("HCF_HCS = 0x%08x", hcf_hcs);
 
 	/*
 	 * Disable host control, fault and serial interrupts
 	 */
 	dbg("disabling host control, fault and serial interrupts");
-	writeb((u8) HC_INT_MASK_REG, csr_hc_index);
-	writeb((u8) ALL_INDEXED_INTS_MASK, csr_hc_data);
+	writeb((u8) HCF_HCI, csr_hc_index);
+	writeb((u8) HCI_ALL_INTS_MASK, csr_hc_data);
 	dbg("disabled host control, fault and serial interrupts");
 
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
 
@@ -153,7 +162,7 @@
 
 	ret = 0;
 	if(dev_id == zt5550_hpc.dev_id) {
-		reg = readb(csr_int_status);
+		reg = readb(csr_intstat);
 		if(reg)
 			ret = 1;
 	}
@@ -167,9 +176,9 @@
 	if(hc_dev == NULL) {
 		return -ENODEV;
 	}
-	reg = readb(csr_int_mask);
-	reg = reg & ~ENUM_INT_MASK;
-	writeb(reg, csr_int_mask);
+	reg = readb(csr_intmask);
+	reg = reg & ~INTMASK_ENUM_INT_MASK;
+	writeb(reg, csr_intmask);
 	return 0;
 }
 
@@ -181,16 +190,42 @@
 		return -ENODEV;
 	}
 
-	reg = readb(csr_int_mask);
-	reg = reg | ENUM_INT_MASK;
-	writeb(reg, csr_int_mask);
+	reg = readb(csr_intmask);
+	reg = reg | INTMASK_ENUM_INT_MASK;
+	writeb(reg, csr_intmask);
 	return 0;
 }
 
+static int __devinit zt5550_register_bus(unsigned int slot,
+					 struct pci_dev **dev,
+					 struct pci_bus **bus)
+{
+	int status;
+
+	/* Look for slot's device */
+	if(!(*dev = pci_find_slot(0, PCI_DEVFN(slot, 0)))) {
+		return -ENODEV;
+	}
+	if(!((*dev)->vendor == PCI_VENDOR_ID_DEC && \
+	     (*dev)->device == PCI_DEVICE_ID_DEC_21154)) {
+		return -ENODEV;
+	}
+	*bus = (*dev)->subordinate;
+
+	status = cpci_hp_register_bus(*bus, 0x0a, 0x0f);
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
 
 	status = zt5550_hc_config(pdev);
 	if(status != 0) {
@@ -198,6 +233,10 @@
 	}
 	dbg("returned from zt5550_hc_config");
 
+	r = request_region(ENUM_PORT, 1, "ENUM# hotswap signal register");
+	if(!r)
+		return -EBUSY;
+
 	memset(&zt5550_hpc, 0, sizeof (struct cpci_hp_controller));
 	zt5550_hpc_ops.query_enum = zt5550_hc_query_enum;
 	zt5550_hpc.ops = &zt5550_hpc_ops;
@@ -220,31 +259,30 @@
 	}
 	dbg("registered controller");
 
-	/* Look for first device matching cPCI bus's bridge vendor and device IDs */
-	if(!(bus0_dev = pci_find_device(PCI_VENDOR_ID_DEC,
-					 PCI_DEVICE_ID_DEC_21154, NULL))) {
-		status = -ENODEV;
-		goto init_register_error;
-	}
-	bus0 = bus0_dev->subordinate;
-
-	status = cpci_hp_register_bus(bus0, 0x0a, 0x0f);
-	if(status != 0) {
-		err("could not register cPCI hotplug bus");
-		goto init_register_error;
+	if(hcf_hcs & HCS_BUS1_ACTIVE) {
+		status = zt5550_register_bus(BUS1_SLOT, &bus1_dev, &bus1);
+		if(status)
+			goto init_register_error;
+	}
+	if(hcf_hcs & HCS_BUS2_ACTIVE) {
+		status = zt5550_register_bus(BUS2_SLOT, &bus2_dev, &bus2);
+		if(status)
+			goto init_register_error;
 	}
-	dbg("registered bus");
 
 	status = cpci_hp_start();
 	if(status != 0) {
 		err("could not started cPCI hotplug system");
-		cpci_hp_unregister_bus(bus0);
 		goto init_register_error;
 	}
-	dbg("started cpci hp system");
+	dbg("started cPCI hotplug system");
 
 	return 0;
 init_register_error:
+	if(bus1)
+		cpci_hp_unregister_bus(bus1);
+	if(bus2)
+		cpci_hp_unregister_bus(bus2);
 	cpci_hp_unregister_controller(&zt5550_hpc);
 init_hc_error:
 	err("status = %d", status);
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
 
 static int __init zt5550_init(void)
 {
-	struct resource* r;
-
 	info(DRIVER_DESC " version: " DRIVER_VERSION);
-	r = request_region(ENUM_PORT, 1, "#ENUM hotswap signal register");
-	if(!r)
-		return -EBUSY;
-
 	return pci_module_init(&zt5550_hc_driver);
 }
 
@@ -303,4 +338,4 @@
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 MODULE_PARM(poll, "i");
-MODULE_PARM_DESC(poll, "#ENUM polling mode enabled or not");
+MODULE_PARM_DESC(poll, "ENUM# polling mode enabled or not");
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/hotplug/cpcihp_zt5550.h linux-2.5-dev/drivers/hotplug/cpcihp_zt5550.h
--- linux-2.5/drivers/hotplug/cpcihp_zt5550.h	Thu Jan  9 13:45:31 2003
+++ linux-2.5-dev/drivers/hotplug/cpcihp_zt5550.h	Fri Jan 10 16:11:24 2003
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
 
 /* Masks for interrupt bits in CSR_INTMASK direct register */
-#define CNT0_INT_MASK		0x01
-#define CNT1_INT_MASK		0x02
-#define ENUM_INT_MASK		0x04
-#define ALL_DIRECT_INTS_MASK	0x07
+#define INTMASK_TIM0_INT_MASK	0x01
+#define INTMASK_TIM1_INT_MASK	0x02
+#define INTMASK_ENUM_INT_MASK	0x04
+#define INTMASK_ALL_INTS_MASK	0x07
 
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
 
 /* Digital I/O port storing ENUM# */
 #define ENUM_PORT	0xE1


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com



