Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSLOSvU>; Sun, 15 Dec 2002 13:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbSLOSvU>; Sun, 15 Dec 2002 13:51:20 -0500
Received: from are.twiddle.net ([64.81.246.98]:4736 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262380AbSLOSvM>;
	Sun, 15 Dec 2002 13:51:12 -0500
Date: Sun, 15 Dec 2002 10:57:22 -0800
From: Richard Henderson <rth@twiddle.net>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 on Alpha oopses on mount
Message-ID: <20021215105722.A3831@twiddle.net>
Mail-Followup-To: Matt Reppert <arashi@arashi.yi.org>,
	linux-kernel@vger.kernel.org
References: <20021214123155.7383524c.arashi@arashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021214123155.7383524c.arashi@arashi.yi.org>; from arashi@arashi.yi.org on Sat, Dec 14, 2002 at 12:31:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 12:31:55PM -0600, Matt Reppert wrote:
> >>PC;  fffffc00004a5240 <__copy_user+100/1d4>   <=====
> Trace; fffffc0000385920 <sys_mount+40/160>

This fault is expected and is _supposed_ to be handled by the
exception mechanism.  Why this stopped working, I don't know.

For grins, see if the following helps.  It's something that I
need for the shared-library modules anyway, and it eliminates
an extra variable from the problem.


r~



===== arch/alpha/kernel/traps.c 1.20 vs edited =====
--- 1.20/arch/alpha/kernel/traps.c	Fri Nov  8 05:48:56 2002
+++ edited/arch/alpha/kernel/traps.c	Sat Dec 14 11:24:11 2002
@@ -638,7 +638,7 @@
 got_exception:
 	/* Ok, we caught the exception, but we don't want it.  Is there
 	   someone to pass it along to?  */
-	if ((fixup = search_exception_table(pc, regs.gp)) != 0) {
+	if ((fixup = search_exception_table(pc)) != 0) {
 		unsigned long newpc;
 		newpc = fixup_exception(una_reg, fixup, pc);
 
===== arch/alpha/lib/clear_user.S 1.1 vs edited =====
--- 1.1/arch/alpha/lib/clear_user.S	Tue Feb  5 09:40:21 2002
+++ edited/arch/alpha/lib/clear_user.S	Sat Dec 14 11:12:14 2002
@@ -29,7 +29,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($31); 	\
 	.previous
 
@@ -80,7 +80,6 @@
 	ret	$31, ($28), 1	# .. e1 :
 
 __do_clear_user:
-	ldgp	$29,0($27)	# we do exceptions -- we need the gp.
 	and	$6, 7, $4	# e0    : find dest misalignment
 	beq	$0, $zerolength # .. e1 :
 	addq	$0, $4, $1	# e0    : bias counter
===== arch/alpha/lib/copy_user.S 1.1 vs edited =====
--- 1.1/arch/alpha/lib/copy_user.S	Tue Feb  5 09:40:21 2002
+++ edited/arch/alpha/lib/copy_user.S	Sat Dec 14 11:13:48 2002
@@ -30,29 +30,28 @@
 #define EXI(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitin-99b($31);	\
 	.previous
 
 #define EXO(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitout-99b($31);	\
 	.previous
 
 	.set noat
-	.align 3
+	.align 4
 	.globl __copy_user
 	.ent __copy_user
 __copy_user:
-	ldgp $29,0($27)			# we do exceptions -- we need the gp.
-	.prologue 1
+	.prologue 0
 	and $6,7,$3
 	beq $0,$35
 	beq $3,$36
 	subq $3,8,$3
-	.align 5
+	.align 4
 $37:
 	EXI( ldq_u $1,0($7) )
 	EXO( ldq_u $2,0($6) )
@@ -73,7 +72,7 @@
 	beq $1,$43
 	beq $4,$48
 	EXI( ldq_u $3,0($7) )
-	.align 5
+	.align 4
 $50:
 	EXI( ldq_u $2,8($7) )
 	subq $4,8,$4
@@ -88,7 +87,7 @@
 	bne $4,$50
 $48:
 	beq $0,$41
-	.align 5
+	.align 4
 $57:
 	EXI( ldq_u $1,0($7) )
 	EXO( ldq_u $2,0($6) )
@@ -105,7 +104,7 @@
 	.align 4
 $43:
 	beq $4,$65
-	.align 5
+	.align 4
 $66:
 	EXI( ldq $1,0($7) )
 	subq $4,8,$4
===== arch/alpha/lib/ev6-clear_user.S 1.1 vs edited =====
--- 1.1/arch/alpha/lib/ev6-clear_user.S	Tue Feb  5 09:40:22 2002
+++ edited/arch/alpha/lib/ev6-clear_user.S	Sat Dec 14 11:14:24 2002
@@ -47,7 +47,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($31); 	\
 	.previous
 
@@ -62,9 +62,6 @@
 
 				# Pipeline info : Slotting & Comments
 __do_clear_user:
-	ldgp	$29,0($27)	# we do exceptions -- we need the gp.
-				# Macro instruction becomes ldah/lda
-				# .. .. E  E	:
 	and	$6, 7, $4	# .. E  .. ..	: find dest head misalignment
 	beq	$0, $zerolength # U  .. .. ..	:  U L U L
 
===== arch/alpha/lib/ev6-copy_user.S 1.1 vs edited =====
--- 1.1/arch/alpha/lib/ev6-copy_user.S	Tue Feb  5 09:40:22 2002
+++ edited/arch/alpha/lib/ev6-copy_user.S	Sat Dec 14 11:14:59 2002
@@ -41,14 +41,14 @@
 #define EXI(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitin-99b($31);	\
 	.previous
 
 #define EXO(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exitout-99b($31);	\
 	.previous
 
@@ -58,10 +58,7 @@
 	.ent __copy_user
 				# Pipeline info: Slotting & Comments
 __copy_user:
-	ldgp $29,0($27)		# we do exceptions -- we need the gp.
-				# Macro instruction becomes ldah/lda
-				# .. .. E  E
-	.prologue 1
+	.prologue 0
 	subq $0, 32, $1		# .. E  .. ..	: Is this going to be a small copy?
 	beq $0, $zerolength	# U  .. .. ..	: U L U L
 
===== arch/alpha/lib/ev6-strncpy_from_user.S 1.2 vs edited =====
--- 1.2/arch/alpha/lib/ev6-strncpy_from_user.S	Thu Aug  8 12:28:01 2002
+++ edited/arch/alpha/lib/ev6-strncpy_from_user.S	Sat Dec 14 11:16:49 2002
@@ -34,7 +34,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($0); 	\
 	.previous
 
@@ -46,11 +46,10 @@
 	.globl __strncpy_from_user
 	.ent __strncpy_from_user
 	.frame $30, 0, $26
-	.prologue 1
+	.prologue 0
 
 	.align 4
 __strncpy_from_user:
-	ldgp	$29, 0($27)	# E E : becomes 2 instructions (for exceptions)
 	and	a0, 7, t3	# E : find dest misalignment
 	beq	a2, $zerolength	# U :
 
===== arch/alpha/lib/ev67-strlen_user.S 1.2 vs edited =====
--- 1.2/arch/alpha/lib/ev67-strlen_user.S	Thu Aug  8 12:28:01 2002
+++ edited/arch/alpha/lib/ev67-strlen_user.S	Sat Dec 14 11:15:49 2002
@@ -30,7 +30,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda v0, $exception-99b(zero);	\
 	.previous
 
@@ -56,9 +56,7 @@
 
 	.align 4
 __strnlen_user:
-	ldgp	$29,0($27)	# E E : we do exceptions -- we need the gp.
-				/* Decomposes into lda/ldah */
-	.prologue 1
+	.prologue 0
 	EX( ldq_u t0, 0(a0) )	# L : load first quadword (a0 may be misaligned)
 	lda     t1, -1(zero)	# E :
 
===== arch/alpha/lib/strlen_user.S 1.2 vs edited =====
--- 1.2/arch/alpha/lib/strlen_user.S	Thu Aug  8 12:28:01 2002
+++ edited/arch/alpha/lib/strlen_user.S	Sat Dec 14 11:16:04 2002
@@ -19,7 +19,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda v0, $exception-99b(zero);	\
 	.previous
 
@@ -42,8 +42,7 @@
 
 	.align 3
 __strnlen_user:
-	ldgp	$29,0($27)	# we do exceptions -- we need the gp.
-	.prologue 1
+	.prologue 0
 
 	EX( ldq_u t0, 0(a0) )	# load first quadword (a0 may be misaligned)
 	lda     t1, -1(zero)
===== arch/alpha/lib/strncpy_from_user.S 1.2 vs edited =====
--- 1.2/arch/alpha/lib/strncpy_from_user.S	Thu Aug  8 12:28:01 2002
+++ edited/arch/alpha/lib/strncpy_from_user.S	Sat Dec 14 11:17:01 2002
@@ -19,7 +19,7 @@
 #define EX(x,y...)			\
 	99: x,##y;			\
 	.section __ex_table,"a";	\
-	.gprel32 99b;			\
+	.long 99b - .;			\
 	lda $31, $exception-99b($0); 	\
 	.previous
 
@@ -31,7 +31,7 @@
 	.globl __strncpy_from_user
 	.ent __strncpy_from_user
 	.frame $30, 0, $26
-	.prologue 1
+	.prologue 0
 
 	.align 3
 $aligned:
@@ -100,8 +100,6 @@
 	/*** The Function Entry Point ***/
 	.align 3
 __strncpy_from_user:
-	ldgp	$29, 0($27)	# we do exceptions -- we need the gp.
-
 	mov	a0, v0		# save the string start
 	beq	a2, $zerolength
 
===== arch/alpha/mm/extable.c 1.2 vs edited =====
--- 1.2/arch/alpha/mm/extable.c	Mon Feb  4 23:40:23 2002
+++ edited/arch/alpha/mm/extable.c	Sat Dec 14 11:23:06 2002
@@ -12,21 +12,17 @@
 static inline unsigned
 search_one_table(const struct exception_table_entry *first,
 		 const struct exception_table_entry *last,
-		 signed long value)
+		 unsigned long value)
 {
-	/* Abort early if the search value is out of range.  */
-	if (value != (signed int)value)
-		return 0;
-
         while (first <= last) {
 		const struct exception_table_entry *mid;
-		long diff;
+		unsigned long mid_value;
 
 		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
+		mid_value = (unsigned long)&mid->insn + mid->insn;
+                if (mid_value == value)
                         return mid->fixup.unit;
-                else if (diff < 0)
+                else if (mid_value < value)
                         first = mid+1;
                 else
                         last = mid-1;
@@ -34,48 +30,13 @@
         return 0;
 }
 
-register unsigned long gp __asm__("$29");
-
-static unsigned
-search_exception_table_without_gp(unsigned long addr)
-{
-	unsigned ret;
-
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table - 1,
-			       addr - gp);
-#else
-	extern spinlock_t modlist_lock;
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special. */
-	struct module *mp;
-
-	ret = 0;
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
-			continue;
-		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end - 1, addr - mp->gp);
-		if (ret)
-			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
-#endif
-
-	return ret;
-}
-
 unsigned
-search_exception_table(unsigned long addr, unsigned long exc_gp)
+search_exception_table(unsigned long addr)
 {
 	unsigned ret;
 
 #ifndef CONFIG_MODULES
-	ret = search_one_table(__start___ex_table, __stop___ex_table - 1,
-			       addr - exc_gp);
-	if (ret) return ret;
+	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 #else
 	extern spinlock_t modlist_lock;
 	unsigned long flags;
@@ -88,25 +49,12 @@
 		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
 			continue;
 		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end - 1, addr - exc_gp);
+				       mp->ex_table_end - 1, addr);
 		if (ret)
 			break;
 	}
 	spin_unlock_irqrestore(&modlist_lock, flags);
-	if (ret) return ret;
 #endif
 
-	/*
-	 * The search failed with the exception gp. To be safe, try the
-	 * old method before giving up.
-	 */
-	ret = search_exception_table_without_gp(addr);
-	if (ret) {
-		printk(KERN_ALERT "%s: [%lx] EX_TABLE search fail with"
-		       "exc frame GP, success with raw GP\n",
-		       current->comm, addr);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
===== arch/alpha/mm/fault.c 1.8 vs edited =====
--- 1.8/arch/alpha/mm/fault.c	Wed Oct 30 10:42:09 2002
+++ edited/arch/alpha/mm/fault.c	Sat Dec 14 11:23:31 2002
@@ -176,7 +176,7 @@
 
  no_context:
 	/* Are we prepared to handle this fault as an exception?  */
-	if ((fixup = search_exception_table(regs->pc, regs->gp)) != 0) {
+	if ((fixup = search_exception_table(regs->pc)) != 0) {
 		unsigned long newpc;
 		newpc = fixup_exception(dpf_reg, fixup, regs->pc);
 		regs->pc = newpc;
===== include/asm-alpha/uaccess.h 1.2 vs edited =====
--- 1.2/include/asm-alpha/uaccess.h	Mon Feb 11 05:42:53 2002
+++ edited/include/asm-alpha/uaccess.h	Sat Dec 14 11:18:49 2002
@@ -126,7 +126,7 @@
 	__asm__("1: ldq %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -136,7 +136,7 @@
 	__asm__("1: ldl %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -149,7 +149,7 @@
 	__asm__("1: ldwu %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -159,7 +159,7 @@
 	__asm__("1: ldbu %0,%2\n"			\
 	"2:\n"						\
 	".section __ex_table,\"a\"\n"			\
-	"	.gprel32 1b\n"				\
+	"	.long 1b - .\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
@@ -178,10 +178,10 @@
 	"	or %0,%1,%0\n"						\
 	"3:\n"								\
 	".section __ex_table,\"a\"\n"					\
-	"	.gprel32 1b\n"						\
+	"	.long 1b - .\n"						\
 	"	lda %0, 3b-1b(%2)\n"					\
-	"	.gprel32 2b\n"						\
-	"	lda %0, 2b-1b(%2)\n"					\
+	"	.long 2b - .\n"						\
+	"	lda %0, 3b-2b(%2)\n"					\
 	".previous"							\
 		: "=&r"(__gu_val), "=&r"(__gu_tmp), "=r"(__gu_err)	\
 		: "r"(addr), "2"(__gu_err));				\
@@ -192,7 +192,7 @@
 	"	extbl %0,%2,%0\n"					\
 	"2:\n"								\
 	".section __ex_table,\"a\"\n"					\
-	"	.gprel32 1b\n"						\
+	"	.long 1b - .\n"						\
 	"	lda %0, 2b-1b(%1)\n"					\
 	".previous"							\
 		: "=&r"(__gu_val), "=r"(__gu_err)			\
@@ -240,7 +240,7 @@
 __asm__ __volatile__("1: stq %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -250,7 +250,7 @@
 __asm__ __volatile__("1: stl %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -263,7 +263,7 @@
 __asm__ __volatile__("1: stw %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -273,7 +273,7 @@
 __asm__ __volatile__("1: stb %r2,%1\n"				\
 	"2:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err)				\
@@ -298,13 +298,13 @@
 	"4:	stq_u %1,0(%5)\n"				\
 	"5:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31, 5b-1b(%0)\n"				\
-	"	.gprel32 2b\n"					\
+	"	.long 2b - .\n"					\
 	"	lda $31, 5b-2b(%0)\n"				\
-	"	.gprel32 3b\n"					\
+	"	.long 3b - .\n"					\
 	"	lda $31, 5b-3b(%0)\n"				\
-	"	.gprel32 4b\n"					\
+	"	.long 4b - .\n"					\
 	"	lda $31, 5b-4b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err), "=&r"(__pu_tmp1),		\
@@ -324,9 +324,9 @@
 	"2:	stq_u %1,0(%4)\n"				\
 	"3:\n"							\
 	".section __ex_table,\"a\"\n"				\
-	"	.gprel32 1b\n"					\
+	"	.long 1b - .\n"					\
 	"	lda $31, 3b-1b(%0)\n"				\
-	"	.gprel32 2b\n"					\
+	"	.long 2b - .\n"					\
 	"	lda $31, 3b-2b(%0)\n"				\
 	".previous"						\
 		: "=r"(__pu_err),				\
@@ -356,7 +356,7 @@
 	register long __cu_len __asm__("$0") = len;
 
 	__asm__ __volatile__(
-		"jsr $28,(%3),__copy_user\n\tldgp $29,0($28)"
+		"jsr $28,(%3),__copy_user"
 		: "=r" (__cu_len), "=r" (__cu_from), "=r" (__cu_to), "=r"(pv)
 		: "0" (__cu_len), "1" (__cu_from), "2" (__cu_to), "3"(pv)
 		: "$1","$2","$3","$4","$5","$28","memory");
@@ -373,7 +373,7 @@
 		register const void * __cu_from __asm__("$7") = from;
 		register long __cu_len __asm__("$0") = len;
 		__asm__ __volatile__(
-			"jsr $28,(%3),__copy_user\n\tldgp $29,0($28)"
+			"jsr $28,(%3),__copy_user"
 			: "=r"(__cu_len), "=r"(__cu_from), "=r"(__cu_to),
 			  "=r" (pv)
 			: "0" (__cu_len), "1" (__cu_from), "2" (__cu_to), 
@@ -413,7 +413,7 @@
 	register void * __cl_to __asm__("$6") = to;
 	register long __cl_len __asm__("$0") = len;
 	__asm__ __volatile__(
-		"jsr $28,(%2),__do_clear_user\n\tldgp $29,0($28)"
+		"jsr $28,(%2),__do_clear_user"
 		: "=r"(__cl_len), "=r"(__cl_to), "=r"(pv)
 		: "0"(__cl_len), "1"(__cl_to), "2"(pv)
 		: "$1","$2","$3","$4","$5","$28","memory");
@@ -428,7 +428,7 @@
 		register void * __cl_to __asm__("$6") = to;
 		register long __cl_len __asm__("$0") = len;
 		__asm__ __volatile__(
-			"jsr $28,(%2),__do_clear_user\n\tldgp $29,0($28)"
+			"jsr $28,(%2),__do_clear_user"
 			: "=r"(__cl_len), "=r"(__cl_to), "=r"(pv)
 			: "0"(__cl_len), "1"(__cl_to), "2"(pv)
 			: "$1","$2","$3","$4","$5","$28","memory");
@@ -471,7 +471,7 @@
 /*
  * About the exception table:
  *
- * - insn is a 32-bit offset off of the kernel's or module's gp.
+ * - insn is a 32-bit pc-relative offset from the faulting insn.
  * - nextinsn is a 16-bit offset off of the faulting instruction
  *   (not off of the *next* instruction as branches are).
  * - errreg is the register in which to place -EFAULT.
@@ -502,7 +502,7 @@
 };
 
 /* Returns 0 if exception not found and fixup.unit otherwise.  */
-extern unsigned search_exception_table(unsigned long, unsigned long);
+extern unsigned search_exception_table(unsigned long);
 
 /* Returns the new pc */
 #define fixup_exception(map_reg, fixup_unit, pc)		\
