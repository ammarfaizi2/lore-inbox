Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVLKAAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVLKAAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 19:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbVLKAAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 19:00:49 -0500
Received: from ns.suse.de ([195.135.220.2]:48267 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030223AbVLKAAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 19:00:48 -0500
Date: Sun, 11 Dec 2005 01:00:39 +0100
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
Message-ID: <20051211000039.GR11190@wotan.suse.de>
References: <1134154208.14363.8.camel@mindpipe> <439A0746.80208@mnsu.edu> <1134173138.18432.41.camel@mindpipe> <439A201D.7030103@mnsu.edu> <1134179410.18432.66.camel@mindpipe> <p73oe3ppbxj.fsf@verdi.suse.de> <1134191524.18432.82.camel@mindpipe> <20051210071935.GQ11190@wotan.suse.de> <1134243273.18432.104.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134243273.18432.104.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are the relevant lines of arch/x86_64/kernel/vmlinux.lds:
> 
>     382 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
>     383 OUTPUT_ARCH(1:x86-64)
>     384 ENTRY(phys_startup_64)
> 
> Any ideas?  Another toolchain quirk?

The original is 

OUTPUT_ARCH(i386:x86-64)

It replaced the i386 with 1, which obviously doesn't work.

Try (full patch again) 

-Andi


Pass -m64 by default

This might help on distributions that use a 32bit biarch compiler.

Also add some more .code32s because at least the Ubuntu biarch
32bit gcc doesn't seem to handle -m64 -m32 as generated
by the Makefile without such assistance.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/Makefile
===================================================================
--- linux.orig/arch/x86_64/Makefile
+++ linux/arch/x86_64/Makefile
@@ -31,6 +31,7 @@ cflags-$(CONFIG_MK8) += $(call cc-option
 cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
 CFLAGS += $(cflags-y)
 
+CFLAGS += -m64
 CFLAGS += -mno-red-zone
 CFLAGS += -mcmodel=kernel
 CFLAGS += -pipe
@@ -52,6 +53,8 @@ CFLAGS += $(call cc-option,-funit-at-a-t
 # prevent gcc from generating any FP code by mistake
 CFLAGS += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
 
+AFLAGS += -m64
+
 head-y := arch/x86_64/kernel/head.o arch/x86_64/kernel/head64.o arch/x86_64/kernel/init_task.o
 
 libs-y 					+= arch/x86_64/lib/
Index: linux/arch/x86_64/ia32/vsyscall-sigreturn.S
===================================================================
--- linux.orig/arch/x86_64/ia32/vsyscall-sigreturn.S
+++ linux/arch/x86_64/ia32/vsyscall-sigreturn.S
@@ -7,6 +7,7 @@
  * by doing ".balign 32" must match in both versions of the page.
  */
 
+	.code32
 	.section .text.sigreturn,"ax"
 	.balign 32
 	.globl __kernel_sigreturn
Index: linux/arch/x86_64/ia32/vsyscall-syscall.S
===================================================================
--- linux.orig/arch/x86_64/ia32/vsyscall-syscall.S
+++ linux/arch/x86_64/ia32/vsyscall-syscall.S
@@ -6,6 +6,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/segment.h>
 
+	.code32
 	.text
 	.section .text.vsyscall,"ax"
 	.globl __kernel_vsyscall
Index: linux/arch/x86_64/ia32/vsyscall-sysenter.S
===================================================================
--- linux.orig/arch/x86_64/ia32/vsyscall-sysenter.S
+++ linux/arch/x86_64/ia32/vsyscall-sysenter.S
@@ -5,6 +5,7 @@
 #include <asm/ia32_unistd.h>
 #include <asm/asm-offsets.h>
 
+	.code32
 	.text
 	.section .text.vsyscall,"ax"
 	.globl __kernel_vsyscall
Index: linux/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux/arch/x86_64/kernel/vmlinux.lds.S
@@ -8,6 +8,8 @@
 #include <asm/page.h>
 #include <linux/config.h>
 
+#undef i386	/* in case the preprocessor is a 32bit one */
+
 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(phys_startup_64)
