Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWHPMGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWHPMGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWHPMGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:06:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:9267 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751130AbWHPMGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:06:03 -0400
Date: Wed, 16 Aug 2006 14:06:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [patch] s390: inaccessible PAV alias devices on LPAR.
Message-ID: <20060816120600.GC24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] inaccessible PAV alias devices on LPAR.

In some situations PAV alias devices on LPAR are not accessible.
The initialization procedure required to enable access to PAV alias
devices has to be performed per storage server subsystem and not
only once per storage server.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-08-16 13:36:33.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-08-16 13:36:33.000000000 +0200
@@ -48,18 +48,20 @@ struct dasd_devmap {
 };
 
 /*
- * dasd_servermap is used to store the server_id of all storage servers
- * accessed by DASD device driver.
+ * dasd_server_ssid_map contains a globally unique storage server subsystem ID.
+ * dasd_server_ssid_list contains the list of all subsystem IDs accessed by
+ * the DASD device driver.
  */
-struct dasd_servermap {
+struct dasd_server_ssid_map {
 	struct list_head list;
 	struct server_id {
 		char vendor[4];
 		char serial[15];
 	} sid;
+	__u16 ssid;
 };
 
-static struct list_head dasd_serverlist;
+static struct list_head dasd_server_ssid_list;
 
 /*
  * Parameter parsing functions for dasd= parameter. The syntax is:
@@ -878,8 +880,9 @@ dasd_get_uid(struct ccw_device *cdev, st
 
 /*
  * Register the given device unique identifier into devmap struct.
- * In addition check if the related storage server is already contained in the
- * dasd_serverlist. If server is not contained, create new entry.
+ * In addition check if the related storage server subsystem ID is already
+ * contained in the dasd_server_ssid_list. If subsystem ID is not contained,
+ * create new entry.
  * Return 0 if server was already in serverlist,
  *	  1 if the server was added successful
  *	 <0 in case of error.
@@ -888,26 +891,27 @@ int
 dasd_set_uid(struct ccw_device *cdev, struct dasd_uid *uid)
 {
 	struct dasd_devmap *devmap;
-	struct dasd_servermap *srv, *tmp;
+	struct dasd_server_ssid_map *srv, *tmp;
 
 	devmap = dasd_find_busid(cdev->dev.bus_id);
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
 
-	/* generate entry for servermap */
-	srv = (struct dasd_servermap *)
-		kzalloc(sizeof(struct dasd_servermap), GFP_KERNEL);
+	/* generate entry for server_ssid_map */
+	srv = (struct dasd_server_ssid_map *)
+		kzalloc(sizeof(struct dasd_server_ssid_map), GFP_KERNEL);
 	if (!srv)
 		return -ENOMEM;
 	strncpy(srv->sid.vendor, uid->vendor, sizeof(srv->sid.vendor) - 1);
 	strncpy(srv->sid.serial, uid->serial, sizeof(srv->sid.serial) - 1);
+	srv->ssid = uid->ssid;
 
 	/* server is already contained ? */
 	spin_lock(&dasd_devmap_lock);
 	devmap->uid = *uid;
-	list_for_each_entry(tmp, &dasd_serverlist, list) {
+	list_for_each_entry(tmp, &dasd_server_ssid_list, list) {
 		if (!memcmp(&srv->sid, &tmp->sid,
-			    sizeof(struct dasd_servermap))) {
+			    sizeof(struct dasd_server_ssid_map))) {
 			kfree(srv);
 			srv = NULL;
 			break;
@@ -916,7 +920,7 @@ dasd_set_uid(struct ccw_device *cdev, st
 
 	/* add servermap to serverlist */
 	if (srv)
-		list_add(&srv->list, &dasd_serverlist);
+		list_add(&srv->list, &dasd_server_ssid_list);
 	spin_unlock(&dasd_devmap_lock);
 
 	return (srv ? 1 : 0);
@@ -987,7 +991,7 @@ dasd_devmap_init(void)
 		INIT_LIST_HEAD(&dasd_hashlists[i]);
 
 	/* Initialize servermap structure. */
-	INIT_LIST_HEAD(&dasd_serverlist);
+	INIT_LIST_HEAD(&dasd_server_ssid_list);
 	return 0;
 }
 
