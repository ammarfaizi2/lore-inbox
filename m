Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbUKXROo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbUKXROo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUKXREh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:04:37 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:52884 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262765AbUKXRCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:02:37 -0500
Subject: Suspend 2 merge: 50/51: Device mapper support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101300802.5805.398.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:02:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the device mapper support plugin. Its sole purpose is to ensure
that the device mapper allocates enough memory to process all of the I/O
we want to throw at it.

diff -ruN 856-suspend-dm-old/drivers/md/dm-io.c 856-suspend-dm-new/drivers/md/dm-io.c
--- 856-suspend-dm-old/drivers/md/dm-io.c	2004-11-03 21:55:01.000000000 +1100
+++ 856-suspend-dm-new/drivers/md/dm-io.c	2004-11-11 15:25:13.549327528 +1100
@@ -214,15 +214,6 @@
  *---------------------------------------------------------------*/
 static struct bio_set _bios;
 
-/* FIXME: can we shrink this ? */
-struct io {
-	unsigned long error;
-	atomic_t count;
-	struct task_struct *sleeper;
-	io_notify_fn callback;
-	void *context;
-};
-
 /*
  * io contexts are only dynamically allocated for asynchronous
  * io.  Since async io is likely to be the majority of io we'll
@@ -247,6 +238,13 @@
 	return 4 * pages;	/* too many ? */
 }
 
+/* Wrapper for exporting this, as suspend2 dm helper code needs this */
+unsigned int dm_pages_to_ios(unsigned int pages)
+{
+	return pages_to_ios(pages);
+}
+EXPORT_SYMBOL(dm_pages_to_ios);
+
 static int resize_pool(unsigned int new_ios)
 {
 	int r = 0;
diff -ruN 856-suspend-dm-old/drivers/md/dm-io.h 856-suspend-dm-new/drivers/md/dm-io.h
--- 856-suspend-dm-old/drivers/md/dm-io.h	2004-11-03 21:52:50.000000000 +1100
+++ 856-suspend-dm-new/drivers/md/dm-io.h	2004-11-09 08:35:30.000000000 +1100
@@ -8,6 +8,7 @@
 #define _DM_IO_H
 
 #include "dm.h"
+#include <linux/bio.h>
 
 /* FIXME make this configurable */
 #define DM_MAX_IO_REGIONS 8
@@ -30,6 +31,18 @@
  */
 typedef void (*io_notify_fn)(unsigned long error, void *context);
 
+/*
+ * Moved here from dm-io.c, as suspend2 dm code needs it
+ */
+/* FIXME: can we shrink this ? */
+struct io {
+        unsigned long error;
+        atomic_t count;
+        struct task_struct *sleeper;
+        io_notify_fn callback;
+        void *context;
+};
+
 
 /*
  * Before anyone uses the IO interface they should call
@@ -42,6 +55,11 @@
 void dm_io_put(unsigned int num_pages);
 
 /*
+ * The suspend2 dm helper code needs this one
+ */
+unsigned int dm_pages_to_ios(unsigned int pages);
+
+/*
  * Synchronous IO.
  *
  * Please ensure that the rw flag in the next two functions is
diff -ruN 856-suspend-dm-old/kernel/power/suspend_dm.c 856-suspend-dm-new/kernel/power/suspend_dm.c
--- 856-suspend-dm-old/kernel/power/suspend_dm.c	1970-01-01 10:00:00.000000000 +1000
+++ 856-suspend-dm-new/kernel/power/suspend_dm.c	2004-11-11 08:16:40.000000000 +1100
@@ -0,0 +1,136 @@
+/*
+ * kernel/power/suspend_dm.c
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains support for interfacing with the device mapper
+ * to allocate memory for its work.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+
+/* For calculating how much memory it needs */
+#include "../../drivers/md/dm-io.h"
+
+#include "suspend.h"
+#include "plugins.h"
+#include "proc.h"
+
+static struct suspend_plugin_ops suspend_dm_ops;
+static int io_get_result;
+
+/* ---- Exported functions ---- */
+
+/* suspend_dm_init()
+ *
+ * Description:	Allocate buffers for device mapper use.
+ * Returns:	Zero on success, -ENOMEM if unable to vmalloc.
+ */
+
+static int suspend_dm_init(void)
+{
+	io_get_result = dm_io_get(max_async_ios);
+	return io_get_result;
+}
+
+/* suspend_dm_cleanup()
+ *
+ * Description: Tell DM to release the memory we allocated.
+ * Returns:	Zero. Always works!
+ */
+
+static void suspend_dm_cleanup(void)
+{
+	if (!io_get_result)
+		dm_io_put(max_async_ios);
+}
+
+/* suspend_dm_save_config_info
+ *
+ * Description:	Save informaton needed when reloading the image at resume time.
+ * Arguments:	Buffer:		Pointer to a buffer of size PAGE_SIZE.
+ * Returns:	Number of bytes used for saving our data.
+ */
+
+static int suspend_dm_save_config_info(char * buffer)
+{
+	return 0;
+}
+
+/* suspend_dm_load_config_info
+ *
+ * Description:	Reload information needed for decompressing the image at 
+ * 		resume time.
+ * Arguments:	Buffer:		Pointer to the start of the data.
+ *		Size:		Number of bytes that were saved.
+ */
+
+static void suspend_dm_load_config_info(char * buffer, int size)
+{
+	BUG_ON(size);
+	return;
+}
+
+/*
+ * data for our proc entries.
+ */
+
+static struct suspend_proc_data disable_dm_support_proc_data = {
+	.filename			= "disable_device_mapper_support",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_INTEGER,
+	.data = {
+		.integer = {
+			.variable	= &suspend_dm_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	}
+};
+
+/*
+ * Ops structure.
+ */
+
+static struct suspend_plugin_ops suspend_dm_ops = {
+	.type			= MISC_PLUGIN,
+	.name			= "Device Mapper Support",
+	.initialise		= suspend_dm_init,
+	.cleanup		= suspend_dm_cleanup,
+	.save_config_info	= suspend_dm_save_config_info,
+	.load_config_info	= suspend_dm_load_config_info,
+};
+
+/* ---- Registration ---- */
+
+static __init int suspend_dm_load(void)
+{
+	int result;
+
+	if (!(result = suspend_register_plugin(&suspend_dm_ops))) {
+		printk("Software Suspend Device Mapper support registering.\n");
+		suspend_register_procfile(&disable_dm_support_proc_data);
+	}
+	return result;
+}
+
+#ifdef MODULE
+static __exit void suspend_dm_unload(void)
+{
+	printk("Software Suspend Device Mapper support unloading.\n");
+	suspend_unregister_procfile(&disable_dm_support_proc_data);
+	suspend_unregister_plugin(&suspend_dm_ops);
+}
+
+
+module_init(suspend_dm_load);
+module_exit(suspend_dm_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Device Mapper support for Suspend2");
+#else
+late_initcall(suspend_dm_load);
+#endif


