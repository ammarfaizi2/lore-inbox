Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424193AbWKISa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424193AbWKISa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424196AbWKISa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:30:57 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:56996 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1424193AbWKISaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:30:55 -0500
Date: Thu, 9 Nov 2006 11:30:55 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-driver@qlogic.com, hch@infradead.org
Subject: [PATCH 2/2] Use mutex_lock_timeout in qla2xxx driver
Message-ID: <20061109183054.GO16952@parisc-linux.org>
References: <20061109182721.GN16952@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109182721.GN16952@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


qla2xxx can use a mutex instead of a semaphore for mailbox serialisation.
It can also use the new mutex_down_timeout function I introduced in
patch 1/2.

Compile-tested only (I don't have a qlogic card conveniently available
right now).

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index c4fc40f..f78b058 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2316,7 +2316,7 @@ #define MBX_UPDATE_FLASH_ACTIVE	3
 
 	spinlock_t	mbx_reg_lock;   /* Mbx Cmd Register Lock */
 
-	struct semaphore mbx_cmd_sem;	/* Serialialize mbx access */
+	struct mutex mbx_cmd_mtx;	/* Serialialize mbx access */
 	struct semaphore mbx_intr_sem;  /* Used for completion notification */
 
 	uint32_t	mbx_flags;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 32ebeec..21cbd6c 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -71,8 +71,6 @@ extern char *qla2x00_get_fw_version_str(
 extern void qla2x00_mark_device_lost(scsi_qla_host_t *, fc_port_t *, int, int);
 extern void qla2x00_mark_all_devices_lost(scsi_qla_host_t *, int);
 
-extern int qla2x00_down_timeout(struct semaphore *, unsigned long);
-
 extern struct fw_blob *qla2x00_request_firmware(scsi_qla_host_t *);
 
 extern int qla2x00_wait_for_hba_online(scsi_qla_host_t *);
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 4cde76c..fbd5822 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -69,7 +69,7 @@ qla2x00_mailbox_command(scsi_qla_host_t 
 	 * non ISP abort time.
 	 */
 	if (!abort_active) {
-		if (qla2x00_down_timeout(&ha->mbx_cmd_sem, mcp->tov * HZ)) {
+		if (mutex_lock_timeout(&ha->mbx_cmd_mtx, mcp->tov * HZ)) {
 			/* Timeout occurred. Return error. */
 			DEBUG2_3_11(printk("%s(%ld): cmd access timeout. "
 			    "Exiting.\n", __func__, ha->host_no));
@@ -311,7 +311,7 @@ #endif
 
 	/* Allow next mbx cmd to come in. */
 	if (!abort_active)
-		up(&ha->mbx_cmd_sem);
+		mutex_unlock(&ha->mbx_cmd_mtx);
 
 	if (rval) {
 		DEBUG2_3_11(printk("%s(%ld): **** FAILED. mbx0=%x, mbx1=%x, "
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 208607b..212f392 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1530,7 +1530,7 @@ qla2x00_probe_one(struct pci_dev *pdev, 
 	/* load the F/W, read paramaters, and init the H/W */
 	ha->instance = num_hosts;
 
-	init_MUTEX(&ha->mbx_cmd_sem);
+	mutex_init(&ha->mbx_cmd_mtx);
 	init_MUTEX_LOCKED(&ha->mbx_intr_sem);
 
 	INIT_LIST_HEAD(&ha->list);
@@ -2580,23 +2580,6 @@ qla2x00_timer(scsi_qla_host_t *ha)
 	qla2x00_restart_timer(ha, WATCH_INTERVAL);
 }
 
-/* XXX(hch): crude hack to emulate a down_timeout() */
-int
-qla2x00_down_timeout(struct semaphore *sema, unsigned long timeout)
-{
-	const unsigned int step = 100; /* msecs */
-	unsigned int iterations = jiffies_to_msecs(timeout)/100;
-
-	do {
-		if (!down_trylock(sema))
-			return 0;
-		if (msleep_interruptible(step))
-			break;
-	} while (--iterations >= 0);
-
-	return -ETIMEDOUT;
-}
-
 /* Firmware interface routines. */
 
 #define FW_BLOBS	5
