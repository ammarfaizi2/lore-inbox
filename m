Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264772AbUFGQEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbUFGQEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUFGQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:04:24 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59013 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S264772AbUFGQD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:03:57 -0400
Date: Mon, 7 Jun 2004 18:03:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: arnd@arndb.de
Cc: jakub@redhat.com, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040607160348.GA2168@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My personal preference is:
> > 1) change s390* entry*.S so that all syscalls can use up to 6 arguments,
> >    otherwise we'll have the same problem every now and then
> >    (last syscall before this one was fadvise64_64 if I remember well)
> > 2) allow sys_futex to have 6 arguments (the 6th on the stack, get_user'ed
> >    from an s390 wrapper)
> > 3) special structure passed in 5th argument for FUTEX_CMP_REQUEUE
> > 4) your solution
> >    (you have a special wrapper around futex anyway, so why not to handle
> >    it there already and create completely new syscall).
> 
> I have talked to Martin about it (he won't be online for one more week),
> and he proposed a variant of 2): sys_futex, and possibly further new
> syscalls that might get added, pass their sixth argument in %r7,
> which is easier to get by than the user stack. Unlike doing it in
> the standard system call path, this won't cause any overhead for
> the other syscalls, but we need some wrappers.

I prefer to store the additional argument in %r7 for ALL system calls
to avoid addtitional system call wrappers. That way new system calls
with 6 arguments can be added without problems. The store for the
additional 6th argument can be hidden in a agi slot so this is pretty
much the perfect solution.

blue skies,
  Martin.

---

[PATCH] s390: add support for 6 system call arguments (FUTEX_CMP_REQUEUE).

This patch adds support for 6 system call arguments on s390. The
first exploiter of this will be the sys_futex system call for the
FUTEX_CMP_REQUEUE operation. The idea is simple: use register %r7
for the 6th argument. This can be extended to 7/8/9/... arguments
if there ever will be the need for it. To call the system call
function in the kernel the additional arguments needs to get stored
on the stack. 8 bytes are added to the head of struct pt_regs. %r7
is stored to the additional field for all system calls. The store
is hidden in a address-generation-interlock slot, it doesn't slow
down the system call path.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/asm-offsets.c    |    1 +
 arch/s390/kernel/compat_wrapper.S |    2 ++
 arch/s390/kernel/entry.S          |   10 +++++++---
 arch/s390/kernel/entry64.S        |   10 +++++++---
 arch/s390/kernel/ptrace.c         |   10 +++++-----
 include/asm-s390/ptrace.h         |    1 +
 6 files changed, 23 insertions(+), 11 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/asm-offsets.c linux-2.6-s390/arch/s390/kernel/asm-offsets.c
--- linux-2.6/arch/s390/kernel/asm-offsets.c	Mon May 10 04:32:26 2004
+++ linux-2.6-s390/arch/s390/kernel/asm-offsets.c	Mon Jun  7 16:10:03 2004
@@ -32,6 +32,7 @@
 	DEFINE(__TI_cpu, offsetof(struct thread_info, cpu),);
 	DEFINE(__TI_precount, offsetof(struct thread_info, preempt_count),);
 	BLANK();
+	DEFINE(__PT_ARGS, offsetof(struct pt_regs, args),);
 	DEFINE(__PT_PSW, offsetof(struct pt_regs, psw),);
 	DEFINE(__PT_GPRS, offsetof(struct pt_regs, gprs),);
 	DEFINE(__PT_ORIG_GPR2, offsetof(struct pt_regs, orig_gpr2),);
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-s390/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	Mon Jun  7 16:07:24 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_wrapper.S	Mon Jun  7 16:07:53 2004
@@ -1097,6 +1097,8 @@
 	lgfr	%r4,%r4			# int
 	llgtr	%r5,%r5			# struct compat_timespec *
 	llgtr	%r6,%r6			# u32 *
+	lgf	%r0,164(%r15)		# int
+	stg	%r0,160(%r15)
 	jg	compat_sys_futex	# branch to system call
 
 	.globl	sys32_setxattr_wrapper
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Mon Jun  7 16:07:24 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Mon Jun  7 16:11:55 2004
@@ -24,7 +24,8 @@
  * Stack layout for the system_call stack entry.
  * The first few entries are identical to the user_regs_struct.
  */
-SP_PTREGS    =  STACK_FRAME_OVERHEAD 
+SP_PTREGS    =  STACK_FRAME_OVERHEAD
+SP_ARGS      =  STACK_FRAME_OVERHEAD + __PT_ARGS
 SP_PSW       =  STACK_FRAME_OVERHEAD + __PT_PSW
 SP_R0        =  STACK_FRAME_OVERHEAD + __PT_GPRS
 SP_R1        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 4
@@ -230,12 +231,14 @@
 sysc_enter:
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	sla	%r7,2             # *4 and test for svc 0
-	bnz	BASED(sysc_do_restart)  # svc number > 0
+	bnz	BASED(sysc_nr_ok) # svc number > 0
 	# svc 0: system call number in %r1
 	cl	%r1,BASED(.Lnr_syscalls)
-	bnl	BASED(sysc_do_restart)
+	bnl	BASED(sysc_nr_ok)
 	lr	%r7,%r1           # copy svc number to %r7
 	sla	%r7,2             # *4
+sysc_nr_ok:
+	mvc	SP_ARGS(4,%r15),SP_R7(%r15)
 sysc_do_restart:
 	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
         l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
@@ -510,6 +513,7 @@
 	lr	%r7,%r1           # copy svc number to %r7
 	sla	%r7,2             # *4
 pgm_svcstd:
+	mvc	SP_ARGS(4,%r15),SP_R7(%r15)
 	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
         l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
         bnz     BASED(pgm_tracesys)
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Mon Jun  7 16:07:24 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Mon Jun  7 16:13:17 2004
@@ -24,7 +24,8 @@
  * Stack layout for the system_call stack entry.
  * The first few entries are identical to the user_regs_struct.
  */
-SP_PTREGS    =  STACK_FRAME_OVERHEAD 
+SP_PTREGS    =  STACK_FRAME_OVERHEAD
+SP_ARGS      =  STACK_FRAME_OVERHEAD + __PT_ARGS
 SP_PSW       =  STACK_FRAME_OVERHEAD + __PT_PSW
 SP_R0        =  STACK_FRAME_OVERHEAD + __PT_GPRS
 SP_R1        =  STACK_FRAME_OVERHEAD + __PT_GPRS + 8
@@ -214,13 +215,15 @@
 sysc_enter:
         GET_THREAD_INFO           # load pointer to task_struct to R9
         slag    %r7,%r7,2         # *4 and test for svc 0
-	jnz	sysc_do_restart
+	jnz	sysc_nr_ok
 	# svc 0: system call number in %r1
 	lghi	%r0,NR_syscalls
 	clr	%r1,%r0
-	jnl	sysc_do_restart
+	jnl	sysc_nr_ok
 	lgfr	%r7,%r1           # clear high word in r1
 	slag    %r7,%r7,2         # svc 0: system call number in %r1
+sysc_nr_ok:
+	mvc	SP_ARGS(8,%r15),SP_R7(%r15)
 sysc_do_restart:
 	larl    %r10,sys_call_table
 #ifdef CONFIG_S390_SUPPORT
@@ -542,6 +545,7 @@
 	clr	%r1,%r0
 	slag	%r7,%r1,2
 pgm_svcstd:
+	mvc	SP_ARGS(8,%r15),SP_R7(%r15)
 	larl    %r10,sys_call_table
 #ifdef CONFIG_S390_SUPPORT
         tm      SP_PSW+3(%r15),0x01  # are we running in 31 bit mode ?
diff -urN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-s390/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	Mon May 10 04:33:19 2004
+++ linux-2.6-s390/arch/s390/kernel/ptrace.c	Mon Jun  7 16:07:53 2004
@@ -141,7 +141,7 @@
 		/*
 		 * psw and gprs are stored on the stack
 		 */
-		tmp = *(addr_t *)((addr_t) __KSTK_PTREGS(child) + addr);
+		tmp = *(addr_t *)((addr_t) &__KSTK_PTREGS(child)->psw + addr);
 		if (addr == (addr_t) &dummy->regs.psw.mask)
 			/* Remove per bit from user psw. */
 			tmp &= ~PSW_MASK_PER;
@@ -215,7 +215,7 @@
 			   high order bit but older gdb's rely on it */
 			data |= PSW_ADDR_AMODE;
 #endif
-		*(addr_t *)((addr_t) __KSTK_PTREGS(child) + addr) = data;
+		*(addr_t *)((addr_t) &__KSTK_PTREGS(child)->psw + addr) = data;
 
 	} else if (addr < (addr_t) (&dummy->regs.orig_gpr2)) {
 		/*
@@ -360,7 +360,7 @@
 				PSW32_ADDR_AMODE31;
 		} else {
 			/* gpr 0-15 */
-			tmp = *(__u32 *)((addr_t) __KSTK_PTREGS(child) + 
+			tmp = *(__u32 *)((addr_t) &__KSTK_PTREGS(child)->psw +
 					 addr*2 + 4);
 		}
 	} else if (addr < (addr_t) (&dummy32->regs.orig_gpr2)) {
@@ -439,8 +439,8 @@
 				(__u64) tmp & PSW32_ADDR_INSN;
 		} else {
 			/* gpr 0-15 */
-			*(__u32*)((addr_t) __KSTK_PTREGS(child) + addr*2 + 4) =
-				tmp;
+			*(__u32*)((addr_t) &__KSTK_PTREGS(child)->psw
+				  + addr*2 + 4) = tmp;
 		}
 	} else if (addr < (addr_t) (&dummy32->regs.orig_gpr2)) {
 		/*
diff -urN linux-2.6/include/asm-s390/ptrace.h linux-2.6-s390/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/include/asm-s390/ptrace.h	Mon Jun  7 16:07:53 2004
@@ -303,6 +303,7 @@
  */
 struct pt_regs 
 {
+	unsigned long args[1];
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
 	unsigned long orig_gpr2;
