Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVCGJvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVCGJvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCGJvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:51:41 -0500
Received: from ozlabs.org ([203.10.76.45]:32402 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261728AbVCGJvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:51:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16940.9284.79566.526069@cargo.ozlabs.ibm.com>
Date: Mon, 7 Mar 2005 20:52:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [PATCH] ppc64: kprobes: handle trap variants while processing probes
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Ananth N Mavinakayanahalli <ananth@in.ibm.com>.

While processing a kprobe, we were currently not handling all available 
trap variants available on PowerPC. This lead to the breakage of BUG()
handling in ppc64.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Naurp temp/linux-2.6.11-rc3/arch/ppc64/kernel/kprobes.c linux-2.6.11-rc3/arch/ppc64/kernel/kprobes.c
--- temp/linux-2.6.11-rc3/arch/ppc64/kernel/kprobes.c	2005-02-03 07:26:53.000000000 +0530
+++ linux-2.6.11-rc3/arch/ppc64/kernel/kprobes.c	2005-02-10 18:08:25.000000000 +0530
@@ -105,8 +105,16 @@ static inline int kprobe_handler(struct 
 	p = get_kprobe(addr);
 	if (!p) {
 		unlock_kprobes();
-#if 0
 		if (*addr != BREAKPOINT_INSTRUCTION) {
+			/* 
+			 * PowerPC has multiple variants of the "trap"
+			 * instruction. If the current instruction is a
+			 * trap variant, it could belong to someone else
+			 */
+			kprobe_opcode_t cur_insn = *addr;
+			if (IS_TW(cur_insn) || IS_TD(cur_insn) || 
+					IS_TWI(cur_insn) || IS_TDI(cur_insn))
+		       		goto no_kprobe;
 			/*
 			 * The breakpoint instruction was removed right
 			 * after we hit it.  Another cpu has removed
@@ -116,7 +124,6 @@ static inline int kprobe_handler(struct 
 			 */
 			ret = 1;
 		}
-#endif
 		/* Not one of ours: let kernel handle it */
 		goto no_kprobe;
 	}
diff -Naurp temp/linux-2.6.11-rc3/include/asm-ppc64/kprobes.h linux-2.6.11-rc3/include/asm-ppc64/kprobes.h
--- temp/linux-2.6.11-rc3/include/asm-ppc64/kprobes.h	2005-02-03 07:25:50.000000000 +0530
+++ linux-2.6.11-rc3/include/asm-ppc64/kprobes.h	2005-02-10 18:08:58.000000000 +0530
@@ -35,6 +35,11 @@ typedef unsigned int kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
 #define MAX_INSN_SIZE 1
 
+#define IS_TW(instr)		(((instr) & 0xfc0007fe) == 0x7c000008)
+#define IS_TD(instr)		(((instr) & 0xfc0007fe) == 0x7c000088)
+#define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
+#define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)
+
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
 
 /* Architecture specific copy of original instruction */
