Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272355AbTHBJGd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272379AbTHBJGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:06:33 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:1801
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S272355AbTHBJG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:06:26 -0400
Subject: [BROKEN PATCH] syscalls leak data via registers?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1059815183.18860.55.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 02:06:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks to me like the syscall calling convention, on x86 at least,
leaks kernel data out via the registers.

In arch/i386/kernel/entry.S, system_call saves all the registers on the
stack and then calls the appropriate system call function.  The integer
registers are saved on the stack in the appropriate order for the C
calling convention, so ebx=arg1, ecx=arg2, etc.

On system call exit, it saves %eax (the return value) back the stack,
restores all those registers by popping them off the stack and returns
to user-mode.

The trouble is that gcc assumes it can reuse the stack space used by
arguments for spilling, so the values the return path restores are not
necessarily the ones it saved.

For example:

If you have sys_foo():

int sys_foo(int arg1, int arg2)
/* arg1 at 4(%esp) on entry */
/* arg2 at 8(%esp) on entry */
{
	/*... stuff ...*/
	arg1 = 77;
		movl	$77, %arg1
	
	/* compiler needs to spill arg1: */
		movl	%arg1, 4(%esp)

	/* ... */

	return 99;
}

When sys_foo returns, the value of %ebx has been changed to 77 on the
stack, so when it returns to user-mode, the whole world can see that
arg1 was assigned 77 at some point.

It seems to me the bug is in restoring the register values on return to
user-mode.  As I understand it, the x86 ABI says that the called
function owns the stack memory which contains the function's arguments,
so it is completely within gcc's right to reuse the memory as spill
space (or anything else) when generating code for that function. 
Therefore, the code in entry.S should not restore those values to
registers - it should just trash all the registers (except %eax, of
course) before returning.

I tried writing a patch which replaces the RESTORE_ALL with the
equivalent which simply skips %esp over the other registers, pops %eax
and then assigns it to %ebx-%ebp (it makes as good a trash value as
any), but this crashes when calibrating the delay loop.  Hm, looks like
the RESTORE_ALL on the syscall return path is also used by the interrupt
return path - that probably shouldn't trash registers.

Anyway, patch attached so you can see what I'm thinking.

	J

 arch/i386/kernel/entry.S |   47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 45 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/entry.S~syscall-trash-regs arch/i386/kernel/entry.S
--- local-2.6/arch/i386/kernel/entry.S~syscall-trash-regs	2003-08-02 01:33:00.000000000 -0700
+++ local-2.6-jeremy/arch/i386/kernel/entry.S	2003-08-02 01:40:32.000000000 -0700
@@ -122,6 +122,33 @@ TSS_ESP0_OFFSET = (4 - 0x200)
 	popl %ebp;	\
 	popl %eax
 
+/* restore %eax, trash the rest */
+#define RESTORE_EAX		\
+	lea  6*4(%esp),%esp;	\
+	popl %eax;		\
+	movl %eax,%ebx;		\
+	movl %eax,%ecx;		\
+	movl %eax,%edx;		\
+	movl %eax,%esi;		\
+	movl %eax,%edi;		\
+	movl %eax,%ebp
+
+#define RESTORE_SOME_REGS	\
+	RESTORE_EAX;		\
+1:	popl %ds;		\
+2:	popl %es;		\
+.section .fixup,"ax";		\
+3:	movl $0,(%esp);		\
+	jmp 1b;			\
+4:	movl $0,(%esp);		\
+	jmp 2b;			\
+.previous;			\
+.section __ex_table,"a";	\
+	.align 4;		\
+	.long 1b,3b;		\
+	.long 2b,4b;		\
+.previous
+
 #define RESTORE_REGS	\
 	RESTORE_INT_REGS; \
 1:	popl %ds;	\
@@ -138,6 +165,22 @@ TSS_ESP0_OFFSET = (4 - 0x200)
 	.long 2b,4b;	\
 .previous
 
+#define RESTORE_MOST	\
+	RESTORE_SOME_REGS;	\
+	addl $4, %esp;	\
+1:	iret;		\
+.section .fixup,"ax";   \
+2:	sti;		\
+	movl $(__USER_DS), %edx; \
+	movl %edx, %ds; \
+	movl %edx, %es; \
+	pushl $11;	\
+	call do_exit;	\
+.previous;		\
+.section __ex_table,"a";\
+	.align 4;	\
+	.long 1b,2b;	\
+.previous
 
 #define RESTORE_ALL	\
 	RESTORE_REGS	\
@@ -324,8 +367,8 @@ restore_all:
         
 resume_kernelX:
 #endif
-	RESTORE_ALL
-
+	RESTORE_MOST
+	
 	# perform work that needs to be done immediately before resumption
 	ALIGN
 work_pending:

_


