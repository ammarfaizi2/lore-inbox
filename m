Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161469AbWJKVP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161469AbWJKVP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161446AbWJKVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:13:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54690 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161452AbWJKVNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:13:02 -0400
To: linux-m68k@vger.kernel.org
Subject: [PATCH 2/2] m68k: more workarounds for recent binutils idiocy
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 22:13:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cretinous thing doesn't believe that (%a0)+ is one macro argument and
splits it in two; worked around by quoting the argument...
---
 arch/m68k/math-emu/fp_move.S  |    4 ++--
 arch/m68k/math-emu/fp_movem.S |   12 ++++++------
 arch/m68k/math-emu/fp_scan.S  |    6 +++---
 arch/m68k/math-emu/fp_util.S  |    6 +++---
 include/asm-m68k/math-emu.h   |    8 ++++++++
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/math-emu/fp_move.S b/arch/m68k/math-emu/fp_move.S
--- a/arch/m68k/math-emu/fp_move.S
+++ b/arch/m68k/math-emu/fp_move.S
@@ -213,9 +213,9 @@ fp_format_extended:
 	lsl.w	#1,%d0
 	lsl.l	#7,%d0
 	lsl.l	#8,%d0
-	putuser.l %d0,(%a1)+,fp_err_ua1,%a1
+	putuser_inc %d0,%a1,fp_err_ua1
 	move.l	(%a0)+,%d0
-	putuser.l %d0,(%a1)+,fp_err_ua1,%a1
+	putuser_inc %d0,%a1,fp_err_ua1
 	move.l	(%a0),%d0
 	putuser.l %d0,(%a1),fp_err_ua1,%a1
 	jra	fp_finish_move
diff --git a/arch/m68k/math-emu/fp_movem.S b/arch/m68k/math-emu/fp_movem.S
--- a/arch/m68k/math-emu/fp_movem.S
+++ b/arch/m68k/math-emu/fp_movem.S
@@ -141,12 +141,12 @@ fpr_do_movem:
 	| move register from memory into fpu
 	jra	3f
 1:	printf	PMOVEM,"(%p>%p)",2,%a0,%a1
-	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
+	getuser_inc %a0,%d2,fp_err_ua1
 	lsr.l	#8,%d2
 	lsr.l	#7,%d2
 	lsr.w	#1,%d2
 	move.l	%d2,(%a1)+
-	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
+	getuser_inc %a0,%d2,fp_err_ua1
 	move.l	%d2,(%a1)+
 	getuser.l (%a0),%d2,fp_err_ua1,%a0
 	move.l	%d2,(%a1)
@@ -164,9 +164,9 @@ fpr_do_movem:
 	lsl.w	#1,%d2
 	lsl.l	#7,%d2
 	lsl.l	#8,%d2
-	putuser.l %d2,(%a0)+,fp_err_ua1,%a0
+	putuser_inc %d2,%a0,fp_err_ua1
 	move.l	(%a1)+,%d2
-	putuser.l %d2,(%a0)+,fp_err_ua1,%a0
+	putuser_inc %d2,%a0,fp_err_ua1
 	move.l	(%a1),%d2
 	putuser.l %d2,(%a0),fp_err_ua1,%a0
 	subq.l	#8,%a1
@@ -325,7 +325,7 @@ fpc_do_movem:
 	| move register from memory into fpu
 	jra	3f
 1:	printf	PMOVEM,"(%p>%p)",2,%a0,%a1
-	getuser.l (%a0)+,%d0,fp_err_ua1,%a0
+	getuser_inc %a0,%d0,fp_err_ua1
 	move.l	%d0,(%a1)
 2:	addq.l	#4,%a1
 3:	lsl.b	#1,%d1
@@ -336,7 +336,7 @@ fpc_do_movem:
 	| move register from fpu into memory
 1:	printf	PMOVEM,"(%p>%p)",2,%a1,%a0
 	move.l	(%a1),%d0
-	putuser.l %d0,(%a0)+,fp_err_ua1,%a0
+	putuser_inc %d0,%a0,fp_err_ua1
 2:	addq.l	#4,%a1
 4:	lsl.b	#1,%d1
 	jcs	1b
diff --git a/arch/m68k/math-emu/fp_scan.S b/arch/m68k/math-emu/fp_scan.S
--- a/arch/m68k/math-emu/fp_scan.S
+++ b/arch/m68k/math-emu/fp_scan.S
@@ -72,7 +72,7 @@ #else
 #endif
 	jne	fp_nonstd
 | first two instruction words are kept in %d2
-	getuser.l (%a0)+,%d2,fp_err_ua1,%a0
+	getuser_inc %a0,%d2,fp_err_ua1
 	fp_put_pc %a0
 fp_decode_cond:				| separate conditional instr
 	fp_decode_cond_instr_type
@@ -262,12 +262,12 @@ fp_single:
 	jra	fp_getdest
 
 fp_ext:
-	getuser.l (%a1)+,%d0,fp_err_ua1,%a1
+	getuser_inc %a1,%d0,fp_err_ua1
 	lsr.l	#8,%d0
 	lsr.l	#7,%d0
 	lsr.w	#1,%d0
 	move.l	%d0,(%a0)+
-	getuser.l (%a1)+,%d0,fp_err_ua1,%a1
+	getuser_inc %a1,%d0,fp_err_ua1
 	move.l	%d0,(%a0)+
 	getuser.l (%a1),%d0,fp_err_ua1,%a1
 	move.l	%d0,(%a0)
diff --git a/arch/m68k/math-emu/fp_util.S b/arch/m68k/math-emu/fp_util.S
--- a/arch/m68k/math-emu/fp_util.S
+++ b/arch/m68k/math-emu/fp_util.S
@@ -163,7 +163,7 @@ #ifdef FPU_EMU_DEBUG
 	getuser.l %a1@(4),%d1,fp_err_ua2,%a1
 	printf	PCONV,"d2e: %p%p -> %p(",3,%d0,%d1,%a0
 #endif
-	getuser.l (%a1)+,%d0,fp_err_ua2,%a1
+	getuser_inc %a1,%d0,fp_err_ua2
 	move.l	%d0,%d1
 	lsl.l	#8,%d0			| shift high mantissa
 	lsl.l	#3,%d0
@@ -177,7 +177,7 @@ #endif
 	add.w	#0x3fff-0x3ff,%d1	| re-bias the exponent.
 9:	move.l	%d1,(%a0)+		| fp_ext.sign, fp_ext.exp
 	move.l	%d0,(%a0)+
-	getuser.l (%a1)+,%d0,fp_err_ua2,%a1
+	getuser_inc %a1,%d0,fp_err_ua2
 	move.l	%d0,%d1
 	lsl.l	#8,%d0
 	lsl.l	#3,%d0
@@ -1286,7 +1286,7 @@ fp_conv_ext2double:
 	lsr.l	#4,%d0
 	lsr.l	#8,%d0
 	or.l	%d2,%d0
-	putuser.l %d0,(%a1)+,fp_err_ua2,%a1
+	putuser_inc %d0,%a1,fp_err_ua2
 	moveq	#21,%d0
 	lsl.l	%d0,%d1
 	move.l	(%a0),%d0
diff --git a/include/asm-m68k/math-emu.h b/include/asm-m68k/math-emu.h
--- a/include/asm-m68k/math-emu.h
+++ b/include/asm-m68k/math-emu.h
@@ -226,6 +226,14 @@ #define FPS_PC2		(PT_PC+10)
 	.previous
 .endm
 
+.macro  getuser_inc src,dest,label
+        getuser.l "(\src)+",\dest,\label,\src
+.endm
+
+.macro  putuser_inc src,dest,label
+        getuser.l \src,"(\dest)+",\label,\dest
+.endm
+
 /* work around binutils idiocy */
 .macro  gas_fscked.x
 .irp	m b,w,l
-- 

