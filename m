Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286372AbSAAXkL>; Tue, 1 Jan 2002 18:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286382AbSAAXkD>; Tue, 1 Jan 2002 18:40:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286372AbSAAXjt>;
	Tue, 1 Jan 2002 18:39:49 -0500
Message-ID: <3C3248C2.A3707471@mandrakesoft.com>
Date: Tue, 01 Jan 2002 18:39:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
CC: "David S. Miller" <davem@redhat.com>
Subject: PATCH 2.5.2.6: fix netlink
Content-Type: multipart/mixed;
 boundary="------------46AD2C6D2A3DFE1A43BDBB69"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------46AD2C6D2A3DFE1A43BDBB69
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Now my kernel builds.  On to "make modules"... :)

netlink uses minor number as an index into an array, and correctly
checks to make sure array-OOB does not occur.  So, this is patch is an
obvious one...
 
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------46AD2C6D2A3DFE1A43BDBB69
Content-Type: text/plain; charset=us-ascii;
 name="netlink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netlink.patch"

diff -u -r1.1.1.1 netlink_dev.c
--- net/netlink/netlink_dev.c	2001/11/09 22:12:55	1.1.1.1
+++ net/netlink/netlink_dev.c	2002/01/01 23:20:06
@@ -41,7 +41,7 @@
  
 static unsigned int netlink_poll(struct file *file, poll_table * wait)
 {
-	struct socket *sock = netlink_user[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct socket *sock = netlink_user[minor(file->f_dentry->d_inode->i_rdev)];
 
 	if (sock->ops->poll==NULL)
 		return 0;
@@ -56,7 +56,7 @@
 			     size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct socket *sock = netlink_user[MINOR(inode->i_rdev)];
+	struct socket *sock = netlink_user[minor(inode->i_rdev)];
 	struct msghdr msg;
 	struct iovec iov;
 
@@ -80,7 +80,7 @@
 			    size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct socket *sock = netlink_user[MINOR(inode->i_rdev)];
+	struct socket *sock = netlink_user[minor(inode->i_rdev)];
 	struct msghdr msg;
 	struct iovec iov;
 
@@ -105,7 +105,7 @@
 
 static int netlink_open(struct inode * inode, struct file * file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	struct socket *sock;
 	struct sockaddr_nl nladdr;
 	int err;
@@ -137,7 +137,7 @@
 
 static int netlink_release(struct inode * inode, struct file * file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	struct socket *sock;
 
 	sock = netlink_user[minor];
@@ -151,7 +151,7 @@
 static int netlink_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	int retval = 0;
 
 	if (minor >= MAX_LINKS)

--------------46AD2C6D2A3DFE1A43BDBB69--

