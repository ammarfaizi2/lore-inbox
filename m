Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262226AbSJJUP1>; Thu, 10 Oct 2002 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263953AbSJJUP0>; Thu, 10 Oct 2002 16:15:26 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:25055 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262226AbSJJUFm>; Thu, 10 Oct 2002 16:05:42 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (5/9) evms_core.h
Date: Thu, 10 Oct 2002 14:37:22 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <02101014372207.17770@boiler>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 5 of the EVMS core driver.

This is a private header file for the various files
that make up the core driver.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/drivers/evms/core/evms_core.h linux-2.5.41-evms/drivers/evms/core/evms_core.h
--- linux-2.5.41/drivers/evms/core/evms_core.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/core/evms_core.h	Thu Oct 10 11:16:58 2002
@@ -0,0 +1,95 @@
+/*
+ *   Copyright (c) International Business Machines  Corp., 2000 - 2002
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __EVMS_CORE_H__
+#define __EVMS_CORE_H__
+
+#define LOG_PREFIX
+
+//#define VFS_PATCH_PRESENT
+
+/**
+ * struct evms_io_notify - IO callback hook structure
+ * @rsector:
+ * @b_private:
+ * @private:
+ * @bio:
+ * @callback_function:
+ * @flags:
+ * @bdev:
+ *
+ * IO notification structure used to track each IO callback hook.
+ **/
+struct evms_io_notify {
+	u64 rsector;
+	void *b_private;
+	void *private;
+	struct bio *bio;
+	void (*callback_function)(void *private,
+				  struct bio * bio, int *redrive);
+	unsigned int flags;
+	struct block_device *bdev;
+};
+/**
+ * field evms_io_notify.flags defines
+ **/
+#define EVMS_ORIGINAL_CALLBACK_FLAG	(1<<0)
+
+/**
+ * struct evms_kevent
+ * @uevent
+ * @list
+ */
+struct evms_kevent {
+	struct evms_event uevent;
+	struct list_head list;
+};
+
+/* Global data shared among the core files. */
+extern struct list_head evms_logical_volumes;
+extern struct list_head evms_notify_list;
+extern struct list_head evms_fbottom_list;
+extern struct list_head plugin_head;
+extern spinlock_t plugin_lock;
+extern mempool_t *evms_io_notify_pool;
+extern struct proc_dir_entry *evms_proc_dir;
+extern struct block_device_operations evms_fops;
+extern devfs_handle_t evms_dir_devfs_handle;
+extern int evms_volumes;
+
+/* Functions shared among the core files. */
+extern struct evms_logical_volume * lookup_volume(int minor);
+extern struct evms_logical_volume * find_next_volume(struct evms_logical_volume *lv);
+extern struct evms_logical_volume * find_next_volume_safe(struct evms_logical_volume **next_lv);
+extern int evms_discover_volumes(struct evms_rediscover_pkt *);
+extern void evms_discover_logical_disks(struct list_head *);
+extern int evms_quiesce_volume(struct evms_logical_volume *volume,
+			       int command, int minor, int lock_vfs);
+extern int evms_make_request_fn(request_queue_t * q, struct bio *bio);
+extern int is_busy(kdev_t dev);
+
+/* If the VFS-lock patch has not been applied, need to declare empty
+ * inline functions for fsync_dev_lockfs() and unlockfs().
+ */
+#ifndef VFS_PATCH_PRESENT
+static inline int fsync_dev_lockfs(kdev_t dev) { return 0; }
+static inline void unlockfs(kdev_t dev) { }
+#endif
+
+#endif
+
˜A8qh
