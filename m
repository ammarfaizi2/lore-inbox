Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289294AbSBEABK>; Mon, 4 Feb 2002 19:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289298AbSBEABB>; Mon, 4 Feb 2002 19:01:01 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:34455 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289294AbSBEAAz>; Mon, 4 Feb 2002 19:00:55 -0500
Date: Mon, 4 Feb 2002 05:53:46 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Size max files based on memory size
Message-ID: <20020204055346.A18191@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The default files_max settings of 8192 is rather low for many workloads. 
This patch changes it to be sized based on the available memory.  It assumes
file + inode + dentry are roughly 1K and will use upto 10% of the available
memory for files_max. 

Also removes two obsolete prototypes in the include file. 

Patch for 2.5.3.  Please consider applying.

Thanks,
-Andi


--- linux-2.5.3-work/fs/dcache.c-FILESSZ	Tue Jan 15 17:53:31 2002
+++ linux-2.5.3-work/fs/dcache.c	Mon Feb  4 05:43:51 2002
@@ -1283,6 +1283,7 @@
 
 	dcache_init(mempages);
 	inode_init(mempages);
+	files_init(mempages); 
 	mnt_init(mempages);
 	bdev_cache_init();
 	cdev_cache_init();
--- linux-2.5.3-work/fs/file_table.c-FILESSZ	Mon Sep 17 22:16:30 2001
+++ linux-2.5.3-work/fs/file_table.c	Mon Feb  4 05:43:43 2002
@@ -186,3 +186,17 @@
 	file_list_unlock();
 	return 0;
 }
+
+void __init files_init(unsigned long mempages)
+{ 
+	int n; 
+	/* One file with associated inode and dcache is very roughly 1K. 
+	 * Per default don't use more than 10% of our memory for files. 
+	 */ 
+
+	n = (mempages * (PAGE_SIZE / 1024)) / 10;
+	files_stat.max_files = n; 
+	if (files_stat.max_files < NR_FILE)
+		files_stat.max_files = NR_FILE;
+} 
+
--- linux-2.5.3-work/include/linux/fs.h-FILESSZ	Wed Jan 30 22:43:34 2002
+++ linux-2.5.3-work/include/linux/fs.h	Mon Feb  4 05:43:43 2002
@@ -208,6 +208,7 @@
 extern void buffer_init(unsigned long);
 extern void inode_init(unsigned long);
 extern void mnt_init(unsigned long);
+extern void files_init(unsigned long);
 
 /* bh state bits */
 enum bh_state_bits {
@@ -1475,8 +1476,6 @@
 	}
 	return 0;
 }
-unsigned long generate_cluster(kdev_t, int b[], int);
-unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
 extern char root_device_name[];
 
