Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291042AbSBGBXm>; Wed, 6 Feb 2002 20:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291027AbSBGBXd>; Wed, 6 Feb 2002 20:23:33 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:63679 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291042AbSBGBXP>; Wed, 6 Feb 2002 20:23:15 -0500
Date: Thu, 7 Feb 2002 02:23:10 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Automatic file-max sizing
Message-ID: <20020207022310.A6206@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The default for NR_FILES of 8192 is far too low for many workloads. This
patch does dynamic sizing for it instead. It assumes file+inode+dentry
are roughly 1K and will use upto 10% of the memory for it. 

Also removes two obsolete prototypes.

Patch against 2.5.4pre1.

-Andi


--- linux-2.5.4pre1-work/fs/dcache.c-FILESSZ	Tue Jan 15 17:53:31 2002
+++ linux-2.5.4pre1-work/fs/dcache.c	Thu Feb  7 02:09:02 2002
@@ -1283,6 +1283,7 @@
 
 	dcache_init(mempages);
 	inode_init(mempages);
+	files_init(mempages); 
 	mnt_init(mempages);
 	bdev_cache_init();
 	cdev_cache_init();
--- linux-2.5.4pre1-work/fs/file_table.c-FILESSZ	Mon Sep 17 22:16:30 2001
+++ linux-2.5.4pre1-work/fs/file_table.c	Thu Feb  7 02:09:02 2002
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
--- linux-2.5.4pre1-work/include/linux/fs.h-FILESSZ	Thu Feb  7 01:46:26 2002
+++ linux-2.5.4pre1-work/include/linux/fs.h	Thu Feb  7 02:09:02 2002
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
 
