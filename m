Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSA3AIN>; Tue, 29 Jan 2002 19:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287254AbSA3AHO>; Tue, 29 Jan 2002 19:07:14 -0500
Received: from zero.tech9.net ([209.61.188.187]:3593 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287109AbSA2Xys>;
	Tue, 29 Jan 2002 18:54:48 -0500
Subject: [PATCH] 2.5: push BKL out of llseek
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 19:00:37 -0500
Message-Id: <1012348838.817.50.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch pushes the BKL out of llseek() and into the individual llseek
methods.  For generic_file_llseek, I replaced it with the inode
semaphore.  The lock contention is noticeable even on 2-way systems. 
Since we simply push the BKL further down the call chain (its the llseek
method's responsibilities now) we aren't doing anything hackish or
unsafe.

I suspect some (Al) may consider this a suboptimal solution, and I
agree.  However it is a first step -- tightening the locks -- toward a
better locking scheme, which is hopefully devoid of the BKL.

The best scores from a slew of dbench runs:

	(2.5.3-pre6 on 2-way Athlon)
	with patch	133.651	165.575	66.9876	37.5297	24.9436
	without patch	132.541	160.774	60.1174	33.2065	22.0126

Interestingly, the shorter lock times corresponded to an 8.9% reduction
in scheduling latency (under the above dbench load) with the preemptible
kernel.

	Robert Love

diff -urN linux-2.5.3-pre6/Documentation/filesystems/Locking linux/Documentation/filesystems/Locking
--- linux-2.5.3-pre6/Documentation/filesystems/Locking	Mon Jan 28 18:30:27 2002
+++ linux/Documentation/filesystems/Locking	Tue Jan 29 17:07:37 2002
@@ -219,7 +219,7 @@
 locking rules:
 	All except ->poll() may block.
 		BKL
-llseek:		yes
+llseek:		yes	(see below)
 read:		no
 write:		no
 readdir:	yes	(see below)
@@ -235,6 +235,10 @@
 readv:		no
 writev:		no
 
+->llseek() locking has moved from llseek to the individual llseek
+implementations.  If your fs is not using generic_file_llseek, you
+need to acquire and release the BKL in your ->llseek().
+
 ->open() locking is in-transit: big lock partially moved into the methods.
 The only exception is ->open() in the instances of file_operations that never
 end up in ->i_fop/->proc_fops, i.e. ones that belong to character devices
diff -urN linux-2.5.3-pre6/fs/block_dev.c linux/fs/block_dev.c
--- linux-2.5.3-pre6/fs/block_dev.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/block_dev.c	Tue Jan 29 16:49:52 2002
@@ -170,6 +170,8 @@
 	loff_t size = file->f_dentry->d_inode->i_bdev->bd_inode->i_size;
 	loff_t retval;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += size;
@@ -186,6 +188,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 	
diff -urN linux-2.5.3-pre6/fs/hfs/file_cap.c linux/fs/hfs/file_cap.c
--- linux-2.5.3-pre6/fs/hfs/file_cap.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/hfs/file_cap.c	Tue Jan 29 16:49:52 2002
@@ -91,6 +91,8 @@
 {
 	long long retval;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += file->f_dentry->d_inode->i_size;
@@ -106,6 +108,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 
diff -urN linux-2.5.3-pre6/fs/hfs/file_hdr.c linux/fs/hfs/file_hdr.c
--- linux-2.5.3-pre6/fs/hfs/file_hdr.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/hfs/file_hdr.c	Tue Jan 29 16:49:52 2002
@@ -347,6 +347,8 @@
 {
 	long long retval;
 
+	lock_kernel();
+
 	switch (origin) {
 		case 2:
 			offset += file->f_dentry->d_inode->i_size;
@@ -362,6 +364,7 @@
 		}
 		retval = offset;
 	}
+	unlock_kernel();
 	return retval;
 }
 
diff -urN linux-2.5.3-pre6/fs/hpfs/dir.c linux/fs/hpfs/dir.c
--- linux-2.5.3-pre6/fs/hpfs/dir.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/hpfs/dir.c	Tue Jan 29 16:49:52 2002
@@ -29,6 +29,9 @@
 	struct inode *i = filp->f_dentry->d_inode;
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 	struct super_block *s = i->i_sb;
+
+	lock_kernel();
+
 	/*printk("dir lseek\n");*/
 	if (new_off == 0 || new_off == 1 || new_off == 11 || new_off == 12 || new_off == 13) goto ok;
 	hpfs_lock_inode(i);
@@ -40,10 +43,12 @@
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
 
diff -urN linux-2.5.3-pre6/fs/proc/generic.c linux/fs/proc/generic.c
--- linux-2.5.3-pre6/fs/proc/generic.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/proc/generic.c	Tue Jan 29 16:49:52 2002
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
+	    goto out;
 	file->f_pos = offset;
+	unlock_kernel();
 	return(file->f_pos);
     case 1:
 	if (offset + file->f_pos < 0)
-	    return -EINVAL;    
+	    goto out;
 	file->f_pos += offset;
+	unlock_kernel();
 	return(file->f_pos);
     case 2:
-	return(-EINVAL);
+	goto out;
     default:
-	return(-EINVAL);
+	goto out;
     }
+
+out:
+    unlock_kernel();
+    return -EINVAL;
 }
 
 /*
diff -urN linux-2.5.3-pre6/fs/read_write.c linux/fs/read_write.c
--- linux-2.5.3-pre6/fs/read_write.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/read_write.c	Tue Jan 29 16:49:52 2002
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
 
diff -urN linux-2.5.3-pre6/fs/ufs/file.c linux/fs/ufs/file.c
--- linux-2.5.3-pre6/fs/ufs/file.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/ufs/file.c	Tue Jan 29 16:49:52 2002
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

