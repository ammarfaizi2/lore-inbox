Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285704AbRLYSnl>; Tue, 25 Dec 2001 13:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285709AbRLYSnc>; Tue, 25 Dec 2001 13:43:32 -0500
Received: from colorfullife.com ([216.156.138.34]:6161 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285704AbRLYSnT>;
	Tue, 25 Dec 2001 13:43:19 -0500
Message-ID: <3C28C8C5.29C433ED@colorfullife.com>
Date: Tue, 25 Dec 2001 19:43:17 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17-rc2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: stas.orel@mailcity.com
Subject: [CFT] error checking for VM86 instruction emulation
Content-Type: multipart/mixed;
 boundary="------------F05A0B9CD872E14A3C7398C9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F05A0B9CD872E14A3C7398C9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The emulation code for the instructions that cannot be executed in vm86
mode directly (iretd, pushf and a few others) accesses user space memory
without an exception handler. This can cause a kernel oops if the stack
pointer points to non-present or read-only memory areas.

The attached patch adds these handlers, but I can't test them properly.
Under 2.5.2-pre1, dosemu still runs.

The patch applies to both 2.4.17 and 2.2.20. Please test it.

--
	Manfred
--------------F05A0B9CD872E14A3C7398C9
Content-Type: text/plain; charset=us-ascii;
 name="patch-vm86"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-vm86"

--- 2.5/arch/i386/kernel/vm86.c	Fri Dec 21 21:28:52 2001
+++ build-2.5/arch/i386/kernel/vm86.c	Tue Dec 25 18:44:25 2001
@@ -326,74 +326,176 @@
  * Boy are these ugly, but we need to do the correct 16-bit arithmetic.
  * Gcc makes a mess of it, so we do it inline and use non-obvious calling
  * conventions..
+ * FIXME: is VM86_UNKNOWN really the correct return code?
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
+#define pushb(base, ptr, val, regs) \
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
+			return_to_32bit(regs, VM86_UNKNOWN); \
+	} while(0)
+
+#define pushw(base, ptr, val, regs) \
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
+			return_to_32bit(regs, VM86_UNKNOWN); \
+	} while(0)
+
+#define pushl(base, ptr, val, regs) \
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
+			return_to_32bit(regs, VM86_UNKNOWN); \
+	} while(0)
+
+#define popb(base, ptr, regs) \
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
+			return_to_32bit(regs, VM86_UNKNOWN); \
+		__res; \
+	})
+
+#define popw(base, ptr, regs) \
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
+			return_to_32bit(regs, VM86_UNKNOWN); \
+		__res; \
+	})
+
+#define popl(base, ptr, regs) \
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
+			return_to_32bit(regs, VM86_UNKNOWN); \
+		__res; \
+	})
 
 static void do_int(struct kernel_vm86_regs *regs, int i, unsigned char * ssp, unsigned long sp)
 {
@@ -410,9 +512,9 @@
 		goto cannot_handle;
 	if ((segoffs >> 16) == BIOSSEG)
 		goto cannot_handle;
-	pushw(ssp, sp, get_vflags(regs));
-	pushw(ssp, sp, regs->cs);
-	pushw(ssp, sp, IP(regs));
+	pushw(ssp, sp, get_vflags(regs), regs);
+	pushw(ssp, sp, regs->cs, regs);
+	pushw(ssp, sp, IP(regs), regs);
 	regs->cs = segoffs >> 16;
 	SP(regs) -= 6;
 	IP(regs) = segoffs & 0xffff;
@@ -454,7 +556,7 @@
 
 #define CHECK_IF_IN_TRAP \
 	if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
-		pushw(ssp,sp,popw(ssp,sp) | TF_MASK);
+		pushw(ssp,sp,popw(ssp,sp, regs) | TF_MASK, regs);
 #define VM86_FAULT_RETURN \
 	if (VMPI.force_return_for_pic  && (VEFLAGS & (IF_MASK | VIF_MASK))) \
 		return_to_32bit(regs, VM86_PICRETURN); \
@@ -465,17 +567,17 @@
 	sp = SP(regs);
 	ip = IP(regs);
 
-	switch (popb(csp, ip)) {
+	switch (popb(csp, ip, regs)) {
 
 	/* operand size override */
 	case 0x66:
-		switch (popb(csp, ip)) {
+		switch (popb(csp, ip, regs)) {
 
 		/* pushfd */
 		case 0x9c:
 			SP(regs) -= 4;
 			IP(regs) += 2;
-			pushl(ssp, sp, get_vflags(regs));
+			pushl(ssp, sp, get_vflags(regs), regs);
 			VM86_FAULT_RETURN;
 
 		/* popfd */
@@ -483,16 +585,16 @@
 			SP(regs) += 4;
 			IP(regs) += 2;
 			CHECK_IF_IN_TRAP
-			set_vflags_long(popl(ssp, sp), regs);
+			set_vflags_long(popl(ssp, sp, regs), regs);
 			VM86_FAULT_RETURN;
 
 		/* iretd */
 		case 0xcf:
 			SP(regs) += 12;
-			IP(regs) = (unsigned short)popl(ssp, sp);
-			regs->cs = (unsigned short)popl(ssp, sp);
+			IP(regs) = (unsigned short)popl(ssp, sp, regs);
+			regs->cs = (unsigned short)popl(ssp, sp, regs);
 			CHECK_IF_IN_TRAP
-			set_vflags_long(popl(ssp, sp), regs);
+			set_vflags_long(popl(ssp, sp, regs), regs);
 			VM86_FAULT_RETURN;
 		/* need this to avoid a fallthrough */
 		default:
@@ -503,7 +605,7 @@
 	case 0x9c:
 		SP(regs) -= 2;
 		IP(regs)++;
-		pushw(ssp, sp, get_vflags(regs));
+		pushw(ssp, sp, get_vflags(regs), regs);
 		VM86_FAULT_RETURN;
 
 	/* popf */
@@ -511,12 +613,12 @@
 		SP(regs) += 2;
 		IP(regs)++;
 		CHECK_IF_IN_TRAP
-		set_vflags_short(popw(ssp, sp), regs);
+		set_vflags_short(popw(ssp, sp, regs), regs);
 		VM86_FAULT_RETURN;
 
 	/* int xx */
 	case 0xcd: {
-	        int intno=popb(csp, ip);
+	        int intno=popb(csp, ip, regs);
 		IP(regs) += 2;
 		if (VMPI.vm86dbg_active) {
 			if ( (1 << (intno &7)) & VMPI.vm86dbg_intxxtab[intno >> 3] )
@@ -529,10 +631,10 @@
 	/* iret */
 	case 0xcf:
 		SP(regs) += 6;
-		IP(regs) = popw(ssp, sp);
-		regs->cs = popw(ssp, sp);
+		IP(regs) = popw(ssp, sp, regs);
+		regs->cs = popw(ssp, sp, regs);
 		CHECK_IF_IN_TRAP
-		set_vflags_short(popw(ssp, sp), regs);
+		set_vflags_short(popw(ssp, sp, regs), regs);
 		VM86_FAULT_RETURN;
 
 	/* cli */

--------------F05A0B9CD872E14A3C7398C9--

