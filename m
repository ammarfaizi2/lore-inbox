Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313694AbSDPOnd>; Tue, 16 Apr 2002 10:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313696AbSDPOnc>; Tue, 16 Apr 2002 10:43:32 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1540 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S313694AbSDPOna>; Tue, 16 Apr 2002 10:43:30 -0400
Date: Tue, 16 Apr 2002 18:43:09 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Robert Love <rml@tech9.net>, Richard Henderson <rth@twiddle.net>
Cc: Oliver Pitzeier <o.pitzeier@uptime.at>, axp-kernel-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Kernel 2.5.8 on Alpha
Message-ID: <20020416184309.A623@jurassic.park.msu.ru>
In-Reply-To: <000001c1e3f7$86214880$1201a8c0@pitzeier.priv.at> <1018896466.857.12.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 02:47:42PM -0400, Robert Love wrote:
> +#define PREEMPT_ACTIVE		0x4000000

This is not enough. Currently I'm running 2.5.8 with following:
- fix pmd_populate;
- fix ptrace wrt thread_info - gdb and strace are working again;
- fix cond_syscall macro;
- various compile fixes, mostly from Chris Meadors.

Ivan.

--- 2.5.8/include/asm-alpha/pgalloc.h	Sun Apr 14 23:18:42 2002
+++ linux/include/asm-alpha/pgalloc.h	Mon Apr 15 18:36:43 2002
@@ -12,7 +12,7 @@
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
-	pmd_set(pmd, (pte_t *)((pte - mem_map) << PAGE_SHIFT));
+	pmd_val(*pmd) = _PAGE_TABLE | ((pte - mem_map) << 32);
 }
 
 static inline void
--- 2.5.8/include/asm-alpha/thread_info.h	Sun Apr 14 23:18:56 2002
+++ linux/include/asm-alpha/thread_info.h	Tue Apr 16 17:14:46 2002
@@ -9,6 +9,8 @@
 #include <asm/hwrpb.h>
 #endif
 
+#define PREEMPT_ACTIVE		0x4000000
+
 #ifndef __ASSEMBLY__
 struct thread_info {
 	struct pcb_struct	pcb;		/* palcode state */
@@ -18,6 +20,8 @@ struct thread_info {
 	unsigned int		ieee_state;	/* see fpu.h */
 
 	struct exec_domain	*exec_domain;	/* execution domain */
+	int			preempt_count;
+
 	mm_segment_t		addr_limit;	/* thread address space */
 	int			cpu;		/* current CPU */
 
--- 2.5.8/include/asm-alpha/mman.h	Sun Apr 14 23:18:43 2002
+++ linux/include/asm-alpha/mman.h	Mon Apr 15 18:36:43 2002
@@ -4,6 +4,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
--- 2.5.8/include/asm-alpha/siginfo.h	Sun Apr 14 23:18:51 2002
+++ linux/include/asm-alpha/siginfo.h	Tue Apr 16 17:14:46 2002
@@ -108,6 +108,7 @@ typedef struct siginfo {
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 #define SI_TKILL	-6		/* sent by tkill system call */
+#define SI_DETHREAD	-7		/* sent by execve() killing subsidiary threads */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
--- 2.5.8/include/asm-alpha/unistd.h	Sun Apr 14 23:18:51 2002
+++ linux/include/asm-alpha/unistd.h	Tue Apr 16 17:14:52 2002
@@ -603,6 +603,6 @@ static inline long delete_module(const c
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asm(".weak " #x "; " #x " = sys_ni_syscall");
 
 #endif /* _ALPHA_UNISTD_H */
--- 2.5.8/arch/alpha/kernel/ptrace.c	Sun Apr 14 23:18:55 2002
+++ linux/arch/alpha/kernel/ptrace.c	Mon Apr 15 18:36:43 2002
@@ -106,7 +106,7 @@ get_reg_addr(struct task_struct * task, 
 		zero = 0;
 		addr = &zero;
 	} else {
-		addr = (long *)((long)task + regoff[regno]);
+		addr = (long *)((long)task->thread_info + regoff[regno]);
 	}
 	return addr;
 }
@@ -292,7 +292,7 @@ sys_ptrace(long request, long pid, long 
 		if (request != PTRACE_KILL)
 			goto out;
 	}
-	if (child->p_pptr != current) {
+	if (child->parent != current) {
 		DBG(DBG_MEM, ("child not parent of this process\n"));
 		goto out;
 	}
@@ -340,9 +340,9 @@ sys_ptrace(long request, long pid, long 
 		if ((unsigned long) data > _NSIG)
 			goto out;
 		if (request == PTRACE_SYSCALL)
-			set_thread_flag(TIF_SYSCALL_TRACE);
+			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		else
-			clear_thread_flag(TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		wake_up_process(child);
 		/* make sure single-step breakpoint is gone. */
@@ -371,7 +371,7 @@ sys_ptrace(long request, long pid, long 
 			goto out;
 		/* Mark single stepping.  */
 		child->thread_info->bpt_nsaved = -1;
-		clear_thread_flag(TIF_SYSCALL_TRACE);
+		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		wake_up_process(child);
 		child->exit_code = data;
 		/* give it a chance to run. */
--- 2.5.8/arch/alpha/kernel/osf_sys.c	Sun Apr 14 23:18:42 2002
+++ linux/arch/alpha/kernel/osf_sys.c	Mon Apr 15 18:36:43 2002
@@ -219,7 +219,7 @@ asmlinkage unsigned long sys_getxpid(int
 	 * isn't actually going to matter, as if the parent happens
 	 * to change we can happily return either of the pids.
 	 */
-	(&regs)->r20 = tsk->p_opptr->pid;
+	(&regs)->r20 = tsk->real_parent->pid;
 	return tsk->pid;
 }
 
--- 2.5.8/arch/alpha/kernel/signal.c	Sun Apr 14 23:18:52 2002
+++ linux/arch/alpha/kernel/signal.c	Mon Apr 15 18:36:43 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
+#include <linux/binfmts.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -661,8 +662,8 @@ do_signal(sigset_t *oldset, struct pt_re
 				info.si_signo = signr;
 				info.si_errno = 0;
 				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
+				info.si_pid = current->parent->pid;
+				info.si_uid = current->parent->uid;
 			}
 
 			/* If the (new) signal is now blocked, requeue it.  */
@@ -701,7 +702,7 @@ do_signal(sigset_t *oldset, struct pt_re
 			case SIGSTOP:
 				current->state = TASK_STOPPED;
 				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1]
+				if (!(current->parent->sig->action[SIGCHLD-1]
 				      .sa.sa_flags & SA_NOCLDSTOP))
 					notify_parent(current, SIGCHLD);
 				schedule();
--- 2.5.8/arch/alpha/kernel/semaphore.c	Sun Apr 14 23:18:53 2002
+++ linux/arch/alpha/kernel/semaphore.c	Mon Apr 15 18:36:43 2002
@@ -6,6 +6,7 @@
  */
 
 #include <linux/sched.h>
+#include <asm/errno.h>
 
 
 /*
--- 2.5.8/arch/alpha/kernel/process.c	Sun Apr 14 23:18:49 2002
+++ linux/arch/alpha/kernel/process.c	Mon Apr 15 18:36:43 2002
@@ -54,6 +54,10 @@ sys_sethae(unsigned long hae, unsigned l
 	return 0;
 }
 
+void default_idle(void)
+{
+}
+
 void
 cpu_idle(void)
 {
--- 2.5.8/arch/alpha/kernel/setup.c	Sun Apr 14 23:18:46 2002
+++ linux/arch/alpha/kernel/setup.c	Tue Apr 16 18:23:52 2002
@@ -326,6 +326,8 @@ setup_memory(void *kernel_end)
 		goto try_again;
 	}
 
+	max_pfn = max_low_pfn;
+
 	/* Allocate the bootmap and mark the whole MM as reserved.  */
 	bootmap_size = init_bootmem(bootmap_start, max_low_pfn);
 
