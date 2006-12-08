Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760822AbWLHS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760822AbWLHS2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760821AbWLHS21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:28:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46225 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760816AbWLHS2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:28:05 -0500
Message-Id: <20061208182500.478856000@osdl.org>
References: <20061208182241.786324000@osdl.org>
User-Agent: quilt/0.46-1
Date: Fri, 08 Dec 2006 10:22:43 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] e1000: use pcix_set_mmrbc
Content-Disposition: inline; filename=e1000-mmrbc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use new pcix_set_mmrbc interface, this prevents possible data
corruption on broken PCI-X chipsets.

The E1000 PCI hardware wrappers are a nuisance.
Untested on real hardware.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

---
 drivers/net/e1000/e1000_hw.c   |   23 ++---------------------
 drivers/net/e1000/e1000_hw.h   |    1 +
 drivers/net/e1000/e1000_main.c |    8 ++++++++
 3 files changed, 11 insertions(+), 21 deletions(-)

--- pci-x.orig/drivers/net/e1000/e1000_hw.c
+++ pci-x/drivers/net/e1000/e1000_hw.c
@@ -846,10 +846,6 @@ e1000_init_hw(struct e1000_hw *hw)
     uint32_t ctrl;
     uint32_t i;
     int32_t ret_val;
-    uint16_t pcix_cmd_word;
-    uint16_t pcix_stat_hi_word;
-    uint16_t cmd_mmrbc;
-    uint16_t stat_mmrbc;
     uint32_t mta_size;
     uint32_t reg_data;
     uint32_t ctrl_ext;
@@ -939,23 +935,8 @@ e1000_init_hw(struct e1000_hw *hw)
         break;
     default:
         /* Workaround for PCI-X problem when BIOS sets MMRBC incorrectly. */
-        if (hw->bus_type == e1000_bus_type_pcix) {
-            e1000_read_pci_cfg(hw, PCIX_COMMAND_REGISTER, &pcix_cmd_word);
-            e1000_read_pci_cfg(hw, PCIX_STATUS_REGISTER_HI,
-                &pcix_stat_hi_word);
-            cmd_mmrbc = (pcix_cmd_word & PCIX_COMMAND_MMRBC_MASK) >>
-                PCIX_COMMAND_MMRBC_SHIFT;
-            stat_mmrbc = (pcix_stat_hi_word & PCIX_STATUS_HI_MMRBC_MASK) >>
-                PCIX_STATUS_HI_MMRBC_SHIFT;
-            if (stat_mmrbc == PCIX_STATUS_HI_MMRBC_4K)
-                stat_mmrbc = PCIX_STATUS_HI_MMRBC_2K;
-            if (cmd_mmrbc > stat_mmrbc) {
-                pcix_cmd_word &= ~PCIX_COMMAND_MMRBC_MASK;
-                pcix_cmd_word |= stat_mmrbc << PCIX_COMMAND_MMRBC_SHIFT;
-                e1000_write_pci_cfg(hw, PCIX_COMMAND_REGISTER,
-                    &pcix_cmd_word);
-            }
-        }
+        if (hw->bus_type == e1000_bus_type_pcix)
+		e1000_pcix_set_mmrbc(hw, 2048);
         break;
     }
 
--- pci-x.orig/drivers/net/e1000/e1000_main.c
+++ pci-x/drivers/net/e1000/e1000_main.c
@@ -4770,6 +4770,14 @@ e1000_read_pci_cfg(struct e1000_hw *hw, 
 }
 
 void
+e1000_pcix_set_mmrbc(struct e1000_hw *hw, int mmrbc)
+{
+	struct e1000_adapter *adapter = hw->back;
+
+	pcix_set_mmrbc(adapter->pdev, mmrbc);
+}
+
+void
 e1000_write_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t *value)
 {
 	struct e1000_adapter *adapter = hw->back;
--- pci-x.orig/drivers/net/e1000/e1000_hw.h
+++ pci-x/drivers/net/e1000/e1000_hw.h
@@ -421,6 +421,7 @@ void e1000_tbi_adjust_stats(struct e1000
 void e1000_get_bus_info(struct e1000_hw *hw);
 void e1000_pci_set_mwi(struct e1000_hw *hw);
 void e1000_pci_clear_mwi(struct e1000_hw *hw);
+void e1000_pcix_set_mmrbc(struct e1000_hw *hw, int mmbrc);
 void e1000_read_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 void e1000_write_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 int32_t e1000_read_pcie_cap_reg(struct e1000_hw *hw, uint32_t reg, uint16_t *value);

-- 

