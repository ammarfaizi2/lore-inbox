Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVAJFmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVAJFmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVAJFlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:41:02 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:24324
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262101AbVAJFO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:26 -0500
Message-Id: <200501100735.j0A7ZmPW005805@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, bstroesser@fujitsu-siemens.com
Subject: [PATCH 15/28] UML - Use va_copy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

In arch/um/kernel/skas/uaccess.c, the simple assignment
   va_list args = *((va_list *) arg_ptr);
is used in do_buffer_op() to obtain a copy of a va_list, that
was delivered as a pointer only.
But this construction doesn't compile on s390. Instead,
va_copy() and va_end() should be used (see "man va_start").

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/skas/uaccess.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/uaccess.c	2005-01-03 12:56:15.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/uaccess.c	2005-01-03 12:57:59.000000000 -0500
@@ -54,15 +54,23 @@
 
 static void do_buffer_op(void *jmpbuf, void *arg_ptr)
 {
-	va_list args = *((va_list *) arg_ptr);
-	unsigned long addr = va_arg(args, unsigned long);
-	int len = va_arg(args, int);
-	int is_write = va_arg(args, int);
-	int (*op)(unsigned long, int, void *) = va_arg(args, void *);
-	void *arg = va_arg(args, void *);
-	int *res = va_arg(args, int *);
-	int size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);
-	int remain = len, n;
+	va_list args;
+	unsigned long addr;
+	int len, is_write, size, remain, n;
+	int (*op)(unsigned long, int, void *);
+	void *arg;
+	int *res;
+
+	va_copy(args, *(va_list *)arg_ptr);
+	addr = va_arg(args, unsigned long);
+	len = va_arg(args, int);
+	is_write = va_arg(args, int);
+	op = va_arg(args, void *);
+	arg = va_arg(args, void *);
+	res = va_arg(args, int *);
+	va_end(args);
+	size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);
+	remain = len;
 
 	current->thread.fault_catcher = jmpbuf;
 	n = do_op(addr, size, is_write, op, arg);

