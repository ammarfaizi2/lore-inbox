Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVDMBeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVDMBeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVDMBbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:31:38 -0400
Received: from mail.aknet.ru ([217.67.122.194]:18447 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262163AbVDLTyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:54:02 -0400
Message-ID: <425C2767.6080603@aknet.ru>
Date: Tue, 12 Apr 2005 23:54:15 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: petkov@uni-muenster.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: [patch 3/3]: fix BAD_SYSCALL_EXIT lockup
References: <20050411012532.58593bc1.akpm@osdl.org>	<1113209793l.7664l.1l@werewolf.able.es>	<20050411024322.786b83de.akpm@osdl.org>	<200504112359.40487.petkov@uni-muenster.de>	<20050411152243.22835d96.akpm@osdl.org>	<425B4C92.1070507@aknet.ru> <20050411212712.0dbd821d.akpm@osdl.org>
In-Reply-To: <20050411212712.0dbd821d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040005000407060901030905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005000407060901030905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

CONFIG_TRAP_BAD_SYSCALL_EXITS forgets to do
GET_THREAD_INFO(%ebp) before accessing the
TI_preempt_count(%ebp). This leads to an
accesses to the random addresses and kills
the machine. Also "int $3" does nothing good
by itself (it would just Oops AFAICS). And
it is misplaced, too. Obviously it never worked.

The attached patch moves the check to the
right place (to the syscall_exit path) and
replaces the "int $3" by the call to the
helper function that only prints some debug
info and doesn't crash the system.
This fully solves the reported problem.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------040005000407060901030905
Content-Type: text/x-patch;
 name="kgdbfix2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdbfix2.diff"

--- linux/arch/i386/kernel/entry.S	2005-04-12 09:47:38.000000000 +0400
+++ linux/arch/i386/kernel/entry.S	2005-04-12 11:51:49.000000000 +0400
@@ -253,24 +253,15 @@
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
+#ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
+	movl %esp, %eax			# pt_regs pointer
+	call sys_call_exit
+#endif
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
 
 restore_all:
-#ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
-	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
-	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernelX		# returning to kernel or vm86-space
-
-	cmpl $0,TI_preempt_count(%ebp)  # non-zero preempt_count ?
-	jz resume_kernelX
-
-        int $3
-
-resume_kernelX:
-#endif
 	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
--- linux/arch/i386/kernel/kgdb_stub.c	2005-04-12 09:47:38.000000000 +0400
+++ linux/arch/i386/kernel/kgdb_stub.c	2005-04-12 13:23:57.000000000 +0400
@@ -2135,18 +2135,16 @@
 #endif
 #undef regs
 #ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
-asmlinkage void
-bad_sys_call_exit(int stuff)
+fastcall void sys_call_exit(struct pt_regs *regs)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stuff;
-	printk("Sys call %d return with %x preempt_count\n",
-	       (int) regs->orig_eax, preempt_count());
+	if (preempt_count())
+		printk("Sys call %d return with %x preempt_count\n",
+			(int) regs->orig_eax, preempt_count());
 }
 #endif
 #ifdef CONFIG_STACK_OVERFLOW_TEST
 #include <asm/kgdb.h>
-asmlinkage void
-stack_overflow(void)
+fastcall void stack_overflow(void)
 {
 #ifdef BREAKPOINT
 	BREAKPOINT;

--------------040005000407060901030905--
