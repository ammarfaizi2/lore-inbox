Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUEGOcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUEGOcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUEGOcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:32:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:5532 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263596AbUEGOca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:32:30 -0400
Date: Fri, 7 May 2004 18:32:08 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christoph Hellwig <hch@lst.de>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040507183208.A3283@jurassic.park.msu.ru>
References: <20040507110217.GA11366@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040507110217.GA11366@lst.de>; from hch@lst.de on Fri, May 07, 2004 at 01:02:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 01:02:17PM +0200, Christoph Hellwig wrote:
> any chance we could either do a try_module_get on a struct module
> *fp_emul_module in alpha core code before or completely disallow module
> unloading for it (by removing the cleanup_module() callback)?

How about this (also fixes modular build of math-emu)?

Ivan.

--- 2.6/arch/alpha/math-emu/math.c	Sun Apr  4 07:38:23 2004
+++ linux/arch/alpha/math-emu/math.c	Fri May  7 18:21:15 2004
@@ -51,7 +51,9 @@ extern void alpha_write_fp_reg_s (unsign
 
 #ifdef MODULE
 
+MODULE_AUTHOR("Richard Henderson <rth@twiddle.net>");
 MODULE_DESCRIPTION("FP Software completion module");
+MODULE_LICENSE("GPL");
 
 extern long (*alpha_fp_emul_imprecise)(struct pt_regs *, unsigned long);
 extern long (*alpha_fp_emul) (unsigned long pc);
@@ -106,7 +108,7 @@ alpha_fp_emul (unsigned long pc)
 	__u32 insn;
 	long si_code;
 
-	MOD_INC_USE_COUNT;
+	BUG_ON(!try_module_get(THIS_MODULE));
 
 	get_user(insn, (__u32*)pc);
 	fc     = (insn >>  0) & 0x1f;	/* destination register */
@@ -320,7 +322,7 @@ done:
 			if (_fex & IEEE_TRAP_ENABLE_INV) si_code = FPE_FLTINV;
 		}
 
-		MOD_DEC_USE_COUNT;
+		module_put(THIS_MODULE);
 		return si_code;
 	}
 
@@ -328,13 +330,13 @@ done:
 	   requires that the result *always* be written... so we do the write
 	   immediately after the operations above.  */
 
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return 0;
 
 bad_insn:
 	printk(KERN_ERR "alpha_fp_emul: Invalid FP insn %#x at %#lx\n",
 	       insn, pc);
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return -1;
 }
 
@@ -344,7 +346,7 @@ alpha_fp_emul_imprecise (struct pt_regs 
 	unsigned long trigger_pc = regs->pc - 4;
 	unsigned long insn, opcode, rc, si_code = 0;
 
-	MOD_INC_USE_COUNT;
+	BUG_ON(!try_module_get(THIS_MODULE));
 
 	/*
 	 * Turn off the bits corresponding to registers that are the
@@ -403,6 +405,6 @@ alpha_fp_emul_imprecise (struct pt_regs 
 	}
 
 egress:
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return si_code;
 }
--- 2.6/arch/alpha/math-emu/Makefile	Sun Apr  4 07:37:23 2004
+++ linux/arch/alpha/math-emu/Makefile	Fri May  7 17:52:22 2004
@@ -4,4 +4,6 @@
 
 EXTRA_CFLAGS := -w
 
-obj-$(CONFIG_MATHEMU) += math.o qrnnd.o
+obj-$(CONFIG_MATHEMU) += math-emu.o
+
+math-emu-objs := math.o qrnnd.o
