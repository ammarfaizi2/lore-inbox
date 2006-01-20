Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWATTNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWATTNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWATTNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:13:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:37584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932066AbWATTFG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:06 -0500
Cc: david.keck@amd.com
Subject: [PATCH] PCI Hotplug: shpchp: AMD POGO errata fix
In-Reply-To: <11377838782828@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:38 -0800
Message-Id: <11377838781658@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: shpchp: AMD POGO errata fix

This patch fixes the AMD POGO errata on the hotplug controller where the
platform will lock up or reboot if PERR/SERR generation is enabled and a
slot is sent an enable command.  This fix disables PERR/SERR generation
before a slot is sent the enable command by first saving related
registers, turning off SERR/PERR generation, enabling the slot, then
restoring the registers.

Signed-off-by: David Keck <david.keck@amd.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 74fe8a7679336ce8229401b13f7af364694818b1
tree 7e81db557f6d91a08ef8bcea60c4910fd7de1d86
parent 40ae159c997fbabbf864283dda902850d136d5aa
author Keck, David <david.keck@amd.com> Mon, 16 Jan 2006 15:22:36 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 drivers/pci/hotplug/shpchp.h      |   94 +++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/shpchp_ctrl.c |   12 ++++-
 2 files changed, 105 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index ce0e9b6..7d6f521 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -95,6 +95,7 @@ struct controller {
 	u8 function;
 	u8 slot_device_offset;
 	u8 add_support;
+	u32 pcix_misc2_reg;	/* for amd pogo errata */
 	enum pci_bus_speed speed;
 	u32 first_slot;		/* First physical slot number */
 	u8 slot_bus;		/* Bus where the slots handled by this controller sit */
@@ -113,6 +114,26 @@ struct hotplug_params {
 
 /* Define AMD SHPC ID  */
 #define PCI_DEVICE_ID_AMD_GOLAM_7450	0x7450 
+#define PCI_DEVICE_ID_AMD_POGO_7458	0x7458
+
+/* AMD PCIX bridge registers */
+
+#define PCIX_MEM_BASE_LIMIT_OFFSET	0x1C
+#define PCIX_MISCII_OFFSET		0x48
+#define PCIX_MISC_BRIDGE_ERRORS_OFFSET	0x80
+
+/* AMD PCIX_MISCII masks and offsets */
+#define PERRNONFATALENABLE_MASK		0x00040000
+#define PERRFATALENABLE_MASK		0x00080000
+#define PERRFLOODENABLE_MASK		0x00100000
+#define SERRNONFATALENABLE_MASK		0x00200000
+#define SERRFATALENABLE_MASK		0x00400000
+
+/* AMD PCIX_MISC_BRIDGE_ERRORS masks and offsets */
+#define PERR_OBSERVED_MASK		0x00000001
+
+/* AMD PCIX_MEM_BASE_LIMIT masks */
+#define RSE_MASK			0x40000000
 
 #define INT_BUTTON_IGNORE		0
 #define INT_PRESENCE_ON			1
@@ -333,6 +354,79 @@ static inline int wait_for_ctrl_irq (str
 	return retval;
 }
 
+static inline void amd_pogo_errata_save_misc_reg(struct slot *p_slot)
+{
+	u32 pcix_misc2_temp;
+
+	/* save MiscII register */
+	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MISCII_OFFSET, &pcix_misc2_temp);
+
+	p_slot->ctrl->pcix_misc2_reg = pcix_misc2_temp;
+
+	/* clear SERR/PERR enable bits */
+	pcix_misc2_temp &= ~SERRFATALENABLE_MASK;
+	pcix_misc2_temp &= ~SERRNONFATALENABLE_MASK;
+	pcix_misc2_temp &= ~PERRFLOODENABLE_MASK;
+	pcix_misc2_temp &= ~PERRFATALENABLE_MASK;
+	pcix_misc2_temp &= ~PERRNONFATALENABLE_MASK;
+	pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISCII_OFFSET, pcix_misc2_temp);
+}
+
+static inline void amd_pogo_errata_restore_misc_reg(struct slot *p_slot)
+{
+	u32 pcix_misc2_temp;
+	u32 pcix_bridge_errors_reg;
+	u32 pcix_mem_base_reg;
+	u8  perr_set;
+	u8  rse_set;
+
+	/* write-one-to-clear Bridge_Errors[ PERR_OBSERVED ] */
+	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET, &pcix_bridge_errors_reg);
+	perr_set = pcix_bridge_errors_reg & PERR_OBSERVED_MASK;
+	if (perr_set) {
+		dbg ("%s  W1C: Bridge_Errors[ PERR_OBSERVED = %08X]\n",__FUNCTION__ , perr_set);
+
+		pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET, perr_set);
+	}
+
+	/* write-one-to-clear Memory_Base_Limit[ RSE ] */
+	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MEM_BASE_LIMIT_OFFSET, &pcix_mem_base_reg);
+	rse_set = pcix_mem_base_reg & RSE_MASK;
+	if (rse_set) {
+		dbg ("%s  W1C: Memory_Base_Limit[ RSE ]\n",__FUNCTION__ );
+
+		pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MEM_BASE_LIMIT_OFFSET, rse_set);
+	}
+	/* restore MiscII register */
+	pci_read_config_dword( p_slot->ctrl->pci_dev, PCIX_MISCII_OFFSET, &pcix_misc2_temp );
+
+	if (p_slot->ctrl->pcix_misc2_reg & SERRFATALENABLE_MASK)
+		pcix_misc2_temp |= SERRFATALENABLE_MASK;
+	else
+		pcix_misc2_temp &= ~SERRFATALENABLE_MASK;
+
+	if (p_slot->ctrl->pcix_misc2_reg & SERRNONFATALENABLE_MASK)
+		pcix_misc2_temp |= SERRNONFATALENABLE_MASK;
+	else
+		pcix_misc2_temp &= ~SERRNONFATALENABLE_MASK;
+
+	if (p_slot->ctrl->pcix_misc2_reg & PERRFLOODENABLE_MASK)
+		pcix_misc2_temp |= PERRFLOODENABLE_MASK;
+	else
+		pcix_misc2_temp &= ~PERRFLOODENABLE_MASK;
+
+	if (p_slot->ctrl->pcix_misc2_reg & PERRFATALENABLE_MASK)
+		pcix_misc2_temp |= PERRFATALENABLE_MASK;
+	else
+		pcix_misc2_temp &= ~PERRFATALENABLE_MASK;
+
+	if (p_slot->ctrl->pcix_misc2_reg & PERRNONFATALENABLE_MASK)
+		pcix_misc2_temp |= PERRNONFATALENABLE_MASK;
+	else
+		pcix_misc2_temp &= ~PERRNONFATALENABLE_MASK;
+	pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISCII_OFFSET, pcix_misc2_temp);
+}
+
 #define SLOT_NAME_SIZE 10
 
 static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 25ccb0e..643252d 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -894,7 +894,17 @@ int shpchp_enable_slot (struct slot *p_s
 	dbg("%s: p_slot->pwr_save %x\n", __FUNCTION__, p_slot->pwr_save);
 	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 
-	rc = board_added(p_slot);
+	if(((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD) ||
+	    (p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458))
+	     && p_slot->ctrl->num_slots == 1) {
+		/* handle amd pogo errata; this must be done before enable  */
+		amd_pogo_errata_save_misc_reg(p_slot);
+		rc = board_added(p_slot);
+		/* handle amd pogo errata; this must be done after enable  */
+		amd_pogo_errata_restore_misc_reg(p_slot);
+	} else
+		rc = board_added(p_slot);
+
 	if (rc) {
 		p_slot->hpc_ops->get_adapter_status(p_slot,
 				&(p_slot->presence_save));

