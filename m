Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267964AbTBSDgF>; Tue, 18 Feb 2003 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTBSDfA>; Tue, 18 Feb 2003 22:35:00 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:21477 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267942AbTBSDeg>; Tue, 18 Feb 2003 22:34:36 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Add a v850 config option to pass illegal insn traps to the kernel
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030219034427.608A537BE@mcspd15.ucom.lsi.nec.co.jp>
Date: Wed, 19 Feb 2003 12:44:27 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the v850 RTE-MA1-CB-MULTI platform, these are normally intercepted by
the monitor for the use of an external debugger, but if you want to use
a linux-resident debugger, the kernel has to see them.

diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/Kconfig linux-2.5.62-uc0/arch/v850/Kconfig
--- linux-2.5.62-uc0.orig/arch/v850/Kconfig	2003-02-12 11:26:18.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/Kconfig	2003-02-19 11:40:02.000000000 +0900
@@ -133,6 +133,11 @@
 	  depends RTE_CB
 	  default y
 
+   config RTE_CB_MULTI_DBTRAP
+   	  bool "Pass illegal insn trap / dbtrap to kernel"
+	  depends RTE_CB_MULTI
+	  default n
+
    config RTE_CB_MA1_KSRAM
    	  bool "Kernel in SRAM (limits size of kernel)"
 	  depends RTE_CB_MA1 && RTE_CB_MULTI
diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/rte_cb_multi.c linux-2.5.62-uc0/arch/v850/kernel/rte_cb_multi.c
--- linux-2.5.62-uc0.orig/arch/v850/kernel/rte_cb_multi.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/rte_cb_multi.c	2003-02-19 11:41:13.000000000 +0900
@@ -2,8 +2,8 @@
  * include/asm-v850/rte_multi.c -- Support for Multi debugger monitor ROM
  * 	on Midas lab RTE-CB series of evaluation boards
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -23,6 +23,9 @@
    the table.  */
 static long multi_intv_install_table[] = {
 	0x40, 0x50,		/* trap vectors */
+#ifdef CONFIG_RTE_CB_MULTI_DBTRAP
+	0x60,			/* illegal insn / dbtrap */
+#endif
 	/* Note -- illegal insn trap is used by the debugger.  */
 	0xD0, 0xE0, 0xF0,	/* GINT1 - GINT3 */
 	0x240, 0x250, 0x260, 0x270, /* timer D interrupts */
