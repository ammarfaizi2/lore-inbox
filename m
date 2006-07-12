Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWGLFqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWGLFqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGLFqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:46:30 -0400
Received: from xenotime.net ([66.160.160.81]:45739 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751336AbWGLFq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:46:29 -0400
Date: Tue, 11 Jul 2006 22:48:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: viro@zeniv.linux.org.uk, akpm <akpm@osdl.org>
Subject: [PATCH -mm] fs/namespace: handle init/registration errors
Message-Id: <20060711224823.6117711d.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle init errors.
sysfs_init() isn't __must_check, but it makes sense to check it too
while we are at it.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/namespace.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

--- linux-2618-rc1mm1.orig/fs/namespace.c
+++ linux-2618-rc1mm1/fs/namespace.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/quotaops.h>
 #include <linux/acct.h>
 #include <linux/capability.h>
@@ -1815,6 +1816,7 @@ void __init mnt_init(unsigned long mempa
 	struct list_head *d;
 	unsigned int nr_hash;
 	int i;
+	int err;
 
 	init_rwsem(&namespace_sem);
 
@@ -1855,8 +1857,14 @@ void __init mnt_init(unsigned long mempa
 		d++;
 		i--;
 	} while (i);
-	sysfs_init();
-	subsystem_register(&fs_subsys);
+	err = sysfs_init();
+	if (err)
+		printk(KERN_WARNING "%s: sysfs_init error: %d\n",
+			__FUNCTION__, err);
+	err = subsystem_register(&fs_subsys);
+	if (err)
+		printk(KERN_WARNING "%s: subsystem_register error: %d\n",
+			__FUNCTION__, err);
 	init_rootfs();
 	init_mount_tree();
 }


---
