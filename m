Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSG1Qmi>; Sun, 28 Jul 2002 12:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSG1Qly>; Sun, 28 Jul 2002 12:41:54 -0400
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:13440 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S316960AbSG1Qlp>;
	Sun, 28 Jul 2002 12:41:45 -0400
Message-ID: <3D441DD0.7090801@yahoo.com>
Date: Sun, 28 Jul 2002 20:37:36 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] vm86: Code cleanup
Content-Type: multipart/mixed;
 boundary="------------020204010906050507030701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020204010906050507030701
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

This patch substitutes the
asmish hell in the stack
manipulating macros by the
get_user() and put_user() macros.
No functional changes.
The patch is for the latest
-ac kernels.

--------------020204010906050507030701
Content-Type: text/plain;
 name="vm86_stack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm86_stack.diff"

--- linux/arch/i386/kernel/vm86.c	Sat May 11 01:39:45 2002
+++ linux/arch/i386/kernel/vm86.c	Sat Jun 15 17:51:22 2002
@@ -365,183 +365,80 @@
 	return nr;
 }
 
-/*
- * Boy are these ugly, but we need to do the correct 16-bit arithmetic.
- * Gcc makes a mess of it, so we do it inline and use non-obvious calling
- * conventions..
- * FIXME: is VM86_UNKNOWN really the correct return code? [MS??]
- * No that wasn't correct, instead we jump to a label given as
- * argument. In do_int the label already existed, in handle_vm86_fault
- * it had to be created. Can this be optimized so error handling get
- * out of the default execution path by using the address of the
- * label as fixup address? [KD]
- */
+#define val_byte(val, n) (((__u8 *)&val)[n])
+
 #define pushb(base, ptr, val, err_label) \
 	do { \
-		int err; \
-		__asm__ __volatile__(				\
-			"decw %w0\n\t"				\
-			"1: movb %3,0(%2,%0)\n\t"		\
-			"xor %1,%1\n\t"				\
-			"2:\n"					\
-			".section .fixup,\"ax\"\n\t"		\
-			"3:	movl $1,%1\n\t"			\
-			"	jmp 2b\n\t"			\
-			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
-			"	.align 4\n"			\
-			"	.long 1b,3b\n"			\
-			".previous"				\
-			: "=r" (ptr), "=r" (err)		\
-			: "r" (base), "q" (val), "0" (ptr));	\
-		if (err) \
+		__u8 __val = val; \
+		ptr--; \
+		if (put_user(__val, base + ptr) < 0) \
 			goto err_label; \
 	} while(0)
 
 #define pushw(base, ptr, val, err_label) \
 	do { \
-		int err; \
-		__asm__ __volatile__(				\
-			"decw %w0\n\t"				\
-			"1: movb %h3,0(%2,%0)\n\t"		\
-			"decw %w0\n\t"				\
-			"2: movb %b3,0(%2,%0)\n\t"		\
-			"xor %1,%1\n\t"				\
-			"3:\n"					\
-			".section .fixup,\"ax\"\n\t"		\
-			"4:	movl $1,%1\n\t"			\
-			"	jmp 3b\n\t"			\
-			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
-			"	.align 4\n"			\
-			"	.long 1b,4b\n"			\
-			"	.long 2b,4b\n"			\
-			".previous"				\
-			: "=r" (ptr), "=r" (err)		\
-			: "r" (base), "q" (val), "0" (ptr));	\
-		if (err) \
+		__u16 __val = val; \
+		ptr--; \
+		if (put_user(val_byte(__val, 1), base + ptr) < 0) \
+			goto err_label; \
+		ptr--; \
+		if (put_user(val_byte(__val, 0), base + ptr) < 0) \
 			goto err_label; \
 	} while(0)
 
 #define pushl(base, ptr, val, err_label) \
 	do { \
-		int err; \
-		__asm__ __volatile__(				\
-			"decw %w0\n\t"				\
-			"rorl $16,%3\n\t"			\
-			"1: movb %h3,0(%2,%0)\n\t"		\
-			"decw %w0\n\t"				\
-			"2: movb %b3,0(%2,%0)\n\t"		\
-			"decw %w0\n\t"				\
-			"rorl $16,%3\n\t"			\
-			"3: movb %h3,0(%2,%0)\n\t"		\
-			"decw %w0\n\t"				\
-			"4: movb %b3,0(%2,%0)\n\t"		\
-			"xor %1,%1\n\t"				\
-			"5:\n"					\
-			".section .fixup,\"ax\"\n\t"		\
-			"6:	movl $1,%1\n\t"			\
-			"	jmp 5b\n\t"			\
-			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
-			"	.align 4\n"			\
-			"	.long 1b,6b\n"			\
-			"	.long 2b,6b\n"			\
-			"	.long 3b,6b\n"			\
-			"	.long 4b,6b\n"			\
-			".previous"				\
-			: "=r" (ptr), "=r" (err)		\
-			: "r" (base), "q" (val), "0" (ptr));	\
-		if (err) \
+		__u32 __val = val; \
+		ptr--; \
+		if (put_user(val_byte(__val, 3), base + ptr) < 0) \
+			goto err_label; \
+		ptr--; \
+		if (put_user(val_byte(__val, 2), base + ptr) < 0) \
+			goto err_label; \
+		ptr--; \
+		if (put_user(val_byte(__val, 1), base + ptr) < 0) \
+			goto err_label; \
+		ptr--; \
+		if (put_user(val_byte(__val, 0), base + ptr) < 0) \
 			goto err_label; \
 	} while(0)
 
 #define popb(base, ptr, err_label) \
 	({ \
-	 	unsigned long __res; \
-	 	unsigned int err; \
-		__asm__ __volatile__( \
-			"1:movb 0(%1,%0),%b2\n\t"		\
-			"incw %w0\n\t"				\
-			"xor %3,%3\n\t"				\
-			"2:\n"					\
-			".section .fixup,\"ax\"\n\t"		\
-			"3:	movl $1,%1\n\t"			\
-			"	jmp 2b\n\t"			\
-			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
-			"	.align 4\n"			\
-			"	.long 1b,3b\n"			\
-			".previous"				\
-			: "=r" (ptr), "=r" (base), "=q" (__res), \
-				"=r" (err) \
-			: "0" (ptr), "1" (base), "2" (0)); \
-		if (err) \
+	 	__u8 __res; \
+		if (get_user(__res, base + ptr) < 0) \
 			goto err_label; \
+		ptr++; \
 		__res; \
 	})
 
 #define popw(base, ptr, err_label) \
 	({ \
-	 	unsigned long __res; \
-	 	unsigned int err; \
-		__asm__ __volatile__( \
-			"1:movb 0(%1,%0),%b2\n\t"		\
-			"incw %w0\n\t"				\
-			"2:movb 0(%1,%0),%h2\n\t"		\
-			"incw %w0\n\t"				\
-			"xor %3,%3\n\t"				\
-			"3:\n"					\
-			".section .fixup,\"ax\"\n\t"		\
-			"4:	movl $1,%1\n\t"			\
-			"	jmp 3b\n\t"			\
-			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
-			"	.align 4\n"			\
-			"	.long 1b,4b\n"			\
-			"	.long 2b,4b\n"			\
-			".previous"				\
-			: "=r" (ptr), "=r" (base), "=q" (__res), \
-				"=r" (err) \
-			: "0" (ptr), "1" (base), "2" (0)); \
-		if (err) \
+	 	__u16 __res; \
+		if (get_user(val_byte(__res, 0), base + ptr) < 0) \
+			goto err_label; \
+		ptr++; \
+		if (get_user(val_byte(__res, 1), base + ptr) < 0) \
 			goto err_label; \
+		ptr++; \
 		__res; \
 	})
 
 #define popl(base, ptr, err_label) \
 	({ \
-	 	unsigned long __res; \
-	 	unsigned int err; \
-		__asm__ __volatile__( \
-			"1:movb 0(%1,%0),%b2\n\t"		\
-			"incw %w0\n\t"				\
-			"2:movb 0(%1,%0),%h2\n\t"		\
-			"incw %w0\n\t"				\
-			"rorl $16,%2\n\t"			\
-			"3:movb 0(%1,%0),%b2\n\t"		\
-			"incw %w0\n\t"				\
-			"4:movb 0(%1,%0),%h2\n\t"		\
-			"incw %w0\n\t"				\
-			"rorl $16,%2\n\t"			\
-			"xor %3,%3\n\t"				\
-			"5:\n"					\
-			".section .fixup,\"ax\"\n\t"		\
-			"6:	movl $1,%1\n\t"			\
-			"	jmp 5b\n\t"			\
-			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
-			"	.align 4\n"			\
-			"	.long 1b,6b\n"			\
-			"	.long 2b,6b\n"			\
-			"	.long 3b,6b\n"			\
-			"	.long 4b,6b\n"			\
-			".previous"				\
-			: "=r" (ptr), "=r" (base), "=q" (__res), \
-				"=r" (err) \
-			: "0" (ptr), "1" (base), "2" (0)); \
-		if (err) \
+	 	__u32 __res; \
+		if (get_user(val_byte(__res, 0), base + ptr) < 0) \
+			goto err_label; \
+		ptr++; \
+		if (get_user(val_byte(__res, 1), base + ptr) < 0) \
+			goto err_label; \
+		ptr++; \
+		if (get_user(val_byte(__res, 2), base + ptr) < 0) \
+			goto err_label; \
+		ptr++; \
+		if (get_user(val_byte(__res, 3), base + ptr) < 0) \
 			goto err_label; \
+		ptr++; \
 		__res; \
 	})
 
@@ -550,7 +447,8 @@
  * userspace programs to be able to handle it. (Getting a problem
  * in userspace is always better than an Oops anyway.) [KD]
  */
-static void do_int(struct kernel_vm86_regs *regs, int i, unsigned char * ssp, unsigned long sp)
+static void do_int(struct kernel_vm86_regs *regs, int i,
+    unsigned char * ssp, unsigned short sp)
 {
 	unsigned long *intr_ptr, segoffs;
 
@@ -605,7 +503,7 @@
 void handle_vm86_fault(struct kernel_vm86_regs * regs, long error_code)
 {
 	unsigned char *csp, *ssp;
-	unsigned long ip, sp;
+	unsigned short ip, sp;
 
 #define CHECK_IF_IN_TRAP \
 	if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \

--------------020204010906050507030701--

