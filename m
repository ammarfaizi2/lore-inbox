Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311691AbSCNRZS>; Thu, 14 Mar 2002 12:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311688AbSCNRY7>; Thu, 14 Mar 2002 12:24:59 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:51333 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S311689AbSCNRYy>;
	Thu, 14 Mar 2002 12:24:54 -0500
Date: Thu, 14 Mar 2002 18:24:44 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203141724.SAA05707@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: [PATCH] boot_cpu_data corruption on SMP x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below eliminates a case of boot_cpu_data corruption
on SMP x86 machines. This was first observed on SMP Athlons,
but it also affects SMP Intel boxes in a less serious way.

When the secondary processors boot and execute head.S:checkCPUtype,
the code performs a 32-bit write of a small constant to the
byte-sized variable boot_cpu_data.x86 (X86 in head.S). Since the
write is 32-bit, it also writes zeros to the following 3 bytes,
which clobbers the x86_vendor, x86_model, and x86_mask fields
previously set up by check_bugs()'s call to identify_cpu().
Thus, after smp_init(), boot_cpu_data will _always_ identify
the CPU as an Intel (X86_VENDOR_INTEL == 0 in processor.h) with
model 0 and stepping 0.

The effect in standard kernels is not catastrophic, since:
(a) most SMP x86 boxes are Intel
(b) most uses of x86_vendor occur before smp_init() or reference
    the SMP cpu_data[] array
(c) most post-boot references to boot_cpu_data occur in the
    cpu_has_XXX macros which only read the x86_capability[] array
However, third-party extensions (like my x86 performance-monitoring
conters driver) can get seriously confused by this mis-identification.

The patch is for 2.4.19-pre3, but it also applies to 2.5.6 and
2.2.21rc1. Please apply.

/Mikael

--- linux-2.4.19-pre3/arch/i386/kernel/head.S.~1~	Tue Feb 26 13:26:56 2002
+++ linux-2.4.19-pre3/arch/i386/kernel/head.S	Thu Mar 14 16:20:57 2002
@@ -178,7 +178,7 @@
  * we don't need to preserve eflags.
  */
 
-	movl $3,X86		# at least 386
+	movb $3,X86		# at least 386
 	pushfl			# push EFLAGS
 	popl %eax		# get EFLAGS
 	movl %eax,%ecx		# save original EFLAGS
@@ -191,7 +191,7 @@
 	andl $0x40000,%eax	# check if AC bit changed
 	je is386
 
-	movl $4,X86		# at least 486
+	movb $4,X86		# at least 486
 	movl %ecx,%eax
 	xorl $0x200000,%eax	# check ID flag
 	pushl %eax
