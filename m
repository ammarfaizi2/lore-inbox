Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWHPMEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWHPMEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWHPMEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:04:53 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:16249 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751126AbWHPMEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:04:52 -0400
Date: Wed, 16 Aug 2006 14:04:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [patch] s390: dasd calls kzalloc while holding a spinlock.
Message-ID: <20060816120449.GA24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] dasd calls kzalloc while holding a spinlock.

The dasd function dasd_set_uid calls kzalloc while holding the
dasd_devmap_lock. Rearrange the code to do the memory allocation
outside the lock.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   65 ++++++++++++++++-----------------------
 drivers/s390/block/dasd_eckd.c   |    8 ++--
 2 files changed, 32 insertions(+), 41 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-08-16 13:36:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-08-16 13:36:31.000000000 +0200
@@ -89,7 +89,7 @@ static char *dasd[256];
 module_param_array(dasd, charp, NULL, 0);
 
 /*
- * Single spinlock to protect devmap structures and lists.
+ * Single spinlock to protect devmap and servermap structures and lists.
  */
 static DEFINE_SPINLOCK(dasd_devmap_lock);
 
@@ -859,39 +859,6 @@ static struct attribute_group dasd_attr_
 };
 
 /*
- * Check if the related storage server is already contained in the
- * dasd_serverlist. If server is not contained, create new entry.
- * Return 0 if server was already in serverlist,
- *	  1 if the server was added successfully
- *	 <0 in case of error.
- */
-static int
-dasd_add_server(struct dasd_uid *uid)
-{
-	struct dasd_servermap *new, *tmp;
-
-	/* check if server is already contained */
-	list_for_each_entry(tmp, &dasd_serverlist, list)
-	  // normale cmp?
-		if (strncmp(tmp->sid.vendor, uid->vendor,
-			    sizeof(tmp->sid.vendor)) == 0
-		    && strncmp(tmp->sid.serial, uid->serial,
-			       sizeof(tmp->sid.serial)) == 0)
-			return 0;
-
-	new = (struct dasd_servermap *)
-		kzalloc(sizeof(struct dasd_servermap), GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	strncpy(new->sid.vendor, uid->vendor, sizeof(new->sid.vendor));
-	strncpy(new->sid.serial, uid->serial, sizeof(new->sid.serial));
-	list_add(&new->list, &dasd_serverlist);
-	return 1;
-}
-
-
-/*
  * Return copy of the device unique identifier.
  */
 int
@@ -910,6 +877,8 @@ dasd_get_uid(struct ccw_device *cdev, st
 
 /*
  * Register the given device unique identifier into devmap struct.
+ * In addition check if the related storage server is already contained in the
+ * dasd_serverlist. If server is not contained, create new entry.
  * Return 0 if server was already in serverlist,
  *	  1 if the server was added successful
  *	 <0 in case of error.
@@ -918,16 +887,38 @@ int
 dasd_set_uid(struct ccw_device *cdev, struct dasd_uid *uid)
 {
 	struct dasd_devmap *devmap;
-	int rc;
+	struct dasd_servermap *srv, *tmp;
 
 	devmap = dasd_find_busid(cdev->dev.bus_id);
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
+
+	/* generate entry for servermap */
+	srv = (struct dasd_servermap *)
+		kzalloc(sizeof(struct dasd_servermap), GFP_KERNEL);
+	if (!srv)
+		return -ENOMEM;
+	strncpy(srv->sid.vendor, uid->vendor, sizeof(srv->sid.vendor) - 1);
+	strncpy(srv->sid.serial, uid->serial, sizeof(srv->sid.serial) - 1);
+
+	/* server is already contained ? */
 	spin_lock(&dasd_devmap_lock);
 	devmap->uid = *uid;
-	rc = dasd_add_server(uid);
+	list_for_each_entry(tmp, &dasd_serverlist, list) {
+		if (!memcmp(&srv->sid, &tmp->sid,
+			    sizeof(struct dasd_servermap))) {
+			kfree(srv);
+			srv = NULL;
+			break;
+		}
+	}
+
+	/* add servermap to serverlist */
+	if (srv)
+		list_add(&srv->list, &dasd_serverlist);
 	spin_unlock(&dasd_devmap_lock);
-	return rc;
+
+	return (srv ? 1 : 0);
 }
 EXPORT_SYMBOL_GPL(dasd_set_uid);
 
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-08-16 13:36:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-08-16 13:36:31.000000000 +0200
@@ -468,11 +468,11 @@ dasd_eckd_generate_uid(struct dasd_devic
 		return -ENODEV;
 
 	memset(uid, 0, sizeof(struct dasd_uid));
-	strncpy(uid->vendor, confdata->ned1.HDA_manufacturer,
-		sizeof(uid->vendor) - 1);
+	memcpy(uid->vendor, confdata->ned1.HDA_manufacturer,
+	       sizeof(uid->vendor) - 1);
 	EBCASC(uid->vendor, sizeof(uid->vendor) - 1);
-	strncpy(uid->serial, confdata->ned1.HDA_location,
-		sizeof(uid->serial) - 1);
+	memcpy(uid->serial, confdata->ned1.HDA_location,
+	       sizeof(uid->serial) - 1);
 	EBCASC(uid->serial, sizeof(uid->serial) - 1);
 	uid->ssid = confdata->neq.subsystemID;
 	if (confdata->ned2.sneq.flags == 0x40) {
