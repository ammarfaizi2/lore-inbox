Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbSKEOax>; Tue, 5 Nov 2002 09:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbSKEOax>; Tue, 5 Nov 2002 09:30:53 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:37548 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S264869AbSKEOat>; Tue, 5 Nov 2002 09:30:49 -0500
Date: Tue, 05 Nov 2002 09:36:48 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46 add original copy_ro/from_user for i386 and support PenPro PenII
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Andrew Morton <akpm@digeo.com>
Message-Id: <20021105090237.511A.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop017.verizon.net from [138.89.32.225] at Tue, 5 Nov 2002 08:37:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is revised version from my previous patch, adding original copy_user.

In addition, I changed one line in Kconfig, remove M585MMX and add M686
because I run new copy-user on my PentiumMMX but had no improvement,
however PenII/PenPro likely to have improvement from new copy_user function.

Athlon is ignored in the current kernel from 2.5.45 but you could use 
CONFIG_M686 to try new copy_user.

Akira

diff -Nur -X dontdiff c46/arch/i386/Kconfig a46/arch/i386/Kconfig
--- c46/arch/i386/Kconfig	Tue Nov  5 08:18:20 2002
+++ a46/arch/i386/Kconfig	Tue Nov  5 08:21:18 2002
@@ -263,9 +263,9 @@
 	depends on MK7 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX
 	default y
 
-config X86_INTEL_USERCOPY
+config X86_USE_USERCOPY_686
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || M586MMX
+	depends on MPENTIUM4 || MPENTIUMIII || M686
 	default y
 
 config X86_USE_PPRO_CHECKSUM
diff -Nur -X dontdiff c46/arch/i386/kernel/cpu/intel.c a46/arch/i386/kernel/cpu/intel.c
--- c46/arch/i386/kernel/cpu/intel.c	Thu Oct 31 22:40:01 2002
+++ a46/arch/i386/kernel/cpu/intel.c	Tue Nov  5 08:21:18 2002
@@ -14,13 +14,6 @@
 static int disable_P4_HT __initdata = 0;
 extern int trap_init_f00f_bug(void);
 
-#ifdef CONFIG_X86_INTEL_USERCOPY
-/*
- * Alignment at which movsl is preferred for bulk memory copies.
- */
-struct movsl_mask movsl_mask;
-#endif
-
 /*
  *	Early probe support logic for ppro memory erratum #50
  *
@@ -356,24 +349,6 @@
 
 	/* Work around errata */
 	Intel_errata_workarounds(c);
-
-#ifdef CONFIG_X86_INTEL_USERCOPY
-	/*
-	 * Set up the preferred alignment for movsl bulk memory moves
-	 */
-	switch (c->x86) {
-	case 4:		/* 486: untested */
-		break;
-	case 5:		/* Old Pentia: untested */
-		break;
-	case 6:		/* PII/PIII only like movsl with 8-byte alignment */
-		movsl_mask.mask = 7;
-		break;
-	case 15:	/* P4 is OK down to 8-byte alignment */
-		movsl_mask.mask = 7;
-		break;
-	}
-#endif
 }
 
 
diff -Nur -X dontdiff c46/arch/i386/lib/usercopy.c a46/arch/i386/lib/usercopy.c
--- c46/arch/i386/lib/usercopy.c	Thu Oct 31 22:40:01 2002
+++ a46/arch/i386/lib/usercopy.c	Tue Nov  5 08:21:18 2002
@@ -7,12 +7,12 @@
  */
 #include <linux/config.h>
 #include <asm/uaccess.h>
-#include <asm/mmx.h>
 
+#define MOVSL_MASK 7
 static inline int movsl_is_ok(const void *a1, const void *a2, unsigned long n)
 {
 #ifdef CONFIG_X86_INTEL_USERCOPY
-	if (n >= 64 && (((const long)a1 ^ (const long)a2) & movsl_mask.mask))
+	if (n >= 64 && (((const long)a1 ^ (const long)a2) & MOVSL_MASK))
 		return 0;
 #endif
 	return 1;
@@ -144,7 +144,11 @@
 	return res & mask;
 }
 
-#ifdef CONFIG_X86_INTEL_USERCOPY
+/*
+ * Copy To/From Userspace.
+ */
+/* MPENTIUMIII MPENTIUM4 MK7 M686 */
+#ifdef CONFIG_X86_USE_USERCOPY_686
 static unsigned long
 __copy_user_intel(void *to, const void *from,unsigned long size)
 {
@@ -326,7 +330,8 @@
 		       : "eax", "edx", "memory");
 	return size;
 }
-#else
+
+#else /* M386 M486 M586 */
 /*
  * Leave these declared but undefined.  They should not be any references to
  * them
@@ -335,9 +340,63 @@
 __copy_user_zeroing_intel(void *to, const void *from, unsigned long size);
 unsigned long
 __copy_user_intel(void *to, const void *from,unsigned long size);
-#endif /* CONFIG_X86_INTEL_USERCOPY */
+#endif /* CONFIG_X86_USE_USERCOPY_686 */
+
+/* M386 M486 */
+#if defined(CONFIG_M386) || defined(CONFIG_M486)
+
+#define __copy_user(to,from,size)					\
+do {									\
+	int __d0, __d1;							\
+	__asm__ __volatile__(						\
+		"0:	rep; movsl\n"					\
+		"	movl %3,%0\n"					\
+		"1:	rep; movsb\n"					\
+		"2:\n"							\
+		".section .fixup,\"ax\"\n"				\
+		"3:	lea 0(%3,%0,4),%0\n"				\
+		"	jmp 2b\n"					\
+		".previous\n"						\
+		".section __ex_table,\"a\"\n"				\
+		"	.align 4\n"					\
+		"	.long 0b,3b\n"					\
+		"	.long 1b,2b\n"					\
+		".previous"						\
+		: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
+		: "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)	\
+		: "memory");						\
+} while (0)
+
+#define __copy_user_zeroing(to,from,size)				\
+do {									\
+	int __d0, __d1;							\
+	__asm__ __volatile__(						\
+		"0:	rep; movsl\n"					\
+		"	movl %3,%0\n"					\
+		"1:	rep; movsb\n"					\
+		"2:\n"							\
+		".section .fixup,\"ax\"\n"				\
+		"3:	lea 0(%3,%0,4),%0\n"				\
+		"4:	pushl %0\n"					\
+		"	pushl %%eax\n"					\
+		"	xorl %%eax,%%eax\n"				\
+		"	rep; stosb\n"					\
+		"	popl %%eax\n"					\
+		"	popl %0\n"					\
+		"	jmp 2b\n"					\
+		".previous\n"						\
+		".section __ex_table,\"a\"\n"				\
+		"	.align 4\n"					\
+		"	.long 0b,3b\n"					\
+		"	.long 1b,4b\n"					\
+		".previous"						\
+		: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
+		: "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)	\
+		: "memory");						\
+} while (0)
+
+#else /* M586 M686 */
 
-/* Generic arbitrary sized copy.  */
 #define __copy_user(to,from,size)					\
 do {									\
 	int __d0, __d1, __d2;						\
@@ -416,6 +475,7 @@
 		: "memory");						\
 } while (0)
 
+#endif /* M386 M486 */
 
 unsigned long __copy_to_user(void *to, const void *from, unsigned long n)
 {


