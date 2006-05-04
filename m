Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWEDOBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWEDOBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWEDOBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:01:38 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:41074 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751038AbWEDOBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:01:37 -0400
Date: Thu, 4 May 2006 16:01:43 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: akpm@osdl.org
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi, greg@kroah.com
Subject: [PATCH 2/3] Add /sys/hypervisor subsystem
Message-Id: <20060504160143.2af57564.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To have a home for all hypervisors, this patch
creates /sys/hypervisor.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 include/linux/kobject.h |    2 ++
 kernel/ksysfs.c         |   26 +++++++++++++++++++++-----

diff -urpN linux-2.6.16-hypfs-2006-04-28-update2/include/linux/kobject.h linux-2.6.16-hypfs-2006-04-28-update3/include/linux/kobject.h
--- linux-2.6.16-hypfs-2006-04-28-update2/include/linux/kobject.h	2006-05-04 10:22:37.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-update3/include/linux/kobject.h	2006-05-04 10:29:47.000000000 +0200
@@ -186,6 +186,8 @@ struct subsystem _varname##_subsys = { \
 
 /* The global /sys/kernel/ subsystem for people to chain off of */
 extern struct subsystem kernel_subsys;
+/* The global /sys/hypervisor/ subsystem  */
+extern struct subsystem hypervisor_subsys;
 
 /**
  * Helpers for setting the kset of registered objects.
diff -urpN linux-2.6.16-hypfs-2006-04-28-update2/kernel/ksysfs.c linux-2.6.16-hypfs-2006-04-28-update3/kernel/ksysfs.c
--- linux-2.6.16-hypfs-2006-04-28-update2/kernel/ksysfs.c	2006-05-04 10:22:38.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-update3/kernel/ksysfs.c	2006-05-04 10:30:03.000000000 +0200
@@ -53,6 +53,8 @@ KERNEL_ATTR_RW(uevent_helper);
 
 decl_subsys(kernel, NULL, NULL);
 EXPORT_SYMBOL_GPL(kernel_subsys);
+decl_subsys(hypervisor, NULL, NULL);
+EXPORT_SYMBOL_GPL(hypervisor_subsys);
 
 static struct attribute * kernel_attrs[] = {
 #ifdef CONFIG_HOTPLUG
@@ -68,12 +70,26 @@ static struct attribute_group kernel_att
 
 static int __init ksysfs_init(void)
 {
-	int error = subsystem_register(&kernel_subsys);
-	if (!error)
-		error = sysfs_create_group(&kernel_subsys.kset.kobj,
-					   &kernel_attr_group);
+	int rc;
 
-	return error;
+	rc = subsystem_register(&hypervisor_subsys);
+	if (rc)
+		goto fail_hyp;
+	rc = subsystem_register(&kernel_subsys);
+	if (rc)
+		goto fail_kernel;
+	rc = sysfs_create_group(&kernel_subsys.kset.kobj,
+				&kernel_attr_group);
+	if (rc)
+		goto fail_group;
+	return 0;
+
+fail_group:
+	subsystem_unregister(&kernel_subsys);
+fail_kernel:
+	subsystem_unregister(&hypervisor_subsys);
+fail_hyp:
+	return rc;
 }
 
 core_initcall(ksysfs_init);
