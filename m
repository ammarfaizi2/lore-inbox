Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTE2BsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 21:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTE2Br7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 21:47:59 -0400
Received: from dp.samba.org ([66.70.73.150]:62128 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261827AbTE2Brt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 21:47:49 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16085.27084.581954.762132@argo.ozlabs.ibm.com>
Date: Thu, 29 May 2003 12:00:44 +1000
To: torvalds@transmeta.com
Cc: davem@redhat.com, rth@twiddle.net, rmk@arm.linux.org.uk, bjorn@axis.com,
       jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx,
       gniibe@rr.iij4u.or.jp, jdike@karaya.com, uclinux-v850@lsi.nec.co.jp,
       davidm@hpl.hp.com, anton@samba.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Proposed patch to kernel.h
In-Reply-To: <16083.60374.284044.751867@nanango.paulus.ozlabs.org>
References: <16083.60374.284044.751867@nanango.paulus.ozlabs.org>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On second thoughts, it would be cleaner to move BUG_ON() into each
architecture's bug.h alongside BUG() and PAGE_BUG(), rather than using
an ifdef in kernel.h as my previous patch did.

This patch moves the definition of BUG_ON from include/linux/kernel.h
into include/asm-*/bug.h so that I can use a conditional-trap
instruction to implement BUG_ON on PowerPC.

Architecture maintainers, this should be completely benign.  An ack
would still be appreciated, though.  If this will let you improve your
BUG_ON too, please let me know.

Thanks,
Paul.

diff -urN linux-2.5/include/asm-alpha/bug.h pmac-2.5/include/asm-alpha/bug.h
--- linux-2.5/include/asm-alpha/bug.h	2002-02-25 03:51:44.000000000 +1100
+++ pmac-2.5/include/asm-alpha/bug.h	2003-05-28 18:33:23.000000000 +1000
@@ -9,6 +9,8 @@
   __asm__ __volatile__("call_pal %0  # bugchk\n\t"".long %1\n\t.8byte %2" \
 		       : : "i" (PAL_bugchk), "i"(__LINE__), "i"(__FILE__))
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #define PAGE_BUG(page)	BUG()
 
 #endif
diff -urN linux-2.5/include/asm-arm/bug.h pmac-2.5/include/asm-arm/bug.h
--- linux-2.5/include/asm-arm/bug.h	2003-02-02 04:15:11.000000000 +1100
+++ pmac-2.5/include/asm-arm/bug.h	2003-05-28 18:33:35.000000000 +1000
@@ -18,4 +18,6 @@
 
 #endif
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #endif
diff -urN linux-2.5/include/asm-cris/bug.h pmac-2.5/include/asm-cris/bug.h
--- linux-2.5/include/asm-cris/bug.h	2002-01-06 22:46:09.000000000 +1100
+++ pmac-2.5/include/asm-cris/bug.h	2003-05-28 18:33:44.000000000 +1000
@@ -9,4 +9,6 @@
          BUG(); \
 } while (0)
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #endif
diff -urN linux-2.5/include/asm-h8300/bug.h pmac-2.5/include/asm-h8300/bug.h
--- linux-2.5/include/asm-h8300/bug.h	2003-04-18 05:31:21.000000000 +1000
+++ pmac-2.5/include/asm-h8300/bug.h	2003-05-28 18:34:07.000000000 +1000
@@ -9,4 +9,6 @@
          BUG(); \
 } while (0)
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #endif
diff -urN linux-2.5/include/asm-i386/bug.h pmac-2.5/include/asm-i386/bug.h
--- linux-2.5/include/asm-i386/bug.h	2003-02-17 10:52:20.000000000 +1100
+++ pmac-2.5/include/asm-i386/bug.h	2003-05-28 18:34:35.000000000 +1000
@@ -19,6 +19,8 @@
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-ia64/bug.h pmac-2.5/include/asm-ia64/bug.h
--- linux-2.5/include/asm-ia64/bug.h	2002-01-06 22:57:28.000000000 +1100
+++ pmac-2.5/include/asm-ia64/bug.h	2003-05-28 18:34:51.000000000 +1000
@@ -7,6 +7,7 @@
 # define ia64_abort()	(*(volatile int *) 0 = 0)
 #endif
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
 #endif
diff -urN linux-2.5/include/asm-m68k/bug.h pmac-2.5/include/asm-m68k/bug.h
--- linux-2.5/include/asm-m68k/bug.h	2002-07-26 06:17:16.000000000 +1000
+++ pmac-2.5/include/asm-m68k/bug.h	2003-05-28 18:35:34.000000000 +1000
@@ -21,6 +21,11 @@
 } while (0)
 #endif
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-m68knommu/bug.h pmac-2.5/include/asm-m68knommu/bug.h
--- linux-2.5/include/asm-m68knommu/bug.h	2003-01-15 22:04:34.000000000 +1100
+++ pmac-2.5/include/asm-m68knommu/bug.h	2003-05-28 18:35:54.000000000 +1000
@@ -5,6 +5,11 @@
   printk("%s(%d): kernel BUG!\n", __FILE__, __LINE__); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
          BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-mips/bug.h pmac-2.5/include/asm-mips/bug.h
--- linux-2.5/include/asm-mips/bug.h	2002-01-06 22:57:49.000000000 +1100
+++ pmac-2.5/include/asm-mips/bug.h	2003-05-28 18:36:16.000000000 +1000
@@ -3,6 +3,7 @@
 #define __ASM_BUG_H
 
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define PAGE_BUG(page) do {  BUG(); } while (0)
 
 #endif
diff -urN linux-2.5/include/asm-mips64/bug.h pmac-2.5/include/asm-mips64/bug.h
--- linux-2.5/include/asm-mips64/bug.h	2002-01-06 22:51:12.000000000 +1100
+++ pmac-2.5/include/asm-mips64/bug.h	2003-05-28 18:36:23.000000000 +1000
@@ -2,6 +2,7 @@
 #define _ASM_BUG_H
 
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define PAGE_BUG(page) do {  BUG(); } while (0)
 
 #endif
diff -urN linux-2.5/include/asm-parisc/bug.h pmac-2.5/include/asm-parisc/bug.h
--- linux-2.5/include/asm-parisc/bug.h	2003-03-18 04:58:50.000000000 +1100
+++ pmac-2.5/include/asm-parisc/bug.h	2003-05-28 18:36:42.000000000 +1000
@@ -10,6 +10,11 @@
 	dump_stack(); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-ppc/bug.h pmac-2.5/include/asm-ppc/bug.h
--- linux-2.5/include/asm-ppc/bug.h	2003-05-26 22:18:59.000000000 +1000
+++ pmac-2.5/include/asm-ppc/bug.h	2003-05-27 11:24:03.000000000 +1000
@@ -1,9 +1,28 @@
 #ifndef _PPC_BUG_H
 #define _PPC_BUG_H
 
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__asm__ __volatile__(".long 0x0"); \
+struct bug_entry {
+	unsigned long	bug_addr;
+	int		line;
+	const char	*file;
+};
+
+#define BUG() do {					\
+	__asm__ __volatile__(				\
+		"1:	twi 31,0,0\n"			\
+		".section __bug_table,\"a\"\n\t"	\
+		"	.long 1b,%0,%1\n"		\
+		".previous"				\
+		: : "i" (__LINE__), "i" (__FILE__));	\
+} while (0)
+
+#define BUG_ON(x) do {						\
+	__asm__ __volatile__(					\
+		"1:	twnei %0,0\n"				\
+		".section __bug_table,\"a\"\n\t"		\
+		"	.long 1b,%1,%2\n"			\
+		".previous"					\
+		: : "r" (x), "i" (__LINE__), "i" (__FILE__));	\
 } while (0)
 
 #define PAGE_BUG(page) do { BUG(); } while (0)
diff -urN linux-2.5/include/asm-ppc64/bug.h pmac-2.5/include/asm-ppc64/bug.h
--- linux-2.5/include/asm-ppc64/bug.h	2003-01-15 20:38:42.000000000 +1100
+++ pmac-2.5/include/asm-ppc64/bug.h	2003-05-28 18:36:55.000000000 +1000
@@ -27,6 +27,8 @@
 } while (0)
 #endif
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
 #endif
diff -urN linux-2.5/include/asm-s390/bug.h pmac-2.5/include/asm-s390/bug.h
--- linux-2.5/include/asm-s390/bug.h	2002-01-06 22:53:36.000000000 +1100
+++ pmac-2.5/include/asm-s390/bug.h	2003-05-28 18:37:12.000000000 +1000
@@ -6,6 +6,11 @@
         __asm__ __volatile__(".long 0"); \
 } while (0)                                       
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
         BUG(); \
 } while (0)                      
diff -urN linux-2.5/include/asm-sh/bug.h pmac-2.5/include/asm-sh/bug.h
--- linux-2.5/include/asm-sh/bug.h	2002-01-06 22:54:51.000000000 +1100
+++ pmac-2.5/include/asm-sh/bug.h	2003-05-28 18:37:24.000000000 +1000
@@ -9,6 +9,11 @@
 	asm volatile("nop"); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-sparc/bug.h pmac-2.5/include/asm-sparc/bug.h
--- linux-2.5/include/asm-sparc/bug.h	2003-05-21 08:27:25.000000000 +1000
+++ pmac-2.5/include/asm-sparc/bug.h	2003-05-28 18:37:37.000000000 +1000
@@ -12,6 +12,11 @@
 #define BUG()		__builtin_trap()
 #endif
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-sparc64/bug.h pmac-2.5/include/asm-sparc64/bug.h
--- linux-2.5/include/asm-sparc64/bug.h	2003-01-15 00:51:44.000000000 +1100
+++ pmac-2.5/include/asm-sparc64/bug.h	2003-05-28 18:37:44.000000000 +1000
@@ -13,6 +13,11 @@
 #define BUG()		__builtin_trap()
 #endif
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-um/bug.h pmac-2.5/include/asm-um/bug.h
--- linux-2.5/include/asm-um/bug.h	2003-01-17 02:42:26.000000000 +1100
+++ pmac-2.5/include/asm-um/bug.h	2003-05-28 18:37:56.000000000 +1000
@@ -7,6 +7,11 @@
 	panic("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
diff -urN linux-2.5/include/asm-v850/bug.h pmac-2.5/include/asm-v850/bug.h
--- linux-2.5/include/asm-v850/bug.h	2003-02-18 13:41:09.000000000 +1100
+++ pmac-2.5/include/asm-v850/bug.h	2003-05-28 18:38:18.000000000 +1000
@@ -18,4 +18,6 @@
 #define BUG()		__bug()
 #define PAGE_BUG(page)	__bug()
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #endif /* __V850_BUG_H__ */
diff -urN linux-2.5/include/asm-x86_64/bug.h pmac-2.5/include/asm-x86_64/bug.h
--- linux-2.5/include/asm-x86_64/bug.h	2003-01-17 06:36:26.000000000 +1100
+++ pmac-2.5/include/asm-x86_64/bug.h	2003-05-28 18:38:32.000000000 +1000
@@ -18,6 +18,7 @@
 #define BUG() \
 	asm volatile("ud2 ; .quad %c1 ; .short %c0" :: \
 		     "i"(__LINE__), "i" (__stringify(KBUILD_BASENAME)))
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define PAGE_BUG(page) BUG()
 void out_of_line_bug(void);
 
diff -urN linux-2.5/include/linux/kernel.h pmac-2.5/include/linux/kernel.h
--- linux-2.5/include/linux/kernel.h	2003-05-21 08:27:25.000000000 +1000
+++ pmac-2.5/include/linux/kernel.h	2003-05-28 18:32:37.000000000 +1000
@@ -228,7 +228,6 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
-#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define WARN_ON(condition) do { \
 	if (unlikely((condition)!=0)) { \
 		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
