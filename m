Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbUK1D41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUK1D41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 22:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUK1D40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 22:56:26 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:16069 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261397AbUK1Dzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 22:55:46 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: [patch 3/3] kallsyms: gate page is part of the kernel, honour CONFIG_KALLSYMS_ALL
In-reply-to: Your message of "Sun, 28 Nov 2004 14:38:47 +1100."
             <28912.1101613127@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Nov 2004 14:55:39 +1100
Message-ID: <19476.1101614139@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Treat the gate page as part of the kernel, to improve kernel backtraces.

* Honour CONFIG_KALLSYMS_ALL, all symbols are valid, not just text.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.10-rc2-bk11/kernel/kallsyms.c
===================================================================
--- 2.6.10-rc2-bk11.orig/kernel/kallsyms.c	2004-11-15 14:26:49.080865854 +1100
+++ 2.6.10-rc2-bk11/kernel/kallsyms.c	2004-11-28 14:42:23.755352067 +1100
@@ -18,6 +18,13 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/mm.h>
+
+#ifdef CONFIG_KALLSYMS_ALL
+#define all_var 1
+#else
+#define all_var 0
+#endif
 
 /* These will be re-linked against their real values during the second link stage */
 extern unsigned long kallsyms_addresses[] __attribute__((weak));
@@ -30,7 +37,7 @@ extern u16 kallsyms_token_index[] __attr
 extern unsigned long kallsyms_markers[] __attribute__((weak));
 
 /* Defined by the linker script. */
-extern char _stext[], _etext[], _sinittext[], _einittext[];
+extern char _stext[], _etext[], _sinittext[], _einittext[], _end[];
 
 static inline int is_kernel_inittext(unsigned long addr)
 {
@@ -44,7 +51,7 @@ static inline int is_kernel_text(unsigne
 {
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext)
 		return 1;
-	return 0;
+	return in_gate_area_no_task(addr);
 }
 
 /* expand a compressed symbol data into the resulting uncompressed string,
@@ -147,7 +154,7 @@ const char *kallsyms_lookup(unsigned lon
 	namebuf[KSYM_NAME_LEN] = 0;
 	namebuf[0] = 0;
 
-	if (is_kernel_text(addr) || is_kernel_inittext(addr)) {
+	if (all_var || is_kernel_text(addr) || is_kernel_inittext(addr)) {
 		unsigned long symbol_end=0;
 
 		/* do a binary search on the sorted kallsyms_addresses array */
@@ -181,7 +188,7 @@ const char *kallsyms_lookup(unsigned lon
 			if (is_kernel_inittext(addr))
 				symbol_end = (unsigned long)_einittext;
 			else
-				symbol_end = (unsigned long)_etext;
+				symbol_end = all_var ? (unsigned long)_end : (unsigned long)_etext;
 		}
 
 		*symbolsize = symbol_end - kallsyms_addresses[low];

