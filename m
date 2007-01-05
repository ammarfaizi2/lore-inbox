Return-Path: <linux-kernel-owner+w=401wt.eu-S1750732AbXAEUUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbXAEUUz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXAEUUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:20:55 -0500
Received: from mail0.lsil.com ([147.145.40.20]:37095 "EHLO mail0.lsil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbXAEUUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:20:53 -0500
Subject: [PATCH] scsi: megaraid_{mm,mbox} init fix for kdump
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, akpm@osdl.org, rdunlap@xenotime.net
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       neela.kolli@lsi.com, bo.yang@lsi.com, sumant.patro@lsi.com
Content-Type: multipart/mixed; boundary="=-02Qxs3UzvkxMXpQFSitQ"
Date: Fri, 05 Jan 2007 07:10:09 -0800
Message-Id: <1168009809.4188.10.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-02Qxs3UzvkxMXpQFSitQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


1.      Changes in Initialization to fix kdump failure.
        Send SYNC command on loading.
        This command clears the pending commands in the adapter
        and re-initialize its internal RAID structure.
        Without this change, megaraid driver either panics or fails to
        initialize the adapter during kdump's second kernel boot
        if there are pending commands or interrupts from other devices
        sharing the same IRQ.
2.      Authors email-id domain name changed from lsil.com to lsi.com.
        Also modified the MODULE_AUTHOR to megaraidlinux@lsi.com

Signed-off-by: Sumant Patro <sumant.patro@lsi.com>
---

 Documentation/scsi/ChangeLog.megaraid |   16 ++
 drivers/scsi/megaraid/megaraid_mbox.c |  140 +++++++++++++++++++-----
 drivers/scsi/megaraid/megaraid_mbox.h |    4
 3 files changed, 130 insertions(+), 30 deletions(-)

diff -uprN linux-2.6.orig/Documentation/scsi/ChangeLog.megaraid linux-2.6.new/Documentation/scsi/ChangeLog.megaraid
--- linux-2.6.orig/Documentation/scsi/ChangeLog.megaraid 2006-12-28 10:10:31.000000000 -0800
+++ linux-2.6.new/Documentation/scsi/ChangeLog.megaraid 2007-01-04 12:09:36.000000000 -0800
@@ -1,3 +1,19 @@
+Release Date : Thu Nov 16 15:32:35 EST 2006 -
+    Sumant Patro <sumant.patro@lsi.com>
+Current Version : 2.20.5.1 (scsi module), 2.20.2.6 (cmm module)
+Older Version : 2.20.4.9 (scsi module), 2.20.2.6 (cmm module)
+
+1. Changes in Initialization to fix kdump failure.
+ Send SYNC command on loading.
+ This command clears the pending commands in the adapter
+ and re-initialize its internal RAID structure.
+ Without this change, megaraid driver either panics or fails to
+ initialize the adapter during kdump's second kernel boot
+ if there are pending commands or interrupts from other devices
+ sharing the same IRQ.
+2.  Authors email-id domain name changed from lsil.com to lsi.com.
+ Also modified the MODULE_AUTHOR to megaraidlinux@lsi.com
+
 Release Date : Fri May 19 09:31:45 EST 2006 - Seokmann Ju <sju@lsil.com>
 Current Version : 2.20.4.9 (scsi module), 2.20.2.6 (cmm module)
 Older Version : 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c	2006-12-28 09:56:04.000000000 -0800
+++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c	2007-01-04 11:22:21.000000000 -0800
@@ -10,13 +10,13 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.9 (Jul 16 2006)
+ * Version	: v2.20.5.1 (Nov 16 2006)
  *
  * Authors:
- * 	Atul Mukker		<Atul.Mukker@lsil.com>
- * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
- * 	Manoj Jose		<Manoj.Jose@lsil.com>
- * 	Seokmann Ju		<Seokmann.Ju@lsil.com>
+ * 	Atul Mukker		<Atul.Mukker@lsi.com>
+ * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsi.com>
+ * 	Manoj Jose		<Manoj.Jose@lsi.com>
+ * 	Seokmann Ju
  *
  * List of supported controllers
  *
@@ -107,6 +107,7 @@ static int megaraid_mbox_support_random_
 static int megaraid_mbox_get_max_sg(adapter_t *);
 static void megaraid_mbox_enum_raid_scsi(adapter_t *);
 static void megaraid_mbox_flush_cache(adapter_t *);
+static int megaraid_mbox_fire_sync_cmd(adapter_t *);
 
 static void megaraid_mbox_display_scb(adapter_t *, scb_t *);
 static void megaraid_mbox_setup_device_map(adapter_t *);
@@ -137,7 +138,7 @@ static int wait_till_fw_empty(adapter_t 
 
 
 
-MODULE_AUTHOR("sju@lsil.com");
+MODULE_AUTHOR("megaraidlinux@lsi.com");
 MODULE_DESCRIPTION("LSI Logic MegaRAID Mailbox Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGARAID_VERSION);
@@ -779,33 +780,39 @@ megaraid_init_mbox(adapter_t *adapter)
 		goto out_release_regions;
 	}
 
-	//
-	// Setup the rest of the soft state using the library of FW routines
-	//
+	/* initialize the mutual exclusion lock for the mailbox */
+	spin_lock_init(&raid_dev->mailbox_lock);
+
+	/* allocate memory required for commands */
+	if (megaraid_alloc_cmd_packets(adapter) != 0)
+		goto out_iounmap;
 
-	// request IRQ and register the interrupt service routine
+	/*
+	 * Issue SYNC cmd to flush the pending cmds in the adapter
+	 * and initialize its internal state
+	 */
+
+	if (megaraid_mbox_fire_sync_cmd(adapter))
+		con_log(CL_ANN, ("megaraid: sync cmd failed\n"));
+
+	/*
+	 * Setup the rest of the soft state using the library of
+	 * FW routines
+	 */
+
+	/* request IRQ and register the interrupt service routine */
 	if (request_irq(adapter->irq, megaraid_isr, IRQF_SHARED, "megaraid",
 		adapter)) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: Couldn't register IRQ %d!\n", adapter->irq));
+		goto out_alloc_cmds;
 
-		goto out_iounmap;
-	}
-
-
-	// initialize the mutual exclusion lock for the mailbox
-	spin_lock_init(&raid_dev->mailbox_lock);
-
-	// allocate memory required for commands
-	if (megaraid_alloc_cmd_packets(adapter) != 0) {
-		goto out_free_irq;
 	}
 
 	// Product info
-	if (megaraid_mbox_product_info(adapter) != 0) {
-		goto out_alloc_cmds;
-	}
+	if (megaraid_mbox_product_info(adapter) != 0)
+		goto out_free_irq;
 
 	// Do we support extended CDBs
 	adapter->max_cdb_sz = 10;
@@ -874,9 +881,8 @@ megaraid_init_mbox(adapter_t *adapter)
 	 * Allocate resources required to issue FW calls, when sysfs is
 	 * accessed
 	 */
-	if (megaraid_sysfs_alloc_resources(adapter) != 0) {
-		goto out_alloc_cmds;
-	}
+	if (megaraid_sysfs_alloc_resources(adapter) != 0)
+		goto out_free_irq;
 
 	// Set the DMA mask to 64-bit. All supported controllers as capable of
 	// DMA in this range
@@ -920,10 +926,10 @@ megaraid_init_mbox(adapter_t *adapter)
 
 out_free_sysfs_res:
 	megaraid_sysfs_free_resources(adapter);
-out_alloc_cmds:
-	megaraid_free_cmd_packets(adapter);
 out_free_irq:
 	free_irq(adapter->irq, adapter);
+out_alloc_cmds:
+	megaraid_free_cmd_packets(adapter);
 out_iounmap:
 	iounmap(raid_dev->baseaddr);
 out_release_regions:
@@ -3380,6 +3386,84 @@ megaraid_mbox_flush_cache(adapter_t *ada
 
 
 /**
+ * megaraid_mbox_fire_sync_cmd - fire the sync cmd
+ * @param adapter	: soft state for the controller
+ *
+ * Clears the pending cmds in FW and reinits its RAID structs
+ */
+static int
+megaraid_mbox_fire_sync_cmd(adapter_t *adapter)
+{
+	mbox_t	*mbox;
+	uint8_t	raw_mbox[sizeof(mbox_t)];
+	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
+	mbox64_t *mbox64;
+	int	status = 0;
+	int i;
+	uint32_t dword;
+
+	mbox = (mbox_t *)raw_mbox;
+
+	memset((caddr_t)raw_mbox, 0, sizeof(mbox_t));
+
+	raw_mbox[0] = 0xFF;
+
+	mbox64	= raid_dev->mbox64;
+	mbox	= raid_dev->mbox;
+
+	/* Wait until mailbox is free */
+	if (megaraid_busywait_mbox(raid_dev) != 0) {
+		status = 1;
+		goto blocked_mailbox;
+	}
+
+	/* Copy mailbox data into host structure */
+	memcpy((caddr_t)mbox, (caddr_t)raw_mbox, 16);
+	mbox->cmdid		= 0xFE;
+	mbox->busy		= 1;
+	mbox->poll		= 0;
+	mbox->ack		= 0;
+	mbox->numstatus		= 0;
+	mbox->status		= 0;
+
+	wmb();
+	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
+
+	/* Wait for maximum 1 min for status to post.
+	 * If the Firmware SUPPORTS the ABOVE COMMAND,
+	 * mbox->cmd will be set to 0
+	 * else
+	 * the firmware will reject the command with
+	 * mbox->numstatus set to 1
+	 */
+
+	i = 0;
+	status = 0;
+	while (!mbox->numstatus && mbox->cmd == 0xFF) {
+		rmb();
+		msleep(1);
+		i++;
+		if (i > 1000 * 60) {
+			status = 1;
+			break;
+		}
+	}
+	if (mbox->numstatus == 1)
+		status = 1; /*cmd not supported*/
+
+	/* Check for interrupt line */
+	dword = RDOUTDOOR(raid_dev);
+	WROUTDOOR(raid_dev, dword);
+	WRINDOOR(raid_dev,2);
+
+	return status;
+
+blocked_mailbox:
+	con_log(CL_ANN, (KERN_WARNING "megaraid: blocked mailbox\n"));
+	return status;
+}
+
+/**
  * megaraid_mbox_display_scb - display SCB information, mostly debug purposes
  * @param adapter	: controllers' soft state
  * @param scb  : SCB to be displayed
diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.h linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.h
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.h 2006-12-28 09:56:04.000000000 -0800
+++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.h	2007-01-04 05:24:22.000000000 -0800
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.9"
-#define MEGARAID_EXT_VERSION	"(Release Date: Sun Jul 16 12:27:22 EST 2006)"
+#define MEGARAID_VERSION	"2.20.5.1"
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov 16 15:32:35 EST 2006)"
 
 
 /*


--=-02Qxs3UzvkxMXpQFSitQ
Content-Description: 
Content-Disposition: attachment; filename=megaraid-initialization-fix-for-kdump.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6.orig/Documentation/scsi/ChangeLog.megaraid linux-2.6.new/Documentation/scsi/ChangeLog.megaraid
--- linux-2.6.orig/Documentation/scsi/ChangeLog.megaraid	2006-12-28 10:10:31.000000000 -0800
+++ linux-2.6.new/Documentation/scsi/ChangeLog.megaraid	2007-01-04 12:09:36.000000000 -0800
@@ -1,3 +1,19 @@
+Release Date	: Thu Nov 16 15:32:35 EST 2006 -
+				Sumant Patro <sumant.patro@lsi.com>
+Current Version : 2.20.5.1 (scsi module), 2.20.2.6 (cmm module)
+Older Version	: 2.20.4.9 (scsi module), 2.20.2.6 (cmm module)
+
+1.	Changes in Initialization to fix kdump failure.
+	Send SYNC command on loading.
+	This command clears the pending commands in the adapter
+	and re-initialize its internal RAID structure.
+	Without this change, megaraid driver either panics or fails to
+	initialize the adapter during kdump's second kernel boot
+	if there are pending commands or interrupts from other devices
+	sharing the same IRQ.
+2. 	Authors email-id domain name changed from lsil.com to lsi.com.
+	Also modified the MODULE_AUTHOR to megaraidlinux@lsi.com
+
 Release Date	: Fri May 19 09:31:45 EST 2006 - Seokmann Ju <sju@lsil.com>
 Current Version : 2.20.4.9 (scsi module), 2.20.2.6 (cmm module)
 Older Version	: 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c	2006-12-28 09:56:04.000000000 -0800
+++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c	2007-01-04 11:22:21.000000000 -0800
@@ -10,13 +10,13 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.9 (Jul 16 2006)
+ * Version	: v2.20.5.1 (Nov 16 2006)
  *
  * Authors:
- * 	Atul Mukker		<Atul.Mukker@lsil.com>
- * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
- * 	Manoj Jose		<Manoj.Jose@lsil.com>
- * 	Seokmann Ju		<Seokmann.Ju@lsil.com>
+ * 	Atul Mukker		<Atul.Mukker@lsi.com>
+ * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsi.com>
+ * 	Manoj Jose		<Manoj.Jose@lsi.com>
+ * 	Seokmann Ju
  *
  * List of supported controllers
  *
@@ -107,6 +107,7 @@ static int megaraid_mbox_support_random_
 static int megaraid_mbox_get_max_sg(adapter_t *);
 static void megaraid_mbox_enum_raid_scsi(adapter_t *);
 static void megaraid_mbox_flush_cache(adapter_t *);
+static int megaraid_mbox_fire_sync_cmd(adapter_t *);
 
 static void megaraid_mbox_display_scb(adapter_t *, scb_t *);
 static void megaraid_mbox_setup_device_map(adapter_t *);
@@ -137,7 +138,7 @@ static int wait_till_fw_empty(adapter_t 
 
 
 
-MODULE_AUTHOR("sju@lsil.com");
+MODULE_AUTHOR("megaraidlinux@lsi.com");
 MODULE_DESCRIPTION("LSI Logic MegaRAID Mailbox Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGARAID_VERSION);
@@ -779,33 +780,39 @@ megaraid_init_mbox(adapter_t *adapter)
 		goto out_release_regions;
 	}
 
-	//
-	// Setup the rest of the soft state using the library of FW routines
-	//
+	/* initialize the mutual exclusion lock for the mailbox */
+	spin_lock_init(&raid_dev->mailbox_lock);
+
+	/* allocate memory required for commands */
+	if (megaraid_alloc_cmd_packets(adapter) != 0)
+		goto out_iounmap;
 
-	// request IRQ and register the interrupt service routine
+	/*
+	 * Issue SYNC cmd to flush the pending cmds in the adapter
+	 * and initialize its internal state
+	 */
+
+	if (megaraid_mbox_fire_sync_cmd(adapter))
+		con_log(CL_ANN, ("megaraid: sync cmd failed\n"));
+
+	/*
+	 * Setup the rest of the soft state using the library of
+	 * FW routines
+	 */
+
+	/* request IRQ and register the interrupt service routine */
 	if (request_irq(adapter->irq, megaraid_isr, IRQF_SHARED, "megaraid",
 		adapter)) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: Couldn't register IRQ %d!\n", adapter->irq));
+		goto out_alloc_cmds;
 
-		goto out_iounmap;
-	}
-
-
-	// initialize the mutual exclusion lock for the mailbox
-	spin_lock_init(&raid_dev->mailbox_lock);
-
-	// allocate memory required for commands
-	if (megaraid_alloc_cmd_packets(adapter) != 0) {
-		goto out_free_irq;
 	}
 
 	// Product info
-	if (megaraid_mbox_product_info(adapter) != 0) {
-		goto out_alloc_cmds;
-	}
+	if (megaraid_mbox_product_info(adapter) != 0)
+		goto out_free_irq;
 
 	// Do we support extended CDBs
 	adapter->max_cdb_sz = 10;
@@ -874,9 +881,8 @@ megaraid_init_mbox(adapter_t *adapter)
 	 * Allocate resources required to issue FW calls, when sysfs is
 	 * accessed
 	 */
-	if (megaraid_sysfs_alloc_resources(adapter) != 0) {
-		goto out_alloc_cmds;
-	}
+	if (megaraid_sysfs_alloc_resources(adapter) != 0)
+		goto out_free_irq;
 
 	// Set the DMA mask to 64-bit. All supported controllers as capable of
 	// DMA in this range
@@ -920,10 +926,10 @@ megaraid_init_mbox(adapter_t *adapter)
 
 out_free_sysfs_res:
 	megaraid_sysfs_free_resources(adapter);
-out_alloc_cmds:
-	megaraid_free_cmd_packets(adapter);
 out_free_irq:
 	free_irq(adapter->irq, adapter);
+out_alloc_cmds:
+	megaraid_free_cmd_packets(adapter);
 out_iounmap:
 	iounmap(raid_dev->baseaddr);
 out_release_regions:
@@ -3380,6 +3386,84 @@ megaraid_mbox_flush_cache(adapter_t *ada
 
 
 /**
+ * megaraid_mbox_fire_sync_cmd - fire the sync cmd
+ * @param adapter	: soft state for the controller
+ *
+ * Clears the pending cmds in FW and reinits its RAID structs
+ */
+static int
+megaraid_mbox_fire_sync_cmd(adapter_t *adapter)
+{
+	mbox_t	*mbox;
+	uint8_t	raw_mbox[sizeof(mbox_t)];
+	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
+	mbox64_t *mbox64;
+	int	status = 0;
+	int i;
+	uint32_t dword;
+
+	mbox = (mbox_t *)raw_mbox;
+
+	memset((caddr_t)raw_mbox, 0, sizeof(mbox_t));
+
+	raw_mbox[0] = 0xFF;
+
+	mbox64	= raid_dev->mbox64;
+	mbox	= raid_dev->mbox;
+
+	/* Wait until mailbox is free */
+	if (megaraid_busywait_mbox(raid_dev) != 0) {
+		status = 1;
+		goto blocked_mailbox;
+	}
+
+	/* Copy mailbox data into host structure */
+	memcpy((caddr_t)mbox, (caddr_t)raw_mbox, 16);
+	mbox->cmdid		= 0xFE;
+	mbox->busy		= 1;
+	mbox->poll		= 0;
+	mbox->ack		= 0;
+	mbox->numstatus		= 0;
+	mbox->status		= 0;
+
+	wmb();
+	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
+
+	/* Wait for maximum 1 min for status to post.
+	 * If the Firmware SUPPORTS the ABOVE COMMAND,
+	 * mbox->cmd will be set to 0
+	 * else
+	 * the firmware will reject the command with
+	 * mbox->numstatus set to 1
+	 */
+
+	i = 0;
+	status = 0;
+	while (!mbox->numstatus && mbox->cmd == 0xFF) {
+		rmb();
+		msleep(1);
+		i++;
+		if (i > 1000 * 60) {
+			status = 1;
+			break;
+		}
+	}
+	if (mbox->numstatus == 1)
+		status = 1; /*cmd not supported*/
+
+	/* Check for interrupt line */
+	dword = RDOUTDOOR(raid_dev);
+	WROUTDOOR(raid_dev, dword);
+	WRINDOOR(raid_dev,2);
+
+	return status;
+
+blocked_mailbox:
+	con_log(CL_ANN, (KERN_WARNING "megaraid: blocked mailbox\n"));
+	return status;
+}
+
+/**
  * megaraid_mbox_display_scb - display SCB information, mostly debug purposes
  * @param adapter	: controllers' soft state
  * @param scb		: SCB to be displayed
diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.h linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.h
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.h	2006-12-28 09:56:04.000000000 -0800
+++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.h	2007-01-04 05:24:22.000000000 -0800
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.9"
-#define MEGARAID_EXT_VERSION	"(Release Date: Sun Jul 16 12:27:22 EST 2006)"
+#define MEGARAID_VERSION	"2.20.5.1"
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov 16 15:32:35 EST 2006)"
 
 
 /*

--=-02Qxs3UzvkxMXpQFSitQ--

