Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbVJGX4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbVJGX4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVJGXzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:55:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:27094 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964946AbVJGXz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:55:26 -0400
Date: Fri, 7 Oct 2005 16:54:55 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net
Subject: [patch 5/7] Fix userland FPU state corruption.
Message-ID: <20051007235455.GF23111@kroah.com>
References: <20051007234348.631583000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-sparc64-fpu-register-corruption.patch"
In-Reply-To: <20051007235353.GA23111@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

We need to use stricter memory barriers around the block
load and store instructions we use to save and restore the
FPU register file.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/sparc64/kernel/entry.S |   39 +++++++++++++++++++++------------------
 arch/sparc64/kernel/rtrap.S |    7 ++++---
 arch/sparc64/lib/VISsave.S  |    8 +++++---
 3 files changed, 30 insertions(+), 24 deletions(-)

--- linux-2.6.13.y.orig/arch/sparc64/kernel/entry.S
+++ linux-2.6.13.y/arch/sparc64/kernel/entry.S
@@ -186,7 +186,7 @@ vmalloc_addr:
 	/* This is trivial with the new code... */
 	.globl		do_fpdis
 do_fpdis:
-	sethi		%hi(TSTATE_PEF), %g4					! IEU0
+	sethi		%hi(TSTATE_PEF), %g4
 	rdpr		%tstate, %g5
 	andcc		%g5, %g4, %g0
 	be,pt		%xcc, 1f
@@ -203,18 +203,18 @@ do_fpdis:
 	add		%g0, %g0, %g0
 	ba,a,pt		%xcc, rtrap_clr_l6
 
-1:	ldub		[%g6 + TI_FPSAVED], %g5					! Load	Group
-	wr		%g0, FPRS_FEF, %fprs					! LSU	Group+4bubbles
-	andcc		%g5, FPRS_FEF, %g0					! IEU1	Group
-	be,a,pt		%icc, 1f						! CTI
-	 clr		%g7							! IEU0
-	ldx		[%g6 + TI_GSR], %g7					! Load	Group
-1:	andcc		%g5, FPRS_DL, %g0					! IEU1
-	bne,pn		%icc, 2f						! CTI
-	 fzero		%f0							! FPA
-	andcc		%g5, FPRS_DU, %g0					! IEU1  Group
-	bne,pn		%icc, 1f						! CTI
-	 fzero		%f2							! FPA
+1:	ldub		[%g6 + TI_FPSAVED], %g5
+	wr		%g0, FPRS_FEF, %fprs
+	andcc		%g5, FPRS_FEF, %g0
+	be,a,pt		%icc, 1f
+	 clr		%g7
+	ldx		[%g6 + TI_GSR], %g7
+1:	andcc		%g5, FPRS_DL, %g0
+	bne,pn		%icc, 2f
+	 fzero		%f0
+	andcc		%g5, FPRS_DU, %g0
+	bne,pn		%icc, 1f
+	 fzero		%f2
 	faddd		%f0, %f2, %f4
 	fmuld		%f0, %f2, %f6
 	faddd		%f0, %f2, %f8
@@ -257,8 +257,10 @@ cplus_fptrap_insn_1:
 	add		%g6, TI_FPREGS + 0xc0, %g2
 	faddd		%f0, %f2, %f8
 	fmuld		%f0, %f2, %f10
-	ldda		[%g1] ASI_BLK_S, %f32	! grrr, where is ASI_BLK_NUCLEUS 8-(
+	membar		#Sync
+	ldda		[%g1] ASI_BLK_S, %f32
 	ldda		[%g2] ASI_BLK_S, %f48
+	membar		#Sync
 	faddd		%f0, %f2, %f12
 	fmuld		%f0, %f2, %f14
 	faddd		%f0, %f2, %f16
@@ -269,7 +271,6 @@ cplus_fptrap_insn_1:
 	fmuld		%f0, %f2, %f26
 	faddd		%f0, %f2, %f28
 	fmuld		%f0, %f2, %f30
-	membar		#Sync
 	b,pt		%xcc, fpdis_exit
 	 nop
 2:	andcc		%g5, FPRS_DU, %g0
@@ -286,8 +287,10 @@ cplus_fptrap_insn_2:
 	add		%g6, TI_FPREGS + 0x40, %g2
 	faddd		%f32, %f34, %f36
 	fmuld		%f32, %f34, %f38
-	ldda		[%g1] ASI_BLK_S, %f0	! grrr, where is ASI_BLK_NUCLEUS 8-(
+	membar		#Sync
+	ldda		[%g1] ASI_BLK_S, %f0
 	ldda		[%g2] ASI_BLK_S, %f16
+	membar		#Sync
 	faddd		%f32, %f34, %f40
 	fmuld		%f32, %f34, %f42
 	faddd		%f32, %f34, %f44
@@ -300,7 +303,6 @@ cplus_fptrap_insn_2:
 	fmuld		%f32, %f34, %f58
 	faddd		%f32, %f34, %f60
 	fmuld		%f32, %f34, %f62
-	membar		#Sync
 	ba,pt		%xcc, fpdis_exit
 	 nop
 3:	mov		SECONDARY_CONTEXT, %g3
@@ -311,7 +313,8 @@ cplus_fptrap_insn_3:
 	stxa		%g2, [%g3] ASI_DMMU
 	membar		#Sync
 	mov		0x40, %g2
-	ldda		[%g1] ASI_BLK_S, %f0		! grrr, where is ASI_BLK_NUCLEUS 8-(
+	membar		#Sync
+	ldda		[%g1] ASI_BLK_S, %f0
 	ldda		[%g1 + %g2] ASI_BLK_S, %f16
 	add		%g1, 0x80, %g1
 	ldda		[%g1] ASI_BLK_S, %f32
--- linux-2.6.13.y.orig/arch/sparc64/kernel/rtrap.S
+++ linux-2.6.13.y/arch/sparc64/kernel/rtrap.S
@@ -310,32 +310,33 @@ kern_fpucheck:	ldub			[%g6 + TI_FPDEPTH]
 		wr			%g1, FPRS_FEF, %fprs
 		ldx			[%o1 + %o5], %g1
 		add			%g6, TI_XFSR, %o1
-		membar			#StoreLoad | #LoadLoad
 		sll			%o0, 8, %o2
 		add			%g6, TI_FPREGS, %o3
 		brz,pn			%l6, 1f
 		 add			%g6, TI_FPREGS+0x40, %o4
 
+		membar			#Sync
 		ldda			[%o3 + %o2] ASI_BLK_P, %f0
 		ldda			[%o4 + %o2] ASI_BLK_P, %f16
+		membar			#Sync
 1:		andcc			%l2, FPRS_DU, %g0
 		be,pn			%icc, 1f
 		 wr			%g1, 0, %gsr
 		add			%o2, 0x80, %o2
+		membar			#Sync
 		ldda			[%o3 + %o2] ASI_BLK_P, %f32
 		ldda			[%o4 + %o2] ASI_BLK_P, %f48
-
 1:		membar			#Sync
 		ldx			[%o1 + %o5], %fsr
 2:		stb			%l5, [%g6 + TI_FPDEPTH]
 		ba,pt			%xcc, rt_continue
 		 nop
 5:		wr			%g0, FPRS_FEF, %fprs
-		membar			#StoreLoad | #LoadLoad
 		sll			%o0, 8, %o2
 
 		add			%g6, TI_FPREGS+0x80, %o3
 		add			%g6, TI_FPREGS+0xc0, %o4
+		membar			#Sync
 		ldda			[%o3 + %o2] ASI_BLK_P, %f32
 		ldda			[%o4 + %o2] ASI_BLK_P, %f48
 		membar			#Sync
--- linux-2.6.13.y.orig/arch/sparc64/lib/VISsave.S
+++ linux-2.6.13.y/arch/sparc64/lib/VISsave.S
@@ -59,15 +59,17 @@ vis1:	ldub		[%g6 + TI_FPSAVED], %g3
 	be,pn		%icc, 9b
 	 add		%g6, TI_FPREGS, %g2
 	andcc		%o5, FPRS_DL, %g0
-	membar		#StoreStore | #LoadStore
 
 	be,pn		%icc, 4f
 	 add		%g6, TI_FPREGS+0x40, %g3
+	membar		#Sync
 	stda		%f0, [%g2 + %g1] ASI_BLK_P
 	stda		%f16, [%g3 + %g1] ASI_BLK_P
+	membar		#Sync
 	andcc		%o5, FPRS_DU, %g0
 	be,pn		%icc, 5f
 4:	 add		%g1, 128, %g1
+	membar		#Sync
 	stda		%f32, [%g2 + %g1] ASI_BLK_P
 
 	stda		%f48, [%g3 + %g1] ASI_BLK_P
@@ -87,7 +89,7 @@ vis1:	ldub		[%g6 + TI_FPSAVED], %g3
 	sll		%g1, 5, %g1
 	add		%g6, TI_FPREGS+0xc0, %g3
 	wr		%g0, FPRS_FEF, %fprs
-	membar		#StoreStore | #LoadStore
+	membar		#Sync
 	stda		%f32, [%g2 + %g1] ASI_BLK_P
 	stda		%f48, [%g3 + %g1] ASI_BLK_P
 	membar		#Sync
@@ -128,8 +130,8 @@ VISenterhalf:
 	be,pn		%icc, 4f
 	 add		%g6, TI_FPREGS, %g2
 
-	membar		#StoreStore | #LoadStore
 	add		%g6, TI_FPREGS+0x40, %g3
+	membar		#Sync
 	stda		%f0, [%g2 + %g1] ASI_BLK_P
 	stda		%f16, [%g3 + %g1] ASI_BLK_P
 	membar		#Sync

--
