Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270608AbRHIXc3>; Thu, 9 Aug 2001 19:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270606AbRHIXcA>; Thu, 9 Aug 2001 19:32:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17065 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269875AbRHIXbx>;
	Thu, 9 Aug 2001 19:31:53 -0400
Date: Thu, 9 Aug 2001 19:32:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c fixes (4/8)
In-Reply-To: <Pine.GSO.4.21.0108091931170.25945-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108091931470.25945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 4/8:

Preparation to refcounting - calls of get_super() are followed by
drop_super(). Right now it's empty, that will be changed on the next
step. For now we simply put the calls in right places.

diff -urN S8-pre7-fsync_no_super/arch/parisc/hpux/sys_hpux.c S8-pre7-drop_super/arch/parisc/hpux/sys_hpux.c
--- S8-pre7-fsync_no_super/arch/parisc/hpux/sys_hpux.c	Fri Feb 16 20:46:44 2001
+++ S8-pre7-drop_super/arch/parisc/hpux/sys_hpux.c	Thu Aug  9 19:07:31 2001
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
 
diff -urN S8-pre7-fsync_no_super/fs/dquot.c S8-pre7-drop_super/fs/dquot.c
--- S8-pre7-fsync_no_super/fs/dquot.c	Sun Jul 29 01:54:47 2001
+++ S8-pre7-drop_super/fs/dquot.c	Thu Aug  9 19:07:31 2001
@@ -1597,6 +1597,8 @@
 	if (sb && sb_has_quota_enabled(sb, type))
 		ret = set_dqblk(sb, id, type, flags, (struct dqblk *) addr);
 out:
+	if (sb)
+		drop_super(sb);
 	unlock_kernel();
 	return ret;
 }
diff -urN S8-pre7-fsync_no_super/fs/inode.c S8-pre7-drop_super/fs/inode.c
--- S8-pre7-fsync_no_super/fs/inode.c	Wed Aug  8 17:54:55 2001
+++ S8-pre7-drop_super/fs/inode.c	Thu Aug  9 19:07:32 2001
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
diff -urN S8-pre7-fsync_no_super/fs/super.c S8-pre7-drop_super/fs/super.c
--- S8-pre7-fsync_no_super/fs/super.c	Thu Aug  9 19:07:31 2001
+++ S8-pre7-drop_super/fs/super.c	Thu Aug  9 19:07:32 2001
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
 
diff -urN S8-pre7-fsync_no_super/include/linux/fs.h S8-pre7-drop_super/include/linux/fs.h
--- S8-pre7-fsync_no_super/include/linux/fs.h	Thu Aug  9 19:07:31 2001
+++ S8-pre7-drop_super/include/linux/fs.h	Thu Aug  9 19:07:32 2001
@@ -1359,11 +1359,12 @@
 
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
diff -urN S8-pre7-fsync_no_super/kernel/ksyms.c S8-pre7-drop_super/kernel/ksyms.c
--- S8-pre7-fsync_no_super/kernel/ksyms.c	Wed Aug  8 17:54:57 2001
+++ S8-pre7-drop_super/kernel/ksyms.c	Thu Aug  9 19:07:32 2001
@@ -128,6 +128,7 @@
 EXPORT_SYMBOL(update_atime);
 EXPORT_SYMBOL(get_fs_type);
 EXPORT_SYMBOL(get_super);
+EXPORT_SYMBOL(drop_super);
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(names_cachep);
 EXPORT_SYMBOL(fput);


