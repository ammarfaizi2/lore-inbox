Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265911AbSKBJA0>; Sat, 2 Nov 2002 04:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265915AbSKBJA0>; Sat, 2 Nov 2002 04:00:26 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:5544 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265911AbSKBJAQ>; Sat, 2 Nov 2002 04:00:16 -0500
Date: Sat, 02 Nov 2002 03:06:09 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 1/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Andrew Morton <akpm@digeo.com>
Message-Id: <20021102024957.220C.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out002.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 03:06:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The original copy_to/from_user routine, existed for long time, was 
deleted in 2.5.45 when the new faster_intel_copy went in.
But it was very compact and was also optimal for old
none-heavily-pipelined CPU, such as, i386/486/clasic pentium.

This patch will:
1) If it is not X86_MPENTIUMIII or 4, use the original copy routines, 
   which does not exist in 2.5.45.
2) Cleanup. (Now it is easy to add faster copy for other CPU)
     The uaccess.h is separeted to uaccess.h uaccess-intel.h to
     avoid #ifdef stuff in usercopy.c. If we keep adding the different
     version of copy-to-user() for each CPU into usercopy.c, 
     it will make it vary crummy.
     Instead, header will solves the problem.
     (Please somebody make uaccess-crusoe.h or could be SSE,
     Currently I am making for amd.)

Please apply both patches. They are against 2.5.45.
*NO feature is deleted from these two patches*

Here comes the first patch, which is purely cleanup for uaccess.h and usercopy.c.


diff -Nur -X dontdiff linux-2.5.45/arch/i386/kernel/cpu/intel.c linux-2.5.45-aki/arch/i386/kernel/cpu/intel.c
--- linux-2.5.45/arch/i386/kernel/cpu/intel.c	Thu Oct 31 22:40:01 2002
+++ linux-2.5.45-aki/arch/i386/kernel/cpu/intel.c	Sat Nov  2 02:37:36 2002
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
 
 
diff -Nur -X dontdiff linux-2.5.45/arch/i386/kernel/i386_ksyms.c linux-2.5.45-aki/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.45/arch/i386/kernel/i386_ksyms.c	Thu Oct 31 22:40:01 2002
+++ linux-2.5.45-aki/arch/i386/kernel/i386_ksyms.c	Sat Nov  2 02:37:27 2002
@@ -116,13 +116,11 @@
 
 EXPORT_SYMBOL(strncpy_from_user);
 EXPORT_SYMBOL(__strncpy_from_user);
+EXPORT_SYMBOL(strnlen_user);
 EXPORT_SYMBOL(clear_user);
 EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(copy_from_user);
-EXPORT_SYMBOL(__copy_from_user);
 EXPORT_SYMBOL(copy_to_user);
-EXPORT_SYMBOL(__copy_to_user);
-EXPORT_SYMBOL(strnlen_user);
 
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
diff -Nur -X dontdiff linux-2.5.45/arch/i386/lib/usercopy.c linux-2.5.45-aki/arch/i386/lib/usercopy.c
--- linux-2.5.45/arch/i386/lib/usercopy.c	Thu Oct 31 22:40:01 2002
+++ linux-2.5.45-aki/arch/i386/lib/usercopy.c	Sat Nov  2 02:37:20 2002
@@ -7,16 +7,6 @@
  */
 #include <linux/config.h>
 #include <asm/uaccess.h>
-#include <asm/mmx.h>
-
-static inline int movsl_is_ok(const void *a1, const void *a2, unsigned long n)
-{
-#ifdef CONFIG_X86_INTEL_USERCOPY
-	if (n >= 64 && (((const long)a1 ^ (const long)a2) & movsl_mask.mask))
-		return 0;
-#endif
-	return 1;
-}
 
 /*
  * Copy a null terminated string from userspace.
@@ -144,309 +134,30 @@
 	return res & mask;
 }
 
-#ifdef CONFIG_X86_INTEL_USERCOPY
-static unsigned long
-__copy_user_intel(void *to, const void *from,unsigned long size)
-{
-	int d0, d1;
-	__asm__ __volatile__(
-		       "       .align 2,0x90\n" 
-		       "0:     movl 32(%4), %%eax\n"
-		       "       cmpl $67, %0\n"     
-		       "       jbe 1f\n"            
-		       "       movl 64(%4), %%eax\n"
-		       "       .align 2,0x90\n"     
-		       "1:     movl 0(%4), %%eax\n" 
-		       "       movl 4(%4), %%edx\n" 
-		       "2:     movl %%eax, 0(%3)\n" 
-		       "21:    movl %%edx, 4(%3)\n" 
-		       "       movl 8(%4), %%eax\n" 
-		       "       movl 12(%4),%%edx\n" 
-		       "3:     movl %%eax, 8(%3)\n" 
-		       "31:    movl %%edx, 12(%3)\n"
-		       "       movl 16(%4), %%eax\n"
-		       "       movl 20(%4), %%edx\n"
-		       "4:     movl %%eax, 16(%3)\n"
-		       "41:    movl %%edx, 20(%3)\n"
-		       "       movl 24(%4), %%eax\n"
-		       "       movl 28(%4), %%edx\n"
-		       "10:    movl %%eax, 24(%3)\n"
-		       "51:    movl %%edx, 28(%3)\n"
-		       "       movl 32(%4), %%eax\n"
-		       "       movl 36(%4), %%edx\n"
-		       "11:    movl %%eax, 32(%3)\n"
-		       "61:    movl %%edx, 36(%3)\n"
-		       "       movl 40(%4), %%eax\n"
-		       "       movl 44(%4), %%edx\n"
-		       "12:    movl %%eax, 40(%3)\n"
-		       "71:    movl %%edx, 44(%3)\n"
-		       "       movl 48(%4), %%eax\n"
-		       "       movl 52(%4), %%edx\n"
-		       "13:    movl %%eax, 48(%3)\n"
-		       "81:    movl %%edx, 52(%3)\n"
-		       "       movl 56(%4), %%eax\n"
-		       "       movl 60(%4), %%edx\n"
-		       "14:    movl %%eax, 56(%3)\n"
-		       "91:    movl %%edx, 60(%3)\n"
-		       "       addl $-64, %0\n"     
-		       "       addl $64, %4\n"      
-		       "       addl $64, %3\n"      
-		       "       cmpl $63, %0\n"      
-		       "       ja  0b\n"            
-		       "5:     movl  %0, %%eax\n"   
-		       "       shrl  $2, %0\n"      
-		       "       andl  $3, %%eax\n"   
-		       "       cld\n"               
-		       "6:     rep; movsl\n"        
-		       "       movl %%eax, %0\n"    
-		       "7:     rep; movsb\n"		
-		       "8:\n"				
-		       ".section .fixup,\"ax\"\n"	
-		       "9:     lea 0(%%eax,%0,4),%0\n"	
-		       "       jmp 8b\n"               
-		       ".previous\n"			
-		       ".section __ex_table,\"a\"\n"	
-		       "       .align 4\n"		
-		       "       .long 2b,8b\n"		
-		       "       .long 21b,8b\n"	
-		       "       .long 3b,8b\n"		
-		       "       .long 31b,8b\n"	
-		       "       .long 4b,8b\n"		
-		       "       .long 41b,8b\n"	
-		       "       .long 10b,8b\n"	
-		       "       .long 51b,8b\n"	
-		       "       .long 11b,8b\n"	
-		       "       .long 61b,8b\n"	
-		       "       .long 12b,8b\n"	
-		       "       .long 71b,8b\n"	
-		       "       .long 13b,8b\n"	
-		       "       .long 81b,8b\n"	
-		       "       .long 14b,8b\n"	
-		       "       .long 91b,8b\n"	
-		       "       .long 6b,9b\n"		
-		       "       .long 7b,8b\n"          
-		       ".previous"			
-		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
-		       :  "1"(to), "2"(from), "0"(size)
-		       : "eax", "edx", "memory");			
-	return size;
-}
-
-static unsigned long
-__copy_user_zeroing_intel(void *to, const void *from, unsigned long size)
-{
-	int d0, d1;
-	__asm__ __volatile__(
-		       "        .align 2,0x90\n"
-		       "0:      movl 32(%4), %%eax\n"
-		       "        cmpl $67, %0\n"      
-		       "        jbe 2f\n"            
-		       "1:      movl 64(%4), %%eax\n"
-		       "        .align 2,0x90\n"     
-		       "2:      movl 0(%4), %%eax\n" 
-		       "21:     movl 4(%4), %%edx\n" 
-		       "        movl %%eax, 0(%3)\n" 
-		       "        movl %%edx, 4(%3)\n" 
-		       "3:      movl 8(%4), %%eax\n" 
-		       "31:     movl 12(%4),%%edx\n" 
-		       "        movl %%eax, 8(%3)\n" 
-		       "        movl %%edx, 12(%3)\n"
-		       "4:      movl 16(%4), %%eax\n"
-		       "41:     movl 20(%4), %%edx\n"
-		       "        movl %%eax, 16(%3)\n"
-		       "        movl %%edx, 20(%3)\n"
-		       "10:     movl 24(%4), %%eax\n"
-		       "51:     movl 28(%4), %%edx\n"
-		       "        movl %%eax, 24(%3)\n"
-		       "        movl %%edx, 28(%3)\n"
-		       "11:     movl 32(%4), %%eax\n"
-		       "61:     movl 36(%4), %%edx\n"
-		       "        movl %%eax, 32(%3)\n"
-		       "        movl %%edx, 36(%3)\n"
-		       "12:     movl 40(%4), %%eax\n"
-		       "71:     movl 44(%4), %%edx\n"
-		       "        movl %%eax, 40(%3)\n"
-		       "        movl %%edx, 44(%3)\n"
-		       "13:     movl 48(%4), %%eax\n"
-		       "81:     movl 52(%4), %%edx\n"
-		       "        movl %%eax, 48(%3)\n"
-		       "        movl %%edx, 52(%3)\n"
-		       "14:     movl 56(%4), %%eax\n"
-		       "91:     movl 60(%4), %%edx\n"
-		       "        movl %%eax, 56(%3)\n"
-		       "        movl %%edx, 60(%3)\n"
-		       "        addl $-64, %0\n"     
-		       "        addl $64, %4\n"      
-		       "        addl $64, %3\n"      
-		       "        cmpl $63, %0\n"      
-		       "        ja  0b\n"            
-		       "5:      movl  %0, %%eax\n"   
-		       "        shrl  $2, %0\n"      
-		       "        andl $3, %%eax\n"    
-		       "        cld\n"               
-		       "6:      rep; movsl\n"   
-		       "        movl %%eax,%0\n"
-		       "7:      rep; movsb\n"	
-		       "8:\n"			
-		       ".section .fixup,\"ax\"\n"
-		       "9:      lea 0(%%eax,%0,4),%0\n"	
-		       "16:     pushl %0\n"	
-		       "        pushl %%eax\n"	
-		       "        xorl %%eax,%%eax\n"
-		       "        rep; stosb\n"	
-		       "        popl %%eax\n"	
-		       "        popl %0\n"	
-		       "        jmp 8b\n"	
-		       ".previous\n"		
-		       ".section __ex_table,\"a\"\n"
-		       "	.align 4\n"	   
-		       "	.long 0b,16b\n"	 
-		       "	.long 1b,16b\n"
-		       "	.long 2b,16b\n"
-		       "	.long 21b,16b\n"
-		       "	.long 3b,16b\n"	
-		       "	.long 31b,16b\n"
-		       "	.long 4b,16b\n"	
-		       "	.long 41b,16b\n"
-		       "	.long 10b,16b\n"
-		       "	.long 51b,16b\n"
-		       "	.long 11b,16b\n"
-		       "	.long 61b,16b\n"
-		       "	.long 12b,16b\n"
-		       "	.long 71b,16b\n"
-		       "	.long 13b,16b\n"
-		       "	.long 81b,16b\n"
-		       "	.long 14b,16b\n"
-		       "	.long 91b,16b\n"
-		       "	.long 6b,9b\n"	
-		       "        .long 7b,16b\n" 
-		       ".previous"		
-		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
-		       :  "1"(to), "2"(from), "0"(size)
-		       : "eax", "edx", "memory");
-	return size;
-}
-#else
 /*
- * Leave these declared but undefined.  They should not be any references to
- * them
+ * Copy To/From Userspace 
+ *
+ * The __ versions(no address verification) of __copy_from/to_user and
+ * CPU specific optimized __do_copy_user are 
+ * in asm-i386/uaccess.h.
  */
-unsigned long
-__copy_user_zeroing_intel(void *to, const void *from, unsigned long size);
-unsigned long
-__copy_user_intel(void *to, const void *from,unsigned long size);
-#endif /* CONFIG_X86_INTEL_USERCOPY */
-
-/* Generic arbitrary sized copy.  */
-#define __copy_user(to,from,size)					\
-do {									\
-	int __d0, __d1, __d2;						\
-	__asm__ __volatile__(						\
-		"	cmp  $7,%0\n"					\
-		"	jbe  1f\n"					\
-		"	movl %1,%0\n"					\
-		"	negl %0\n"					\
-		"	andl $7,%0\n"					\
-		"	subl %0,%3\n"					\
-		"4:	rep; movsb\n"					\
-		"	movl %3,%0\n"					\
-		"	shrl $2,%0\n"					\
-		"	andl $3,%3\n"					\
-		"	.align 2,0x90\n"				\
-		"0:	rep; movsl\n"					\
-		"	movl %3,%0\n"					\
-		"1:	rep; movsb\n"					\
-		"2:\n"							\
-		".section .fixup,\"ax\"\n"				\
-		"5:	addl %3,%0\n"					\
-		"	jmp 2b\n"					\
-		"3:	lea 0(%3,%0,4),%0\n"				\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		".section __ex_table,\"a\"\n"				\
-		"	.align 4\n"					\
-		"	.long 4b,5b\n"					\
-		"	.long 0b,3b\n"					\
-		"	.long 1b,2b\n"					\
-		".previous"						\
-		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
-		: "3"(size), "0"(size), "1"(to), "2"(from)		\
-		: "memory");						\
-} while (0)
 
-#define __copy_user_zeroing(to,from,size)				\
-do {									\
-	int __d0, __d1, __d2;						\
-	__asm__ __volatile__(						\
-		"	cmp  $7,%0\n"					\
-		"	jbe  1f\n"					\
-		"	movl %1,%0\n"					\
-		"	negl %0\n"					\
-		"	andl $7,%0\n"					\
-		"	subl %0,%3\n"					\
-		"4:	rep; movsb\n"					\
-		"	movl %3,%0\n"					\
-		"	shrl $2,%0\n"					\
-		"	andl $3,%3\n"					\
-		"	.align 2,0x90\n"				\
-		"0:	rep; movsl\n"					\
-		"	movl %3,%0\n"					\
-		"1:	rep; movsb\n"					\
-		"2:\n"							\
-		".section .fixup,\"ax\"\n"				\
-		"5:	addl %3,%0\n"					\
-		"	jmp 6f\n"					\
-		"3:	lea 0(%3,%0,4),%0\n"				\
-		"6:	pushl %0\n"					\
-		"	pushl %%eax\n"					\
-		"	xorl %%eax,%%eax\n"				\
-		"	rep; stosb\n"					\
-		"	popl %%eax\n"					\
-		"	popl %0\n"					\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		".section __ex_table,\"a\"\n"				\
-		"	.align 4\n"					\
-		"	.long 4b,5b\n"					\
-		"	.long 0b,3b\n"					\
-		"	.long 1b,6b\n"					\
-		".previous"						\
-		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
-		: "3"(size), "0"(size), "1"(to), "2"(from)		\
-		: "memory");						\
-} while (0)
-
-
-unsigned long __copy_to_user(void *to, const void *from, unsigned long n)
-{
-	if (movsl_is_ok(to, from, n))
-		__copy_user(to, from, n);
-	else
-		n = __copy_user_intel(to, from, n);
-	return n;
-}
-
-unsigned long __copy_from_user(void *to, const void *from, unsigned long n)
-{
-	if (movsl_is_ok(to, from, n))
-		__copy_user_zeroing(to, from, n);
-	else
-		n = __copy_user_zeroing_intel(to, from, n);
-	return n;
-}
-
-unsigned long copy_to_user(void *to, const void *from, unsigned long n)
+unsigned long
+copy_to_user(void *to, const void *from, unsigned long n)
 {
 	prefetch(from);
 	if (access_ok(VERIFY_WRITE, to, n))
-		n = __copy_to_user(to, from, n);
+		__do_copy_user(to,from,n);
 	return n;
 }
 
-unsigned long copy_from_user(void *to, const void *from, unsigned long n)
+unsigned long
+copy_from_user(void *to, const void *from, unsigned long n)
 {
 	prefetchw(to);
 	if (access_ok(VERIFY_READ, from, n))
-		n = __copy_from_user(to, from, n);
+		__do_copy_user_zeroing(to,from,n);
+	else
+		memset(to, 0, n);
 	return n;
 }
diff -Nur -X dontdiff linux-2.5.45/include/asm-i386/uaccess.h linux-2.5.45-aki/include/asm-i386/uaccess.h
--- linux-2.5.45/include/asm-i386/uaccess.h	Thu Oct 31 22:40:12 2002
+++ linux-2.5.45-aki/include/asm-i386/uaccess.h	Sat Nov  2 03:12:14 2002
@@ -33,15 +33,6 @@
 
 #define segment_eq(a,b)	((a).seg == (b).seg)
 
-/*
- * movsl can be slow when source and dest are not both 8-byte aligned
- */
-#ifdef CONFIG_X86_INTEL_USERCOPY
-extern struct movsl_mask {
-	int mask;
-} ____cacheline_aligned_in_smp movsl_mask;
-#endif
-
 int __verify_write(const void *, unsigned long);
 
 #define __addr_ok(addr) ((unsigned long)(addr) < (current_thread_info()->addr_limit.seg))
@@ -255,17 +246,112 @@
 		: "=r"(err), ltype (x)				\
 		: "m"(__m(addr)), "i"(-EFAULT), "0"(err))
 
-
-unsigned long copy_to_user(void *to, const void *from, unsigned long n);
-unsigned long copy_from_user(void *to, const void *from, unsigned long n);
-unsigned long __copy_to_user(void *to, const void *from, unsigned long n);
-unsigned long __copy_from_user(void *to, const void *from, unsigned long n);
-
+/*
+ * Copy a null terminated string from userspace.
+ */
 long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);
 #define strlen_user(str) strnlen_user(str, ~0UL >> 1)
 long strnlen_user(const char *str, long n);
+
+/*
+ * Zeroing Userspace
+ */
 unsigned long clear_user(void *mem, unsigned long len);
 unsigned long __clear_user(void *mem, unsigned long len);
 
+/*
+ * CPU specific Copy To/From Userspace starts here  **** 
+ */
+
+/* Intel */
+#if defined(CONFIG_X86_INTEL_USERCOPY)
+#include "uaccess-intel.h"
+
+/* i386 */
+#else
+/*
+ * Copy To/From Userspace for Generic arbitrary size. 
+ */
+#define __do_copy_user(to,from,size)					\
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
+#define __do_copy_user_zeroing(to,from,size)				\
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
+#endif /* uaccess-i386.h */
+
+/*
+ * Main Copy To/From Userspace
+ */
+/* We let the __ versions(no address verification) of 
+ * copy_from/to_user inline, because they're often
+ * used in fast paths.
+ */
+unsigned long 
+copy_to_user(void *, const void *, unsigned long);
+
+unsigned long 
+copy_from_user(void *, const void *, unsigned long);
+
+static inline unsigned long
+__copy_to_user(void *to, const void *from, unsigned long n)
+{
+	prefetch(from);
+	__do_copy_user(to,from,n);
+	return n;
+}
+
+static inline unsigned long
+__copy_from_user(void *to, const void *from, unsigned long n)
+{
+	prefetchw(to);
+	__do_copy_user_zeroing(to,from,n);
+	return n;
+}
+
 #endif /* __i386_UACCESS_H */
Binary files linux-2.5.45/scripts/kconfig/mconf and linux-2.5.45-aki/scripts/kconfig/mconf differ



