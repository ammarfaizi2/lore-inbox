Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290983AbSAaGmP>; Thu, 31 Jan 2002 01:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290981AbSAaGmC>; Thu, 31 Jan 2002 01:42:02 -0500
Received: from zero.tech9.net ([209.61.188.187]:64006 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290983AbSAaGlc>;
	Thu, 31 Jan 2002 01:41:32 -0500
Subject: [PATCH] 2.5: further llseek cleanup (2/3)
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 31 Jan 2002 01:47:34 -0500
Message-Id: <1012459655.3219.154.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is the second patch of three implementing further llseek cleanups,
against 2.5.3.  It does not depend on the other patches.

This patch cleans up various code and quite nicely removes much more
code than it adds.  Specifically:

- remove static lseek method which merely reimplements
  the standard no_llseek in the following seven files:
  hci_vhci.c, ite8172.c, nec_vrc5477.c, auerswald.c,
  pipe.c, netlink_dev.c, and socket.c

- remove fs/ufs/file.c::ufs_file_lseek -- Al says it is
  reimplementing generic_file_llseek, so let's use that
  instead (the comment about 32-bit sizes shouldn't be
  an issue, the generic method checks size)

- include smp_lock.h in 3 files missed from previous
  'remove bkl' patch

- Documentation/filesystem/Locking update

Please, apply.

	Robert Love

diff -urN linux-2.5.3/Documentation/filesystems/Locking linux/Documentation/filesystems/Locking
--- linux-2.5.3/Documentation/filesystems/Locking	Wed Jan 30 16:12:06 2002
+++ linux/Documentation/filesystems/Locking	Wed Jan 30 22:46:40 2002
@@ -237,7 +237,10 @@
 
 ->llseek() locking has moved from llseek to the individual llseek
 implementations.  If your fs is not using generic_file_llseek, you
-need to acquire and release the BKL in your ->llseek().
+need to acquire and release the appropriate locks in your ->llseek().
+For many filesystems, it is probably safe to acquire the inode
+semaphore.  Note some filesystems (i.e. remote ones) provide no
+protection for i_size so you will need to use the BKL.
 
 ->open() locking is in-transit: big lock partially moved into the methods.
 The only exception is ->open() in the instances of file_operations that never
diff -urN linux-2.5.3/drivers/bluetooth/hci_vhci.c linux/drivers/bluetooth/hci_vhci.c
--- linux-2.5.3/drivers/bluetooth/hci_vhci.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/bluetooth/hci_vhci.c	Wed Jan 30 22:35:11 2002
@@ -221,11 +221,6 @@
 	return ret;
 }
 
-static loff_t hci_vhci_chr_lseek(struct file * file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
 static int hci_vhci_chr_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	return -EINVAL;
@@ -296,7 +291,7 @@
 
 static struct file_operations hci_vhci_fops = {
 	owner:	THIS_MODULE,	
-	llseek:	hci_vhci_chr_lseek,
+	llseek:	no_lseek,
 	read:	hci_vhci_chr_read,
 	write:	hci_vhci_chr_write,
 	poll:	hci_vhci_chr_poll,
diff -urN linux-2.5.3/drivers/sound/ite8172.c linux/drivers/sound/ite8172.c
--- linux-2.5.3/drivers/sound/ite8172.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/sound/ite8172.c	Wed Jan 30 22:34:34 2002
@@ -824,12 +824,6 @@
 
 /* --------------------------------------------------------------------- */
 
-static loff_t it8172_llseek(struct file *file, loff_t offset, int origin)
-{
-    return -ESPIPE;
-}
-
-
 static int it8172_open_mixdev(struct inode *inode, struct file *file)
 {
     int minor = MINOR(inode->i_rdev);
@@ -870,7 +864,7 @@
 
 static /*const*/ struct file_operations it8172_mixer_fops = {
     owner:	THIS_MODULE,
-    llseek:	it8172_llseek,
+    llseek:	no_llseek,
     ioctl:	it8172_ioctl_mixdev,
     open:	it8172_open_mixdev,
     release:	it8172_release_mixdev,
@@ -1633,7 +1627,7 @@
 
 static /*const*/ struct file_operations it8172_audio_fops = {
     owner:	THIS_MODULE,
-    llseek:	it8172_llseek,
+    llseek:	no_llseek,
     read:	it8172_read,
     write:	it8172_write,
     poll:	it8172_poll,
diff -urN linux-2.5.3/drivers/sound/nec_vrc5477.c linux/drivers/sound/nec_vrc5477.c
--- linux-2.5.3/drivers/sound/nec_vrc5477.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/sound/nec_vrc5477.c	Wed Jan 30 22:36:57 2002
@@ -805,12 +805,6 @@
 
 /* --------------------------------------------------------------------- */
 
-static loff_t vrc5477_ac97_llseek(struct file *file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
-
 static int vrc5477_ac97_open_mixdev(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
@@ -852,7 +846,7 @@
 
 static /*const*/ struct file_operations vrc5477_ac97_mixer_fops = {
 	owner:		THIS_MODULE,
-	llseek:		vrc5477_ac97_llseek,
+	llseek:		no_llseek,
 	ioctl:		vrc5477_ac97_ioctl_mixdev,
 	open:		vrc5477_ac97_open_mixdev,
 	release:	vrc5477_ac97_release_mixdev,
@@ -1618,7 +1612,7 @@
 
 static /*const*/ struct file_operations vrc5477_ac97_audio_fops = {
 	owner:	THIS_MODULE,
-	llseek:		vrc5477_ac97_llseek,
+	llseek:		no_llseek,
 	read:		vrc5477_ac97_read,
 	write:		vrc5477_ac97_write,
 	poll:		vrc5477_ac97_poll,
diff -urN linux-2.5.3/drivers/usb/auerswald.c linux/drivers/usb/auerswald.c
--- linux-2.5.3/drivers/usb/auerswald.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/usb/auerswald.c	Wed Jan 30 22:34:51 2002
@@ -1553,15 +1553,6 @@
 	return ret;
 }
 
-
-/* Seek is not supported */
-static loff_t auerchar_llseek (struct file *file, loff_t offset, int origin)
-{
-        dbg ("auerchar_seek");
-        return -ESPIPE;
-}
-
-
 /* Read data from the device */
 static ssize_t auerchar_read (struct file *file, char *buf, size_t count, loff_t * ppos)
 {
@@ -1843,7 +1834,7 @@
 static struct file_operations auerswald_fops =
 {
 	owner:		THIS_MODULE,
-	llseek:		auerchar_llseek,
+	llseek:		no_llseek,
 	read:		auerchar_read,
 	write:          auerchar_write,
 	ioctl:		auerchar_ioctl,
diff -urN linux-2.5.3/fs/pipe.c linux/fs/pipe.c
--- linux-2.5.3/fs/pipe.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/pipe.c	Wed Jan 30 22:43:34 2002
@@ -246,12 +246,6 @@
 	return -EPIPE;
 }
 
-static loff_t
-pipe_lseek(struct file *file, loff_t offset, int orig)
-{
-	return -ESPIPE;
-}
-
 static ssize_t
 bad_pipe_r(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
@@ -381,7 +375,7 @@
  * are also used in linux/fs/fifo.c to do operations on FIFOs.
  */
 struct file_operations read_fifo_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		bad_pipe_w,
 	poll:		fifo_poll,
@@ -391,7 +385,7 @@
 };
 
 struct file_operations write_fifo_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		bad_pipe_r,
 	write:		pipe_write,
 	poll:		fifo_poll,
@@ -401,7 +395,7 @@
 };
 
 struct file_operations rdwr_fifo_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		pipe_write,
 	poll:		fifo_poll,
@@ -411,7 +405,7 @@
 };
 
 struct file_operations read_pipe_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		bad_pipe_w,
 	poll:		pipe_poll,
@@ -421,7 +415,7 @@
 };
 
 struct file_operations write_pipe_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		bad_pipe_r,
 	write:		pipe_write,
 	poll:		pipe_poll,
@@ -431,7 +425,7 @@
 };
 
 struct file_operations rdwr_pipe_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		pipe_write,
 	poll:		pipe_poll,
diff -urN linux-2.5.3/fs/ufs/file.c linux/fs/ufs/file.c
--- linux-2.5.3/fs/ufs/file.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/ufs/file.c	Wed Jan 30 22:42:45 2002
@@ -37,46 +37,12 @@
 #include <linux/pagemap.h>
 
 /*
- * Make sure the offset never goes beyond the 32-bit mark..
- */
-static long long ufs_file_lseek(
-	struct file *file,
-	long long offset,
-	int origin )
-{
-	long long retval;
-	struct inode *inode = file->f_dentry->d_inode;
-
-	lock_kernel();
-
-	switch (origin) {
-		case 2:
-			offset += inode->i_size;
-			break;
-		case 1:
-			offset += file->f_pos;
-	}
-	retval = -EINVAL;
-	/* make sure the offset fits in 32 bits */
-	if (((unsigned long long) offset >> 32) == 0) {
-		if (offset != file->f_pos) {
-			file->f_pos = offset;
-			file->f_reada = 0;
-			file->f_version = ++event;
-		}
-		retval = offset;
-	}
-	unlock_kernel();
-	return retval;
-}
-
-/*
  * We have mostly NULL's here: the current defaults are ok for
  * the ufs filesystem.
  */
  
 struct file_operations ufs_file_operations = {
-	llseek:		ufs_file_lseek,
+	llseek:		generic_file_llseek,
 	read:		generic_file_read,
 	write:		generic_file_write,
 	mmap:		generic_file_mmap,
diff -urN linux-2.5.3/net/netlink/netlink_dev.c linux/net/netlink/netlink_dev.c
--- linux-2.5.3/net/netlink/netlink_dev.c	Wed Jan 30 16:12:04 2002
+++ linux/net/netlink/netlink_dev.c	Wed Jan 30 22:34:01 2002
@@ -98,11 +98,6 @@
 	return sock_recvmsg(sock, &msg, count, msg.msg_flags);
 }
 
-static loff_t netlink_lseek(struct file * file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
 static int netlink_open(struct inode * inode, struct file * file)
 {
 	unsigned int minor = minor(inode->i_rdev);
@@ -166,7 +161,7 @@
 
 static struct file_operations netlink_fops = {
 	owner:		THIS_MODULE,
-	llseek:		netlink_lseek,
+	llseek:		no_llseek,
 	read:		netlink_read,
 	write:		netlink_write,
 	poll:		netlink_poll,
diff -urN linux-2.5.3/net/socket.c linux/net/socket.c
--- linux-2.5.3/net/socket.c	Wed Jan 30 16:12:04 2002
+++ linux/net/socket.c	Wed Jan 30 22:33:22 2002
@@ -86,7 +86,6 @@
 #include <linux/netfilter.h>
 
 static int sock_no_open(struct inode *irrelevant, struct file *dontcare);
-static loff_t sock_lseek(struct file *file, loff_t offset, int whence);
 static ssize_t sock_read(struct file *file, char *buf,
 			 size_t size, loff_t *ppos);
 static ssize_t sock_write(struct file *file, const char *buf,
@@ -113,7 +112,7 @@
  */
 
 static struct file_operations socket_file_ops = {
-	llseek:		sock_lseek,
+	llseek:		no_llseek,
 	read:		sock_read,
 	write:		sock_write,
 	poll:		sock_poll,
@@ -527,15 +526,6 @@
 
 
 /*
- *	Sockets are not seekable.
- */
-
-static loff_t sock_lseek(struct file *file, loff_t offset, int whence)
-{
-	return -ESPIPE;
-}
-
-/*
  *	Read data from a socket. ubuf is a user mode pointer. We make sure the user
  *	area ubuf...ubuf+size-1 is writable before asking the protocol.
  */
diff -urN linux-2.5.3/fs/hfs/file_cap.c linux/fs/hfs/file_cap.c
--- linux-2.5.3/fs/hfs/file_cap.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/hfs/file_cap.c	Thu Jan 31 00:19:42 2002
@@ -24,6 +24,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/smp_lock.h>
 
 /*================ Forward declarations ================*/
 static loff_t      cap_info_llseek(struct file *, loff_t,
diff -urN linux-2.5.3/fs/hfs/file_hdr.c linux/fs/hfs/file_hdr.c
--- linux-2.5.3/fs/hfs/file_hdr.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/hfs/file_hdr.c	Thu Jan 31 00:19:42 2002
@@ -29,6 +29,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/smp_lock.h>
 
 /* prodos types */
 #define PRODOSI_FTYPE_DIR   0x0F
diff -urN linux-2.5.3/fs/ncpfs/file.c linux/fs/ncpfs/file.c
--- linux-2.5.3/fs/ncpfs/file.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/ncpfs/file.c	Thu Jan 31 00:19:42 2002
@@ -18,6 +18,7 @@
 #include <linux/locks.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/smp_lock.h>
 
 #include <linux/ncp_fs.h>
 #include "ncplib_kernel.h"
diff -urN linux-2.5.3/fs/ufs/file.c linux/fs/ufs/file.c
--- linux-2.5.3/fs/ufs/file.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/ufs/file.c	Thu Jan 31 00:19:42 2002
@@ -35,6 +35,7 @@
 #include <linux/locks.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/smp_lock.h>
 
 /*
  * Make sure the offset never goes beyond the 32-bit mark..

