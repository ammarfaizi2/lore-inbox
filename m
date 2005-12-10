Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVLJHTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVLJHTi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbVLJHTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:19:38 -0500
Received: from mx1.suse.de ([195.135.220.2]:64423 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932769AbVLJHTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:19:37 -0500
Date: Sat, 10 Dec 2005 08:19:35 +0100
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
Message-ID: <20051210071935.GQ11190@wotan.suse.de>
References: <1134154208.14363.8.camel@mindpipe> <439A0746.80208@mnsu.edu> <1134173138.18432.41.camel@mindpipe> <439A201D.7030103@mnsu.edu> <1134179410.18432.66.camel@mindpipe> <p73oe3ppbxj.fsf@verdi.suse.de> <1134191524.18432.82.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134191524.18432.82.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2005 at 12:12:03AM -0500, Lee Revell wrote:
> On Sat, 2005-12-10 at 01:56 -0700, Andi Kleen wrote:
> > Lee Revell <rlrevell@joe-job.com> writes:
> > >  - disable CONFIG_IA32_EMULATION
> > 
> > I just tried it here. Adding -m64 to CFLAGS/AFLAGS on a native
> > 64bit biarch toolchain and it compiled without problems. It ends
> > up with -m64 -m32 for the 32bit vsyscall files, but that seems
> > to DTRT at least in gcc 4.
> 
> Nope, passing -m64 -m32 does not seem to DTRT on native 32bit biarch
> toolchain:

How about this patch? 

-Andi


Pass -m64 by default

This might help on distributions that use a 32bit biarch compiler.

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
