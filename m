Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTBXPAW>; Mon, 24 Feb 2003 10:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBXPAW>; Mon, 24 Feb 2003 10:00:22 -0500
Received: from comtv.ru ([217.10.32.4]:30142 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267174AbTBXPAV>;
	Mon, 24 Feb 2003 10:00:21 -0500
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] memory leak in ext3+htree
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 24 Feb 2003 18:05:38 +0300
Message-ID: <m3smud90sd.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

here is very simple fix against memory leak in ext3's readdir().



diff -uNr linux/fs/ext3/dir.c edited/fs/ext3/dir.c
--- linux/fs/ext3/dir.c	Mon Nov 11 06:28:16 2002
+++ edited/fs/ext3/dir.c	Mon Feb 24 17:39:59 2003
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


