Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSJEUgY>; Sat, 5 Oct 2002 16:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSJEUgY>; Sat, 5 Oct 2002 16:36:24 -0400
Received: from zero.aec.at ([193.170.194.10]:29962 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262580AbSJEUgW>;
	Sat, 5 Oct 2002 16:36:22 -0400
Date: Sat, 5 Oct 2002 22:41:53 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] struct timespec for stat - driver changes 2/3
Message-ID: <20021005204153.GA16009@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Required for the previous core timespec stat patch. This convers all the drivers
to access the new datatype for i_amtime. No functional changes.

Patch for 2.5.40.

Please apply

-Andi

 linux-2.5.40-work/drivers/char/busmouse.c            |    2 +-
 linux-2.5.40-work/drivers/char/hp_psaux.c            |    4 ++--
 linux-2.5.40-work/drivers/char/qtronix.c             |    2 +-
 linux-2.5.40-work/drivers/char/random.c              |    2 +-
 linux-2.5.40-work/drivers/char/sonypi.c              |    2 +-
 linux-2.5.40-work/drivers/char/tty_io.c              |    4 ++--
 linux-2.5.40-work/drivers/hotplug/pci_hotplug_core.c |    2 +-
 linux-2.5.40-work/drivers/isdn/capi/capifs.c         |    2 +-
 linux-2.5.40-work/drivers/usb/core/inode.c           |    6 +++---

diff -burp -X ../KDIFX linux/drivers/char/busmouse.c linux-2.5.40-work/drivers/char/busmouse.c
--- linux/drivers/char/busmouse.c	2002-06-09 07:28:20.000000000 +0200
+++ linux-2.5.40-work/drivers/char/busmouse.c	2002-10-05 18:46:47.000000000 +0200
@@ -316,7 +316,7 @@ repeat:
 	if (count > 3 && clear_user(buffer + 3, count - 3))
 		return -EFAULT;
 
-	file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+	file->f_dentry->d_inode->i_atime = xtime;
 
 	return count;
 }
diff -burp -X ../KDIFX linux/drivers/char/hp_psaux.c linux-2.5.40-work/drivers/char/hp_psaux.c
--- linux/drivers/char/hp_psaux.c	2002-06-09 07:31:25.000000000 +0200
+++ linux-2.5.40-work/drivers/char/hp_psaux.c	2002-10-05 18:46:58.000000000 +0200
@@ -289,7 +289,7 @@ static ssize_t write_aux(struct file * f
 		retval = -EIO;
 		if (written) {
 			retval = written;
-			file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+			file->f_dentry->d_inode->i_mtime = xtime;
 		}
 	}
 
@@ -324,7 +324,7 @@ repeat:
 		i--;
 	}
 	if (count-i) {
-		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+		file->f_dentry->d_inode->i_atime = xtime;
 		return count-i;
 	}
 	if (signal_pending(current))
diff -burp -X ../KDIFX linux/drivers/char/qtronix.c linux-2.5.40-work/drivers/char/qtronix.c
--- linux/drivers/char/qtronix.c	2002-06-09 07:28:58.000000000 +0200
+++ linux-2.5.40-work/drivers/char/qtronix.c	2002-10-05 18:47:02.000000000 +0200
@@ -536,7 +536,7 @@ repeat:
 		i--;
 	}
 	if (count-i) {
-		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+		file->f_dentry->d_inode->i_atime = xtime;
 		return count-i;
 	}
 	if (signal_pending(current))
diff -burp -X ../KDIFX linux/drivers/char/random.c linux-2.5.40-work/drivers/char/random.c
--- linux/drivers/char/random.c	2002-10-05 18:42:38.000000000 +0200
+++ linux-2.5.40-work/drivers/char/random.c	2002-10-05 18:46:14.000000000 +0200
@@ -1597,7 +1597,7 @@ random_write(struct file * file, const c
 	if (p == buffer) {
 		return (ssize_t)ret;
 	} else {
-		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+		file->f_dentry->d_inode->i_mtime = xtime;
 		mark_inode_dirty(file->f_dentry->d_inode);
 		return (ssize_t)(p - buffer);
 	}
diff -burp -X ../KDIFX linux/drivers/char/sonypi.c linux-2.5.40-work/drivers/char/sonypi.c
--- linux/drivers/char/sonypi.c	2002-06-09 07:27:43.000000000 +0200
+++ linux-2.5.40-work/drivers/char/sonypi.c	2002-10-05 18:47:12.000000000 +0200
@@ -518,7 +518,7 @@ repeat:
 		i--;
         }
 	if (count - i) {
-		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+		file->f_dentry->d_inode->i_atime = xtime;
 		return count-i;
 	}
 	if (signal_pending(current))
diff -burp -X ../KDIFX linux/drivers/char/tty_io.c linux-2.5.40-work/drivers/char/tty_io.c
--- linux/drivers/char/tty_io.c	2002-10-05 18:42:38.000000000 +0200
+++ linux-2.5.40-work/drivers/char/tty_io.c	2002-10-05 18:47:26.000000000 +0200
@@ -682,7 +682,7 @@ static ssize_t tty_read(struct file * fi
 		i = -EIO;
 	unlock_kernel();
 	if (i > 0)
-		inode->i_atime = CURRENT_TIME;
+		inode->i_atime = xtime;
 	return i;
 }
 
@@ -728,7 +728,7 @@ static inline ssize_t do_tty_write(
 		}
 	}
 	if (written) {
-		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+		file->f_dentry->d_inode->i_mtime = xtime;
 		ret = written;
 	}
 	up(&tty->atomic_write);
diff -burp -X ../KDIFX linux/drivers/hotplug/pci_hotplug_core.c linux-2.5.40-work/drivers/hotplug/pci_hotplug_core.c
--- linux/drivers/hotplug/pci_hotplug_core.c	2002-09-21 09:02:54.000000000 +0200
+++ linux-2.5.40-work/drivers/hotplug/pci_hotplug_core.c	2002-10-05 18:46:14.000000000 +0200
@@ -131,7 +131,7 @@ static struct inode *pcihpfs_get_inode (
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
diff -burp -X ../KDIFX linux/drivers/isdn/capi/capifs.c linux-2.5.40-work/drivers/isdn/capi/capifs.c
--- linux/drivers/isdn/capi/capifs.c	2002-08-28 12:58:38.000000000 +0200
+++ linux-2.5.40-work/drivers/isdn/capi/capifs.c	2002-10-05 18:46:14.000000000 +0200
@@ -356,7 +356,7 @@ static struct inode *capifs_new_inode(st
 {
 	struct inode *inode = new_inode(sb);
 	if (inode) {
-		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+		inode->i_mtime = inode->i_atime = inode->i_ctime = xtime;
 		inode->i_blocks = 0;
 		inode->i_blksize = 1024;
 		inode->i_uid = inode->i_gid = 0;
Only in linux/drivers/pci: gen-devlist
Only in linux/drivers/scsi/aic7xxx: aic7xxx_reg.h
diff -burp -X ../KDIFX linux/drivers/usb/core/inode.c linux-2.5.40-work/drivers/usb/core/inode.c
--- linux/drivers/usb/core/inode.c	2002-09-16 04:42:50.000000000 +0200
+++ linux-2.5.40-work/drivers/usb/core/inode.c	2002-10-05 18:46:14.000000000 +0200
@@ -152,7 +152,7 @@ static struct inode *usbfs_get_inode (st
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -632,12 +632,12 @@ void usbfs_update_special (void)
 	if (devices_usbdevfs_dentry) {
 		inode = devices_usbdevfs_dentry->d_inode;
 		if (inode)
-			inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+			inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 	}
 	if (devices_usbfs_dentry) {
 		inode = devices_usbfs_dentry->d_inode;
 		if (inode)
-			inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+			inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 	}
 }
 

