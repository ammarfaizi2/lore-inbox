Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCLW5P>; Tue, 12 Mar 2002 17:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSCLW5A>; Tue, 12 Mar 2002 17:57:00 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:26505 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S286322AbSCLW4s>; Tue, 12 Mar 2002 17:56:48 -0500
Message-ID: <3C8E8794.5060903@didntduck.org>
Date: Tue, 12 Mar 2002 17:56:20 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>, vandrove@vc.cvut.cz,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - ncpfs
Content-Type: multipart/mixed;
 boundary="------------050902080709060800070608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050902080709060800070608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates ncp_sb_info from struct super_block.

-- 

						Brian Gerst

--------------050902080709060800070608
Content-Type: text/plain;
 name="sb-ncp-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-ncp-1"

diff -urN linux-2.5.7-pre1/fs/ncpfs/inode.c linux/fs/ncpfs/inode.c
--- linux-2.5.7-pre1/fs/ncpfs/inode.c	Tue Mar 12 17:35:11 2002
+++ linux/fs/ncpfs/inode.c	Tue Mar 12 17:44:53 2002
@@ -315,6 +315,10 @@
 #endif
 	struct ncp_entry_info finfo;
 
+	server = kmalloc(sizeof(struct ncp_server), GFP_KERNEL);
+	if (!server)
+		return -ENOMEM;
+	sb->u.generic_sbp = server;
 	error = -EFAULT;
 	if (raw_data == NULL)
 		goto out;
@@ -520,6 +524,8 @@
 	 */
 	fput(ncp_filp);
 out:
+	sb->u.generic_sbp = NULL;
+	kfree(server);
 	return error;
 }
 
@@ -553,7 +559,8 @@
 	if (server->auth.object_name)
 		ncp_kfree_s(server->auth.object_name, server->auth.object_name_len);
 	vfree(server->packet);
-
+	sb->u.generic_sbp = NULL;
+	kfree(server);
 }
 
 static int ncp_statfs(struct super_block *sb, struct statfs *buf)
diff -urN linux-2.5.7-pre1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre1/include/linux/fs.h	Tue Mar 12 17:35:11 2002
+++ linux/include/linux/fs.h	Tue Mar 12 17:40:30 2002
@@ -667,7 +667,6 @@
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
 #include <linux/udf_fs_sb.h>
-#include <linux/ncp_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
 extern struct list_head super_blocks;
@@ -724,7 +723,6 @@
 		struct reiserfs_sb_info	reiserfs_sb;
 		struct bfs_sb_info	bfs_sb;
 		struct udf_sb_info	udf_sb;
-		struct ncp_sb_info	ncpfs_sb;
 		struct jffs2_sb_info	jffs2_sb;
 		void			*generic_sbp;
 	} u;
diff -urN linux-2.5.7-pre1/include/linux/ncp_fs.h linux/include/linux/ncp_fs.h
--- linux-2.5.7-pre1/include/linux/ncp_fs.h	Thu Mar  7 21:18:17 2002
+++ linux/include/linux/ncp_fs.h	Tue Mar 12 17:44:20 2002
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 
 #include <linux/ncp_fs_i.h>
+#include <linux/ncp_fs_sb.h>
 #include <linux/ipx.h>
 #include <linux/ncp_no.h>
 
@@ -190,7 +191,10 @@
 #define NCP_SUPER_MAGIC  0x564c
 
 
-#define NCP_SBP(sb)		(&((sb)->u.ncpfs_sb))
+static inline struct ncp_server *NCP_SBP(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
 
 #define NCP_SERVER(inode)	NCP_SBP((inode)->i_sb)
 static inline struct ncp_inode_info *NCP_FINFO(struct inode *inode)
diff -urN linux-2.5.7-pre1/include/linux/ncp_fs_sb.h linux/include/linux/ncp_fs_sb.h
--- linux-2.5.7-pre1/include/linux/ncp_fs_sb.h	Tue Mar 12 13:53:06 2002
+++ linux/include/linux/ncp_fs_sb.h	Tue Mar 12 17:43:57 2002
@@ -81,8 +81,6 @@
 	unsigned int flags;
 };
 
-#define ncp_sb_info	ncp_server
-
 #define NCP_FLAG_UTF8	1
 
 #define NCP_CLR_FLAG(server, flag)	((server)->flags &= ~(flag))

--------------050902080709060800070608--

