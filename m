Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbVKDBDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbVKDBDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbVKDAuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:50:46 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:54675
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161022AbVKDAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:50:18 -0500
Date: Thu, 3 Nov 2005 18:50:17 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 14/42]: ppc64: Save & restore of PCI device BARS
Message-ID: <20051104005017.GA26911@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

14-eeh-device-bar-save.patch

After a PCI device has been resest, the device BAR's and other config
space info must be restored to the same state as they were in when 
the firmware first handed us this device.  This will allow the 
PCI device driver, when restarted, to correctly recognize and set up
the device.

Tis patch saves the device config space as early as reasonable after
the firmware has handed over the device.  Te state resore funcion 
is inteded for use by the EEH recovery routines.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:33:42.096436081 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:34:19.926132452 -0600
@@ -77,6 +77,9 @@
  */
 #define EEH_MAX_FAILS	100000
 
+/* Misc forward declaraions */
+static void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn);
+
 /* RTAS tokens */
 static int ibm_set_eeh_option;
 static int ibm_set_slot_reset;
@@ -366,6 +369,7 @@
  */
 void __init pci_addr_cache_build(void)
 {
+	struct device_node *dn;
 	struct pci_dev *dev = NULL;
 
 	if (!eeh_subsystem_enabled)
@@ -379,6 +383,10 @@
 			continue;
 		}
 		pci_addr_cache_insert_device(dev);
+
+		/* Save the BAR's; firmware doesn't restore these after EEH reset */
+		dn = pci_device_to_OF_node(dev);
+		eeh_save_bars(dev, PCI_DN(dn));
 	}
 
 #ifdef DEBUG
@@ -775,6 +783,108 @@
 	}
 }
 
+/* ------------------------------------------------------- */
+/** Save and restore of PCI BARs
+ *
+ * Although firmware will set up BARs during boot, it doesn't
+ * set up device BAR's after a device reset, although it will,
+ * if requested, set up bridge configuration. Thus, we need to
+ * configure the PCI devices ourselves.  
+ */
+
+/**
+ * __restore_bars - Restore the Base Address Registers
+ * Loads the PCI configuration space base address registers,
+ * the expansion ROM base address, the latency timer, and etc.
+ * from the saved values in the device node.
+ */
+static inline void __restore_bars (struct pci_dn *pdn)
+{
+	int i;
+
+	if (NULL==pdn->phb) return;
+	for (i=4; i<10; i++) {
+		rtas_write_config(pdn, i*4, 4, pdn->config_space[i]);
+	}
+
+	/* 12 == Expansion ROM Address */
+	rtas_write_config(pdn, 12*4, 4, pdn->config_space[12]);
+
+#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
+#define SAVED_BYTE(OFF) (((u8 *)(pdn->config_space))[BYTE_SWAP(OFF)])
+
+	rtas_write_config (pdn, PCI_CACHE_LINE_SIZE, 1,
+	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+
+	rtas_write_config (pdn, PCI_LATENCY_TIMER, 1,
+	            SAVED_BYTE(PCI_LATENCY_TIMER));
+
+	/* max latency, min grant, interrupt pin and line */
+	rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
+}
+
+/**
+ * eeh_restore_bars - restore the PCI config space info
+ *
+ * This routine performs a recursive walk to the children
+ * of this device as well.
+ */
+void eeh_restore_bars(struct pci_dn *pdn)
+{
+	struct device_node *dn;
+	if (!pdn) 
+		return;
+	
+	if (! pdn->eeh_is_bridge)
+		__restore_bars (pdn);
+
+	dn = pdn->node->child;
+	while (dn) {
+		eeh_restore_bars (PCI_DN(dn));
+		dn = dn->sibling;
+	}
+}
+
+/**
+ * eeh_save_bars - save device bars
+ *
+ * Save the values of the device bars. Unlike the restore
+ * routine, this routine is *not* recursive. This is because
+ * PCI devices are added individuallly; but, for the restore,
+ * an entire slot is reset at a time.
+ */
+static void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn)
+{
+	int i;
+
+	if (!pdev || !pdn )
+		return;
+	
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(pdev, i * 4, &pdn->config_space[i]);
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		pdn->eeh_is_bridge = 1;
+}
+
+void
+rtas_configure_bridge(struct pci_dn *pdn)
+{
+	int token = rtas_token ("ibm,configure-bridge");
+	int rc;
+
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return;
+	rc = rtas_call(token,3,1, NULL,
+	               pdn->eeh_config_addr,
+	               BUID_HI(pdn->phb->buid),
+	               BUID_LO(pdn->phb->buid));
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to configure device bridge (%d) for %s\n",
+		        rc, pdn->node->full_name);
+	}
+}
+
 /* ------------------------------------------------------------- */
 /* The code below deals with enabling EEH for devices during  the
  * early boot sequence.  EEH must be enabled before any PCI probing
@@ -977,6 +1087,7 @@
 void eeh_add_device_late(struct pci_dev *dev)
 {
 	struct device_node *dn;
+	struct pci_dn *pdn;
 
 	if (!dev || !eeh_subsystem_enabled)
 		return;
@@ -987,9 +1098,11 @@
 
 	pci_dev_get (dev);
 	dn = pci_device_to_OF_node(dev);
-	PCI_DN(dn)->pcidev = dev;
+	pdn = PCI_DN(dn);
+	pdn->pcidev = dev;
 
 	pci_addr_cache_insert_device (dev);
+	eeh_save_bars(dev, pdn);
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_late);
 
Index: linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-powerpc/ppc-pci.h	2005-11-02 14:33:42.083437903 -0600
+++ linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h	2005-11-02 14:34:19.931131751 -0600
@@ -63,6 +63,29 @@
  */
 void rtas_set_slot_reset (struct pci_dn *);
 
+/** 
+ * eeh_restore_bars - Restore device configuration info.
+ *
+ * A reset of a PCI device will clear out its config space.
+ * This routines will restore the config space for this
+ * device, and is children, to values previously obtained
+ * from the firmware.
+ */
+void eeh_restore_bars(struct pci_dn *);
+
+/**
+ * rtas_configure_bridge -- firmware initialization of pci bridge
+ *
+ * Ask the firmware to configure all PCI bridges devices
+ * located behind the indicated node. Required after a
+ * pci device reset. Does essentially the same hing as
+ * eeh_restore_bars, but for brdges, and lets firmware 
+ * do the work.
+ */
+void rtas_configure_bridge(struct pci_dn *);
+
+int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
+
 #endif
 
 #endif /* _ASM_POWERPC_PPC_PCI_H */
