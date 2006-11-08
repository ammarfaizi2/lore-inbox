Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754380AbWKHG4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbWKHG4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 01:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbWKHG4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 01:56:25 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:34469 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1754375AbWKHG4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 01:56:24 -0500
Date: Wed, 8 Nov 2006 15:59:21 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: [PATHC] [2.6.19-rc4-mm2] driver/base/memory.c :: remove warnings of
 sysfs_create_file()
Message-Id: <20061108155921.62f9a68f.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got following messages at compile time.
==
drivers/base/memory.c: In function `memory_dev_init':
drivers/base/memory.c:293: warning: ignoring return value of `sysfs_create_file'
, declared with attribute warn_unused_result
==

This patch adds tests for returned value from sysfs_create_file().
This patch just prints warning if failed.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.19-rc4-mm2/drivers/base/memory.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/drivers/base/memory.c	2006-11-08 15:15:59.000000000 +0900
+++ linux-2.6.19-rc4-mm2/drivers/base/memory.c	2006-11-08 15:26:52.000000000 +0900
@@ -290,8 +290,14 @@
 
 static int block_size_init(void)
 {
-	sysfs_create_file(&memory_sysdev_class.kset.kobj,
-		&class_attr_block_size_bytes.attr);
+	int ret;
+	ret = sysfs_create_file(&memory_sysdev_class.kset.kobj,
+				&class_attr_block_size_bytes.attr);
+	if (ret < 0) {
+		/* We failed to init memory-hotplug infrastructure.
+		   But don't panic here */
+		printk(KERN_WARNING "cannot create memory hotplug interface\n");
+	}
 	return 0;
 }
 
@@ -323,8 +329,14 @@
 
 static int memory_probe_init(void)
 {
-	sysfs_create_file(&memory_sysdev_class.kset.kobj,
+	int ret;
+	ret = sysfs_create_file(&memory_sysdev_class.kset.kobj,
 		&class_attr_probe.attr);
+	if (ret < 0) {
+		/* we failed to init memory hotplug infrastructure.
+		   But don't panic here */
+		printk(KERN_WARNING "cannot create memory hotplug interface\n");
+	}
 	return 0;
 }
 #else

