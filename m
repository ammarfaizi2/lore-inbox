Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263306AbUJ2Mxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbUJ2Mxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUJ2Mxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:53:55 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:2469 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S263306AbUJ2Mvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:51:48 -0400
Date: Fri, 29 Oct 2004 14:51:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: make zfcp compile again.
Message-ID: <20041029125133.GA3602@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] s390: make zfcp compile again.

From: Andreas Herrmann <aherrman@de.ibm.com>

Make zfcp compile again after the SPI-5 constants and the
interface to suspend I/O to scsi devices got added.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_def.h  |   10 +++++-----
 drivers/s390/scsi/zfcp_scsi.c |   20 ++++++--------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-patched/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	2004-10-29 13:57:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_def.h	2004-10-29 13:58:02.000000000 +0200
@@ -188,11 +188,11 @@
 #define UNTAGGED	5
 
 /* task management flags in FCP-2 FCP_CMND IU */
-#define CLEAR_ACA		0x40
-#define TARGET_RESET		0x20
-#define LOGICAL_UNIT_RESET	0x10
-#define CLEAR_TASK_SET		0x04
-#define ABORT_TASK_SET		0x02
+#define FCP_CLEAR_ACA		0x40
+#define FCP_TARGET_RESET	0x20
+#define FCP_LOGICAL_UNIT_RESET	0x10
+#define FCP_CLEAR_TASK_SET	0x04
+#define FCP_ABORT_TASK_SET	0x02
 
 #define FCP_CDB_LENGTH		16
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2004-10-29 13:57:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2004-10-29 13:58:02.000000000 +0200
@@ -49,8 +49,8 @@
 
 static struct zfcp_unit *zfcp_unit_lookup(struct zfcp_adapter *, int, scsi_id_t,
 					  scsi_lun_t);
-static struct zfcp_port * zfcp_port_lookup(struct zfcp_adapter *, int,
-					 scsi_id_t);
+static struct zfcp_port *zfcp_port_lookup(struct zfcp_adapter *, int,
+					  scsi_id_t);
 
 static struct device_attribute *zfcp_sysfs_sdev_attrs[];
 
@@ -402,15 +402,7 @@
  out:
 	return retval;
 }
-/*
- * function:    zfcp_unit_tgt_lookup
- *
- * purpose:
- *
- * returns:
- *
- * context:	
- */
+
 static struct zfcp_port *
 zfcp_port_lookup(struct zfcp_adapter *adapter, int channel, scsi_id_t id)
 {
@@ -420,7 +412,7 @@
 		if (id == port->scsi_id)
 			return port;
 	}
-	return (zfcp_port *)NULL;
+	return (struct zfcp_port *) NULL;
 }
 
 /*
@@ -653,7 +645,7 @@
 	if (!atomic_test_mask(ZFCP_STATUS_UNIT_NOTSUPPUNITRESET,
 			      &unit->status)) {
 		retval =
-		    zfcp_task_management_function(unit, LOGICAL_UNIT_RESET);
+		    zfcp_task_management_function(unit, FCP_LOGICAL_UNIT_RESET);
 		if (retval) {
 			ZFCP_LOG_DEBUG("unit reset failed (unit=%p)\n", unit);
 			if (retval == -ENOTSUPP)
@@ -669,7 +661,7 @@
 			goto out;
 		}
 	}
-	retval = zfcp_task_management_function(unit, TARGET_RESET);
+	retval = zfcp_task_management_function(unit, FCP_TARGET_RESET);
 	if (retval) {
 		ZFCP_LOG_DEBUG("target reset failed (unit=%p)\n", unit);
 		retval = FAILED;
