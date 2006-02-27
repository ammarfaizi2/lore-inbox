Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWB0Vn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWB0Vn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWB0Vn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:43:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29320 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751454AbWB0Vn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:43:58 -0500
Date: Mon, 27 Feb 2006 16:43:54 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Mark unwind info for signal trampolines in vDSOs
Message-ID: <20060227214354.GF20301@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following patch marks unwind info for signal trampolines using the
new S augmentation flag introduced in:
http://gcc.gnu.org/PR26208
GCC 4.2 (or patched earlier GCC) will be able to special case unwinding
through frames right above signal trampolines.  As the augmentations
start with z flag and S is at the very end of the augmentation string,
older GCCs will just skip the S flag as unknown (that's why an augmentation
flag was chosen over say a new CFA opcode).

Please apply.

Signed-off-by: Jakub Jelinek <jakub@redhat.com>

--- linux-2.6.15/arch/i386/kernel/vsyscall-sigreturn.S.jj	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/i386/kernel/vsyscall-sigreturn.S	2006-02-21 05:10:31.000000000 -0500
@@ -44,7 +44,7 @@ __kernel_rt_sigreturn:
 .LSTARTCIEDLSI1:
 	.long 0			/* CIE ID */
 	.byte 1			/* Version number */
-	.string "zR"		/* NUL-terminated augmentation string */
+	.string "zRS"		/* NUL-terminated augmentation string */
 	.uleb128 1		/* Code alignment factor */
 	.sleb128 -4		/* Data alignment factor */
 	.byte 8			/* Return address register column */
--- linux-2.6.15/arch/x86_64/ia32/vsyscall-sigreturn.S.jj	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/x86_64/ia32/vsyscall-sigreturn.S	2006-02-21 05:17:41.000000000 -0500
@@ -31,8 +31,27 @@ __kernel_rt_sigreturn:
 	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
 
 	.section .eh_frame,"a",@progbits
+.LSTARTFRAMES:
+        .long .LENDCIES-.LSTARTCIES
+.LSTARTCIES:
+	.long 0			/* CIE ID */
+	.byte 1			/* Version number */
+	.string "zRS"		/* NUL-terminated augmentation string */
+	.uleb128 1		/* Code alignment factor */
+	.sleb128 -4		/* Data alignment factor */
+	.byte 8			/* Return address register column */
+	.uleb128 1		/* Augmentation value length */
+	.byte 0x1b		/* DW_EH_PE_pcrel|DW_EH_PE_sdata4. */
+	.byte 0x0c		/* DW_CFA_def_cfa */
+	.uleb128 4
+	.uleb128 4
+	.byte 0x88		/* DW_CFA_offset, column 0x8 */
+	.uleb128 1
+	.align 4
+.LENDCIES:
+
 	.long .LENDFDE2-.LSTARTFDE2	/* Length FDE */
 .LSTARTFDE2:
-	.long .LSTARTFDE2-.LSTARTFRAME	/* CIE pointer */
+	.long .LSTARTFDE2-.LSTARTFRAMES	/* CIE pointer */
 	/* HACK: The dwarf2 unwind routines will subtract 1 from the
 	   return address to get an address in the middle of the
@@ -96,7 +116,7 @@ __kernel_rt_sigreturn:
 
 	.long .LENDFDE3-.LSTARTFDE3	/* Length FDE */
 .LSTARTFDE3:
-	.long .LSTARTFDE3-.LSTARTFRAME	/* CIE pointer */
+	.long .LSTARTFDE3-.LSTARTFRAMES	/* CIE pointer */
 	/* HACK: See above wrt unwind library assumptions.  */
 	.long .LSTART_rt_sigreturn-1-.	/* PC-relative start address */
 	.long .LEND_rt_sigreturn-.LSTART_rt_sigreturn+1
--- linux-2.6.15/arch/powerpc/kernel/vdso32/sigtramp.S.jj	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/powerpc/kernel/vdso32/sigtramp.S	2006-02-21 05:24:12.000000000 -0500
@@ -261,7 +261,7 @@ V_FUNCTION_END(__kernel_sigtramp_rt32)
 .Lcie_start:
 	.long 0			/* CIE ID */
 	.byte 1			/* Version number */
-	.string "zR"		/* NUL-terminated augmentation string */
+	.string "zRS"		/* NUL-terminated augmentation string */
 	.uleb128 4		/* Code alignment factor */
 	.sleb128 -4		/* Data alignment factor */
 	.byte 67		/* Return address register column, ap */
--- linux-2.6.15/arch/powerpc/kernel/vdso64/sigtramp.S.jj	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/powerpc/kernel/vdso64/sigtramp.S	2006-02-21 05:28:28.000000000 -0500
@@ -263,7 +263,7 @@ V_FUNCTION_END(__kernel_sigtramp_rt64)
 .Lcie_start:
 	.long 0			/* CIE ID */
 	.byte 1			/* Version number */
-	.string "zR"		/* NUL-terminated augmentation string */
+	.string "zRS"		/* NUL-terminated augmentation string */
 	.uleb128 4		/* Code alignment factor */
 	.sleb128 -8		/* Data alignment factor */
 	.byte 67		/* Return address register column, ap */

	Jakub
