Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTBFSPw>; Thu, 6 Feb 2003 13:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbTBFSPv>; Thu, 6 Feb 2003 13:15:51 -0500
Received: from fmr01.intel.com ([192.55.52.18]:32496 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267494AbTBFSPe>;
	Thu, 6 Feb 2003 13:15:34 -0500
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
Content-Type: multipart/mixed; boundary="=-+9etmQeW3wUE3YrliWxR"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Feb 2003 10:23:13 -0800
Message-Id: <1044555793.3098.5.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+9etmQeW3wUE3YrliWxR
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

It wouldn't apply because it was made on top of Scott's uniprocessor
deadlock fix.  Here is a Scott's previous patch merged with today's bk
tree.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.974   -> 1.975  
#	drivers/hotplug/cpcihp_zt5550.h	1.1     -> 1.2    
#	drivers/hotplug/cpci_hotplug.h	1.1     -> 1.2    
#	drivers/hotplug/cpci_hotplug_core.c	1.3     -> 1.4    
#	drivers/hotplug/cpcihp_zt5550.c	1.1     -> 1.2    
#	drivers/hotplug/cpci_hotplug_pci.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/06	rusty@penguin.co.intel.com	1.975
# Adding cpci uniprocessor deadlock fix
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpci_hotplug.h b/drivers/hotplug/cpci_hotplug.h
--- a/drivers/hotplug/cpci_hotplug.h	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpci_hotplug.h	Thu Feb  6 10:18:12 2003
@@ -75,7 +75,6 @@
 extern int cpci_hp_unregister_controller(struct cpci_hp_controller *controller);
 extern int cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last);
 extern int cpci_hp_unregister_bus(struct pci_bus *bus);
-extern struct slot *cpci_find_slot(struct pci_bus *bus, unsigned int devfn);
 extern int cpci_hp_start(void);
 extern int cpci_hp_stop(void);
 
diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
--- a/drivers/hotplug/cpci_hotplug_core.c	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpci_hotplug_core.c	Thu Feb  6 10:18:12 2003
@@ -417,34 +417,6 @@
 	return 0;
 }
 
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
-	found = NULL;
-	list_for_each(tmp, &slot_list) {
-		slot = list_entry(tmp, struct slot, slot_list);
-		if(slot->bus == bus && slot->devfn == devfn) {
-			found = slot;
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
diff -Nru a/drivers/hotplug/cpci_hotplug_pci.c b/drivers/hotplug/cpci_hotplug_pci.c
--- a/drivers/hotplug/cpci_hotplug_pci.c	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpci_hotplug_pci.c	Thu Feb  6 10:18:12 2003
@@ -448,7 +448,7 @@
 }
 
 static int configure_visit_pci_dev(struct pci_dev_wrapped *wrapped_dev,
-			struct pci_bus_wrapped *wrapped_bus)
+				   struct pci_bus_wrapped *wrapped_bus)
 {
 	int rc;
 	struct pci_dev *dev = wrapped_dev->dev;
@@ -461,8 +461,8 @@
 	 * We need to fix up the hotplug representation with the Linux
 	 * representation.
 	 */
-	slot = cpci_find_slot(dev->bus, dev->devfn);
-	if(slot) {
+	if(wrapped_dev->data) {
+		slot = (struct slot*) wrapped_dev->data;
 		slot->dev = dev;
 	}
 
@@ -484,7 +484,7 @@
 }
 
 static int unconfigure_visit_pci_dev_phase1(struct pci_dev_wrapped *wrapped_dev,
-				 struct pci_bus_wrapped *wrapped_bus)
+					    struct pci_bus_wrapped *wrapped_bus)
 {
 	struct pci_dev *dev = wrapped_dev->dev;
 
@@ -527,8 +527,8 @@
 	/*
 	 * Now remove the hotplug representation.
 	 */
-	slot = cpci_find_slot(dev->bus, dev->devfn);
-	if(slot) {
+	if(wrapped_dev->data) {
+		slot = (struct slot*) wrapped_dev->data;
 		slot->dev = NULL;
 	} else {
 		dbg("No hotplug representation for %02x:%02x.%x",
@@ -636,6 +636,10 @@
 				continue;
 			wrapped_dev.dev = dev;
 			wrapped_bus.bus = slot->dev->bus;
+			if(i)
+				wrapped_dev.data = NULL;
+			else
+				wrapped_dev.data = (void*) slot;
 			rc = pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
 		}
 	}
@@ -668,16 +672,21 @@
 		if(dev) {
 			wrapped_dev.dev = dev;
 			wrapped_bus.bus = dev->bus;
+			if(i)
+				wrapped_dev.data = NULL;
+			else
+				wrapped_dev.data = (void*) slot;
 			dbg("%s - unconfigure phase 1", __FUNCTION__);
 			rc = pci_visit_dev(&unconfigure_functions_phase1,
-					   &wrapped_dev, &wrapped_bus);
-			if(rc) {
+					   &wrapped_dev,
+					   &wrapped_bus);
+			if(rc)
 				break;
-			}
 
 			dbg("%s - unconfigure phase 2", __FUNCTION__);
 			rc = pci_visit_dev(&unconfigure_functions_phase2,
-					   &wrapped_dev, &wrapped_bus);
+					   &wrapped_dev,
+					   &wrapped_bus);
 			if(rc)
 				break;
 		}
diff -Nru a/drivers/hotplug/cpcihp_zt5550.c b/drivers/hotplug/cpcihp_zt5550.c
--- a/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:18:12 2003
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
diff -Nru a/drivers/hotplug/cpcihp_zt5550.h b/drivers/hotplug/cpcihp_zt5550.h
--- a/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:18:12 2003
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

--=-+9etmQeW3wUE3YrliWxR
Content-Disposition: attachment; filename=deadlock.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=deadlock.diff; charset=UTF-8

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.974   -> 1.975 =20
#	drivers/hotplug/cpcihp_zt5550.h	1.1     -> 1.2   =20
#	drivers/hotplug/cpci_hotplug.h	1.1     -> 1.2   =20
#	drivers/hotplug/cpci_hotplug_core.c	1.3     -> 1.4   =20
#	drivers/hotplug/cpcihp_zt5550.c	1.1     -> 1.2   =20
#	drivers/hotplug/cpci_hotplug_pci.c	1.4     -> 1.5   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/06	rusty@penguin.co.intel.com	1.975
# Adding cpci uniprocessor deadlock fix
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpci_hotplug.h b/drivers/hotplug/cpci_hotplug.h
--- a/drivers/hotplug/cpci_hotplug.h	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpci_hotplug.h	Thu Feb  6 10:18:12 2003
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
--- a/drivers/hotplug/cpci_hotplug_core.c	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpci_hotplug_core.c	Thu Feb  6 10:18:12 2003
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
--- a/drivers/hotplug/cpci_hotplug_pci.c	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpci_hotplug_pci.c	Thu Feb  6 10:18:12 2003
@@ -448,7 +448,7 @@
 }
=20
 static int configure_visit_pci_dev(struct pci_dev_wrapped *wrapped_dev,
-			struct pci_bus_wrapped *wrapped_bus)
+				   struct pci_bus_wrapped *wrapped_bus)
 {
 	int rc;
 	struct pci_dev *dev =3D wrapped_dev->dev;
@@ -461,8 +461,8 @@
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
@@ -484,7 +484,7 @@
 }
=20
 static int unconfigure_visit_pci_dev_phase1(struct pci_dev_wrapped *wrappe=
d_dev,
-				 struct pci_bus_wrapped *wrapped_bus)
+					    struct pci_bus_wrapped *wrapped_bus)
 {
 	struct pci_dev *dev =3D wrapped_dev->dev;
=20
@@ -527,8 +527,8 @@
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
@@ -636,6 +636,10 @@
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
@@ -668,16 +672,21 @@
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
--- a/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpcihp_zt5550.c	Thu Feb  6 10:18:12 2003
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
--- a/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:18:12 2003
+++ b/drivers/hotplug/cpcihp_zt5550.h	Thu Feb  6 10:18:12 2003
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

--=-+9etmQeW3wUE3YrliWxR--

