Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTBXTiS>; Mon, 24 Feb 2003 14:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTBXTiS>; Mon, 24 Feb 2003 14:38:18 -0500
Received: from comtv.ru ([217.10.32.4]:64196 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S265863AbTBXTiQ>;
	Mon, 24 Feb 2003 14:38:16 -0500
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] one more memory leak in ext3+htree
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 24 Feb 2003 22:43:31 +0300
Message-ID: <m3of518nx8.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I've just found one more memory leak in ext2+htree code.
this time it's free_rb_tree_fname(). here is aggregated
from previous messages patch against 2.5.62. it fixes
two memory leaks.



diff -uNr linux/fs/ext3/dir.c edited/fs/ext3/dir.c
--- linux/fs/ext3/dir.c	Mon Nov 11 06:28:16 2002
+++ edited/fs/ext3/dir.c	Mon Feb 24 22:19:55 2003
@@ -33,12 +33,17 @@
 static int ext3_readdir(struct file *, void *, filldir_t);
 static int ext3_dx_readdir(struct file * filp,
 			   void * dirent, filldir_t filldir);
+static int ext3_release_dir (struct inode * inode,
+				struct file * filp);
 
 struct file_operations ext3_dir_operations = {
 	.read		= generic_read_dir,
 	.readdir	= ext3_readdir,		/* we take BKL. needed?*/
 	.ioctl		= ext3_ioctl,		/* BKL held */
 	.fsync		= ext3_sync_file,		/* BKL held */
+#ifdef CONFIG_EXT3_INDEX
+	.release	= ext3_release_dir,
+#endif
 };
 
 
@@ -275,7 +281,11 @@
 		 */
 		parent = n->rb_parent;
 		fname = rb_entry(n, struct fname, rb_hash);
-		kfree(fname);
+		while (fname) {
+			struct fname * old = fname;
+			fname = fname->next;
+			kfree (old);
+		}
 		if (!parent)
 			root->rb_node = 0;
 		else if (parent->rb_left == n)
@@ -481,4 +491,13 @@
 	UPDATE_ATIME(inode);
 	return 0;
 }
+
+static int ext3_release_dir (struct inode * inode, struct file * filp)
+{
+       if (is_dx(inode) && filp->private_data)
+		ext3_htree_free_dir_info(filp->private_data);
+
+	return 0;
+}
+
 #endif


