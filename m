Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVALLbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVALLbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVALLbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:31:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:28560 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261152AbVALLbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:31:12 -0500
Date: Wed, 12 Jan 2005 17:00:54 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ppc64: kprobes breaks BUG() handling
Message-ID: <20050112113054.GA9622@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20050110111937.GN14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110111937.GN14239@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:19:37PM +1100, Anton Blanchard wrote:

Hi Anton,
 
> I was running some tests and noticed BUG() handling wasnt working as
> expected. The kprobes code has some code to check for breakpoint
> removal races and only checks for one opcode. It turns out there are
> many forms of the breakpoint instruction, comparing against one is not
> good enough.

Here is a patch containing checks for the other trap variants (twi, td,
tdi). Logic is similar to the one used in IS_MTMSRD() and IS_RFID(). 

Please let me know if this fixes the issue.

Thanks,
Ananth


Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

diff -Naurp temp/linux-2.6.11-rc1/arch/ppc64/kernel/kprobes.c linux-2.6.11-rc1/arch/ppc64/kernel/kprobes.c
--- temp/linux-2.6.11-rc1/arch/ppc64/kernel/kprobes.c	2005-01-12 09:32:08.000000000 +0530
+++ linux-2.6.11-rc1/arch/ppc64/kernel/kprobes.c	2005-01-12 15:37:24.165968408 +0530
@@ -99,8 +99,16 @@ static inline int kprobe_handler(struct 
 	p = get_kprobe(addr);
 	if (!p) {
 		unlock_kprobes();
-#if 0
 		if (*addr != BREAKPOINT_INSTRUCTION) {
+			/* 
+			 * PPC64 has multiple variants of the "trap"
+			 * instruction. If the current instruction is a
+			 * trap variant, it could belong to someone else
+			 */
+			kprobe_opcode_t cur_insn = *addr;
+			if (IS_TWI(cur_insn) || IS_TD(cur_insn) || 
+					IS_TDI(cur_insn))
+		       		goto no_kprobe;
 			/*
 			 * The breakpoint instruction was removed right
 			 * after we hit it.  Another cpu has removed
@@ -110,7 +118,6 @@ static inline int kprobe_handler(struct 
 			 */
 			ret = 1;
 		}
-#endif
 		/* Not one of ours: let kernel handle it */
 		goto no_kprobe;
 	}
diff -Naurp temp/linux-2.6.11-rc1/include/asm-ppc64/kprobes.h linux-2.6.11-rc1/include/asm-ppc64/kprobes.h
--- temp/linux-2.6.11-rc1/include/asm-ppc64/kprobes.h	2005-01-12 09:30:44.000000000 +0530
+++ linux-2.6.11-rc1/include/asm-ppc64/kprobes.h	2005-01-12 15:39:24.100977920 +0530
@@ -35,6 +35,10 @@ typedef unsigned int kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
 #define MAX_INSN_SIZE 1
 
+#define IS_TD(instr)		(((instr) & 0xfc0007fe) == 0x7c000088)
+#define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
+#define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)
+
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
 
 /* Architecture specific copy of original instruction */
