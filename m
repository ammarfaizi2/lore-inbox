Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUKHOv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUKHOv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUKHOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:34:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261846AbUKHOcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:32:54 -0500
Date: Mon, 8 Nov 2004 14:32:41 GMT
Message-Id: <200411081432.iA8EWf0c023426@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] Additional kgdb hooks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a couple of extra hooks by which kgdb or an equivalent
gdbstub can catch bad_page() and panic() invocations.

Signed-Off-By: dhowells@redhat.com
---
diffstat kgdb-hooks-2610rc1mm3.diff
 include/asm-generic/bug.h |    8 ++++++++
 kernel/panic.c            |    1 +
 mm/page_alloc.c           |    1 +
 3 files changed, 10 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-generic/bug.h linux-2.6.10-rc1-mm3-frv/include/asm-generic/bug.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-generic/bug.h	2004-10-19 10:42:12.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-generic/bug.h	2004-11-05 14:13:04.327459964 +0000
@@ -18,6 +18,10 @@
 } while (0)
 #endif
 
+#ifndef HAVE_ARCH_KGDB_BAD_PAGE
+#define kgdb_bad_page(page) do {} while(0)
+#endif
+
 #ifndef HAVE_ARCH_BUG_ON
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #endif
@@ -31,4 +35,8 @@
 } while (0)
 #endif
 
+#ifndef HAVE_ARCH_KGDB_RAISE
+#define kgdb_raise(signr) do {} while(0)
+#endif
+
 #endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/panic.c linux-2.6.10-rc1-mm3-frv/kernel/panic.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/panic.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/kernel/panic.c	2004-11-05 14:13:04.528442988 +0000
@@ -73,6 +73,7 @@ NORET_TYPE void panic(const char * fmt, 
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
+	kgdb_raise(SIGABRT);
 	bust_spinlocks(0);
 
 	/* If we have crashed, perform a kexec reboot, for dump write-out */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/mm/page_alloc.c linux-2.6.10-rc1-mm3-frv/mm/page_alloc.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/page_alloc.c	2004-11-05 13:15:52.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/mm/page_alloc.c	2004-11-05 14:13:04.654432347 +0000
@@ -88,6 +89,7 @@ static void bad_page(const char *functio
 		page->mapping, page_mapcount(page), page_count(page));
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
+	kgdb_bad_page(page);
 	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
 	page->flags &= ~(1 << PG_private	|
 			1 << PG_locked	|
