Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312042AbSCQPVB>; Sun, 17 Mar 2002 10:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312044AbSCQPUw>; Sun, 17 Mar 2002 10:20:52 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:33015 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S312042AbSCQPUm>; Sun, 17 Mar 2002 10:20:42 -0500
Message-ID: <3C94B425.2000603@didntduck.org>
Date: Sun, 17 Mar 2002 10:20:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, bfennema@calpoly.edu
Subject: [PATCH] struct super_block cleanup - udf
Content-Type: multipart/mixed;
 boundary="------------050708070406030700050509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050708070406030700050509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates udf_sb_info from struct super_block.

-- 

						Brian Gerst

--------------050708070406030700050509
Content-Type: text/plain;
 name="sb-udf-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-udf-1"

diff -urN linux-2.5.7-pre2/fs/udf/super.c linux/fs/udf/super.c
--- linux-2.5.7-pre2/fs/udf/super.c	Sat Mar 16 00:17:33 2002
+++ linux/fs/udf/super.c	Sat Mar 16 01:09:32 2002
@@ -1413,12 +1413,17 @@
 	struct inode *inode=NULL;
 	struct udf_options uopt;
 	lb_addr rootdir, fileset;
+	struct udf_sb_info *sbi;
 
 	uopt.flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
 	uopt.uid = -1;
 	uopt.gid = -1;
 	uopt.umask = 0;
 
+	sbi = kmalloc(sizeof(struct udf_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	sb->u.generic_sbp = sbi;
 	memset(UDF_SB(sb), 0x00, sizeof(struct udf_sb_info));
 
 #if UDFFS_RW != 1
@@ -1607,6 +1612,8 @@
 		udf_close_lvid(sb);
 	udf_release_data(UDF_SB_LVIDBH(sb));
 	UDF_SB_FREE(sb);
+	kfree(sbi);
+	sb->u.generic_sbp = NULL;
 	return -EINVAL;
 }
 
@@ -1697,6 +1704,8 @@
 		udf_close_lvid(sb);
 	udf_release_data(UDF_SB_LVIDBH(sb));
 	UDF_SB_FREE(sb);
+	kfree(sb->u.generic_sbp);
+	sb->u.generic_sbp = NULL;
 }
 
 /*
diff -urN linux-2.5.7-pre2/fs/udf/udf_sb.h linux/fs/udf/udf_sb.h
--- linux-2.5.7-pre2/fs/udf/udf_sb.h	Sat Mar 16 00:17:33 2002
+++ linux/fs/udf/udf_sb.h	Sat Mar 16 01:18:22 2002
@@ -30,6 +30,11 @@
 #define UDF_PART_FLAG_REWRITABLE	0x0040
 #define UDF_PART_FLAG_OVERWRITABLE	0x0080
 
+static inline struct udf_sb_info *UDF_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 #define UDF_SB_FREE(X)\
 {\
 	if (UDF_SB(X))\
@@ -39,7 +44,6 @@
 		UDF_SB_PARTMAPS(X) = NULL;\
 	}\
 }
-#define UDF_SB(X)	(&((X)->u.udf_sb))
 
 #define UDF_SB_ALLOC_PARTMAPS(X,Y)\
 {\
diff -urN linux-2.5.7-pre2/fs/udf/udfdecl.h linux/fs/udf/udfdecl.h
--- linux-2.5.7-pre2/fs/udf/udfdecl.h	Sat Mar 16 00:17:33 2002
+++ linux/fs/udf/udfdecl.h	Sat Mar 16 01:16:39 2002
@@ -8,6 +8,8 @@
 #include <linux/fs.h>
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/udf_fs_i.h>
+#include <linux/udf_fs_sb.h>
 
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
@@ -15,8 +17,6 @@
 
 #if !defined(CONFIG_UDF_FS) && !defined(CONFIG_UDF_FS_MODULE)
 #define CONFIG_UDF_FS_MODULE
-#include <linux/udf_fs_i.h>
-#include <linux/udf_fs_sb.h>
 #endif
 
 #include "udfend.h"
diff -urN linux-2.5.7-pre2/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre2/include/linux/fs.h	Sat Mar 16 00:17:34 2002
+++ linux/include/linux/fs.h	Sat Mar 16 01:12:41 2002
@@ -657,7 +657,6 @@
 #include <linux/adfs_fs_sb.h>
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
-#include <linux/udf_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
 extern struct list_head super_blocks;
@@ -707,7 +706,6 @@
 		struct adfs_sb_info	adfs_sb;
 		struct reiserfs_sb_info	reiserfs_sb;
 		struct bfs_sb_info	bfs_sb;
-		struct udf_sb_info	udf_sb;
 		struct jffs2_sb_info	jffs2_sb;
 		void			*generic_sbp;
 	} u;

--------------050708070406030700050509--

