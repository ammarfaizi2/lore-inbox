Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTKYAj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTKYAj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:39:57 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:45061 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261801AbTKYAiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:38:04 -0500
Subject: Re: test10 hangs on startup: NMI watchdog hits Adaptec driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       gibbs@overdrive.btc.adaptec.com
In-Reply-To: <16322.41235.39815.936201@wombat.chubb.wattle.id.au>
References: <16322.41235.39815.936201@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Nov 2003 18:37:59 -0600
Message-Id: <1069720681.2870.73.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 18:23, Peter Chubb wrote:
>    I've been seeing random hangs on a dual 500MHz celeron here; so I
> rebooted this morning with the NMI watchdog turned on.
> 
> With the watchdog, the machine shows the attached.  Looks to me as if
> the lock taken at aic7xx_osm.c:1709 which is released *after*
> ahc_linux_initialize_scsi_bus() should perhaps be released earlier.
> Otherwise the host lock is held for the duration.

There have been several threads on this.

The fix is attached.

James

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1483  -> 1.1484 
#	drivers/scsi/scsi_error.c	1.65    -> 1.66   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/24	jejb@raven.il.steeleye.com	1.1484
# Fix locking problems in scsi_report_bus_reset() causing aic7xxx to hang
# 
# All the users of this function in the SCSI tree call it with the host
# lock held.  With the new list traversal code, it was trying to take
# the lock again to traverse the list.
# 
# Fix it to use the unlocked version of list traversal and modify the
# header comments to make it clear that the lock is expected to be held
# on calling it.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Mon Nov 24 17:27:38 2003
+++ b/drivers/scsi/scsi_error.c	Mon Nov 24 17:27:38 2003
@@ -911,7 +911,9 @@
 
 	if (rtn == SUCCESS) {
 		scsi_sleep(BUS_RESET_SETTLE_TIME);
+		spin_lock_irqsave(scmd->device->host->host_lock, flags);
 		scsi_report_bus_reset(scmd->device->host, scmd->device->channel);
+		spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
 	}
 
 	return rtn;
@@ -940,7 +942,9 @@
 
 	if (rtn == SUCCESS) {
 		scsi_sleep(HOST_RESET_SETTLE_TIME);
+		spin_lock_irqsave(scmd->device->host->host_lock, flags);
 		scsi_report_bus_reset(scmd->device->host, scmd->device->channel);
+		spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
 	}
 
 	return rtn;
@@ -1608,7 +1612,7 @@
  *
  * Returns:     Nothing
  *
- * Lock status: No locks are assumed held.
+ * Lock status: Host lock must be held.
  *
  * Notes:       This only needs to be called if the reset is one which
  *		originates from an unknown location.  Resets originated
@@ -1622,7 +1626,7 @@
 {
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, shost) {
+	__shost_for_each_device(sdev, shost) {
 		if (channel == sdev->channel) {
 			sdev->was_reset = 1;
 			sdev->expecting_cc_ua = 1;
@@ -1642,7 +1646,7 @@
  *
  * Returns:     Nothing
  *
- * Lock status: No locks are assumed held.
+ * Lock status: Host lock must be held
  *
  * Notes:       This only needs to be called if the reset is one which
  *		originates from an unknown location.  Resets originated
@@ -1656,7 +1660,7 @@
 {
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, shost) {
+	__shost_for_each_device(sdev, shost) {
 		if (channel == sdev->channel &&
 		    target == sdev->id) {
 			sdev->was_reset = 1;

