Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWH2LTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWH2LTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWH2LTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:19:11 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:19614 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S964891AbWH2LTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:19:09 -0400
Date: Tue, 29 Aug 2006 03:22:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: Re: [PATCH 3/7] provide kernel_execve on all architectures
Message-ID: <20060829022209.GA14661@linux-mips.org>
References: <20060827214734.252316000@klappe.arndb.de> <20060827215636.263883000@klappe.arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827215636.263883000@klappe.arndb.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 11:47:37PM +0200, Arnd Bergmann wrote:

> This adds the new kernel_execve function on all architectures
> that were using _syscall3() to implement execve.
> 
> The implementation uses code from the _syscall3 macros provided
> in the unistd.h header file. I don't have cross-compilers for
> any of these architectures, so the patch is untested with the
> exception of i386.
> 
> Most architectures can probably implement this in a nicer way
> in assembly or by combining it with the sys_execve implementation
> itself, but this should do it for now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Two bugs in your MIPS version of kernel_execve(); the inline asm which
was copying from _syscall3 macro was still using the #stringify
operation.  It also didn't get the result return in case of errors
right - $a3 = 1 indicates an error in which case $v0 will contain the
positive error number.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 0721314..b73b26c 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -399,3 +399,32 @@ asmlinkage void bad_stack(void)
 {
 	do_exit(SIGSEGV);
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register unsigned long __a0 asm("$4") = (unsigned long) filename;
+	register unsigned long __a1 asm("$5") = (unsigned long) argv;
+	register unsigned long __a2 asm("$6") = (unsigned long) envp;
+	register unsigned long __a3 asm("$7");
+	unsigned long __v0;
+
+	__asm__ volatile ("					\n"
+	"	.set	noreorder				\n"
+	"	li	$2, %5		# __NR_execve		\n"
+	"	syscall						\n"
+	"	move	%0, $2					\n"
+	"	.set	reorder					\n"
+	: "=&r" (__v0), "=r" (__a3)
+	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_execve)
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
+	  "memory");
+
+	if (__a3 == 0)
+		return __v0;
+
+	return -__v0;
+}
