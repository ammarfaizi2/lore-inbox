Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269202AbRHBXA0>; Thu, 2 Aug 2001 19:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269213AbRHBXAQ>; Thu, 2 Aug 2001 19:00:16 -0400
Received: from jalon.able.es ([212.97.163.2]:19873 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S269202AbRHBW77>;
	Thu, 2 Aug 2001 18:59:59 -0400
Date: Fri, 3 Aug 2001 01:05:49 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <laughing@shared-source.org>
Subject: more extern -> inline for gcc3
Message-ID: <20010803010549.A2210@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Just building 2.4.7-ac3 with gcc-3.0.1 snapshot from mandrake. Found another couple
of extern __inline__ -> static __inline__ changes needed (oh, it is only x86, I think
other archs will need the same):

--- linux-2.4.7-ac3/include/asm-i386/pgalloc.h.orig	Fri Aug  3 00:56:20 2001
+++ linux-2.4.7-ac3/include/asm-i386/pgalloc.h	Fri Aug  3 00:52:58 2001
@@ -29,7 +29,7 @@
 
 extern void init_pae_pgd_cache(void);
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static inline pgd_t *get_pgd_slow(void)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, GFP_KERNEL);
@@ -54,7 +54,7 @@
 
 #else
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static inline pgd_t *get_pgd_slow(void)
 {
 	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 
@@ -67,7 +67,7 @@
 
 #endif
 
-extern __inline__ pgd_t *get_pgd_fast(void)
+static inline pgd_t *get_pgd_fast(void)
 {
 	unsigned long *ret;
 
@@ -80,14 +80,14 @@
 	return (pgd_t *)ret;
 }
 
-extern __inline__ void free_pgd_fast(pgd_t *pgd)
+static inline void free_pgd_fast(pgd_t *pgd)
 {
 	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
 	pgd_quicklist = (unsigned long *) pgd;
 	pgtable_cache_size++;
 }
 
-extern __inline__ void free_pgd_slow(pgd_t *pgd)
+static inline void free_pgd_slow(pgd_t *pgd)
 {
 #if CONFIG_X86_PAE
 	int i;
@@ -122,14 +122,14 @@
 	return (pte_t *)ret;
 }
 
-extern __inline__ void pte_free_fast(pte_t *pte)
+static inline void pte_free_fast(pte_t *pte)
 {
 	*(unsigned long *)pte = (unsigned long) pte_quicklist;
 	pte_quicklist = (unsigned long *) pte;
 	pgtable_cache_size++;
 }
 
-extern __inline__ void pte_free_slow(pte_t *pte)
+static inline void pte_free_slow(pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
--- linux-2.4.7-ac3/include/asm-i386/siginfo.h.orig	Fri Aug  3 00:53:41 2001
+++ linux-2.4.7-ac3/include/asm-i386/siginfo.h	Fri Aug  3 00:53:51 2001
@@ -216,7 +216,7 @@
 #ifdef __KERNEL__
 #include <linux/string.h>
 
-extern inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
+static inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
 {
 	if (from->si_code < 0)
 		memcpy(to, from, sizeof(siginfo_t));

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7-ac3 #1 SMP Mon Jul 30 16:39:36 CEST 2001 i686
