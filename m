Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293167AbSCAWeX>; Fri, 1 Mar 2002 17:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293269AbSCAWeM>; Fri, 1 Mar 2002 17:34:12 -0500
Received: from zero.tech9.net ([209.61.188.187]:520 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293167AbSCAWdx>;
	Fri, 1 Mar 2002 17:33:53 -0500
Subject: [PATCH] 2.4 lseek usage cleanup, take two
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Mar 2002 17:33:35 -0500
Message-Id: <1015022015.11291.44.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of my previous lseek cleanup patch, with the following
changes:

	- resync for 2.4.19-pre2
	- found more (all?) worthless lseek code
	- removed the ufs chunk of the patch (will send separate)

This patch is the _cleanup_ version of my 2.5 lseek work.  It is clean
and simple and 2.4 material.  The situation:

Many drivers implement and register a function like:

	loff_t my_lseek(struct file * file, loff_t offset, int origin)
	{
		return -ESPIPE;
	}

Which is a reimplementation of the standard no_llseek in
fs/read_write.c.  This patch removes all these worthless functions and
registers the no_llseek method as their lseek function, as it should be.

Patch is against 2.4.19-pre2.  Marcelo, my good man, please apply.

	Robert Love

diff -urN linux-2.4.19-pre2/drivers/bluetooth/hci_vhci.c linux/drivers/bluetooth/hci_vhci.c
--- linux-2.4.19-pre2/drivers/bluetooth/hci_vhci.c	Fri Mar  1 16:24:08 2002
+++ linux/drivers/bluetooth/hci_vhci.c	Fri Mar  1 16:47:53 2002
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
diff -urN linux-2.4.19-pre2/drivers/sound/au1000.c linux/drivers/sound/au1000.c
--- linux-2.4.19-pre2/drivers/sound/au1000.c	Fri Mar  1 16:23:53 2002
+++ linux/drivers/sound/au1000.c	Fri Mar  1 17:06:16 2002
@@ -812,12 +812,6 @@
 
 /* --------------------------------------------------------------------- */
 
-static loff_t au1000_llseek(struct file *file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
-
 static int au1000_open_mixdev(struct inode *inode, struct file *file)
 {
 	file->private_data = &au1000_state;
@@ -846,7 +840,7 @@
 
 static /*const */ struct file_operations au1000_mixer_fops = {
 	owner:THIS_MODULE,
-	llseek:au1000_llseek,
+	llseek:no_llseek,
 	ioctl:au1000_ioctl_mixdev,
 	open:au1000_open_mixdev,
 	release:au1000_release_mixdev,
@@ -1872,7 +1866,7 @@
 
 static /*const */ struct file_operations au1000_audio_fops = {
 	owner:		THIS_MODULE,
-	llseek:		au1000_llseek,
+	llseek:		no_llseek,
 	read:		au1000_read,
 	write:		au1000_write,
 	poll:		au1000_poll,
diff -urN linux-2.4.19-pre2/drivers/sound/cs4281/cs4281_wrapper.h linux/drivers/sound/cs4281/cs4281_wrapper.h
--- linux-2.4.19-pre2/drivers/sound/cs4281/cs4281_wrapper.h	Fri Mar  1 16:23:51 2002
+++ linux/drivers/sound/cs4281/cs4281_wrapper.h	Fri Mar  1 17:04:56 2002
@@ -28,7 +28,7 @@
 #define __CS4281_WRAPPER_H
 
 /* 2.4.x wrapper */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,12)
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,9)
 static int cs4281_null_suspend(struct pci_dev *pcidev, u32 unused) { return 0; }
 static int cs4281_null_resume(struct pci_dev *pcidev) { return 0; }
 #else
diff -urN linux-2.4.19-pre2/drivers/sound/cs4281/cs4281m.c linux/drivers/sound/cs4281/cs4281m.c
--- linux-2.4.19-pre2/drivers/sound/cs4281/cs4281m.c	Fri Mar  1 16:23:51 2002
+++ linux/drivers/sound/cs4281/cs4281m.c	Fri Mar  1 17:04:26 2002
@@ -2628,17 +2628,6 @@
 	}
 }
 
-
-// --------------------------------------------------------------------- 
-
-static loff_t cs4281_llseek(struct file *file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
-
-// --------------------------------------------------------------------- 
-
 static int cs4281_open_mixdev(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
@@ -2694,7 +2683,7 @@
 //   Mixer file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_mixer_fops = {
-	llseek:cs4281_llseek,
+	llseek:no_llseek,
 	ioctl:cs4281_ioctl_mixdev,
 	open:cs4281_open_mixdev,
 	release:cs4281_release_mixdev,
@@ -3835,7 +3824,7 @@
 //   Wave (audio) file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_audio_fops = {
-	llseek:cs4281_llseek,
+	llseek:no_llseek,
 	read:cs4281_read,
 	write:cs4281_write,
 	poll:cs4281_poll,
@@ -4184,7 +4173,7 @@
 //   Midi file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_midi_fops = {
-	llseek:cs4281_llseek,
+	llseek:no_llseek,
 	read:cs4281_midi_read,
 	write:cs4281_midi_write,
 	poll:cs4281_midi_poll,
diff -urN linux-2.4.19-pre2/drivers/sound/ite8172.c linux/drivers/sound/ite8172.c
--- linux-2.4.19-pre2/drivers/sound/ite8172.c	Fri Mar  1 16:23:53 2002
+++ linux/drivers/sound/ite8172.c	Fri Mar  1 16:48:56 2002
@@ -857,12 +857,6 @@
 
 /* --------------------------------------------------------------------- */
 
-static loff_t it8172_llseek(struct file *file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
-
 static int it8172_open_mixdev(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
@@ -1004,7 +998,7 @@
 
 static /*const*/ struct file_operations it8172_mixer_fops = {
 	owner:	THIS_MODULE,
-	llseek:	it8172_llseek,
+	llseek:	no_llseek,
 	ioctl:	it8172_ioctl_mixdev,
 	open:	it8172_open_mixdev,
 	release:	it8172_release_mixdev,
@@ -1873,7 +1867,7 @@
 
 static /*const*/ struct file_operations it8172_audio_fops = {
 	owner:	THIS_MODULE,
-	llseek:	it8172_llseek,
+	llseek:	no_llseek,
 	read:	it8172_read,
 	write:	it8172_write,
 	poll:	it8172_poll,
diff -urN linux-2.4.19-pre2/drivers/sound/nec_vrc5477.c linux/drivers/sound/nec_vrc5477.c
--- linux-2.4.19-pre2/drivers/sound/nec_vrc5477.c	Fri Mar  1 16:23:53 2002
+++ linux/drivers/sound/nec_vrc5477.c	Fri Mar  1 16:48:01 2002
@@ -818,12 +818,6 @@
 
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
@@ -865,7 +859,7 @@
 
 static /*const*/ struct file_operations vrc5477_ac97_mixer_fops = {
 	owner:		THIS_MODULE,
-	llseek:		vrc5477_ac97_llseek,
+	llseek:		no_llseek,
 	ioctl:		vrc5477_ac97_ioctl_mixdev,
 	open:		vrc5477_ac97_open_mixdev,
 	release:	vrc5477_ac97_release_mixdev,
@@ -1631,7 +1625,7 @@
 
 static /*const*/ struct file_operations vrc5477_ac97_audio_fops = {
 	owner:	THIS_MODULE,
-	llseek:		vrc5477_ac97_llseek,
+	llseek:		no_llseek,
 	read:		vrc5477_ac97_read,
 	write:		vrc5477_ac97_write,
 	poll:		vrc5477_ac97_poll,
diff -urN linux-2.4.19-pre2/drivers/sound/swarm_cs4297a.c linux/drivers/sound/swarm_cs4297a.c
--- linux-2.4.19-pre2/drivers/sound/swarm_cs4297a.c	Fri Mar  1 16:23:53 2002
+++ linux/drivers/sound/swarm_cs4297a.c	Fri Mar  1 17:01:18 2002
@@ -1526,15 +1526,6 @@
 	}
 }
 
-
-// --------------------------------------------------------------------- 
-
-static loff_t cs4297a_llseek(struct file *file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
-
 // --------------------------------------------------------------------- 
 
 static int cs4297a_open_mixdev(struct inode *inode, struct file *file)
@@ -1592,7 +1583,7 @@
 //   Mixer file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4297a_mixer_fops = {
-	llseek:cs4297a_llseek,
+	llseek:no_llseek,
 	ioctl:cs4297a_ioctl_mixdev,
 	open:cs4297a_open_mixdev,
 	release:cs4297a_release_mixdev,
@@ -2510,7 +2501,7 @@
 //   Wave (audio) file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4297a_audio_fops = {
-	llseek:cs4297a_llseek,
+	llseek:no_llseek,
 	read:cs4297a_read,
 	write:cs4297a_write,
 	poll:cs4297a_poll,
diff -urN linux-2.4.19-pre2/fs/pipe.c linux/fs/pipe.c
--- linux-2.4.19-pre2/fs/pipe.c	Fri Mar  1 16:23:16 2002
+++ linux/fs/pipe.c	Fri Mar  1 16:48:01 2002
@@ -248,12 +248,6 @@
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
@@ -383,7 +377,7 @@
  * are also used in linux/fs/fifo.c to do operations on FIFOs.
  */
 struct file_operations read_fifo_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		bad_pipe_w,
 	poll:		fifo_poll,
@@ -393,7 +387,7 @@
 };
 
 struct file_operations write_fifo_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		bad_pipe_r,
 	write:		pipe_write,
 	poll:		fifo_poll,
@@ -403,7 +397,7 @@
 };
 
 struct file_operations rdwr_fifo_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		pipe_write,
 	poll:		fifo_poll,
@@ -413,7 +407,7 @@
 };
 
 struct file_operations read_pipe_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		bad_pipe_w,
 	poll:		pipe_poll,
@@ -423,7 +417,7 @@
 };
 
 struct file_operations write_pipe_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		bad_pipe_r,
 	write:		pipe_write,
 	poll:		pipe_poll,
@@ -433,7 +427,7 @@
 };
 
 struct file_operations rdwr_pipe_fops = {
-	llseek:		pipe_lseek,
+	llseek:		no_llseek,
 	read:		pipe_read,
 	write:		pipe_write,
 	poll:		pipe_poll,
diff -urN linux-2.4.19-pre2/net/netlink/netlink_dev.c linux/net/netlink/netlink_dev.c
--- linux-2.4.19-pre2/net/netlink/netlink_dev.c	Fri Mar  1 16:23:33 2002
+++ linux/net/netlink/netlink_dev.c	Fri Mar  1 16:48:01 2002
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
diff -urN linux-2.4.19-pre2/net/socket.c linux/net/socket.c
--- linux-2.4.19-pre2/net/socket.c	Fri Mar  1 16:23:31 2002
+++ linux/net/socket.c	Fri Mar  1 16:48:01 2002
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


