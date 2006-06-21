Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWFUHcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWFUHcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 03:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWFUHb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 03:31:59 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:39832 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932460AbWFUHb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 03:31:59 -0400
Date: Wed, 21 Jun 2006 03:27:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [RFC, patch] i386: vgetcpu(), take 2
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>
Message-ID: <200606210329_MC3-1-C305-E008@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a GDT entry's limit field to store per-cpu data for fast access
from userspace, and provide a vsyscall to access the current CPU
number stored there.

Questions:
 1. Will the vdso relocation patch break this?
 2. Should the version number of the vsyscall .so be incremented?

Test program using the new call:

/* vgetcpu.c: get CPU number we are running on.
 * build kernel with vgetcpu patch first, then:
 *  gcc -o vgetcpu vgetcpu.c <srcpath>/arch/i386/kernel/vsyscall-sysenter.so
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

extern int __vgetcpu(void);

int main(int argc, char * const argv[])
{
	printf("cpu: %u\n", __vgetcpu());

	return 0;
}

---
 arch/i386/kernel/cpu/common.c        |    3 +++
 arch/i386/kernel/head.S              |    8 +++++++-
 arch/i386/kernel/vsyscall-getcpu.S   |   25 +++++++++++++++++++++++++
 arch/i386/kernel/vsyscall-int80.S    |    2 ++
 arch/i386/kernel/vsyscall-sysenter.S |    2 ++
 arch/i386/kernel/vsyscall.lds.S      |    1 +
 6 files changed, 40 insertions(+), 1 deletion(-)

--- 2.6.17-32.orig/arch/i386/kernel/cpu/common.c
+++ 2.6.17-32/arch/i386/kernel/cpu/common.c
@@ -642,6 +642,9 @@ void __cpuinit cpu_init(void)
 		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
 		(CPU_16BIT_STACK_SIZE - 1);
 
+	/* Set up GDT entry for per-cpu data */
+ 	*(__u64 *)(&gdt[27]) |= cpu;
+
 	cpu_gdt_descr->size = GDT_SIZE - 1;
  	cpu_gdt_descr->address = (unsigned long)gdt;
 
--- 2.6.17-32.orig/arch/i386/kernel/head.S
+++ 2.6.17-32/arch/i386/kernel/head.S
@@ -525,7 +525,13 @@ ENTRY(cpu_gdt_table)
 	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
+
+	/*
+	 * Use a GDT entry to store per-cpu data for user space (DPL 3.)
+	 * 32-bit data segment, byte granularity, base 0, limit set at runtime.
+	 */
+	.quad 0x0040f20000000000	/* 0xd8 - for per-cpu user data */
+
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
--- /dev/null
+++ 2.6.17-32/arch/i386/kernel/vsyscall-getcpu.S
@@ -0,0 +1,25 @@
+/*
+ * vgetcpu
+ * This file is #include'd by vsyscall-*.S to define them after the
+ * vsyscall entry point.  The kernel assumes that the addresses of these
+ * routines are constant for all vsyscall implementations.
+ */
+
+#include <linux/errno.h>
+
+	.text
+	.org __kernel_rt_sigreturn+32,0x90
+	.globl __vgetcpu
+	.type __vgetcpu,@function
+__vgetcpu:
+.LSTART_vgetcpu:
+	movl $-EFAULT,%eax
+	movl $((27<<3)|3),%edx
+	lsll %edx,%eax
+	jnz 1f
+	andl $0xff,%eax
+1:
+	ret
+.LEND_vgetcpu:
+	.size __vgetcpu,.-.LSTART_vgetcpu
+
--- 2.6.17-32.orig/arch/i386/kernel/vsyscall-int80.S
+++ 2.6.17-32/arch/i386/kernel/vsyscall-int80.S
@@ -51,3 +51,5 @@ __kernel_vsyscall:
  * Get the common code for the sigreturn entry points.
  */
 #include "vsyscall-sigreturn.S"
+
+#include "vsyscall-getcpu.S"
--- 2.6.17-32.orig/arch/i386/kernel/vsyscall-sysenter.S
+++ 2.6.17-32/arch/i386/kernel/vsyscall-sysenter.S
@@ -120,3 +120,5 @@ SYSENTER_RETURN:
  * Get the common code for the sigreturn entry points.
  */
 #include "vsyscall-sigreturn.S"
+
+#include "vsyscall-getcpu.S"
--- 2.6.17-32.orig/arch/i386/kernel/vsyscall.lds.S
+++ 2.6.17-32/arch/i386/kernel/vsyscall.lds.S
@@ -57,6 +57,7 @@ VERSION
     	__kernel_vsyscall;
     	__kernel_sigreturn;
     	__kernel_rt_sigreturn;
+	__vgetcpu;
 
     local: *;
   };
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
