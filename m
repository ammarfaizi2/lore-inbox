Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTDXQfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbTDXQfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:35:50 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:62216 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263766AbTDXQfp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:35:45 -0400
Date: Thu, 24 Apr 2003 18:47:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: Soos Peter <sp@osb.hu>
Subject: [PATCH 2.4] dmi_ident made public
Message-Id: <20030424184759.5f7b3323.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__24_Apr_2003_18:47:59_+0200_082ed720"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__24_Apr_2003_18:47:59_+0200_082ed720
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi everyone,

Here is a simple patch for the 2.4 kernel series that makes dmi_ident
(as defined in arch/i386/kernel/dmi_scan.c) public.

The idea is that this array is actually needed by other parts of the
kernel. Known modules in this case are:
 - i8k (drivers/char/i8k.c);
 - i2c-piix4 (from the LM Sensors project [1]);
 - omke (from the OMKE project [2]).
Right now, these modules are scanning the DMI table again, on their own.
This is bad for at least two reasons:
 - waste of time;
 - code duplication.

So, this simple patch is the first step in a simplification process that
would let us remove all duplicated code. It is somehow based on a patch
Soos Peter, the author of OMKE, sent me one month ago, so I have to
credit him here.

If this patch is accepted and applied, I'll work together with Peter to
get the three above-mentioned modules simplified, as well as any other I
may have missed. Also, I'll take care of porting this patch to the 2.5
series, since it also belongs there.

All comments welcome, please CC me. And please apply if it's OK.

[1] http://www.lm-sensors.nu/
[2] http://sourceforge.net/projects/omke/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

--Multipart_Thu__24_Apr_2003_18:47:59_+0200_082ed720
Content-Type: text/plain;
 name="linux-2.4.21-rc1-publicdmi.diff"
Content-Disposition: attachment;
 filename="linux-2.4.21-rc1-publicdmi.diff"
Content-Transfer-Encoding: 7bit

diff -ruN linux-2.4.21-rc1-orig/arch/i386/kernel/Makefile linux-2.4.21-rc1/arch/i386/kernel/Makefile
--- linux-2.4.21-rc1-orig/arch/i386/kernel/Makefile	2003-04-24 15:56:25.000000000 +0200
+++ linux-2.4.21-rc1/arch/i386/kernel/Makefile	2003-04-24 16:24:58.000000000 +0200
@@ -14,7 +14,8 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
+export-objs := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o \
+               dmi_scan.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -ruN linux-2.4.21-rc1-orig/arch/i386/kernel/dmi_scan.c linux-2.4.21-rc1/arch/i386/kernel/dmi_scan.c
--- linux-2.4.21-rc1-orig/arch/i386/kernel/dmi_scan.c	2003-04-24 16:14:06.000000000 +0200
+++ linux-2.4.21-rc1/arch/i386/kernel/dmi_scan.c	2003-04-24 17:42:49.000000000 +0200
@@ -5,11 +5,13 @@
 #include <linux/init.h>
 #include <linux/apm_bios.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <linux/pm.h>
 #include <asm/keyboard.h>
 #include <asm/system.h>
 #include <linux/bootmem.h>
+#include <linux/dmi.h>
 
 #include "pci-i386.h"
 
@@ -131,22 +133,7 @@
 	return -1;
 }
 
-
-enum
-{
-	DMI_BIOS_VENDOR,
-	DMI_BIOS_VERSION,
-	DMI_BIOS_DATE,
-	DMI_SYS_VENDOR,
-	DMI_PRODUCT_NAME,
-	DMI_PRODUCT_VERSION,
-	DMI_BOARD_VENDOR,
-	DMI_BOARD_NAME,
-	DMI_BOARD_VERSION,
-	DMI_STRING_MAX
-};
-
-static char *dmi_ident[DMI_STRING_MAX];
+char *dmi_ident[DMI_STRING_MAX];
 
 /*
  *	Save a DMI string
@@ -829,7 +816,7 @@
 
 static void __init dmi_decode(struct dmi_header *dm)
 {
-	u8 *data = (u8 *)dm;
+//	u8 *data = (u8 *)dm;
 	
 	switch(dm->type)
 	{
@@ -877,3 +864,5 @@
 	if(err == 0)
 		dmi_check_blacklist();
 }
+
+EXPORT_SYMBOL(dmi_ident);
diff -ruN linux-2.4.21-rc1-orig/include/linux/dmi.h linux-2.4.21-rc1/include/linux/dmi.h
--- linux-2.4.21-rc1-orig/include/linux/dmi.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.21-rc1/include/linux/dmi.h	2003-04-24 16:32:02.000000000 +0200
@@ -0,0 +1,20 @@
+#ifndef _LINUX_DMI_H
+#define _LINUX_DMI_H
+
+enum
+{
+	DMI_BIOS_VENDOR,
+	DMI_BIOS_VERSION,
+	DMI_BIOS_DATE,
+	DMI_SYS_VENDOR,
+	DMI_PRODUCT_NAME,
+	DMI_PRODUCT_VERSION,
+	DMI_BOARD_VENDOR,
+	DMI_BOARD_NAME,
+	DMI_BOARD_VERSION,
+	DMI_STRING_MAX
+};
+
+extern char *dmi_ident[DMI_STRING_MAX];
+
+#endif

--Multipart_Thu__24_Apr_2003_18:47:59_+0200_082ed720--
