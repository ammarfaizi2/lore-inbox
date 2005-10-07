Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVJGXzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVJGXzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVJGXzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:55:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:7126 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964887AbVJGXzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:55:04 -0400
Date: Fri, 7 Oct 2005 16:54:22 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, stefanr@s5r6.in-berlin.de,
       bcollins@debian.org
Subject: [patch 1/7] ieee1394/sbp2: fixes for hot-unplug and module unloading
Message-ID: <20051007235422.GB23111@kroah.com>
References: <20051007234348.631583000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ieee1394-sbp2-fixes-for-hot-unplug-and-module-unloading.patch"
In-Reply-To: <20051007235353.GA23111@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Richter <stefanr@s5r6.in-berlin.de>

Fixes for reference counting problems, deadlocks, and delays when SBP-2 devices
are unplugged or unbound from sbp2, or when unloading of sbp2/ ohci1394/ pcilynx
is attempted.

Most often reported symptoms were hotplugs remaining undetected once a FireWire
disk was unplugged since the knodemgrd kernel thread went to uninterruptible
sleep, and "modprobe -r sbp2" being unable to complete because still being in
use.

Patch is equivalent to commit abd559b1052e28d8b9c28aabde241f18fa89090b in
2.6.14-rc3 plus a fix which is necessary together with 2.6.13's scsi core API
(linux1394.org commit r1308 by Ben Collins).

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Ben Collins <bcollins@debian.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/ieee1394/sbp2.c |   38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

--- linux-2.6.13.y.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.13.y/drivers/ieee1394/sbp2.c
@@ -596,6 +596,11 @@ static void sbp2util_mark_command_comple
 	spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 }
 
+static inline int sbp2util_node_is_available(struct scsi_id_instance_data *scsi_id)
+{
+	return scsi_id && scsi_id->ne && !scsi_id->ne->in_limbo;
+}
+
 
 
 /*********************************************
@@ -631,11 +636,23 @@ static int sbp2_remove(struct device *de
 {
 	struct unit_directory *ud;
 	struct scsi_id_instance_data *scsi_id;
+	struct scsi_device *sdev;
 
 	SBP2_DEBUG("sbp2_remove");
 
 	ud = container_of(dev, struct unit_directory, device);
 	scsi_id = ud->device.driver_data;
+	if (!scsi_id)
+		return 0;
+
+	/* Trigger shutdown functions in scsi's highlevel. */
+	if (scsi_id->scsi_host)
+		scsi_unblock_requests(scsi_id->scsi_host);
+	sdev = scsi_id->sdev;
+	if (sdev) {
+		scsi_id->sdev = NULL;
+		scsi_remove_device(sdev);
+	}
 
 	sbp2_logout_device(scsi_id);
 	sbp2_remove_device(scsi_id);
@@ -944,6 +961,7 @@ alloc_fail:
 		SBP2_ERR("scsi_add_device failed");
 		return PTR_ERR(sdev);
 	}
+	scsi_device_put(sdev);
 
 	return 0;
 }
@@ -2480,7 +2498,7 @@ static int sbp2scsi_queuecommand(struct 
 	 * If scsi_id is null, it means there is no device in this slot,
 	 * so we should return selection timeout.
 	 */
-	if (!scsi_id) {
+	if (!sbp2util_node_is_available(scsi_id)) {
 		SCpnt->result = DID_NO_CONNECT << 16;
 		done (SCpnt);
 		return 0;
@@ -2683,6 +2701,18 @@ static void sbp2scsi_complete_command(st
 }
 
 
+static int sbp2scsi_slave_alloc(struct scsi_device *sdev)
+{
+	((struct scsi_id_instance_data *)sdev->host->hostdata[0])->sdev = sdev;
+	return 0;
+}
+
+static void sbp2scsi_slave_destroy(struct scsi_device *sdev)
+{
+	((struct scsi_id_instance_data *)sdev->host->hostdata[0])->sdev = NULL;
+	return;
+}
+
 static int sbp2scsi_slave_configure (struct scsi_device *sdev)
 {
 	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
@@ -2705,7 +2735,7 @@ static int sbp2scsi_abort(struct scsi_cm
 	SBP2_ERR("aborting sbp2 command");
 	scsi_print_command(SCpnt);
 
-	if (scsi_id) {
+	if (sbp2util_node_is_available(scsi_id)) {
 
 		/*
 		 * Right now, just return any matching command structures
@@ -2749,7 +2779,7 @@ static int __sbp2scsi_reset(struct scsi_
 
 	SBP2_ERR("reset requested");
 
-	if (scsi_id) {
+	if (sbp2util_node_is_available(scsi_id)) {
 		SBP2_ERR("Generating sbp2 fetch agent reset");
 		sbp2_agent_reset(scsi_id, 0);
 	}
@@ -2817,7 +2847,9 @@ static struct scsi_host_template scsi_dr
 	.eh_device_reset_handler =	sbp2scsi_reset,
 	.eh_bus_reset_handler =		sbp2scsi_reset,
 	.eh_host_reset_handler =	sbp2scsi_reset,
+	.slave_alloc =			sbp2scsi_slave_alloc,
 	.slave_configure =		sbp2scsi_slave_configure,
+	.slave_destroy =		sbp2scsi_slave_destroy,
 	.this_id =			-1,
 	.sg_tablesize =			SG_ALL,
 	.use_clustering =		ENABLE_CLUSTERING,

--
