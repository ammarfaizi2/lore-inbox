Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWJDOJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWJDOJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWJDOJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:09:10 -0400
Received: from havoc.gtf.org ([69.61.125.42]:30605 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964873AbWJDOJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:09:08 -0400
Date: Wed, 4 Oct 2006 10:09:07 -0400
From: Jeff Garzik <jeff@garzik.org>
To: airlied@linux.ie
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: fix error returns, sysfs error handling
Message-ID: <20061004140907.GA30208@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- callers of drm_sysfs_create() and drm_sysfs_device_add() looked for
  errors using IS_ERR(), but the functions themselves only ever returned
  NULL on error.  Fixed.

- unwind from, and propagate sysfs errors

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/char/drm/drm_sysfs.c |   43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/char/drm/drm_sysfs.c b/drivers/char/drm/drm_sysfs.c
index 51ad98c..ba4b8de 100644
--- a/drivers/char/drm/drm_sysfs.c
+++ b/drivers/char/drm/drm_sysfs.c
@@ -42,13 +42,24 @@ static CLASS_ATTR(version, S_IRUGO, vers
 struct class *drm_sysfs_create(struct module *owner, char *name)
 {
 	struct class *class;
+	int err;
 
 	class = class_create(owner, name);
-	if (!class)
-		return class;
+	if (!class) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = class_create_file(class, &class_attr_version);
+	if (err)
+		goto err_out_class;
 
-	class_create_file(class, &class_attr_version);
 	return class;
+
+err_out_class:
+	class_destroy(class);
+err_out:
+	return ERR_PTR(err);
 }
 
 /**
@@ -96,20 +107,36 @@ static struct class_device_attribute cla
 struct class_device *drm_sysfs_device_add(struct class *cs, drm_head_t *head)
 {
 	struct class_device *class_dev;
-	int i;
+	int i, j, err;
 
 	class_dev = class_device_create(cs, NULL,
 					MKDEV(DRM_MAJOR, head->minor),
 					&(head->dev->pdev)->dev,
 					"card%d", head->minor);
-	if (!class_dev)
-		return NULL;
+	if (!class_dev) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
 	class_set_devdata(class_dev, head);
 
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_create_file(class_dev, &class_device_attrs[i]);
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++) {
+		err = class_device_create_file(class_dev,
+					       &class_device_attrs[i]);
+		if (err)
+			goto err_out_files;
+	}
+
 	return class_dev;
+
+err_out_files:
+	if (i > 0)
+		for (j = 0; j < i; j++)
+			class_device_remove_file(class_dev,
+						 &class_device_attrs[i]);
+	class_device_unregister(class_dev);
+err_out:
+	return ERR_PTR(err);
 }
 
 /**
