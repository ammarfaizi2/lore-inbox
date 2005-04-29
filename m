Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVD2F7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVD2F7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVD2F7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:59:05 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:11161 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262392AbVD2F6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:58:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 6/5] Make attributes names const char *
Date: Fri, 29 Apr 2005 00:58:46 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200504260229.03866.dtor_core@ameritech.net> <20050428070022.GC12086@kroah.com>
In-Reply-To: <20050428070022.GC12086@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290058.46279.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: make attributes and attribute_group's names const char *

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/infiniband/core/sysfs.c |  122 ++++++++++++++++------------------------
 drivers/pci/pci-sysfs.c         |   13 ++--
 include/linux/sysfs.h           |    4 -
 3 files changed, 59 insertions(+), 80 deletions(-)

Index: dtor/include/linux/sysfs.h
===================================================================
--- dtor.orig/include/linux/sysfs.h
+++ dtor/include/linux/sysfs.h
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
 
Index: dtor/drivers/pci/pci-sysfs.c
===================================================================
--- dtor.orig/drivers/pci/pci-sysfs.c
+++ dtor/drivers/pci/pci-sysfs.c
@@ -293,16 +293,17 @@ pci_create_resource_files(struct pci_dev
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
Index: dtor/drivers/infiniband/core/sysfs.c
===================================================================
--- dtor.orig/drivers/infiniband/core/sysfs.c
+++ dtor/drivers/infiniband/core/sysfs.c
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
