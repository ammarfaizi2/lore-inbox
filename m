Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310153AbSCKXVG>; Mon, 11 Mar 2002 18:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310158AbSCKXUr>; Mon, 11 Mar 2002 18:20:47 -0500
Received: from zero.tech9.net ([209.61.188.187]:41233 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S310153AbSCKXUc>;
	Mon, 11 Mar 2002 18:20:32 -0500
Subject: [PATCH] more lseek cleanup
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 11 Mar 2002 18:20:44 -0500
Message-Id: <1015888844.853.98.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The -ac merge in 2.4.19-pre3 merged the majority of my 2.4 lseek
cleanup, but not all.  The following patch continues the cleanup by
removing more instances of reimplementations of no_llseek and having the
driver in question use no_llseek.

Most of these are in a later -ac release.  Patch is against 2.4.19-pre3,
please apply.

	Robert Love

diff -urN linux-2.4.19-pre3/drivers/sound/au1000.c linux/drivers/sound/au1000.c
--- linux-2.4.19-pre3/drivers/sound/au1000.c	Mon Mar 11 18:08:43 2002
+++ linux/drivers/sound/au1000.c	Mon Mar 11 18:09:58 2002
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
diff -urN linux-2.4.19-pre3/drivers/sound/cs4281/cs4281_wrapper.h linux/drivers/sound/cs4281/cs4281_wrapper.h
--- linux-2.4.19-pre3/drivers/sound/cs4281/cs4281_wrapper.h	Mon Mar 11 18:08:42 2002
+++ linux/drivers/sound/cs4281/cs4281_wrapper.h	Mon Mar 11 18:09:58 2002
@@ -28,7 +28,7 @@
 #define __CS4281_WRAPPER_H
 
 /* 2.4.x wrapper */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,12)
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,9)
 static int cs4281_null_suspend(struct pci_dev *pcidev, u32 unused) { return 0; }
 static int cs4281_null_resume(struct pci_dev *pcidev) { return 0; }
 #else
diff -urN linux-2.4.19-pre3/drivers/sound/cs4281/cs4281m.c linux/drivers/sound/cs4281/cs4281m.c
--- linux-2.4.19-pre3/drivers/sound/cs4281/cs4281m.c	Mon Mar 11 18:08:42 2002
+++ linux/drivers/sound/cs4281/cs4281m.c	Mon Mar 11 18:09:58 2002
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
diff -urN linux-2.4.19-pre3/drivers/sound/ite8172.c linux/drivers/sound/ite8172.c
--- linux-2.4.19-pre3/drivers/sound/ite8172.c	Mon Mar 11 18:08:42 2002
+++ linux/drivers/sound/ite8172.c	Mon Mar 11 18:09:58 2002
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
diff -urN linux-2.4.19-pre3/drivers/sound/swarm_cs4297a.c linux/drivers/sound/swarm_cs4297a.c
--- linux-2.4.19-pre3/drivers/sound/swarm_cs4297a.c	Mon Mar 11 18:08:43 2002
+++ linux/drivers/sound/swarm_cs4297a.c	Mon Mar 11 18:10:00 2002
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
diff -urN linux-2.4.19-pre3/net/netlink/netlink_dev.c linux/net/netlink/netlink_dev.c
--- linux-2.4.19-pre3/net/netlink/netlink_dev.c	Mon Mar 11 18:08:19 2002
+++ linux/net/netlink/netlink_dev.c	Mon Mar 11 18:09:47 2002
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
diff -urN linux-2.4.19-pre3/net/socket.c linux/net/socket.c
--- linux-2.4.19-pre3/net/socket.c	Mon Mar 11 18:08:17 2002
+++ linux/net/socket.c	Mon Mar 11 18:09:47 2002
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



