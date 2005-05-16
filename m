Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVEPH0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVEPH0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 03:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEPH0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 03:26:11 -0400
Received: from mail0.lsil.com ([147.145.40.20]:38072 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261420AbVEPHJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:09:17 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CCE7D@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
Subject: [PATCH 2.6.12-rc4-mm1 4/4] megaraid_sas: updating the driver
Date: Mon, 16 May 2005 02:59:44 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 of 4:

Signed-off by: Sreenivas Bagalkote <sreenivas.bagalkote@lsil.com>

diff -Naurp linux-2.6.12-rc4-mm1.d/Documentation/scsi/ChangeLog.megaraid_sas
linux-2.6.12-rc4-mm1.e/Documentation/scsi/ChangeLog.megaraid_sas
--- linux-2.6.12-rc4-mm1.d/Documentation/scsi/ChangeLog.megaraid_sas
1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-mm1.e/Documentation/scsi/ChangeLog.megaraid_sas
2005-05-15 22:52:36.172599320 -0400
@@ -0,0 +1,39 @@
+Release Date	: Mon May 16 03:17:26 EDT 2005
+Released by	: Sreenivas Bagalkote (sreenivas.bagalkote@lsil.com)
+Current Version	: 00.00.01.02
+Older Version	: 00.00.01.00
+
+1.	Incorporates all the feedback received on SCSI mailing list from the
+	following people:
+
+	Matt Domsh (Matt_Domsch@dell.com)
+	---------------------------------
+	1.  Got rid of all the function prototypes. 
+	2.  Added comments for jargon like MFI, AEN.
+	3.  Fixed char dev and PCI pool leaks.
+	4.  Removed unnecessary prink messages.
+	5.  Coverted all uint32_t style to u32 style. 
+	6.  Many coding sytle issues.
+
+	Arjan van de Ven (arjan@infradead.org)
+	--------------------------------------
+	1.  Merged Kconfig.megaraid_sas into existing Kconfig.megaraid
+
+	Adrian Bunk (bunk@stusta.de)
+	----------------------------
+	1.  Reduced stack usage in megasas_init_mfi(), megasas_mgmt_ioctl(),
+	    megasas_mgmt_fw_ioctl() [Used Yum Ryan's patch]
+
+2.	Fixed a cicular reply queue handling bug that causes ABORT/RESET
+	cycle.
+
+3.	Fixed issues with SMP & STP handling.
+
+Release Date	: Fri Mar  4 21:06:57 EST 2005
+Released by	: Sreenivas Bagalkote (sreenivas.bagalkote@lsil.com)
+Current Version	: 00.00.01.00
+Older Version	: NA
+
+1.	Initial announcement to community - Module for LSI Logic's SAS based
+	RAID controllers.
+
diff -Naurp linux-2.6.12-rc4-mm1.d/drivers/scsi/Kconfig
linux-2.6.12-rc4-mm1.e/drivers/scsi/Kconfig
--- linux-2.6.12-rc4-mm1.d/drivers/scsi/Kconfig	2005-05-15
22:03:19.639060736 -0400
+++ linux-2.6.12-rc4-mm1.e/drivers/scsi/Kconfig	2005-05-15
22:13:52.431861608 -0400
@@ -418,7 +418,6 @@ config SCSI_IN2000
 	  module will be called in2000.
 
 source "drivers/scsi/megaraid/Kconfig.megaraid"
-source "drivers/scsi/megaraid/Kconfig.megaraid_sas"
 
 config SCSI_SATA
 	bool "Serial ATA (SATA) support"
diff -Naurp linux-2.6.12-rc4-mm1.d/drivers/scsi/megaraid/Kconfig.megaraid
linux-2.6.12-rc4-mm1.e/drivers/scsi/megaraid/Kconfig.megaraid
--- linux-2.6.12-rc4-mm1.d/drivers/scsi/megaraid/Kconfig.megaraid
2005-05-15 22:03:19.937015440 -0400
+++ linux-2.6.12-rc4-mm1.e/drivers/scsi/megaraid/Kconfig.megaraid
2005-05-15 22:11:24.540344536 -0400
@@ -76,3 +76,13 @@ config MEGARAID_LEGACY
 	To compile this driver as a module, choose M here: the
 	module will be called megaraid
 endif
+
+config MEGARAID_SAS
+	tristate "LSI Logic MegaRAID SAS RAID module"
+	depends on PCI && SCSI
+	help
+	Module for LSI Logic's SAS based RAID controllers.
+	To compile this driver as a module, choose 'm' here.
+	Module will be called megaraid_sas
+
+
diff -Naurp linux-2.6.12-rc4-mm1.d/drivers/scsi/megaraid/megaraid_sas.h
linux-2.6.12-rc4-mm1.e/drivers/scsi/megaraid/megaraid_sas.h
--- linux-2.6.12-rc4-mm1.d/drivers/scsi/megaraid/megaraid_sas.h	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-mm1.e/drivers/scsi/megaraid/megaraid_sas.h	2005-05-15
22:11:10.132534856 -0400
@@ -0,0 +1,1199 @@
+/*
+ *
+ *		Linux MegaRAID driver for SAS based RAID controllers
+ *
+ * Copyright (c) 2003-2005  LSI Logic Corporation.
+ *
+ *		This program is free software; you can redistribute it
and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ * FILE		: megaraid_sas.h
+ */
+
+#ifndef LSI_MEGARAID_SAS_H
+#define LSI_MEGARAID_SAS_H
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/list.h>
+#include <linux/version.h>
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+#include <linux/ioctl32.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+
+/**
+ * MegaRAID SAS Driver meta data
+ */
+#define MEGASAS_VERSION				"00.00.01.02"
+#define MEGASAS_RELDATE				"May 10, 2005"
+#define MEGASAS_EXT_VERSION			"18:32:27 EST 2005"
+
+/**
+ * MegaRAID SAS supported controllers
+ */
+#define	PCI_DEVICE_LSI_1064			0x0411
+
+#define PCI_DEVICE_ID_DELL_PERC5		0x0015
+#define PCI_DEVICE_ID_DELL_SAS5			0x0054
+
+#define PCI_SUBSYSTEM_DELL_PERC5E		0x1F01
+#define PCI_SUBSYSTEM_DELL_PERC5I		0x1F02
+#define PCI_SUBSYSTEM_DELL_PERC5I_INTEGRATED	0x1F03
+#define PCI_SUBSYSTEM_DELL_SAS5I		0x1F05
+#define PCI_SUBSYSTEM_DELL_SAS5I_INTEGRATED	0x1F06
+
+#define PCI_SUB_DEVICEID_FSC			0x1081
+#define PCI_SUB_VENDORID_FSC			0x1734
+
+/*
+ * =====================================
+ * MegaRAID SAS MFI firmware definitions
+ * =====================================
+ */
+
+/*
+ * MFI stands for  MegaRAID SAS FW Interface. This is just a moniker for 
+ * protocol between the software and firmware. Commands are issued using
+ * "message frames"
+ */
+
+/**
+ * FW posts its state in upper 4 bits of outbound_msg_0 register
+ */
+#define MFI_STATE_MASK				0xF0000000
+#define MFI_STATE_UNDEFINED			0x00000000
+#define MFI_STATE_BB_INIT			0x10000000
+#define MFI_STATE_FW_INIT			0x40000000
+#define MFI_STATE_WAIT_HANDSHAKE		0x60000000
+#define MFI_STATE_FW_INIT_2			0x70000000
+#define MFI_STATE_DEVICE_SCAN			0x80000000
+#define MFI_STATE_FLUSH_CACHE			0xA0000000
+#define MFI_STATE_READY				0xB0000000
+#define MFI_STATE_OPERATIONAL			0xC0000000
+#define MFI_STATE_FAULT				0xF0000000
+
+#define MEGAMFI_FRAME_SIZE			64
+
+/**
+ * During FW init, clear pending cmds & reset state using inbound_msg_0
+ *
+ * ABORT	: Abort all pending cmds
+ * READY	: Move from OPERATIONAL to READY state; discard queue info
+ * MFIMODE	: Discard (possible) low MFA posted in 64-bit mode (??)
+ * CLR_HANDSHAKE: FW is waiting for HANDSHAKE from BIOS or Driver
+ */
+#define MFI_INIT_ABORT				0x00000000
+#define MFI_INIT_READY				0x00000002
+#define MFI_INIT_MFIMODE			0x00000004
+#define MFI_INIT_CLEAR_HANDSHAKE		0x00000008
+#define MFI_RESET_FLAGS
MFI_INIT_READY|MFI_INIT_MFIMODE
+
+/**
+ * MFI frame flags
+ */
+#define MFI_FRAME_POST_IN_REPLY_QUEUE		0x0000
+#define MFI_FRAME_DONT_POST_IN_REPLY_QUEUE	0x0001
+#define MFI_FRAME_SGL32				0x0000
+#define MFI_FRAME_SGL64				0x0002
+#define MFI_FRAME_SENSE32			0x0000
+#define MFI_FRAME_SENSE64			0x0004
+#define MFI_FRAME_DIR_NONE			0x0000
+#define MFI_FRAME_DIR_WRITE			0x0008
+#define MFI_FRAME_DIR_READ			0x0010
+#define MFI_FRAME_DIR_BOTH			0x0018
+
+/**
+ * Definition for cmd_status
+ */
+#define MFI_CMD_STATUS_POLL_MODE		0xFF
+
+/**
+ * MFI command opcodes
+ */
+#define MFI_CMD_INIT				0x00
+#define MFI_CMD_LD_READ				0x01
+#define MFI_CMD_LD_WRITE			0x02
+#define MFI_CMD_LD_SCSI_IO			0x03
+#define MFI_CMD_PD_SCSI_IO			0x04
+#define MFI_CMD_DCMD				0x05
+#define MFI_CMD_ABORT				0x06
+#define MFI_CMD_SMP				0x07
+#define MFI_CMD_STP				0x08
+
+#define MR_DCMD_CTRL_GET_INFO			0x01010000
+
+#define MR_DCMD_CTRL_CACHE_FLUSH		0x01101000
+#define MR_FLUSH_CTRL_CACHE			0x01
+#define MR_FLUSH_DISK_CACHE			0x02
+
+#define MR_DCMD_CTRL_SHUTDOWN			0x01050000
+#define MR_ENABLE_DRIVE_SPINDOWN		0x01
+
+#define MR_DCMD_CTRL_EVENT_GET_INFO		0x01040100
+#define MR_DCMD_CTRL_EVENT_GET			0x01040300
+#define MR_DCMD_CTRL_EVENT_WAIT			0x01040500
+#define MR_DCMD_LD_GET_PROPERTIES		0x03030000
+
+#define MR_DCMD_CLUSTER				0x08000000
+#define MR_DCMD_CLUSTER_RESET_ALL		0x08010100
+#define MR_DCMD_CLUSTER_RESET_LD		0x08010200
+
+/**
+ * MFI command completion codes
+ */
+enum MFI_STAT {
+	MFI_STAT_OK				= 0x00,
+	MFI_STAT_INVALID_CMD			= 0x01,
+	MFI_STAT_INVALID_DCMD			= 0x02,
+	MFI_STAT_INVALID_PARAMETER		= 0x03,
+	MFI_STAT_INVALID_SEQUENCE_NUMBER	= 0x04,
+	MFI_STAT_ABORT_NOT_POSSIBLE		= 0x05,
+	MFI_STAT_APP_HOST_CODE_NOT_FOUND	= 0x06,
+	MFI_STAT_APP_IN_USE			= 0x07,
+	MFI_STAT_APP_NOT_INITIALIZED		= 0x08,
+	MFI_STAT_ARRAY_INDEX_INVALID		= 0x09,
+	MFI_STAT_ARRAY_ROW_NOT_EMPTY		= 0x0a,
+	MFI_STAT_CONFIG_RESOURCE_CONFLICT	= 0x0b,
+	MFI_STAT_DEVICE_NOT_FOUND		= 0x0c,
+	MFI_STAT_DRIVE_TOO_SMALL		= 0x0d,
+	MFI_STAT_FLASH_ALLOC_FAIL		= 0x0e,
+	MFI_STAT_FLASH_BUSY			= 0x0f,
+	MFI_STAT_FLASH_ERROR			= 0x10,
+	MFI_STAT_FLASH_IMAGE_BAD		= 0x11,
+	MFI_STAT_FLASH_IMAGE_INCOMPLETE		= 0x12,
+	MFI_STAT_FLASH_NOT_OPEN			= 0x13,
+	MFI_STAT_FLASH_NOT_STARTED		= 0x14,
+	MFI_STAT_FLUSH_FAILED			= 0x15,
+	MFI_STAT_HOST_CODE_NOT_FOUNT		= 0x16,
+	MFI_STAT_LD_CC_IN_PROGRESS		= 0x17,
+	MFI_STAT_LD_INIT_IN_PROGRESS		= 0x18,
+	MFI_STAT_LD_LBA_OUT_OF_RANGE		= 0x19,
+	MFI_STAT_LD_MAX_CONFIGURED		= 0x1a,
+	MFI_STAT_LD_NOT_OPTIMAL			= 0x1b,
+	MFI_STAT_LD_RBLD_IN_PROGRESS		= 0x1c,
+	MFI_STAT_LD_RECON_IN_PROGRESS		= 0x1d,
+	MFI_STAT_LD_WRONG_RAID_LEVEL		= 0x1e,
+	MFI_STAT_MAX_SPARES_EXCEEDED		= 0x1f,
+	MFI_STAT_MEMORY_NOT_AVAILABLE		= 0x20,
+	MFI_STAT_MFC_HW_ERROR			= 0x21,
+	MFI_STAT_NO_HW_PRESENT			= 0x22,
+	MFI_STAT_NOT_FOUND			= 0x23,
+	MFI_STAT_NOT_IN_ENCL			= 0x24,
+	MFI_STAT_PD_CLEAR_IN_PROGRESS		= 0x25,
+	MFI_STAT_PD_TYPE_WRONG			= 0x26,
+	MFI_STAT_PR_DISABLED			= 0x27,
+	MFI_STAT_ROW_INDEX_INVALID		= 0x28,
+	MFI_STAT_SAS_CONFIG_INVALID_ACTION	= 0x29,
+	MFI_STAT_SAS_CONFIG_INVALID_DATA	= 0x2a,
+	MFI_STAT_SAS_CONFIG_INVALID_PAGE	= 0x2b,
+	MFI_STAT_SAS_CONFIG_INVALID_TYPE	= 0x2c,
+	MFI_STAT_SCSI_DONE_WITH_ERROR		= 0x2d,
+	MFI_STAT_SCSI_IO_FAILED			= 0x2e,
+	MFI_STAT_SCSI_RESERVATION_CONFLICT	= 0x2f,
+	MFI_STAT_SHUTDOWN_FAILED		= 0x30,
+	MFI_STAT_TIME_NOT_SET			= 0x31,
+	MFI_STAT_WRONG_STATE			= 0x32,
+	MFI_STAT_LD_OFFLINE			= 0x33,
+	MFI_STAT_PEER_NOTIFICATION_REJECTED	= 0x34,
+	MFI_STAT_PEER_NOTIFICATION_FAILED	= 0x35,
+	MFI_STAT_RESERVATION_IN_PROGRESS	= 0x36,
+	MFI_STAT_I2C_ERRORS_DETECTED		= 0x37,
+	MFI_STAT_PCI_ERRORS_DETECTED		= 0x38,
+
+	MFI_STAT_INVALID_STATUS			= 0xFF
+};
+
+/*
+ * Number of mailbox bytes in DCMD message frame
+ */
+#define MFI_MBOX_SIZE				12
+
+enum MR_EVT_CLASS {
+
+	MR_EVT_CLASS_DEBUG		= -2,
+	MR_EVT_CLASS_PROGRESS		= -1,
+	MR_EVT_CLASS_INFO		=  0,
+	MR_EVT_CLASS_WARNING		=  1,
+	MR_EVT_CLASS_CRITICAL		=  2,
+	MR_EVT_CLASS_FATAL		=  3,
+	MR_EVT_CLASS_DEAD		=  4,
+
+};
+
+enum MR_EVT_LOCALE{
+
+	MR_EVT_LOCALE_LD		= 0x0001,
+	MR_EVT_LOCALE_PD		= 0x0002,
+	MR_EVT_LOCALE_ENCL		= 0x0004,
+	MR_EVT_LOCALE_BBU		= 0x0008,
+	MR_EVT_LOCALE_SAS		= 0x0010,
+	MR_EVT_LOCALE_CTRL		= 0x0020,
+	MR_EVT_LOCALE_CONFIG		= 0x0040,
+	MR_EVT_LOCALE_CLUSTER		= 0x0080,
+	MR_EVT_LOCALE_ALL		= 0xffff,
+
+};
+
+enum MR_EVT_ARGS {
+
+	MR_EVT_ARGS_NONE,
+	MR_EVT_ARGS_CDB_SENSE,
+	MR_EVT_ARGS_LD,
+	MR_EVT_ARGS_LD_COUNT,
+	MR_EVT_ARGS_LD_LBA,
+	MR_EVT_ARGS_LD_OWNER,
+	MR_EVT_ARGS_LD_LBA_PD_LBA,
+	MR_EVT_ARGS_LD_PROG,
+	MR_EVT_ARGS_LD_STATE,
+	MR_EVT_ARGS_LD_STRIP,
+	MR_EVT_ARGS_PD,
+	MR_EVT_ARGS_PD_ERR,
+	MR_EVT_ARGS_PD_LBA,
+	MR_EVT_ARGS_PD_LBA_LD,
+	MR_EVT_ARGS_PD_PROG,
+	MR_EVT_ARGS_PD_STATE,
+	MR_EVT_ARGS_PCI,
+	MR_EVT_ARGS_RATE,
+	MR_EVT_ARGS_STR,
+	MR_EVT_ARGS_TIME,
+	MR_EVT_ARGS_ECC,
+
+};
+
+/*
+ * SAS controller properties
+ */
+struct megasas_ctrl_prop {
+
+	u16		seq_num;
+	u16		pred_fail_poll_interval;
+	u16		intr_throttle_count;
+	u16		intr_throttle_timeouts;
+
+	u8		rebuild_rate;
+	u8		patrol_read_rate;
+	u8		bgi_rate;
+	u8		cc_rate;
+	u8		recon_rate;
+
+	u8		cache_flush_interval;
+
+	u8		spinup_drv_count;
+	u8		spinup_delay;
+
+	u8		cluster_enable;
+	u8		coercion_mode;
+	u8		disk_write_cache_disable;
+	u8		alarm_enable;
+
+	u8		reserved[44];
+
+} __attribute__ ((packed));
+
+/*
+ * SAS controller information
+ */
+struct megasas_ctrl_info {
+
+	/*
+	 * PCI device information
+	 */
+	struct {
+
+		u16	vendor_id;
+		u16	device_id;
+		u16	sub_vendor_id;
+		u16	sub_device_id;
+		u8	reserved[24];
+
+	} __attribute__ ((packed)) pci;
+
+	/*
+	 * Host interface information
+	 */
+	struct {
+
+		u8	PCIX		: 1;
+		u8	PCIE		: 1;
+		u8	iSCSI		: 1;
+		u8	SAS_3G		: 1;
+		u8	reserved_0	: 4;
+		u8	reserved_1[6];
+		u8	port_count;
+		u64	port_addr[8];
+
+	} __attribute__ ((packed)) host_interface;
+
+	/*
+	 * Device (backend) interface information
+	 */
+	struct {
+
+		u8	SPI		: 1;
+		u8	SAS_3G		: 1;
+		u8	SATA_1_5G	: 1;
+		u8	SATA_3G		: 1;
+		u8	reserved_0	: 4;
+		u8	reserved_1[6];
+		u8	port_count;
+		u64	port_addr[8];
+
+	} __attribute__ ((packed)) device_interface;
+
+	/*
+	 * List of components residing in flash. All str are null terminated
+	 */
+	u32		image_check_word;
+	u32		image_component_count;
+
+	struct {
+
+		char	name[8];
+		char	version[32];
+		char	build_date[16];
+		char	built_time[16];
+
+	} __attribute__ ((packed)) image_component[8];
+
+	/*
+	 * List of flash components that have been flashed on the card, but
+	 * are not in use, pending reset of the adapter. This list will be
+	 * empty if a flash operation has not occurred. All stings are null
+	 * terminated
+	 */
+	u32		pending_image_component_count;
+
+	struct {
+
+		char	name[8];
+		char	version[32];
+		char	build_date[16];
+		char	build_time[16];
+
+	} __attribute__ ((packed)) pending_image_component[8];
+
+	u8		max_arms;
+	u8		max_spans;
+	u8		max_arrays;
+	u8		max_lds;
+
+	char		product_name[80];
+	char		serial_no[32];
+
+	/*
+	 * Other physical/controller/operation information. Indicates the
+	 * presence of the hardware
+	 */
+	struct {
+
+		u32	bbu		: 1;
+		u32	alarm		: 1;
+		u32	nvram		: 1;
+		u32	uart		: 1;
+		u32	reserved	: 28;
+
+	} __attribute__ ((packed)) hw_present;
+
+	u32	current_fw_time;
+
+	/*
+	 * Maximum data transfer sizes
+	 */
+	u16		max_concurrent_cmds;
+	u16		max_sge_count;
+	u32		max_request_size;
+
+	/*
+	 * Logical and physical device counts
+	 */
+	u16		ld_present_count;
+	u16		ld_degraded_count;
+	u16		ld_offline_count;
+
+	u16		pd_present_count;
+	u16		pd_disk_present_count;
+	u16		pd_disk_pred_failure_count;
+	u16		pd_disk_failed_count;
+
+	/*
+	 * Memory size information
+	 */
+	u16		nvram_size;
+	u16		memory_size;
+	u16		flash_size;
+
+	/*
+	 * Error counters
+	 */
+	u16		mem_correctable_error_count;
+	u16		mem_uncorrectable_error_count;
+
+	/*
+	 * Cluster information
+	 */
+	u8		cluster_permitted;
+	u8		cluster_active;
+
+	/*
+	 * Additional max data transfer sizes
+	 */
+	u16		max_strips_per_io;
+
+	/*
+	 * Controller capabilities structures
+	 */
+	struct {
+
+		u32	raid_level_0	: 1;
+		u32	raid_level_1	: 1;
+		u32	raid_level_5	: 1;
+		u32	raid_level_1E	: 1;
+		u32	reserved	: 28;
+
+	} __attribute__ ((packed)) raid_levels;
+
+	struct {
+
+		u32	rbld_rate		: 1;
+		u32	cc_rate			: 1;
+		u32	bgi_rate		: 1;
+		u32	recon_rate		: 1;
+		u32	patrol_rate		: 1;
+		u32	alarm_control		: 1;
+		u32	cluster_supported	: 1;
+		u32	bbu			: 1;
+		u32	spanning_allowed	: 1;
+		u32	dedicated_hotspares	: 1;
+		u32	revertible_hotspares	: 1;
+		u32	foreign_config_import	: 1;
+		u32	self_diagnostic		: 1;
+		u32	mixed_redundancy_arr	: 1;
+		u32	reserved		: 18;
+
+	} __attribute__ ((packed)) adapter_operations;
+
+	struct {
+
+		u32	read_policy	: 1;
+		u32	write_policy	: 1;
+		u32	io_policy	: 1;
+		u32	access_policy	: 1;
+		u32	reserved	: 28;
+
+	} __attribute__ ((packed)) ld_operations;
+
+	struct {
+
+		u8	min;
+		u8	max;
+		u8	reserved[2];
+
+	} __attribute__ ((packed)) stripe_sz_ops;
+
+	struct {
+
+		u32	force_online	: 1;
+		u32	force_offline	: 1;
+		u32	force_rebuild	: 1;
+		u32	reserved	: 29;
+
+	} __attribute__ ((packed)) pd_operations;
+
+	struct {
+
+		u32	ctrl_supports_sas	: 1;
+		u32	ctrl_supports_sata	: 1;
+		u32	allow_mix_in_encl	: 1;
+		u32	allow_mix_in_ld		: 1;
+		u32	allow_sata_in_cluster	: 1;
+		u32	reserved		: 27;
+
+	} __attribute__ ((packed)) pd_mix_support;
+
+	/*
+	 * Include the controller properties (changeable items)
+	 */
+	u8				reserved_2[12];
+	struct megasas_ctrl_prop	properties;
+
+	u8				pad[0x800 - 0x640];
+
+} __attribute__ ((packed));
+
+/*
+ * ===============================
+ * MegaRAID SAS driver definitions
+ * ===============================
+ */
+#define MEGASAS_MAX_PD_CHANNELS			2
+#define MEGASAS_MAX_LD_CHANNELS			2
+#define MEGASAS_MAX_CHANNELS			(MEGASAS_MAX_PD_CHANNELS + \
+						MEGASAS_MAX_LD_CHANNELS)
+#define MEGASAS_MAX_DEV_PER_CHANNEL		128
+#define MEGASAS_DEFAULT_INIT_ID			-1
+#define MEGASAS_MAX_LUN				8
+#define MEGASAS_MAX_LD				64
+
+/*
+ * When SCSI mid-layer calls driver's reset routine, driver waits for
+ * MEGASAS_RESET_WAIT_TIME seconds for all outstanding IO to complete. Note
+ * that the driver cannot _actually_ abort or reset pending commands. While
+ * it is waiting for the commands to complete, it prints a diagnostic
message
+ * every MEGASAS_RESET_NOTICE_INTERVAL seconds
+ */
+#define MEGASAS_RESET_WAIT_TIME			180
+#define	MEGASAS_RESET_NOTICE_INTERVAL		5
+
+#define MEGASAS_IOCTL_CMD			0
+
+/*
+ * FW reports the maximum of number of commands that it can accept (maximum
+ * commands that can be outstanding) at any time. The driver must report a
+ * lower number to the mid layer because it can issue a few internal
commands
+ * itself (E.g, AEN, abort cmd, IOCTLs etc). The number of commands it
needs
+ * is shown below
+ */
+#define MEGASAS_INT_CMDS			32
+
+/*
+ * FW can accept both 32 and 64 bit SGLs. We want to allocate 32/64 bit
+ * SGLs based on the size of dma_addr_t
+ */
+#define IS_DMA64		(sizeof(dma_addr_t) == 8)
+
+/*
+ * All MFI register set macros accept megasas_register_set*
+ */
+#define RD_OB_MSG_0(regs)	readl((void*)(&(regs)->outbound_msg_0))
+#define WR_IN_MSG_0(v, regs)	writel((v),(void*)(&(regs)->inbound_msg_0))
+#define WR_IN_DOORBELL(v, regs)
writel((v),(void*)(&(regs)->inbound_doorbell))
+#define WR_IN_QPORT(v, regs)
writel((v),(void*)(&(regs)->inbound_queue_port))
+
+#define RD_OB_INTR_STATUS(regs)
readl((void*)(&(regs)->outbound_intr_status))
+#define WR_OB_INTR_STATUS(v, regs)
writel((v),(&(regs)->outbound_intr_status))
+
+/*
+ * When FW is in MFI_STATE_READY or MFI_STATE_OPERATIONAL, the state data
+ * of Outbound Msg Reg 0 indicates max concurrent cmds supported, max SGEs
+ * supported per cmd and if 64-bit MFAs (M64) is enabled or disabled.
+ */
+#define MFI_MAX_SUPP_CMDS(regs)	((RD_OB_MSG_0(regs)) & 0x00FFFF)
+#define MFI_MAX_SUPP_SGES(regs)	(((RD_OB_MSG_0(regs)) & 0x0FF0000)
>> 0x10)
+#define MFI_M64_ENABLED(regs)	((RD_OB_MSG_0(regs)) & 0x1000000)
+
+#define MFI_OB_INTR_STATUS_MASK		0x00000002
+#define MFI_POLL_TIMEOUT_SECS		10
+
+#define MFI_ENABLE_INTR(regs)
writel(1,(void*)(&(regs)->outbound_intr_mask))
+
+#define MFI_DISABLE_INTR(regs)						\
+{									\
+	u32 disable = ~0x00000001;					\
+	u32 mask = readl((void*)(&(regs)->outbound_intr_mask));	\
+	mask &= disable;						\
+	writel(mask, (void*)(&(regs)->outbound_intr_mask));		\
+}
+
+
+struct megasas_register_set {
+
+	u32	reserved_0[4];			/*0000h*/
+
+	u32	inbound_msg_0;			/*0010h*/
+	u32	inbound_msg_1;			/*0014h*/
+	u32	outbound_msg_0;			/*0018h*/
+	u32	outbound_msg_1;			/*001Ch*/
+
+	u32	inbound_doorbell;		/*0020h*/
+	u32	inbound_intr_status;		/*0024h*/
+	u32	inbound_intr_mask;		/*0028h*/
+
+	u32	outbound_doorbell;		/*002Ch*/
+	u32	outbound_intr_status;		/*0030h*/
+	u32	outbound_intr_mask;		/*0034h*/
+
+	u32	reserved_1[2];			/*0038h*/
+
+	u32	inbound_queue_port;		/*0040h*/
+	u32	outbound_queue_port;		/*0044h*/
+
+	u32	reserved_2;			/*004Ch*/
+
+	u32	index_registers[1004];		/*0050h*/
+
+} __attribute__ ((packed));
+
+struct megasas_sge32 {
+
+	u32	phys_addr;
+	u32	length;
+
+} __attribute__ ((packed));
+
+struct megasas_sge64 {
+
+	u64	phys_addr;
+	u32	length;
+
+} __attribute__ ((packed));
+
+union megasas_sgl {
+
+	struct megasas_sge32	sge32[1];
+	struct megasas_sge64	sge64[1];
+
+} __attribute__ ((packed));
+
+struct megasas_header {
+
+	u8		cmd;				/*00h*/
+	u8		sense_len;			/*01h*/
+	u8		cmd_status;			/*02h*/
+	u8		scsi_status;			/*03h*/
+
+	u8		target_id;			/*04h*/
+	u8		lun;				/*05h*/
+	u8		cdb_len;			/*06h*/
+	u8		sge_count;			/*07h*/
+
+	u32		context;			/*08h*/
+	u32		pad_0;				/*0Ch*/
+
+	u16		flags;				/*10h*/
+	u16		timeout;			/*12h*/
+	u32		data_xferlen;			/*14h*/
+
+} __attribute__ ((packed));
+
+union megasas_sgl_frame {
+
+	struct megasas_sge32	sge32[8];
+	struct megasas_sge64	sge64[5];
+
+} __attribute__ ((packed));
+
+struct megasas_init_frame {
+
+	u8		cmd;				/*00h*/
+	u8		reserved_0;			/*01h*/
+	u8		cmd_status;			/*02h*/
+
+	u8		reserved_1;			/*03h*/
+	u32		reserved_2;			/*04h*/
+
+	u32		context;			/*08h*/
+	u32		pad_0;				/*0Ch*/
+
+	u16		flags;				/*10h*/
+	u16		reserved_3;			/*12h*/
+	u32		data_xfer_len;			/*14h*/
+
+	u32		queue_info_new_phys_addr_lo;	/*18h*/
+	u32		queue_info_new_phys_addr_hi;	/*1Ch*/
+	u32		queue_info_old_phys_addr_lo;	/*20h*/
+	u32		queue_info_old_phys_addr_hi;	/*24h*/
+
+	u32		reserved_4[6];			/*28h*/
+
+} __attribute__ ((packed));
+
+struct megasas_init_queue_info {
+
+	u32		init_flags;			/*00h*/
+	u32		reply_queue_entries;		/*04h*/
+
+	u32		reply_queue_start_phys_addr_lo;	/*08h*/
+	u32		reply_queue_start_phys_addr_hi;	/*0Ch*/
+	u32		producer_index_phys_addr_lo;	/*10h*/
+	u32		producer_index_phys_addr_hi;	/*14h*/
+	u32		consumer_index_phys_addr_lo;	/*18h*/
+	u32		consumer_index_phys_addr_hi;	/*1Ch*/
+
+} __attribute__ ((packed));
+
+struct megasas_io_frame {
+
+	u8			cmd;			/*00h*/
+	u8			sense_len;		/*01h*/
+	u8			cmd_status;		/*02h*/
+	u8			scsi_status;		/*03h*/
+
+	u8			target_id;		/*04h*/
+	u8			access_byte;		/*05h*/
+	u8			reserved_0;		/*06h*/
+	u8			sge_count;		/*07h*/
+
+	u32			context;		/*08h*/
+	u32			pad_0;			/*0Ch*/
+
+	u16			flags;			/*10h*/
+	u16			timeout;		/*12h*/
+	u32			lba_count;		/*14h*/
+
+	u32			sense_buf_phys_addr_lo;	/*18h*/
+	u32			sense_buf_phys_addr_hi;	/*1Ch*/
+
+	u32			start_lba_lo;		/*20h*/
+	u32			start_lba_hi;		/*24h*/
+
+	union megasas_sgl	sgl;			/*28h*/
+
+} __attribute__ ((packed));
+
+struct megasas_pthru_frame {
+
+	u8			cmd;				/*00h*/
+	u8			sense_len;			/*01h*/
+	u8			cmd_status;			/*02h*/
+	u8			scsi_status;			/*03h*/
+
+	u8			target_id;			/*04h*/
+	u8			lun;				/*05h*/
+	u8			cdb_len;			/*06h*/
+	u8			sge_count;			/*07h*/
+
+	u32			context;			/*08h*/
+	u32			pad_0;				/*0Ch*/
+
+	u16			flags;				/*10h*/
+	u16			timeout;			/*12h*/
+	u32			data_xfer_len;			/*14h*/
+
+	u32			sense_buf_phys_addr_lo;		/*18h*/
+	u32			sense_buf_phys_addr_hi;		/*1Ch*/
+
+	u8			cdb[16];			/*20h*/
+	union megasas_sgl	sgl;				/*30h*/
+
+} __attribute__ ((packed));
+
+struct megasas_dcmd_frame {
+
+	u8			cmd;				/*00h*/
+	u8			reserved_0;			/*01h*/
+	u8			cmd_status;			/*02h*/
+	u8			reserved_1[4];			/*03h*/
+	u8			sge_count;			/*07h*/
+
+	u32			context;			/*08h*/
+	u32			pad_0;				/*0Ch*/
+
+	u16			flags;				/*10h*/
+	u16			timeout;			/*12h*/
+
+	u32			data_xfer_len;			/*14h*/
+	u32			opcode;				/*18h*/
+
+	u8			mbox[MFI_MBOX_SIZE];		/*1Ch*/
+
+	union megasas_sgl	sgl;				/*28h*/
+
+} __attribute__ ((packed));
+
+struct megasas_abort_frame {
+
+	u8		cmd;				/*00h*/
+	u8		reserved_0;			/*01h*/
+	u8		cmd_status;			/*02h*/
+
+	u8		reserved_1;			/*03h*/
+	u32		reserved_2;			/*04h*/
+
+	u32		context;			/*08h*/
+	u32		pad_0;				/*0Ch*/
+
+	u16		flags;				/*10h*/
+	u16		reserved_3;			/*12h*/
+	u32		reserved_4;			/*14h*/
+
+	u32		abort_context;			/*18h*/
+	u32		pad_1;				/*1Ch*/
+
+	u32		abort_mfi_phys_addr_lo;		/*20h*/
+	u32		abort_mfi_phys_addr_hi;		/*24h*/
+
+	u32		reserved_5[6];			/*28h*/
+
+} __attribute__ ((packed));
+
+struct megasas_smp_frame {
+
+	u8			cmd;				/*00h*/
+	u8			reserved_1;			/*01h*/
+	u8			cmd_status;			/*02h*/
+	u8			connection_status;		/*03h*/
+
+	u8			reserved_2[3];			/*04h*/
+	u8			sge_count;			/*07h*/
+
+	u32			context;			/*08h*/
+	u32			pad_0;				/*0Ch*/
+
+	u16			flags;				/*10h*/
+	u16			timeout;			/*12h*/
+
+	u32			data_xfer_len;			/*14h*/
+	u64			sas_addr;			/*18h*/
+
+	union {
+		struct megasas_sge32	sge32[2]; /* [0]: resp [1]: req */
+		struct megasas_sge64	sge64[2]; /* [0]: resp [1]: req */
+	} sgl;
+
+} __attribute__ ((packed));
+
+struct megasas_stp_frame {
+
+	u8			cmd;				/*00h*/
+	u8			reserved_1;			/*01h*/
+	u8			cmd_status;			/*02h*/
+	u8			reserved_2;			/*03h*/
+
+	u8			target_id;			/*04h*/
+	u8			reserved_3[2];			/*05h*/
+	u8			sge_count;			/*07h*/
+
+	u32			context;			/*08h*/
+	u32			pad_0;				/*0Ch*/
+
+	u16			flags;				/*10h*/
+	u16			timeout;			/*12h*/
+
+	u32			data_xfer_len;			/*14h*/
+
+	u16			fis[10];			/*18h*/
+	u32			stp_flags;
+
+	union {
+		struct megasas_sge32	sge32[2]; /* [0]: resp [1]: data */
+		struct megasas_sge64	sge64[2]; /* [0]: resp [1]: data */
+	} sgl;
+
+} __attribute__ ((packed));
+
+union megasas_frame {
+
+	struct megasas_header		hdr;
+	struct megasas_init_frame	init;
+	struct megasas_io_frame		io;
+	struct megasas_pthru_frame	pthru;
+	struct megasas_dcmd_frame	dcmd;
+	struct megasas_abort_frame	abort;
+	struct megasas_smp_frame	smp;
+	struct megasas_stp_frame	stp;
+
+	u8				raw_bytes[64];
+};
+
+struct megasas_cmd;
+
+union megasas_evt_class_locale {
+
+	struct {
+		u16		locale;
+		u8		reserved;
+		s8		class;
+	} __attribute__ ((packed)) members;
+
+	u32			word;
+
+} __attribute__ ((packed));
+
+struct megasas_evt_log_info {
+	u32		newest_seq_num;
+	u32		oldest_seq_num;
+	u32		clear_seq_num;
+	u32		shutdown_seq_num;
+	u32		boot_seq_num;
+
+} __attribute__ ((packed));
+
+struct megasas_progress {
+
+	u16		progress;
+	u16		elapsed_seconds;
+
+} __attribute__ ((packed));
+
+struct megasas_evtarg_ld {
+
+	u16		target_id;
+	u8		ld_index;
+	u8		reserved;
+
+} __attribute__ ((packed));
+
+struct megasas_evtarg_pd {
+	u16		device_id;
+	u8		encl_index;
+	u8		slot_number;
+
+} __attribute__ ((packed));
+
+struct megasas_evt_detail {
+
+	u32						seq_num;
+	u32						time_stamp;
+	u32						code;
+	union megasas_evt_class_locale			cl;
+	u8						arg_type;
+	u8						reserved1[15];
+
+	union {
+		struct {
+			struct megasas_evtarg_pd	pd;
+			u8				cdb_length;
+			u8				sense_length;
+			u8				reserved[2];
+			u8				cdb[16];
+			u8				sense[64];
+		} __attribute__ ((packed)) cdbSense;
+
+		struct megasas_evtarg_ld		ld;
+
+	        struct {
+			struct megasas_evtarg_ld	ld;
+			u64			count;
+		} __attribute__ ((packed)) ld_count;
+
+		struct {
+			u64				lba;
+			struct megasas_evtarg_ld	ld;
+		} __attribute__ ((packed)) ld_lba;
+
+		struct {
+			struct megasas_evtarg_ld	ld;
+			u32				prevOwner;
+			u32				newOwner;
+		} __attribute__ ((packed)) ld_owner;
+
+		struct {
+			u64				ld_lba;
+			u64				pd_lba;
+			struct megasas_evtarg_ld	ld;
+			struct megasas_evtarg_pd	pd;
+		} __attribute__ ((packed)) ld_lba_pd_lba;
+
+		struct {
+			struct megasas_evtarg_ld	ld;
+			struct megasas_progress		prog;
+		} __attribute__ ((packed)) ld_prog;
+
+		struct {
+			struct megasas_evtarg_ld	ld;
+			u32				prev_state;
+			u32				new_state;
+		} __attribute__ ((packed)) ld_state;
+
+		struct {
+			u64				strip;
+			struct megasas_evtarg_ld	ld;
+		} __attribute__ ((packed)) ld_strip;
+
+		struct megasas_evtarg_pd		pd;
+
+		struct {
+			struct megasas_evtarg_pd	pd;
+			u32				err;
+		} __attribute__ ((packed)) pd_err;
+
+		struct {
+			u64				lba;
+			struct megasas_evtarg_pd	pd;
+		} __attribute__ ((packed)) pd_lba;
+
+		struct {
+			u64				lba;
+			struct megasas_evtarg_pd	pd;
+			struct megasas_evtarg_ld	ld;
+		} __attribute__ ((packed)) pd_lba_ld;
+
+		struct {
+			struct megasas_evtarg_pd	pd;
+			struct megasas_progress		prog;
+		} __attribute__ ((packed)) pd_prog;
+
+		struct {
+			struct megasas_evtarg_pd	pd;
+			u32				prevState;
+			u32				newState;
+		} __attribute__ ((packed)) pd_state;
+
+		struct {
+			u16				vendorId;
+			u16				deviceId;
+			u16				subVendorId;
+			u16				subDeviceId;
+		} __attribute__ ((packed)) pci;
+
+		u32					rate;
+		char					str[96];
+
+		struct {
+			u32				rtc;
+			u32				elapsedSeconds;
+		} __attribute__ ((packed)) time;
+
+		struct {
+			u32				ecar;
+			u32				elog;
+			char				str[64];
+		} __attribute__ ((packed)) ecc;
+
+		u8					b[96];
+		u16					s[48];
+		u32					w[24];
+		u64					d[12];
+	} args;
+
+	char						description[128];
+
+} __attribute__ ((packed));
+
+struct megasas_instance {
+
+	u32					producer;
+	u32					consumer;
+
+	u32*					reply_queue;
+	dma_addr_t				reply_queue_phys_addr;
+
+	dma_addr_t				phys_addr;
+
+	unsigned long				base_addr;
+	struct megasas_register_set __iomem*	reg_set;
+
+	s8					init_id;
+	u8					reserved[3];
+
+	u16					max_num_sge;
+	u16					max_fw_cmds;
+	u32					max_sectors_per_req;
+
+	struct megasas_cmd**			cmd_list;
+	struct list_head			cmd_pool;
+	spinlock_t				cmd_pool_lock;
+	struct dma_pool*			frame_dma_pool;
+	struct dma_pool*			sense_dma_pool;
+
+	struct megasas_evt_detail		evt_detail;
+	struct megasas_cmd*			aen_cmd;
+
+	struct Scsi_Host*			host;
+	spinlock_t				lock;
+	spinlock_t*				host_lock;
+
+	wait_queue_head_t			int_cmd_wait_q;
+	wait_queue_head_t			abort_cmd_wait_q;
+
+	struct pci_dev*				pdev;
+	u32					unique_id;
+
+	u32					fw_outstanding;
+	u32					hw_crit_error;
+};
+
+/*
+ * Various conversion macros from SCSI command
+ */
+#define SCP2HOST(scp)		(scp)->device->host	// to host
+#define SCP2HOSTDATA(scp)	SCP2HOST(scp)->hostdata	// to soft state
+#define SCP2CHANNEL(scp)	(scp)->device->channel	// to channel
+#define SCP2TARGET(scp)		(scp)->device->id	// to target
+#define SCP2LUN(scp)		(scp)->device->lun	// to LUN
+
+#define SCSIHOST2ADAP(host)	(((caddr_t *)(host->hostdata))[0])
+#define SCP2ADAPTER(scp)	(struct
megasas_instance*)SCSIHOST2ADAP(SCP2HOST(scp))
+
+#define MEGASAS_IS_LOGICAL(scp)
\
+	(SCP2CHANNEL(scp) < MEGASAS_MAX_PD_CHANNELS) ? 0 : 1
+
+#define MEGASAS_DEV_INDEX(inst, scp)					\
+	((SCP2CHANNEL(scp) % 2) * MEGASAS_MAX_DEV_PER_CHANNEL) +
SCP2TARGET(scp)
+
+struct megasas_cmd {
+
+	union megasas_frame*	frame;
+	dma_addr_t		frame_phys_addr;
+	u8*			sense;
+	dma_addr_t		sense_phys_addr;
+
+	u32			index;
+	u8			sync_cmd;
+	u8			cmd_status;
+	u16			abort_aen;
+
+	struct list_head	list;
+	struct scsi_cmnd*	scmd;
+	u32			frame_count;
+};
+
+#define MAX_MGMT_ADAPTERS			1024
+#define IOC_SIGNATURE				"LSILOGIC"
+
+#define IOC_CMD_FIRMWARE			0x0
+#define MR_DRIVER_IOCTL_COMMON			0xF0010000
+#define MR_DRIVER_IOCTL_DRIVER_VERSION		0xF0010100
+#define MR_DRIVER_IOCTL_PCI_INFORMATION		0xF0010200
+#define MR_DRIVER_IOCTL_MEGARAID_STATISTICS	0xF0010300
+
+#define MR_DRIVER_IOCTL_LINUX			0xF0040000
+#define MR_LINUX_GET_ADAPTER_COUNT		(MR_DRIVER_IOCTL_LINUX |
0x0100)
+#define MR_LINUX_GET_ADAPTER_MAP		(MR_DRIVER_IOCTL_LINUX |
0x0200)
+#define MR_LINUX_GET_AEN			(MR_DRIVER_IOCTL_LINUX |
0x0300)
+
+#define MR_MAX_SENSE_LENGTH			32
+
+struct iocpacket {
+
+	u16			version;
+	u16			controller_id;
+	u8			signature[8];
+	u32			reserved_1;
+	u32			control_code;
+	u32			reserved_2[2];
+	u8			frame[64];
+	union megasas_sgl_frame	sgl_frame;
+	u8			sense_buff[MR_MAX_SENSE_LENGTH];
+	u8			data[1];
+
+} __attribute__ ((packed));
+
+struct megasas_adp_map {
+
+	u16	unique_hndl;
+	u32	bus_devfn;
+
+} __attribute__ ((packed));
+
+struct megasas_mgmt_info {
+
+	u16				count;
+	struct megasas_instance*	instance[MAX_MGMT_ADAPTERS];
+	struct megasas_adp_map		map[MAX_MGMT_ADAPTERS];
+	int				max_index;
+};
+
+struct megasas_drv_ver {
+	u8	signature[12];
+	u8	os_name[16];
+	u8	os_ver[12];
+	u8	drv_name[20];
+	u8	drv_ver[32];
+	u8	drv_rel_date[20];
+
+} __attribute__ ((packed));
+
+#endif /*LSI_MEGARAID_SAS_H*/
