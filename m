Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUDOR1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbUDOR1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:27:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:17070 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263142AbUDORYG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:06 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10820498243742@kroah.com>
Date: Thu, 15 Apr 2004 10:23:45 -0700
Message-Id: <10820498253445@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.3, 2004/03/26 16:31:44-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI: Updates for PCI Express hot-plug driver


 drivers/pci/hotplug/pciehp_hpc.c      |   91 +++++++++++++++++++++++++++-------
 drivers/pci/hotplug/pciehp_pci.c      |    2 
 drivers/pci/hotplug/shpchp_hpc.c      |   11 +---
 drivers/pci/hotplug/shpchprm_acpi.c   |    3 -
 drivers/pci/hotplug/shpchprm_legacy.c |   30 -----------
 drivers/pci/pci.h                     |    2 
 drivers/pci/quirks.c                  |   11 ++++
 include/linux/pci_ids.h               |    1 
 8 files changed, 95 insertions(+), 56 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	Thu Apr 15 10:06:13 2004
+++ b/drivers/pci/hotplug/pciehp_hpc.c	Thu Apr 15 10:06:13 2004
@@ -37,6 +37,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <asm/system.h>
+#include "../pci.h"
 #include "pciehp.h"
 
 #ifdef DEBUG
@@ -315,12 +316,13 @@
 		dbg("%s : CMD_COMPLETED not clear after 1 sec.\n", __FUNCTION__);
 	}
 
-	retval = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL, cmd);
+	dbg("%s: Before hp_register_write_word SLOT_CTRL %x\n", __FUNCTION__, cmd);
+	retval = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL, cmd | CMD_CMPL_INTR_ENABLE);
 	if (retval) {
 		err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
 		return retval;
 	}
-	dbg("%s : hp_register_write_word SLOT_CTRL %x\n", __FUNCTION__, cmd);
+	dbg("%s : hp_register_write_word SLOT_CTRL %x\n", __FUNCTION__, cmd | CMD_CMPL_INTR_ENABLE);
 	dbg("%s : Exit\n", __FUNCTION__);
 
 	DBG_LEAVE_ROUTINE 
@@ -918,13 +920,32 @@
 			return IRQ_NONE;;
 		}
 
-		temp_word = (temp_word & ~HP_INTR_ENABLE) | 0x00;
+		dbg("%s: Set Mask Hot-plug Interrupt Enable\n", __FUNCTION__);
+		dbg("%s: hp_register_read_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word);
+		temp_word = (temp_word & ~HP_INTR_ENABLE & ~CMD_CMPL_INTR_ENABLE) | 0x00;
 
 		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL, temp_word);
 		if (rc) {
 			err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
-			return IRQ_NONE;;
+			return IRQ_NONE;
+		}
+		dbg("%s: hp_register_write_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word);
+		
+		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+		if (rc) {
+			err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
+			return IRQ_NONE;
+		}
+		dbg("%s: hp_register_read_word SLOT_STATUS with value %x\n", __FUNCTION__, slot_status); 
+		
+		/* Clear command complete interrupt caused by this write */
+		temp_word = 0x1f;
+		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+		if (rc) {
+			err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
+			return IRQ_NONE;
 		}
+		dbg("%s: hp_register_write_word SLOT_STATUS with value %x\n", __FUNCTION__, temp_word);
 	}
 	
 	if (intr_loc & CMD_COMPLETED) {
@@ -949,7 +970,7 @@
 			hp_slot, php_ctlr->callback_instance_id);
 
 	/* Clear all events after serving them */
-	temp_word = slot_status | 0xff;
+	temp_word = 0x1F;
 	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
@@ -963,6 +984,8 @@
 			return IRQ_NONE;
 		}
 
+		dbg("%s: Unmask Hot-plug Interrupt Enable\n", __FUNCTION__);
+		dbg("%s: hp_register_read_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word);
 		temp_word = (temp_word & ~HP_INTR_ENABLE) | HP_INTR_ENABLE;
 
 		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_CTRL, temp_word);
@@ -970,6 +993,23 @@
 			err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
 			return IRQ_NONE;
 		}
+		dbg("%s: hp_register_write_word SLOT_CTRL with value %x\n", __FUNCTION__, temp_word); 	
+	
+		rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+		if (rc) {
+			err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
+			return IRQ_NONE;
+		}
+		dbg("%s: hp_register_read_word SLOT_STATUS with value %x\n", __FUNCTION__, slot_status); 
+		
+		/* Clear command complete interrupt caused by this write */
+		temp_word = 0x1F;
+		rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+		if (rc) {
+			err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
+			return IRQ_NONE;
+		}
+		dbg("%s: hp_register_write_word SLOT_STATUS with value %x\n", __FUNCTION__, temp_word); 
 	}
 	
 	return IRQ_HANDLED;
@@ -1330,7 +1370,7 @@
 	}
 
 	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL, temp_word);
-	temp_word = (temp_word & ~HP_INTR_ENABLE) | 0x00;
+	temp_word = (temp_word & ~HP_INTR_ENABLE & ~CMD_CMPL_INTR_ENABLE) | 0x00;
 
 	rc = hp_register_write_word(pdev, SLOT_CTRL, temp_word);
 	if (rc) {
@@ -1346,12 +1386,13 @@
 	}
 	dbg("%s: Mask HPIE SLOT_STATUS offset %x reads slot_status %x\n", __FUNCTION__, SLOT_STATUS, slot_status);
 
-	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	temp_word = 0x1F; /* Clear all events */
+	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
 		goto abort_free_ctlr;
 	}
-	dbg("%s: SLOT_STATUS offset %x writes slot_status %x\n", __FUNCTION__, SLOT_STATUS, slot_status);
+	dbg("%s: SLOT_STATUS offset %x writes slot_status %x\n", __FUNCTION__, SLOT_STATUS, temp_word);
 
 	if (pciehp_poll_mode)  {/* Install interrupt polling code */
 		/* Install and start the interrupt polling timer */
@@ -1359,15 +1400,16 @@
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-#ifdef CONFIG_PCI_USE_VECTOR 
-		rc = pci_enable_msi(pdev);
-		if (rc) {
-			err("Can't get msi for the hotplug controller\n");
-			dbg("%s: rc = %x\n", __FUNCTION__, rc);
-			goto abort_free_ctlr;
+		dbg("%s: pciehp_msi_quirk = %x\n", __FUNCTION__, pciehp_msi_quirk);
+		if (!pciehp_msi_quirk) {
+			rc = pci_enable_msi(pdev);
+			if (rc) {
+				info("Can't get msi for the hotplug controller\n");
+				info("Use INTx for the hotplug controller\n");
+				dbg("%s: rc = %x\n", __FUNCTION__, rc);
+			} else 
+				php_ctlr->irq = pdev->irq;
 		}
-		php_ctlr->irq = pdev->irq;
-#endif		
 		rc = request_irq(php_ctlr->irq, pcie_isr, SA_SHIRQ, MY_NAME, (void *) ctrl);
 		dbg("%s: request_irq %d for hpc%d (returns %d)\n", __FUNCTION__, php_ctlr->irq, ctlr_seq_num, rc);
 		if (rc) {
@@ -1384,7 +1426,7 @@
 	dbg("%s: SLOT_CTRL %x value read %x\n", __FUNCTION__, SLOT_CTRL, temp_word);
 
 	intr_enable = ATTN_BUTTN_ENABLE | PWR_FAULT_DETECT_ENABLE | MRL_DETECT_ENABLE |
-					PRSN_DETECT_ENABLE | CMD_CMPL_INTR_ENABLE;
+					PRSN_DETECT_ENABLE;
 
 	temp_word = (temp_word & ~intr_enable) | intr_enable; 
 
@@ -1402,6 +1444,21 @@
 		goto abort_free_ctlr;
 	}
 	dbg("%s : Unmask HPIE hp_register_write_word SLOT_CTRL with %x\n", __FUNCTION__, temp_word);
+	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS, slot_status);
+	if (rc) {
+		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
+		goto abort_free_ctlr;
+	}
+	dbg("%s: Unmask HPIE SLOT_STATUS offset %x reads slot_status %x\n", __FUNCTION__, 
+		SLOT_STATUS, slot_status);
+	
+	temp_word =  0x1F; /* Clear all events */
+	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS, temp_word);
+	if (rc) {
+		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
+		goto abort_free_ctlr;
+	}
+	dbg("%s: SLOT_STATUS offset %x writes slot_status %x\n", __FUNCTION__, SLOT_STATUS, temp_word);
 	
 	/*  Add this HPC instance into the HPC list */
 	spin_lock(&list_lock);
diff -Nru a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
--- a/drivers/pci/hotplug/pciehp_pci.c	Thu Apr 15 10:06:13 2004
+++ b/drivers/pci/hotplug/pciehp_pci.c	Thu Apr 15 10:06:13 2004
@@ -192,7 +192,6 @@
 	for (device = FirstSupported; device <= LastSupported; device++) {
 		ID = 0xFFFFFFFF;
 		rc = pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, 0), PCI_VENDOR_ID, &ID);
-		dbg("%s: ID = %x\n", __FUNCTION__, ID);
 
 		if (ID != 0xFFFFFFFF) {	  /*  device in slot */
 			dbg("%s: ID = %x\n", __FUNCTION__, ID);
@@ -325,7 +324,6 @@
 			new_slot->presence_save = 0;
 			new_slot->switch_save = 0;
 		}
-		dbg("%s: End of For loop\n", __FUNCTION__);
 	} 			/* End of FOR loop */
 
 	dbg("%s: Exit\n", __FUNCTION__);
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	Thu Apr 15 10:06:13 2004
+++ b/drivers/pci/hotplug/shpchp_hpc.c	Thu Apr 15 10:06:13 2004
@@ -1441,6 +1441,7 @@
 			err("%s : shpc_cap_offset == 0\n", __FUNCTION__);
 			goto abort_free_ctlr;
 		}
+		dbg("%s: shpc_cap_offset = %x\n", __FUNCTION__, shpc_cap_offset);	
 	
 		rc = pci_write_config_byte(pdev, (u8)shpc_cap_offset + DWORD_SELECT , BASE_OFFSET);
 		if (rc) {
@@ -1547,15 +1548,13 @@
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-#ifdef CONFIG_PCI_USE_VECTOR 
 		rc = pci_enable_msi(pdev);
 		if (rc) {
-			err("Can't get msi for the hotplug controller\n");
+			info("Can't get msi for the hotplug controller\n");
+			info("Use INTx for the hotplug controller\n");
 			dbg("%s: rc = %x\n", __FUNCTION__, rc);
-			goto abort_free_ctlr;
-		}
-		php_ctlr->irq = pdev->irq;
-#endif
+		} else
+			php_ctlr->irq = pdev->irq;
 		
 		rc = request_irq(php_ctlr->irq, shpc_isr, SA_SHIRQ, MY_NAME, (void *) ctrl);
 		dbg("%s: request_irq %d for hpc%d (returns %d)\n", __FUNCTION__, php_ctlr->irq, ctlr_seq_num, rc);
diff -Nru a/drivers/pci/hotplug/shpchprm_acpi.c b/drivers/pci/hotplug/shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c	Thu Apr 15 10:06:13 2004
+++ b/drivers/pci/hotplug/shpchprm_acpi.c	Thu Apr 15 10:06:13 2004
@@ -1267,7 +1267,8 @@
 int shpchprm_print_pirt(void)
 {
 	dbg("SHPCHPRM ACPI Slots\n");
-	print_acpi_resources (acpi_bridges_head);
+	if (acpi_bridges_head)
+		print_acpi_resources (acpi_bridges_head);
 	return 0;
 }
 
diff -Nru a/drivers/pci/hotplug/shpchprm_legacy.c b/drivers/pci/hotplug/shpchprm_legacy.c
--- a/drivers/pci/hotplug/shpchprm_legacy.c	Thu Apr 15 10:06:13 2004
+++ b/drivers/pci/hotplug/shpchprm_legacy.c	Thu Apr 15 10:06:13 2004
@@ -96,23 +96,6 @@
 	return fp;
 }
 
-#if link_available
-/*
- *  Links available memory, IO, and IRQ resources for programming
- *  devices which may be added to the system
- *
- *  Returns 0 if success
- */
-static int
-link_available_resources (
-	struct controller *ctrl,
-	struct pci_func *func,
-	int index )
-{
-	return shpchp_save_used_resources (ctrl, func, !DISABLE_CARD);
-}
-#endif
-
 /*
  * shpchprm_find_available_resources
  *
@@ -345,19 +328,6 @@
 			}
 		}
 
-#if link_available
-		++index;
-
-		while (index < 8) {
-			if (((func = shpchp_slot_find(primary_bus, dev_func >> 3, index)) != NULL) && populated_slot)
-				rc = link_available_resources(ctrl, func, index);
-			
-			if (rc)
-				break;
-
-			++index;
-		}
-#endif
 		i--;
 		one_slot += sizeof(struct slot_rt);
 	}
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Thu Apr 15 10:06:13 2004
+++ b/drivers/pci/pci.h	Thu Apr 15 10:06:13 2004
@@ -60,3 +60,5 @@
 
 /* Lock for read/write access to pci device and bus lists */
 extern spinlock_t pci_bus_lock;
+
+extern int pciehp_msi_quirk;
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Thu Apr 15 10:06:13 2004
+++ b/drivers/pci/quirks.c	Thu Apr 15 10:06:13 2004
@@ -868,6 +868,13 @@
 }
 #endif /* CONFIG_SCSI_SATA */
 
+int pciehp_msi_quirk;
+
+static void __devinit quirk_pciehp_msi(struct pci_dev *pdev)
+{
+	pciehp_msi_quirk = 1;
+}
+
 /*
  *  The main table of quirks.
  *
@@ -984,6 +991,8 @@
 	  quirk_intel_ide_combined },
 #endif /* CONFIG_SCSI_SATA */
 
+	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_SMCH,	quirk_pciehp_msi },
+
 	{ 0 }
 };
 
@@ -1008,3 +1017,5 @@
 	pci_do_fixups(dev, pass, pcibios_fixups);
 	pci_do_fixups(dev, pass, pci_fixups);
 }
+
+EXPORT_SYMBOL(pciehp_msi_quirk);
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Thu Apr 15 10:06:13 2004
+++ b/include/linux/pci_ids.h	Thu Apr 15 10:06:13 2004
@@ -2073,6 +2073,7 @@
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
+#define PCI_DEVICE_ID_INTEL_SMCH	0x3590
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010

