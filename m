Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVFUE3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVFUE3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVFUCPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:15:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:36324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261749AbVFTW7u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:50 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Make attributes names const char *
In-Reply-To: <11193083613036@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <11193083612312@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Make attributes names const char *

sysfs: make attributes and attribute_group's names const char *

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d48593bf208e0d046c35fb0707ae5b23fef8c4ff
tree 8ee1375b7c7725c11238716646266d9a6d7fbc9f
parent 8d790d74085833ba2a3e84b5bcd683be4981c29a
author Dmitry Torokhov <dtor_core@ameritech.net> Fri, 29 Apr 2005 00:58:46 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:01 -0700

 drivers/infiniband/core/sysfs.c |  122 ++++++++++++++++-----------------------
 drivers/pci/pci-sysfs.c         |   13 ++--
 include/linux/sysfs.h           |    4 +
 3 files changed, 59 insertions(+), 80 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -40,9 +40,7 @@ struct ib_port {
 	struct kobject         kobj;
 	struct ib_device      *ibdev;
 	struct attribute_group gid_group;
-	struct attribute     **gid_attr;
 	struct attribute_group pkey_group;
-	struct attribute     **pkey_attr;
 	u8                     port_num;
 };
 
@@ -60,8 +58,9 @@ struct port_attribute port_attr_##_name 
 struct port_attribute port_attr_##_name = __ATTR_RO(_name)
 
 struct port_table_attribute {
-	struct port_attribute attr;
-	int                   index;
+	struct port_attribute	attr;
+	char			name[8];
+	int			index;
 };
 
 static ssize_t port_attr_show(struct kobject *kobj,
@@ -398,17 +397,16 @@ static void ib_port_release(struct kobje
 	struct attribute *a;
 	int i;
 
-	for (i = 0; (a = p->gid_attr[i]); ++i) {
-		kfree(a->name);
+	for (i = 0; (a = p->gid_group.attrs[i]); ++i)
 		kfree(a);
-	}
 
-	for (i = 0; (a = p->pkey_attr[i]); ++i) {
-		kfree(a->name);
+	kfree(p->gid_group.attrs);
+
+	for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
 		kfree(a);
-	}
 
-	kfree(p->gid_attr);
+	kfree(p->pkey_group.attrs);
+
 	kfree(p);
 }
 
@@ -449,58 +447,45 @@ static int ib_device_hotplug(struct clas
 	return 0;
 }
 
-static int alloc_group(struct attribute ***attr,
-		       ssize_t (*show)(struct ib_port *,
-				       struct port_attribute *, char *buf),
-		       int len)
+static struct attribute **
+alloc_group_attrs(ssize_t (*show)(struct ib_port *,
+				  struct port_attribute *, char *buf),
+		  int len)
 {
-	struct port_table_attribute ***tab_attr =
-		(struct port_table_attribute ***) attr;
+	struct attribute **tab_attr;
+	struct port_table_attribute *element;
 	int i;
-	int ret;
-
-	*tab_attr = kmalloc((1 + len) * sizeof *tab_attr, GFP_KERNEL);
-	if (!*tab_attr)
-		return -ENOMEM;
 
-	memset(*tab_attr, 0, (1 + len) * sizeof *tab_attr);
-
-	for (i = 0; i < len; ++i) {
-		(*tab_attr)[i] = kmalloc(sizeof *(*tab_attr)[i], GFP_KERNEL);
-		if (!(*tab_attr)[i]) {
-			ret = -ENOMEM;
-			goto err;
-		}
-		memset((*tab_attr)[i], 0, sizeof *(*tab_attr)[i]);
-		(*tab_attr)[i]->attr.attr.name = kmalloc(8, GFP_KERNEL);
-		if (!(*tab_attr)[i]->attr.attr.name) {
-			ret = -ENOMEM;
+	tab_attr = kcalloc(1 + len, sizeof(struct attribute *), GFP_KERNEL);
+	if (!tab_attr)
+		return NULL;
+
+	for (i = 0; i < len; i++) {
+		element = kcalloc(1, sizeof(struct port_table_attribute),
+				  GFP_KERNEL);
+		if (!element)
 			goto err;
-		}
 
-		if (snprintf((*tab_attr)[i]->attr.attr.name, 8, "%d", i) >= 8) {
-			ret = -ENOMEM;
+		if (snprintf(element->name, sizeof(element->name),
+			     "%d", i) >= sizeof(element->name))
 			goto err;
-		}
-
-		(*tab_attr)[i]->attr.attr.mode  = S_IRUGO;
-		(*tab_attr)[i]->attr.attr.owner = THIS_MODULE;
-		(*tab_attr)[i]->attr.show       = show;
-		(*tab_attr)[i]->index           = i;
-	}
 
-	return 0;
+		element->attr.attr.name  = element->name;
+		element->attr.attr.mode  = S_IRUGO;
+		element->attr.attr.owner = THIS_MODULE;
+		element->attr.show       = show;
+		element->index		 = i;
 
-err:
-	for (i = 0; i < len; ++i) {
-		if ((*tab_attr)[i])
-			kfree((*tab_attr)[i]->attr.attr.name);
-		kfree((*tab_attr)[i]);
+		tab_attr[i] = &element->attr.attr;
 	}
 
-	kfree(*tab_attr);
+	return tab_attr;
 
-	return ret;
+err:
+	while (--i >= 0)
+		kfree(tab_attr[i]);
+	kfree(tab_attr);
+	return NULL;
 }
 
 static int add_port(struct ib_device *device, int port_num)
@@ -541,23 +526,20 @@ static int add_port(struct ib_device *de
 	if (ret)
 		goto err_put;
 
-	ret = alloc_group(&p->gid_attr, show_port_gid, attr.gid_tbl_len);
-	if (ret)
-		goto err_remove_pma;
-
 	p->gid_group.name  = "gids";
-	p->gid_group.attrs = p->gid_attr;
+	p->gid_group.attrs = alloc_group_attrs(show_port_gid, attr.gid_tbl_len);
+	if (!p->gid_group.attrs)
+		goto err_remove_pma;
 
 	ret = sysfs_create_group(&p->kobj, &p->gid_group);
 	if (ret)
 		goto err_free_gid;
 
-	ret = alloc_group(&p->pkey_attr, show_port_pkey, attr.pkey_tbl_len);
-	if (ret)
-		goto err_remove_gid;
-
 	p->pkey_group.name  = "pkeys";
-	p->pkey_group.attrs = p->pkey_attr;
+	p->pkey_group.attrs = alloc_group_attrs(show_port_pkey,
+						attr.pkey_tbl_len);
+	if (!p->pkey_group.attrs)
+		goto err_remove_gid;
 
 	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
 	if (ret)
@@ -568,23 +550,19 @@ static int add_port(struct ib_device *de
 	return 0;
 
 err_free_pkey:
-	for (i = 0; i < attr.pkey_tbl_len; ++i) {
-		kfree(p->pkey_attr[i]->name);
-		kfree(p->pkey_attr[i]);
-	}
+	for (i = 0; i < attr.pkey_tbl_len; ++i)
+		kfree(p->pkey_group.attrs[i]);
 
-	kfree(p->pkey_attr);
+	kfree(p->pkey_group.attrs);
 
 err_remove_gid:
 	sysfs_remove_group(&p->kobj, &p->gid_group);
 
 err_free_gid:
-	for (i = 0; i < attr.gid_tbl_len; ++i) {
-		kfree(p->gid_attr[i]->name);
-		kfree(p->gid_attr[i]);
-	}
+	for (i = 0; i < attr.gid_tbl_len; ++i)
+		kfree(p->gid_group.attrs[i]);
 
-	kfree(p->gid_attr);
+	kfree(p->gid_group.attrs);
 
 err_remove_pma:
 	sysfs_remove_group(&p->kobj, &pma_group);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -339,16 +339,17 @@ pci_create_resource_files(struct pci_dev
 		if (!pci_resource_len(pdev, i))
 			continue;
 
-		res_attr = kmalloc(sizeof(*res_attr) + 10, GFP_ATOMIC);
+		/* allocate attribute structure, piggyback attribute name */
+		res_attr = kcalloc(1, sizeof(*res_attr) + 10, GFP_ATOMIC);
 		if (res_attr) {
-			memset(res_attr, 0, sizeof(*res_attr) + 10);
+			char *res_attr_name = (char *)(res_attr + 1);
+
 			pdev->res_attr[i] = res_attr;
-			/* Allocated above after the res_attr struct */
-			res_attr->attr.name = (char *)(res_attr + 1);
-			sprintf(res_attr->attr.name, "resource%d", i);
-			res_attr->size = pci_resource_len(pdev, i);
+			sprintf(res_attr_name, "resource%d", i);
+			res_attr->attr.name = res_attr_name;
 			res_attr->attr.mode = S_IRUSR | S_IWUSR;
 			res_attr->attr.owner = THIS_MODULE;
+			res_attr->size = pci_resource_len(pdev, i);
 			res_attr->mmap = pci_mmap_resource;
 			res_attr->private = &pdev->resource[i];
 			sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -16,13 +16,13 @@ struct kobject;
 struct module;
 
 struct attribute {
-	char			* name;
+	const char		* name;
 	struct module 		* owner;
 	mode_t			mode;
 };
 
 struct attribute_group {
-	char			* name;
+	const char		* name;
 	struct attribute	** attrs;
 };
 

