Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314153AbSDLWcl>; Fri, 12 Apr 2002 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314154AbSDLWck>; Fri, 12 Apr 2002 18:32:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38119 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S314153AbSDLWcj>; Fri, 12 Apr 2002 18:32:39 -0400
Date: Fri, 12 Apr 2002 23:35:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] highmem bugchecks
In-Reply-To: <Pine.LNX.4.21.0204122320110.1012-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0204122332350.1020-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kmap interrupt bug checks in asm/highmem.h inlines are just a waste
of space (unless you're unwisely trying to test highmem without highmem
or highmem emulation).  They should be done in the one place they matter,
within kmap_high and kunmap_high themselves.

So removed interrupt.h from asm/highmem.h, but added it to skbuff.h
if CONFIG_HIGHMEM.  Also removed init.h from asm/highmem.h, except
in the sparc case where kmap_init is called from a different source.

[I missed linux-kernel from posting a moment ago]

Hugh

--- 1906/include/asm-i386/highmem.h	Wed Apr 10 15:09:58 2002
+++ 1906H/include/asm-i386/highmem.h	Fri Apr 12 22:39:36 2002
@@ -21,8 +21,6 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
@@ -39,8 +37,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
@@ -61,8 +57,6 @@
 
 static inline void *kmap(struct page *page)
 {
-	if (in_interrupt())
-		out_of_line_bug();
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -70,8 +64,6 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		out_of_line_bug();
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
--- 1906/include/asm-mips/highmem.h	Mon Apr  8 12:38:21 2002
+++ 1906H/include/asm-mips/highmem.h	Fri Apr 12 22:39:36 2002
@@ -21,8 +21,6 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
@@ -52,8 +50,6 @@
 
 static inline void *kmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -61,8 +57,6 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
--- 1906/include/asm-ppc/highmem.h	Mon Jul  2 22:34:57 2001
+++ 1906H/include/asm-ppc/highmem.h	Fri Apr 12 22:39:36 2002
@@ -25,8 +25,6 @@
 
 #ifdef __KERNEL__
 
-#include <linux/init.h>
-#include <linux/interrupt.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
 
@@ -37,8 +35,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
@@ -57,8 +53,6 @@
 
 static inline void *kmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -66,8 +60,6 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
--- 1906/include/asm-sparc/highmem.h	Wed Oct 17 22:16:39 2001
+++ 1906H/include/asm-sparc/highmem.h	Fri Apr 12 22:39:36 2002
@@ -21,7 +21,6 @@
 #ifdef __KERNEL__
 
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <asm/vaddrs.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable.h>
@@ -54,8 +53,6 @@
 
 static inline void *kmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -63,8 +60,6 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
--- 1906/include/linux/skbuff.h	Wed Apr 10 15:10:08 2002
+++ 1906H/include/linux/skbuff.h	Fri Apr 12 22:39:57 2002
@@ -25,6 +25,9 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#ifdef CONFIG_HIGHMEM
+#include <linux/interrupt.h>
+#endif
 
 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */
--- 1906/mm/highmem.c	Fri Dec 21 17:42:05 2001
+++ 1906H/mm/highmem.c	Fri Apr 12 22:39:36 2002
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/interrupt.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
 
@@ -135,6 +136,9 @@
 	 *
 	 * We cannot call this from interrupts, as it may block
 	 */
+	if (in_interrupt())
+		BUG();
+
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;
 	if (!vaddr)
@@ -151,6 +155,9 @@
 	unsigned long vaddr;
 	unsigned long nr;
 	int need_wakeup;
+
+	if (in_interrupt())
+		BUG();
 
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;

