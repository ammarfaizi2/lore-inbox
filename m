Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271634AbTGQXni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271635AbTGQXni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:43:38 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:56467 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271634AbTGQXnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:43:37 -0400
Subject: [patch] shrink thread_struct
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com
Content-Type: text/plain
Organization: 
Message-Id: <1058485773.733.32.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jul 2003 19:49:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thread_struct was bloated due to padding.
I kept the alignment and may have improved the
cache behavior even, with the FPU stuff now
generally starting on a cache line.
(found with -Wpadded)

diff -Naurd old/include/asm-i386/processor.h new/include/asm-i386/processor.h
--- old/include/asm-i386/processor.h	2003-06-26 17:50:47.000000000 -0400
+++ new/include/asm-i386/processor.h	2003-07-17 18:10:33.000000000 -0400
@@ -335,9 +335,9 @@
 	long	foo;
 	long	fos;
 	long	st_space[20];	/* 8*10 bytes for each FP-reg = 80 bytes */
-	unsigned char	ftop, changed, lookahead, no_update, rm, alimit;
 	struct info	*info;
 	unsigned long	entry_eip;
+	unsigned char	ftop, changed, lookahead, no_update, rm, alimit;
 };
 
 union i387_union {
@@ -393,19 +393,20 @@
 	unsigned long	esp;
 	unsigned long	fs;
 	unsigned long	gs;
+/* IO permissions */
+	unsigned long	*ts_io_bitmap;
 /* Hardware debugging registers */
 	unsigned long	debugreg[8];  /* %%db0-7 debug registers */
 /* fault info */
 	unsigned long	cr2, trap_no, error_code;
+/* virtual 86 mode info part #1, to pad (and cache-align) i387_union */
+	unsigned long		screen_bitmap;
 /* floating point info */
 	union i387_union	i387;
-/* virtual 86 mode info */
+/* virtual 86 mode info part #2 */
 	struct vm86_struct __user * vm86_info;
-	unsigned long		screen_bitmap;
 	unsigned long		v86flags, v86mask, saved_esp0;
 	unsigned int		saved_fs, saved_gs;
-/* IO permissions */
-	unsigned long	*ts_io_bitmap;
 };
 
 #define INIT_THREAD  {							\



