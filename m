Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVAJNs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVAJNs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAJNs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:48:29 -0500
Received: from ozlabs.org ([203.10.76.45]:28315 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262263AbVAJNqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:46:36 -0500
Date: Tue, 11 Jan 2005 00:41:20 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Remove flush_instruction_cache
Message-ID: <20050110134120.GU14239@krispykreme.ozlabs.ibm.com>
References: <20050110133838.GT14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110133838.GT14239@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Remove flush_instruction_cache, we cant touch HID bits on LPAR machines.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/misc.S~canttouchhids arch/ppc64/kernel/misc.S
--- foobar2/arch/ppc64/kernel/misc.S~canttouchhids	2005-01-10 23:30:39.785548541 +1100
+++ foobar2-anton/arch/ppc64/kernel/misc.S	2005-01-10 23:31:43.714281834 +1100
@@ -167,27 +167,7 @@ _GLOBAL(call_with_mmu_off)
 	xori	r0,r0,MSR_IR|MSR_DR
 	mtspr	SPRN_SRR1,r0
 	rfid
-	
-/*
- * Flush instruction cache.
- */
-_GLOBAL(flush_instruction_cache)
 
-/*
- * This is called by kgdb code
- * and should probably go away
- * to be replaced by invalidating
- * the cache lines that are actually
- * modified
- */
-	/* use invalidate-all bit in HID0
-	 *  - is this consistent across all 64-bit cpus?  -- paulus */
-	mfspr	r3,HID0
-	ori	r3,r3,HID0_ICFI
-	mtspr	HID0,r3
-	sync
-	isync
-	blr
 
 	.section	".toc","aw"
 PPC64_CACHES:
diff -puN include/asm-ppc64/system.h~canttouchhids include/asm-ppc64/system.h
--- foobar2/include/asm-ppc64/system.h~canttouchhids	2005-01-10 23:30:39.790548159 +1100
+++ foobar2-anton/include/asm-ppc64/system.h	2005-01-10 23:30:43.792899917 +1100
@@ -108,7 +108,6 @@ extern void show_regs(struct pt_regs * r
 extern void low_hash_fault(struct pt_regs *regs, unsigned long address);
 extern int die(const char *str, struct pt_regs *regs, long err);
 
-extern void flush_instruction_cache(void);
 extern int _get_PVR(void);
 extern void giveup_fpu(struct task_struct *);
 extern void disable_kernel_fp(void);
diff -puN arch/ppc64/kernel/ppc_ksyms.c~canttouchhids arch/ppc64/kernel/ppc_ksyms.c
--- foobar2/arch/ppc64/kernel/ppc_ksyms.c~canttouchhids	2005-01-10 23:33:43.020213869 +1100
+++ foobar2-anton/arch/ppc64/kernel/ppc_ksyms.c	2005-01-10 23:33:49.460644370 +1100
@@ -114,7 +114,6 @@ EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(kernel_thread);
 
-EXPORT_SYMBOL(flush_instruction_cache);
 EXPORT_SYMBOL(giveup_fpu);
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(giveup_altivec);
_
