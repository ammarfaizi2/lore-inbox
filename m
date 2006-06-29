Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWF2Epm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWF2Epm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWF2Epm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:45:42 -0400
Received: from xenotime.net ([66.160.160.81]:39091 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751731AbWF2Epl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:45:41 -0400
Date: Wed, 28 Jun 2006 21:48:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, akpm <akpm@osdl.org>
Subject: [PATCH 1/2] MTD: fix all kernel-doc warnings
Message-Id: <20060628214827.c8a189c6.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix all kernel-doc warnings in MTD headers and source files:
- add some missing struct fields;
- correct some function parameter names;
- use kernel-doc format for function doc. headers;
- nand_ecc.c contains only exported interfaces, no internal ones;


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/mtdnand.tmpl |    4 +++-
 drivers/mtd/nand/nand_base.c       |   16 ++++++++--------
 drivers/mtd/nand/nand_ecc.c        |    3 +--
 include/linux/mtd/nand.h           |   13 ++++++++++---
 4 files changed, 22 insertions(+), 14 deletions(-)

--- linux-2617-g13.orig/include/linux/mtd/nand.h
+++ linux-2617-g13/include/linux/mtd/nand.h
@@ -202,7 +202,7 @@ typedef enum {
 struct nand_chip;
 
 /**
- * struct nand_hw_control - Control structure for hardware controller (e.g ECC generator) shared among independend devices
+ * struct nand_hw_control - Control structure for hardware controller (e.g ECC generator) shared among independent devices
  * @lock:               protection lock
  * @active:		the mtd device which holds the controller currently
  * @wq:			wait queue to sleep on if a NAND operation is in progress
@@ -223,12 +223,15 @@ struct nand_hw_control {
  * @total:	total number of ecc bytes per page
  * @prepad:	padding information for syndrome based ecc generators
  * @postpad:	padding information for syndrome based ecc generators
+ * @layout:	ECC layout control struct pointer
  * @hwctl:	function to control hardware ecc generator. Must only
  *		be provided if an hardware ECC is available
  * @calculate:	function for ecc calculation or readback from ecc hardware
  * @correct:	function for ecc correction, matching to ecc generator (sw/hw)
  * @read_page:	function to read a page according to the ecc generator requirements
  * @write_page:	function to write a page according to the ecc generator requirements
+ * @read_oob:	function to read chip OOB data
+ * @write_oob:	function to write chip OOB data
  */
 struct nand_ecc_ctrl {
 	nand_ecc_modes_t	mode;
@@ -300,11 +303,15 @@ struct nand_buffers {
  * @cmdfunc:		[REPLACEABLE] hardwarespecific function for writing commands to the chip
  * @waitfunc:		[REPLACEABLE] hardwarespecific function for wait on ready
  * @ecc:		[BOARDSPECIFIC] ecc control ctructure
+ * @buffers:		buffer structure for read/write
+ * @hwcontrol:		platform-specific hardware control structure
+ * @ops:		oob operation operands
  * @erase_cmd:		[INTERN] erase command write function, selectable due to AND support
  * @scan_bbt:		[REPLACEABLE] function to scan bad block table
  * @chip_delay:		[BOARDSPECIFIC] chip dependent delay for transfering data from array to read regs (tR)
  * @wq:			[INTERN] wait queue to sleep on if a NAND operation is in progress
  * @state:		[INTERN] the current state of the NAND device
+ * @oob_poi:		poison value buffer
  * @page_shift:		[INTERN] number of address bits in a page (column address bits)
  * @phys_erase_shift:	[INTERN] number of address bits in a physical eraseblock
  * @bbt_erase_shift:	[INTERN] number of address bits in a bbt entry
@@ -521,7 +528,7 @@ extern int nand_do_read(struct mtd_info 
  * struct platform_nand_chip - chip level device structure
  *
  * @nr_chips:		max. number of chips to scan for
- * @chip_offs:		chip number offset
+ * @chip_offset:	chip number offset
  * @nr_partitions:	number of partitions pointed to by partitions (or zero)
  * @partitions:		mtd partition list
  * @chip_delay:		R/B delay value in us
@@ -546,7 +553,7 @@ struct platform_nand_chip {
  * @hwcontrol:		platform specific hardware control structure
  * @dev_ready:		platform specific function to read ready/busy pin
  * @select_chip:	platform specific chip select function
- * @priv_data:		private data to transport driver specific settings
+ * @priv:		private data to transport driver specific settings
  *
  * All fields are optional and depend on the hardware driver requirements
  */
--- linux-2617-g13.orig/drivers/mtd/nand/nand_base.c
+++ linux-2617-g13/drivers/mtd/nand/nand_base.c
@@ -155,7 +155,7 @@ static u16 nand_read_word(struct mtd_inf
 /**
  * nand_select_chip - [DEFAULT] control CE line
  * @mtd:	MTD device structure
- * @chip:	chipnumber to select, -1 for deselect
+ * @chipnr:	chipnumber to select, -1 for deselect
  *
  * Default select function for 1 chip devices.
  */
@@ -542,7 +542,6 @@ static void nand_command(struct mtd_info
  * Send command to NAND device. This is the version for the new large page
  * devices We dont have the separate regions as we have in the small page
  * devices.  We must emulate NAND_CMD_READOOB to keep the code compatible.
- *
  */
 static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 			    int column, int page_addr)
@@ -656,7 +655,7 @@ static void nand_command_lp(struct mtd_i
 
 /**
  * nand_get_device - [GENERIC] Get chip for selected access
- * @this:	the nand chip descriptor
+ * @chip:	the nand chip descriptor
  * @mtd:	MTD device structure
  * @new_state:	the state which is requested
  *
@@ -696,13 +695,12 @@ nand_get_device(struct nand_chip *chip, 
 /**
  * nand_wait - [DEFAULT]  wait until the command is done
  * @mtd:	MTD device structure
- * @this:	NAND chip structure
+ * @chip:	NAND chip structure
  *
  * Wait for command done. This applies to erase and program only
  * Erase can take up to 400ms and program up to 20ms according to
  * general NAND and SmartMedia specs
- *
-*/
+ */
 static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
 
@@ -896,6 +894,7 @@ static int nand_read_page_syndrome(struc
 /**
  * nand_transfer_oob - [Internal] Transfer oob to client buffer
  * @chip:	nand chip structure
+ * @oob:	oob destination address
  * @ops:	oob ops structure
  */
 static uint8_t *nand_transfer_oob(struct nand_chip *chip, uint8_t *oob,
@@ -946,6 +945,7 @@ static uint8_t *nand_transfer_oob(struct
  *
  * @mtd:	MTD device structure
  * @from:	offset to read from
+ * @ops:	oob ops structure
  *
  * Internal function. Called with chip held.
  */
@@ -1760,7 +1760,7 @@ static int nand_do_write_oob(struct mtd_
 /**
  * nand_write_oob - [MTD Interface] NAND write data and/or out-of-band
  * @mtd:	MTD device structure
- * @from:	offset to read from
+ * @to:		offset to write to
  * @ops:	oob operation description structure
  */
 static int nand_write_oob(struct mtd_info *mtd, loff_t to,
@@ -2055,7 +2055,7 @@ static void nand_sync(struct mtd_info *m
 /**
  * nand_block_isbad - [MTD Interface] Check if block at offset is bad
  * @mtd:	MTD device structure
- * @ofs:	offset relative to mtd start
+ * @offs:	offset relative to mtd start
  */
 static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
 {
--- linux-2617-g13.orig/drivers/mtd/nand/nand_ecc.c
+++ linux-2617-g13/drivers/mtd/nand/nand_ecc.c
@@ -65,8 +65,7 @@ static const u_char nand_ecc_precalc_tab
 };
 
 /**
- * nand_calculate_ecc - [NAND Interface] Calculate 3 byte ECC code
- *			for 256 byte block
+ * nand_calculate_ecc - [NAND Interface] Calculate 3-byte ECC for 256-byte block
  * @mtd:	MTD block structure
  * @dat:	raw data
  * @ecc_code:	buffer for ECC
--- linux-2617-g13.orig/Documentation/DocBook/mtdnand.tmpl
+++ linux-2617-g13/Documentation/DocBook/mtdnand.tmpl
@@ -1295,7 +1295,9 @@ in this page</entry>
      </para>
 !Idrivers/mtd/nand/nand_base.c
 !Idrivers/mtd/nand/nand_bbt.c
-!Idrivers/mtd/nand/nand_ecc.c
+<!-- No internal functions for kernel-doc:
+X!Idrivers/mtd/nand/nand_ecc.c
+-->
   </chapter>
 
   <chapter id="credits">


---
