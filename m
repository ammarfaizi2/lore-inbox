Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUEPKFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUEPKFb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 06:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUEPKFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 06:05:31 -0400
Received: from [212.34.189.10] ([212.34.189.10]:7344 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263467AbUEPKFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 06:05:03 -0400
Date: Sun, 16 May 2004 12:04:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040516100435.GD16301@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru> <20040507143512.GA14338@lst.de> <20040508023717.A3960@jurassic.park.msu.ru> <20040507224104.GA21153@lst.de> <20040508025142.A4330@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040508025142.A4330@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 02:51:42AM +0400, Ivan Kokshaysky wrote:
> On Sat, May 08, 2004 at 12:41:04AM +0200, Christoph Hellwig wrote:
> > either that or just marking it unloadable by removing the cleanup_module
> > handler sound like the simplest solution I guess.
> 
> Or leave it as it is for now - 'CONFIG_MATHEMU=m' won't compile. ;-)

Well, still false positives in grep.  What about this patch to simply
remove any traces of CONFIG_MATHEMU and modular math emulation?


--- 1.36/arch/alpha/Kconfig	Sat Mar 20 19:29:54 2004
+++ edited/arch/alpha/Kconfig	Sun May 16 11:14:44 2004
@@ -625,14 +625,6 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
-config MATHEMU
-	tristate "Kernel FP software completion" if DEBUG_KERNEL
-	default y if !DEBUG_KERNEL
-	help
-	  This option is required for IEEE compliant floating point arithmetic
-	  on the Alpha. The only time you would ever not say Y is to say M in
-	  order to debug the code. Say Y unless you know what you are doing.
-
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
===== arch/alpha/kernel/alpha_ksyms.c 1.37 vs edited =====
--- 1.37/arch/alpha/kernel/alpha_ksyms.c	Thu Mar 18 01:58:10 2004
+++ edited/arch/alpha/kernel/alpha_ksyms.c	Sun May 16 11:15:01 2004
@@ -169,13 +169,6 @@
 EXPORT_SYMBOL(csum_partial_copy_from_user);
 EXPORT_SYMBOL(csum_ipv6_magic);
 
-#ifdef CONFIG_MATHEMU_MODULE
-extern long (*alpha_fp_emul_imprecise)(struct pt_regs *, unsigned long);
-extern long (*alpha_fp_emul) (unsigned long pc);
-EXPORT_SYMBOL(alpha_fp_emul_imprecise);
-EXPORT_SYMBOL(alpha_fp_emul);
-#endif
-
 #ifdef CONFIG_ALPHA_BROKEN_IRQ_MASK
 EXPORT_SYMBOL(__min_ipl);
 #endif
===== arch/alpha/kernel/traps.c 1.29 vs edited =====
--- 1.29/arch/alpha/kernel/traps.c	Thu Apr 22 10:40:31 2004
+++ edited/arch/alpha/kernel/traps.c	Sun May 16 11:15:09 2004
@@ -191,16 +191,8 @@
 	do_exit(SIGSEGV);
 }
 
-#ifndef CONFIG_MATHEMU
-static long dummy_emul(void) { return 0; }
-long (*alpha_fp_emul_imprecise)(struct pt_regs *regs, unsigned long writemask)
-  = (void *)dummy_emul;
-long (*alpha_fp_emul) (unsigned long pc)
-  = (void *)dummy_emul;
-#else
 long alpha_fp_emul_imprecise(struct pt_regs *regs, unsigned long writemask);
 long alpha_fp_emul (unsigned long pc);
-#endif
 
 asmlinkage void
 do_entArith(unsigned long summary, unsigned long write_mask,
===== arch/alpha/math-emu/Makefile 1.9 vs edited =====
--- 1.9/arch/alpha/math-emu/Makefile	Sun Feb 23 02:34:29 2003
+++ edited/arch/alpha/math-emu/Makefile	Sun May 16 11:15:21 2004
@@ -4,4 +4,4 @@
 
 EXTRA_CFLAGS := -w
 
-obj-$(CONFIG_MATHEMU) += math.o qrnnd.o
+obj-y += math.o qrnnd.o
===== arch/alpha/math-emu/math.c 1.5 vs edited =====
--- 1.5/arch/alpha/math-emu/math.c	Fri Apr  4 00:49:57 2003
+++ edited/arch/alpha/math-emu/math.c	Sun May 16 11:15:57 2004
@@ -48,43 +48,6 @@
 extern unsigned long alpha_read_fp_reg_s (unsigned long reg);
 extern void alpha_write_fp_reg_s (unsigned long reg, unsigned long val);
 
-
-#ifdef MODULE
-
-MODULE_DESCRIPTION("FP Software completion module");
-
-extern long (*alpha_fp_emul_imprecise)(struct pt_regs *, unsigned long);
-extern long (*alpha_fp_emul) (unsigned long pc);
-
-static long (*save_emul_imprecise)(struct pt_regs *, unsigned long);
-static long (*save_emul) (unsigned long pc);
-
-long do_alpha_fp_emul_imprecise(struct pt_regs *, unsigned long);
-long do_alpha_fp_emul(unsigned long);
-
-int init_module(void)
-{
-	save_emul_imprecise = alpha_fp_emul_imprecise;
-	save_emul = alpha_fp_emul;
-	alpha_fp_emul_imprecise = do_alpha_fp_emul_imprecise;
-	alpha_fp_emul = do_alpha_fp_emul;
-	return 0;
-}
-
-void cleanup_module(void)
-{
-	alpha_fp_emul_imprecise = save_emul_imprecise;
-	alpha_fp_emul = save_emul;
-}
-
-#undef  alpha_fp_emul_imprecise
-#define alpha_fp_emul_imprecise		do_alpha_fp_emul_imprecise
-#undef  alpha_fp_emul
-#define alpha_fp_emul			do_alpha_fp_emul
-
-#endif /* MODULE */
-
-
 /*
  * Emulate the floating point instruction at address PC.  Returns -1 if the
  * instruction to be emulated is illegal (such as with the opDEC trap), else
@@ -106,8 +69,6 @@
 	__u32 insn;
 	long si_code;
 
-	MOD_INC_USE_COUNT;
-
 	get_user(insn, (__u32*)pc);
 	fc     = (insn >>  0) & 0x1f;	/* destination register */
 	fb     = (insn >> 16) & 0x1f;
@@ -320,7 +281,6 @@
 			if (_fex & IEEE_TRAP_ENABLE_INV) si_code = FPE_FLTINV;
 		}
 
-		MOD_DEC_USE_COUNT;
 		return si_code;
 	}
 
@@ -328,13 +288,11 @@
 	   requires that the result *always* be written... so we do the write
 	   immediately after the operations above.  */
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 
 bad_insn:
 	printk(KERN_ERR "alpha_fp_emul: Invalid FP insn %#x at %#lx\n",
 	       insn, pc);
-	MOD_DEC_USE_COUNT;
 	return -1;
 }
 
@@ -344,8 +302,6 @@
 	unsigned long trigger_pc = regs->pc - 4;
 	unsigned long insn, opcode, rc, si_code = 0;
 
-	MOD_INC_USE_COUNT;
-
 	/*
 	 * Turn off the bits corresponding to registers that are the
 	 * target of instructions that set bits in the exception
@@ -403,6 +359,5 @@
 	}
 
 egress:
-	MOD_DEC_USE_COUNT;
 	return si_code;
 }
