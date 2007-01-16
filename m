Return-Path: <linux-kernel-owner+w=401wt.eu-S1751369AbXAPTu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXAPTu2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXAPTu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:50:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:26381 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbXAPTu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:50:26 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,197,1167638400"; 
   d="scan'208"; a="185651613:sNHT64509403"
From: Auke Kok <auke-jan.h.kok@intel.com>
To: akpm@osdl.org
Cc: jgarzik@pobox.com
Cc: Jesse Brandeburg <jbrandeb@intel.com>
Cc: Jeb Cramer <cramerj@intel.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: arjan@infradead.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: robbat2@gentoo.org
Cc: infowolfe@gmail.com
Subject: [PATCH -MM] e1000: update new hardware init layer code with bugfixes
Date: Tue, 16 Jan 2007 11:33:16 -0800
Message-Id: <20070116195010.8CAAD418A2@ahkok-mobl.jf.intel.com>
X-OriginalArrivalTime: 16 Jan 2007 19:50:10.0657 (UTC) FILETIME=[87F3C510:01C739A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e1000: update new hardware init layer code with bugfixes

From: Jeb Cramer <cramerj@intel.com>

Replace hard coded RAR numbers with constant. Add several function description
and fix some small copy+paste errors in others. Fix link speed detection on
PCI adapters showing wrong PCI bus speed. Fix laa detection. Rewrite tbi static
for 82543. Fix mta list overflow. Don't unmap skb's twice in occasions, but set
dma=0. Flatten dhcp generic function for readability. Change force phy speed
duplex setup to be void and static.

Depends on git-e1000.patch as present in 2.6.20-rc4-mm1.

Signed-off-by: Jesse Brandeburg <jbrandeb@intel.com>
Signed-off-by: Jeb Cramer <cramerj@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
---

 drivers/net/e1000/e1000_80003es2lan.c |   90 ++++++++++++++++++++++++---------
 drivers/net/e1000/e1000_82540.c       |   86 ++++++++++++++++++++++++++++++--
 drivers/net/e1000/e1000_82541.c       |    6 +-
 drivers/net/e1000/e1000_82542.c       |    6 +-
 drivers/net/e1000/e1000_82543.c       |   44 +++++++++-------
 drivers/net/e1000/e1000_82571.c       |   19 +++----
 drivers/net/e1000/e1000_api.h         |    1 
 drivers/net/e1000/e1000_defines.h     |    8 +++
 drivers/net/e1000/e1000_ich8lan.c     |   21 +++++---
 drivers/net/e1000/e1000_ich8lan.h     |    2 +
 drivers/net/e1000/e1000_mac.c         |    5 ++
 drivers/net/e1000/e1000_main.c        |   31 ++++++++---
 drivers/net/e1000/e1000_manage.c      |   39 +++++++-------
 drivers/net/e1000/e1000_nvm.c         |    3 -
 drivers/net/e1000/e1000_osdep.h       |    2 -
 drivers/net/e1000/e1000_phy.c         |   58 +++++++++++----------
 drivers/net/e1000/e1000_phy.h         |   64 ++++++++++++-----------
 17 files changed, 316 insertions(+), 169 deletions(-)

diff --git a/drivers/net/e1000/e1000_80003es2lan.c b/drivers/net/e1000/e1000_80003es2lan.c
index ef5e250..9a89c26 100644
--- a/drivers/net/e1000/e1000_80003es2lan.c
+++ b/drivers/net/e1000/e1000_80003es2lan.c
@@ -131,7 +131,7 @@ out:
 }
 
 /**
- * e1000_init_phy_params_80003es2lan - Init ESB2 NVM func ptrs.
+ * e1000_init_nvm_params_80003es2lan - Init ESB2 NVM func ptrs.
  * @hw - pointer to the HW structure
  *
  * This is a function pointer entry point called by the api module.
@@ -187,7 +187,7 @@ e1000_init_nvm_params_80003es2lan(struct e1000_hw *hw)
 }
 
 /**
- * e1000_init_phy_params_80003es2lan - Init ESB2 MAC func ptrs.
+ * e1000_init_mac_params_80003es2lan - Init ESB2 MAC func ptrs.
  * @hw - pointer to the HW structure
  *
  * This is a function pointer entry point called by the api module.
@@ -214,7 +214,7 @@ e1000_init_mac_params_80003es2lan(struct e1000_hw *hw)
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
-	mac->rar_entry_count = 16;
+	mac->rar_entry_count = E1000_RAR_ENTRIES;
 	/* Set if part includes ASF firmware */
 	mac->asf_firmware_present = TRUE;
 	/* Set if manageability features are enabled. */
@@ -535,29 +535,48 @@ e1000_read_phy_reg_gg82563_80003es2lan(struct e1000_hw *hw, u32 offset,
                                        u16 *data)
 {
 	s32 ret_val;
+	u32 page_select;
+	u16 temp;
 
 	DEBUGFUNC("e1000_read_phy_reg_gg82563_80003es2lan");
 
 	/* Select Configuration Page */
-	if ((offset & MAX_PHY_REG_ADDRESS) < GG82563_MIN_ALT_REG) {
-		ret_val = e1000_write_phy_reg_m88(hw, GG82563_PHY_PAGE_SELECT,
-		                      (u16)((u16)offset >> GG82563_PAGE_SHIFT));
-	} else {
+	if ((offset & MAX_PHY_REG_ADDRESS) < GG82563_MIN_ALT_REG)
+		page_select = GG82563_PHY_PAGE_SELECT;
+	else {
 		/* Use Alternative Page Select register to access
 		 * registers 30 and 31
 		 */
-		ret_val = e1000_write_phy_reg_m88(hw,
-		                                  GG82563_PHY_PAGE_SELECT_ALT,
-		                      (u16)((u16)offset >> GG82563_PAGE_SHIFT));
+		page_select = GG82563_PHY_PAGE_SELECT_ALT;
 	}
 
+	temp = (u16)((u16)offset >> GG82563_PAGE_SHIFT);
+	ret_val = e1000_write_phy_reg_m88(hw, page_select, temp);
 	if (ret_val)
 		goto out;
 
+	/* The "ready" bit in the MDIC register may be incorrectly set
+	 * before the device has completed the "Page Select" MDI
+	 * transaction.  So we wait 200us after each MDI command...
+	 */
+	udelay(200);
+
+	/* ...and verify the command was successful. */
+	ret_val = e1000_read_phy_reg_m88(hw, page_select, &temp);
+
+	if (((u16)offset >> GG82563_PAGE_SHIFT) != temp) {
+		ret_val = -E1000_ERR_PHY;
+		goto out;
+	}
+
+	udelay(200);
+
 	ret_val = e1000_read_phy_reg_m88(hw,
 	                                 MAX_PHY_REG_ADDRESS & offset,
 	                                 data);
 
+	udelay(200);
+
 out:
 	return ret_val;
 }
@@ -576,29 +595,48 @@ e1000_write_phy_reg_gg82563_80003es2lan(struct e1000_hw *hw, u32 offset,
                                         u16 data)
 {
 	s32 ret_val;
+	u32 page_select;
+	u16 temp;
 
 	DEBUGFUNC("e1000_write_phy_reg_gg82563_80003es2lan");
 
 	/* Select Configuration Page */
-	if ((offset & MAX_PHY_REG_ADDRESS) < GG82563_MIN_ALT_REG) {
-		ret_val = e1000_write_phy_reg_m88(hw, GG82563_PHY_PAGE_SELECT,
-		                      (u16)((u16)offset >> GG82563_PAGE_SHIFT));
-	} else {
+	if ((offset & MAX_PHY_REG_ADDRESS) < GG82563_MIN_ALT_REG)
+		page_select = GG82563_PHY_PAGE_SELECT;
+	else {
 		/* Use Alternative Page Select register to access
 		 * registers 30 and 31
 		 */
-		ret_val = e1000_write_phy_reg_m88(hw,
-		                                  GG82563_PHY_PAGE_SELECT_ALT,
-		                      (u16)((u16)offset >> GG82563_PAGE_SHIFT));
+		page_select = GG82563_PHY_PAGE_SELECT_ALT;
 	}
 
+	temp = (u16)((u16)offset >> GG82563_PAGE_SHIFT);
+	ret_val = e1000_write_phy_reg_m88(hw, page_select, temp);
 	if (ret_val)
 		goto out;
 
+	/* The "ready" bit in the MDIC register may be incorrectly set
+	 * before the device has completed the "Page Select" MDI
+	 * transaction.  So we wait 200us after each MDI command...
+	 */
+	udelay(200);
+
+	/* ...and verify the command was successful. */
+	ret_val = e1000_read_phy_reg_m88(hw, page_select, &temp);
+
+	if (((u16)offset >> GG82563_PAGE_SHIFT) != temp) {
+		ret_val = -E1000_ERR_PHY;
+		goto out;
+	}
+
+	udelay(200);
+
 	ret_val = e1000_write_phy_reg_m88(hw,
 	                                  MAX_PHY_REG_ADDRESS & offset,
 	                                  data);
 
+	udelay(200);
+
 out:
 	return ret_val;
 }
@@ -673,10 +711,6 @@ e1000_phy_force_speed_duplex_80003es2lan(struct e1000_hw *hw)
 
 	DEBUGFUNC("e1000_phy_force_speed_duplex_80003es2lan");
 
-	ret_val = e1000_phy_force_speed_duplex_setup(hw);
-	if (ret_val)
-		goto out;
-
 	/* Clear Auto-Crossover to force MDI manually.  M88E1000 requires MDI
 	 * forced whenever speed and duplex are forced.
 	 */
@@ -691,8 +725,16 @@ e1000_phy_force_speed_duplex_80003es2lan(struct e1000_hw *hw)
 
 	DEBUGOUT1("GG82563 PSCR: %X\n", phy_data);
 
+	ret_val = e1000_read_phy_reg(hw, PHY_CONTROL, &phy_data);
+	if (ret_val)
+		goto out;
+
+	e1000_phy_force_speed_duplex_setup(hw, &phy_data);
+
 	/* Reset the phy to commit changes. */
-	ret_val = e1000_phy_commit(hw);
+	phy_data |= MII_CR_RESET;
+
+	ret_val = e1000_write_phy_reg(hw, PHY_CONTROL, phy_data);
 	if (ret_val)
 		goto out;
 
@@ -892,9 +934,7 @@ e1000_init_hw_80003es2lan(struct e1000_hw *hw)
 	DEBUGOUT("Initializing the IEEE VLAN\n");
 	e1000_clear_vfta(hw);
 
-	/* Setup the receive address.  This involves initializing all of the
-	 * Receive Address Registers (RARs 0 - 15).
-	 */
+	/* Setup the receive address. */
 	e1000_init_rx_addrs_generic(hw, mac->rar_entry_count);
 
 	/* Zero out the Multicast HASH table */
diff --git a/drivers/net/e1000/e1000_82540.c b/drivers/net/e1000/e1000_82540.c
index 325c2e7..d82f3fa 100644
--- a/drivers/net/e1000/e1000_82540.c
+++ b/drivers/net/e1000/e1000_82540.c
@@ -49,6 +49,12 @@ static s32  e1000_set_vco_speed_82540(struct e1000_hw *hw);
 static s32  e1000_setup_copper_link_82540(struct e1000_hw *hw);
 static s32  e1000_setup_fiber_serdes_link_82540(struct e1000_hw *hw);
 
+/**
+ * e1000_init_phy_params_82540 - Init PHY func ptrs.
+ * @hw - pointer to the HW structure
+ *
+ * This is a function pointer entry point called by the api module.
+ **/
 static s32
 e1000_init_phy_params_82540(struct e1000_hw *hw)
 {
@@ -96,6 +102,12 @@ out:
 	return ret_val;
 }
 
+/**
+ * e1000_init_nvm_params_82540 - Init NVM func ptrs.
+ * @hw - pointer to the HW structure
+ *
+ * This is a function pointer entry point called by the api module.
+ **/
 static s32
 e1000_init_nvm_params_82540(struct e1000_hw *hw)
 {
@@ -135,6 +147,12 @@ e1000_init_nvm_params_82540(struct e1000_hw *hw)
 	return E1000_SUCCESS;
 }
 
+/**
+ * e1000_init_mac_params_82540 - Init MAC func ptrs.
+ * @hw - pointer to the HW structure
+ *
+ * This is a function pointer entry point called by the api module.
+ **/
 static s32
 e1000_init_mac_params_82540(struct e1000_hw *hw)
 {
@@ -164,7 +182,7 @@ e1000_init_mac_params_82540(struct e1000_hw *hw)
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
-	mac->rar_entry_count = 16;
+	mac->rar_entry_count = E1000_RAR_ENTRIES;
 
 	/* Function pointers */
 
@@ -224,6 +242,13 @@ out:
 	return ret_val;
 }
 
+/**
+ * e1000_init_function_pointers_82540 - Init func ptrs.
+ * @hw - pointer to the HW structure
+ *
+ * The only function explicitly called by the api module to initialize
+ * all function pointers and parameters.
+ **/
 void
 e1000_init_function_pointers_82540(struct e1000_hw *hw)
 {
@@ -234,6 +259,13 @@ e1000_init_function_pointers_82540(struct e1000_hw *hw)
 	hw->func.init_phy_params = e1000_init_phy_params_82540;
 }
 
+/**
+ *  e1000_reset_hw_82540 - Reset hardware
+ *  @hw - pointer to the HW structure
+ *
+ *  This resets the hardware into a known state.  This is a
+ *  function pointer entry point called by the api module.
+ **/
 static s32
 e1000_reset_hw_82540(struct e1000_hw *hw)
 {
@@ -285,6 +317,13 @@ e1000_reset_hw_82540(struct e1000_hw *hw)
 	return ret_val;
 }
 
+/**
+ *  e1000_init_hw_82540 - Initialize hardware
+ *  @hw - pointer to the HW structure
+ *
+ *  This inits the hardware readying it for operation.  This is a
+ *  function pointer entry point called by the api module.
+ **/
 static s32
 e1000_init_hw_82540(struct e1000_hw *hw)
 {
@@ -309,9 +348,7 @@ e1000_init_hw_82540(struct e1000_hw *hw)
 	}
 	e1000_clear_vfta(hw);
 
-	/* Setup the receive address.  This involves initializing all of the
-	 * Receive Address Registers (RARs 0 - 15).
-	 */
+	/* Setup the receive address. */
 	e1000_init_rx_addrs_generic(hw, mac->rar_entry_count);
 
 	/* Zero out the Multicast HASH table */
@@ -359,6 +396,16 @@ out:
 	return ret_val;
 }
 
+/**
+ *  e1000_setup_copper_link_82540 - Configure copper link settings
+ *  @hw - pointer to the HW structure
+ *
+ *  Calls the appropriate function to configure the link for auto-neg or forced
+ *  speed and duplex.  Then we check for link, once link is established calls
+ *  to configure collision distance and flow control are called.  If link is
+ *  not established, we return -E1000_ERR_PHY (-2).  This is a function
+ *  pointer entry point called by the api module.
+ **/
 static s32
 e1000_setup_copper_link_82540(struct e1000_hw *hw)
 {
@@ -398,6 +445,16 @@ out:
 	return ret_val;
 }
 
+/**
+ *  e1000_setup_fiber_serdes_link_82540 - Setup link for fiber/serdes
+ *  @hw - pointer to the HW structure
+ *
+ *  Set the output amplitude to the value in the EEPROM and adjust the VCO
+ *  speed to improve Bit Error Rate (BER) performance.  Configures collision
+ *  distance and flow control for fiber and serdes links.  Upon successful
+ *  setup, poll for link.  This is a function pointer entry point called by
+ *  the api module.
+ **/
 static s32
 e1000_setup_fiber_serdes_link_82540(struct e1000_hw *hw)
 {
@@ -431,6 +488,12 @@ out:
 	return ret_val;
 }
 
+/**
+ *  e1000_adjust_serdes_amplitude_82540 - Adjust amplitude based on EEPROM
+ *  @hw - pointer to the HW structure
+ *
+ *  Adjust the SERDES ouput amplitude based on the EEPROM settings.
+ **/
 static s32
 e1000_adjust_serdes_amplitude_82540(struct e1000_hw *hw)
 {
@@ -458,6 +521,12 @@ out:
 	return ret_val;
 }
 
+/**
+ *  e1000_set_vco_speed_82540 - Set VCO speed for better performance
+ *  @hw - pointer to the HW structure
+ *
+ *  Set the VCO speed to improve Bit Error Rate (BER) performance.
+ **/
 static s32
 e1000_set_vco_speed_82540(struct e1000_hw *hw)
 {
@@ -510,6 +579,15 @@ out:
 	return ret_val;
 }
 
+/**
+ *  e1000_set_phy_mode_82540 - Set PHY to class A mode
+ *  @hw - pointer to the HW structure
+ *
+ *  Sets the PHY to class A mode and assumes the following operations will
+ *  follow to enable the new class mode:
+ *    1.  Do a PHY soft reset.
+ *    2.  Restart auto-negotiation or force link.
+ **/
 static s32
 e1000_set_phy_mode_82540(struct e1000_hw *hw)
 {
diff --git a/drivers/net/e1000/e1000_82541.c b/drivers/net/e1000/e1000_82541.c
index bd6ee89..3ad9f72 100644
--- a/drivers/net/e1000/e1000_82541.c
+++ b/drivers/net/e1000/e1000_82541.c
@@ -222,7 +222,7 @@ e1000_init_mac_params_82541(struct e1000_hw *hw)
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
-	mac->rar_entry_count = 16;
+	mac->rar_entry_count = E1000_RAR_ENTRIES;
 	/* Set if part includes ASF firmware */
 	mac->asf_firmware_present = TRUE;
 
@@ -370,9 +370,7 @@ e1000_init_hw_82541(struct e1000_hw *hw)
 	DEBUGOUT("Initializing the IEEE VLAN\n");
 	e1000_clear_vfta(hw);
 
-	/* Setup the receive address.  This involves initializing
-	 * all of the Receive Address Registers (RARs 0 - 15);
-	 */
+	/* Setup the receive address. */
 	e1000_init_rx_addrs_generic(hw, mac->rar_entry_count);
 
 	/* Zero out the Multicast HASH table */
diff --git a/drivers/net/e1000/e1000_82542.c b/drivers/net/e1000/e1000_82542.c
index 25bc73a..febbafb 100644
--- a/drivers/net/e1000/e1000_82542.c
+++ b/drivers/net/e1000/e1000_82542.c
@@ -100,7 +100,7 @@ e1000_init_mac_params_82542(struct e1000_hw *hw)
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
-	mac->rar_entry_count = 16;
+	mac->rar_entry_count = E1000_RAR_ENTRIES;
 
 	/* Function pointers */
 
@@ -235,9 +235,7 @@ e1000_init_hw_82542(struct e1000_hw *hw)
 		msleep(5);
 	}
 
-	/* Setup the receive address.  This involves initializing all of the
-	 * Receive Address Registers (RARs 0 - 15).
-	 */
+	/* Setup the receive address. */
 	e1000_init_rx_addrs_generic(hw, mac->rar_entry_count);
 
 	/* For 82542 (rev 2.0), take the receiver out of reset and enable MWI */
diff --git a/drivers/net/e1000/e1000_82543.c b/drivers/net/e1000/e1000_82543.c
index c29789a..f1acc51 100644
--- a/drivers/net/e1000/e1000_82543.c
+++ b/drivers/net/e1000/e1000_82543.c
@@ -64,6 +64,7 @@ static void      e1000_raise_mdi_clk_82543(struct e1000_hw *hw, u32 *ctrl);
 static u16       e1000_shift_in_mdi_bits_82543(struct e1000_hw *hw);
 static void      e1000_shift_out_mdi_bits_82543(struct e1000_hw *hw, u32 data,
                                                 u16 count);
+static boolean_t e1000_tbi_compatibility_enabled_82543(struct e1000_hw *hw);
 static void      e1000_set_tbi_sbp_82543(struct e1000_hw *hw, boolean_t state);
 
 struct e1000_dev_spec_82543 {
@@ -196,7 +197,7 @@ e1000_init_mac_params_82543(struct e1000_hw *hw)
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
-	mac->rar_entry_count = 16;
+	mac->rar_entry_count = E1000_RAR_ENTRIES;
 
 	/* Function pointers */
 
@@ -265,7 +266,7 @@ e1000_init_function_pointers_82543(struct e1000_hw *hw)
 	hw->func.init_phy_params = e1000_init_phy_params_82543;
 }
 
-boolean_t
+static boolean_t
 e1000_tbi_compatibility_enabled_82543(struct e1000_hw *hw)
 {
 	struct e1000_dev_spec_82543 *dev_spec;
@@ -869,9 +870,7 @@ e1000_init_hw_82543(struct e1000_hw *hw)
 	E1000_WRITE_REG(hw, VET, 0);
 	e1000_clear_vfta(hw);
 
-	/* Setup the receive address.  This involves initializing all of the
-	 * Receive Address Registers (RARs 0 - 15).
-	 */
+	/* Setup the receive address. */
 	e1000_init_rx_addrs_generic(hw, mac->rar_entry_count);
 
 	/* Zero out the Multicast HASH table */
@@ -1286,41 +1285,46 @@ out:
 static void
 e1000_write_vfta_82543(struct e1000_hw *hw, u32 offset, u32 value)
 {
-	u32 vfta;
+	u32 temp;
 
 	DEBUGFUNC("e1000_write_vfta_82543");
 
-	vfta = E1000_READ_REG_ARRAY(hw, VFTA, offset - 1);
-
-	e1000_write_vfta_generic(hw, offset, value);
-
 	if ((hw->mac.type == e1000_82544) && (offset & 1)) {
-		E1000_WRITE_REG_ARRAY(hw, VFTA, offset - 1, vfta);
+		temp = E1000_READ_REG_ARRAY(hw, VFTA, offset - 1);
+		E1000_WRITE_REG_ARRAY(hw, VFTA, offset, value);
 		E1000_WRITE_FLUSH(hw);
-	}
+		E1000_WRITE_REG_ARRAY(hw, VFTA, offset - 1, temp);
+		E1000_WRITE_FLUSH(hw);
+	} else
+		e1000_write_vfta_generic(hw, offset, value);
 }
 
 static void
 e1000_mta_set_82543(struct e1000_hw *hw, u32 hash_value)
 {
-	u32 hash_reg, mta;
+	u32 hash_bit, hash_reg, mta, temp;
 
 	DEBUGFUNC("e1000_mta_set_82543");
 
-	hash_reg = (hash_value >> 5) & (hw->mac.mta_reg_count - 1);
-
-	mta = E1000_READ_REG_ARRAY(hw, MTA, hash_reg - 1);
-
-	e1000_mta_set_generic(hw, hash_value);
+	hash_reg = (hash_value >> 5);
 
 	/* If we are on an 82544 and we are trying to write an odd offset
 	 * in the MTA, save off the previous entry before writing and
 	 * restore the old value after writing.
 	 */
 	if ((hw->mac.type == e1000_82544) && (hash_reg & 1)) {
-		E1000_WRITE_REG_ARRAY(hw, MTA, hash_reg - 1, mta);
+		hash_reg &= (hw->mac.mta_reg_count - 1);
+		hash_bit = hash_value & 0x1F;
+		mta = E1000_READ_REG_ARRAY(hw, MTA, hash_reg);
+		mta |= (1 << hash_bit);
+		temp = E1000_READ_REG_ARRAY(hw, MTA, hash_reg - 1);
+
+		E1000_WRITE_REG_ARRAY(hw, MTA, hash_reg, mta);
 		E1000_WRITE_FLUSH(hw);
-	}
+		E1000_WRITE_REG_ARRAY(hw, MTA, hash_reg - 1, temp);
+		E1000_WRITE_FLUSH(hw);
+	} else
+		e1000_mta_set_generic(hw, hash_value);
 }
 
 static s32
diff --git a/drivers/net/e1000/e1000_82571.c b/drivers/net/e1000/e1000_82571.c
index 0ebee4c..f54ed5d 100644
--- a/drivers/net/e1000/e1000_82571.c
+++ b/drivers/net/e1000/e1000_82571.c
@@ -243,7 +243,7 @@ e1000_init_mac_params_82571(struct e1000_hw *hw)
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
-	mac->rar_entry_count = 16;
+	mac->rar_entry_count = E1000_RAR_ENTRIES;
 	/* Set if part includes ASF firmware */
 	mac->asf_firmware_present = TRUE;
 	/* Set if manageability features are enabled. */
@@ -700,7 +700,6 @@ static s32
 e1000_init_hw_82571(struct e1000_hw *hw)
 {
 	struct e1000_mac_info *mac = &hw->mac;
-	struct e1000_dev_spec_82571 *dev_spec;
 	u32 reg_data;
 	s32 ret_val;
 	u16 i, rar_count = mac->rar_entry_count;
@@ -709,8 +708,6 @@ e1000_init_hw_82571(struct e1000_hw *hw)
 
 	e1000_initialize_hw_bits_82571(hw);
 
-	dev_spec = (struct e1000_dev_spec_82571 *)hw->dev_spec;
-
 	/* Initialize identification LED */
 	ret_val = e1000_id_led_init_generic(hw);
 	if (ret_val) {
@@ -722,14 +719,12 @@ e1000_init_hw_82571(struct e1000_hw *hw)
 	DEBUGOUT("Initializing the IEEE VLAN\n");
 	e1000_clear_vfta(hw);
 
-	/* Setup the receive address.  This involves initializing all of the
-	 * Receive Address Registers (RARs 0 - 15).
-	 */
+	/* Setup the receive address. */
 	/* If, however, a locally administered address was assigned to the
 	 * 82571, we must reserve a RAR for it to work around an issue where
 	 * resetting one port will reload the MAC on the other port.
 	 */
-	if (dev_spec->laa_is_present)
+	if (e1000_get_laa_state_82571(hw) == TRUE)
 		rar_count--;
 	e1000_init_rx_addrs_generic(hw, rar_count);
 
@@ -744,16 +739,16 @@ e1000_init_hw_82571(struct e1000_hw *hw)
 	/* Set the transmit descriptor write-back policy */
 	reg_data = E1000_READ_REG(hw, TXDCTL);
 	reg_data = (reg_data & ~E1000_TXDCTL_WTHRESH) |
-	         E1000_TXDCTL_FULL_TX_DESC_WB |
-	         E1000_TXDCTL_COUNT_DESC;
+	           E1000_TXDCTL_FULL_TX_DESC_WB |
+	           E1000_TXDCTL_COUNT_DESC;
 	E1000_WRITE_REG(hw, TXDCTL, reg_data);
 
 	/* ...for both queues. */
 	if (mac->type != e1000_82573) {
 		reg_data = E1000_READ_REG(hw, TXDCTL1);
 		reg_data = (reg_data & ~E1000_TXDCTL_WTHRESH) |
-		         E1000_TXDCTL_FULL_TX_DESC_WB |
-		         E1000_TXDCTL_COUNT_DESC;
+		           E1000_TXDCTL_FULL_TX_DESC_WB |
+		           E1000_TXDCTL_COUNT_DESC;
 		E1000_WRITE_REG(hw, TXDCTL1, reg_data);
 	} else {
 		e1000_enable_tx_pkt_filtering(hw);
diff --git a/drivers/net/e1000/e1000_api.h b/drivers/net/e1000/e1000_api.h
index 43ae26d..1eb11aa 100644
--- a/drivers/net/e1000/e1000_api.h
+++ b/drivers/net/e1000/e1000_api.h
@@ -97,7 +97,6 @@ void      e1000_tbi_adjust_stats_82543(struct e1000_hw *hw,
                                        u32 frame_len, u8 *mac_addr);
 void      e1000_set_tbi_compatibility_82543(struct e1000_hw *hw,
                                             boolean_t state);
-boolean_t e1000_tbi_compatibility_enabled_82543(struct e1000_hw *hw);
 boolean_t e1000_tbi_sbp_enabled_82543(struct e1000_hw *hw);
 #endif
 #ifndef NO_82542_SUPPORT
diff --git a/drivers/net/e1000/e1000_defines.h b/drivers/net/e1000/e1000_defines.h
index 06dea1a..b647ff6 100644
--- a/drivers/net/e1000/e1000_defines.h
+++ b/drivers/net/e1000/e1000_defines.h
@@ -740,6 +740,7 @@
 #define E1000_TXDCTL_GRAN    0x01000000 /* TXDCTL Granularity */
 #define E1000_TXDCTL_LWTHRESH 0xFE000000 /* TXDCTL Low Threshold */
 #define E1000_TXDCTL_FULL_TX_DESC_WB 0x01010000 /* GRAN=1, WTHRESH=1 */
+#define E1000_TXDCTL_MAX_TX_DESC_PREFETCH 0x0100001F /* GRAN=1, PTHRESH=31 */
 #define E1000_TXDCTL_COUNT_DESC 0x00400000 /* Enable the counting of desc.
                                               still to be processed. */
 
@@ -753,6 +754,13 @@
 #define E1000_VLAN_FILTER_TBL_SIZE 128  /* VLAN Filter Table (4096 bits) */
 
 /* Receive Address */
+/* Number of high/low register pairs in the RAR. The RAR (Receive Address
+ * Registers) holds the directed and multicast addresses that we monitor.
+ * Technically, we have 16 spots.  However, we reserve one of these spots
+ * (RAR[15]) for our directed address used by controllers with
+ * manageability enabled, allowing us room for 15 multicast addresses.
+ */
+#define E1000_RAR_ENTRIES     15
 #define E1000_RAH_AV  0x80000000        /* Receive descriptor valid */
 
 /* Error Codes */
diff --git a/drivers/net/e1000/e1000_ich8lan.c b/drivers/net/e1000/e1000_ich8lan.c
index 53f7570..19fdd27 100644
--- a/drivers/net/e1000/e1000_ich8lan.c
+++ b/drivers/net/e1000/e1000_ich8lan.c
@@ -292,10 +292,9 @@ e1000_init_mac_params_ich8lan(struct e1000_hw *hw)
 	/* Set mta register count */
 	mac->mta_reg_count = 32;
 	/* Set rar entry count */
+	mac->rar_entry_count = E1000_ICH_RAR_ENTRIES;
 	if (mac->type == e1000_ich8lan)
-		mac->rar_entry_count = 6;
-	else
-		mac->rar_entry_count = 7;
+		mac->rar_entry_count--;
 	/* Set if part includes ASF firmware */
 	mac->asf_firmware_present = TRUE;
 	/* Set if manageability features are enabled. */
@@ -493,7 +492,13 @@ e1000_phy_force_speed_duplex_ich8lan(struct e1000_hw *hw)
 		goto out;
 	}
 
-	ret_val = e1000_phy_force_speed_duplex_setup(hw);
+	ret_val = e1000_read_phy_reg(hw, PHY_CONTROL, &data);
+	if (ret_val)
+		goto out;
+
+	e1000_phy_force_speed_duplex_setup(hw, &data);
+
+	ret_val = e1000_write_phy_reg(hw, PHY_CONTROL, data);
 	if (ret_val)
 		goto out;
 
@@ -1860,9 +1865,7 @@ e1000_init_hw_ich8lan(struct e1000_hw *hw)
 		goto out;
 	}
 
-	/* Setup the receive address.  This involves initializing all of the
-	 * Receive Address Registers (RARs 0 - 5).
-	 */
+	/* Setup the receive address. */
 	e1000_init_rx_addrs_generic(hw, mac->rar_entry_count);
 
 	/* Zero out the Multicast HASH table */
@@ -1877,10 +1880,14 @@ e1000_init_hw_ich8lan(struct e1000_hw *hw)
 	txdctl = E1000_READ_REG(hw, TXDCTL);
 	txdctl = (txdctl & ~E1000_TXDCTL_WTHRESH) |
 		 E1000_TXDCTL_FULL_TX_DESC_WB;
+	txdctl = (txdctl & ~E1000_TXDCTL_PTHRESH) |
+	         E1000_TXDCTL_MAX_TX_DESC_PREFETCH;
 	E1000_WRITE_REG(hw, TXDCTL, txdctl);
 	txdctl = E1000_READ_REG(hw, TXDCTL1);
 	txdctl = (txdctl & ~E1000_TXDCTL_WTHRESH) |
 		 E1000_TXDCTL_FULL_TX_DESC_WB;
+	txdctl = (txdctl & ~E1000_TXDCTL_PTHRESH) |
+	         E1000_TXDCTL_MAX_TX_DESC_PREFETCH;
 	E1000_WRITE_REG(hw, TXDCTL1, txdctl);
 
 	/* ICH8 has opposite polarity of no_snoop bits.
diff --git a/drivers/net/e1000/e1000_ich8lan.h b/drivers/net/e1000/e1000_ich8lan.h
index 04a2d9e..d39f7c3 100644
--- a/drivers/net/e1000/e1000_ich8lan.h
+++ b/drivers/net/e1000/e1000_ich8lan.h
@@ -83,6 +83,8 @@
 
 #define PCIE_ICH8_SNOOP_ALL   PCIE_NO_SNOOP_ALL
 
+#define E1000_ICH_RAR_ENTRIES            7
+
 #define PHY_PAGE_SHIFT 5
 #define PHY_REG(page, reg) (((page) << PHY_PAGE_SHIFT) | \
                            ((reg) & MAX_PHY_REG_ADDRESS))
diff --git a/drivers/net/e1000/e1000_mac.c b/drivers/net/e1000/e1000_mac.c
index 3137e05..4b1ad11 100644
--- a/drivers/net/e1000/e1000_mac.c
+++ b/drivers/net/e1000/e1000_mac.c
@@ -76,10 +76,13 @@ e1000_get_bus_info_pci_generic(struct e1000_hw *hw)
 		switch (status & E1000_STATUS_PCIX_SPEED) {
 		case E1000_STATUS_PCIX_SPEED_66:
 			bus->speed = e1000_bus_speed_66;
+			break;
 		case E1000_STATUS_PCIX_SPEED_100:
 			bus->speed = e1000_bus_speed_100;
+			break;
 		case E1000_STATUS_PCIX_SPEED_133:
 			bus->speed = e1000_bus_speed_133;
+			break;
 		default:
 			bus->speed = e1000_bus_speed_reserved;
 			break;
@@ -207,7 +210,9 @@ e1000_init_rx_addrs_generic(struct e1000_hw *hw, u16 rar_count)
 	DEBUGOUT1("Clearing RAR[1-%u]\n", rar_count-1);
 	for (i = 1; i < rar_count; i++) {
 		E1000_WRITE_REG_ARRAY(hw, RA, (i << 1), 0);
+		E1000_WRITE_FLUSH(hw);
 		E1000_WRITE_REG_ARRAY(hw, RA, ((i << 1) + 1), 0);
+		E1000_WRITE_FLUSH(hw);
 	}
 }
 
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 7918346..25840a3 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -35,7 +35,7 @@ static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-#define DRV_VERSION "7.4.16-m2"DRIVERNAPI
+#define DRV_VERSION "7.4.19-m2"DRIVERNAPI
 char e1000_driver_version[] = DRV_VERSION;
 static char e1000_copyright[] = "Copyright (c) 1999-2007 Intel Corporation.";
 
@@ -2254,12 +2254,14 @@ e1000_clean_rx_ring(struct e1000_adapter *adapter,
 	/* Free all the Rx ring sk_buffs */
 	for (i = 0; i < rx_ring->count; i++) {
 		buffer_info = &rx_ring->buffer_info[i];
-		if (buffer_info->skb) {
+		if (buffer_info->dma) {
 			pci_unmap_single(pdev,
 					 buffer_info->dma,
 					 buffer_info->length,
 					 PCI_DMA_FROMDEVICE);
-
+			buffer_info->dma = 0;
+		}
+		if (buffer_info->skb) {
 			dev_kfree_skb(buffer_info->skb);
 			buffer_info->skb = NULL;
 		}
@@ -2429,7 +2431,7 @@ e1000_set_multi(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	struct e1000_mac_info *mac = &hw->mac;
 	struct dev_mc_list *mc_ptr;
-	u8  mta_list[512];  /* Largest MTA size is 4096 bits */
+	u8  *mta_list;
 	u32 rctl;
 	int i;
 
@@ -2453,16 +2455,24 @@ e1000_set_multi(struct net_device *netdev)
 	if (hw->mac.type == e1000_82542)
 		e1000_enter_82542_rst(adapter);
 
+	mta_list = kmalloc(netdev->mc_count * 6, GFP_ATOMIC);
+	if (!mta_list)
+		return;
+
 	/* The shared function expects a packed array of only addresses. */
 	mc_ptr = netdev->mc_list;
 
-	for (i = 0; mc_ptr; mc_ptr = mc_ptr->next) {
-		memcpy(&mta_list[i*6], mc_ptr->dmi_addr, 6);
-		i++;
+	for (i = 0; i < netdev->mc_count; i++) {
+		if (!mc_ptr)
+			break;
+		memcpy(mta_list + (i*ETH_ALEN), mc_ptr->dmi_addr, ETH_ALEN);
+		mc_ptr = mc_ptr->next;
 	}
 
 	e1000_mc_addr_list_update(hw, mta_list, i, 1, mac->rar_entry_count);
 
+	kfree(mta_list);
+
 	if (hw->mac.type == e1000_82542)
 		e1000_leave_82542_rst(adapter);
 }
@@ -3530,7 +3540,7 @@ e1000_change_mtu(struct net_device *netdev, int new_mtu)
 		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
 
 	/* adjust allocation if LPE protects us, and we aren't using SBP */
-	if (!e1000_tbi_compatibility_enabled_82543(&adapter->hw) &&
+	if (!e1000_tbi_sbp_enabled_82543(&adapter->hw) &&
 	    ((max_frame == ETH_FRAME_LEN + ETHERNET_FCS_SIZE) ||
 	     (max_frame == MAXIMUM_ETHERNET_VLAN_SIZE)))
 		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
@@ -3882,7 +3892,7 @@ e1000_intr(int irq, void *data)
 
 	for (i = 0; i < E1000_MAX_INTR; i++)
 		if (unlikely(!adapter->clean_rx(adapter, adapter->rx_ring) &
-		   !e1000_clean_tx_irq(adapter, adapter->tx_ring)))
+		   e1000_clean_tx_irq(adapter, adapter->tx_ring)))
 			break;
 
 	if (likely(adapter->itr_setting & 3))
@@ -4166,6 +4176,7 @@ e1000_clean_rx_irq(struct e1000_adapter *adapter,
 		                 buffer_info->dma,
 		                 buffer_info->length,
 		                 PCI_DMA_FROMDEVICE);
+		buffer_info->dma = 0;
 
 		length = le16_to_cpu(rx_desc->length);
 
@@ -4333,6 +4344,7 @@ e1000_clean_rx_irq_ps(struct e1000_adapter *adapter,
 		pci_unmap_single(pdev, buffer_info->dma,
 				 buffer_info->length,
 				 PCI_DMA_FROMDEVICE);
+		buffer_info->dma = 0;
 
 		if (unlikely(!(staterr & E1000_RXD_STAT_EOP))) {
 			E1000_DBG("%s: Packet Split buffers didn't pick up"
@@ -4548,6 +4560,7 @@ map_skb:
 			pci_unmap_single(pdev, buffer_info->dma,
 					 adapter->rx_buffer_len,
 					 PCI_DMA_FROMDEVICE);
+			buffer_info->dma = 0;
 
 			break; /* while !buffer_info->skb */
 		}
diff --git a/drivers/net/e1000/e1000_manage.c b/drivers/net/e1000/e1000_manage.c
index 076fff7..324af04 100644
--- a/drivers/net/e1000/e1000_manage.c
+++ b/drivers/net/e1000/e1000_manage.c
@@ -208,23 +208,27 @@ e1000_mng_write_dhcp_info_generic(struct e1000_hw * hw, u8 *buffer, u16 length)
 	hdr.reserved2 = 0;
 	hdr.checksum = 0;
 
+	/* Enable the host interface */
 	ret_val = e1000_mng_enable_host_if(hw);
-	if (ret_val == E1000_SUCCESS) {
-		ret_val = e1000_mng_host_if_write(hw,
-		                                  buffer,
-		                                  length,
-		                                  sizeof(hdr),
-		                                  &(hdr.checksum));
-		if (ret_val == E1000_SUCCESS) {
-			ret_val = e1000_mng_write_cmd_header(hw, &hdr);
-			if (ret_val == E1000_SUCCESS) {
-				/* Tell the ARC a new command is pending. */
-				hicr = E1000_READ_REG(hw, HICR);
-				E1000_WRITE_REG(hw, HICR, hicr | E1000_HICR_C);
-			}
-		}
-	}
+	if (ret_val)
+		goto out;
+
+	/* Populate the host interface with the contents of "buffer". */
+	ret_val = e1000_mng_host_if_write(hw, buffer, length,
+	                                  sizeof(hdr), &(hdr.checksum));
+	if (ret_val)
+		goto out;
 
+	/* Write the manageability command header */
+	ret_val = e1000_mng_write_cmd_header(hw, &hdr);
+	if (ret_val)
+		goto out;
+
+	/* Tell the ARC a new command is pending. */
+	hicr = E1000_READ_REG(hw, HICR);
+	E1000_WRITE_REG(hw, HICR, hicr | E1000_HICR_C);
+
+out:
 	return ret_val;
 }
 
@@ -252,10 +256,7 @@ e1000_mng_write_cmd_header_generic(struct e1000_hw * hw,
 	length >>= 2;
 	/* Write the relevant command block into the ram area. */
 	for (i = 0; i < length; i++) {
-		E1000_WRITE_REG_ARRAY_DWORD(hw,
-		                            HOST_IF,
-		                            i,
-		                            *((u32 *) hdr + i));
+		E1000_WRITE_REG_ARRAY_DWORD(hw, HOST_IF, i, *((u32 *) hdr + i));
 		E1000_WRITE_FLUSH(hw);
 	}
 
diff --git a/drivers/net/e1000/e1000_nvm.c b/drivers/net/e1000/e1000_nvm.c
index b95d275..9dd63fe 100644
--- a/drivers/net/e1000/e1000_nvm.c
+++ b/drivers/net/e1000/e1000_nvm.c
@@ -518,8 +518,7 @@ e1000_read_nvm_eerd(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
 		if (ret_val)
 			break;
 
-		data[i] = (E1000_READ_REG(hw, EERD) >>
-				E1000_NVM_RW_REG_DATA);
+		data[i] = (E1000_READ_REG(hw, EERD) >> E1000_NVM_RW_REG_DATA);
 	}
 
 out:
diff --git a/drivers/net/e1000/e1000_osdep.h b/drivers/net/e1000/e1000_osdep.h
index 9f48f45..1f5612c 100644
--- a/drivers/net/e1000/e1000_osdep.h
+++ b/drivers/net/e1000/e1000_osdep.h
@@ -58,7 +58,7 @@ typedef enum {
 #define DEBUGOUT1(S, A...)
 #endif
 
-#define DEBUGFUNC(F) DEBUGOUT(F)
+#define DEBUGFUNC(F) DEBUGOUT(F "\n")
 #define DEBUGOUT2 DEBUGOUT1
 #define DEBUGOUT3 DEBUGOUT2
 #define DEBUGOUT7 DEBUGOUT3
diff --git a/drivers/net/e1000/e1000_phy.c b/drivers/net/e1000/e1000_phy.c
index 1f2130a..3aa2a90 100644
--- a/drivers/net/e1000/e1000_phy.c
+++ b/drivers/net/e1000/e1000_phy.c
@@ -998,7 +998,13 @@ e1000_phy_force_speed_duplex_igp(struct e1000_hw *hw)
 
 	DEBUGFUNC("e1000_phy_force_speed_duplex_igp");
 
-	ret_val = e1000_phy_force_speed_duplex_setup(hw);
+	ret_val = e1000_read_phy_reg(hw, PHY_CONTROL, &phy_data);
+	if (ret_val)
+		goto out;
+
+	e1000_phy_force_speed_duplex_setup(hw, &phy_data);
+
+	ret_val = e1000_write_phy_reg(hw, PHY_CONTROL, phy_data);
 	if (ret_val)
 		goto out;
 
@@ -1067,10 +1073,6 @@ e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 
 	DEBUGFUNC("e1000_phy_force_speed_duplex_m88");
 
-	ret_val = e1000_phy_force_speed_duplex_setup(hw);
-	if (ret_val)
-		goto out;
-
 	/* Clear Auto-Crossover to force MDI manually.  M88E1000 requires MDI
 	 * forced whenever speed and duplex are forced.
 	 */
@@ -1085,8 +1087,16 @@ e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 
 	DEBUGOUT1("M88E1000 PSCR: %X\n", phy_data);
 
+	ret_val = e1000_read_phy_reg(hw, PHY_CONTROL, &phy_data);
+	if (ret_val)
+		goto out;
+
+	e1000_phy_force_speed_duplex_setup(hw, &phy_data);
+
 	/* Reset the phy to commit changes. */
-	ret_val = e1000_phy_commit(hw);
+	phy_data |= MII_CR_RESET;
+
+	ret_val = e1000_write_phy_reg(hw, PHY_CONTROL, phy_data);
 	if (ret_val)
 		goto out;
 
@@ -1155,19 +1165,20 @@ out:
 /**
  *  e1000_phy_force_speed_duplex_setup - Configure forced PHY speed/duplex
  *  @hw - pointer to the HW structure
+ *  @phy_ctrl - pointer to current value of PHY_CONTROL
  *
  *  Forces speed and duplex on the PHY by doing the following: disable flow
  *  control, force speed/duplex on the MAC, disable auto speed detection,
  *  disable auto-negotiation, configure duplex, configure speed, configure
- *  the collision distance, write configuration to CTRL and PHY registers.
+ *  the collision distance, write configuration to CTRL register.  The
+ *  caller must write to the PHY_CONTROL register for these settings to
+ *  take affect.
  **/
-s32
-e1000_phy_force_speed_duplex_setup(struct e1000_hw *hw)
+void
+e1000_phy_force_speed_duplex_setup(struct e1000_hw *hw, u16 *phy_ctrl)
 {
 	struct e1000_mac_info *mac = &hw->mac;
-	s32  ret_val;
 	u32 ctrl;
-	u16 phy_ctrl;
 
 	DEBUGFUNC("e1000_phy_force_speed_duplex_setup");
 
@@ -1182,47 +1193,36 @@ e1000_phy_force_speed_duplex_setup(struct e1000_hw *hw)
 	/* Disable Auto Speed Detection */
 	ctrl &= ~E1000_CTRL_ASDE;
 
-	ret_val = e1000_read_phy_reg(hw, PHY_CONTROL, &phy_ctrl);
-	if (ret_val)
-		goto out;
-
 	/* Disable autoneg on the phy */
-	phy_ctrl &= ~MII_CR_AUTO_NEG_EN;
+	*phy_ctrl &= ~MII_CR_AUTO_NEG_EN;
 
 	/* Forcing Full or Half Duplex? */
 	if (mac->forced_speed_duplex & E1000_ALL_HALF_DUPLEX) {
 		ctrl &= ~E1000_CTRL_FD;
-		phy_ctrl &= ~MII_CR_FULL_DUPLEX;
+		*phy_ctrl &= ~MII_CR_FULL_DUPLEX;
 		DEBUGOUT("Half Duplex\n");
 	} else {
 		ctrl |= E1000_CTRL_FD;
-		phy_ctrl |= MII_CR_FULL_DUPLEX;
+		*phy_ctrl |= MII_CR_FULL_DUPLEX;
 		DEBUGOUT("Full Duplex\n");
 	}
 
 	/* Forcing 10mb or 100mb? */
 	if (mac->forced_speed_duplex & E1000_ALL_100_SPEED) {
 		ctrl |= E1000_CTRL_SPD_100;
-		phy_ctrl |= MII_CR_SPEED_100;
-		phy_ctrl &= ~(MII_CR_SPEED_1000 | MII_CR_SPEED_10);
+		*phy_ctrl |= MII_CR_SPEED_100;
+		*phy_ctrl &= ~(MII_CR_SPEED_1000 | MII_CR_SPEED_10);
 		DEBUGOUT("Forcing 100mb\n");
 	} else {
 		ctrl &= ~(E1000_CTRL_SPD_1000 | E1000_CTRL_SPD_100);
-		phy_ctrl |= MII_CR_SPEED_10;
-		phy_ctrl &= ~(MII_CR_SPEED_1000 | MII_CR_SPEED_100);
+		*phy_ctrl |= MII_CR_SPEED_10;
+		*phy_ctrl &= ~(MII_CR_SPEED_1000 | MII_CR_SPEED_100);
 		DEBUGOUT("Forcing 10mb\n");
 	}
 
 	e1000_config_collision_dist_generic(hw);
 
 	E1000_WRITE_REG(hw, CTRL, ctrl);
-
-	ret_val = e1000_write_phy_reg(hw, PHY_CONTROL, phy_ctrl);
-	if (ret_val)
-		goto out;
-
-out:
-	return ret_val;
 }
 
 /**
diff --git a/drivers/net/e1000/e1000_phy.h b/drivers/net/e1000/e1000_phy.h
index f02b0a5..55909ec 100644
--- a/drivers/net/e1000/e1000_phy.h
+++ b/drivers/net/e1000/e1000_phy.h
@@ -44,38 +44,38 @@ typedef enum {
 
 #include "e1000_api.h"
 
-s32 e1000_check_downshift_generic(struct e1000_hw *hw);
-s32 e1000_check_polarity_m88(struct e1000_hw *hw);
-s32 e1000_check_polarity_igp(struct e1000_hw *hw);
-s32 e1000_check_reset_block_generic(struct e1000_hw *hw);
-s32 e1000_copper_link_autoneg(struct e1000_hw *hw);
-s32 e1000_copper_link_setup_igp(struct e1000_hw *hw);
-s32 e1000_copper_link_setup_m88(struct e1000_hw *hw);
-s32 e1000_phy_force_speed_duplex_igp(struct e1000_hw *hw);
-s32 e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw);
-s32 e1000_get_cable_length_m88(struct e1000_hw *hw);
-s32 e1000_get_cable_length_igp_2(struct e1000_hw *hw);
-s32 e1000_get_cfg_done_generic(struct e1000_hw *hw);
-s32 e1000_get_phy_id(struct e1000_hw *hw);
-s32 e1000_get_phy_info_igp(struct e1000_hw *hw);
-s32 e1000_get_phy_info_m88(struct e1000_hw *hw);
-s32 e1000_phy_sw_reset_generic(struct e1000_hw *hw);
-s32 e1000_phy_force_speed_duplex_setup(struct e1000_hw *hw);
-s32 e1000_phy_hw_reset_generic(struct e1000_hw *hw);
-s32 e1000_phy_reset_dsp_generic(struct e1000_hw *hw);
-s32 e1000_phy_setup_autoneg(struct e1000_hw *hw);
-s32 e1000_read_kmrn_reg_generic(struct e1000_hw *hw, u32 offset, u16 *data);
-s32 e1000_read_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 *data);
-s32 e1000_read_phy_reg_m88(struct e1000_hw *hw, u32 offset, u16 *data);
-s32 e1000_set_d3_lplu_state_generic(struct e1000_hw *hw, boolean_t active);
-s32 e1000_setup_copper_link_generic(struct e1000_hw *hw);
-s32 e1000_wait_autoneg_generic(struct e1000_hw *hw);
-s32 e1000_write_kmrn_reg_generic(struct e1000_hw *hw, u32 offset, u16 data);
-s32 e1000_write_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 data);
-s32 e1000_write_phy_reg_m88(struct e1000_hw *hw, u32 offset, u16 data);
-s32 e1000_phy_reset_dsp(struct e1000_hw *hw);
-s32 e1000_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
-                               u32 usec_interval, boolean_t *success);
+s32  e1000_check_downshift_generic(struct e1000_hw *hw);
+s32  e1000_check_polarity_m88(struct e1000_hw *hw);
+s32  e1000_check_polarity_igp(struct e1000_hw *hw);
+s32  e1000_check_reset_block_generic(struct e1000_hw *hw);
+s32  e1000_copper_link_autoneg(struct e1000_hw *hw);
+s32  e1000_copper_link_setup_igp(struct e1000_hw *hw);
+s32  e1000_copper_link_setup_m88(struct e1000_hw *hw);
+s32  e1000_phy_force_speed_duplex_igp(struct e1000_hw *hw);
+s32  e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw);
+s32  e1000_get_cable_length_m88(struct e1000_hw *hw);
+s32  e1000_get_cable_length_igp_2(struct e1000_hw *hw);
+s32  e1000_get_cfg_done_generic(struct e1000_hw *hw);
+s32  e1000_get_phy_id(struct e1000_hw *hw);
+s32  e1000_get_phy_info_igp(struct e1000_hw *hw);
+s32  e1000_get_phy_info_m88(struct e1000_hw *hw);
+s32  e1000_phy_sw_reset_generic(struct e1000_hw *hw);
+void e1000_phy_force_speed_duplex_setup(struct e1000_hw *hw, u16 *phy_ctrl);
+s32  e1000_phy_hw_reset_generic(struct e1000_hw *hw);
+s32  e1000_phy_reset_dsp_generic(struct e1000_hw *hw);
+s32  e1000_phy_setup_autoneg(struct e1000_hw *hw);
+s32  e1000_read_kmrn_reg_generic(struct e1000_hw *hw, u32 offset, u16 *data);
+s32  e1000_read_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 *data);
+s32  e1000_read_phy_reg_m88(struct e1000_hw *hw, u32 offset, u16 *data);
+s32  e1000_set_d3_lplu_state_generic(struct e1000_hw *hw, boolean_t active);
+s32  e1000_setup_copper_link_generic(struct e1000_hw *hw);
+s32  e1000_wait_autoneg_generic(struct e1000_hw *hw);
+s32  e1000_write_kmrn_reg_generic(struct e1000_hw *hw, u32 offset, u16 data);
+s32  e1000_write_phy_reg_igp(struct e1000_hw *hw, u32 offset, u16 data);
+s32  e1000_write_phy_reg_m88(struct e1000_hw *hw, u32 offset, u16 data);
+s32  e1000_phy_reset_dsp(struct e1000_hw *hw);
+s32  e1000_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
+                                u32 usec_interval, boolean_t *success);
 
 
 
