Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVAJFlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVAJFlB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVAJFkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:40:19 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:23044
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262099AbVAJFOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:21 -0500
Message-Id: <200501100735.j0A7ZhPW005795@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/28] UML - Split out arch link address definitions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define addresses at which UML will link and make them settable by the arch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/Kconfig_arch
===================================================================
--- 2.6.10.orig/arch/um/Kconfig_arch	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/Kconfig_arch	2005-01-09 18:25:36.000000000 -0500
@@ -0,0 +1,16 @@
+config 64_BIT
+	bool
+	default n
+ 
+config TOP_ADDR
+ 	hex
+ 	default 0xc0000000 if !HOST_2G_2G
+ 	default 0x80000000 if HOST_2G_2G
+
+config 3_LEVEL_PGTABLES
+	bool "Three-level pagetables"
+	default n
+	help
+	Three-level pagetables will let UML have more than 4G of physical
+	memory.  All the memory that can't be mapped directly will be treated
+	as high memory.
Index: 2.6.10/arch/um/Kconfig_i386
===================================================================
--- 2.6.10.orig/arch/um/Kconfig_i386	2005-01-07 22:58:55.000000000 -0500
+++ 2.6.10/arch/um/Kconfig_i386	2005-01-09 18:25:36.000000000 -0500
@@ -1,6 +1,12 @@
 config 64_BIT
 	bool
 	default n
+ 
+config TOP_ADDR
+ 	hex
+ 	default 0xc0000000 if !HOST_2G_2G
+ 	default 0x80000000 if HOST_2G_2G
+
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables"
 	default n
@@ -8,4 +14,3 @@
 	Three-level pagetables will let UML have more than 4G of physical
 	memory.  All the memory that can't be mapped directly will be treated
 	as high memory.
-
Index: 2.6.10/arch/um/Makefile-i386
===================================================================
--- 2.6.10.orig/arch/um/Makefile-i386	2005-01-07 22:58:55.000000000 -0500
+++ 2.6.10/arch/um/Makefile-i386	2005-01-09 18:25:36.000000000 -0500
@@ -1,10 +1,6 @@
 SUBARCH_CORE := arch/um/sys-i386/
 
-ifeq ($(CONFIG_HOST_2G_2G), y)
-TOP_ADDR := 0x80000000
-else
-TOP_ADDR := 0xc0000000
-endif
+TOP_ADDR := $(CONFIG_TOP_ADDR)
 
 ifeq ($(CONFIG_MODE_SKAS),y)
   ifneq ($(CONFIG_MODE_TT),y)
Index: 2.6.10/arch/um/kernel/skas/mem.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/mem.c	2005-01-07 22:58:51.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/mem.c	2005-01-09 18:25:36.000000000 -0500
@@ -13,8 +13,13 @@
 	/* Round up to the nearest 4M */
 	unsigned long top = ROUND_4M((unsigned long) &arg);
 
+#ifdef CONFIG_HOST_TASK_SIZE
+	*host_size_out = CONFIG_HOST_TASK_SIZE;
+	*task_size_out = CONFIG_HOST_TASK_SIZE;
+#else
 	*host_size_out = top;
 	*task_size_out = top;
+#endif
 	return(((unsigned long) set_task_sizes_skas) & ~0xffffff);
 }
 

