Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVLMRX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVLMRX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVLMRX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:23:29 -0500
Received: from verein.lst.de ([213.95.11.210]:3794 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751104AbVLMRX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:23:28 -0500
Date: Tue, 13 Dec 2005 18:23:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/3] move rtc compat ioctl handling to fs/compat_ioctl.c
Message-ID: <20051213172312.GA16392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements generic handling of RTC_IRQP_READ32, RTC_IRQP_SET32,
RTC_EPOCH_READ32 and RTC_EPOCH_SET32 in fs/compat_ioctl.c.  It's based on
the x86_64 code which needed a little massaging to be endian-clean.

parisc used COMPAT_IOCTL or generic w_long handlers for these whichce
is wrong and can't work because the ioctls encode sizeof(unsigned long)
in their ioctl number.  parisc also duplicated COMPAT_IOCTL entries for
other rtc ioctls which I remove in this patch, too.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/arch/parisc/kernel/ioctl32.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/parisc/kernel/ioctl32.c	2005-12-12 18:31:28.000000000 +0100
+++ linux-2.6.15-rc5/arch/parisc/kernel/ioctl32.c	2005-12-12 18:53:52.000000000 +0100
@@ -36,25 +36,6 @@
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
 IOCTL_TABLE_END
 
 int ioctl_table_size = ARRAY_SIZE(ioctl_start);
Index: linux-2.6.15-rc5/arch/x86_64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/ia32/ia32_ioctl.c	2005-12-12 18:31:31.000000000 +0100
+++ linux-2.6.15-rc5/arch/x86_64/ia32/ia32_ioctl.c	2005-12-12 18:53:52.000000000 +0100
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
 
Index: linux-2.6.15-rc5/fs/compat_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/compat_ioctl.c	2005-12-12 18:51:16.000000000 +0100
+++ linux-2.6.15-rc5/fs/compat_ioctl.c	2005-12-12 19:00:53.000000000 +0100
@@ -2476,6 +2476,49 @@
 	return -EINVAL;
 }
 
+#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
+#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
+#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
+#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
+
+static int rtc_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
+{
+	mm_segment_t oldfs = get_fs();
+	compat_ulong_t val32;
+	unsigned long kval;
+	int ret;
+
+	switch (cmd) {
+	case RTC_IRQP_READ32:
+	case RTC_EPOCH_READ32:
+		set_fs(KERNEL_DS);
+		ret = sys_ioctl(fd, (cmd == RTC_IRQP_READ32) ?
+					RTC_IRQP_READ : RTC_EPOCH_READ,
+					(unsigned long)&kval);
+		set_fs(oldfs);
+		if (ret)
+			return ret;
+		val32 = kval;
+		return put_user(val32, (unsigned int __user *)arg);
+	case RTC_IRQP_SET32:
+	case RTC_EPOCH_SET32:
+		ret = get_user(val32, (unsigned int __user *)arg);
+		if (ret)
+			return ret;
+		kval = val32;
+
+		set_fs(KERNEL_DS);
+		ret = sys_ioctl(fd, (cmd == RTC_IRQP_SET32) ?
+				RTC_IRQP_SET : RTC_EPOCH_SET,
+				(unsigned long)&kval);
+		set_fs(oldfs);
+		return ret;
+	default:
+		/* unreached */
+		return -ENOIOCTLCMD;
+	}
+}
+
 #if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
 struct ncp_ioctl_request_32 {
 	u32 function;
@@ -2859,6 +2902,10 @@
 HANDLE_IOCTL(SIOCGIWENCODE, do_wireless_ioctl)
 HANDLE_IOCTL(SIOCSIFBR, old_bridge_ioctl)
 HANDLE_IOCTL(SIOCGIFBR, old_bridge_ioctl)
+HANDLE_IOCTL(RTC_IRQP_READ32, rtc_ioctl)
+HANDLE_IOCTL(RTC_IRQP_SET32, rtc_ioctl)
+HANDLE_IOCTL(RTC_EPOCH_READ32, rtc_ioctl)
+HANDLE_IOCTL(RTC_EPOCH_SET32, rtc_ioctl)
 
 #if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
 HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
