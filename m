Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283008AbRK1DQF>; Tue, 27 Nov 2001 22:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281869AbRK1DP6>; Tue, 27 Nov 2001 22:15:58 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:14853 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281866AbRK1DPj>;
	Tue, 27 Nov 2001 22:15:39 -0500
Date: Wed, 28 Nov 2001 14:11:16 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove BKL from llseek
Message-ID: <20011128141116.C22190@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The dbench-o-matic results from removing the BKL from llseek can be
found here:

http://samba.org/~anton/linux/llseek/

Same hardware as the earlier test, 12 way ppc64. The patch is pretty dumb,
I just pushed the kernel lock down into the llseek methods and only replaced
it with the inode semaphore in generic_llseek. Im sure Al will have a
better fix for 2.5, I just wanted to highlight the problem :)

Anton


diff -urN linuxppc_2_4_devel/fs/block_dev.c linuxppc_2_4_devel_work_nollseek/fs/block_dev.c
--- linuxppc_2_4_devel/fs/block_dev.c	Thu Nov 22 22:59:18 2001
+++ linuxppc_2_4_devel_work_nollseek/fs/block_dev.c	Fri Nov 23 09:53:19 2001
@@ -149,6 +149,8 @@
 	loff_t size = file->f_dentry->d_inode->i_bdev->bd_inode->i_size;
 	loff_t retval;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += size;
@@ -165,6 +167,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 	
diff -urN linuxppc_2_4_devel/fs/hfs/file_cap.c linuxppc_2_4_devel_work_nollseek/fs/hfs/file_cap.c
--- linuxppc_2_4_devel/fs/hfs/file_cap.c	Wed Sep 26 15:19:44 2001
+++ linuxppc_2_4_devel_work_nollseek/fs/hfs/file_cap.c	Tue Oct 16 19:18:19 2001
@@ -91,6 +91,8 @@
 {
 	long long retval;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += file->f_dentry->d_inode->i_size;
@@ -107,6 +109,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 
diff -urN linuxppc_2_4_devel/fs/hfs/file_hdr.c linuxppc_2_4_devel_work_nollseek/fs/hfs/file_hdr.c
--- linuxppc_2_4_devel/fs/hfs/file_hdr.c	Wed Sep 26 15:19:44 2001
+++ linuxppc_2_4_devel_work_nollseek/fs/hfs/file_hdr.c	Tue Oct 16 19:18:19 2001
@@ -347,6 +347,8 @@
 {
 	long long retval;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += file->f_dentry->d_inode->i_size;
@@ -363,6 +365,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 
diff -urN linuxppc_2_4_devel/fs/hpfs/dir.c linuxppc_2_4_devel_work_nollseek/fs/hpfs/dir.c
--- linuxppc_2_4_devel/fs/hpfs/dir.c	Wed Sep 26 15:19:44 2001
+++ linuxppc_2_4_devel_work_nollseek/fs/hpfs/dir.c	Tue Oct 16 19:18:19 2001
@@ -28,6 +28,9 @@
 	struct quad_buffer_head qbh;
 	struct inode *i = filp->f_dentry->d_inode;
 	struct super_block *s = i->i_sb;
+
+	lock_kernel();
+
 	/*printk("dir lseek\n");*/
 	if (new_off == 0 || new_off == 1 || new_off == 11 || new_off == 12 || new_off == 13) goto ok;
 	hpfs_lock_inode(i);
@@ -39,10 +42,12 @@
 	}
 	hpfs_unlock_inode(i);
 	ok:
+	unlock_kernel();
 	return filp->f_pos = new_off;
 	fail:
 	hpfs_unlock_inode(i);
 	/*printk("illegal lseek: %016llx\n", new_off);*/
+	unlock_kernel();
 	return -ESPIPE;
 }
 
diff -urN linuxppc_2_4_devel/fs/proc/generic.c linuxppc_2_4_devel_work_nollseek/fs/proc/generic.c
--- linuxppc_2_4_devel/fs/proc/generic.c	Wed Sep 26 15:19:46 2001
+++ linuxppc_2_4_devel_work_nollseek/fs/proc/generic.c	Tue Oct 16 19:18:19 2001
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/smp_lock.h>
 #include <asm/bitops.h>
 
 static ssize_t proc_file_read(struct file * file, char * buf,
@@ -140,22 +141,30 @@
 static loff_t
 proc_file_lseek(struct file * file, loff_t offset, int orig)
 {
+    lock_kernel();
+
     switch (orig) {
     case 0:
 	if (offset < 0)
-	    return -EINVAL;    
+	    goto out_err;
 	file->f_pos = offset;
+	unlock_kernel();
 	return(file->f_pos);
     case 1:
 	if (offset + file->f_pos < 0)
-	    return -EINVAL;    
+	    goto out_err;
 	file->f_pos += offset;
+	unlock_kernel();
 	return(file->f_pos);
     case 2:
-	return(-EINVAL);
+	goto out_err;
     default:
-	return(-EINVAL);
+	goto out_err;
     }
+
+out_err:
+    unlock_kernel();
+    return -EINVAL;
 }
 
 /*
diff -urN linuxppc_2_4_devel/fs/read_write.c linuxppc_2_4_devel_work_nollseek/fs/read_write.c
--- linuxppc_2_4_devel/fs/read_write.c	Wed Sep 26 15:19:42 2001
+++ linuxppc_2_4_devel_work_nollseek/fs/read_write.c	Tue Oct 16 19:22:10 2001
@@ -29,6 +29,8 @@
 {
 	long long retval;
 
+	down(&file->f_dentry->d_inode->i_sem);
+
 	switch (origin) {
 		case 2:
 			offset += file->f_dentry->d_inode->i_size;
@@ -45,6 +47,7 @@
 		}
 		retval = offset;
 	}
+	up(&file->f_dentry->d_inode->i_sem);
 	return retval;
 }
 
@@ -57,6 +60,8 @@
 {
 	long long retval;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += file->f_dentry->d_inode->i_size;
@@ -73,6 +78,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 
@@ -84,9 +90,7 @@
 	fn = default_llseek;
 	if (file->f_op && file->f_op->llseek)
 		fn = file->f_op->llseek;
-	lock_kernel();
 	retval = fn(file, offset, origin);
-	unlock_kernel();
 	return retval;
 }
 
diff -urN linuxppc_2_4_devel/fs/ufs/file.c linuxppc_2_4_devel_work_nollseek/fs/ufs/file.c
--- linuxppc_2_4_devel/fs/ufs/file.c	Wed Sep 26 15:19:47 2001
+++ linuxppc_2_4_devel_work_nollseek/fs/ufs/file.c	Tue Oct 16 19:18:20 2001
@@ -47,6 +47,8 @@
 	long long retval;
 	struct inode *inode = file->f_dentry->d_inode;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += inode->i_size;
@@ -64,6 +66,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 
