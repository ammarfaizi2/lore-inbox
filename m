Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWHSRgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWHSRgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWHSRgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 13:36:11 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:12721 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751036AbWHSRgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 13:36:10 -0400
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [patch 2.6.18-rc3] RTC class, Kconfig improvements
Date: Sat, 19 Aug 2006 10:19:48 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200608041741.26730.david-b@pacbell.net>
In-Reply-To: <200608041741.26730.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608191019.49557.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ RESEND against RC4, plus added RTC_DEBUG option ]

Small updates to make the RTC class Kconfig text be more informative.
This should help folk used to the drivers/char/rtc.c support, or a
single RTC, be slightly less surprised by the differences.

Also, adds a new RTC_DEBUG option to predefine DEBUG in the framework
and its drivers, while debugging.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/Kconfig
===================================================================
--- g26.orig/drivers/rtc/Kconfig	2006-08-19 02:02:45.000000000 -0700
+++ g26/drivers/rtc/Kconfig	2006-08-19 10:08:23.000000000 -0700
@@ -37,6 +37,13 @@ config RTC_HCTOSYS_DEVICE
 	  The RTC device that will be used as the source for
 	  the system time, usually rtc0.
 
+config RTC_DEBUG
+	bool "RTC debug support"
+	depends on RTC_CLASS = y
+	help
+	  Say yes here to enable debugging support in the RTC framework
+	  and individual RTC drivers.
+
 comment "RTC interfaces"
 	depends on RTC_CLASS
 
@@ -45,8 +52,8 @@ config RTC_INTF_SYSFS
 	depends on RTC_CLASS && SYSFS
 	default RTC_CLASS
 	help
-	  Say yes here if you want to use your RTC using the sysfs
-	  interface, /sys/class/rtc/rtcX .
+	  Say yes here if you want to use your RTCs using sysfs interfaces,
+	  /sys/class/rtc/rtc0 through /sys/.../rtcN.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-sysfs.
@@ -56,8 +63,9 @@ config RTC_INTF_PROC
 	depends on RTC_CLASS && PROC_FS
 	default RTC_CLASS
 	help
-	  Say yes here if you want to use your RTC using the proc
-	  interface, /proc/driver/rtc .
+	  Say yes here if you want to use your first RTC through the proc
+	  interface, /proc/driver/rtc.  Other RTCs will not be available
+	  through that API.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-proc.
@@ -67,8 +75,11 @@ config RTC_INTF_DEV
 	depends on RTC_CLASS
 	default RTC_CLASS
 	help
-	  Say yes here if you want to use your RTC using the dev
-	  interface, /dev/rtc .
+	  Say yes here if you want to use your RTCs using the /dev
+	  interfaces, which "udev" sets up as /dev/rtc0 through
+	  /dev/rtcN.  You may want to set up a symbolic link so one
+	  of these can be accessed as /dev/rtc, which is a name
+	  expected by "hwclock" and some other programs.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-dev.
@@ -78,7 +89,8 @@ config RTC_INTF_DEV_UIE_EMUL
 	depends on RTC_INTF_DEV
 	help
 	  Provides an emulation for RTC_UIE if the underlaying rtc chip
-	  driver did not provide RTC_UIE ioctls.
+	  driver does not expose RTC_UIE ioctls.  Those requests generate
+	  once-per-second update interrupts, used for synchronization.
 
 comment "RTC drivers"
 	depends on RTC_CLASS
Index: g26/drivers/rtc/Makefile
===================================================================
--- g26.orig/drivers/rtc/Makefile	2006-08-19 10:08:09.000000000 -0700
+++ g26/drivers/rtc/Makefile	2006-08-19 10:09:07.000000000 -0700
@@ -2,6 +2,10 @@
 # Makefile for RTC class/drivers.
 #
 
+ifeq ($(CONFIG_RTC_DEBUG),y)
+	EXTRA_CFLAGS		+= -DDEBUG
+endif
+
 obj-$(CONFIG_RTC_LIB)		+= rtc-lib.o
 obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
