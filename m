Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030591AbWBNOqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030591AbWBNOqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbWBNOqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:46:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030591AbWBNOqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:46:30 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Miscellaneous fixes
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 14 Feb 2006 14:46:20 +0000
Message-ID: <32620.1139928380@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes various alterations and fixes to the FRV arch:

 (1) Resyncs the FRV system call collection with the i386 arch.

 (2) Discards __iounmap() as it's not used.

 (3) Fixes the use of the SWAP/SWAPI instruction to get the arguments the right
     way around in atomic.h, and also to get the asm constraints correct.

 (4) Moves copy_to/from_user_page() to asm/cacheflush.h to be consistent with
     other archs.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-2616rc2.diff 
 arch/frv/kernel/entry.S      |   26 +++++++++++++++++++++-----
 arch/frv/mm/kmap.c           |    9 ---------
 include/asm-frv/atomic.h     |    6 +++---
 include/asm-frv/cacheflush.h |   12 ++++++++++++
 include/asm-frv/io.h         |    1 -
 include/asm-frv/uaccess.h    |    3 ---
 include/asm-frv/unistd.h     |   28 ++++++++++++++++++++++------
 7 files changed, 58 insertions(+), 27 deletions(-)

diff -uNrp linux-2.6.16-rc2/arch/frv/kernel/entry.S linux-2.6.16-rc2-frv/arch/frv/kernel/entry.S
--- linux-2.6.16-rc2/arch/frv/kernel/entry.S	2006-02-06 15:25:19.000000000 +0000
+++ linux-2.6.16-rc2-frv/arch/frv/kernel/entry.S	2006-02-07 18:37:39.000000000 +0000
@@ -1418,11 +1418,27 @@ sys_call_table:
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
-	.long sys_ni_syscall // sys_vperfctr_open
-	.long sys_ni_syscall // sys_vperfctr_control	/* 290 */
-	.long sys_ni_syscall // sys_vperfctr_unlink
-	.long sys_ni_syscall // sys_vperfctr_iresume
-	.long sys_ni_syscall // sys_vperfctr_read
+	.long sys_ioprio_set
+	.long sys_ioprio_get		/* 290 */
+	.long sys_inotify_init
+	.long sys_inotify_add_watch
+	.long sys_inotify_rm_watch
+	.long sys_migrate_pages
+	.long sys_openat		/* 295 */
+	.long sys_mkdirat
+	.long sys_mknodat
+	.long sys_fchownat
+	.long sys_futimesat
+	.long sys_newfstatat		/* 300 */
+	.long sys_unlinkat
+	.long sys_renameat
+	.long sys_linkat
+	.long sys_symlinkat
+	.long sys_readlinkat		/* 305 */
+	.long sys_fchmodat
+	.long sys_faccessat
+	.long sys_pselect6
+	.long sys_ppoll
 
 
 syscall_table_size = (. - sys_call_table)
diff -uNrp linux-2.6.16-rc2/arch/frv/mm/kmap.c linux-2.6.16-rc2-frv/arch/frv/mm/kmap.c
--- linux-2.6.16-rc2/arch/frv/mm/kmap.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.16-rc2-frv/arch/frv/mm/kmap.c	2006-02-07 20:42:49.000000000 +0000
@@ -44,15 +44,6 @@ void iounmap(void *addr)
 }
 
 /*
- * __iounmap unmaps nearly everything, so be careful
- * it doesn't free currently pointer/page tables anymore but it
- * wans't used anyway and might be added later.
- */
-void __iounmap(void *addr, unsigned long size)
-{
-}
-
-/*
  * Set new cache mode for some kernel address space.
  * The caller must push data for that range itself, if such data may already
  * be in the cache.
diff -uNrp linux-2.6.16-rc2/include/asm-frv/atomic.h linux-2.6.16-rc2-frv/include/asm-frv/atomic.h
--- linux-2.6.16-rc2/include/asm-frv/atomic.h	2006-02-06 15:25:36.000000000 +0000
+++ linux-2.6.16-rc2-frv/include/asm-frv/atomic.h	2006-02-09 15:56:35.000000000 +0000
@@ -220,9 +220,9 @@ extern unsigned long atomic_test_and_XOR
 	switch (sizeof(__xg_orig)) {						\
 	case 4:									\
 		asm volatile(							\
-			"swap%I0 %2,%M0"					\
-			: "+m"(*__xg_ptr), "=&r"(__xg_orig)			\
-			: "r"(x)						\
+			"swap%I0 %M0,%1"					\
+			: "+m"(*__xg_ptr), "=r"(__xg_orig)			\
+			: "1"(x)						\
 			: "memory"						\
 			);							\
 		break;								\
diff -uNrp linux-2.6.16-rc2/include/asm-frv/cacheflush.h linux-2.6.16-rc2-frv/include/asm-frv/cacheflush.h
--- linux-2.6.16-rc2/include/asm-frv/cacheflush.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.16-rc2-frv/include/asm-frv/cacheflush.h	2006-02-07 17:05:26.000000000 +0000
@@ -87,5 +87,17 @@ static inline void flush_icache_page(str
 	flush_icache_user_range(vma, page, page_to_phys(page), PAGE_SIZE);
 }
 
+/*
+ * permit ptrace to access another process's address space through the icache
+ * and the dcache
+ */
+#define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
+do {								\
+	memcpy((dst), (src), (len));				\
+	flush_icache_user_range((vma), (page), (vaddr), (len));	\
+} while(0)
+
+#define copy_from_user_page(vma, page, vaddr, dst, src, len)	\
+	memcpy((dst), (src), (len))
 
 #endif /* _ASM_CACHEFLUSH_H */
diff -uNrp linux-2.6.16-rc2/include/asm-frv/io.h linux-2.6.16-rc2-frv/include/asm-frv/io.h
--- linux-2.6.16-rc2/include/asm-frv/io.h	2006-02-06 15:25:36.000000000 +0000
+++ linux-2.6.16-rc2-frv/include/asm-frv/io.h	2006-02-07 20:43:12.000000000 +0000
@@ -251,7 +251,6 @@ static inline void writel(uint32_t datum
 #define IOMAP_WRITETHROUGH		3
 
 extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size, int cacheflag);
-extern void __iounmap(void __iomem *addr, unsigned long size);
 
 static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
 {
diff -uNrp linux-2.6.16-rc2/include/asm-frv/uaccess.h linux-2.6.16-rc2-frv/include/asm-frv/uaccess.h
--- linux-2.6.16-rc2/include/asm-frv/uaccess.h	2006-02-06 15:25:36.000000000 +0000
+++ linux-2.6.16-rc2-frv/include/asm-frv/uaccess.h	2006-02-07 17:02:43.000000000 +0000
@@ -306,7 +306,4 @@ extern long strnlen_user(const char *src
 
 extern unsigned long search_exception_table(unsigned long addr);
 
-#define copy_to_user_page(vma, page, vaddr, dst, src, len)	memcpy(dst, src, len)
-#define copy_from_user_page(vma, page, vaddr, dst, src, len)	memcpy(dst, src, len)
-
 #endif /* _ASM_UACCESS_H */
diff -uNrp linux-2.6.16-rc2/include/asm-frv/unistd.h linux-2.6.16-rc2-frv/include/asm-frv/unistd.h
--- linux-2.6.16-rc2/include/asm-frv/unistd.h	2006-02-06 15:25:36.000000000 +0000
+++ linux-2.6.16-rc2-frv/include/asm-frv/unistd.h	2006-02-07 18:35:08.000000000 +0000
@@ -295,13 +295,29 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
-#define __NR_vperfctr_open	289
-#define __NR_vperfctr_control	(__NR_perfctr_info+1)
-#define __NR_vperfctr_unlink	(__NR_perfctr_info+2)
-#define __NR_vperfctr_iresume	(__NR_perfctr_info+3)
-#define __NR_vperfctr_read	(__NR_perfctr_info+4)
+#define __NR_ioprio_set		289
+#define __NR_ioprio_get		290
+#define __NR_inotify_init	291
+#define __NR_inotify_add_watch	292
+#define __NR_inotify_rm_watch	293
+#define __NR_migrate_pages	294
+#define __NR_openat		295
+#define __NR_mkdirat		296
+#define __NR_mknodat		297
+#define __NR_fchownat		298
+#define __NR_futimesat		299
+#define __NR_newfstatat		300
+#define __NR_unlinkat		301
+#define __NR_renameat		302
+#define __NR_linkat		303
+#define __NR_symlinkat		304
+#define __NR_readlinkat		305
+#define __NR_fchmodat		306
+#define __NR_faccessat		307
+#define __NR_pselect6		308
+#define __NR_ppoll		309
 
-#define NR_syscalls 294
+#define NR_syscalls 310
 
 /*
  * process the return value of a syscall, consigning it to one of two possible fates
