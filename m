Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbRETJ44>; Sun, 20 May 2001 05:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbRETJ4r>; Sun, 20 May 2001 05:56:47 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:17162 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S261508AbRETJ42>;
	Sun, 20 May 2001 05:56:28 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15111.38049.614837.978468@tango.paulus.ozlabs.org>
Date: Sun, 20 May 2001 19:55:45 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: add page argument to copy/clear_user_page
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The patch below adds a page * argument to copy_user_page and
clear_user_page.  These functions are used only in
include/linux/highmem.h to implement clear_user_highpage and
copy_user_highpage.  The idea is to pass in the pointer to the page
struct for the destination page so that, on architectures where it is
needed, we can use the PG_arch_1 bit of page->flags to indicate
whether the i-cache and d-cache are consistent for the page.  With the
extra argument, copy/clear_user_page can set the PG_arch_1 bit to the
"inconsistent" state.  We can then add architecture-specific code to
flush the i-cache when the bit is in the "inconsistent" state and a
user process wants to be able to execute from the page.

Sparc64, ppc and ia64 at least will benefit from this.  Using the
PG_arch_1 bit in this way lets us avoid doing unnecessary i-cache
flushes for the page - on ppc I have measured a 2.5% reduction in time
for a kernel compile by doing this.

David Miller and David Mosberger-Tang agree with this change, in
fact if you look in include/asm-ia64/pgalloc.h you will see that
copy/clear_user_page already have the extra page * argument.

The patch below does nothing more than add the extra argument to all
the definitions of copy_user_page and clear_user_page (for all
architectures), and to the places where they are called.  At this
stage this extra argument will be unused (except on ia64).  Once this
change goes in, the various architecture maintainers who care can send
you the patches which will make use of the extra argument on their
architecture.  We have patches for ppc tested and ready to be
included, and I know DaveM has patches for sparc64.

Please apply this to your tree.

Thanks,
Paul.

diff -urN linux/Documentation/cachetlb.txt linux.new/Documentation/cachetlb.txt
--- linux/Documentation/cachetlb.txt	Sat Mar 31 03:05:54 2001
+++ linux.new/Documentation/cachetlb.txt	Sun May 20 16:44:46 2001
@@ -260,8 +260,9 @@
 
 Here is the new interface:
 
-  void copy_user_page(void *to, void *from, unsigned long address)
-  void clear_user_page(void *to, unsigned long address)
+  void copy_user_page(void *to, void *from, unsigned long address,
+		      struct page *page)
+  void clear_user_page(void *to, unsigned long address, struct page *page)
 
 	These two routines store data in user anonymous or COW
 	pages.  It allows a port to efficiently avoid D-cache alias
@@ -279,6 +280,12 @@
 
 	If D-cache aliasing is not an issue, these two routines may
 	simply call memcpy/memset directly and do nothing more.
+
+	The "page" parameter points to the page struct for the page.
+	This allows a port to store information about the cache status
+	of the page in the page struct (for example, by using the
+	PG_arch_1 bit of the flags field) and update that status to
+	reflect the effect of the clear or copy.
 
   void flush_dcache_page(struct page *page)
 
diff -urN linux/arch/sh/mm/cache.c linux.new/arch/sh/mm/cache.c
--- linux/arch/sh/mm/cache.c	Sat Apr 28 23:02:38 2001
+++ linux.new/arch/sh/mm/cache.c	Sun May 20 16:45:47 2001
@@ -506,14 +506,15 @@
 /* Page is 4K, OC size is 16K, there are four lines. */
 #define CACHE_ALIAS 0x00003000
 
-void clear_user_page(void *to, unsigned long address)
+void clear_user_page(void *to, unsigned long address, struct page *page)
 {
 	clear_page(to);
 	if (((address ^ (unsigned long)to) & CACHE_ALIAS))
 		__flush_page_to_ram(to);
 }
 
-void copy_user_page(void *to, void *from, unsigned long address)
+void copy_user_page(void *to, void *from, unsigned long address,
+		    struct page *page)
 {
 	copy_page(to, from);
 	if (((address ^ (unsigned long)to) & CACHE_ALIAS))
diff -urN linux/include/asm-alpha/page.h linux.new/include/asm-alpha/page.h
--- linux/include/asm-alpha/page.h	Thu Feb 22 14:25:37 2001
+++ linux.new/include/asm-alpha/page.h	Sun May 20 16:50:42 2001
@@ -13,10 +13,10 @@
 #define STRICT_MM_TYPECHECKS
 
 extern void clear_page(void *page);
-#define clear_user_page(page, vaddr)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
 
 extern void copy_page(void * _to, void * _from);
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
diff -urN linux/include/asm-arm/page.h linux.new/include/asm-arm/page.h
--- linux/include/asm-arm/page.h	Mon Aug 14 02:54:15 2000
+++ linux.new/include/asm-arm/page.h	Sun May 20 16:50:41 2001
@@ -14,8 +14,8 @@
 #define clear_page(page)	memzero((void *)(page), PAGE_SIZE)
 extern void copy_page(void *to, void *from);
 
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
diff -urN linux/include/asm-cris/page.h linux.new/include/asm-cris/page.h
--- linux/include/asm-cris/page.h	Thu Feb 22 14:25:38 2001
+++ linux.new/include/asm-cris/page.h	Sun May 20 16:51:17 2001
@@ -14,8 +14,8 @@
 #define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from)      memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
-#define clear_user_page(page, vaddr)    clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)    clear_page(page)
+#define copy_user_page(to, from, vaddr, page) copy_page(to, from)
 
 #define STRICT_MM_TYPECHECKS
 
diff -urN linux/include/asm-i386/page.h linux.new/include/asm-i386/page.h
--- linux/include/asm-i386/page.h	Fri Jan  5 09:50:46 2001
+++ linux.new/include/asm-i386/page.h	Sun May 20 16:50:41 2001
@@ -30,8 +30,8 @@
 
 #endif
 
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-m68k/page.h linux.new/include/asm-m68k/page.h
--- linux/include/asm-m68k/page.h	Tue Nov 28 13:00:49 2000
+++ linux.new/include/asm-m68k/page.h	Sun May 20 16:50:41 2001
@@ -76,8 +76,8 @@
 #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
 #endif
 
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-mips/page.h linux.new/include/asm-mips/page.h
--- linux/include/asm-mips/page.h	Thu Aug 10 06:46:02 2000
+++ linux.new/include/asm-mips/page.h	Sun May 20 16:50:40 2001
@@ -28,8 +28,8 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-mips64/page.h linux.new/include/asm-mips64/page.h
--- linux/include/asm-mips64/page.h	Thu Aug 10 06:46:02 2000
+++ linux.new/include/asm-mips64/page.h	Sun May 20 16:50:40 2001
@@ -28,8 +28,8 @@
 
 #define clear_page(page)	_clear_page(page)
 #define copy_page(to, from)	_copy_page(to, from)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-parisc/page.h linux.new/include/asm-parisc/page.h
--- linux/include/asm-parisc/page.h	Wed Dec  6 07:29:39 2000
+++ linux.new/include/asm-parisc/page.h	Sun May 20 16:51:18 2001
@@ -12,8 +12,8 @@
 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
-#define clear_user_page(page, vaddr) clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
+#define clear_user_page(page, vaddr, pg) clear_page(page)
+#define copy_user_page(to, from, vaddr, page) copy_page(to, from)
 
 /*
  * These are used to make use of C type-checking..
diff -urN linux/include/asm-ppc/page.h linux.new/include/asm-ppc/page.h
--- linux/include/asm-ppc/page.h	Mon Apr  2 02:19:59 2001
+++ linux.new/include/asm-ppc/page.h	Sun May 20 16:50:40 2001
@@ -79,8 +79,8 @@
 
 extern void clear_page(void *page);
 extern void copy_page(void *to, void *from);
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 /* map phys->virtual and virtual->phys for RAM pages */
 static inline unsigned long ___pa(unsigned long v)
diff -urN linux/include/asm-s390/page.h linux.new/include/asm-s390/page.h
--- linux/include/asm-s390/page.h	Sat Apr 28 23:02:54 2001
+++ linux.new/include/asm-s390/page.h	Sun May 20 16:50:39 2001
@@ -59,8 +59,8 @@
 			      : "memory" );
 }
 
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
diff -urN linux/include/asm-s390x/page.h linux.new/include/asm-s390x/page.h
--- linux/include/asm-s390x/page.h	Sat Apr 28 23:02:54 2001
+++ linux.new/include/asm-s390x/page.h	Sun May 20 16:51:17 2001
@@ -57,8 +57,8 @@
 			      : "memory" );
 }
 
-#define clear_user_page(page, vaddr)    clear_page(page)
-#define copy_user_page(to, from, vaddr) copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)      clear_page(page)
+#define copy_user_page(to, from, vaddr, page) copy_page(to, from)
 
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
diff -urN linux/include/asm-sh/page.h linux.new/include/asm-sh/page.h
--- linux/include/asm-sh/page.h	Mon Dec  4 12:48:19 2000
+++ linux.new/include/asm-sh/page.h	Sun May 20 16:50:39 2001
@@ -28,11 +28,13 @@
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
 #if defined(__sh3__)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 #elif defined(__SH4__)
-extern void clear_user_page(void *to, unsigned long address);
-extern void copy_user_page(void *to, void *from, unsigned long address);
+extern void clear_user_page(void *to, unsigned long address,
+			    struct page *page);
+extern void copy_user_page(void *to, void *from, unsigned long address,
+			   struct page *page);
 #endif
 
 /*
diff -urN linux/include/asm-sparc/page.h linux.new/include/asm-sparc/page.h
--- linux/include/asm-sparc/page.h	Tue Oct 31 09:34:12 2000
+++ linux.new/include/asm-sparc/page.h	Sun May 20 16:50:39 2001
@@ -54,8 +54,8 @@
 
 #define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
-#define clear_user_page(page, vaddr)	clear_page(page)
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, page)	copy_page(to, from)
 
 /* The following structure is used to hold the physical
  * memory configuration of the machine.  This is filled in
diff -urN linux/include/asm-sparc64/page.h linux.new/include/asm-sparc64/page.h
--- linux/include/asm-sparc64/page.h	Fri Aug 11 05:43:12 2000
+++ linux.new/include/asm-sparc64/page.h	Sun May 20 16:50:38 2001
@@ -25,8 +25,9 @@
 extern void _copy_page(void *to, void *from);
 #define clear_page(X)	_clear_page((void *)(X))
 #define copy_page(X,Y)	_copy_page((void *)(X), (void *)(Y))
-extern void clear_user_page(void *page, unsigned long vaddr);
-extern void copy_user_page(void *to, void *from, unsigned long vaddr);
+extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
+extern void copy_user_page(void *to, void *from, unsigned long vaddr,
+			   struct page *page);
 
 /* GROSS, defining this makes gcc pass these types as aggregates,
  * and thus on the stack, turn this crap off... -DaveM
diff -urN linux/include/linux/highmem.h linux.new/include/linux/highmem.h
--- linux/include/linux/highmem.h	Mon Apr  2 02:20:15 2001
+++ linux.new/include/linux/highmem.h	Sun May 20 16:50:38 2001
@@ -45,7 +45,7 @@
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 {
-	clear_user_page(kmap(page), vaddr);
+	clear_user_page(kmap(page), vaddr, page);
 	kunmap(page);
 }
 
@@ -87,7 +87,7 @@
 
 	vfrom = kmap(from);
 	vto = kmap(to);
-	copy_user_page(vto, vfrom, vaddr);
+	copy_user_page(vto, vfrom, vaddr, to);
 	kunmap(from);
 	kunmap(to);
 }
