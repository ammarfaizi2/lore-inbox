Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWHXL2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHXL2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWHXL2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:28:07 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:29458 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751133AbWHXL2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:28:04 -0400
Date: Thu, 24 Aug 2006 13:28:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [patch] s390: dasd PAV enabling.
Message-ID: <20060824112802.GA7022@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] dasd PAV enabling.

The subsystem check in the PAV code is incorrect, it enables PAV
per device instead of per subsystem.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |    8 ++++----
 drivers/s390/block/dasd_eckd.c   |   14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-08-24 12:09:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-08-24 12:10:19.000000000 +0200
@@ -54,11 +54,11 @@ struct dasd_devmap {
  */
 struct dasd_server_ssid_map {
 	struct list_head list;
-	struct server_id {
+	struct system_id {
 		char vendor[4];
 		char serial[15];
+		__u16 ssid;
 	} sid;
-	__u16 ssid;
 };
 
 static struct list_head dasd_server_ssid_list;
@@ -904,14 +904,14 @@ dasd_set_uid(struct ccw_device *cdev, st
 		return -ENOMEM;
 	strncpy(srv->sid.vendor, uid->vendor, sizeof(srv->sid.vendor) - 1);
 	strncpy(srv->sid.serial, uid->serial, sizeof(srv->sid.serial) - 1);
-	srv->ssid = uid->ssid;
+	srv->sid.ssid = uid->ssid;
 
 	/* server is already contained ? */
 	spin_lock(&dasd_devmap_lock);
 	devmap->uid = *uid;
 	list_for_each_entry(tmp, &dasd_server_ssid_list, list) {
 		if (!memcmp(&srv->sid, &tmp->sid,
-			    sizeof(struct dasd_server_ssid_map))) {
+			    sizeof(struct system_id))) {
 			kfree(srv);
 			srv = NULL;
 			break;
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-08-24 12:09:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-08-24 12:10:19.000000000 +0200
@@ -607,7 +607,7 @@ dasd_eckd_psf_ssc(struct dasd_device *de
  * Valide storage server of current device.
  */
 static int
-dasd_eckd_validate_server(struct dasd_device *device)
+dasd_eckd_validate_server(struct dasd_device *device, struct dasd_uid *uid)
 {
 	int rc;
 
@@ -616,11 +616,11 @@ dasd_eckd_validate_server(struct dasd_de
 		return 0;
 
 	rc = dasd_eckd_psf_ssc(device);
-	if (rc)
-		/* may be requested feature is not available on server,
-		 * therefore just report error and go ahead */
-		DEV_MESSAGE(KERN_INFO, device,
-			    "Perform Subsystem Function returned rc=%d", rc);
+	/* may be requested feature is not available on server,
+	 * therefore just report error and go ahead */
+	DEV_MESSAGE(KERN_INFO, device,
+		    "PSF-SSC on storage subsystem %s.%s.%04x returned rc=%d",
+		    uid->vendor, uid->serial, uid->ssid, rc);
 	/* RE-Read Configuration Data */
 	return dasd_eckd_read_conf(device);
 }
@@ -666,7 +666,7 @@ dasd_eckd_check_characteristics(struct d
 		return rc;
 	rc = dasd_set_uid(device->cdev, &uid);
 	if (rc == 1)	/* new server found */
-		rc = dasd_eckd_validate_server(device);
+		rc = dasd_eckd_validate_server(device, &uid);
 	if (rc)
 		return rc;
 
