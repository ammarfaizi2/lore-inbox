Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUHWUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUHWUBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266763AbUHWT7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:59:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:40899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266663AbUHWSgK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:10 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860901217@kroah.com>
Date: Mon, 23 Aug 2004 11:34:50 -0700
Message-Id: <10932860901833@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.59.7, 2004/08/05 16:38:57-07:00, R.Marek@sh.cvut.cz

[PATCH] I2C: automatic VRM detection part1

This patch forms composite module with i2c-sensor.c and new file
i2c-sensor-vid.c, which provides i2c_which_vrm function for detecting VRM
version of processor using cpuid_eax func. Resulting module has unchanged
name (i2c-sensor).

Before applaying this patch, please rename i2c-sensor.c to
i2c-sensor-detect.c

This patch was briefly reviewed by Jean Delvare.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/Makefile            |    3 +
 drivers/i2c/i2c-sensor-detect.c |    8 ++-
 drivers/i2c/i2c-sensor-vid.c    |   99 ++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-vid.h         |    5 +-
 4 files changed, 111 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	2004-08-23 11:04:59 -07:00
+++ b/drivers/i2c/Makefile	2004-08-23 11:04:59 -07:00
@@ -7,6 +7,9 @@
 obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-y				+= busses/ chips/ algos/
 
+i2c-sensor-objs := i2c-sensor-detect.o i2c-sensor-vid.o
+
+
 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-08-23 11:04:59 -07:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-08-23 11:04:59 -07:00
@@ -1,6 +1,6 @@
 /*
-    i2c-sensor.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
+    i2c-sensor-detect.c - Part of lm_sensors, Linux kernel modules for hardware
+            		  monitoring
     Copyright (c) 1998 - 2001 Frodo Looijaard <frodol@dds.nl> and
     Mark D. Studebaker <mdsxyz123@yahoo.com>
 
@@ -162,6 +162,8 @@
 
 EXPORT_SYMBOL(i2c_detect);
 
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+	      "Rudolf Marek <r.marek@sh.cvut.cz>");
+
 MODULE_DESCRIPTION("i2c-sensor driver");
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/i2c/i2c-sensor-vid.c b/drivers/i2c/i2c-sensor-vid.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/i2c-sensor-vid.c	2004-08-23 11:04:59 -07:00
@@ -0,0 +1,99 @@
+/*
+    i2c-sensor-vid.c -  Part of lm_sensors, Linux kernel modules for hardware
+        		monitoring
+
+    Copyright (c) 2004 Rudolf Marek <r.marek@sh.cvut.cz>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+struct vrm_model {
+	u8 vendor;
+	u8 eff_family;
+	u8 eff_model;
+	int vrm_type;
+};
+
+#define ANY 0xFF
+
+#ifdef CONFIG_X86
+
+static struct vrm_model vrm_models[] = {
+	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
+	{X86_VENDOR_AMD, 0xF, 0x4, 90},		/* Athlon 64 */
+	{X86_VENDOR_AMD, 0xF, 0x5, 24},		/* Opteron */
+	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
+	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */
+	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
+	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
+	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
+	{X86_VENDOR_INTEL, 0xF, ANY, 90},	/* P4 before Prescott */
+	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
+	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
+	};
+
+static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
+{
+	int i = 0;
+
+	while (vrm_models[i].vendor!=X86_VENDOR_UNKNOWN) {
+		if (vrm_models[i].vendor==vendor)
+			if ((vrm_models[i].eff_family==eff_family)&& \
+			((vrm_models[i].eff_model==eff_model)|| \
+			(vrm_models[i].eff_model==ANY)))
+				return vrm_models[i].vrm_type;
+		i++;
+	}
+
+	return 0;
+}
+
+int i2c_which_vrm(void)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+	u32 eax;
+	u8 eff_family, eff_model;
+	int vrm_ret;
+
+	if (c->x86 < 6) return 0;	/* any CPU with familly lower than 6
+				 	dont have VID and/or CPUID */
+	eax = cpuid_eax(1);
+	eff_family = ((eax & 0x00000F00)>>8);
+	eff_model  = ((eax & 0x000000F0)>>4);
+	if (eff_family == 0xF) {	/* use extended model & family */
+		eff_family += ((eax & 0x00F00000)>>20);
+		eff_model += ((eax & 0x000F0000)>>16)<<4;
+	}
+	vrm_ret = find_vrm(eff_family,eff_model,c->x86_vendor);
+	if (vrm_ret == 0)
+		printk(KERN_INFO "i2c-sensor.o: Unknown VRM version of your"
+		" x86 CPU\n");
+	return vrm_ret;
+}
+
+/* and now something completely different for Non-x86 world*/
+#else
+int i2c_which_vrm(void)
+{
+	printk(KERN_INFO "i2c-sensor.o: Unknown VRM version of your CPU\n");
+	return 0;
+}
+#endif
+
+EXPORT_SYMBOL(i2c_which_vrm);
diff -Nru a/include/linux/i2c-vid.h b/include/linux/i2c-vid.h
--- a/include/linux/i2c-vid.h	2004-08-23 11:04:59 -07:00
+++ b/include/linux/i2c-vid.h	2004-08-23 11:04:59 -07:00
@@ -35,12 +35,15 @@
     to avoid floating point in the kernel.
 */
 
+int i2c_which_vrm(void);
+
 #define DEFAULT_VRM	82
 
 static inline int vid_from_reg(int val, int vrm)
 {
 	switch(vrm) {
-
+	case  0:
+		return 0;
 	case 91:		/* VRM 9.1 */
 	case 90:		/* VRM 9.0 */
 		return(val == 0x1f ? 0 :

