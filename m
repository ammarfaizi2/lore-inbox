Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263426AbRFKFh3>; Mon, 11 Jun 2001 01:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbRFKFhU>; Mon, 11 Jun 2001 01:37:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58034 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263426AbRFKFhM>;
	Mon, 11 Jun 2001 01:37:12 -0400
Date: Mon, 11 Jun 2001 01:37:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/super.c stuff (6/10)
In-Reply-To: <Pine.GSO.4.21.0106110135010.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110136250.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-dquot/arch/parisc/hpux/sys_hpux.c S6-pre2-drop_super/arch/parisc/hpux/sys_hpux.c
--- S6-pre2-dquot/arch/parisc/hpux/sys_hpux.c	Fri Feb 16 20:46:44 2001
+++ S6-pre2-drop_super/arch/parisc/hpux/sys_hpux.c	Sun Jun 10 18:38:23 2001
@@ -109,9 +109,11 @@
 
 	lock_kernel();
 	s = get_super(to_kdev_t(dev));
+	unlock_kernel();
 	if (s == NULL)
 		goto out;
 	err = vfs_statfs(s, &sbuf);
+	drop_super(s);
 	if (err)
 		goto out;
 
@@ -124,7 +126,6 @@
 	/* Changed to hpux_ustat:  */
 	err = copy_to_user(ubuf,&tmp,sizeof(struct hpux_ustat)) ? -EFAULT : 0;
 out:
-	unlock_kernel();
 	return err;
 }
 
diff -urN S6-pre2-dquot/fs/dquot.c S6-pre2-drop_super/fs/dquot.c
--- S6-pre2-dquot/fs/dquot.c	Sun Jun 10 18:46:54 2001
+++ S6-pre2-drop_super/fs/dquot.c	Sun Jun 10 18:38:23 2001
@@ -1602,6 +1602,8 @@
 	if (sb && sb_has_quota_enabled(sb, type))
 		ret = set_dqblk(sb, id, type, flags, (struct dqblk *) addr);
 out:
+	if (sb)
+		drop_super(sb);
 	unlock_kernel();
 	return ret;
 }
diff -urN S6-pre2-dquot/fs/inode.c S6-pre2-drop_super/fs/inode.c
--- S6-pre2-dquot/fs/inode.c	Sun Jun 10 18:43:02 2001
+++ S6-pre2-drop_super/fs/inode.c	Sun Jun 10 18:38:23 2001
@@ -605,8 +605,10 @@
 		fsync_dev(dev);
 
 	res = 0;
-	if (sb)
+	if (sb) {
 		res = invalidate_inodes(sb);
+		drop_super(sb);
+	}
 	invalidate_buffers(dev);
 	return res;
 }
diff -urN S6-pre2-dquot/fs/super.c S6-pre2-drop_super/fs/super.c
--- S6-pre2-dquot/fs/super.c	Sun Jun 10 18:36:27 2001
+++ S6-pre2-drop_super/fs/super.c	Sun Jun 10 18:38:23 2001
@@ -491,7 +491,6 @@
 	kill_super(sb);
 }
 
-
 /* Use octal escapes, like mount does, for embedded spaces etc. */
 static unsigned char need_escaping[] = { ' ', '\t', '\n', '\\' };
 
@@ -640,6 +639,10 @@
 #undef MANGLE
 #undef FREEROOM
 }
+
+void drop_super(struct super_block *sb)
+{
+}
  
 /*
  * Note: check the dirty flag before waiting, so we don't
@@ -709,6 +712,7 @@
         if (s == NULL)
                 goto out;
 	err = vfs_statfs(s, &sbuf);
+	drop_super(s);
 	if (err)
 		goto out;
 
diff -urN S6-pre2-dquot/include/linux/fs.h S6-pre2-drop_super/include/linux/fs.h
--- S6-pre2-dquot/include/linux/fs.h	Sun Jun 10 18:39:04 2001
+++ S6-pre2-drop_super/include/linux/fs.h	Sun Jun 10 18:38:31 2001
@@ -1320,11 +1320,12 @@
 
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(kdev_t);
+extern void drop_super(struct super_block *sb);
 static inline int is_mounted(kdev_t dev)
 {
 	struct super_block *sb = get_super(dev);
 	if (sb) {
-		/* drop_super(sb); will go here */
+		drop_super(sb);
 		return 1;
 	}
 	return 0;
diff -urN S6-pre2-dquot/kernel/ksyms.c S6-pre2-drop_super/kernel/ksyms.c
--- S6-pre2-dquot/kernel/ksyms.c	Fri Jun  8 18:29:03 2001
+++ S6-pre2-drop_super/kernel/ksyms.c	Sun Jun 10 18:38:23 2001
@@ -129,6 +129,7 @@
 EXPORT_SYMBOL(update_atime);
 EXPORT_SYMBOL(get_fs_type);
 EXPORT_SYMBOL(get_super);
+EXPORT_SYMBOL(drop_super);
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(names_cachep);
 EXPORT_SYMBOL(fput);



