Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293496AbSBZD2v>; Mon, 25 Feb 2002 22:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293497AbSBZD2p>; Mon, 25 Feb 2002 22:28:45 -0500
Received: from zero.tech9.net ([209.61.188.187]:51719 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293496AbSBZD2c>;
	Mon, 25 Feb 2002 22:28:32 -0500
Subject: [PATCH] 2.4 lseek usage cleanup
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Feb 2002 22:28:29 -0500
Message-Id: <1014694109.879.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a version of the _cleanup_ portion of my lseek work in 2.5. 
Specifically, this patch:

- Removes 6 pointless functions that reinvent fs/read_write.c ::
  no_llseek

- Convert 14 uses of the above functions to the proper no_llseek

- Removes fs/ufs/file.c :: ufs_file_lseek which, although the
  comments feel is needed, is pointless.  generic_file_write is
  a safe replacement, so use it.

These changes have all been blessed by Al for 2.5.  They are cleanups
and clear 2.4 material.  Patch is against 2.4.19-pre1.  Marcelo, please
apply.

	Robert Love

diff -urN linux-2.4.19-pre1/drivers/bluetooth/hci_vhci.c linux/drivers/bluetooth/hci_vhci.c
--- linux-2.4.19-pre1/drivers/bluetooth/hci_vhci.c	Thu Feb  7 15:26:53 2002
+++ linux/drivers/bluetooth/hci_vhci.c	Mon Feb 11 20:59:31 2002
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
+	llseek:	no_llseek,
 	read:	hci_vhci_chr_read,
 	write:	hci_vhci_chr_write,
 	poll:	hci_vhci_chr_poll,
diff -urN linux-2.4.19-pre1/drivers/sound/ite8172.c linux/drivers/sound/ite8172.c
--- linux-2.4.19-pre1/drivers/sound/ite8172.c	Thu Feb  7 15:26:42 2002
+++ linux/drivers/sound/ite8172.c	Mon Feb 11 20:59:31 2002
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
diff -urN linux-2.4.19-pre1/drivers/sound/nec_vrc5477.c linux/drivers/sound/nec_vrc5477.c
--- linux-2.4.19-pre1/drivers/sound/nec_vrc5477.c	Thu Feb  7 15:26:42 2002
+++ linux/drivers/sound/nec_vrc5477.c	Mon Feb 11 20:59:31 2002
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
diff -urN linux-2.4.19-pre1/fs/pipe.c linux/fs/pipe.c
--- linux-2.4.19-pre1/fs/pipe.c	Thu Feb  7 15:26:13 2002
+++ linux/fs/pipe.c	Mon Feb 11 20:59:31 2002
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
diff -urN linux-2.4.19-pre1/fs/ufs/file.c linux/fs/ufs/file.c
--- linux-2.4.19-pre1/fs/ufs/file.c	Thu Feb  7 15:26:13 2002
+++ linux/fs/ufs/file.c	Mon Feb 11 21:00:14 2002
@@ -37,43 +37,12 @@
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
diff -urN linux-2.4.19-pre1/net/netlink/netlink_dev.c linux/net/netlink/netlink_dev.c
--- linux-2.4.19-pre1/net/netlink/netlink_dev.c	Thu Feb  7 15:26:23 2002
+++ linux/net/netlink/netlink_dev.c	Mon Feb 11 20:59:31 2002
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
 	unsigned int minor = MINOR(inode->i_rdev);
@@ -166,7 +161,7 @@
 
 static struct file_operations netlink_fops = {
 	owner:		THIS_MODULE,
-	llseek:		netlink_lseek,
+	llseek:		no_llseek,
 	read:		netlink_read,
 	write:		netlink_write,
 	poll:		netlink_poll,
diff -urN linux-2.4.19-pre1/net/socket.c linux/net/socket.c
--- linux-2.4.19-pre1/net/socket.c	Thu Feb  7 15:26:21 2002
+++ linux/net/socket.c	Mon Feb 11 20:59:31 2002
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

