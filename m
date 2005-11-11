Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVKKJU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVKKJU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVKKJU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:20:29 -0500
Received: from verein.lst.de ([213.95.11.210]:24040 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932305AbVKKJU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:20:28 -0500
Date: Fri, 11 Nov 2005 10:20:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] implement generic rtc compat ioctl handling
Message-ID: <20051111092021.GA26750@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements generic handling of RTC_IRQP_READ32,
RTC_IRQP_SET32, RTC_EPOCH_READ32 and RTC_EPOCH_SET32 in
fs/compat_ioctl.c.  It's based on the x86_64 code which needed
a little massaging to be endian-clean and use compat_alloc_user_space
aswell as the compat_ types.

parisc used COMPAT_IOCTL or generic w_long handlers for these which
is wrong and can't work because the ioctls encode sizeof(unsigned long)
in their ioctl number.  parisc also duplicated COMPAT_IOCTL entries for
other rtc ioctls which I remove in this patch, too.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/parisc/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/ioctl32.c	2005-11-08 23:07:47.000000000 +0100
+++ linux-2.6/arch/parisc/kernel/ioctl32.c	2005-11-11 09:57:27.000000000 +0100
@@ -571,25 +571,6 @@
 HANDLE_IOCTL(SIOCGPPPCSTATS, dev_ifsioc)
 HANDLE_IOCTL(SIOCGPPPVER, dev_ifsioc)
 
-#if defined(CONFIG_GEN_RTC)
-COMPATIBLE_IOCTL(RTC_AIE_ON)
-COMPATIBLE_IOCTL(RTC_AIE_OFF)
-COMPATIBLE_IOCTL(RTC_UIE_ON)
-COMPATIBLE_IOCTL(RTC_UIE_OFF)
-COMPATIBLE_IOCTL(RTC_PIE_ON)
-COMPATIBLE_IOCTL(RTC_PIE_OFF)
-COMPATIBLE_IOCTL(RTC_WIE_ON)
-COMPATIBLE_IOCTL(RTC_WIE_OFF)
-COMPATIBLE_IOCTL(RTC_ALM_SET)   /* struct rtc_time only has ints */
-COMPATIBLE_IOCTL(RTC_ALM_READ)  /* struct rtc_time only has ints */
-COMPATIBLE_IOCTL(RTC_RD_TIME)   /* struct rtc_time only has ints */
-COMPATIBLE_IOCTL(RTC_SET_TIME)  /* struct rtc_time only has ints */
-HANDLE_IOCTL(RTC_IRQP_READ, w_long)
-COMPATIBLE_IOCTL(RTC_IRQP_SET)
-HANDLE_IOCTL(RTC_EPOCH_READ, w_long)
-COMPATIBLE_IOCTL(RTC_EPOCH_SET)
-#endif
-
 #if defined(CONFIG_DRM) || defined(CONFIG_DRM_MODULE)
 HANDLE_IOCTL(DRM32_IOCTL_VERSION, drm32_version);
 HANDLE_IOCTL(DRM32_IOCTL_GET_UNIQUE, drm32_getsetunique);
Index: linux-2.6/arch/x86_64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/ia32_ioctl.c	2005-11-10 12:20:19.000000000 +0100
+++ linux-2.6/arch/x86_64/ia32/ia32_ioctl.c	2005-11-11 09:49:33.000000000 +0100
@@ -16,45 +16,6 @@
 
 #define CODE
 #include "compat_ioctl.c"
-  
-#define RTC_IRQP_READ32	_IOR('p', 0x0b, unsigned int)	 /* Read IRQ rate   */
-#define RTC_IRQP_SET32	_IOW('p', 0x0c, unsigned int)	 /* Set IRQ rate    */
-#define RTC_EPOCH_READ32	_IOR('p', 0x0d, unsigned)	 /* Read epoch      */
-#define RTC_EPOCH_SET32		_IOW('p', 0x0e, unsigned)	 /* Set epoch       */
-
-static int rtc32_ioctl(unsigned fd, unsigned cmd, unsigned long arg) 
-{ 
-	unsigned long val;
-	mm_segment_t oldfs = get_fs(); 
-	int ret; 
-	
-	switch (cmd) { 
-	case RTC_IRQP_READ32: 
-		set_fs(KERNEL_DS); 
-		ret = sys_ioctl(fd, RTC_IRQP_READ, (unsigned long)&val); 
-		set_fs(oldfs); 
-		if (!ret)
-			ret = put_user(val, (unsigned int __user *) arg); 
-		return ret; 
-
-	case RTC_IRQP_SET32: 
-		cmd = RTC_IRQP_SET; 
-		break; 
-
-	case RTC_EPOCH_READ32:
-		set_fs(KERNEL_DS); 
-		ret = sys_ioctl(fd, RTC_EPOCH_READ, (unsigned long) &val); 
-		set_fs(oldfs); 
-		if (!ret)
-			ret = put_user(val, (unsigned int __user *) arg); 
-		return ret; 
-
-	case RTC_EPOCH_SET32:
-		cmd = RTC_EPOCH_SET; 
-		break; 
-	} 
-	return sys_ioctl(fd,cmd,arg); 
-} 
 
 
 #define HANDLE_IOCTL(cmd,handler) { (cmd), (ioctl_trans_handler_t)(handler) }, 
@@ -64,14 +25,6 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "compat_ioctl.c"
-
-/* And these ioctls need translation */
-/* realtime device */
-HANDLE_IOCTL(RTC_IRQP_READ,  rtc32_ioctl)
-HANDLE_IOCTL(RTC_IRQP_READ32,rtc32_ioctl)
-HANDLE_IOCTL(RTC_IRQP_SET32, rtc32_ioctl)
-HANDLE_IOCTL(RTC_EPOCH_READ32, rtc32_ioctl)
-HANDLE_IOCTL(RTC_EPOCH_SET32, rtc32_ioctl)
 /* take care of sizeof(sizeof()) breakage */
 }; 
 
Index: linux-2.6/fs/compat_ioctl.c
===================================================================
--- linux-2.6.orig/fs/compat_ioctl.c	2005-11-10 12:20:20.000000000 +0100
+++ linux-2.6/fs/compat_ioctl.c	2005-11-11 10:14:13.000000000 +0100
@@ -2561,6 +2561,46 @@
 	return -EINVAL;
 }
 
+#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
+#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
+#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
+#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
+
+static int rtc_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
+{
+	compat_ulong_t __user *val = compat_alloc_user_space(sizeof(*val));
+	compat_ulong_t __user *uval = (compat_ulong_t __user *)arg;
+	int ret;
+
+	switch (cmd) {
+	case RTC_IRQP_READ32:
+	case RTC_EPOCH_READ32:
+		ret = sys_ioctl(fd, (cmd == RTC_IRQP_READ32) ?
+					RTC_IRQP_READ : RTC_EPOCH_READ,
+					(unsigned long)val);
+		if (!ret && copy_in_user(uval, val, sizeof(compat_ulong_t)))
+			ret = -EFAULT;
+		break;
+	case RTC_IRQP_SET32:
+	case RTC_EPOCH_SET32:
+		if (copy_in_user(val, uval, sizeof(compat_ulong_t))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = sys_ioctl(fd, (cmd == RTC_IRQP_SET32) ?
+				RTC_IRQP_SET : RTC_EPOCH_SET,
+				(unsigned long)val);
+		break;
+	default:
+		/* unreached */
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	return ret;
+}
+
 #if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
 struct ncp_ioctl_request_32 {
 	u32 function;
@@ -2943,6 +2983,10 @@
 HANDLE_IOCTL(SIOCGIWENCODE, do_wireless_ioctl)
 HANDLE_IOCTL(SIOCSIFBR, old_bridge_ioctl)
 HANDLE_IOCTL(SIOCGIFBR, old_bridge_ioctl)
+HANDLE_IOCTL(RTC_IRQP_READ32, rtc_ioctl)
+HANDLE_IOCTL(RTC_IRQP_SET32, rtc_ioctl)
+HANDLE_IOCTL(RTC_EPOCH_READ32, rtc_ioctl)
+HANDLE_IOCTL(RTC_EPOCH_SET32, rtc_ioctl)
 
 #if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
 HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
