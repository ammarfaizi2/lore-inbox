Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUBWO6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbUBWO6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:58:03 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:44493 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261905AbUBWO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:56:04 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200402231455.i1NEtEqJ041950@fsgi900.americas.sgi.com>
Subject: [2.6 PATCH] Altix hotplug
To: davidm@napali.hpl.hp.com
Date: Mon, 23 Feb 2004 08:55:14 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6 Altix patch for kernel hotplug support

-- 

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054




# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1656  -> 1.1657 
#	include/asm-ia64/sn/pci/pcibr_private.h	1.21    -> 1.22   
#	arch/ia64/sn/kernel/irq.c	1.18    -> 1.19   
#	drivers/pci/hotplug/Kconfig	1.12    -> 1.13   
#	arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	1.18    -> 1.19   
#	arch/ia64/sn/io/machvec/pci_bus_cvlink.c	1.35    -> 1.36   
#	include/asm-ia64/sn/pci/pcibr.h	1.13    -> 1.14   
#	include/asm-ia64/sn/sn_sal.h	1.6     -> 1.7    
#	arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	1.28    -> 1.29   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/19	pfg@sgi.com	1.1657
# arch/ia64/sn/io/machvec/pci_bus_cvlink.c
#     Interface functions for hot plug added:
#         sn_dma_flush_clear - called from sn_pci_unfixup_slot
#         sn_pci_unfixup_slot - called from the sn hotplug driver
# arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
#     Add an ifdef for CONFIG_HOTPLUG_PCI_SGI in a couple of blocks.
#     The use of slot_status is hotplug only
# arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c
#     More hotplug support code : pcibr_slot_enable and pcibr_slot_disable are hotplug
#     driver interfaces, the others are support funcs
#     Made the use of slot_status hotplug only
# arch/ia64/sn/kernel/irq.c
#     Added unregister_pcibr_intr - a hotplug support function
# drivers/pci/hotplug/Kconfig
#     config option to enabel SGI SN2 PCI hotplug
# include/asm-ia64/sn/pci/pcibr.h
#     data structs and definitions needed for hotplug
#     removed some typedefs .....
# include/asm-ia64/sn/pci/pcibr_private.h
#     Added elements needed for hotplug
# include/asm-ia64/sn/sn_sal.h
#     Added sal call needed for hotplug - perform a 'generic' hotplug call
# --------------------------------------------
#
diff -Nru a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Feb 19 17:12:31 2004
+++ b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Feb 19 17:12:31 2004
@@ -384,6 +384,80 @@
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_PCI_SGI
+
+void
+sn_dma_flush_clear(struct sn_flush_device_list *dma_flush_list,
+                   unsigned long start, unsigned long end)
+{
+
+        int i;
+
+        dma_flush_list->pin = -1;
+        dma_flush_list->bus = -1;
+        dma_flush_list->slot = -1;
+
+        for (i = 0; i < PCI_ROM_RESOURCE; i++)
+                if ((dma_flush_list->bar_list[i].start == start) &&
+                    (dma_flush_list->bar_list[i].end == end)) {
+                        dma_flush_list->bar_list[i].start = 0;
+                        dma_flush_list->bar_list[i].end = 0;
+                        break;
+                }           
+
+}
+
+/*
+ * sn_pci_unfixup_slot() - This routine frees a slot's resources
+ * consistent with the Linux PCI abstraction layer.  Resources released
+ * back to our PCI provider include PIO maps to BAR space and interrupt
+ * objects.
+ */
+void
+sn_pci_unfixup_slot(struct pci_dev *dev)
+{
+	struct sn_device_sysdata *device_sysdata;
+	vertex_hdl_t vhdl;
+	pciio_intr_t intr_handle;
+	unsigned int irq;
+	unsigned long size;
+	int idx;
+
+	device_sysdata = SN_DEVICE_SYSDATA(dev);
+
+	vhdl = device_sysdata->vhdl;
+
+	if (device_sysdata->dma_flush_list)
+		for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
+			size = dev->resource[idx].end -
+				dev->resource[idx].start;
+			if (size == 0) continue;
+
+			sn_dma_flush_clear(device_sysdata->dma_flush_list,
+				   	   dev->resource[idx].start,
+				   	   dev->resource[idx].end);
+		}
+
+	intr_handle = device_sysdata->intr_handle;
+	if (intr_handle) {
+		extern void unregister_pcibr_intr(int, pcibr_intr_t);
+		irq = intr_handle->pi_irq;
+		irqpdaindr->device_dev[irq] = NULL;
+		unregister_pcibr_intr(irq, (pcibr_intr_t) intr_handle);
+		pciio_intr_disconnect(intr_handle);
+		pciio_intr_free(intr_handle);
+	}
+
+	for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
+		if (device_sysdata->pio_map[idx]) {
+			pciio_piomap_done (device_sysdata->pio_map[idx]);
+			pciio_piomap_free (device_sysdata->pio_map[idx]);
+		}
+	}
+
+}
+#endif /* CONFIG_HOTPLUG_PCI_SGI */
+
 struct sn_flush_nasid_entry flush_nasid_list[MAX_NASIDS];
 
 /* Initialize the data structures for flushing write buffers after a PIO read.
@@ -534,6 +608,7 @@
 	return p;
 }
 
+
 /*
  * linux_bus_cvlink() Creates a link between the Linux PCI Bus number
  *	to the actual hardware component that it represents:
@@ -774,7 +849,7 @@
 			printk(KERN_WARNING
 				"sn_pci_fixup: sn_pci_fixup_bus fails : error %d\n",
 					ret);
-			return;
+			return 0;
 		}
 	}
 
@@ -805,7 +880,7 @@
 			printk(KERN_WARNING
 				"sn_pci_fixup: sn_pci_fixup_slot fails : error %d\n",
 					ret);
-			return;
+			return 0;
 		}
 	}
 
diff -Nru a/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c b/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
--- a/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Thu Feb 19 17:12:31 2004
+++ b/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Thu Feb 19 17:12:31 2004
@@ -629,6 +629,8 @@
 
     pcibr_soft = pcibr_soft_get(pcibr_vhdl);
     pcibr_info->f_att_det_error = error;
+
+#ifdef CONFIG_HOTPLUG_PCI_SGI
     pcibr_soft->bs_slot[slot].slot_status &= ~SLOT_STATUS_MASK;
 
     if (error) {
@@ -636,6 +638,7 @@
     } else {
         pcibr_soft->bs_slot[slot].slot_status |= SLOT_STARTUP_CMPLT;
     }
+#endif	/* CONFIG_HOTPLUG_PCI_SGI */
 }
 
 /*
@@ -668,6 +671,7 @@
 
     pcibr_soft = pcibr_soft_get(pcibr_vhdl);
     pcibr_info->f_att_det_error = error;
+#ifdef CONFIG_HOTPLUG_PCI_SGI
     pcibr_soft->bs_slot[slot].slot_status &= ~SLOT_STATUS_MASK;
 
     if (error) {
@@ -675,6 +679,7 @@
     } else {
         pcibr_soft->bs_slot[slot].slot_status |= SLOT_SHUTDOWN_CMPLT;
     }
+#endif	/* CONFIG_HOTPLUG_PCI_SGI */
 }
 
 /*
diff -Nru a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c
--- a/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Thu Feb 19 17:12:31 2004
+++ b/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Thu Feb 19 17:12:31 2004
@@ -16,6 +16,7 @@
 #include <asm/sn/pci/pcibr_private.h>
 #include <asm/sn/pci/pci_defs.h>
 #include <asm/sn/sn_private.h>
+#include <asm/sn/sn_sal.h>
 
 extern pcibr_info_t     pcibr_info_get(vertex_hdl_t);
 extern int              pcibr_widget_to_bus(vertex_hdl_t pcibr_vhdl);
@@ -58,6 +59,411 @@
 int max_splittrans_to_numbuf[MAX_SPLIT_TABLE] = {1, 2, 3, 4, 8, 12, 16, 32};
 int max_readcount_to_bufsize[MAX_READCNT_TABLE] = {512, 1024, 2048, 4096 };
 
+#ifdef CONFIG_HOTPLUG_PCI_SGI
+
+/*
+ * PCI slot manipulation errors from the system controller, and their
+ * associated descriptions
+ */
+#define SYSCTL_REQERR_BASE	(-106000)
+#define SYSCTL_PCI_ERROR_BASE	(SYSCTL_REQERR_BASE - 100)
+#define SYSCTL_PCIX_ERROR_BASE	(SYSCTL_REQERR_BASE - 3000)
+
+struct sysctl_pci_error_s {
+
+    int	 	error;
+    char	*msg;
+
+} sysctl_pci_errors[] = {
+
+#define SYSCTL_PCI_UNINITIALIZED	(SYSCTL_PCI_ERROR_BASE - 0)
+    { SYSCTL_PCI_UNINITIALIZED, "module not initialized" },
+
+#define SYSCTL_PCI_UNSUPPORTED_BUS	(SYSCTL_PCI_ERROR_BASE - 1)
+    { SYSCTL_PCI_UNSUPPORTED_BUS, "unsupported bus" },
+
+#define SYSCTL_PCI_UNSUPPORTED_SLOT	(SYSCTL_PCI_ERROR_BASE - 2)
+    { SYSCTL_PCI_UNSUPPORTED_SLOT, "unsupported slot" },
+
+#define SYSCTL_PCI_POWER_NOT_OKAY	(SYSCTL_PCI_ERROR_BASE - 3)
+    { SYSCTL_PCI_POWER_NOT_OKAY, "slot power not okay" },
+
+#define SYSCTL_PCI_CARD_NOT_PRESENT	(SYSCTL_PCI_ERROR_BASE - 4)
+    { SYSCTL_PCI_CARD_NOT_PRESENT, "card not present" },
+
+#define SYSCTL_PCI_POWER_LIMIT		(SYSCTL_PCI_ERROR_BASE - 5)
+    { SYSCTL_PCI_POWER_LIMIT, "power limit reached - some cards not powered up" },
+
+#define SYSCTL_PCI_33MHZ_ON_66MHZ	(SYSCTL_PCI_ERROR_BASE - 6)
+    { SYSCTL_PCI_33MHZ_ON_66MHZ, "cannot add a 33 MHz card to an active 66 MHz bus" },
+
+#define SYSCTL_PCI_INVALID_ORDER	(SYSCTL_PCI_ERROR_BASE - 7)
+    { SYSCTL_PCI_INVALID_ORDER, "invalid reset order" },
+
+#define SYSCTL_PCI_DOWN_33MHZ		(SYSCTL_PCI_ERROR_BASE - 8)
+    { SYSCTL_PCI_DOWN_33MHZ, "cannot power down a 33 MHz card on an active bus" },
+
+#define SYSCTL_PCI_RESET_33MHZ		(SYSCTL_PCI_ERROR_BASE - 9)
+    { SYSCTL_PCI_RESET_33MHZ, "cannot reset a 33 MHz card on an active bus" },
+
+#define SYSCTL_PCI_SLOT_NOT_UP		(SYSCTL_PCI_ERROR_BASE - 10)
+    { SYSCTL_PCI_SLOT_NOT_UP, "cannot reset a slot that is not powered up" },
+
+#define SYSCTL_PCIX_UNINITIALIZED	(SYSCTL_PCIX_ERROR_BASE - 0)
+    { SYSCTL_PCIX_UNINITIALIZED, "module not initialized" },
+
+#define SYSCTL_PCIX_UNSUPPORTED_BUS	(SYSCTL_PCIX_ERROR_BASE - 1)
+    { SYSCTL_PCIX_UNSUPPORTED_BUS, "unsupported bus" },
+
+#define SYSCTL_PCIX_UNSUPPORTED_SLOT	(SYSCTL_PCIX_ERROR_BASE - 2)
+    { SYSCTL_PCIX_UNSUPPORTED_SLOT, "unsupported slot" },
+
+#define SYSCTL_PCIX_POWER_NOT_OKAY	(SYSCTL_PCIX_ERROR_BASE - 3)
+    { SYSCTL_PCIX_POWER_NOT_OKAY, "slot power not okay" },
+
+#define SYSCTL_PCIX_CARD_NOT_PRESENT	(SYSCTL_PCIX_ERROR_BASE - 4)
+    { SYSCTL_PCIX_CARD_NOT_PRESENT, "card not present" },
+
+#define SYSCTL_PCIX_POWER_LIMIT		(SYSCTL_PCIX_ERROR_BASE - 5)
+    { SYSCTL_PCIX_POWER_LIMIT, "power limit reached - some cards not powered up" },
+
+#define SYSCTL_PCIX_33MHZ_ON_66MHZ	(SYSCTL_PCIX_ERROR_BASE - 6)
+    { SYSCTL_PCIX_33MHZ_ON_66MHZ, "cannot add a 33 MHz card to an active 66 MHz bus" },
+
+#define SYSCTL_PCIX_PCI_ON_PCIX		(SYSCTL_PCIX_ERROR_BASE - 7)
+    { SYSCTL_PCIX_PCI_ON_PCIX, "cannot add a PCI card to an active PCIX bus" },
+
+#define SYSCTL_PCIX_ANYTHING_ON_133MHZ		(SYSCTL_PCIX_ERROR_BASE - 8)
+    { SYSCTL_PCIX_ANYTHING_ON_133MHZ, "cannot add any card to an active 133MHz PCIX bus" },
+
+#define SYSCTL_PCIX_X66MHZ_ON_X100MHZ		(SYSCTL_PCIX_ERROR_BASE - 9)
+    { SYSCTL_PCIX_X66MHZ_ON_X100MHZ, "cannot add a PCIX 66MHz card to an active 100MHz PCIX bus" },
+
+#define SYSCTL_PCIX_INVALID_ORDER	(SYSCTL_PCIX_ERROR_BASE - 10)
+    { SYSCTL_PCIX_INVALID_ORDER, "invalid reset order" },
+
+#define SYSCTL_PCIX_DOWN_33MHZ		(SYSCTL_PCIX_ERROR_BASE - 11)
+    { SYSCTL_PCIX_DOWN_33MHZ, "cannot power down a 33 MHz card on an active bus" },
+
+#define SYSCTL_PCIX_RESET_33MHZ		(SYSCTL_PCIX_ERROR_BASE - 12)
+    { SYSCTL_PCIX_RESET_33MHZ, "cannot reset a 33 MHz card on an active bus" },
+
+#define SYSCTL_PCIX_SLOT_NOT_UP		(SYSCTL_PCIX_ERROR_BASE - 13)
+    { SYSCTL_PCIX_SLOT_NOT_UP, "cannot reset a slot that is not powered up" },
+
+#define SYSCTL_PCIX_INVALID_BUS_SETTING	(SYSCTL_PCIX_ERROR_BASE - 14)
+    { SYSCTL_PCIX_INVALID_BUS_SETTING, "invalid bus type/speed selection (PCIX<66MHz, PCI>66MHz)" },
+
+#define SYSCTL_PCIX_INVALID_DEPENDENT_SLOT (SYSCTL_PCIX_ERROR_BASE - 15)
+    { SYSCTL_PCIX_INVALID_DEPENDENT_SLOT, "invalid dependent slot in PCI slot configuration" },
+
+#define SYSCTL_PCIX_SHARED_IDSELECT	(SYSCTL_PCIX_ERROR_BASE - 16)
+    { SYSCTL_PCIX_SHARED_IDSELECT, "cannot enable two slots sharing the same IDSELECT" },
+
+#define SYSCTL_PCIX_SLOT_DISABLED	(SYSCTL_PCIX_ERROR_BASE - 17)
+    { SYSCTL_PCIX_SLOT_DISABLED, "slot is disabled" },
+
+}; /* end sysctl_pci_errors[] */
+
+/*
+ * look up an error message for PCI operations that fail
+ */
+static void
+sysctl_pci_error_lookup(int error, char *err_msg)
+{
+    int i;
+    struct sysctl_pci_error_s *e = sysctl_pci_errors;
+    
+    for (i = 0; 
+	 i < (sizeof(sysctl_pci_errors) / sizeof(*e));
+	 i++, e++ )
+    {
+	if (e->error == error)
+	{
+	    strcpy(err_msg, e->msg);
+	    return;
+	}
+    }
+
+    sprintf(err_msg, "unrecognized PCI error type");
+}
+
+/*
+ * pcibr_slot_attach
+ *	This is a place holder routine to keep track of all the
+ *	slot-specific initialization that needs to be done.
+ *	This is usually called when we want to initialize a new
+ * 	PCI card on the bus.
+ */
+int
+pcibr_slot_attach(vertex_hdl_t pcibr_vhdl,
+		  pciio_slot_t slot,
+		  int          drv_flags,
+		  char        *l1_msg,
+                  int         *sub_errorp)
+{
+    pcibr_soft_t  pcibr_soft = pcibr_soft_get(pcibr_vhdl);
+    int		  error;
+
+    if (!(pcibr_soft->bs_slot[slot].slot_status & PCI_SLOT_POWER_ON)) {
+	uint64_t speed;
+	uint64_t mode;
+
+        /* Power-up the slot */
+        error = pcibr_slot_pwr(pcibr_vhdl, slot, PCI_REQ_SLOT_POWER_ON, l1_msg);
+
+        if (error) {
+            if (sub_errorp)
+                *sub_errorp = error;
+            return(PCI_L1_ERR);
+        } else {
+            pcibr_soft->bs_slot[slot].slot_status &= ~PCI_SLOT_POWER_MASK;
+            pcibr_soft->bs_slot[slot].slot_status |= PCI_SLOT_POWER_ON;
+        }
+
+	/* The speed/mode of the bus may have changed due to the hotplug */
+	speed = pcireg_speed_get(pcibr_soft);
+	mode = pcireg_mode_get(pcibr_soft);
+	pcibr_soft->bs_bridge_mode = ((speed << 1) | mode);
+
+        /*
+         * Allow cards like the Alteon Gigabit Ethernet Adapter to complete
+         * on-card initialization following the slot reset
+         */
+        set_current_state (TASK_INTERRUPTIBLE);
+        schedule_timeout (HZ);
+
+        /* Find out what is out there */
+        error = pcibr_slot_info_init(pcibr_vhdl, slot);
+
+        if (error) {
+            if (sub_errorp)
+                *sub_errorp = error;
+            return(PCI_SLOT_INFO_INIT_ERR);
+        }
+
+        /* Set up the address space for this slot in the PCI land */
+
+        error = pcibr_slot_addr_space_init(pcibr_vhdl, slot);
+
+        if (error) {
+            if (sub_errorp)
+                *sub_errorp = error;
+            return(PCI_SLOT_ADDR_INIT_ERR);
+        }
+
+	/* Allocate the PCI-X Read Buffer Attribute Registers (RBARs)*/
+	if (IS_PCIX(pcibr_soft)) {
+	    int tmp_slot;
+
+	    /* Recalculate the RBARs for all the devices on the bus.  Only
+	     * return an error if we error for the given 'slot'
+	     */
+	    pcibr_soft->bs_pcix_rbar_inuse = 0;
+	    pcibr_soft->bs_pcix_rbar_avail = NUM_RBAR;
+	    pcibr_soft->bs_pcix_rbar_percent_allowed = 
+					pcibr_pcix_rbars_calc(pcibr_soft);
+	    for (tmp_slot = pcibr_soft->bs_min_slot;
+			tmp_slot < PCIBR_NUM_SLOTS(pcibr_soft); ++tmp_slot) {
+		if (tmp_slot == slot)
+		    continue;	/* skip this 'slot', we do it below */
+                (void)pcibr_slot_pcix_rbar_init(pcibr_soft, tmp_slot);
+	    }
+
+	    error = pcibr_slot_pcix_rbar_init(pcibr_soft, slot);
+	    if (error) {
+		if (sub_errorp)
+		    *sub_errorp = error;
+		return(PCI_SLOT_RBAR_ALLOC_ERR);
+	    }
+	}
+
+        /* Setup the device register */
+        error = pcibr_slot_device_init(pcibr_vhdl, slot);
+
+        if (error) {
+            if (sub_errorp)
+                *sub_errorp = error;
+            return(PCI_SLOT_DEV_INIT_ERR);
+        }
+
+        /* Setup host/guest relations */
+        error = pcibr_slot_guest_info_init(pcibr_vhdl, slot);
+
+        if (error) {
+            if (sub_errorp)
+                *sub_errorp = error;
+            return(PCI_SLOT_GUEST_INIT_ERR);
+        }
+
+        /* Initial RRB management */
+        error = pcibr_slot_initial_rrb_alloc(pcibr_vhdl, slot);
+
+        if (error) {
+            if (sub_errorp)
+                *sub_errorp = error;
+            return(PCI_SLOT_RRB_ALLOC_ERR);
+        }
+
+    }
+
+    /* Call the device attach */
+    error = pcibr_slot_call_device_attach(pcibr_vhdl, slot, drv_flags);
+
+    if (error) {
+        if (sub_errorp)
+            *sub_errorp = error;
+        if (error == EUNATCH)
+            return(PCI_NO_DRIVER);
+        else
+            return(PCI_SLOT_DRV_ATTACH_ERR);
+    }
+
+    return(0);
+}
+
+/*
+ * pcibr_slot_enable
+ *	Enable the PCI slot for a hot-plug insert.
+ */
+int
+pcibr_slot_enable(vertex_hdl_t pcibr_vhdl, struct pcibr_slot_enable_req_s *req_p)
+{
+    pcibr_soft_t                   pcibr_soft = pcibr_soft_get(pcibr_vhdl);
+    pciio_slot_t                   slot = req_p->req_device;
+    int                            error = 0;
+
+    /* Make sure that we are dealing with a bridge device vertex */
+    if (!pcibr_soft) {
+        return(PCI_NOT_A_BRIDGE);
+    }
+
+    PCIBR_DEBUG_ALWAYS((PCIBR_DEBUG_HOTPLUG, pcibr_vhdl,
+                "pcibr_slot_enable: pcibr_soft=0x%lx, slot=%d, req_p=0x%lx\n",
+                pcibr_soft, slot, req_p));
+
+    /* Check for the valid slot */
+    if (!PCIBR_VALID_SLOT(pcibr_soft, slot))
+        return(PCI_NOT_A_SLOT);
+
+    if (pcibr_soft->bs_slot[slot].slot_status & PCI_SLOT_ENABLE_CMPLT) {
+        error = PCI_SLOT_ALREADY_UP;
+        goto enable_unlock;
+    }
+
+    error = pcibr_slot_attach(pcibr_vhdl, slot, NULL,
+                              req_p->req_resp.resp_l1_msg,
+			      &req_p->req_resp.resp_sub_errno);
+
+    req_p->req_resp.resp_l1_msg[PCI_L1_QSIZE] = '\0';
+
+    enable_unlock:
+
+    return(error);
+}
+
+/*
+ * pcibr_slot_disable
+ *	Disable the PCI slot for a hot-plug removal.
+ */
+int
+pcibr_slot_disable(vertex_hdl_t pcibr_vhdl, struct pcibr_slot_disable_req_s *req_p)
+{
+    pcibr_soft_t                   pcibr_soft = pcibr_soft_get(pcibr_vhdl);
+    pciio_slot_t                   slot = req_p->req_device;
+    int                            error = 0;
+    pciio_slot_t                   tmp_slot;
+
+    /* Make sure that we are dealing with a bridge device vertex */
+    if (!pcibr_soft) {
+        return(PCI_NOT_A_BRIDGE);
+    }
+
+    PCIBR_DEBUG_ALWAYS((PCIBR_DEBUG_HOTPLUG, pcibr_vhdl,
+                "pcibr_slot_disable: pcibr_soft=0x%lx, slot=%d, req_p=0x%lx\n",
+                pcibr_soft, slot, req_p));
+
+    /* Check for valid slot */
+    if (!PCIBR_VALID_SLOT(pcibr_soft, slot))
+        return(PCI_NOT_A_SLOT);
+
+    if ((pcibr_soft->bs_slot[slot].slot_status & PCI_SLOT_DISABLE_CMPLT) ||
+       ((pcibr_soft->bs_slot[slot].slot_status & PCI_SLOT_STATUS_MASK) == 0)) {
+        error = PCI_SLOT_ALREADY_DOWN;
+        /*
+         * RJR - Should we invoke an L1 slot power-down command just in case
+         *       a previous shut-down failed to power-down the slot?
+         */
+        goto disable_unlock;
+    }
+
+    /* Do not allow the last 33 MHz card to be removed */
+    if (IS_33MHZ(pcibr_soft)) {
+        for (tmp_slot = pcibr_soft->bs_first_slot;
+             tmp_slot <= pcibr_soft->bs_last_slot; tmp_slot++)
+            if (tmp_slot != slot)
+                if (pcibr_soft->bs_slot[tmp_slot].slot_status & PCI_SLOT_POWER_ON) {
+                    error++;
+                    break;
+                }
+        if (!error) {
+            error = PCI_EMPTY_33MHZ;
+            goto disable_unlock;
+        }
+    }
+
+    if (req_p->req_action == PCI_REQ_SLOT_ELIGIBLE)
+	return(0);
+
+    error = pcibr_slot_detach(pcibr_vhdl, slot, 1,
+                              req_p->req_resp.resp_l1_msg,
+			      &req_p->req_resp.resp_sub_errno);
+
+    req_p->req_resp.resp_l1_msg[PCI_L1_QSIZE] = '\0';
+
+    disable_unlock:
+
+    return(error);
+}
+
+/*
+ * pcibr_slot_pwr
+ *      Power-up or power-down a PCI slot.  This routines makes calls to
+ *      the L1 system controller driver which requires "external" slot#.
+ */
+int
+pcibr_slot_pwr(vertex_hdl_t pcibr_vhdl,
+               pciio_slot_t slot,
+               int          up,
+	       char        *err_msg)
+{
+    pcibr_soft_t        pcibr_soft = pcibr_soft_get(pcibr_vhdl);
+    nasid_t             nasid;
+    u64			connection_type;
+    int			rv;
+
+    nasid = NASID_GET(pcibr_soft->bs_base);
+    connection_type = SAL_SYSCTL_IO_XTALK;
+
+    rv = (int) ia64_sn_sysctl_iobrick_pci_op
+	(nasid,
+	 connection_type,
+	 (u64) pcibr_widget_to_bus(pcibr_vhdl),
+	 PCIBR_DEVICE_TO_SLOT(pcibr_soft, slot),
+	 (up ? SAL_SYSCTL_PCI_POWER_UP : SAL_SYSCTL_PCI_POWER_DOWN));
+
+    if (!rv) {
+	/* everything's okay; no error message */
+	*err_msg = '\0';
+    }
+    else {
+	/* there was a problem; look up an appropriate error message */
+	sysctl_pci_error_lookup(rv, err_msg);
+    }
+    return rv;
+}
+
+#endif /* CONFIG_HOTPLUG_PCI_SGI */
 
 /*
  * pcibr_slot_info_init
@@ -114,7 +520,9 @@
 	return -ENODEV;
 
     slotp = &pcibr_soft->bs_slot[slot];
+#ifdef CONFIG_HOTPLUG_PCI_SGI
     slotp->slot_status |= SLOT_POWER_UP;
+#endif
 
     vendor = 0xFFFF & idword;
     device = 0xFFFF & (idword >> 16);
@@ -1019,6 +1427,7 @@
 
     }				/* next func */
 
+#ifdef CONFIG_HOTPLUG_PCI_SGI
     if (error) {
 	if ((error != ENODEV) && (error != EUNATCH) && (error != EPERM)) {
 	    pcibr_soft->bs_slot[slot].slot_status &= ~SLOT_STATUS_MASK;
@@ -1028,7 +1437,7 @@
         pcibr_soft->bs_slot[slot].slot_status &= ~SLOT_STATUS_MASK;
         pcibr_soft->bs_slot[slot].slot_status |= SLOT_STARTUP_CMPLT;
     }
-        
+#endif	/* CONFIG_HOTPLUG_PCI_SGI */
     return error;
 }
 
@@ -1103,7 +1512,7 @@
 
     }				/* next func */
 
-
+#ifdef CONFIG_HOTPLUG_PCI_SGI
     if (error) {
 	if ((error != ENODEV) && (error != EUNATCH) && (error != EPERM)) {
 	    pcibr_soft->bs_slot[slot].slot_status &= ~SLOT_STATUS_MASK;
@@ -1115,9 +1524,11 @@
         pcibr_soft->bs_slot[slot].slot_status &= ~SLOT_STATUS_MASK;
         pcibr_soft->bs_slot[slot].slot_status |= SLOT_SHUTDOWN_CMPLT;
     }
-        
+#endif	/* CONFIG_HOTPLUG_PCI_SGI */
     return error;
 }
+
+
 
 /*
  * pcibr_slot_detach
diff -Nru a/arch/ia64/sn/kernel/irq.c b/arch/ia64/sn/kernel/irq.c
--- a/arch/ia64/sn/kernel/irq.c	Thu Feb 19 17:12:31 2004
+++ b/arch/ia64/sn/kernel/irq.c	Thu Feb 19 17:12:31 2004
@@ -212,6 +212,49 @@
 }
 
 void
+unregister_pcibr_intr(int irq, pcibr_intr_t intr)
+{
+
+	struct sn_intr_list_t **prev, *curr;
+	int cpu = intr->bi_cpu;
+	int i;
+
+	if (sn_intr_list[irq] == NULL)
+		return;
+
+	prev = &sn_intr_list[irq];
+	curr = sn_intr_list[irq];
+	while (curr) {
+		if (curr->intr == intr)	 {
+			*prev = curr->next;
+			break;
+		}
+		prev = &curr->next;
+		curr = curr->next;
+	}
+
+	if (curr)
+		kfree(curr);
+
+	if (!sn_intr_list[irq]) {
+		if (pdacpu(cpu)->sn_last_irq == irq) {
+			for (i = pdacpu(cpu)->sn_last_irq - 1; i; i--)
+				if (sn_intr_list[i])
+					break;
+			pdacpu(cpu)->sn_last_irq = i;
+		}
+
+		if (pdacpu(cpu)->sn_first_irq == irq) {
+			pdacpu(cpu)->sn_first_irq = 0;
+			for (i = pdacpu(cpu)->sn_first_irq + 1; i < NR_IRQS; i++)
+				if (sn_intr_list[i])
+					pdacpu(cpu)->sn_first_irq = i;
+		}
+	}
+
+}
+
+void
 force_polled_int(void)
 {
 	int i;
diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	Thu Feb 19 17:12:31 2004
+++ b/drivers/pci/hotplug/Kconfig	Thu Feb 19 17:12:31 2004
@@ -122,5 +122,13 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_SGI
+	tristate "SGI PCI Hotplug Support"
+	depends on HOTPLUG_PCI && IA64_SGI_SN2
+	help
+	  Say Y here if you have an SGI IA64 Altix system.
+
+	  When in doubt, say N.
+
 endmenu
 
diff -Nru a/include/asm-ia64/sn/pci/pcibr.h b/include/asm-ia64/sn/pci/pcibr.h
--- a/include/asm-ia64/sn/pci/pcibr.h	Thu Feb 19 17:12:31 2004
+++ b/include/asm-ia64/sn/pci/pcibr.h	Thu Feb 19 17:12:31 2004
@@ -325,9 +325,27 @@
 #define PCIBR			'p'
 #define _PCIBR(x)		((PCIBR << 8) | (x))
 
-#define PCIBR_SLOT_STARTUP	_PCIBR(1)
-#define PCIBR_SLOT_SHUTDOWN     _PCIBR(2)
-#define PCIBR_SLOT_QUERY	_PCIBR(3)
+/*
+ * Bit defintions for variable slot_status in struct
+ * pcibr_soft_slot_s.  They are here so that the user
+ * hot-plug utility can interpret the slot's power
+ * status.
+ */
+#ifdef CONFIG_HOTPLUG_PCI_SGI
+#define PCI_SLOT_ENABLE_CMPLT       0x01    
+#define PCI_SLOT_ENABLE_INCMPLT     0x02    
+#define PCI_SLOT_DISABLE_CMPLT      0x04    
+#define PCI_SLOT_DISABLE_INCMPLT    0x08    
+#define PCI_SLOT_POWER_ON           0x10    
+#define PCI_SLOT_POWER_OFF          0x20    
+#define PCI_SLOT_IS_SYS_CRITICAL    0x40    
+#define PCI_SLOT_PCIBA_LOADED       0x80    
+
+#define PCI_SLOT_STATUS_MASK        (PCI_SLOT_ENABLE_CMPLT | \
+				     PCI_SLOT_ENABLE_INCMPLT | \
+                                     PCI_SLOT_DISABLE_CMPLT | \
+				     PCI_SLOT_DISABLE_INCMPLT)
+#define PCI_SLOT_POWER_MASK         (PCI_SLOT_POWER_ON | PCI_SLOT_POWER_OFF)
 
 /*
  * Bit defintions for variable slot_status in struct
@@ -356,26 +374,20 @@
 #define FUNC_IS_SYS_CRITICAL    0x02
 
 /*
- * Structures for requesting PCI bridge information and receiving a response
+ * L1 slot power operations for PCI hot-plug
  */
-typedef struct pcibr_slot_req_s *pcibr_slot_req_t;
-typedef struct pcibr_slot_up_resp_s *pcibr_slot_up_resp_t;
-typedef struct pcibr_slot_down_resp_s *pcibr_slot_down_resp_t;
-typedef struct pcibr_slot_info_resp_s *pcibr_slot_info_resp_t;
-typedef struct pcibr_slot_func_info_resp_s *pcibr_slot_func_info_resp_t;
+#define PCI_REQ_SLOT_POWER_ON       1
+#define PCI_L1_QSIZE                128      /* our L1 message buffer size */
+
 
 #define L1_QSIZE                128      /* our L1 message buffer size */
-struct pcibr_slot_req_s {
-    int                      req_slot;
-    union {
-        pcibr_slot_up_resp_t     up;
-        pcibr_slot_down_resp_t   down;
-        pcibr_slot_info_resp_t   query;
-        void                    *any;
-    }                       req_respp;
-    int                     req_size;
+
+enum pcibr_slot_disable_action_e {
+    PCI_REQ_SLOT_ELIGIBLE,
+    PCI_REQ_SLOT_DISABLE
 };
 
+
 struct pcibr_slot_up_resp_s {
     int                     resp_sub_errno;
     char                    resp_l1_msg[L1_QSIZE + 1];
@@ -443,6 +455,45 @@
 
     } resp_func[8];
 };
+
+struct pcibr_slot_req_s {
+    int                      req_slot;
+    union {
+        enum pcibr_slot_disable_action_e up;
+        struct pcibr_slot_down_resp_s *down;
+        struct pcibr_slot_info_resp_s *query;
+        void                    *any;
+    }                       req_respp;
+    int                     req_size;
+};
+
+struct pcibr_slot_enable_resp_s {
+    int                     resp_sub_errno;
+    char                    resp_l1_msg[PCI_L1_QSIZE + 1];
+};
+
+struct pcibr_slot_disable_resp_s {
+    int                     resp_sub_errno;
+    char                    resp_l1_msg[PCI_L1_QSIZE + 1];
+};
+
+struct pcibr_slot_enable_req_s {
+    pciio_slot_t              	     req_device;
+    struct pcibr_slot_enable_resp_s  req_resp;
+};
+
+struct pcibr_slot_disable_req_s {
+    pciio_slot_t                     req_device;
+    enum pcibr_slot_disable_action_e req_action;
+    struct pcibr_slot_disable_resp_s req_resp;
+};
+
+struct pcibr_slot_info_req_s {
+    pciio_slot_t              	     req_device;
+    struct pcibr_slot_info_resp_s    req_resp;
+};
+
+#endif	/* CONFIG_HOTPLUG_PCI_SGI */
 
 
 /*
diff -Nru a/include/asm-ia64/sn/pci/pcibr_private.h b/include/asm-ia64/sn/pci/pcibr_private.h
--- a/include/asm-ia64/sn/pci/pcibr_private.h	Thu Feb 19 17:12:31 2004
+++ b/include/asm-ia64/sn/pci/pcibr_private.h	Thu Feb 19 17:12:31 2004
@@ -475,6 +475,12 @@
     
     vertex_hdl_t	    bs_noslot_conn;	/* NO-SLOT connection point */
     pcibr_info_t	    bs_noslot_info;
+
+#ifdef CONFIG_HOTPLUG_PCI_SGI
+    /* Linux PCI bus structure pointer */
+    struct pci_bus         *bs_pci_bus;
+#endif
+
     struct pcibr_soft_slot_s {
 	/* information we keep about each CFG slot */
 
@@ -492,8 +498,13 @@
 	pciio_slot_t            host_slot;
 	vertex_hdl_t		slot_conn;
 
+#ifdef CONFIG_HOTPLUG_PCI_SGI
         /* PCI Hot-Plug status word */
         int 			slot_status;
+
+	/* PCI Hot-Plug core structure pointer */
+	struct hotplug_slot    *bss_hotplug_slot;
+#endif	/* CONFIG_HOTPLUG_PCI_SGI */
 
 	/* Potentially several connection points
 	 * for this slot. bss_ninfo is how many,
diff -Nru a/include/asm-ia64/sn/sn_sal.h b/include/asm-ia64/sn/sn_sal.h
--- a/include/asm-ia64/sn/sn_sal.h	Thu Feb 19 17:12:31 2004
+++ b/include/asm-ia64/sn/sn_sal.h	Thu Feb 19 17:12:31 2004
@@ -58,6 +58,7 @@
 #define  SN_SAL_MEMPROTECT                         0x0200003e
 #define  SN_SAL_SYSCTL_FRU_CAPTURE		   0x0200003f
 
+#define  SN_SAL_SYSCTL_IOBRICK_PCI_OP		   0x02000042	// reentrant
 
 /*
  * Service-specific constants
@@ -72,6 +73,16 @@
 #define SAL_CONSOLE_INTR_XMIT	1	/* output interrupt */
 #define SAL_CONSOLE_INTR_RECV	2	/* input interrupt */
 
+#ifdef CONFIG_HOTPLUG_PCI_SGI
+/* power up / power down / reset a PCI slot or bus */
+#define SAL_SYSCTL_PCI_POWER_UP         0
+#define SAL_SYSCTL_PCI_POWER_DOWN       1
+#define SAL_SYSCTL_PCI_RESET            2
+
+/* what type of I/O brick? */
+#define SAL_SYSCTL_IO_XTALK	0       /* connected via a compute node */
+
+#endif	/* CONFIG_HOTPLUG_PCI_SGI */
 
 /*
  * SN_SAL_GET_PARTITION_ADDR return constants
@@ -639,6 +650,24 @@
         if (isrv.status)
                 return 0;
         return isrv.v0;
+}
+
+/*
+ * Performs an operation on a PCI bus or slot -- power up, power down
+ * or reset.
+ */
+static inline u64
+ia64_sn_sysctl_iobrick_pci_op(nasid_t n, u64 connection_type, 
+			      u64 bus, slotid_t slot, 
+			      u64 action)
+{
+	struct ia64_sal_retval rv = {0, 0, 0, 0};
+
+	SAL_CALL_NOLOCK(rv, SN_SAL_SYSCTL_IOBRICK_PCI_OP, connection_type, n, action,
+		 bus, (u64) slot, 0, 0);
+	if (rv.status)
+	    	return rv.v0;
+	return 0;
 }
 
 #endif /* _ASM_IA64_SN_SN_SAL_H */
