Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVIPXgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVIPXgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVIPXgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:36:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7084
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750719AbVIPXgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:36:01 -0400
Date: Fri, 16 Sep 2005 16:35:54 -0700 (PDT)
Message-Id: <20050916.163554.79765706.davem@davemloft.net>
To: ecashin@coraid.com
Cc: linux-kernel@vger.kernel.org, jmacbaine@gmail.com
Subject: Re: aoe fails on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87u0glxhfw.fsf@coraid.com>
References: <3afbacad0508310630797f397d@mail.gmail.com>
	<87u0glxhfw.fsf@coraid.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Fri, 16 Sep 2005 09:36:51 -0400

> I've been working with Jim MacBaine, and he reports that the patch
> below gets rid of the problem.  I don't know why.  When I test
> le64_to_cpup by itself, it works as expected.

This patch should fix the bug.

diff --git a/arch/sparc64/kernel/una_asm.S b/arch/sparc64/kernel/una_asm.S
--- a/arch/sparc64/kernel/una_asm.S
+++ b/arch/sparc64/kernel/una_asm.S
@@ -17,7 +17,7 @@ kernel_unaligned_trap_fault:
 __do_int_store:
 	rd	%asi, %o4
 	wr	%o3, 0, %asi
-	ldx	[%o2], %g3
+	mov	%o2, %g3
 	cmp	%o1, 2
 	be,pn	%icc, 2f
 	 cmp	%o1, 4
diff --git a/arch/sparc64/kernel/unaligned.c b/arch/sparc64/kernel/unaligned.c
--- a/arch/sparc64/kernel/unaligned.c
+++ b/arch/sparc64/kernel/unaligned.c
@@ -184,13 +184,14 @@ extern void do_int_load(unsigned long *d
 			unsigned long *saddr, int is_signed, int asi);
 	
 extern void __do_int_store(unsigned long *dst_addr, int size,
-			   unsigned long *src_val, int asi);
+			   unsigned long src_val, int asi);
 
 static inline void do_int_store(int reg_num, int size, unsigned long *dst_addr,
-				struct pt_regs *regs, int asi)
+				struct pt_regs *regs, int asi, int orig_asi)
 {
 	unsigned long zero = 0;
-	unsigned long *src_val = &zero;
+	unsigned long *src_val_p = &zero;
+	unsigned long src_val;
 
 	if (size == 16) {
 		size = 8;
@@ -198,7 +199,25 @@ static inline void do_int_store(int reg_
 		        (unsigned)fetch_reg(reg_num, regs) : 0)) << 32) |
 			(unsigned)fetch_reg(reg_num + 1, regs);
 	} else if (reg_num) {
-		src_val = fetch_reg_addr(reg_num, regs);
+		src_val_p = fetch_reg_addr(reg_num, regs);
+	}
+	src_val = *src_val_p;
+	if (unlikely(asi != orig_asi)) {
+		switch (size) {
+		case 2:
+			src_val = swab16(src_val);
+			break;
+		case 4:
+			src_val = swab32(src_val);
+			break;
+		case 8:
+			src_val = swab64(src_val);
+			break;
+		case 16:
+		default:
+			BUG();
+			break;
+		};
 	}
 	__do_int_store(dst_addr, size, src_val, asi);
 }
@@ -276,6 +295,7 @@ asmlinkage void kernel_unaligned_trap(st
 		kernel_mna_trap_fault();
 	} else {
 		unsigned long addr;
+		int orig_asi, asi;
 
 		addr = compute_effective_address(regs, insn,
 						 ((insn >> 25) & 0x1f));
@@ -285,18 +305,48 @@ asmlinkage void kernel_unaligned_trap(st
 		       regs->tpc, dirstrings[dir], addr, size,
 		       regs->u_regs[UREG_RETPC]);
 #endif
+		orig_asi = asi = decode_asi(insn, regs);
+		switch (asi) {
+		case ASI_NL:
+		case ASI_AIUPL:
+		case ASI_AIUSL:
+		case ASI_PL:
+		case ASI_SL:
+		case ASI_PNFL:
+		case ASI_SNFL:
+			asi &= ~0x08;
+			break;
+		};
 		switch (dir) {
 		case load:
 			do_int_load(fetch_reg_addr(((insn>>25)&0x1f), regs),
 				    size, (unsigned long *) addr,
-				    decode_signedness(insn),
-				    decode_asi(insn, regs));
+				    decode_signedness(insn), asi);
+			if (unlikely(asi != orig_asi)) {
+				unsigned long val_in = *(unsigned long *) addr;
+				switch (size) {
+				case 2:
+					val_in = swab16(val_in);
+					break;
+				case 4:
+					val_in = swab32(val_in);
+					break;
+				case 8:
+					val_in = swab64(val_in);
+					break;
+				case 16:
+				default:
+					BUG();
+					break;
+				};
+				*(unsigned long *) addr = val_in;
+			}
 			break;
 
 		case store:
 			do_int_store(((insn>>25)&0x1f), size,
 				     (unsigned long *) addr, regs,
-				     decode_asi(insn, regs));
+				     asi, orig_asi);
 			break;
 
 		default:
