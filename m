Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316974AbSFQUXt>; Mon, 17 Jun 2002 16:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSFQUXs>; Mon, 17 Jun 2002 16:23:48 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:41373 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316974AbSFQUXp>;
	Mon, 17 Jun 2002 16:23:45 -0400
Subject: [PATCH] 2.5.22: common code changes for s/390.
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2002 00:22:28 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17K4tI-0000JR-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some simple common code changes for s/390:

1) Add __s390__ to the list of architectures that use unsigned int as
   type for rautofs_wqt_t. __s390__ is defined for both 31-bit and 64-bit
   linux for s/390. Both architectures are fine with unsigned int since
   sizeof(unsigned int) == sizeof(unsigned long) for 31 bit s/390.
2) Remove early initialization call ccwcache_init(). It doesn't exists
   anymore.
3) Remove special case for irq_stat. We moved the irq_stat structure out
   of the lowcore.
4) Set LOG_BUF_LEN to 128K for s/390. With cio_msg=yes the common io layer
   is very verbose.
5) Replace acquire_console_sem with down_trylock & return to avoid an
   endless trap loop if console_unblank is called from interrupt context
   and the console semaphore is taken.

blue skies,
  Martin.

diff -urN linux-2.5.22/include/linux/auto_fs.h linux-2.5.22-s390/include/linux/auto_fs.h
--- linux-2.5.22/include/linux/auto_fs.h	Mon Jun 17 04:31:22 2002
+++ linux-2.5.22-s390/include/linux/auto_fs.h	Tue Jun  4 09:52:06 2002
@@ -45,7 +45,8 @@
  * If so, 32-bit user-space code should be backwards compatible.
  */
 
-#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) || defined(__powerpc__)
+#if defined(__sparc__) || defined(__mips__) || defined(__x86_64) \
+ || defined(__powerpc__) || defined(__s390__)
 typedef unsigned int autofs_wqt_t;
 #else
 typedef unsigned long autofs_wqt_t;
diff -urN linux-2.5.22/init/main.c linux-2.5.22-s390/init/main.c
--- linux-2.5.22/init/main.c	Mon Jun 17 04:31:26 2002
+++ linux-2.5.22-s390/init/main.c	Mon Jun 10 11:30:35 2002
@@ -34,7 +34,6 @@
 
 #if defined(CONFIG_ARCH_S390)
 #include <asm/s390mach.h>
-#include <asm/ccwcache.h>
 #endif
 
 #ifdef CONFIG_MTRR
@@ -393,9 +392,6 @@
 	buffer_init();
 	vfs_caches_init(mempages);
 	radix_tree_init();
-#if defined(CONFIG_ARCH_S390)
-	ccwcache_init();
-#endif
 	signals_init();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
diff -urN linux-2.5.22/kernel/ksyms.c linux-2.5.22-s390/kernel/ksyms.c
--- linux-2.5.22/kernel/ksyms.c	Mon Jun 17 04:31:23 2002
+++ linux-2.5.22-s390/kernel/ksyms.c	Mon Jun 17 14:18:29 2002
@@ -388,9 +388,7 @@
 EXPORT_SYMBOL(del_timer);
 EXPORT_SYMBOL(request_irq);
 EXPORT_SYMBOL(free_irq);
-#if !defined(CONFIG_ARCH_S390)
-EXPORT_SYMBOL(irq_stat);	/* No separate irq_stat for s390, it is part of PSA */
-#endif
+EXPORT_SYMBOL(irq_stat);
 
 /* waitqueue handling */
 EXPORT_SYMBOL(add_wait_queue);
diff -urN linux-2.5.22/kernel/printk.c linux-2.5.22-s390/kernel/printk.c
--- linux-2.5.22/kernel/printk.c	Mon Jun 17 04:31:32 2002
+++ linux-2.5.22-s390/kernel/printk.c	Tue Apr 30 18:08:43 2002
@@ -31,6 +31,8 @@
 
 #if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
+#elif defined(CONFIG_ARCH_S390)
+#define LOG_BUF_LEN	(131072)
 #elif defined(CONFIG_SMP)
 #define LOG_BUF_LEN	(32768)
 #else	
@@ -553,7 +555,14 @@
 {
 	struct console *c;
 
-	acquire_console_sem();
+	/*
+	 * Try to get the console semaphore. If someone else owns it
+	 * we have to return without unblanking because console_unblank
+	 * may be called in interrupt context.
+	 */
+	if (down_trylock(&console_sem) != 0)
+		return;
+	console_may_schedule = 0;
 	for (c = console_drivers; c != NULL; c = c->next)
 		if ((c->flags & CON_ENABLED) && c->unblank)
 			c->unblank();
