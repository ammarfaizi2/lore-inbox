Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVEFW6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVEFW6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVEFWzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:55:50 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:43014 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261317AbVEFWyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:54:21 -0400
Message-Id: <200505062249.j46MnZqk010485@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 10/12] UML - S390 preparation, arch_align_stack
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Only x86 and x86_64 use arch_align_stack(), all other subarches
have:
 #define arch_align_stack(x) (x)
So, if this definition is found, UML's own arch_align_stack()
should be skipped.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Index: linux-2.6.11-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/process_kern.c	2005-04-30 13:13:04.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/process_kern.c	2005-04-30 13:20:41.000000000 -0400
@@ -462,12 +462,21 @@
 	return 2;
 }
 
+/*
+ * Only x86 and x86_64 have an arch_align_stack().
+ * All other arches have "#define arch_align_stack(x) (x)"
+ * in their asm/system.h
+ * As this is included in UML from asm-um/system-generic.h,
+ * we can use it to behave as the subarch does.
+ */
+#ifndef arch_align_stack
 unsigned long arch_align_stack(unsigned long sp)
 {
 	if (randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
+#endif
 
 
 /*

