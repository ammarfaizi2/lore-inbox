Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264890AbSLII4O>; Mon, 9 Dec 2002 03:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSLIIz5>; Mon, 9 Dec 2002 03:55:57 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:16111 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264733AbSLIIyo>; Mon, 9 Dec 2002 03:54:44 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [v850]  Make uClinux flat-executable stack format backward-compatible on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021209090213.0B884370C@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  9 Dec 2002 18:02:13 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the choice of whether or not explicit argv/envp pointers are
placed on the stack for flat-format executables, selectable on a
per-architecture basis.  The v850 expects them _not_ to be (for
accidental historical reasons) and changing it breaks existing flat
executables.

[A simple `#ifndef CONFIG_V850' would work too, of course; it's done
this way to make the LKML people happy by avoiding #ifdef madness.]

-Miles


diff -ruN -X../cludes ../orig/linux-2.5.50/fs/binfmt_flat.c fs/binfmt_flat.c
--- ../orig/linux-2.5.50/fs/binfmt_flat.c	2002-11-05 11:25:27.000000000 +0900
+++ fs/binfmt_flat.c	2002-12-02 14:07:50.000000000 +0900
@@ -80,8 +80,10 @@
 	envp = sp;
 	sp -= argc+1;
 	argv = sp;
-	put_user((unsigned long) envp, --sp);
-	put_user((unsigned long) argv, --sp);
+	if (flat_argvp_envp_on_stack()) {
+		put_user((unsigned long) envp, --sp);
+		put_user((unsigned long) argv, --sp);
+	}
 	put_user(argc,--sp);
 	current->mm->arg_start = (unsigned long) p;
 	while (argc-->0) {
diff -ruN -X../cludes ../orig/linux-2.5.50/include/linux/flat.h include/linux/flat.h
--- ../orig/linux-2.5.50/include/linux/flat.h	2002-11-11 13:04:48.000000000 +0900
+++ include/linux/flat.h	2002-12-02 13:55:17.000000000 +0900
@@ -10,6 +10,8 @@
 #ifndef _LINUX_FLAT_H
 #define _LINUX_FLAT_H
 
+#include <asm/flat.h>
+
 #define	FLAT_VERSION			0x00000004L
 
 /*
diff -ruN -X../cludes ../orig/linux-2.5.50/include/asm-v850/flat.h include/asm-v850/flat.h
--- ../orig/linux-2.5.50/include/asm-v850/flat.h	1970-01-01 09:00:00.000000000 +0900
+++ include/asm-v850/flat.h	2002-12-02 14:07:25.000000000 +0900
@@ -0,0 +1,19 @@
+/*
+ * include/asm-v850/flat.h -- uClinux flat-format executables
+ *
+ *  Copyright (C) 2002  NEC Corporation
+ *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_FLAT_H__
+#define __V850_FLAT_H__
+
+#define flat_argvp_envp_on_stack()	0
+
+#endif /* __V850_FLAT_H__ */
diff -ruN -X../cludes ../orig/linux-2.5.50/include/asm-m68knommu/flat.h include/asm-m68knommu/flat.h
--- ../orig/linux-2.5.50/include/asm-m68knommu/flat.h	1970-01-01 09:00:00.000000000 +0900
+++ include/asm-m68knommu/flat.h	2002-12-02 14:07:31.000000000 +0900
@@ -0,0 +1,10 @@
+/*
+ * include/asm-v850/flat.h -- uClinux flat-format executables
+ */
+
+#ifndef __M68KNOMMU_FLAT_H__
+#define __M68KNOMMU_FLAT_H__
+
+#define flat_argvp_envp_on_stack()	1
+
+#endif /* __M68KNOMMU_FLAT_H__ */
