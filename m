Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290722AbSAYTfg>; Fri, 25 Jan 2002 14:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290804AbSAYTf0>; Fri, 25 Jan 2002 14:35:26 -0500
Received: from [217.9.226.246] ([217.9.226.246]:15744 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S290722AbSAYTfL>; Fri, 25 Jan 2002 14:35:11 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 64-bit divide tweaks
From: Momchil Velikov <velco@fadata.bg>
Date: 25 Jan 2002 21:34:43 +0200
Message-ID: <87r8oez0ks.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

printk, etc. are broken wrt printing 64-bit numbers (%ll, %L).

This patch fixes do_div, which did (on some archs) 32-bit divide.

Regards,
-velco

===== drivers/net/sk98lin/skproc.c 1.1 vs edited =====
--- 1.1/drivers/net/sk98lin/skproc.c	Sat Dec  8 02:14:15 2001
+++ edited/drivers/net/sk98lin/skproc.c	Fri Jan 25 21:20:06 2002
@@ -339,17 +339,6 @@
  return (Rest);
 }
 
-
-#if 0
-#define do_div(n,base) ({ \
-long long __res; \
-__res = ((unsigned long long) n) % (unsigned) base; \
-n = ((unsigned long long) n) / (unsigned) base; \
-__res; })
-
-#endif
-
-
 /*****************************************************************************
  *
  * SkNumber - Print results
===== include/asm-arm/div64.h 1.1 vs edited =====
--- 1.1/include/asm-arm/div64.h	Sat Dec  8 02:13:45 2001
+++ edited/include/asm-arm/div64.h	Fri Jan 25 21:21:56 2002
@@ -1,12 +1,11 @@
 #ifndef __ASM_ARM_DIV64
 #define __ASM_ARM_DIV64
 
-/* We're not 64-bit, but... */
 #define do_div(n,base)						\
 ({								\
 	int __res;						\
-	__res = ((unsigned long)n) % (unsigned int)base;	\
-	n = ((unsigned long)n) / (unsigned int)base;		\
+	__res = ((unsigned long long)n) % (unsigned int)base;	\
+	n = ((unsigned long long)n) / (unsigned int)base;		\
 	__res;							\
 })
 
===== include/asm-cris/div64.h 1.1 vs edited =====
--- 1.1/include/asm-cris/div64.h	Sat Dec  8 02:13:57 2001
+++ edited/include/asm-cris/div64.h	Fri Jan 25 21:22:19 2002
@@ -3,12 +3,11 @@
 
 /* copy from asm-arm */
 
-/* We're not 64-bit, but... */
 #define do_div(n,base)						\
 ({								\
 	int __res;						\
-	__res = ((unsigned long)n) % (unsigned int)base;	\
-	n = ((unsigned long)n) / (unsigned int)base;		\
+	__res = ((unsigned long long)n) % (unsigned int)base;	\
+	n = ((unsigned long long)n) / (unsigned int)base;	\
 	__res;							\
 })
 
===== include/asm-m68k/div64.h 1.1 vs edited =====
--- 1.1/include/asm-m68k/div64.h	Sat Dec  8 02:13:35 2001
+++ edited/include/asm-m68k/div64.h	Fri Jan 25 21:23:59 2002
@@ -26,8 +26,8 @@
 #else
 #define do_div(n,base) ({					\
 	int __res;						\
-	__res = ((unsigned long) n) % (unsigned) base;		\
-	n = ((unsigned long) n) / (unsigned) base;		\
+	__res = ((unsigned long long) n) % (unsigned) base;	\
+	n = ((unsigned long long) n) / (unsigned) base;		\
 	__res;							\
 })
 #endif
===== include/asm-ppc/div64.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/div64.h	Sat Dec  8 02:13:37 2001
+++ edited/include/asm-ppc/div64.h	Fri Jan 25 21:28:49 2002
@@ -4,10 +4,9 @@
 #ifndef __PPC_DIV64
 #define __PPC_DIV64
 
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
+#define do_div(n,base) ({					\
+	int __res;						\
+	__res = ((unsigned long long) n) % (unsigned) base;	\
+	n = ((unsigned long long) n) / (unsigned) base;		\
+	__res; })
 #endif
===== include/asm-sh/div64.h 1.1 vs edited =====
--- 1.1/include/asm-sh/div64.h	Sat Dec  8 02:13:46 2001
+++ edited/include/asm-sh/div64.h	Fri Jan 25 21:29:31 2002
@@ -1,10 +1,9 @@
 #ifndef __ASM_SH_DIV64
 #define __ASM_SH_DIV64
 
-#define do_div(n,base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
+#define do_div(n,base) ({					\
+	int __res;						\
+	__res = ((unsigned long long) n) % (unsigned) base;	\
+	n = ((unsigned long long) n) / (unsigned) base;		\
+	__res; })
 #endif /* __ASM_SH_DIV64 */
===== include/asm-sparc/div64.h 1.1 vs edited =====
--- 1.1/include/asm-sparc/div64.h	Sat Dec  8 02:13:36 2001
+++ edited/include/asm-sparc/div64.h	Fri Jan 25 21:25:39 2002
@@ -1,11 +1,10 @@
 #ifndef __SPARC_DIV64
 #define __SPARC_DIV64
 
-/* We're not 64-bit, but... */
 #define do_div(n,base) ({ \
 	int __res; \
-	__res = ((unsigned long) n) % (unsigned) base; \
-	n = ((unsigned long) n) / (unsigned) base; \
+	__res = ((unsigned long long) n) % (unsigned) base; \
+	n = ((unsigned long long) n) / (unsigned) base; \
 	__res; })
 
 #endif /* __SPARC_DIV64 */
