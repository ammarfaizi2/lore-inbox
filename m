Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUD2DY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUD2DY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUD2DY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:24:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:45005 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263085AbUD2DYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:24:05 -0400
Date: Wed, 28 Apr 2004 20:26:12 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-log.c
Message-ID: <20040429032612.GA4193@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patches dm-log.c.  In dm-register-dirty-log-type, I didn't
seem any reason for the try_module_get to be within locked region
of code. So I moved it.  I also added the error return case, in 
the event try_module_get() fails.

I added THIS_MODULE intializers to the _core_type and _disk_type
declarations.  This isn't strictly necessary, but I think is
good for consistency.

I reordered the __init declaration in dm_dirty_log_init() I removed
dm_dirty_log_init and dm_dirty_log_exit() from the EXPORT_SYMBOL()
list.



diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-log.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-log.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-log.c	2004-04-28 11:41:52.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-log.c	2004-04-28 20:15:59.000000000 -0700
@@ -17,10 +17,11 @@
 
 int dm_register_dirty_log_type(struct dirty_log_type *type)
 {
+	if (!try_module_get(type->module))
+		return -EINVAL;
+
 	spin_lock(&_lock);
 	type->use_count = 0;
-	try_module_get(type->module);
-
 	list_add(&type->list, &_log_types);
 	spin_unlock(&_lock);
 
@@ -567,6 +568,7 @@
 
 static struct dirty_log_type _core_type = {
 	.name = "core",
+	.module = THIS_MODULE,
 	.ctr = core_ctr,
 	.dtr = core_dtr,
 	.get_region_size = core_get_region_size,
@@ -582,6 +584,7 @@
 
 static struct dirty_log_type _disk_type = {
 	.name = "disk",
+	.module = THIS_MODULE,
 	.ctr = disk_ctr,
 	.dtr = disk_dtr,
 	.suspend = disk_flush,
@@ -597,7 +600,7 @@
         .get_sync_count = core_get_sync_count
 };
 
-__init int dm_dirty_log_init(void)
+int __init dm_dirty_log_init(void)
 {
 	int r;
 
@@ -622,7 +625,5 @@
 
 EXPORT_SYMBOL(dm_register_dirty_log_type);
 EXPORT_SYMBOL(dm_unregister_dirty_log_type);
-EXPORT_SYMBOL(dm_dirty_log_init);
-EXPORT_SYMBOL(dm_dirty_log_exit);
 EXPORT_SYMBOL(dm_create_dirty_log);
 EXPORT_SYMBOL(dm_destroy_dirty_log);
