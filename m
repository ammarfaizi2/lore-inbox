Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVKEQgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVKEQgT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVKEQep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:46797 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932106AbVKEQed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:33 -0500
Message-Id: <20051105162720.973028000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:15 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, maxk@qualcomm.com, marcel@holtmann.org,
       bluez-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 25/25] bluetooth: integrate ioctl32 handling
Content-Disposition: inline; filename=bluetooth-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All bluetooth ioctl numbers are compatible for 32 bit,
but some of them are not defined under include/linux,
so we needed some hacks to make it work with compat_ioctl.

This patch moves the compat_ioctl code into the
respective bluetooth device drivers for simplification.

CC: maxk@qualcomm.com
CC: marcel@holtmann.org
CC: bluez-devel@lists.sf.net
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/bluetooth/hci_ldisc.c
===================================================================
--- linux-cg.orig/drivers/bluetooth/hci_ldisc.c	2005-11-05 02:44:35.000000000 +0100
+++ linux-cg/drivers/bluetooth/hci_ldisc.c	2005-11-05 02:55:29.000000000 +0100
@@ -507,6 +507,25 @@
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static long hci_uart_tty_compat_ioctl(struct tty_struct *tty,
+		struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+	switch (cmd) {
+	case HCIUARTSETPROTO:
+	case HCIUARTGETPROTO:
+		lock_kernel();
+		ret = hci_uart_tty_ioctl(tty, file, cmd, arg);
+		unlock_kernel();
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+	}
+	return ret;
+}
+#endif
+
 /*
  * We don't provide read/write/poll interface for user space.
  */
@@ -545,6 +564,9 @@
 	hci_uart_ldisc.read		= hci_uart_tty_read;
 	hci_uart_ldisc.write		= hci_uart_tty_write;
 	hci_uart_ldisc.ioctl		= hci_uart_tty_ioctl;
+#ifdef CONFIG_COMPAT
+	hci_uart_ldisc.compat_ioctl	= hci_uart_tty_compat_ioctl;
+#endif
 	hci_uart_ldisc.poll		= hci_uart_tty_poll;
 	hci_uart_ldisc.receive_room	= hci_uart_tty_room;
 	hci_uart_ldisc.receive_buf	= hci_uart_tty_receive;
Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 02:54:26.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 02:54:31.000000000 +0100
@@ -164,25 +164,6 @@
 	return -EINVAL;
 }
 
-/* Bluetooth ioctls */
-#define HCIUARTSETPROTO	_IOW('U', 200, int)
-#define HCIUARTGETPROTO	_IOR('U', 201, int)
-
-#define BNEPCONNADD	_IOW('B', 200, int)
-#define BNEPCONNDEL	_IOW('B', 201, int)
-#define BNEPGETCONNLIST	_IOR('B', 210, int)
-#define BNEPGETCONNINFO	_IOR('B', 211, int)
-
-#define CMTPCONNADD	_IOW('C', 200, int)
-#define CMTPCONNDEL	_IOW('C', 201, int)
-#define CMTPGETCONNLIST	_IOR('C', 210, int)
-#define CMTPGETCONNINFO	_IOR('C', 211, int)
-
-#define HIDPCONNADD	_IOW('H', 200, int)
-#define HIDPCONNDEL	_IOW('H', 201, int)
-#define HIDPGETCONNLIST	_IOR('H', 210, int)
-#define HIDPGETCONNINFO	_IOR('H', 211, int)
-
 #undef CODE
 #endif
 
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 02:54:26.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 02:54:31.000000000 +0100
@@ -350,43 +350,7 @@
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
 /* Bluetooth */
-COMPATIBLE_IOCTL(HCIDEVUP)
-COMPATIBLE_IOCTL(HCIDEVDOWN)
-COMPATIBLE_IOCTL(HCIDEVRESET)
-COMPATIBLE_IOCTL(HCIDEVRESTAT)
-COMPATIBLE_IOCTL(HCIGETDEVLIST)
-COMPATIBLE_IOCTL(HCIGETDEVINFO)
-COMPATIBLE_IOCTL(HCIGETCONNLIST)
-COMPATIBLE_IOCTL(HCIGETCONNINFO)
-COMPATIBLE_IOCTL(HCISETRAW)
-COMPATIBLE_IOCTL(HCISETSCAN)
-COMPATIBLE_IOCTL(HCISETAUTH)
-COMPATIBLE_IOCTL(HCISETENCRYPT)
-COMPATIBLE_IOCTL(HCISETPTYPE)
-COMPATIBLE_IOCTL(HCISETLINKPOL)
-COMPATIBLE_IOCTL(HCISETLINKMODE)
-COMPATIBLE_IOCTL(HCISETACLMTU)
-COMPATIBLE_IOCTL(HCISETSCOMTU)
-COMPATIBLE_IOCTL(HCIINQUIRY)
-COMPATIBLE_IOCTL(HCIUARTSETPROTO)
-COMPATIBLE_IOCTL(HCIUARTGETPROTO)
-COMPATIBLE_IOCTL(RFCOMMCREATEDEV)
-COMPATIBLE_IOCTL(RFCOMMRELEASEDEV)
-COMPATIBLE_IOCTL(RFCOMMGETDEVLIST)
-COMPATIBLE_IOCTL(RFCOMMGETDEVINFO)
 COMPATIBLE_IOCTL(RFCOMMSTEALDLC)
-COMPATIBLE_IOCTL(BNEPCONNADD)
-COMPATIBLE_IOCTL(BNEPCONNDEL)
-COMPATIBLE_IOCTL(BNEPGETCONNLIST)
-COMPATIBLE_IOCTL(BNEPGETCONNINFO)
-COMPATIBLE_IOCTL(CMTPCONNADD)
-COMPATIBLE_IOCTL(CMTPCONNDEL)
-COMPATIBLE_IOCTL(CMTPGETCONNLIST)
-COMPATIBLE_IOCTL(CMTPGETCONNINFO)
-COMPATIBLE_IOCTL(HIDPCONNADD)
-COMPATIBLE_IOCTL(HIDPCONNDEL)
-COMPATIBLE_IOCTL(HIDPGETCONNLIST)
-COMPATIBLE_IOCTL(HIDPGETCONNINFO)
 /* CAPI */
 COMPATIBLE_IOCTL(CAPI_REGISTER)
 COMPATIBLE_IOCTL(CAPI_GET_MANUFACTURER)
Index: linux-cg/net/bluetooth/bnep/sock.c
===================================================================
--- linux-cg.orig/net/bluetooth/bnep/sock.c	2005-11-05 02:43:24.000000000 +0100
+++ linux-cg/net/bluetooth/bnep/sock.c	2005-11-05 02:54:31.000000000 +0100
@@ -151,6 +151,7 @@
 	.owner      = THIS_MODULE,
 	.release    = bnep_sock_release,
 	.ioctl      = bnep_sock_ioctl,
+	.compat_ioctl = bnep_sock_ioctl,
 	.bind       = sock_no_bind,
 	.getname    = sock_no_getname,
 	.sendmsg    = sock_no_sendmsg,
Index: linux-cg/net/bluetooth/cmtp/sock.c
===================================================================
--- linux-cg.orig/net/bluetooth/cmtp/sock.c	2005-11-05 02:43:24.000000000 +0100
+++ linux-cg/net/bluetooth/cmtp/sock.c	2005-11-05 02:54:31.000000000 +0100
@@ -142,6 +142,7 @@
 	.owner		= THIS_MODULE,
 	.release	= cmtp_sock_release,
 	.ioctl		= cmtp_sock_ioctl,
+	.compat_ioctl	= cmtp_sock_ioctl,
 	.bind		= sock_no_bind,
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
Index: linux-cg/net/bluetooth/hci_sock.c
===================================================================
--- linux-cg.orig/net/bluetooth/hci_sock.c	2005-11-05 02:45:00.000000000 +0100
+++ linux-cg/net/bluetooth/hci_sock.c	2005-11-05 02:54:31.000000000 +0100
@@ -584,6 +584,7 @@
 	.sendmsg	= hci_sock_sendmsg,
 	.recvmsg	= hci_sock_recvmsg,
 	.ioctl		= hci_sock_ioctl,
+	.compat_ioctl	= hci_sock_ioctl,
 	.poll		= datagram_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
Index: linux-cg/net/bluetooth/hidp/sock.c
===================================================================
--- linux-cg.orig/net/bluetooth/hidp/sock.c	2005-11-05 02:43:24.000000000 +0100
+++ linux-cg/net/bluetooth/hidp/sock.c	2005-11-05 02:54:31.000000000 +0100
@@ -148,6 +148,7 @@
 	.owner		= THIS_MODULE,
 	.release	= hidp_sock_release,
 	.ioctl		= hidp_sock_ioctl,
+	.compat_ioctl	= hidp_sock_ioctl,
 	.bind		= sock_no_bind,
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
Index: linux-cg/net/bluetooth/rfcomm/sock.c
===================================================================
--- linux-cg.orig/net/bluetooth/rfcomm/sock.c	2005-11-05 02:43:24.000000000 +0100
+++ linux-cg/net/bluetooth/rfcomm/sock.c	2005-11-05 02:54:31.000000000 +0100
@@ -986,6 +986,7 @@
 	.setsockopt	= rfcomm_sock_setsockopt,
 	.getsockopt	= rfcomm_sock_getsockopt,
 	.ioctl		= rfcomm_sock_ioctl,
+	.compat_ioctl	= rfcomm_sock_ioctl,
 	.poll		= bt_sock_poll,
 	.socketpair	= sock_no_socketpair,
 	.mmap		= sock_no_mmap

--

