Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUJHF2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUJHF2C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 01:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUJHF2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 01:28:02 -0400
Received: from ozlabs.org ([203.10.76.45]:1755 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267785AbUJHF1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 01:27:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16742.10154.523798.177319@cargo.ozlabs.ibm.com>
Date: Fri, 8 Oct 2004 15:37:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Replace cmp instructions with cmpw/cmpd
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few places in assembly code in the ppc64 part of the
kernel where we were using the old forms of the compare instruction
(cmp, cmpi, cmpl, cmpli) which don't specify the operand size (word or
doubleword).  These have been accepted for a long time for backward
compatibility with the old POWER architecture (and defaulted to a
32-bit comparison) but are now being rejected by the latest versions
of binutils.  Some of them were actual bugs in that they were on
things which were actually 64-bit values such as pointers (not that
any of them actually caused a problem in practice).

This patch replaces cmp{,l}{,i} with cmp{,l}[wd]{,i} as appropriate.
The original patch was from Segher Boessenkool, slightly modified by
me.  Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/entry.S g5-ppc64/arch/ppc64/kernel/entry.S
--- linux-2.5/arch/ppc64/kernel/entry.S	2004-09-24 15:23:06.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/entry.S	2004-10-08 07:52:15.781520816 +1000
@@ -122,7 +122,7 @@
 	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
-	cmpli	0,r0,NR_syscalls
+	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
 
 system_call:			/* label this so stack traces look sane */
@@ -204,7 +204,7 @@
 
 syscall_error:
 	lbz	r11,TI_SC_NOERR(r12)
-	cmpi	0,r11,0
+	cmpwi	0,r11,0
 	bne-	syscall_error_cont
 	neg	r3,r3
 	oris	r5,r5,0x1000	/* Set SO bit in CR */
diff -urN linux-2.5/arch/ppc64/kernel/idle_power4.S g5-ppc64/arch/ppc64/kernel/idle_power4.S
--- linux-2.5/arch/ppc64/kernel/idle_power4.S	2004-02-12 14:47:50.000000000 +1100
+++ g5-ppc64/arch/ppc64/kernel/idle_power4.S	2004-10-08 07:52:15.792519144 +1000
@@ -46,7 +46,7 @@
 	/* Now check if user or arch enabled NAP mode */
 	LOADBASE(r3,powersave_nap)
 	lwz	r4,powersave_nap@l(r3)
-	cmpi	0,r4,0
+	cmpwi	0,r4,0
 	beqlr
 
 	/* Clear MSR:EE */
diff -urN linux-2.5/arch/ppc64/kernel/misc.S g5-ppc64/arch/ppc64/kernel/misc.S
--- linux-2.5/arch/ppc64/kernel/misc.S	2004-09-29 08:25:15.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/misc.S	2004-10-08 07:52:15.820514888 +1000
@@ -670,7 +670,7 @@
 	li	r4,0		/* new sp (unused) */
 	li	r0,__NR_clone
 	sc
-	cmpi	0,r3,0		/* parent or child? */
+	cmpdi	0,r3,0		/* parent or child? */
 	bne	1f		/* return if parent */
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
diff -urN linux-2.5/arch/ppc64/lib/checksum.S g5-ppc64/arch/ppc64/lib/checksum.S
--- linux-2.5/arch/ppc64/lib/checksum.S	2002-09-18 09:32:53.000000000 +1000
+++ g5-ppc64/arch/ppc64/lib/checksum.S	2004-10-08 08:38:13.365530392 +1000
@@ -92,19 +92,19 @@
         adde    r5,r5,r6
         bdnz    2b
         andi.	r4,r4,7         /* compute bytes left to sum after doublewords */
-3:	cmpi	0,r4,4		/* is at least a full word left? */
+3:	cmpwi	0,r4,4		/* is at least a full word left? */
 	blt	4f
 	lwz	r6,8(r3)	/* sum this word */
 	addi	r3,r3,4
 	subi	r4,r4,4
 	adde	r5,r5,r6
-4:      cmpi    0,r4,2		/* is at least a halfword left? */
+4:	cmpwi	0,r4,2		/* is at least a halfword left? */
         blt+	5f
         lhz     r6,8(r3)        /* sum this halfword */
         addi    r3,r3,2
         subi    r4,r4,2
         adde    r5,r5,r6
-5:      cmpi    0,r4,1		/* is at least a byte left? */
+5:	cmpwi	0,r4,1		/* is at least a byte left? */
         bne+    6f
         lbz     r6,8(r3)        /* sum this byte */
         slwi    r6,r6,8         /* this byte is assumed to be the upper byte of a halfword */
@@ -150,7 +150,7 @@
 	adde	r0,r0,r6
 	bdnz	82b
 	andi.	r5,r5,3
-3:	cmpi	0,r5,2
+3:	cmpwi	0,r5,2
 	blt+	4f
 83:	lhz	r6,4(r3)
 	addi	r3,r3,2
@@ -158,7 +158,7 @@
 93:	sth	r6,4(r4)
 	addi	r4,r4,2
 	adde	r0,r0,r6
-4:	cmpi	0,r5,1
+4:	cmpwi	0,r5,1
 	bne+	5f
 84:	lbz	r6,4(r3)
 94:	stb	r6,4(r4)
@@ -198,7 +198,7 @@
 	bdnz	97b
 	.globl src_error
 src_error:
-	cmpi	0,r7,0
+	cmpdi	0,r7,0
 	beq	1f
 	li	r6,-EFAULT
 	stw	r6,0(r7)
@@ -207,7 +207,7 @@
 
 	.globl dst_error
 dst_error:
-	cmpi	0,r8,0
+	cmpdi	0,r8,0
 	beq	1f
 	li	r6,-EFAULT
 	stw	r6,0(r8)
diff -urN linux-2.5/arch/ppc64/mm/hash_low.S g5-ppc64/arch/ppc64/mm/hash_low.S
--- linux-2.5/arch/ppc64/mm/hash_low.S	2004-08-25 18:19:22.000000000 +1000
+++ g5-ppc64/arch/ppc64/mm/hash_low.S	2004-10-08 07:52:15.857509264 +1000
@@ -172,9 +172,9 @@
 	li	r9,0
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* Will be patched by htab_finish_init() */
-	cmpi	0,r3,0
+	cmpdi	0,r3,0
 	bge	htab_pte_insert_ok	/* Insertion successful */
-	cmpi	0,r3,-2			/* Critical failure */
+	cmpdi	0,r3,-2			/* Critical failure */
 	beq-	htab_pte_insert_failure
 
 	/* Now try secondary slot */
@@ -194,9 +194,9 @@
 	li	r9,0
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* Will be patched by htab_finish_init() */
-	cmpi	0,r3,0
+	cmpdi	0,r3,0
 	bge+	htab_pte_insert_ok	/* Insertion successful */
-	cmpi	0,r3,-2			/* Critical failure */
+	cmpdi	0,r3,-2			/* Critical failure */
 	beq-	htab_pte_insert_failure
 
 	/* Both are full, we need to evict something */
