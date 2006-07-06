Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWGFUhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWGFUhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWGFUhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:37:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20485 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750829AbWGFUhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:37:36 -0400
Date: Thu, 6 Jul 2006 22:37:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, cramerj@intel.com, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
       auke-jan.h.kok@intel.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [-mm patch] drivers/net/e1000/: possible cleanups
Message-ID: <20060706203736.GS26941@stusta.de>
References: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 03:03:55AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm5:
>...
>  git-e1000.patch
>...
>  git trees.
>...

This patch contains the following possible cleanups:
- make needlessly global functions static
- #if 0 the following unused global functions:
  - e1000_hw.c: e1000_mc_addr_list_update()
  - e1000_hw.c: e1000_read_reg_io()
  - e1000_hw.c: e1000_enable_pciex_master()
  - e1000_hw.c: e1000_ife_disable_dynamic_power_down()
  - e1000_hw.c: e1000_ife_enable_dynamic_power_down()
  - e1000_hw.c: e1000_write_ich8_word()
  - e1000_hw.c: e1000_duplex_reversal()
  - e1000_main.c: e1000_io_read()

Please review which of these changes do make sense and which do 
conflict with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/e1000/e1000_hw.c   |   89 ++++++++++++++++++++++++---------
 drivers/net/e1000/e1000_hw.h   |   32 -----------
 drivers/net/e1000/e1000_main.c |    2 
 3 files changed, 67 insertions(+), 56 deletions(-)

--- linux-2.6.17-mm6-full/drivers/net/e1000/e1000_hw.h.old	2006-07-06 21:17:20.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/net/e1000/e1000_hw.h	2006-07-06 21:57:18.000000000 +0200
@@ -323,13 +323,8 @@
 int32_t e1000_phy_hw_reset(struct e1000_hw *hw);
 int32_t e1000_phy_reset(struct e1000_hw *hw);
 void e1000_phy_powerdown_workaround(struct e1000_hw *hw);
-int32_t e1000_kumeran_lock_loss_workaround(struct e1000_hw *hw);
-int32_t e1000_init_lcd_from_nvm_config_region(struct e1000_hw *hw, uint32_t cnf_base_addr, uint32_t cnf_size);
-int32_t e1000_init_lcd_from_nvm(struct e1000_hw *hw);
 int32_t e1000_phy_get_info(struct e1000_hw *hw, struct e1000_phy_info *phy_info);
 int32_t e1000_validate_mdi_setting(struct e1000_hw *hw);
-int32_t e1000_read_kmrn_reg(struct e1000_hw *hw, uint32_t reg_addr, uint16_t *data);
-int32_t e1000_write_kmrn_reg(struct e1000_hw *hw, uint32_t reg_addr, uint16_t data);
 
 /* EEPROM Functions */
 int32_t e1000_init_eeprom_params(struct e1000_hw *hw);
@@ -400,13 +395,8 @@
 int32_t e1000_write_eeprom(struct e1000_hw *hw, uint16_t reg, uint16_t words, uint16_t *data);
 int32_t e1000_read_part_num(struct e1000_hw *hw, uint32_t * part_num);
 int32_t e1000_read_mac_addr(struct e1000_hw * hw);
-int32_t e1000_swfw_sync_acquire(struct e1000_hw *hw, uint16_t mask);
-void e1000_swfw_sync_release(struct e1000_hw *hw, uint16_t mask);
-void e1000_release_software_flag(struct e1000_hw *hw);
-int32_t e1000_get_software_flag(struct e1000_hw *hw);
 
 /* Filters (multicast, vlan, receive) */
-void e1000_mc_addr_list_update(struct e1000_hw *hw, uint8_t * mc_addr_list, uint32_t mc_addr_count, uint32_t pad, uint32_t rar_used_count);
 uint32_t e1000_hash_mc_addr(struct e1000_hw *hw, uint8_t * mc_addr);
 void e1000_mta_set(struct e1000_hw *hw, uint32_t hash_value);
 void e1000_rar_set(struct e1000_hw *hw, uint8_t * mc_addr, uint32_t rar_index);
@@ -431,31 +421,9 @@
 void e1000_read_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 void e1000_write_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 /* Port I/O is only supported on 82544 and newer */
-uint32_t e1000_io_read(struct e1000_hw *hw, unsigned long port);
-uint32_t e1000_read_reg_io(struct e1000_hw *hw, uint32_t offset);
 void e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value);
-void e1000_enable_pciex_master(struct e1000_hw *hw);
 int32_t e1000_disable_pciex_master(struct e1000_hw *hw);
-int32_t e1000_get_software_semaphore(struct e1000_hw *hw);
-void e1000_release_software_semaphore(struct e1000_hw *hw);
 int32_t e1000_check_phy_reset_block(struct e1000_hw *hw);
-int32_t e1000_set_pci_ex_no_snoop(struct e1000_hw *hw, uint32_t no_snoop);
-
-int32_t e1000_read_ich8_byte(struct e1000_hw *hw, uint32_t index,
-                             uint8_t *data);
-int32_t e1000_verify_write_ich8_byte(struct e1000_hw *hw, uint32_t index,
-                                     uint8_t byte);
-int32_t e1000_write_ich8_byte(struct e1000_hw *hw, uint32_t index,
-                              uint8_t byte);
-int32_t e1000_read_ich8_word(struct e1000_hw *hw, uint32_t index,
-                             uint16_t *data);
-int32_t e1000_read_ich8_data(struct e1000_hw *hw, uint32_t index,
-                             uint32_t size, uint16_t *data);
-int32_t e1000_read_eeprom_ich8(struct e1000_hw *hw, uint16_t offset,
-                               uint16_t words, uint16_t *data);
-int32_t e1000_write_eeprom_ich8(struct e1000_hw *hw, uint16_t offset,
-                                uint16_t words, uint16_t *data);
-int32_t e1000_erase_ich8_4k_segment(struct e1000_hw *hw, uint32_t segment);
 
 
 #define E1000_READ_REG_IO(a, reg) \
--- linux-2.6.17-mm6-full/drivers/net/e1000/e1000_hw.c.old	2006-07-06 21:16:17.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/net/e1000/e1000_hw.c	2006-07-06 21:39:03.000000000 +0200
@@ -105,6 +105,33 @@
                                                uint16_t duplex);
 static int32_t e1000_configure_kmrn_for_1000(struct e1000_hw *hw);
 
+static int32_t e1000_erase_ich8_4k_segment(struct e1000_hw *hw,
+					   uint32_t segment);
+static int32_t e1000_get_software_flag(struct e1000_hw *hw);
+static int32_t e1000_get_software_semaphore(struct e1000_hw *hw);
+static int32_t e1000_init_lcd_from_nvm(struct e1000_hw *hw);
+static int32_t e1000_kumeran_lock_loss_workaround(struct e1000_hw *hw);
+static int32_t e1000_read_eeprom_ich8(struct e1000_hw *hw, uint16_t offset,
+				      uint16_t words, uint16_t *data);
+static int32_t e1000_read_ich8_byte(struct e1000_hw *hw, uint32_t index,
+				    uint8_t* data);
+static int32_t e1000_read_ich8_word(struct e1000_hw *hw, uint32_t index,
+				    uint16_t *data);
+static int32_t e1000_read_kmrn_reg(struct e1000_hw *hw, uint32_t reg_addr,
+				   uint16_t *data);
+static void e1000_release_software_flag(struct e1000_hw *hw);
+static void e1000_release_software_semaphore(struct e1000_hw *hw);
+static int32_t e1000_set_pci_ex_no_snoop(struct e1000_hw *hw,
+					 uint32_t no_snoop);
+static int32_t e1000_verify_write_ich8_byte(struct e1000_hw *hw,
+					    uint32_t index, uint8_t byte);
+static int32_t e1000_write_eeprom_ich8(struct e1000_hw *hw, uint16_t offset,
+				       uint16_t words, uint16_t *data);
+static int32_t e1000_write_ich8_byte(struct e1000_hw *hw, uint32_t index,
+				     uint8_t data);
+static int32_t e1000_write_kmrn_reg(struct e1000_hw *hw, uint32_t reg_addr,
+				    uint16_t data);
+
 /* IGP cable length table */
 static const
 uint16_t e1000_igp_cable_length_table[IGP01E1000_AGC_LENGTH_TABLE_SIZE] =
@@ -3233,7 +3260,7 @@
     return data;
 }
 
-int32_t
+static int32_t
 e1000_swfw_sync_acquire(struct e1000_hw *hw, uint16_t mask)
 {
     uint32_t swfw_sync = 0;
@@ -3277,7 +3304,7 @@
     return E1000_SUCCESS;
 }
 
-void
+static void
 e1000_swfw_sync_release(struct e1000_hw *hw, uint16_t mask)
 {
     uint32_t swfw_sync;
@@ -3575,7 +3602,7 @@
     return E1000_SUCCESS;
 }
 
-int32_t
+static int32_t
 e1000_read_kmrn_reg(struct e1000_hw *hw,
                     uint32_t reg_addr,
                     uint16_t *data)
@@ -3608,7 +3635,7 @@
     return E1000_SUCCESS;
 }
 
-int32_t
+static int32_t
 e1000_write_kmrn_reg(struct e1000_hw *hw,
                      uint32_t reg_addr,
                      uint16_t data)
@@ -3839,7 +3866,7 @@
 *
 * hw - struct containing variables accessed by shared code
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_kumeran_lock_loss_workaround(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -4086,7 +4113,7 @@
 * hw - Struct containing variables accessed by shared code
 * phy_info - PHY information structure
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_phy_ife_get_info(struct e1000_hw *hw,
                        struct e1000_phy_info *phy_info)
 {
@@ -5643,6 +5670,7 @@
  * for the first 15 multicast addresses, and hashes the rest into the
  * multicast table.
  *****************************************************************************/
+#if 0
 void
 e1000_mc_addr_list_update(struct e1000_hw *hw,
                           uint8_t *mc_addr_list,
@@ -5719,6 +5747,7 @@
     }
     DEBUGOUT("MC Update Complete\n");
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Hashes an address to determine its location in the multicast table
@@ -6587,6 +6616,7 @@
  * hw - Struct containing variables accessed by shared code
  * offset - offset to read from
  *****************************************************************************/
+#if 0
 uint32_t
 e1000_read_reg_io(struct e1000_hw *hw,
                   uint32_t offset)
@@ -6597,6 +6627,7 @@
     e1000_io_write(hw, io_addr, offset);
     return e1000_io_read(hw, io_data);
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Writes a value to one of the devices registers using port I/O (as opposed to
@@ -7909,6 +7940,7 @@
  * returns: - none.
  *
  ***************************************************************************/
+#if 0
 void
 e1000_enable_pciex_master(struct e1000_hw *hw)
 {
@@ -7923,6 +7955,7 @@
     ctrl &= ~E1000_CTRL_GIO_MASTER_DISABLE;
     E1000_WRITE_REG(hw, CTRL, ctrl);
 }
+#endif  /*  0  */
 
 /*******************************************************************************
  *
@@ -8148,7 +8181,7 @@
  *            E1000_SUCCESS at any other case.
  *
  ***************************************************************************/
-int32_t
+static int32_t
 e1000_get_software_semaphore(struct e1000_hw *hw)
 {
     int32_t timeout = hw->eeprom.word_size + 1;
@@ -8183,7 +8216,7 @@
  * hw: Struct containing variables accessed by shared code
  *
  ***************************************************************************/
-void
+static void
 e1000_release_software_semaphore(struct e1000_hw *hw)
 {
     uint32_t swsm;
@@ -8265,7 +8298,7 @@
  * returns: E1000_SUCCESS
  *
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_set_pci_ex_no_snoop(struct e1000_hw *hw, uint32_t no_snoop)
 {
     uint32_t gcr_reg = 0;
@@ -8306,7 +8339,7 @@
  * hw: Struct containing variables accessed by shared code
  *
  ***************************************************************************/
-int32_t
+static int32_t
 e1000_get_software_flag(struct e1000_hw *hw)
 {
     int32_t timeout = PHY_CFG_TIMEOUT;
@@ -8345,7 +8378,7 @@
  * hw: Struct containing variables accessed by shared code
  *
  ***************************************************************************/
-void
+static void
 e1000_release_software_flag(struct e1000_hw *hw)
 {
     uint32_t extcnf_ctrl;
@@ -8369,6 +8402,7 @@
  * hw: Struct containing variables accessed by shared code
  *
  ***************************************************************************/
+#if 0
 int32_t
 e1000_ife_disable_dynamic_power_down(struct e1000_hw *hw)
 {
@@ -8388,6 +8422,7 @@
 
     return ret_val;
 }
+#endif  /*  0  */
 
 /***************************************************************************
  *
@@ -8397,6 +8432,7 @@
  * hw: Struct containing variables accessed by shared code
  *
  ***************************************************************************/
+#if 0
 int32_t
 e1000_ife_enable_dynamic_power_down(struct e1000_hw *hw)
 {
@@ -8416,6 +8452,7 @@
 
     return ret_val;
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Reads a 16 bit word or words from the EEPROM using the ICH8's flash access
@@ -8426,7 +8463,7 @@
  * data - word read from the EEPROM
  * words - number of words to read
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_read_eeprom_ich8(struct e1000_hw *hw, uint16_t offset, uint16_t words,
                        uint16_t *data)
 {
@@ -8482,7 +8519,7 @@
  * words - number of words to write
  * data - words to write to the EEPROM
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_write_eeprom_ich8(struct e1000_hw *hw, uint16_t offset, uint16_t words,
                         uint16_t *data)
 {
@@ -8529,7 +8566,7 @@
  *
  * hw - The pointer to the hw structure
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_ich8_cycle_init(struct e1000_hw *hw)
 {
     union ich8_hws_flash_status hsfsts;
@@ -8596,7 +8633,7 @@
  *
  * hw - The pointer to the hw structure
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_ich8_flash_cycle(struct e1000_hw *hw, uint32_t timeout)
 {
     union ich8_hws_flash_ctrl hsflctl;
@@ -8631,7 +8668,7 @@
  * size - Size of data to read, 1=byte 2=word
  * data - Pointer to the word to store the value read.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_read_ich8_data(struct e1000_hw *hw, uint32_t index,
                      uint32_t size, uint16_t* data)
 {
@@ -8710,7 +8747,7 @@
  * size - Size of data to read, 1=byte 2=word
  * data - The byte(s) to write to the NVM.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_write_ich8_data(struct e1000_hw *hw, uint32_t index, uint32_t size,
                       uint16_t data)
 {
@@ -8785,7 +8822,7 @@
  * index - The index of the byte to read.
  * data - Pointer to a byte to store the value read.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_read_ich8_byte(struct e1000_hw *hw, uint32_t index, uint8_t* data)
 {
     int32_t status = E1000_SUCCESS;
@@ -8808,7 +8845,7 @@
  * index - The index of the byte to write.
  * byte - The byte to write to the NVM.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_verify_write_ich8_byte(struct e1000_hw *hw, uint32_t index, uint8_t byte)
 {
     int32_t error = E1000_SUCCESS;
@@ -8839,7 +8876,7 @@
  * index - The index of the byte to read.
  * data - The byte to write to the NVM.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_write_ich8_byte(struct e1000_hw *hw, uint32_t index, uint8_t data)
 {
     int32_t status = E1000_SUCCESS;
@@ -8857,7 +8894,7 @@
  * index - The starting byte index of the word to read.
  * data - Pointer to a word to store the value read.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_read_ich8_word(struct e1000_hw *hw, uint32_t index, uint16_t *data)
 {
     int32_t status = E1000_SUCCESS;
@@ -8872,6 +8909,7 @@
  * index - The starting byte index of the word to read.
  * data - The word to write to the NVM.
  *****************************************************************************/
+#if 0
 int32_t
 e1000_write_ich8_word(struct e1000_hw *hw, uint32_t index, uint16_t data)
 {
@@ -8879,6 +8917,7 @@
     status = e1000_write_ich8_data(hw, index, 2, data);
     return status;
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Erases the bank specified. Each bank is a 4k block. Segments are 0 based.
@@ -8887,7 +8926,7 @@
  * hw - pointer to e1000_hw structure
  * segment - 0 for first segment, 1 for second segment, etc.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_erase_ich8_4k_segment(struct e1000_hw *hw, uint32_t segment)
 {
     union ich8_hws_flash_status hsfsts;
@@ -8984,6 +9023,7 @@
  * hw: Struct containing variables accessed by shared code
  *
  *****************************************************************************/
+#if 0
 int32_t
 e1000_duplex_reversal(struct e1000_hw *hw)
 {
@@ -9012,8 +9052,9 @@
 
     return ret_val;
 }
+#endif  /*  0  */
 
-int32_t
+static int32_t
 e1000_init_lcd_from_nvm_config_region(struct e1000_hw *hw,
                                       uint32_t cnf_base_addr, uint32_t cnf_size)
 {
@@ -9047,7 +9088,7 @@
 }
 
 
-int32_t
+static int32_t
 e1000_init_lcd_from_nvm(struct e1000_hw *hw)
 {
     uint32_t reg_data, cnf_base_addr, cnf_size, ret_val, loop;
--- linux-2.6.17-mm6-full/drivers/net/e1000/e1000_main.c.old	2006-07-06 21:57:45.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/net/e1000/e1000_main.c	2006-07-06 21:58:01.000000000 +0200
@@ -4387,11 +4387,13 @@
 	pci_write_config_word(adapter->pdev, reg, *value);
 }
 
+#if 0
 uint32_t
 e1000_io_read(struct e1000_hw *hw, unsigned long port)
 {
 	return inl(port);
 }
+#endif  /*  0  */
 
 void
 e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value)

