Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVIAAe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVIAAe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVIAAe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:34:56 -0400
Received: from mail0.lsil.com ([147.145.40.20]:41910 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S965003AbVIAAex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:34:53 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CD126@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'hch@lst.de'" <hch@lst.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       "Patro, Sumant" <sumantp@COS1.co.lsil.com>,
       "Kolli, Neela Syam" <knsyam@lsil.com>
Subject: FW: [Fwd: Re: [PATCH scsi-misc 2/2] megaraid_sas: LSI Logic MegaR
	AID SAS RA ID D river]
Date: Wed, 31 Aug 2005 20:34:07 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5AE8C.DCE07840"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5AE8C.DCE07840
Content-Type: text/plain

> Looks pretty good to me.  Small issues I've identified:
> 
>  - what do you need the hba_count attribute for?  This should be
>    implementable in userspace pretty easily by iterating of all
>    devices of the scsi_host class that are attached to the driver

I have removed hba_count

>  - the ->queuecommand cleanup patch I sent you a awhile ago doesn't
>    seem to be applied

I seem to have missed it. I will submit the patch after inclusion

>  - there's quite a lot of slightly odd formating, it would be nice
>    if you could run the code through scripts/Lindent.

I ran Lindent. It looks worse :( I am submitting the Lindent output anyway.

> 
> If you could sent out an unmangled patch (even as attachment or on 
> LSI's ftp side) I'd like to take another, closer look.

I am sending this from a Linux box. Hopefully, this will comeout clean.
Sorry for mangled patches.

Signed-off-by: Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>

diff -Naur scsi_misc-a/drivers/scsi/Makefile
scsi_misc-b/drivers/scsi/Makefile
--- scsi_misc-a/drivers/scsi/Makefile	2005-08-25 16:25:07.000000000 -0400
+++ scsi_misc-b/drivers/scsi/Makefile	2005-08-25 16:28:08.000000000 -0400
@@ -96,6 +96,7 @@
 obj-$(CONFIG_SCSI_DC390T)	+= tmscsim.o
 obj-$(CONFIG_MEGARAID_LEGACY)	+= megaraid.o
 obj-$(CONFIG_MEGARAID_NEWGEN)	+= megaraid/
+obj-$(CONFIG_MEGARAID_SAS)	+= megaraid/
 obj-$(CONFIG_SCSI_ACARD)	+= atp870u.o
 obj-$(CONFIG_SCSI_SUNESP)	+= esp.o
 obj-$(CONFIG_SCSI_GDTH)		+= gdth.o
diff -Naur scsi_misc-a/drivers/scsi/megaraid/Kconfig.megaraid
scsi_misc-b/drivers/scsi/megaraid/Kconfig.megaraid
--- scsi_misc-a/drivers/scsi/megaraid/Kconfig.megaraid	2005-08-25
16:25:06.000000000 -0400
+++ scsi_misc-b/drivers/scsi/megaraid/Kconfig.megaraid	2005-08-25
16:27:29.000000000 -0400
@@ -76,3 +76,12 @@
 	To compile this driver as a module, choose M here: the
 	module will be called megaraid
 endif
+
+config MEGARAID_SAS
+	tristate "LSI Logic MegaRAID SAS RAID Module"
+	depends on PCI && SCSI
+	help
+	Module for LSI Logic's SAS based RAID controllers.
+	To compile this driver as a module, choose 'm' here.
+	Module will be called megaraid_sas
+
diff -Naur scsi_misc-a/drivers/scsi/megaraid/Makefile
scsi_misc-b/drivers/scsi/megaraid/Makefile
--- scsi_misc-a/drivers/scsi/megaraid/Makefile	2005-08-25
16:25:06.000000000 -0400
+++ scsi_misc-b/drivers/scsi/megaraid/Makefile	2005-08-25
16:27:23.000000000 -0400
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MEGARAID_MM)	+= megaraid_mm.o
 obj-$(CONFIG_MEGARAID_MAILBOX)	+= megaraid_mbox.o
+obj-$(CONFIG_MEGARAID_SAS)	+= megaraid_sas.o
diff -Naur scsi_misc-a/drivers/scsi/megaraid/megaraid_sas.h
scsi_misc-b/drivers/scsi/megaraid/megaraid_sas.h
--- scsi_misc-a/drivers/scsi/megaraid/megaraid_sas.h	1969-12-31
19:00:00.000000000 -0500
+++ scsi_misc-b/drivers/scsi/megaraid/megaraid_sas.h	2005-08-31
13:24:29.291554792 -0400
@@ -0,0 +1,1123 @@
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
+/**
+ * MegaRAID SAS Driver meta data
+ */
+#define MEGASAS_VERSION				"00.00.02.00-rc1"
+#define MEGASAS_RELDATE				"Aug 28, 2005"
+#define MEGASAS_EXT_VERSION			"Sun Aug 28 21:30:34 EDT
2005"
+
+/*
+ * =====================================
+ * MegaRAID SAS MFI firmware definitions
+ * =====================================
+ */
+
+/*
+ * MFI stands for  MegaRAID SAS FW Interface. This is just a moniker 
+for
+ * protocol between the software and firmware. Commands are issued 
+using
+ * "message frames"
+ */
+
+/**
+ * FW posts its state in upper 4 bits of outbound_msg_0 register  */
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
+ * CLR_HANDSHAKE: FW is waiting for HANDSHAKE from BIOS or Driver  */
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
+	MFI_STAT_OK = 0x00,
+	MFI_STAT_INVALID_CMD = 0x01,
+	MFI_STAT_INVALID_DCMD = 0x02,
+	MFI_STAT_INVALID_PARAMETER = 0x03,
+	MFI_STAT_INVALID_SEQUENCE_NUMBER = 0x04,
+	MFI_STAT_ABORT_NOT_POSSIBLE = 0x05,
+	MFI_STAT_APP_HOST_CODE_NOT_FOUND = 0x06,
+	MFI_STAT_APP_IN_USE = 0x07,
+	MFI_STAT_APP_NOT_INITIALIZED = 0x08,
+	MFI_STAT_ARRAY_INDEX_INVALID = 0x09,
+	MFI_STAT_ARRAY_ROW_NOT_EMPTY = 0x0a,
+	MFI_STAT_CONFIG_RESOURCE_CONFLICT = 0x0b,
+	MFI_STAT_DEVICE_NOT_FOUND = 0x0c,
+	MFI_STAT_DRIVE_TOO_SMALL = 0x0d,
+	MFI_STAT_FLASH_ALLOC_FAIL = 0x0e,
+	MFI_STAT_FLASH_BUSY = 0x0f,
+	MFI_STAT_FLASH_ERROR = 0x10,
+	MFI_STAT_FLASH_IMAGE_BAD = 0x11,
+	MFI_STAT_FLASH_IMAGE_INCOMPLETE = 0x12,
+	MFI_STAT_FLASH_NOT_OPEN = 0x13,
+	MFI_STAT_FLASH_NOT_STARTED = 0x14,
+	MFI_STAT_FLUSH_FAILED = 0x15,
+	MFI_STAT_HOST_CODE_NOT_FOUNT = 0x16,
+	MFI_STAT_LD_CC_IN_PROGRESS = 0x17,
+	MFI_STAT_LD_INIT_IN_PROGRESS = 0x18,
+	MFI_STAT_LD_LBA_OUT_OF_RANGE = 0x19,
+	MFI_STAT_LD_MAX_CONFIGURED = 0x1a,
+	MFI_STAT_LD_NOT_OPTIMAL = 0x1b,
+	MFI_STAT_LD_RBLD_IN_PROGRESS = 0x1c,
+	MFI_STAT_LD_RECON_IN_PROGRESS = 0x1d,
+	MFI_STAT_LD_WRONG_RAID_LEVEL = 0x1e,
+	MFI_STAT_MAX_SPARES_EXCEEDED = 0x1f,
+	MFI_STAT_MEMORY_NOT_AVAILABLE = 0x20,
+	MFI_STAT_MFC_HW_ERROR = 0x21,
+	MFI_STAT_NO_HW_PRESENT = 0x22,
+	MFI_STAT_NOT_FOUND = 0x23,
+	MFI_STAT_NOT_IN_ENCL = 0x24,
+	MFI_STAT_PD_CLEAR_IN_PROGRESS = 0x25,
+	MFI_STAT_PD_TYPE_WRONG = 0x26,
+	MFI_STAT_PR_DISABLED = 0x27,
+	MFI_STAT_ROW_INDEX_INVALID = 0x28,
+	MFI_STAT_SAS_CONFIG_INVALID_ACTION = 0x29,
+	MFI_STAT_SAS_CONFIG_INVALID_DATA = 0x2a,
+	MFI_STAT_SAS_CONFIG_INVALID_PAGE = 0x2b,
+	MFI_STAT_SAS_CONFIG_INVALID_TYPE = 0x2c,
+	MFI_STAT_SCSI_DONE_WITH_ERROR = 0x2d,
+	MFI_STAT_SCSI_IO_FAILED = 0x2e,
+	MFI_STAT_SCSI_RESERVATION_CONFLICT = 0x2f,
+	MFI_STAT_SHUTDOWN_FAILED = 0x30,
+	MFI_STAT_TIME_NOT_SET = 0x31,
+	MFI_STAT_WRONG_STATE = 0x32,
+	MFI_STAT_LD_OFFLINE = 0x33,
+	MFI_STAT_PEER_NOTIFICATION_REJECTED = 0x34,
+	MFI_STAT_PEER_NOTIFICATION_FAILED = 0x35,
+	MFI_STAT_RESERVATION_IN_PROGRESS = 0x36,
+	MFI_STAT_I2C_ERRORS_DETECTED = 0x37,
+	MFI_STAT_PCI_ERRORS_DETECTED = 0x38,
+
+	MFI_STAT_INVALID_STATUS = 0xFF
+};
+
+/*
+ * Number of mailbox bytes in DCMD message frame  */
+#define MFI_MBOX_SIZE				12
+
+enum MR_EVT_CLASS {
+
+	MR_EVT_CLASS_DEBUG = -2,
+	MR_EVT_CLASS_PROGRESS = -1,
+	MR_EVT_CLASS_INFO = 0,
+	MR_EVT_CLASS_WARNING = 1,
+	MR_EVT_CLASS_CRITICAL = 2,
+	MR_EVT_CLASS_FATAL = 3,
+	MR_EVT_CLASS_DEAD = 4,
+
+};
+
+enum MR_EVT_LOCALE {
+
+	MR_EVT_LOCALE_LD = 0x0001,
+	MR_EVT_LOCALE_PD = 0x0002,
+	MR_EVT_LOCALE_ENCL = 0x0004,
+	MR_EVT_LOCALE_BBU = 0x0008,
+	MR_EVT_LOCALE_SAS = 0x0010,
+	MR_EVT_LOCALE_CTRL = 0x0020,
+	MR_EVT_LOCALE_CONFIG = 0x0040,
+	MR_EVT_LOCALE_CLUSTER = 0x0080,
+	MR_EVT_LOCALE_ALL = 0xffff,
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
+	u16 seq_num;
+	u16 pred_fail_poll_interval;
+	u16 intr_throttle_count;
+	u16 intr_throttle_timeouts;
+	u8 rebuild_rate;
+	u8 patrol_read_rate;
+	u8 bgi_rate;
+	u8 cc_rate;
+	u8 recon_rate;
+	u8 cache_flush_interval;
+	u8 spinup_drv_count;
+	u8 spinup_delay;
+	u8 cluster_enable;
+	u8 coercion_mode;
+	u8 alarm_enable;
+	u8 disable_auto_rebuild;
+	u8 disable_battery_warn;
+	u8 ecc_bucket_size;
+	u16 ecc_bucket_leak_rate;
+	u8 restore_hotspare_on_insertion;
+	u8 expose_encl_devices;
+	u8 reserved[38];
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
+		u16 vendor_id;
+		u16 device_id;
+		u16 sub_vendor_id;
+		u16 sub_device_id;
+		u8 reserved[24];
+
+	} __attribute__ ((packed)) pci;
+
+	/*
+	 * Host interface information
+	 */
+	struct {
+
+		u8 PCIX:1;
+		u8 PCIE:1;
+		u8 iSCSI:1;
+		u8 SAS_3G:1;
+		u8 reserved_0:4;
+		u8 reserved_1[6];
+		u8 port_count;
+		u64 port_addr[8];
+
+	} __attribute__ ((packed)) host_interface;
+
+	/*
+	 * Device (backend) interface information
+	 */
+	struct {
+
+		u8 SPI:1;
+		u8 SAS_3G:1;
+		u8 SATA_1_5G:1;
+		u8 SATA_3G:1;
+		u8 reserved_0:4;
+		u8 reserved_1[6];
+		u8 port_count;
+		u64 port_addr[8];
+
+	} __attribute__ ((packed)) device_interface;
+
+	/*
+	 * List of components residing in flash. All str are null terminated
+	 */
+	u32 image_check_word;
+	u32 image_component_count;
+
+	struct {
+
+		char name[8];
+		char version[32];
+		char build_date[16];
+		char built_time[16];
+
+	} __attribute__ ((packed)) image_component[8];
+
+	/*
+	 * List of flash components that have been flashed on the card, but
+	 * are not in use, pending reset of the adapter. This list will be
+	 * empty if a flash operation has not occurred. All stings are null
+	 * terminated
+	 */
+	u32 pending_image_component_count;
+
+	struct {
+
+		char name[8];
+		char version[32];
+		char build_date[16];
+		char build_time[16];
+
+	} __attribute__ ((packed)) pending_image_component[8];
+
+	u8 max_arms;
+	u8 max_spans;
+	u8 max_arrays;
+	u8 max_lds;
+
+	char product_name[80];
+	char serial_no[32];
+
+	/*
+	 * Other physical/controller/operation information. Indicates the
+	 * presence of the hardware
+	 */
+	struct {
+
+		u32 bbu:1;
+		u32 alarm:1;
+		u32 nvram:1;
+		u32 uart:1;
+		u32 reserved:28;
+
+	} __attribute__ ((packed)) hw_present;
+
+	u32 current_fw_time;
+
+	/*
+	 * Maximum data transfer sizes
+	 */
+	u16 max_concurrent_cmds;
+	u16 max_sge_count;
+	u32 max_request_size;
+
+	/*
+	 * Logical and physical device counts
+	 */
+	u16 ld_present_count;
+	u16 ld_degraded_count;
+	u16 ld_offline_count;
+
+	u16 pd_present_count;
+	u16 pd_disk_present_count;
+	u16 pd_disk_pred_failure_count;
+	u16 pd_disk_failed_count;
+
+	/*
+	 * Memory size information
+	 */
+	u16 nvram_size;
+	u16 memory_size;
+	u16 flash_size;
+
+	/*
+	 * Error counters
+	 */
+	u16 mem_correctable_error_count;
+	u16 mem_uncorrectable_error_count;
+
+	/*
+	 * Cluster information
+	 */
+	u8 cluster_permitted;
+	u8 cluster_active;
+
+	/*
+	 * Additional max data transfer sizes
+	 */
+	u16 max_strips_per_io;
+
+	/*
+	 * Controller capabilities structures
+	 */
+	struct {
+
+		u32 raid_level_0:1;
+		u32 raid_level_1:1;
+		u32 raid_level_5:1;
+		u32 raid_level_1E:1;
+		u32 raid_level_6:1;
+		u32 reserved:27;
+
+	} __attribute__ ((packed)) raid_levels;
+
+	struct {
+
+		u32 rbld_rate:1;
+		u32 cc_rate:1;
+		u32 bgi_rate:1;
+		u32 recon_rate:1;
+		u32 patrol_rate:1;
+		u32 alarm_control:1;
+		u32 cluster_supported:1;
+		u32 bbu:1;
+		u32 spanning_allowed:1;
+		u32 dedicated_hotspares:1;
+		u32 revertible_hotspares:1;
+		u32 foreign_config_import:1;
+		u32 self_diagnostic:1;
+		u32 mixed_redundancy_arr:1;
+		u32 global_hot_spares:1;
+		u32 reserved:17;
+
+	} __attribute__ ((packed)) adapter_operations;
+
+	struct {
+
+		u32 read_policy:1;
+		u32 write_policy:1;
+		u32 io_policy:1;
+		u32 access_policy:1;
+		u32 disk_cache_policy:1;
+		u32 reserved:27;
+
+	} __attribute__ ((packed)) ld_operations;
+
+	struct {
+
+		u8 min;
+		u8 max;
+		u8 reserved[2];
+
+	} __attribute__ ((packed)) stripe_sz_ops;
+
+	struct {
+
+		u32 force_online:1;
+		u32 force_offline:1;
+		u32 force_rebuild:1;
+		u32 reserved:29;
+
+	} __attribute__ ((packed)) pd_operations;
+
+	struct {
+
+		u32 ctrl_supports_sas:1;
+		u32 ctrl_supports_sata:1;
+		u32 allow_mix_in_encl:1;
+		u32 allow_mix_in_ld:1;
+		u32 allow_sata_in_cluster:1;
+		u32 reserved:27;
+
+	} __attribute__ ((packed)) pd_mix_support;
+
+	/*
+	 * Define ECC single-bit-error bucket information
+	 */
+	u8 ecc_bucket_count;
+	u8 reserved_2[11];
+
+	/*
+	 * Include the controller properties (changeable items)
+	 */
+	struct megasas_ctrl_prop properties;
+
+	/*
+	 * Define FW pkg version (set in envt v'bles on OEM basis)
+	 */
+	char package_version[0x60];
+
+	u8 pad[0x800 - 0x6a0];
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
+ * MEGASAS_RESET_WAIT_TIME seconds for all outstanding IO to complete. 
+Note
+ * that the driver cannot _actually_ abort or reset pending commands. 
+While
+ * it is waiting for the commands to complete, it prints a diagnostic 
+message
+ * every MEGASAS_RESET_NOTICE_INTERVAL seconds  */
+#define MEGASAS_RESET_WAIT_TIME			180
+#define	MEGASAS_RESET_NOTICE_INTERVAL		5
+
+#define MEGASAS_IOCTL_CMD			0
+
+/*
+ * FW reports the maximum of number of commands that it can accept 
+(maximum
+ * commands that can be outstanding) at any time. The driver must 
+report a
+ * lower number to the mid layer because it can issue a few internal 
+commands
+ * itself (E.g, AEN, abort cmd, IOCTLs etc). The number of commands it 
+needs
+ * is shown below
+ */
+#define MEGASAS_INT_CMDS			32
+
+/*
+ * FW can accept both 32 and 64 bit SGLs. We want to allocate 32/64 bit
+ * SGLs based on the size of dma_addr_t  */
+#define IS_DMA64				(sizeof(dma_addr_t) == 8)
+
+#define MFI_OB_INTR_STATUS_MASK			0x00000002
+#define MFI_POLL_TIMEOUT_SECS			10
+
+struct megasas_register_set {
+
+	u32 reserved_0[4];	/*0000h */
+
+	u32 inbound_msg_0;	/*0010h */
+	u32 inbound_msg_1;	/*0014h */
+	u32 outbound_msg_0;	/*0018h */
+	u32 outbound_msg_1;	/*001Ch */
+
+	u32 inbound_doorbell;	/*0020h */
+	u32 inbound_intr_status;	/*0024h */
+	u32 inbound_intr_mask;	/*0028h */
+
+	u32 outbound_doorbell;	/*002Ch */
+	u32 outbound_intr_status;	/*0030h */
+	u32 outbound_intr_mask;	/*0034h */
+
+	u32 reserved_1[2];	/*0038h */
+
+	u32 inbound_queue_port;	/*0040h */
+	u32 outbound_queue_port;	/*0044h */
+
+	u32 reserved_2;		/*004Ch */
+
+	u32 index_registers[1004];	/*0050h */
+
+} __attribute__ ((packed));
+
+struct megasas_sge32 {
+
+	u32 phys_addr;
+	u32 length;
+
+} __attribute__ ((packed));
+
+struct megasas_sge64 {
+
+	u64 phys_addr;
+	u32 length;
+
+} __attribute__ ((packed));
+
+union megasas_sgl {
+
+	struct megasas_sge32 sge32[1];
+	struct megasas_sge64 sge64[1];
+
+} __attribute__ ((packed));
+
+struct megasas_header {
+
+	u8 cmd;			/*00h */
+	u8 sense_len;		/*01h */
+	u8 cmd_status;		/*02h */
+	u8 scsi_status;		/*03h */
+
+	u8 target_id;		/*04h */
+	u8 lun;			/*05h */
+	u8 cdb_len;		/*06h */
+	u8 sge_count;		/*07h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 timeout;		/*12h */
+	u32 data_xferlen;	/*14h */
+
+} __attribute__ ((packed));
+
+union megasas_sgl_frame {
+
+	struct megasas_sge32 sge32[8];
+	struct megasas_sge64 sge64[5];
+
+} __attribute__ ((packed));
+
+struct megasas_init_frame {
+
+	u8 cmd;			/*00h */
+	u8 reserved_0;		/*01h */
+	u8 cmd_status;		/*02h */
+
+	u8 reserved_1;		/*03h */
+	u32 reserved_2;		/*04h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 reserved_3;		/*12h */
+	u32 data_xfer_len;	/*14h */
+
+	u32 queue_info_new_phys_addr_lo;	/*18h */
+	u32 queue_info_new_phys_addr_hi;	/*1Ch */
+	u32 queue_info_old_phys_addr_lo;	/*20h */
+	u32 queue_info_old_phys_addr_hi;	/*24h */
+
+	u32 reserved_4[6];	/*28h */
+
+} __attribute__ ((packed));
+
+struct megasas_init_queue_info {
+
+	u32 init_flags;		/*00h */
+	u32 reply_queue_entries;	/*04h */
+
+	u32 reply_queue_start_phys_addr_lo;	/*08h */
+	u32 reply_queue_start_phys_addr_hi;	/*0Ch */
+	u32 producer_index_phys_addr_lo;	/*10h */
+	u32 producer_index_phys_addr_hi;	/*14h */
+	u32 consumer_index_phys_addr_lo;	/*18h */
+	u32 consumer_index_phys_addr_hi;	/*1Ch */
+
+} __attribute__ ((packed));
+
+struct megasas_io_frame {
+
+	u8 cmd;			/*00h */
+	u8 sense_len;		/*01h */
+	u8 cmd_status;		/*02h */
+	u8 scsi_status;		/*03h */
+
+	u8 target_id;		/*04h */
+	u8 access_byte;		/*05h */
+	u8 reserved_0;		/*06h */
+	u8 sge_count;		/*07h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 timeout;		/*12h */
+	u32 lba_count;		/*14h */
+
+	u32 sense_buf_phys_addr_lo;	/*18h */
+	u32 sense_buf_phys_addr_hi;	/*1Ch */
+
+	u32 start_lba_lo;	/*20h */
+	u32 start_lba_hi;	/*24h */
+
+	union megasas_sgl sgl;	/*28h */
+
+} __attribute__ ((packed));
+
+struct megasas_pthru_frame {
+
+	u8 cmd;			/*00h */
+	u8 sense_len;		/*01h */
+	u8 cmd_status;		/*02h */
+	u8 scsi_status;		/*03h */
+
+	u8 target_id;		/*04h */
+	u8 lun;			/*05h */
+	u8 cdb_len;		/*06h */
+	u8 sge_count;		/*07h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 timeout;		/*12h */
+	u32 data_xfer_len;	/*14h */
+
+	u32 sense_buf_phys_addr_lo;	/*18h */
+	u32 sense_buf_phys_addr_hi;	/*1Ch */
+
+	u8 cdb[16];		/*20h */
+	union megasas_sgl sgl;	/*30h */
+
+} __attribute__ ((packed));
+
+struct megasas_dcmd_frame {
+
+	u8 cmd;			/*00h */
+	u8 reserved_0;		/*01h */
+	u8 cmd_status;		/*02h */
+	u8 reserved_1[4];	/*03h */
+	u8 sge_count;		/*07h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 timeout;		/*12h */
+
+	u32 data_xfer_len;	/*14h */
+	u32 opcode;		/*18h */
+
+	union {			/*1Ch */
+		u8 b[12];
+		u16 s[6];
+		u32 w[3];
+	} mbox;
+
+	union megasas_sgl sgl;	/*28h */
+
+} __attribute__ ((packed));
+
+struct megasas_abort_frame {
+
+	u8 cmd;			/*00h */
+	u8 reserved_0;		/*01h */
+	u8 cmd_status;		/*02h */
+
+	u8 reserved_1;		/*03h */
+	u32 reserved_2;		/*04h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 reserved_3;		/*12h */
+	u32 reserved_4;		/*14h */
+
+	u32 abort_context;	/*18h */
+	u32 pad_1;		/*1Ch */
+
+	u32 abort_mfi_phys_addr_lo;	/*20h */
+	u32 abort_mfi_phys_addr_hi;	/*24h */
+
+	u32 reserved_5[6];	/*28h */
+
+} __attribute__ ((packed));
+
+struct megasas_smp_frame {
+
+	u8 cmd;			/*00h */
+	u8 reserved_1;		/*01h */
+	u8 cmd_status;		/*02h */
+	u8 connection_status;	/*03h */
+
+	u8 reserved_2[3];	/*04h */
+	u8 sge_count;		/*07h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 timeout;		/*12h */
+
+	u32 data_xfer_len;	/*14h */
+	u64 sas_addr;		/*18h */
+
+	union {
+		struct megasas_sge32 sge32[2];	/* [0]: resp [1]: req */
+		struct megasas_sge64 sge64[2];	/* [0]: resp [1]: req */
+	} sgl;
+
+} __attribute__ ((packed));
+
+struct megasas_stp_frame {
+
+	u8 cmd;			/*00h */
+	u8 reserved_1;		/*01h */
+	u8 cmd_status;		/*02h */
+	u8 reserved_2;		/*03h */
+
+	u8 target_id;		/*04h */
+	u8 reserved_3[2];	/*05h */
+	u8 sge_count;		/*07h */
+
+	u32 context;		/*08h */
+	u32 pad_0;		/*0Ch */
+
+	u16 flags;		/*10h */
+	u16 timeout;		/*12h */
+
+	u32 data_xfer_len;	/*14h */
+
+	u16 fis[10];		/*18h */
+	u32 stp_flags;
+
+	union {
+		struct megasas_sge32 sge32[2];	/* [0]: resp [1]: data */
+		struct megasas_sge64 sge64[2];	/* [0]: resp [1]: data */
+	} sgl;
+
+} __attribute__ ((packed));
+
+union megasas_frame {
+
+	struct megasas_header hdr;
+	struct megasas_init_frame init;
+	struct megasas_io_frame io;
+	struct megasas_pthru_frame pthru;
+	struct megasas_dcmd_frame dcmd;
+	struct megasas_abort_frame abort;
+	struct megasas_smp_frame smp;
+	struct megasas_stp_frame stp;
+
+	u8 raw_bytes[64];
+};
+
+struct megasas_cmd;
+
+union megasas_evt_class_locale {
+
+	struct {
+		u16 locale;
+		u8 reserved;
+		s8 class;
+	} __attribute__ ((packed)) members;
+
+	u32 word;
+
+} __attribute__ ((packed));
+
+struct megasas_evt_log_info {
+	u32 newest_seq_num;
+	u32 oldest_seq_num;
+	u32 clear_seq_num;
+	u32 shutdown_seq_num;
+	u32 boot_seq_num;
+
+} __attribute__ ((packed));
+
+struct megasas_progress {
+
+	u16 progress;
+	u16 elapsed_seconds;
+
+} __attribute__ ((packed));
+
+struct megasas_evtarg_ld {
+
+	u16 target_id;
+	u8 ld_index;
+	u8 reserved;
+
+} __attribute__ ((packed));
+
+struct megasas_evtarg_pd {
+	u16 device_id;
+	u8 encl_index;
+	u8 slot_number;
+
+} __attribute__ ((packed));
+
+struct megasas_evt_detail {
+
+	u32 seq_num;
+	u32 time_stamp;
+	u32 code;
+	union megasas_evt_class_locale cl;
+	u8 arg_type;
+	u8 reserved1[15];
+
+	union {
+		struct {
+			struct megasas_evtarg_pd pd;
+			u8 cdb_length;
+			u8 sense_length;
+			u8 reserved[2];
+			u8 cdb[16];
+			u8 sense[64];
+		} __attribute__ ((packed)) cdbSense;
+
+		struct megasas_evtarg_ld ld;
+
+		struct {
+			struct megasas_evtarg_ld ld;
+			u64 count;
+		} __attribute__ ((packed)) ld_count;
+
+		struct {
+			u64 lba;
+			struct megasas_evtarg_ld ld;
+		} __attribute__ ((packed)) ld_lba;
+
+		struct {
+			struct megasas_evtarg_ld ld;
+			u32 prevOwner;
+			u32 newOwner;
+		} __attribute__ ((packed)) ld_owner;
+
+		struct {
+			u64 ld_lba;
+			u64 pd_lba;
+			struct megasas_evtarg_ld ld;
+			struct megasas_evtarg_pd pd;
+		} __attribute__ ((packed)) ld_lba_pd_lba;
+
+		struct {
+			struct megasas_evtarg_ld ld;
+			struct megasas_progress prog;
+		} __attribute__ ((packed)) ld_prog;
+
+		struct {
+			struct megasas_evtarg_ld ld;
+			u32 prev_state;
+			u32 new_state;
+		} __attribute__ ((packed)) ld_state;
+
+		struct {
+			u64 strip;
+			struct megasas_evtarg_ld ld;
+		} __attribute__ ((packed)) ld_strip;
+
+		struct megasas_evtarg_pd pd;
+
+		struct {
+			struct megasas_evtarg_pd pd;
+			u32 err;
+		} __attribute__ ((packed)) pd_err;
+
+		struct {
+			u64 lba;
+			struct megasas_evtarg_pd pd;
+		} __attribute__ ((packed)) pd_lba;
+
+		struct {
+			u64 lba;
+			struct megasas_evtarg_pd pd;
+			struct megasas_evtarg_ld ld;
+		} __attribute__ ((packed)) pd_lba_ld;
+
+		struct {
+			struct megasas_evtarg_pd pd;
+			struct megasas_progress prog;
+		} __attribute__ ((packed)) pd_prog;
+
+		struct {
+			struct megasas_evtarg_pd pd;
+			u32 prevState;
+			u32 newState;
+		} __attribute__ ((packed)) pd_state;
+
+		struct {
+			u16 vendorId;
+			u16 deviceId;
+			u16 subVendorId;
+			u16 subDeviceId;
+		} __attribute__ ((packed)) pci;
+
+		u32 rate;
+		char str[96];
+
+		struct {
+			u32 rtc;
+			u32 elapsedSeconds;
+		} __attribute__ ((packed)) time;
+
+		struct {
+			u32 ecar;
+			u32 elog;
+			char str[64];
+		} __attribute__ ((packed)) ecc;
+
+		u8 b[96];
+		u16 s[48];
+		u32 w[24];
+		u64 d[12];
+	} args;
+
+	char description[128];
+
+} __attribute__ ((packed));
+
+struct megasas_instance {
+
+	u32 *producer;
+	dma_addr_t producer_h;
+	u32 *consumer;
+	dma_addr_t consumer_h;
+
+	u32 *reply_queue;
+	dma_addr_t reply_queue_h;
+
+	unsigned long base_addr;
+	struct megasas_register_set __iomem *reg_set;
+
+	s8 init_id;
+	u8 reserved[3];
+
+	u16 max_num_sge;
+	u16 max_fw_cmds;
+	u32 max_sectors_per_req;
+
+	struct megasas_cmd **cmd_list;
+	struct list_head cmd_pool;
+	spinlock_t cmd_pool_lock;
+	struct dma_pool *frame_dma_pool;
+	struct dma_pool *sense_dma_pool;
+
+	struct megasas_evt_detail *evt_detail;
+	dma_addr_t evt_detail_h;
+	struct megasas_cmd *aen_cmd;
+	struct semaphore aen_mutex;
+	struct semaphore ioctl_sem;
+
+	struct Scsi_Host *host;
+
+	wait_queue_head_t int_cmd_wait_q;
+	wait_queue_head_t abort_cmd_wait_q;
+
+	struct pci_dev *pdev;
+	u32 unique_id;
+
+	u32 fw_outstanding;
+	u32 hw_crit_error;
+	spinlock_t instance_lock;
+};
+
+#define MEGASAS_IS_LOGICAL(scp)
\
+	(scp->device->channel < MEGASAS_MAX_PD_CHANNELS) ? 0 : 1
+
+#define MEGASAS_DEV_INDEX(inst, scp)					\
+	((scp->device->channel % 2) * MEGASAS_MAX_DEV_PER_CHANNEL) + 	\
+	scp->device->id
+
+struct megasas_cmd {
+
+	union megasas_frame *frame;
+	dma_addr_t frame_phys_addr;
+	u8 *sense;
+	dma_addr_t sense_phys_addr;
+
+	u32 index;
+	u8 sync_cmd;
+	u8 cmd_status;
+	u16 abort_aen;
+
+	struct list_head list;
+	struct scsi_cmnd *scmd;
+	struct megasas_instance *instance;
+	u32 frame_count;
+};
+
+#define MAX_MGMT_ADAPTERS		1024
+#define MAX_IOCTL_SGE			16
+
+struct megasas_iocpacket {
+
+	u16 host_no;
+	u16 __pad1;
+	u32 sgl_off;
+	u32 sge_count;
+	u32 sense_off;
+	u32 sense_len;
+	union {
+		u8 raw[128];
+		struct megasas_header hdr;
+	} frame;
+
+	struct iovec sgl[MAX_IOCTL_SGE];
+
+} __attribute__ ((packed));
+
+struct megasas_aen {
+	u16 host_no;
+	u16 __pad1;
+	u32 seq_num;
+	u32 class_locale_word;
+};
+
+#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct megasas_iocpacket)
+#define MEGASAS_IOC_GET_AEN	_IOW('M', 2, struct megasas_aen)
+
+struct megasas_mgmt_info {
+
+	u16 count;
+	struct megasas_instance *instance[MAX_MGMT_ADAPTERS];
+	int max_index;
+};
+
+#endif				/*LSI_MEGARAID_SAS_H */
diff -Naur scsi_misc-a/include/linux/pci_ids.h
scsi_misc-b/include/linux/pci_ids.h
--- scsi_misc-a/include/linux/pci_ids.h	2005-08-25 16:24:10.000000000 -0400
+++ scsi_misc-b/include/linux/pci_ids.h	2005-08-25 16:25:55.000000000 -0400
@@ -185,6 +185,7 @@
 #define PCI_DEVICE_ID_LSI_61C102	0x0901
 #define PCI_DEVICE_ID_LSI_63C815	0x1000
 #define PCI_DEVICE_ID_LSI_SAS1064	0x0050
+#define PCI_DEVICE_ID_LSI_SAS1064R	0x0411
 #define PCI_DEVICE_ID_LSI_SAS1066	0x005E
 #define PCI_DEVICE_ID_LSI_SAS1068	0x0054
 #define PCI_DEVICE_ID_LSI_SAS1064A	0x005C
@@ -554,6 +555,7 @@
 #define PCI_VENDOR_ID_DELL		0x1028
 #define PCI_DEVICE_ID_DELL_RACIII	0x0008
 #define PCI_DEVICE_ID_DELL_RAC4		0x0012
+#define PCI_DEVICE_ID_DELL_PERC5	0x0015
 
 #define PCI_VENDOR_ID_MATROX		0x102B
 #define PCI_DEVICE_ID_MATROX_MGA_2	0x0518



------_=_NextPart_000_01C5AE8C.DCE07840
Content-Type: application/octet-stream;
	name="megaraid_sas_1of2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid_sas_1of2.patch"

diff -Naur scsi_misc-a/drivers/scsi/Makefile =
scsi_misc-b/drivers/scsi/Makefile=0A=
--- scsi_misc-a/drivers/scsi/Makefile	2005-08-25 16:25:07.000000000 =
-0400=0A=
+++ scsi_misc-b/drivers/scsi/Makefile	2005-08-25 16:28:08.000000000 =
-0400=0A=
@@ -96,6 +96,7 @@=0A=
 obj-$(CONFIG_SCSI_DC390T)	+=3D tmscsim.o=0A=
 obj-$(CONFIG_MEGARAID_LEGACY)	+=3D megaraid.o=0A=
 obj-$(CONFIG_MEGARAID_NEWGEN)	+=3D megaraid/=0A=
+obj-$(CONFIG_MEGARAID_SAS)	+=3D megaraid/=0A=
 obj-$(CONFIG_SCSI_ACARD)	+=3D atp870u.o=0A=
 obj-$(CONFIG_SCSI_SUNESP)	+=3D esp.o=0A=
 obj-$(CONFIG_SCSI_GDTH)		+=3D gdth.o=0A=
diff -Naur scsi_misc-a/drivers/scsi/megaraid/Kconfig.megaraid =
scsi_misc-b/drivers/scsi/megaraid/Kconfig.megaraid=0A=
--- scsi_misc-a/drivers/scsi/megaraid/Kconfig.megaraid	2005-08-25 =
16:25:06.000000000 -0400=0A=
+++ scsi_misc-b/drivers/scsi/megaraid/Kconfig.megaraid	2005-08-25 =
16:27:29.000000000 -0400=0A=
@@ -76,3 +76,12 @@=0A=
 	To compile this driver as a module, choose M here: the=0A=
 	module will be called megaraid=0A=
 endif=0A=
+=0A=
+config MEGARAID_SAS=0A=
+	tristate "LSI Logic MegaRAID SAS RAID Module"=0A=
+	depends on PCI && SCSI=0A=
+	help=0A=
+	Module for LSI Logic's SAS based RAID controllers.=0A=
+	To compile this driver as a module, choose 'm' here.=0A=
+	Module will be called megaraid_sas=0A=
+=0A=
diff -Naur scsi_misc-a/drivers/scsi/megaraid/Makefile =
scsi_misc-b/drivers/scsi/megaraid/Makefile=0A=
--- scsi_misc-a/drivers/scsi/megaraid/Makefile	2005-08-25 =
16:25:06.000000000 -0400=0A=
+++ scsi_misc-b/drivers/scsi/megaraid/Makefile	2005-08-25 =
16:27:23.000000000 -0400=0A=
@@ -1,2 +1,3 @@=0A=
 obj-$(CONFIG_MEGARAID_MM)	+=3D megaraid_mm.o=0A=
 obj-$(CONFIG_MEGARAID_MAILBOX)	+=3D megaraid_mbox.o=0A=
+obj-$(CONFIG_MEGARAID_SAS)	+=3D megaraid_sas.o=0A=
diff -Naur scsi_misc-a/drivers/scsi/megaraid/megaraid_sas.h =
scsi_misc-b/drivers/scsi/megaraid/megaraid_sas.h=0A=
--- scsi_misc-a/drivers/scsi/megaraid/megaraid_sas.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ scsi_misc-b/drivers/scsi/megaraid/megaraid_sas.h	2005-08-31 =
13:24:29.291554792 -0400=0A=
@@ -0,0 +1,1123 @@=0A=
+/*=0A=
+ *=0A=
+ *		Linux MegaRAID driver for SAS based RAID controllers=0A=
+ *=0A=
+ * Copyright (c) 2003-2005  LSI Logic Corporation.=0A=
+ *=0A=
+ *		This program is free software; you can redistribute it and/or=0A=
+ *		modify it under the terms of the GNU General Public License=0A=
+ *		as published by the Free Software Foundation; either version=0A=
+ *		2 of the License, or (at your option) any later version.=0A=
+ *=0A=
+ * FILE		: megaraid_sas.h=0A=
+ */=0A=
+=0A=
+#ifndef LSI_MEGARAID_SAS_H=0A=
+#define LSI_MEGARAID_SAS_H=0A=
+=0A=
+/**=0A=
+ * MegaRAID SAS Driver meta data=0A=
+ */=0A=
+#define MEGASAS_VERSION				"00.00.02.00-rc1"=0A=
+#define MEGASAS_RELDATE				"Aug 28, 2005"=0A=
+#define MEGASAS_EXT_VERSION			"Sun Aug 28 21:30:34 EDT 2005"=0A=
+=0A=
+/*=0A=
+ * =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+ * MegaRAID SAS MFI firmware definitions=0A=
+ * =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * MFI stands for  MegaRAID SAS FW Interface. This is just a moniker =
for =0A=
+ * protocol between the software and firmware. Commands are issued =
using=0A=
+ * "message frames"=0A=
+ */=0A=
+=0A=
+/**=0A=
+ * FW posts its state in upper 4 bits of outbound_msg_0 register=0A=
+ */=0A=
+#define MFI_STATE_MASK				0xF0000000=0A=
+#define MFI_STATE_UNDEFINED			0x00000000=0A=
+#define MFI_STATE_BB_INIT			0x10000000=0A=
+#define MFI_STATE_FW_INIT			0x40000000=0A=
+#define MFI_STATE_WAIT_HANDSHAKE		0x60000000=0A=
+#define MFI_STATE_FW_INIT_2			0x70000000=0A=
+#define MFI_STATE_DEVICE_SCAN			0x80000000=0A=
+#define MFI_STATE_FLUSH_CACHE			0xA0000000=0A=
+#define MFI_STATE_READY				0xB0000000=0A=
+#define MFI_STATE_OPERATIONAL			0xC0000000=0A=
+#define MFI_STATE_FAULT				0xF0000000=0A=
+=0A=
+#define MEGAMFI_FRAME_SIZE			64=0A=
+=0A=
+/**=0A=
+ * During FW init, clear pending cmds & reset state using =
inbound_msg_0=0A=
+ *=0A=
+ * ABORT	: Abort all pending cmds=0A=
+ * READY	: Move from OPERATIONAL to READY state; discard queue info=0A=
+ * MFIMODE	: Discard (possible) low MFA posted in 64-bit mode (??)=0A=
+ * CLR_HANDSHAKE: FW is waiting for HANDSHAKE from BIOS or Driver=0A=
+ */=0A=
+#define MFI_INIT_ABORT				0x00000000=0A=
+#define MFI_INIT_READY				0x00000002=0A=
+#define MFI_INIT_MFIMODE			0x00000004=0A=
+#define MFI_INIT_CLEAR_HANDSHAKE		0x00000008=0A=
+#define MFI_RESET_FLAGS				MFI_INIT_READY|MFI_INIT_MFIMODE=0A=
+=0A=
+/**=0A=
+ * MFI frame flags=0A=
+ */=0A=
+#define MFI_FRAME_POST_IN_REPLY_QUEUE		0x0000=0A=
+#define MFI_FRAME_DONT_POST_IN_REPLY_QUEUE	0x0001=0A=
+#define MFI_FRAME_SGL32				0x0000=0A=
+#define MFI_FRAME_SGL64				0x0002=0A=
+#define MFI_FRAME_SENSE32			0x0000=0A=
+#define MFI_FRAME_SENSE64			0x0004=0A=
+#define MFI_FRAME_DIR_NONE			0x0000=0A=
+#define MFI_FRAME_DIR_WRITE			0x0008=0A=
+#define MFI_FRAME_DIR_READ			0x0010=0A=
+#define MFI_FRAME_DIR_BOTH			0x0018=0A=
+=0A=
+/**=0A=
+ * Definition for cmd_status=0A=
+ */=0A=
+#define MFI_CMD_STATUS_POLL_MODE		0xFF=0A=
+=0A=
+/**=0A=
+ * MFI command opcodes=0A=
+ */=0A=
+#define MFI_CMD_INIT				0x00=0A=
+#define MFI_CMD_LD_READ				0x01=0A=
+#define MFI_CMD_LD_WRITE			0x02=0A=
+#define MFI_CMD_LD_SCSI_IO			0x03=0A=
+#define MFI_CMD_PD_SCSI_IO			0x04=0A=
+#define MFI_CMD_DCMD				0x05=0A=
+#define MFI_CMD_ABORT				0x06=0A=
+#define MFI_CMD_SMP				0x07=0A=
+#define MFI_CMD_STP				0x08=0A=
+=0A=
+#define MR_DCMD_CTRL_GET_INFO			0x01010000=0A=
+=0A=
+#define MR_DCMD_CTRL_CACHE_FLUSH		0x01101000=0A=
+#define MR_FLUSH_CTRL_CACHE			0x01=0A=
+#define MR_FLUSH_DISK_CACHE			0x02=0A=
+=0A=
+#define MR_DCMD_CTRL_SHUTDOWN			0x01050000=0A=
+#define MR_ENABLE_DRIVE_SPINDOWN		0x01=0A=
+=0A=
+#define MR_DCMD_CTRL_EVENT_GET_INFO		0x01040100=0A=
+#define MR_DCMD_CTRL_EVENT_GET			0x01040300=0A=
+#define MR_DCMD_CTRL_EVENT_WAIT			0x01040500=0A=
+#define MR_DCMD_LD_GET_PROPERTIES		0x03030000=0A=
+=0A=
+#define MR_DCMD_CLUSTER				0x08000000=0A=
+#define MR_DCMD_CLUSTER_RESET_ALL		0x08010100=0A=
+#define MR_DCMD_CLUSTER_RESET_LD		0x08010200=0A=
+=0A=
+/**=0A=
+ * MFI command completion codes=0A=
+ */=0A=
+enum MFI_STAT {=0A=
+	MFI_STAT_OK =3D 0x00,=0A=
+	MFI_STAT_INVALID_CMD =3D 0x01,=0A=
+	MFI_STAT_INVALID_DCMD =3D 0x02,=0A=
+	MFI_STAT_INVALID_PARAMETER =3D 0x03,=0A=
+	MFI_STAT_INVALID_SEQUENCE_NUMBER =3D 0x04,=0A=
+	MFI_STAT_ABORT_NOT_POSSIBLE =3D 0x05,=0A=
+	MFI_STAT_APP_HOST_CODE_NOT_FOUND =3D 0x06,=0A=
+	MFI_STAT_APP_IN_USE =3D 0x07,=0A=
+	MFI_STAT_APP_NOT_INITIALIZED =3D 0x08,=0A=
+	MFI_STAT_ARRAY_INDEX_INVALID =3D 0x09,=0A=
+	MFI_STAT_ARRAY_ROW_NOT_EMPTY =3D 0x0a,=0A=
+	MFI_STAT_CONFIG_RESOURCE_CONFLICT =3D 0x0b,=0A=
+	MFI_STAT_DEVICE_NOT_FOUND =3D 0x0c,=0A=
+	MFI_STAT_DRIVE_TOO_SMALL =3D 0x0d,=0A=
+	MFI_STAT_FLASH_ALLOC_FAIL =3D 0x0e,=0A=
+	MFI_STAT_FLASH_BUSY =3D 0x0f,=0A=
+	MFI_STAT_FLASH_ERROR =3D 0x10,=0A=
+	MFI_STAT_FLASH_IMAGE_BAD =3D 0x11,=0A=
+	MFI_STAT_FLASH_IMAGE_INCOMPLETE =3D 0x12,=0A=
+	MFI_STAT_FLASH_NOT_OPEN =3D 0x13,=0A=
+	MFI_STAT_FLASH_NOT_STARTED =3D 0x14,=0A=
+	MFI_STAT_FLUSH_FAILED =3D 0x15,=0A=
+	MFI_STAT_HOST_CODE_NOT_FOUNT =3D 0x16,=0A=
+	MFI_STAT_LD_CC_IN_PROGRESS =3D 0x17,=0A=
+	MFI_STAT_LD_INIT_IN_PROGRESS =3D 0x18,=0A=
+	MFI_STAT_LD_LBA_OUT_OF_RANGE =3D 0x19,=0A=
+	MFI_STAT_LD_MAX_CONFIGURED =3D 0x1a,=0A=
+	MFI_STAT_LD_NOT_OPTIMAL =3D 0x1b,=0A=
+	MFI_STAT_LD_RBLD_IN_PROGRESS =3D 0x1c,=0A=
+	MFI_STAT_LD_RECON_IN_PROGRESS =3D 0x1d,=0A=
+	MFI_STAT_LD_WRONG_RAID_LEVEL =3D 0x1e,=0A=
+	MFI_STAT_MAX_SPARES_EXCEEDED =3D 0x1f,=0A=
+	MFI_STAT_MEMORY_NOT_AVAILABLE =3D 0x20,=0A=
+	MFI_STAT_MFC_HW_ERROR =3D 0x21,=0A=
+	MFI_STAT_NO_HW_PRESENT =3D 0x22,=0A=
+	MFI_STAT_NOT_FOUND =3D 0x23,=0A=
+	MFI_STAT_NOT_IN_ENCL =3D 0x24,=0A=
+	MFI_STAT_PD_CLEAR_IN_PROGRESS =3D 0x25,=0A=
+	MFI_STAT_PD_TYPE_WRONG =3D 0x26,=0A=
+	MFI_STAT_PR_DISABLED =3D 0x27,=0A=
+	MFI_STAT_ROW_INDEX_INVALID =3D 0x28,=0A=
+	MFI_STAT_SAS_CONFIG_INVALID_ACTION =3D 0x29,=0A=
+	MFI_STAT_SAS_CONFIG_INVALID_DATA =3D 0x2a,=0A=
+	MFI_STAT_SAS_CONFIG_INVALID_PAGE =3D 0x2b,=0A=
+	MFI_STAT_SAS_CONFIG_INVALID_TYPE =3D 0x2c,=0A=
+	MFI_STAT_SCSI_DONE_WITH_ERROR =3D 0x2d,=0A=
+	MFI_STAT_SCSI_IO_FAILED =3D 0x2e,=0A=
+	MFI_STAT_SCSI_RESERVATION_CONFLICT =3D 0x2f,=0A=
+	MFI_STAT_SHUTDOWN_FAILED =3D 0x30,=0A=
+	MFI_STAT_TIME_NOT_SET =3D 0x31,=0A=
+	MFI_STAT_WRONG_STATE =3D 0x32,=0A=
+	MFI_STAT_LD_OFFLINE =3D 0x33,=0A=
+	MFI_STAT_PEER_NOTIFICATION_REJECTED =3D 0x34,=0A=
+	MFI_STAT_PEER_NOTIFICATION_FAILED =3D 0x35,=0A=
+	MFI_STAT_RESERVATION_IN_PROGRESS =3D 0x36,=0A=
+	MFI_STAT_I2C_ERRORS_DETECTED =3D 0x37,=0A=
+	MFI_STAT_PCI_ERRORS_DETECTED =3D 0x38,=0A=
+=0A=
+	MFI_STAT_INVALID_STATUS =3D 0xFF=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Number of mailbox bytes in DCMD message frame=0A=
+ */=0A=
+#define MFI_MBOX_SIZE				12=0A=
+=0A=
+enum MR_EVT_CLASS {=0A=
+=0A=
+	MR_EVT_CLASS_DEBUG =3D -2,=0A=
+	MR_EVT_CLASS_PROGRESS =3D -1,=0A=
+	MR_EVT_CLASS_INFO =3D 0,=0A=
+	MR_EVT_CLASS_WARNING =3D 1,=0A=
+	MR_EVT_CLASS_CRITICAL =3D 2,=0A=
+	MR_EVT_CLASS_FATAL =3D 3,=0A=
+	MR_EVT_CLASS_DEAD =3D 4,=0A=
+=0A=
+};=0A=
+=0A=
+enum MR_EVT_LOCALE {=0A=
+=0A=
+	MR_EVT_LOCALE_LD =3D 0x0001,=0A=
+	MR_EVT_LOCALE_PD =3D 0x0002,=0A=
+	MR_EVT_LOCALE_ENCL =3D 0x0004,=0A=
+	MR_EVT_LOCALE_BBU =3D 0x0008,=0A=
+	MR_EVT_LOCALE_SAS =3D 0x0010,=0A=
+	MR_EVT_LOCALE_CTRL =3D 0x0020,=0A=
+	MR_EVT_LOCALE_CONFIG =3D 0x0040,=0A=
+	MR_EVT_LOCALE_CLUSTER =3D 0x0080,=0A=
+	MR_EVT_LOCALE_ALL =3D 0xffff,=0A=
+=0A=
+};=0A=
+=0A=
+enum MR_EVT_ARGS {=0A=
+=0A=
+	MR_EVT_ARGS_NONE,=0A=
+	MR_EVT_ARGS_CDB_SENSE,=0A=
+	MR_EVT_ARGS_LD,=0A=
+	MR_EVT_ARGS_LD_COUNT,=0A=
+	MR_EVT_ARGS_LD_LBA,=0A=
+	MR_EVT_ARGS_LD_OWNER,=0A=
+	MR_EVT_ARGS_LD_LBA_PD_LBA,=0A=
+	MR_EVT_ARGS_LD_PROG,=0A=
+	MR_EVT_ARGS_LD_STATE,=0A=
+	MR_EVT_ARGS_LD_STRIP,=0A=
+	MR_EVT_ARGS_PD,=0A=
+	MR_EVT_ARGS_PD_ERR,=0A=
+	MR_EVT_ARGS_PD_LBA,=0A=
+	MR_EVT_ARGS_PD_LBA_LD,=0A=
+	MR_EVT_ARGS_PD_PROG,=0A=
+	MR_EVT_ARGS_PD_STATE,=0A=
+	MR_EVT_ARGS_PCI,=0A=
+	MR_EVT_ARGS_RATE,=0A=
+	MR_EVT_ARGS_STR,=0A=
+	MR_EVT_ARGS_TIME,=0A=
+	MR_EVT_ARGS_ECC,=0A=
+=0A=
+};=0A=
+=0A=
+/*=0A=
+ * SAS controller properties=0A=
+ */=0A=
+struct megasas_ctrl_prop {=0A=
+=0A=
+	u16 seq_num;=0A=
+	u16 pred_fail_poll_interval;=0A=
+	u16 intr_throttle_count;=0A=
+	u16 intr_throttle_timeouts;=0A=
+	u8 rebuild_rate;=0A=
+	u8 patrol_read_rate;=0A=
+	u8 bgi_rate;=0A=
+	u8 cc_rate;=0A=
+	u8 recon_rate;=0A=
+	u8 cache_flush_interval;=0A=
+	u8 spinup_drv_count;=0A=
+	u8 spinup_delay;=0A=
+	u8 cluster_enable;=0A=
+	u8 coercion_mode;=0A=
+	u8 alarm_enable;=0A=
+	u8 disable_auto_rebuild;=0A=
+	u8 disable_battery_warn;=0A=
+	u8 ecc_bucket_size;=0A=
+	u16 ecc_bucket_leak_rate;=0A=
+	u8 restore_hotspare_on_insertion;=0A=
+	u8 expose_encl_devices;=0A=
+	u8 reserved[38];=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+/*=0A=
+ * SAS controller information=0A=
+ */=0A=
+struct megasas_ctrl_info {=0A=
+=0A=
+	/*=0A=
+	 * PCI device information=0A=
+	 */=0A=
+	struct {=0A=
+=0A=
+		u16 vendor_id;=0A=
+		u16 device_id;=0A=
+		u16 sub_vendor_id;=0A=
+		u16 sub_device_id;=0A=
+		u8 reserved[24];=0A=
+=0A=
+	} __attribute__ ((packed)) pci;=0A=
+=0A=
+	/*=0A=
+	 * Host interface information=0A=
+	 */=0A=
+	struct {=0A=
+=0A=
+		u8 PCIX:1;=0A=
+		u8 PCIE:1;=0A=
+		u8 iSCSI:1;=0A=
+		u8 SAS_3G:1;=0A=
+		u8 reserved_0:4;=0A=
+		u8 reserved_1[6];=0A=
+		u8 port_count;=0A=
+		u64 port_addr[8];=0A=
+=0A=
+	} __attribute__ ((packed)) host_interface;=0A=
+=0A=
+	/*=0A=
+	 * Device (backend) interface information=0A=
+	 */=0A=
+	struct {=0A=
+=0A=
+		u8 SPI:1;=0A=
+		u8 SAS_3G:1;=0A=
+		u8 SATA_1_5G:1;=0A=
+		u8 SATA_3G:1;=0A=
+		u8 reserved_0:4;=0A=
+		u8 reserved_1[6];=0A=
+		u8 port_count;=0A=
+		u64 port_addr[8];=0A=
+=0A=
+	} __attribute__ ((packed)) device_interface;=0A=
+=0A=
+	/*=0A=
+	 * List of components residing in flash. All str are null =
terminated=0A=
+	 */=0A=
+	u32 image_check_word;=0A=
+	u32 image_component_count;=0A=
+=0A=
+	struct {=0A=
+=0A=
+		char name[8];=0A=
+		char version[32];=0A=
+		char build_date[16];=0A=
+		char built_time[16];=0A=
+=0A=
+	} __attribute__ ((packed)) image_component[8];=0A=
+=0A=
+	/*=0A=
+	 * List of flash components that have been flashed on the card, =
but=0A=
+	 * are not in use, pending reset of the adapter. This list will be=0A=
+	 * empty if a flash operation has not occurred. All stings are =
null=0A=
+	 * terminated=0A=
+	 */=0A=
+	u32 pending_image_component_count;=0A=
+=0A=
+	struct {=0A=
+=0A=
+		char name[8];=0A=
+		char version[32];=0A=
+		char build_date[16];=0A=
+		char build_time[16];=0A=
+=0A=
+	} __attribute__ ((packed)) pending_image_component[8];=0A=
+=0A=
+	u8 max_arms;=0A=
+	u8 max_spans;=0A=
+	u8 max_arrays;=0A=
+	u8 max_lds;=0A=
+=0A=
+	char product_name[80];=0A=
+	char serial_no[32];=0A=
+=0A=
+	/*=0A=
+	 * Other physical/controller/operation information. Indicates the=0A=
+	 * presence of the hardware=0A=
+	 */=0A=
+	struct {=0A=
+=0A=
+		u32 bbu:1;=0A=
+		u32 alarm:1;=0A=
+		u32 nvram:1;=0A=
+		u32 uart:1;=0A=
+		u32 reserved:28;=0A=
+=0A=
+	} __attribute__ ((packed)) hw_present;=0A=
+=0A=
+	u32 current_fw_time;=0A=
+=0A=
+	/*=0A=
+	 * Maximum data transfer sizes=0A=
+	 */=0A=
+	u16 max_concurrent_cmds;=0A=
+	u16 max_sge_count;=0A=
+	u32 max_request_size;=0A=
+=0A=
+	/*=0A=
+	 * Logical and physical device counts=0A=
+	 */=0A=
+	u16 ld_present_count;=0A=
+	u16 ld_degraded_count;=0A=
+	u16 ld_offline_count;=0A=
+=0A=
+	u16 pd_present_count;=0A=
+	u16 pd_disk_present_count;=0A=
+	u16 pd_disk_pred_failure_count;=0A=
+	u16 pd_disk_failed_count;=0A=
+=0A=
+	/*=0A=
+	 * Memory size information=0A=
+	 */=0A=
+	u16 nvram_size;=0A=
+	u16 memory_size;=0A=
+	u16 flash_size;=0A=
+=0A=
+	/*=0A=
+	 * Error counters=0A=
+	 */=0A=
+	u16 mem_correctable_error_count;=0A=
+	u16 mem_uncorrectable_error_count;=0A=
+=0A=
+	/*=0A=
+	 * Cluster information=0A=
+	 */=0A=
+	u8 cluster_permitted;=0A=
+	u8 cluster_active;=0A=
+=0A=
+	/*=0A=
+	 * Additional max data transfer sizes=0A=
+	 */=0A=
+	u16 max_strips_per_io;=0A=
+=0A=
+	/*=0A=
+	 * Controller capabilities structures=0A=
+	 */=0A=
+	struct {=0A=
+=0A=
+		u32 raid_level_0:1;=0A=
+		u32 raid_level_1:1;=0A=
+		u32 raid_level_5:1;=0A=
+		u32 raid_level_1E:1;=0A=
+		u32 raid_level_6:1;=0A=
+		u32 reserved:27;=0A=
+=0A=
+	} __attribute__ ((packed)) raid_levels;=0A=
+=0A=
+	struct {=0A=
+=0A=
+		u32 rbld_rate:1;=0A=
+		u32 cc_rate:1;=0A=
+		u32 bgi_rate:1;=0A=
+		u32 recon_rate:1;=0A=
+		u32 patrol_rate:1;=0A=
+		u32 alarm_control:1;=0A=
+		u32 cluster_supported:1;=0A=
+		u32 bbu:1;=0A=
+		u32 spanning_allowed:1;=0A=
+		u32 dedicated_hotspares:1;=0A=
+		u32 revertible_hotspares:1;=0A=
+		u32 foreign_config_import:1;=0A=
+		u32 self_diagnostic:1;=0A=
+		u32 mixed_redundancy_arr:1;=0A=
+		u32 global_hot_spares:1;=0A=
+		u32 reserved:17;=0A=
+=0A=
+	} __attribute__ ((packed)) adapter_operations;=0A=
+=0A=
+	struct {=0A=
+=0A=
+		u32 read_policy:1;=0A=
+		u32 write_policy:1;=0A=
+		u32 io_policy:1;=0A=
+		u32 access_policy:1;=0A=
+		u32 disk_cache_policy:1;=0A=
+		u32 reserved:27;=0A=
+=0A=
+	} __attribute__ ((packed)) ld_operations;=0A=
+=0A=
+	struct {=0A=
+=0A=
+		u8 min;=0A=
+		u8 max;=0A=
+		u8 reserved[2];=0A=
+=0A=
+	} __attribute__ ((packed)) stripe_sz_ops;=0A=
+=0A=
+	struct {=0A=
+=0A=
+		u32 force_online:1;=0A=
+		u32 force_offline:1;=0A=
+		u32 force_rebuild:1;=0A=
+		u32 reserved:29;=0A=
+=0A=
+	} __attribute__ ((packed)) pd_operations;=0A=
+=0A=
+	struct {=0A=
+=0A=
+		u32 ctrl_supports_sas:1;=0A=
+		u32 ctrl_supports_sata:1;=0A=
+		u32 allow_mix_in_encl:1;=0A=
+		u32 allow_mix_in_ld:1;=0A=
+		u32 allow_sata_in_cluster:1;=0A=
+		u32 reserved:27;=0A=
+=0A=
+	} __attribute__ ((packed)) pd_mix_support;=0A=
+=0A=
+	/*=0A=
+	 * Define ECC single-bit-error bucket information=0A=
+	 */=0A=
+	u8 ecc_bucket_count;=0A=
+	u8 reserved_2[11];=0A=
+=0A=
+	/*=0A=
+	 * Include the controller properties (changeable items)=0A=
+	 */=0A=
+	struct megasas_ctrl_prop properties;=0A=
+=0A=
+	/*=0A=
+	 * Define FW pkg version (set in envt v'bles on OEM basis)=0A=
+	 */=0A=
+	char package_version[0x60];=0A=
+=0A=
+	u8 pad[0x800 - 0x6a0];=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+/*=0A=
+ * =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A=
+ * MegaRAID SAS driver definitions=0A=
+ * =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A=
+ */=0A=
+#define MEGASAS_MAX_PD_CHANNELS			2=0A=
+#define MEGASAS_MAX_LD_CHANNELS			2=0A=
+#define MEGASAS_MAX_CHANNELS			(MEGASAS_MAX_PD_CHANNELS + \=0A=
+						MEGASAS_MAX_LD_CHANNELS)=0A=
+#define MEGASAS_MAX_DEV_PER_CHANNEL		128=0A=
+#define MEGASAS_DEFAULT_INIT_ID			-1=0A=
+#define MEGASAS_MAX_LUN				8=0A=
+#define MEGASAS_MAX_LD				64=0A=
+=0A=
+/*=0A=
+ * When SCSI mid-layer calls driver's reset routine, driver waits =
for=0A=
+ * MEGASAS_RESET_WAIT_TIME seconds for all outstanding IO to complete. =
Note=0A=
+ * that the driver cannot _actually_ abort or reset pending commands. =
While=0A=
+ * it is waiting for the commands to complete, it prints a diagnostic =
message=0A=
+ * every MEGASAS_RESET_NOTICE_INTERVAL seconds=0A=
+ */=0A=
+#define MEGASAS_RESET_WAIT_TIME			180=0A=
+#define	MEGASAS_RESET_NOTICE_INTERVAL		5=0A=
+=0A=
+#define MEGASAS_IOCTL_CMD			0=0A=
+=0A=
+/*=0A=
+ * FW reports the maximum of number of commands that it can accept =
(maximum=0A=
+ * commands that can be outstanding) at any time. The driver must =
report a=0A=
+ * lower number to the mid layer because it can issue a few internal =
commands=0A=
+ * itself (E.g, AEN, abort cmd, IOCTLs etc). The number of commands it =
needs=0A=
+ * is shown below=0A=
+ */=0A=
+#define MEGASAS_INT_CMDS			32=0A=
+=0A=
+/*=0A=
+ * FW can accept both 32 and 64 bit SGLs. We want to allocate 32/64 =
bit=0A=
+ * SGLs based on the size of dma_addr_t=0A=
+ */=0A=
+#define IS_DMA64				(sizeof(dma_addr_t) =3D=3D 8)=0A=
+=0A=
+#define MFI_OB_INTR_STATUS_MASK			0x00000002=0A=
+#define MFI_POLL_TIMEOUT_SECS			10=0A=
+=0A=
+struct megasas_register_set {=0A=
+=0A=
+	u32 reserved_0[4];	/*0000h */=0A=
+=0A=
+	u32 inbound_msg_0;	/*0010h */=0A=
+	u32 inbound_msg_1;	/*0014h */=0A=
+	u32 outbound_msg_0;	/*0018h */=0A=
+	u32 outbound_msg_1;	/*001Ch */=0A=
+=0A=
+	u32 inbound_doorbell;	/*0020h */=0A=
+	u32 inbound_intr_status;	/*0024h */=0A=
+	u32 inbound_intr_mask;	/*0028h */=0A=
+=0A=
+	u32 outbound_doorbell;	/*002Ch */=0A=
+	u32 outbound_intr_status;	/*0030h */=0A=
+	u32 outbound_intr_mask;	/*0034h */=0A=
+=0A=
+	u32 reserved_1[2];	/*0038h */=0A=
+=0A=
+	u32 inbound_queue_port;	/*0040h */=0A=
+	u32 outbound_queue_port;	/*0044h */=0A=
+=0A=
+	u32 reserved_2;		/*004Ch */=0A=
+=0A=
+	u32 index_registers[1004];	/*0050h */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_sge32 {=0A=
+=0A=
+	u32 phys_addr;=0A=
+	u32 length;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_sge64 {=0A=
+=0A=
+	u64 phys_addr;=0A=
+	u32 length;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+union megasas_sgl {=0A=
+=0A=
+	struct megasas_sge32 sge32[1];=0A=
+	struct megasas_sge64 sge64[1];=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_header {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 sense_len;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+	u8 scsi_status;		/*03h */=0A=
+=0A=
+	u8 target_id;		/*04h */=0A=
+	u8 lun;			/*05h */=0A=
+	u8 cdb_len;		/*06h */=0A=
+	u8 sge_count;		/*07h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 timeout;		/*12h */=0A=
+	u32 data_xferlen;	/*14h */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+union megasas_sgl_frame {=0A=
+=0A=
+	struct megasas_sge32 sge32[8];=0A=
+	struct megasas_sge64 sge64[5];=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_init_frame {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 reserved_0;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+=0A=
+	u8 reserved_1;		/*03h */=0A=
+	u32 reserved_2;		/*04h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 reserved_3;		/*12h */=0A=
+	u32 data_xfer_len;	/*14h */=0A=
+=0A=
+	u32 queue_info_new_phys_addr_lo;	/*18h */=0A=
+	u32 queue_info_new_phys_addr_hi;	/*1Ch */=0A=
+	u32 queue_info_old_phys_addr_lo;	/*20h */=0A=
+	u32 queue_info_old_phys_addr_hi;	/*24h */=0A=
+=0A=
+	u32 reserved_4[6];	/*28h */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_init_queue_info {=0A=
+=0A=
+	u32 init_flags;		/*00h */=0A=
+	u32 reply_queue_entries;	/*04h */=0A=
+=0A=
+	u32 reply_queue_start_phys_addr_lo;	/*08h */=0A=
+	u32 reply_queue_start_phys_addr_hi;	/*0Ch */=0A=
+	u32 producer_index_phys_addr_lo;	/*10h */=0A=
+	u32 producer_index_phys_addr_hi;	/*14h */=0A=
+	u32 consumer_index_phys_addr_lo;	/*18h */=0A=
+	u32 consumer_index_phys_addr_hi;	/*1Ch */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_io_frame {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 sense_len;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+	u8 scsi_status;		/*03h */=0A=
+=0A=
+	u8 target_id;		/*04h */=0A=
+	u8 access_byte;		/*05h */=0A=
+	u8 reserved_0;		/*06h */=0A=
+	u8 sge_count;		/*07h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 timeout;		/*12h */=0A=
+	u32 lba_count;		/*14h */=0A=
+=0A=
+	u32 sense_buf_phys_addr_lo;	/*18h */=0A=
+	u32 sense_buf_phys_addr_hi;	/*1Ch */=0A=
+=0A=
+	u32 start_lba_lo;	/*20h */=0A=
+	u32 start_lba_hi;	/*24h */=0A=
+=0A=
+	union megasas_sgl sgl;	/*28h */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_pthru_frame {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 sense_len;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+	u8 scsi_status;		/*03h */=0A=
+=0A=
+	u8 target_id;		/*04h */=0A=
+	u8 lun;			/*05h */=0A=
+	u8 cdb_len;		/*06h */=0A=
+	u8 sge_count;		/*07h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 timeout;		/*12h */=0A=
+	u32 data_xfer_len;	/*14h */=0A=
+=0A=
+	u32 sense_buf_phys_addr_lo;	/*18h */=0A=
+	u32 sense_buf_phys_addr_hi;	/*1Ch */=0A=
+=0A=
+	u8 cdb[16];		/*20h */=0A=
+	union megasas_sgl sgl;	/*30h */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_dcmd_frame {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 reserved_0;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+	u8 reserved_1[4];	/*03h */=0A=
+	u8 sge_count;		/*07h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 timeout;		/*12h */=0A=
+=0A=
+	u32 data_xfer_len;	/*14h */=0A=
+	u32 opcode;		/*18h */=0A=
+=0A=
+	union {			/*1Ch */=0A=
+		u8 b[12];=0A=
+		u16 s[6];=0A=
+		u32 w[3];=0A=
+	} mbox;=0A=
+=0A=
+	union megasas_sgl sgl;	/*28h */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_abort_frame {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 reserved_0;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+=0A=
+	u8 reserved_1;		/*03h */=0A=
+	u32 reserved_2;		/*04h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 reserved_3;		/*12h */=0A=
+	u32 reserved_4;		/*14h */=0A=
+=0A=
+	u32 abort_context;	/*18h */=0A=
+	u32 pad_1;		/*1Ch */=0A=
+=0A=
+	u32 abort_mfi_phys_addr_lo;	/*20h */=0A=
+	u32 abort_mfi_phys_addr_hi;	/*24h */=0A=
+=0A=
+	u32 reserved_5[6];	/*28h */=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_smp_frame {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 reserved_1;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+	u8 connection_status;	/*03h */=0A=
+=0A=
+	u8 reserved_2[3];	/*04h */=0A=
+	u8 sge_count;		/*07h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 timeout;		/*12h */=0A=
+=0A=
+	u32 data_xfer_len;	/*14h */=0A=
+	u64 sas_addr;		/*18h */=0A=
+=0A=
+	union {=0A=
+		struct megasas_sge32 sge32[2];	/* [0]: resp [1]: req */=0A=
+		struct megasas_sge64 sge64[2];	/* [0]: resp [1]: req */=0A=
+	} sgl;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_stp_frame {=0A=
+=0A=
+	u8 cmd;			/*00h */=0A=
+	u8 reserved_1;		/*01h */=0A=
+	u8 cmd_status;		/*02h */=0A=
+	u8 reserved_2;		/*03h */=0A=
+=0A=
+	u8 target_id;		/*04h */=0A=
+	u8 reserved_3[2];	/*05h */=0A=
+	u8 sge_count;		/*07h */=0A=
+=0A=
+	u32 context;		/*08h */=0A=
+	u32 pad_0;		/*0Ch */=0A=
+=0A=
+	u16 flags;		/*10h */=0A=
+	u16 timeout;		/*12h */=0A=
+=0A=
+	u32 data_xfer_len;	/*14h */=0A=
+=0A=
+	u16 fis[10];		/*18h */=0A=
+	u32 stp_flags;=0A=
+=0A=
+	union {=0A=
+		struct megasas_sge32 sge32[2];	/* [0]: resp [1]: data */=0A=
+		struct megasas_sge64 sge64[2];	/* [0]: resp [1]: data */=0A=
+	} sgl;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+union megasas_frame {=0A=
+=0A=
+	struct megasas_header hdr;=0A=
+	struct megasas_init_frame init;=0A=
+	struct megasas_io_frame io;=0A=
+	struct megasas_pthru_frame pthru;=0A=
+	struct megasas_dcmd_frame dcmd;=0A=
+	struct megasas_abort_frame abort;=0A=
+	struct megasas_smp_frame smp;=0A=
+	struct megasas_stp_frame stp;=0A=
+=0A=
+	u8 raw_bytes[64];=0A=
+};=0A=
+=0A=
+struct megasas_cmd;=0A=
+=0A=
+union megasas_evt_class_locale {=0A=
+=0A=
+	struct {=0A=
+		u16 locale;=0A=
+		u8 reserved;=0A=
+		s8 class;=0A=
+	} __attribute__ ((packed)) members;=0A=
+=0A=
+	u32 word;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_evt_log_info {=0A=
+	u32 newest_seq_num;=0A=
+	u32 oldest_seq_num;=0A=
+	u32 clear_seq_num;=0A=
+	u32 shutdown_seq_num;=0A=
+	u32 boot_seq_num;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_progress {=0A=
+=0A=
+	u16 progress;=0A=
+	u16 elapsed_seconds;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_evtarg_ld {=0A=
+=0A=
+	u16 target_id;=0A=
+	u8 ld_index;=0A=
+	u8 reserved;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_evtarg_pd {=0A=
+	u16 device_id;=0A=
+	u8 encl_index;=0A=
+	u8 slot_number;=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_evt_detail {=0A=
+=0A=
+	u32 seq_num;=0A=
+	u32 time_stamp;=0A=
+	u32 code;=0A=
+	union megasas_evt_class_locale cl;=0A=
+	u8 arg_type;=0A=
+	u8 reserved1[15];=0A=
+=0A=
+	union {=0A=
+		struct {=0A=
+			struct megasas_evtarg_pd pd;=0A=
+			u8 cdb_length;=0A=
+			u8 sense_length;=0A=
+			u8 reserved[2];=0A=
+			u8 cdb[16];=0A=
+			u8 sense[64];=0A=
+		} __attribute__ ((packed)) cdbSense;=0A=
+=0A=
+		struct megasas_evtarg_ld ld;=0A=
+=0A=
+		struct {=0A=
+			struct megasas_evtarg_ld ld;=0A=
+			u64 count;=0A=
+		} __attribute__ ((packed)) ld_count;=0A=
+=0A=
+		struct {=0A=
+			u64 lba;=0A=
+			struct megasas_evtarg_ld ld;=0A=
+		} __attribute__ ((packed)) ld_lba;=0A=
+=0A=
+		struct {=0A=
+			struct megasas_evtarg_ld ld;=0A=
+			u32 prevOwner;=0A=
+			u32 newOwner;=0A=
+		} __attribute__ ((packed)) ld_owner;=0A=
+=0A=
+		struct {=0A=
+			u64 ld_lba;=0A=
+			u64 pd_lba;=0A=
+			struct megasas_evtarg_ld ld;=0A=
+			struct megasas_evtarg_pd pd;=0A=
+		} __attribute__ ((packed)) ld_lba_pd_lba;=0A=
+=0A=
+		struct {=0A=
+			struct megasas_evtarg_ld ld;=0A=
+			struct megasas_progress prog;=0A=
+		} __attribute__ ((packed)) ld_prog;=0A=
+=0A=
+		struct {=0A=
+			struct megasas_evtarg_ld ld;=0A=
+			u32 prev_state;=0A=
+			u32 new_state;=0A=
+		} __attribute__ ((packed)) ld_state;=0A=
+=0A=
+		struct {=0A=
+			u64 strip;=0A=
+			struct megasas_evtarg_ld ld;=0A=
+		} __attribute__ ((packed)) ld_strip;=0A=
+=0A=
+		struct megasas_evtarg_pd pd;=0A=
+=0A=
+		struct {=0A=
+			struct megasas_evtarg_pd pd;=0A=
+			u32 err;=0A=
+		} __attribute__ ((packed)) pd_err;=0A=
+=0A=
+		struct {=0A=
+			u64 lba;=0A=
+			struct megasas_evtarg_pd pd;=0A=
+		} __attribute__ ((packed)) pd_lba;=0A=
+=0A=
+		struct {=0A=
+			u64 lba;=0A=
+			struct megasas_evtarg_pd pd;=0A=
+			struct megasas_evtarg_ld ld;=0A=
+		} __attribute__ ((packed)) pd_lba_ld;=0A=
+=0A=
+		struct {=0A=
+			struct megasas_evtarg_pd pd;=0A=
+			struct megasas_progress prog;=0A=
+		} __attribute__ ((packed)) pd_prog;=0A=
+=0A=
+		struct {=0A=
+			struct megasas_evtarg_pd pd;=0A=
+			u32 prevState;=0A=
+			u32 newState;=0A=
+		} __attribute__ ((packed)) pd_state;=0A=
+=0A=
+		struct {=0A=
+			u16 vendorId;=0A=
+			u16 deviceId;=0A=
+			u16 subVendorId;=0A=
+			u16 subDeviceId;=0A=
+		} __attribute__ ((packed)) pci;=0A=
+=0A=
+		u32 rate;=0A=
+		char str[96];=0A=
+=0A=
+		struct {=0A=
+			u32 rtc;=0A=
+			u32 elapsedSeconds;=0A=
+		} __attribute__ ((packed)) time;=0A=
+=0A=
+		struct {=0A=
+			u32 ecar;=0A=
+			u32 elog;=0A=
+			char str[64];=0A=
+		} __attribute__ ((packed)) ecc;=0A=
+=0A=
+		u8 b[96];=0A=
+		u16 s[48];=0A=
+		u32 w[24];=0A=
+		u64 d[12];=0A=
+	} args;=0A=
+=0A=
+	char description[128];=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_instance {=0A=
+=0A=
+	u32 *producer;=0A=
+	dma_addr_t producer_h;=0A=
+	u32 *consumer;=0A=
+	dma_addr_t consumer_h;=0A=
+=0A=
+	u32 *reply_queue;=0A=
+	dma_addr_t reply_queue_h;=0A=
+=0A=
+	unsigned long base_addr;=0A=
+	struct megasas_register_set __iomem *reg_set;=0A=
+=0A=
+	s8 init_id;=0A=
+	u8 reserved[3];=0A=
+=0A=
+	u16 max_num_sge;=0A=
+	u16 max_fw_cmds;=0A=
+	u32 max_sectors_per_req;=0A=
+=0A=
+	struct megasas_cmd **cmd_list;=0A=
+	struct list_head cmd_pool;=0A=
+	spinlock_t cmd_pool_lock;=0A=
+	struct dma_pool *frame_dma_pool;=0A=
+	struct dma_pool *sense_dma_pool;=0A=
+=0A=
+	struct megasas_evt_detail *evt_detail;=0A=
+	dma_addr_t evt_detail_h;=0A=
+	struct megasas_cmd *aen_cmd;=0A=
+	struct semaphore aen_mutex;=0A=
+	struct semaphore ioctl_sem;=0A=
+=0A=
+	struct Scsi_Host *host;=0A=
+=0A=
+	wait_queue_head_t int_cmd_wait_q;=0A=
+	wait_queue_head_t abort_cmd_wait_q;=0A=
+=0A=
+	struct pci_dev *pdev;=0A=
+	u32 unique_id;=0A=
+=0A=
+	u32 fw_outstanding;=0A=
+	u32 hw_crit_error;=0A=
+	spinlock_t instance_lock;=0A=
+};=0A=
+=0A=
+#define MEGASAS_IS_LOGICAL(scp)						\=0A=
+	(scp->device->channel < MEGASAS_MAX_PD_CHANNELS) ? 0 : 1=0A=
+=0A=
+#define MEGASAS_DEV_INDEX(inst, scp)					\=0A=
+	((scp->device->channel % 2) * MEGASAS_MAX_DEV_PER_CHANNEL) + 	\=0A=
+	scp->device->id=0A=
+=0A=
+struct megasas_cmd {=0A=
+=0A=
+	union megasas_frame *frame;=0A=
+	dma_addr_t frame_phys_addr;=0A=
+	u8 *sense;=0A=
+	dma_addr_t sense_phys_addr;=0A=
+=0A=
+	u32 index;=0A=
+	u8 sync_cmd;=0A=
+	u8 cmd_status;=0A=
+	u16 abort_aen;=0A=
+=0A=
+	struct list_head list;=0A=
+	struct scsi_cmnd *scmd;=0A=
+	struct megasas_instance *instance;=0A=
+	u32 frame_count;=0A=
+};=0A=
+=0A=
+#define MAX_MGMT_ADAPTERS		1024=0A=
+#define MAX_IOCTL_SGE			16=0A=
+=0A=
+struct megasas_iocpacket {=0A=
+=0A=
+	u16 host_no;=0A=
+	u16 __pad1;=0A=
+	u32 sgl_off;=0A=
+	u32 sge_count;=0A=
+	u32 sense_off;=0A=
+	u32 sense_len;=0A=
+	union {=0A=
+		u8 raw[128];=0A=
+		struct megasas_header hdr;=0A=
+	} frame;=0A=
+=0A=
+	struct iovec sgl[MAX_IOCTL_SGE];=0A=
+=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+struct megasas_aen {=0A=
+	u16 host_no;=0A=
+	u16 __pad1;=0A=
+	u32 seq_num;=0A=
+	u32 class_locale_word;=0A=
+};=0A=
+=0A=
+#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct =
megasas_iocpacket)=0A=
+#define MEGASAS_IOC_GET_AEN	_IOW('M', 2, struct megasas_aen)=0A=
+=0A=
+struct megasas_mgmt_info {=0A=
+=0A=
+	u16 count;=0A=
+	struct megasas_instance *instance[MAX_MGMT_ADAPTERS];=0A=
+	int max_index;=0A=
+};=0A=
+=0A=
+#endif				/*LSI_MEGARAID_SAS_H */=0A=
diff -Naur scsi_misc-a/include/linux/pci_ids.h =
scsi_misc-b/include/linux/pci_ids.h=0A=
--- scsi_misc-a/include/linux/pci_ids.h	2005-08-25 16:24:10.000000000 =
-0400=0A=
+++ scsi_misc-b/include/linux/pci_ids.h	2005-08-25 16:25:55.000000000 =
-0400=0A=
@@ -185,6 +185,7 @@=0A=
 #define PCI_DEVICE_ID_LSI_61C102	0x0901=0A=
 #define PCI_DEVICE_ID_LSI_63C815	0x1000=0A=
 #define PCI_DEVICE_ID_LSI_SAS1064	0x0050=0A=
+#define PCI_DEVICE_ID_LSI_SAS1064R	0x0411=0A=
 #define PCI_DEVICE_ID_LSI_SAS1066	0x005E=0A=
 #define PCI_DEVICE_ID_LSI_SAS1068	0x0054=0A=
 #define PCI_DEVICE_ID_LSI_SAS1064A	0x005C=0A=
@@ -554,6 +555,7 @@=0A=
 #define PCI_VENDOR_ID_DELL		0x1028=0A=
 #define PCI_DEVICE_ID_DELL_RACIII	0x0008=0A=
 #define PCI_DEVICE_ID_DELL_RAC4		0x0012=0A=
+#define PCI_DEVICE_ID_DELL_PERC5	0x0015=0A=
 =0A=
 #define PCI_VENDOR_ID_MATROX		0x102B=0A=
 #define PCI_DEVICE_ID_MATROX_MGA_2	0x0518=0A=

------_=_NextPart_000_01C5AE8C.DCE07840--
