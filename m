Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313160AbSDINLh>; Tue, 9 Apr 2002 09:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313161AbSDINLh>; Tue, 9 Apr 2002 09:11:37 -0400
Received: from horse05.daimi.au.dk ([130.225.18.245]:25499 "EHLO
	horse05.daimi.au.dk") by vger.kernel.org with ESMTP
	id <S313160AbSDINLe>; Tue, 9 Apr 2002 09:11:34 -0400
Message-ID: <3CB2E716.2FADB9F8@daimi.au.dk>
Date: Tue, 09 Apr 2002 15:05:26 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] More VM86 fixes
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully this time we have a bugfix that doesn't introduce new bugs:

http://www.daimi.au.dk/~kasperd/linux_kernel/vm86.2.4.19-pre5-ac3.patch

Stas will you verify that I have done the changes we agreed on, and
that it didn't break anything obvious this time. (This time I tested
both pcemu and dosemu, both seems to work correctly. ;-) )

There is still one remaining problem, how can we do the SIGSEGV at the
bottom of handle_vm6_fault function. The signal context needs info
from the exception handler that has just returned. Any good ideas will
be apprechiated. (The current implementation is wrong, but can be
handled correctly in userspace if the caller knows about it unlike the
original version which would oops.)

diff -Nur linux-2.4.19-pre5-ac3/arch/i386/kernel/vm86.c linux-2.4.19-pre5-ac3-kd/arch/i386/kernel/vm86.c
--- linux-2.4.19-pre5-ac3/arch/i386/kernel/vm86.c	Tue Apr  9 09:33:11 2002
+++ linux-2.4.19-pre5-ac3-kd/arch/i386/kernel/vm86.c	Tue Apr  9 10:07:50 2002
@@ -2,12 +2,32 @@
  *  linux/kernel/vm86.c
  *
  *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- *  Bugfixes Copyright 2002 by Manfred Spraul and
- *  Kasper Dupont <kasperd@daimi.au.dk>
  *
+ *  29 dec 2001 - Fixed oopses caused by unchecked access to the vm86
+ *                stack - Manfred Spraul <manfreds@colorfullife.com>
+ *
+ *  22 mar 2002 - Manfred detected the stackfaults, but didn't handle
+ *                them correctly. Now the emulation will be in a
+ *                consistent state after stackfaults - Kasper Dupont
+ *                <kasperd@daimi.au.dk>
+ *
+ *  22 mar 2002 - Added missing clear_IF in set_vflags_* Kasper Dupont
+ *                <kasperd@daimi.au.dk>
+ *
+ *  ?? ??? 2002 - Fixed premature returns from handle_vm86_fault
+ *                caused by Kasper Dupont's changes - Stas Sergeev
+ *
+ *   4 apr 2002 - Fixed CHECK_IF_IN_TRAP broken by Stas' changes.
+ *                Kasper Dupont <kasperd@daimi.au.dk>
+ *
+ *   9 apr 2002 - Changed syntax of macros in handle_vm86_fault.
+ *                Kasper Dupont <kasperd@daimi.au.dk>
+ *
+ *   9 apr 2002 - Changed stack access macros to jump to a label
+ *                instead of returning to userspace. This simplifies
+ *                do_int, and is needed by handle_vm6_fault. Kasper
+ *                Dupont <kasperd@daimi.au.dk>
+ *   
  */
 
 #include <linux/errno.h>
@@ -350,10 +370,13 @@
  * Gcc makes a mess of it, so we do it inline and use non-obvious calling
  * conventions..
  * FIXME: is VM86_UNKNOWN really the correct return code? [MS??]
- * No that wasn't correct, it depends on the context, so lets
- * make it an argument to the macro. [KD]
+ * No that wasn't correct, instead we jump to a label given as
+ * argument. In do_int the label already existed, in handle_vm86_fault
+ * it had to be created. Can this be optimized so error handling get
+ * out of the default execution path by using the address of the
+ * label as fixup address? [KD]
  */
-#define pushb(base, ptr, val, regs, errcode) \
+#define pushb(base, ptr, val, err_label) \
 	do { \
 		int err; \
 		__asm__ __volatile__(				\
@@ -372,10 +395,10 @@
 			: "=r" (ptr), "=r" (err)		\
 			: "r" (base), "q" (val), "0" (ptr));	\
 		if (err) \
-			return_to_32bit(regs, errcode); \
+			goto err_label; \
 	} while(0)
 
-#define pushw(base, ptr, val, regs, errcode) \
+#define pushw(base, ptr, val, err_label) \
 	do { \
 		int err; \
 		__asm__ __volatile__(				\
@@ -397,10 +420,10 @@
 			: "=r" (ptr), "=r" (err)		\
 			: "r" (base), "q" (val), "0" (ptr));	\
 		if (err) \
-			return_to_32bit(regs, errcode); \
+			goto err_label; \
 	} while(0)
 
-#define pushl(base, ptr, val, regs, errcode) \
+#define pushl(base, ptr, val, err_label) \
 	do { \
 		int err; \
 		__asm__ __volatile__(				\
@@ -430,10 +453,10 @@
 			: "=r" (ptr), "=r" (err)		\
 			: "r" (base), "q" (val), "0" (ptr));	\
 		if (err) \
-			return_to_32bit(regs, errcode); \
+			goto err_label; \
 	} while(0)
 
-#define popb(base, ptr, regs, errcode) \
+#define popb(base, ptr, err_label) \
 	({ \
 	 	unsigned long __res; \
 	 	unsigned int err; \
@@ -454,11 +477,11 @@
 				"=r" (err) \
 			: "0" (ptr), "1" (base), "2" (0)); \
 		if (err) \
-			return_to_32bit(regs, errcode); \
+			goto err_label; \
 		__res; \
 	})
 
-#define popw(base, ptr, regs, errcode) \
+#define popw(base, ptr, err_label) \
 	({ \
 	 	unsigned long __res; \
 	 	unsigned int err; \
@@ -482,11 +505,11 @@
 				"=r" (err) \
 			: "0" (ptr), "1" (base), "2" (0)); \
 		if (err) \
-			return_to_32bit(regs, errcode); \
+			goto err_label; \
 		__res; \
 	})
 
-#define popl(base, ptr, regs, errcode) \
+#define popl(base, ptr, err_label) \
 	({ \
 	 	unsigned long __res; \
 	 	unsigned int err; \
@@ -518,7 +541,7 @@
 				"=r" (err) \
 			: "0" (ptr), "1" (base), "2" (0)); \
 		if (err) \
-			return_to_32bit(regs, errcode); \
+			goto err_label; \
 		__res; \
 	})
 
@@ -542,9 +565,9 @@
 		goto cannot_handle;
 	if ((segoffs >> 16) == BIOSSEG)
 		goto cannot_handle;
-	pushw(ssp, sp, get_vflags(regs), regs, VM86_INTx + (i << 8));
-	pushw(ssp, sp, regs->cs, regs, VM86_INTx + (i << 8));
-	pushw(ssp, sp, IP(regs), regs, VM86_INTx + (i << 8));
+	pushw(ssp, sp, get_vflags(regs), cannot_handle);
+	pushw(ssp, sp, regs->cs, cannot_handle);
+	pushw(ssp, sp, IP(regs), cannot_handle);
 	regs->cs = segoffs >> 16;
 	SP(regs) -= 6;
 	IP(regs) = segoffs & 0xffff;
@@ -579,22 +602,6 @@
 	return 0;
 }
 
-/* I guess the most consistent with other stack access like
- * PUSH AX and similar would be a SIGSEGV, but I really don't
- * like that so I will just stick to Manfred's solution with
- * a return code. The SIGSEGV would be harder to implement
- * here, and also more difficult for userspace code to handle.
- * I would prefer a new return code, but in order not to mess
- * up unsuspecting applications I will not invent a new code
- * yet. Either way we get the problem moved from kernel space
- * to user space, which is one step in the right direction.
- * Some existing user space code might even be ready to deal
- * with VM86_UNKNOWN, since handle_vm86_fault can return that
- * for so many other reasons as well. I have also fixed the
- * problem with incorrect IP by moving the increment after the
- * actual execution of the instruction. [KD]
- */
-#define VM86_SIGSEGV VM86_UNKNOWN
 void handle_vm86_fault(struct kernel_vm86_regs * regs, long error_code)
 {
 	unsigned char *csp, *ssp;
@@ -602,26 +609,26 @@
 
 #define CHECK_IF_IN_TRAP \
 	if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
-		pushw(ssp,sp,popw(ssp,sp, regs, VM86_SIGSEGV) | TF_MASK, regs, VM86_SIGSEGV);
-#define VM86_FAULT_RETURN \
+		newflags |= TF_MASK
+#define VM86_FAULT_RETURN do { \
 	if (VMPI.force_return_for_pic  && (VEFLAGS & (IF_MASK | VIF_MASK))) \
 		return_to_32bit(regs, VM86_PICRETURN); \
-	return;
+	return; } while (0)
 	                                   
 	csp = (unsigned char *) (regs->cs << 4);
 	ssp = (unsigned char *) (regs->ss << 4);
 	sp = SP(regs);
 	ip = IP(regs);
 
-	switch (popb(csp, ip, regs, VM86_SIGSEGV)) {
+	switch (popb(csp, ip, simulate_sigsegv)) {
 
 	/* operand size override */
 	case 0x66:
-		switch (popb(csp, ip, regs, VM86_SIGSEGV)) {
+		switch (popb(csp, ip, simulate_sigsegv)) {
 
 		/* pushfd */
 		case 0x9c:
-			pushl(ssp, sp, get_vflags(regs), regs, VM86_SIGSEGV);
+			pushl(ssp, sp, get_vflags(regs), simulate_sigsegv);
 			SP(regs) -= 4;
 			IP(regs) += 2;
 			VM86_FAULT_RETURN;
@@ -629,10 +636,10 @@
 		/* popfd */
 		case 0x9d:
 			{
-			unsigned long newflags=popl(ssp, sp, regs, VM86_SIGSEGV);
+			unsigned long newflags=popl(ssp, sp, simulate_sigsegv);
 			SP(regs) += 4;
 			IP(regs) += 2;
-			CHECK_IF_IN_TRAP
+			CHECK_IF_IN_TRAP;
 			set_vflags_long(newflags, regs);
 			VM86_FAULT_RETURN;
 			}
@@ -640,13 +647,13 @@
 		/* iretd */
 		case 0xcf:
 			{
-			unsigned long newip=popl(ssp, sp, regs, VM86_SIGSEGV);
-			unsigned long newcs=popl(ssp, sp, regs, VM86_SIGSEGV);
-			unsigned long newflags=popl(ssp, sp, regs, VM86_SIGSEGV);
+			unsigned long newip=popl(ssp, sp, simulate_sigsegv);
+			unsigned long newcs=popl(ssp, sp, simulate_sigsegv);
+			unsigned long newflags=popl(ssp, sp, simulate_sigsegv);
 			SP(regs) += 12;
 			IP(regs) = (unsigned short)newip;
 			regs->cs = (unsigned short)newcs;
-			CHECK_IF_IN_TRAP
+			CHECK_IF_IN_TRAP;
 			set_vflags_long(newflags, regs);
 			VM86_FAULT_RETURN;
 			}
@@ -657,7 +664,7 @@
 
 	/* pushf */
 	case 0x9c:
-		pushw(ssp, sp, get_vflags(regs), regs, VM86_SIGSEGV);
+		pushw(ssp, sp, get_vflags(regs), simulate_sigsegv);
 		SP(regs) -= 2;
 		IP(regs)++;
 		VM86_FAULT_RETURN;
@@ -665,17 +672,17 @@
 	/* popf */
 	case 0x9d:
 		{
-		unsigned short newflags=popw(ssp, sp, regs, VM86_SIGSEGV);
+		unsigned short newflags=popw(ssp, sp, simulate_sigsegv);
 		SP(regs) += 2;
 		IP(regs)++;
-		CHECK_IF_IN_TRAP
+		CHECK_IF_IN_TRAP;
 		set_vflags_short(newflags, regs);
 		VM86_FAULT_RETURN;
 		}
 
 	/* int xx */
 	case 0xcd: {
-	        int intno=popb(csp, ip, regs, VM86_SIGSEGV);
+	        int intno=popb(csp, ip, simulate_sigsegv);
 		IP(regs) += 2;
 		if (VMPI.vm86dbg_active) {
 			if ( (1 << (intno &7)) & VMPI.vm86dbg_intxxtab[intno >> 3] )
@@ -688,13 +695,13 @@
 	/* iret */
 	case 0xcf:
 		{
-		unsigned short newip=popw(ssp, sp, regs, VM86_SIGSEGV);
-		unsigned short newcs=popw(ssp, sp, regs, VM86_SIGSEGV);
-		unsigned short newflags=popw(ssp, sp, regs, VM86_SIGSEGV);
+		unsigned short newip=popw(ssp, sp, simulate_sigsegv);
+		unsigned short newcs=popw(ssp, sp, simulate_sigsegv);
+		unsigned short newflags=popw(ssp, sp, simulate_sigsegv);
 		SP(regs) += 6;
 		IP(regs) = newip;
 		regs->cs = newcs;
-		CHECK_IF_IN_TRAP
+		CHECK_IF_IN_TRAP;
 		set_vflags_short(newflags, regs);
 		VM86_FAULT_RETURN;
 		}
@@ -720,6 +727,21 @@
 	default:
 		return_to_32bit(regs, VM86_UNKNOWN);
 	}
+
+	return;
+
+simulate_sigsegv:
+	/* FIXME: After a long discussion with Stas we finally
+	 *        agreed, that this is wrong. Here we should
+	 *        really send a SIGSEGV to the user program.
+	 *        But how do we create the correct context? We
+	 *        are inside a general protection fault handler
+	 *        and has just returned from a page fault handler.
+	 *        The correct context for the signal handler
+	 *        should be a mixture of the two, but how do we
+	 *        get the information? [KD]
+	 */
+	return_to_32bit(regs, VM86_UNKNOWN);
 }
 
 /* ---------------- vm86 special IRQ passing stuff ----------------- */

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
