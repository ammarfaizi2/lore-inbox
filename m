Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVIITlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVIITlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVIITlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:41:31 -0400
Received: from magic.adaptec.com ([216.52.22.17]:18375 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030384AbVIITlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:41:25 -0400
Message-ID: <4321E55F.3030105@adaptec.com>
Date: Fri, 09 Sep 2005 15:41:19 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 10/14] sas-class: sas_init.c SAS Transport Layer initialization
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:41:24.0727 (UTC) FILETIME=[7668B870:01C5B576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/sas-class/sas_init.c linux-2.6.13/drivers/scsi/sas-class/sas_init.c
--- linux-2.6.13-orig/drivers/scsi/sas-class/sas_init.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/sas-class/sas_init.c	2005-09-09 11:14:29.000000000 -0400
@@ -0,0 +1,229 @@
+/*
+ * Serial Attached SCSI (SAS) Transport Layer initialization
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_init.c#44 $
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <scsi/scsi_host.h>
+
+#include "sas_internal.h"
+#include <scsi/sas/sas_task.h>
+
+kmem_cache_t *sas_task_cache;
+
+/* ---------- HA events ---------- */
+
+void sas_hae_reset(struct sas_ha_struct *sas_ha)
+{
+	;
+}
+
+/* ---------- HA attributes ---------- */
+
+static ssize_t sas_ha_name_show(struct sas_ha_struct *sas_ha, char *buf)
+{
+	if (sas_ha->sas_ha_name)
+		return sprintf(buf, "%s\n", sas_ha->sas_ha_name);
+	return 0;
+}
+
+static ssize_t sas_ha_addr_show(struct sas_ha_struct *sas_ha, char *buf)
+{
+	return sprintf(buf, "%llx\n", SAS_ADDR(sas_ha->sas_addr));
+}
+
+/* ---------- SAS HA Class ---------- */
+
+#define to_sas_ha(_obj) container_of(to_kset(_obj),struct sas_ha_struct,ha_kset)
+#define to_ha_attr(_attr) container_of(_attr, struct ha_attribute, attr)
+
+struct ha_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct sas_ha_struct *sas_ha, char *);
+	ssize_t (*store)(struct sas_ha_struct *sas_ha,const char *,size_t len);
+};
+
+static ssize_t ha_show_attr(struct kobject *kobj,
+		     struct attribute *attr,
+		     char *page)
+{
+	ssize_t ret = 0;
+	struct sas_ha_struct *sas_ha = to_sas_ha(kobj);
+	struct ha_attribute *ha_attr = to_ha_attr(attr);
+	
+	if (ha_attr->show)
+		ret = ha_attr->show(sas_ha, page);
+	return ret;
+}
+
+static struct ha_attribute ha_attrs[] = {
+	__ATTR(ha_name, 0444, sas_ha_name_show, NULL),
+	__ATTR(device_name, 0444, sas_ha_addr_show, NULL),
+	__ATTR_NULL,
+};
+
+static struct attribute *def_attrs[ARRAY_SIZE(ha_attrs)];
+
+static struct sysfs_ops ha_sysfs_ops = {
+	.show = ha_show_attr,
+};
+
+static struct kobj_type ha_ktype = {
+	.sysfs_ops = &ha_sysfs_ops,
+	.default_attrs = def_attrs,
+};
+
+/* This is our "root". */
+static struct kset sas_kset = {
+	.kobj = { .name = "sas" },
+	.ktype = &ha_ktype,	  /* children are of this type */
+};
+
+int sas_register_ha(struct sas_ha_struct *sas_ha)
+{
+	int i, error = 0;
+
+	spin_lock_init(&sas_ha->phy_port_lock);
+	sas_hash_addr(sas_ha->hashed_sas_addr, sas_ha->sas_addr);
+
+	if (sas_ha->lldd_queue_size == 0)
+		sas_ha->lldd_queue_size = 1;
+	else if (sas_ha->lldd_queue_size == -1)
+		sas_ha->lldd_queue_size = 128; /* Sanity */
+
+	error = sas_register_scsi_host(sas_ha);
+	if (error) {
+		printk(KERN_NOTICE "couldn't register scsi host\n");
+		return error;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(def_attrs)-1; i++)
+		def_attrs[i] = &ha_attrs[i].attr;
+	def_attrs[i] = NULL;
+
+	/* make sas/ appear */
+	sas_kset.kobj.parent = &sas_ha->core.shost->shost_gendev.kobj;
+	kset_register(&sas_kset);
+
+	/* make sas/ha/ appear */
+	kobject_set_name(&sas_ha->ha_kset.kobj, "%s", "ha");
+	sas_ha->ha_kset.kobj.kset = &sas_kset; /* parent */
+	sas_ha->ha_kset.kobj.ktype = sas_kset.ktype;
+	kset_register(&sas_ha->ha_kset);
+	
+	error = sas_register_phys(sas_ha);
+	if (error) {
+		printk(KERN_NOTICE "couldn't register sas phys:%d\n", error);
+		goto Undo;
+	}
+
+	error = sas_register_ports(sas_ha); 
+ 	if (error) {
+ 		printk(KERN_NOTICE "couldn't register sas ports:%d\n", error);
+ 		goto Undo_phys;
+ 	}
+
+	error = sas_start_event_thread(sas_ha);
+	if (error) {
+		printk(KERN_NOTICE "couldn't start event thread:%d\n", error);
+		goto Undo_ports;
+	}
+
+	if (sas_ha->lldd_max_execute_num > 1) {
+		error = sas_init_queue(sas_ha);
+		if (!error)
+			kobject_register(&sas_ha->core.scsi_core_obj);
+		else {
+			printk(KERN_NOTICE "couldn't start queue thread:%d, "
+			       "running in direct mode\n", error);
+			sas_ha->lldd_max_execute_num = 1;
+		}
+	}
+	
+	return 0;
+
+Undo_ports:
+	sas_unregister_ports(sas_ha);
+Undo_phys:
+	sas_unregister_phys(sas_ha);
+Undo:
+	kset_unregister(&sas_ha->ha_kset);
+	kset_unregister(&sas_kset);
+	sas_unregister_scsi_host(sas_ha);	
+
+	return error;
+}
+
+int sas_unregister_ha(struct sas_ha_struct *sas_ha)
+{
+	sas_unregister_devices(sas_ha);
+	
+	if (sas_ha->lldd_max_execute_num > 1) {
+		kobject_unregister(&sas_ha->core.scsi_core_obj);
+		sas_shutdown_queue(sas_ha);
+	}
+
+	sas_kill_event_thread(sas_ha);
+
+	sas_unregister_ports(sas_ha);
+	sas_unregister_phys(sas_ha);
+
+	kset_unregister(&sas_ha->ha_kset);
+	kset_unregister(&sas_kset);
+
+	sas_unregister_scsi_host(sas_ha);
+	
+	return 0;
+}
+
+/* ---------- SAS Class register/unregister ---------- */
+
+static int __init sas_class_init(void)
+{
+	sas_task_cache = kmem_cache_create("sas_task", sizeof(struct sas_task),
+					   0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!sas_task_cache)
+		return -ENOMEM;
+	
+	return 0;
+}
+
+static void __exit sas_class_exit(void)
+{
+	if (sas_task_cache)
+		kmem_cache_destroy(sas_task_cache);
+}
+
+MODULE_AUTHOR("Luben Tuikov <luben_tuikov@adaptec.com>");
+MODULE_DESCRIPTION("SAS Transport Layer");
+MODULE_LICENSE("GPL v2");
+
+module_init(sas_class_init);
+module_exit(sas_class_exit);
+
+EXPORT_SYMBOL_GPL(sas_register_ha);
+EXPORT_SYMBOL_GPL(sas_unregister_ha);


