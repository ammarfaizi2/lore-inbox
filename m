Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266374AbSKGFev>; Thu, 7 Nov 2002 00:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266375AbSKGFev>; Thu, 7 Nov 2002 00:34:51 -0500
Received: from dp.samba.org ([66.70.73.150]:9195 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266374AbSKGFen>;
	Thu, 7 Nov 2002 00:34:43 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.64739.822417.716074@argo.ozlabs.ibm.com>
Date: Thu, 7 Nov 2002 16:40:51 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove drivers/macintosh/rtc.c
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes drivers/macintosh/rtc.c.  It was only used on PPC,
and we now use drivers/char/genrtc.c instead.

Linus, please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/Makefile linuxppc-2.5/drivers/macintosh/Makefile
--- linux-2.5/drivers/macintosh/Makefile	2002-08-27 07:04:37.000000000 +1000
+++ linuxppc-2.5/drivers/macintosh/Makefile	2002-08-27 07:23:00.000000000 +1000
@@ -22,7 +22,6 @@
 endif
 obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
-obj-$(CONFIG_PPC_RTC)		+= rtc.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
 obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
diff -urN linux-2.5/drivers/macintosh/rtc.c linuxppc-2.5/drivers/macintosh/rtc.c
--- linux-2.5/drivers/macintosh/rtc.c	Sat May 25 10:21:39 2002
+++ /dev/null	Thu Jan 01 10:00:00 1970
@@ -1,147 +0,0 @@
-/*
- * Linux/PowerPC Real Time Clock Driver
- *
- * heavily based on:
- * Linux/SPARC Real Time Clock Driver
- * Copyright (C) 1996 Thomas K. Dyas (tdyas@eden.rutgers.edu)
- *
- * This is a little driver that lets a user-level program access
- * the PPC clocks chip. It is no use unless you
- * use the modified clock utility.
- *
- * Get the modified clock utility from:
- *   ftp://vger.rutgers.edu/pub/linux/Sparc/userland/clock.c
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/miscdevice.h>
-#include <linux/slab.h>
-#include <linux/fcntl.h>
-#include <linux/poll.h>
-#include <linux/init.h>
-#include <linux/mc146818rtc.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/machdep.h>
-
-#include <asm/time.h>
-
-static int rtc_busy = 0;
-
-/* Retrieve the current date and time from the real time clock. */
-void get_rtc_time(struct rtc_time *t)
-{
-	unsigned long nowtime;
-
-	nowtime = (ppc_md.get_rtc_time)();
-
-	to_tm(nowtime, t);
-
-	t->tm_year -= 1900;
-	t->tm_mon -= 1; /* Make sure userland has a 0-based month */
-}
-
-/* Set the current date and time in the real time clock. */
-void set_rtc_time(struct rtc_time *t)
-{
-	unsigned long nowtime;
-
-	nowtime = mktime(t->tm_year+1900, t->tm_mon+1, t->tm_mday,
-			t->tm_hour, t->tm_min, t->tm_sec);
-
-	(ppc_md.set_rtc_time)(nowtime);
-}
-
-static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-	unsigned long arg)
-{
-	struct rtc_time rtc_tm;
-
-	switch (cmd)
-	{
-	case RTC_RD_TIME:
-		if (ppc_md.get_rtc_time)
-		{
-			get_rtc_time(&rtc_tm);
-
-			if (copy_to_user((struct rtc_time*)arg, &rtc_tm, sizeof(struct rtc_time)))
-				return -EFAULT;
-
-			return 0;
-		}
-		else
-			return -EINVAL;
-
-	case RTC_SET_TIME:
-		if (!capable(CAP_SYS_TIME))
-			return -EPERM;
-
-		if (ppc_md.set_rtc_time)
-		{
-			if (copy_from_user(&rtc_tm, (struct rtc_time*)arg, sizeof(struct rtc_time)))
-				return -EFAULT;
-
-			set_rtc_time(&rtc_tm);
-
-			return 0;
-		}
-		else
-			return -EINVAL;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static int rtc_open(struct inode *inode, struct file *file)
-{
-	if (rtc_busy)
-		return -EBUSY;
-
-	rtc_busy = 1;
-
-	MOD_INC_USE_COUNT;
-
-	return 0;
-}
-
-static int rtc_release(struct inode *inode, struct file *file)
-{
-	MOD_DEC_USE_COUNT;
-	rtc_busy = 0;
-	return 0;
-}
-
-static struct file_operations rtc_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		rtc_ioctl,
-	open:		rtc_open,
-	release:	rtc_release
-};
-
-static struct miscdevice rtc_dev = { RTC_MINOR, "rtc", &rtc_fops };
-
-static int __init rtc_init(void)
-{
-	int error;
-
-	error = misc_register(&rtc_dev);
-	if (error) {
-		printk(KERN_ERR "rtc: unable to get misc minor\n");
-		return error;
-	}
-
-	return 0;
-}
-
-static void __exit rtc_exit(void)
-{
-	misc_deregister(&rtc_dev);
-}
-
-module_init(rtc_init);
-module_exit(rtc_exit);
-MODULE_LICENSE("GPL");
