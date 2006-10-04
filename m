Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbWJDLFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbWJDLFO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030821AbWJDLFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:05:14 -0400
Received: from havoc.gtf.org ([69.61.125.42]:30088 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030576AbWJDLFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:05:12 -0400
Date: Wed, 4 Oct 2006 07:05:11 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] raid class: handle component-add errors
Message-ID: <20061004110511.GA19666@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/raid_class.c  |   20 ++++++++++++++++----
 include/linux/raid_class.h |    5 +++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 327b33a..e79f3d9 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -215,18 +215,19 @@ static void raid_component_release(struc
 	kfree(rc);
 }
 
-void raid_component_add(struct raid_template *r,struct device *raid_dev,
-			struct device *component_dev)
+int raid_component_add(struct raid_template *r,struct device *raid_dev,
+		       struct device *component_dev)
 {
 	struct class_device *cdev =
 		attribute_container_find_class_device(&r->raid_attrs.ac,
 						      raid_dev);
 	struct raid_component *rc;
 	struct raid_data *rd = class_get_devdata(cdev);
+	int err;
 
 	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
 	if (!rc)
-		return;
+		return -ENOMEM;
 
 	INIT_LIST_HEAD(&rc->node);
 	class_device_initialize(&rc->cdev);
@@ -239,7 +240,18 @@ void raid_component_add(struct raid_temp
 	list_add_tail(&rc->node, &rd->component_list);
 	rc->cdev.parent = cdev;
 	rc->cdev.class = &raid_class.class;
-	class_device_add(&rc->cdev);
+	err = class_device_add(&rc->cdev);
+	if (err)
+		goto err_out;
+	
+	return 0;
+
+err_out:
+	list_del(&rc->node);
+	rd->component_count--;
+	put_device(component_dev);
+	kfree(rc);
+	return err;
 }
 EXPORT_SYMBOL(raid_component_add);
 
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index d0dd38b..d22ad39 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -77,5 +77,6 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, s
 struct raid_template *raid_class_attach(struct raid_function_template *);
 void raid_class_release(struct raid_template *);
 
-void raid_component_add(struct raid_template *, struct device *,
-			struct device *);
+int __must_check raid_component_add(struct raid_template *, struct device *,
+				    struct device *);
+
