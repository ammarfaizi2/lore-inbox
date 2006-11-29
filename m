Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757667AbWK2Ms5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667AbWK2Ms5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 07:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757681AbWK2Ms5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 07:48:57 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:52668 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757667AbWK2Ms4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 07:48:56 -0500
Date: Wed, 29 Nov 2006 13:49:26 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch -mm 1/2] s390: Use dev->groups for subchannel attributes.
Message-ID: <20061129134926.4c8472a2@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Use dev->groups for adding/removing the subchannel attribute group.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/s390/cio/css.c    |    5 +----
 drivers/s390/cio/css.h    |    1 +
 drivers/s390/cio/device.c |   16 +++++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6-CH.orig/drivers/s390/cio/css.c
+++ linux-2.6-CH/drivers/s390/cio/css.c
@@ -137,6 +137,7 @@ css_register_subchannel(struct subchanne
 	sch->dev.parent = &css[0]->device;
 	sch->dev.bus = &css_bus_type;
 	sch->dev.release = &css_subchannel_release;
+	sch->dev.groups = subch_attr_groups;
 
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
@@ -146,10 +147,6 @@ css_register_subchannel(struct subchanne
 		return ret;
 	}
 	css_get_ssd_info(sch);
-	ret = subchannel_add_files(&sch->dev);
-	if (ret)
-		printk(KERN_WARNING "%s: could not add attributes to %s\n",
-		       __func__, sch->dev.bus_id);
 	return ret;
 }
 
--- linux-2.6-CH.orig/drivers/s390/cio/css.h
+++ linux-2.6-CH/drivers/s390/cio/css.h
@@ -190,4 +190,5 @@ extern struct workqueue_struct *slow_pat
 extern struct work_struct slow_path_work;
 
 int subchannel_add_files (struct device *);
+extern struct attribute_group *subch_attr_groups[];
 #endif
--- linux-2.6-CH.orig/drivers/s390/cio/device.c
+++ linux-2.6-CH/drivers/s390/cio/device.c
@@ -235,9 +235,11 @@ chpids_show (struct device * dev, struct
 	ssize_t ret = 0;
 	int chp;
 
-	for (chp = 0; chp < 8; chp++)
-		ret += sprintf (buf+ret, "%02x ", ssd->chpid[chp]);
-
+	if (ssd)
+		for (chp = 0; chp < 8; chp++)
+			ret += sprintf (buf+ret, "%02x ", ssd->chpid[chp]);
+	else
+		ret += sprintf (buf, "n/a");
 	ret += sprintf (buf+ret, "\n");
 	return min((ssize_t)PAGE_SIZE, ret);
 }
@@ -529,10 +531,10 @@ static struct attribute_group subch_attr
 	.attrs = subch_attrs,
 };
 
-int subchannel_add_files (struct device *dev)
-{
-	return sysfs_create_group(&dev->kobj, &subch_attr_group);
-}
+struct attribute_group *subch_attr_groups[] = {
+	&subch_attr_group,
+	NULL,
+};
 
 static struct attribute * ccwdev_attrs[] = {
 	&dev_attr_devtype.attr,
