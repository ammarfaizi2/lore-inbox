Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSCVORO>; Fri, 22 Mar 2002 09:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312530AbSCVORH>; Fri, 22 Mar 2002 09:17:07 -0500
Received: from daimi.au.dk ([130.225.16.1]:10171 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S312529AbSCVOQr>;
	Fri, 22 Mar 2002 09:16:47 -0500
Message-ID: <3C9B3CCA.B4D7FAB9@daimi.au.dk>
Date: Fri, 22 Mar 2002 15:16:42 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Recent vm86 bugfixes
In-Reply-To: <3C9B150B.7F4E7985@daimi.au.dk>
Content-Type: multipart/mixed;
 boundary="------------111A8ED9BF7BE4AC0E202C73"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------111A8ED9BF7BE4AC0E202C73
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Kasper Dupont wrote:
> 
> In 2.2.21-pre1 some vm86 bugs have been attempted fixed.
> The bug did become smaller, but unfortunately didn't get
> completely fixed.
> 
> [snip] I will be
> back with a patch for 2.4.18 once I have resolved
> the mentioned problems.
> 
> Any comments?

Here is the patch, which I has also made available by http:
http://www.daimi.au.dk/~kasperd/linux_kernel/vm86.2.4.18.patch

Somebody suggested me that Alan might be interesting in
this particular path.

I have done some testing, of the new patch, and it seems to
work. Though userspace programs using vm86 might need to
be changed slightly to handle the situation. Anyway that
situation should be better than both the orignial Oops bug,
and the incorrect IP register value caused by the first
patch. Now the userspace code is no longer left in an
imposible to handle situation.

About the other bug I mentioned here is a hexdump of a
small DOS program demonstrating the difference. This prints
0 on a real PC but 2 on an emulator using vm86, my patch
also fixes this problem.

[kasperd:pts/1:~] od -h <setvflag.com 
0000000 9cfa 9dfb fb9c 8858 25e0 0002 3005 cd0e
0000020 b810 4c00 21cd
0000026

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
--------------111A8ED9BF7BE4AC0E202C73
Content-Type: text/plain; charset=us-ascii;
 name="vm86.2.4.18.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm86.2.4.18.patch"

diff -Nur linux.old/arch/i386/kernel/vm86.c linux.new/arch/i386/kernel/vm86.c
--- linux.old/arch/i386/kernel/vm86.c	Fri Mar 22 12:53:37 2002
+++ linux.new/arch/i386/kernel/vm86.c	Fri Mar 22 14:25:08 2002
@@ -3,6 +3,13 @@
  *
  *  Copyright (C) 1994  Linus Torvalds
  */
+
+/*
+ *  Bugfixes Copyright 2002 by Manfred Spraul and
+ *  Kasper Dupont <kasperd@daimi.au.dk>
+ *
+ */
+
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -290,12 +297,25 @@
 	regs->eflags &= ~TF_MASK;
 }
 
+/* It is correct to call set_IF(regs) from the set_vflags_*
+ * functions. However someone forgot to call clear_IF(regs)
+ * in the opposite case.
+ * After the command sequence CLI PUSHF STI POPF you should
+ * end up with interrups disabled, but you ended up with
+ * interrupts enabled.
+ *  ( I was testing my own changes, but the only bug I
+ *    could find was in a function I had not changed. )
+ * [KD]
+ */
+
 static inline void set_vflags_long(unsigned long eflags, struct kernel_vm86_regs * regs)
 {
 	set_flags(VEFLAGS, eflags, current->thread.v86mask);
 	set_flags(regs->eflags, eflags, SAFE_MASK);
 	if (eflags & IF_MASK)
 		set_IF(regs);
+	else
+		clear_IF(regs);
 }
 
 static inline void set_vflags_short(unsigned short flags, struct kernel_vm86_regs * regs)
@@ -304,6 +324,8 @@
 	set_flags(regs->eflags, flags, SAFE_MASK);
 	if (flags & IF_MASK)
 		set_IF(regs);
+	else
+		clear_IF(regs);
 }
 
 static inline unsigned long get_vflags(struct kernel_vm86_regs * regs)
@@ -327,75 +349,184 @@
  * Boy are these ugly, but we need to do the correct 16-bit arithmetic.
  * Gcc makes a mess of it, so we do it inline and use non-obvious calling
  * conventions..
+ * FIXME: is VM86_UNKNOWN really the correct return code? [MS??]
+ * No that wasn't correct, it depends on the context, so lets
+ * make it an argument to the macro. [KD]
+ */
+#define pushb(base, ptr, val, regs, errcode) \
+	do { \
+		int err; \
+		__asm__ __volatile__(				\
+			"decw %w0\n\t"				\
+			"1: movb %3,0(%2,%0)\n\t"		\
+			"xor %1,%1\n\t"				\
+			"2:\n"					\
+			".section .fixup,\"ax\"\n\t"		\
+			"3:	movl $1,%1\n\t"			\
+			"	jmp 2b\n\t"			\
+			".previous\n"				\
+			".section __ex_table,\"a\"\n"		\
+			"	.align 4\n"			\
+			"	.long 1b,3b\n"			\
+			".previous"				\
+			: "=r" (ptr), "=r" (err)		\
+			: "r" (base), "q" (val), "0" (ptr));	\
+		if (err) \
+			return_to_32bit(regs, errcode); \
+	} while(0)
+
+#define pushw(base, ptr, val, regs, errcode) \
+	do { \
+		int err; \
+		__asm__ __volatile__(				\
+			"decw %w0\n\t"				\
+			"1: movb %h3,0(%2,%0)\n\t"		\
+			"decw %w0\n\t"				\
+			"2: movb %b3,0(%2,%0)\n\t"		\
+			"xor %1,%1\n\t"				\
+			"3:\n"					\
+			".section .fixup,\"ax\"\n\t"		\
+			"4:	movl $1,%1\n\t"			\
+			"	jmp 3b\n\t"			\
+			".previous\n"				\
+			".section __ex_table,\"a\"\n"		\
+			"	.align 4\n"			\
+			"	.long 1b,4b\n"			\
+			"	.long 2b,4b\n"			\
+			".previous"				\
+			: "=r" (ptr), "=r" (err)		\
+			: "r" (base), "q" (val), "0" (ptr));	\
+		if (err) \
+			return_to_32bit(regs, errcode); \
+	} while(0)
+
+#define pushl(base, ptr, val, regs, errcode) \
+	do { \
+		int err; \
+		__asm__ __volatile__(				\
+			"decw %w0\n\t"				\
+			"rorl $16,%3\n\t"			\
+			"1: movb %h3,0(%2,%0)\n\t"		\
+			"decw %w0\n\t"				\
+			"2: movb %b3,0(%2,%0)\n\t"		\
+			"decw %w0\n\t"				\
+			"rorl $16,%3\n\t"			\
+			"3: movb %h3,0(%2,%0)\n\t"		\
+			"decw %w0\n\t"				\
+			"4: movb %b3,0(%2,%0)\n\t"		\
+			"xor %1,%1\n\t"				\
+			"5:\n"					\
+			".section .fixup,\"ax\"\n\t"		\
+			"6:	movl $1,%1\n\t"			\
+			"	jmp 5b\n\t"			\
+			".previous\n"				\
+			".section __ex_table,\"a\"\n"		\
+			"	.align 4\n"			\
+			"	.long 1b,6b\n"			\
+			"	.long 2b,6b\n"			\
+			"	.long 3b,6b\n"			\
+			"	.long 4b,6b\n"			\
+			".previous"				\
+			: "=r" (ptr), "=r" (err)		\
+			: "r" (base), "q" (val), "0" (ptr));	\
+		if (err) \
+			return_to_32bit(regs, errcode); \
+	} while(0)
+
+#define popb(base, ptr, regs, errcode) \
+	({ \
+	 	unsigned long __res; \
+	 	unsigned int err; \
+		__asm__ __volatile__( \
+			"1:movb 0(%1,%0),%b2\n\t"		\
+			"incw %w0\n\t"				\
+			"xor %3,%3\n\t"				\
+			"2:\n"					\
+			".section .fixup,\"ax\"\n\t"		\
+			"3:	movl $1,%1\n\t"			\
+			"	jmp 2b\n\t"			\
+			".previous\n"				\
+			".section __ex_table,\"a\"\n"		\
+			"	.align 4\n"			\
+			"	.long 1b,3b\n"			\
+			".previous"				\
+			: "=r" (ptr), "=r" (base), "=q" (__res), \
+				"=r" (err) \
+			: "0" (ptr), "1" (base), "2" (0)); \
+		if (err) \
+			return_to_32bit(regs, errcode); \
+		__res; \
+	})
+
+#define popw(base, ptr, regs, errcode) \
+	({ \
+	 	unsigned long __res; \
+	 	unsigned int err; \
+		__asm__ __volatile__( \
+			"1:movb 0(%1,%0),%b2\n\t"		\
+			"incw %w0\n\t"				\
+			"2:movb 0(%1,%0),%h2\n\t"		\
+			"incw %w0\n\t"				\
+			"xor %3,%3\n\t"				\
+			"3:\n"					\
+			".section .fixup,\"ax\"\n\t"		\
+			"4:	movl $1,%1\n\t"			\
+			"	jmp 3b\n\t"			\
+			".previous\n"				\
+			".section __ex_table,\"a\"\n"		\
+			"	.align 4\n"			\
+			"	.long 1b,4b\n"			\
+			"	.long 2b,4b\n"			\
+			".previous"				\
+			: "=r" (ptr), "=r" (base), "=q" (__res), \
+				"=r" (err) \
+			: "0" (ptr), "1" (base), "2" (0)); \
+		if (err) \
+			return_to_32bit(regs, errcode); \
+		__res; \
+	})
+
+#define popl(base, ptr, regs, errcode) \
+	({ \
+	 	unsigned long __res; \
+	 	unsigned int err; \
+		__asm__ __volatile__( \
+			"1:movb 0(%1,%0),%b2\n\t"		\
+			"incw %w0\n\t"				\
+			"2:movb 0(%1,%0),%h2\n\t"		\
+			"incw %w0\n\t"				\
+			"rorl $16,%2\n\t"			\
+			"3:movb 0(%1,%0),%b2\n\t"		\
+			"incw %w0\n\t"				\
+			"4:movb 0(%1,%0),%h2\n\t"		\
+			"incw %w0\n\t"				\
+			"rorl $16,%2\n\t"			\
+			"xor %3,%3\n\t"				\
+			"5:\n"					\
+			".section .fixup,\"ax\"\n\t"		\
+			"6:	movl $1,%1\n\t"			\
+			"	jmp 5b\n\t"			\
+			".previous\n"				\
+			".section __ex_table,\"a\"\n"		\
+			"	.align 4\n"			\
+			"	.long 1b,6b\n"			\
+			"	.long 2b,6b\n"			\
+			"	.long 3b,6b\n"			\
+			"	.long 4b,6b\n"			\
+			".previous"				\
+			: "=r" (ptr), "=r" (base), "=q" (__res), \
+				"=r" (err) \
+			: "0" (ptr), "1" (base), "2" (0)); \
+		if (err) \
+			return_to_32bit(regs, errcode); \
+		__res; \
+	})
+
+/* There are so many possible reasons for this function to return
+ * VM86_INTx, so adding another doesn't bother me. We can expect
+ * userspace programs to be able to handle it. (Getting a problem
+ * in userspace is always better than an Oops anyway.) [KD]
  */
-#define pushb(base, ptr, val) \
-__asm__ __volatile__( \
-	"decw %w0\n\t" \
-	"movb %2,0(%1,%0)" \
-	: "=r" (ptr) \
-	: "r" (base), "q" (val), "0" (ptr))
-
-#define pushw(base, ptr, val) \
-__asm__ __volatile__( \
-	"decw %w0\n\t" \
-	"movb %h2,0(%1,%0)\n\t" \
-	"decw %w0\n\t" \
-	"movb %b2,0(%1,%0)" \
-	: "=r" (ptr) \
-	: "r" (base), "q" (val), "0" (ptr))
-
-#define pushl(base, ptr, val) \
-__asm__ __volatile__( \
-	"decw %w0\n\t" \
-	"rorl $16,%2\n\t" \
-	"movb %h2,0(%1,%0)\n\t" \
-	"decw %w0\n\t" \
-	"movb %b2,0(%1,%0)\n\t" \
-	"decw %w0\n\t" \
-	"rorl $16,%2\n\t" \
-	"movb %h2,0(%1,%0)\n\t" \
-	"decw %w0\n\t" \
-	"movb %b2,0(%1,%0)" \
-	: "=r" (ptr) \
-	: "r" (base), "q" (val), "0" (ptr))
-
-#define popb(base, ptr) \
-({ unsigned long __res; \
-__asm__ __volatile__( \
-	"movb 0(%1,%0),%b2\n\t" \
-	"incw %w0" \
-	: "=r" (ptr), "=r" (base), "=q" (__res) \
-	: "0" (ptr), "1" (base), "2" (0)); \
-__res; })
-
-#define popw(base, ptr) \
-({ unsigned long __res; \
-__asm__ __volatile__( \
-	"movb 0(%1,%0),%b2\n\t" \
-	"incw %w0\n\t" \
-	"movb 0(%1,%0),%h2\n\t" \
-	"incw %w0" \
-	: "=r" (ptr), "=r" (base), "=q" (__res) \
-	: "0" (ptr), "1" (base), "2" (0)); \
-__res; })
-
-#define popl(base, ptr) \
-({ unsigned long __res; \
-__asm__ __volatile__( \
-	"movb 0(%1,%0),%b2\n\t" \
-	"incw %w0\n\t" \
-	"movb 0(%1,%0),%h2\n\t" \
-	"incw %w0\n\t" \
-	"rorl $16,%2\n\t" \
-	"movb 0(%1,%0),%b2\n\t" \
-	"incw %w0\n\t" \
-	"movb 0(%1,%0),%h2\n\t" \
-	"incw %w0\n\t" \
-	"rorl $16,%2" \
-	: "=r" (ptr), "=r" (base), "=q" (__res) \
-	: "0" (ptr), "1" (base)); \
-__res; })
-
 static void do_int(struct kernel_vm86_regs *regs, int i, unsigned char * ssp, unsigned long sp)
 {
 	unsigned long *intr_ptr, segoffs;
@@ -411,9 +542,9 @@
 		goto cannot_handle;
 	if ((segoffs >> 16) == BIOSSEG)
 		goto cannot_handle;
-	pushw(ssp, sp, get_vflags(regs));
-	pushw(ssp, sp, regs->cs);
-	pushw(ssp, sp, IP(regs));
+	pushw(ssp, sp, get_vflags(regs), regs, VM86_INTx + (i << 8));
+	pushw(ssp, sp, regs->cs, regs, VM86_INTx + (i << 8));
+	pushw(ssp, sp, IP(regs), regs, VM86_INTx + (i << 8));
 	regs->cs = segoffs >> 16;
 	SP(regs) -= 6;
 	IP(regs) = segoffs & 0xffff;
@@ -448,6 +579,22 @@
 	return 0;
 }
 
+/* I guess the most consistent with other stack access like
+ * PUSH AX and similar would be a SIGSEGV, but I really don't
+ * like that so I will just stick to Manfred's solution with
+ * a return code. The SIGSEGV would be harder to implement
+ * here, and also more difficult for userspace code to handle.
+ * I would prefer a new return code, but in order not to mess
+ * up unsuspecting applications I will not invent a new code
+ * yet. Either way we get the problem moved from kernel space
+ * to user space, which is one step in the right direction.
+ * Some existing user space code might even be ready to deal
+ * with VM86_UNKNOWN, since handle_vm86_fault can return that
+ * for so many other reasons as well. I have also fixed the
+ * problem with incorrect IP by moving the increment after the
+ * actual execution of the instruction. [KD]
+ */
+#define VM86_SIGSEGV VM86_UNKNOWN
 void handle_vm86_fault(struct kernel_vm86_regs * regs, long error_code)
 {
 	unsigned char *csp, *ssp;
@@ -455,7 +602,7 @@
 
 #define CHECK_IF_IN_TRAP \
 	if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
-		pushw(ssp,sp,popw(ssp,sp) | TF_MASK);
+		pushw(ssp,sp,popw(ssp,sp, regs, VM86_SIGSEGV) | TF_MASK, regs, VM86_SIGSEGV);
 #define VM86_FAULT_RETURN \
 	if (VMPI.force_return_for_pic  && (VEFLAGS & (IF_MASK | VIF_MASK))) \
 		return_to_32bit(regs, VM86_PICRETURN); \
@@ -466,35 +613,39 @@
 	sp = SP(regs);
 	ip = IP(regs);
 
-	switch (popb(csp, ip)) {
+	switch (popb(csp, ip, regs, VM86_SIGSEGV)) {
 
 	/* operand size override */
 	case 0x66:
-		switch (popb(csp, ip)) {
+		switch (popb(csp, ip, regs, VM86_SIGSEGV)) {
 
 		/* pushfd */
 		case 0x9c:
+			pushl(ssp, sp, get_vflags(regs), regs, VM86_SIGSEGV);
 			SP(regs) -= 4;
 			IP(regs) += 2;
-			pushl(ssp, sp, get_vflags(regs));
 			VM86_FAULT_RETURN;
 
 		/* popfd */
 		case 0x9d:
+			CHECK_IF_IN_TRAP
+			set_vflags_long(popl(ssp, sp, regs, VM86_SIGSEGV), regs);
 			SP(regs) += 4;
 			IP(regs) += 2;
-			CHECK_IF_IN_TRAP
-			set_vflags_long(popl(ssp, sp), regs);
 			VM86_FAULT_RETURN;
 
 		/* iretd */
 		case 0xcf:
-			SP(regs) += 12;
-			IP(regs) = (unsigned short)popl(ssp, sp);
-			regs->cs = (unsigned short)popl(ssp, sp);
+			{
+			unsigned long newip=popl(ssp, sp, regs, VM86_SIGSEGV);
+			unsigned long newcs=popl(ssp, sp, regs, VM86_SIGSEGV);
 			CHECK_IF_IN_TRAP
-			set_vflags_long(popl(ssp, sp), regs);
+			set_vflags_long(popl(ssp, sp, regs, VM86_SIGSEGV), regs);
+			SP(regs) += 12;
+			IP(regs) = (unsigned short)newip;
+			regs->cs = (unsigned short)newcs;
 			VM86_FAULT_RETURN;
+			}
 		/* need this to avoid a fallthrough */
 		default:
 			return_to_32bit(regs, VM86_UNKNOWN);
@@ -502,22 +653,22 @@
 
 	/* pushf */
 	case 0x9c:
+		pushw(ssp, sp, get_vflags(regs), regs, VM86_SIGSEGV);
 		SP(regs) -= 2;
 		IP(regs)++;
-		pushw(ssp, sp, get_vflags(regs));
 		VM86_FAULT_RETURN;
 
 	/* popf */
 	case 0x9d:
+		CHECK_IF_IN_TRAP
+		set_vflags_short(popw(ssp, sp, regs, VM86_SIGSEGV), regs);
 		SP(regs) += 2;
 		IP(regs)++;
-		CHECK_IF_IN_TRAP
-		set_vflags_short(popw(ssp, sp), regs);
 		VM86_FAULT_RETURN;
 
 	/* int xx */
 	case 0xcd: {
-	        int intno=popb(csp, ip);
+	        int intno=popb(csp, ip, regs, VM86_SIGSEGV);
 		IP(regs) += 2;
 		if (VMPI.vm86dbg_active) {
 			if ( (1 << (intno &7)) & VMPI.vm86dbg_intxxtab[intno >> 3] )
@@ -529,12 +680,16 @@
 
 	/* iret */
 	case 0xcf:
-		SP(regs) += 6;
-		IP(regs) = popw(ssp, sp);
-		regs->cs = popw(ssp, sp);
+		{
+		unsigned short newip=popw(ssp, sp, regs, VM86_SIGSEGV);
+		unsigned short newcs=popw(ssp, sp, regs, VM86_SIGSEGV);
 		CHECK_IF_IN_TRAP
-		set_vflags_short(popw(ssp, sp), regs);
+		set_vflags_short(popw(ssp, sp, regs, VM86_SIGSEGV), regs);
+		SP(regs) += 6;
+		IP(regs) = newip;
+		regs->cs = newcs;
 		VM86_FAULT_RETURN;
+		}
 
 	/* cli */
 	case 0xfa:

--------------111A8ED9BF7BE4AC0E202C73--

