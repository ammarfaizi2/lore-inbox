Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVKTSXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVKTSXo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKTSXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:23:44 -0500
Received: from verein.lst.de ([213.95.11.210]:51907 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750883AbVKTSXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:23:43 -0500
Date: Sun, 20 Nov 2005 19:23:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement generic rtc compat ioctl handling
Message-ID: <20051120182335.GA19720@lst.de>
References: <20051111092021.GA26750@lst.de> <200511141309.37180.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511141309.37180.arnd@arndb.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 01:09:36PM +0100, Arnd Bergmann wrote:
> On Freedag 11 November 2005 10:20, Christoph Hellwig wrote:
> > +static int rtc_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
> > +{
> > +???????compat_ulong_t __user *val = compat_alloc_user_space(sizeof(*val));
> > +???????compat_ulong_t __user *uval = (compat_ulong_t __user *)arg;
> > +???????int ret;
> > +
> > 
> This one should really be 
> 
> compat_ulong_t __user *uval = compat_ptr(arg);
> 
> It's not really a problem since the only architecture where compat_ptr()
> makes a difference (64 bit s390) doesn't have an RTC driver, but it
> should be changed nevertheless.
> 
> Also, I suppose the declaration of val is wrong, since the ioctl methods
> expect a pointer to an unsigned long, not a compat_ulong_t. If you
> change that, the copy_in_user() won't work either.

Yeah.  This stuff was hurting my brain so I decided to go for the
traditional get_fs() based version instead:

Index: linux-2.6/arch/parisc/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/ioctl32.c	2005-11-20 19:17:42.000000000 +0100
+++ linux-2.6/arch/parisc/kernel/ioctl32.c	2005-11-20 19:18:02.000000000 +0100
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
--- linux-2.6.orig/arch/x86_64/ia32/ia32_ioctl.c	2005-11-20 19:17:42.000000000 +0100
+++ linux-2.6/arch/x86_64/ia32/ia32_ioctl.c	2005-11-20 19:18:02.000000000 +0100
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
--- linux-2.6.orig/fs/compat_ioctl.c	2005-11-20 19:17:42.000000000 +0100
+++ linux-2.6/fs/compat_ioctl.c	2005-11-20 19:18:02.000000000 +0100
@@ -2561,6 +2561,49 @@
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
@@ -2943,6 +2986,10 @@
 HANDLE_IOCTL(SIOCGIWENCODE, do_wireless_ioctl)
 HANDLE_IOCTL(SIOCSIFBR, old_bridge_ioctl)
 HANDLE_IOCTL(SIOCGIFBR, old_bridge_ioctl)
+HANDLE_IOCTL(RTC_IRQP_READ32, rtc_ioctl)
+HANDLE_IOCTL(RTC_IRQP_SET32, rtc_ioctl)
+HANDLE_IOCTL(RTC_EPOCH_READ32, rtc_ioctl)
+HANDLE_IOCTL(RTC_EPOCH_SET32, rtc_ioctl)
 
 #if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
 HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
