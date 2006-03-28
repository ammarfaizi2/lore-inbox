Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWC2ADG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWC2ADG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWC2ABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:47 -0500
Received: from [151.97.230.9] ([151.97.230.9]:28609 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964857AbWC2ABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/7] uml: clean arch_switch usage
Date: Wed, 29 Mar 2006 01:56:55 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060328235655.13838.14912.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Call arch_switch also in switch_to_skas, even if it's, for now, a no-op for that
case (and mark this in the comment); this will change soon.

Also, arch_switch for TT mode is actually useless when the PT proxy (a
complicate debugging instrumentation for TT mode) is not enabled. In fact, it
only calls update_debugregs, which checks debugregs_seq against seq (to check
if the registers are up-to-date - seq here means a "version number" of the
registers).

If the ptrace proxy is not enabled, debugregs_seq always stays 0 and
update_debugregs will be a no-op. So, optimize this out (the compiler can't
do it).

Also, I've been disappointed by the fact that it would make a lot of sense
if, after calling a successful
update_debugregs(current->thread.arch.debugregs_seq),
current->thread.arch.debugregs_seq were updated with the new debugregs_seq.
But this is not done. Is this a bug or a feature? For all purposes, it seems
a bug (otherwise the whole mechanism does not make sense, which is also a
possibility to check), which causes some performance only problems (not
correctness), since we write_debugregs when not needed.

Also, as suggested by Jeff, remove a redundant enabling of SIGVTALRM,
comprised in the subsequent local_irq_enable(). I'm just a bit dubious if
ordering matters there...

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/kern_util.h          |    6 +++++-
 arch/um/include/sysdep-i386/ptrace.h |    5 +++++
 arch/um/kernel/skas/process_kern.c   |    2 ++
 arch/um/kernel/tt/process_kern.c     |   10 ++++++++--
 arch/um/sys-i386/ptrace.c            |    8 ++++++--
 arch/um/sys-i386/ptrace_user.c       |   10 +++++++++-
 6 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index 07176d9..4255713 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -116,7 +116,11 @@ extern void *get_current(void);
 extern struct task_struct *get_task(int pid, int require);
 extern void machine_halt(void);
 extern int is_syscall(unsigned long addr);
-extern void arch_switch(void);
+
+extern void arch_switch_to_tt(struct task_struct *from, struct task_struct *to);
+
+extern void arch_switch_to_skas(struct task_struct *from, struct task_struct *to);
+
 extern void free_irq(unsigned int, void *);
 extern int cpu(void);
 
diff --git a/arch/um/include/sysdep-i386/ptrace.h b/arch/um/include/sysdep-i386/ptrace.h
index c8ee955..6670cc9 100644
--- a/arch/um/include/sysdep-i386/ptrace.h
+++ b/arch/um/include/sysdep-i386/ptrace.h
@@ -14,7 +14,12 @@
 #define MAX_REG_NR (UM_FRAME_SIZE / sizeof(unsigned long))
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
 
+#ifdef UML_CONFIG_PT_PROXY
 extern void update_debugregs(int seq);
+#else
+static inline void update_debugregs(int seq) {}
+#endif
+
 
 /* syscall emulation path in ptrace */
 
diff --git a/arch/um/kernel/skas/process_kern.c b/arch/um/kernel/skas/process_kern.c
index 3f70a2e..14360ac 100644
--- a/arch/um/kernel/skas/process_kern.c
+++ b/arch/um/kernel/skas/process_kern.c
@@ -35,6 +35,8 @@ void switch_to_skas(void *prev, void *ne
 	switch_threads(&from->thread.mode.skas.switch_buf,
 		       to->thread.mode.skas.switch_buf);
 
+	arch_switch_to_skas(current->thread.prev_sched, current);
+
 	if(current->pid == 0)
 		switch_timers(1);
 }
diff --git a/arch/um/kernel/tt/process_kern.c b/arch/um/kernel/tt/process_kern.c
index 295c1ac..a9c1443 100644
--- a/arch/um/kernel/tt/process_kern.c
+++ b/arch/um/kernel/tt/process_kern.c
@@ -51,6 +51,13 @@ void switch_to_tt(void *prev, void *next
 
 	c = 0;
 
+	/* Notice that here we "up" the semaphore on which "to" is waiting, and
+	 * below (the read) we wait on this semaphore (which is implemented by
+	 * switch_pipe) and go sleeping. Thus, after that, we have resumed in
+	 * "to", and can't use any more the value of "from" (which is outdated),
+	 * nor the value in "to" (since it was the task which stole us the CPU,
+	 * which we don't care about). */
+
 	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
 	if(err != sizeof(c))
 		panic("write of switch_pipe failed, err = %d", -err);
@@ -77,7 +84,7 @@ void switch_to_tt(void *prev, void *next
 	change_sig(SIGALRM, alrm);
 	change_sig(SIGPROF, prof);
 
-	arch_switch();
+	arch_switch_to_tt(prev_sched, current);
 
 	flush_tlb_all();
 	local_irq_restore(flags);
@@ -141,7 +148,6 @@ static void new_thread_handler(int sig)
 	set_cmdline("(kernel thread)");
 
 	change_sig(SIGUSR1, 1);
-	change_sig(SIGVTALRM, 1);
 	change_sig(SIGPROF, 1);
 	local_irq_enable();
 	if(!run_kernel_thread(fn, arg, &current->thread.exec_buf))
diff --git a/arch/um/sys-i386/ptrace.c b/arch/um/sys-i386/ptrace.c
index 8032a10..bf896b8 100644
--- a/arch/um/sys-i386/ptrace.c
+++ b/arch/um/sys-i386/ptrace.c
@@ -15,9 +15,13 @@
 #include "sysdep/sigcontext.h"
 #include "sysdep/sc.h"
 
-void arch_switch(void)
+void arch_switch_to_tt(struct task_struct *from, struct task_struct *to)
+{
+	update_debugregs(to->thread.arch.debugregs_seq);
+}
+
+void arch_switch_to_skas(struct task_struct *from, struct task_struct *to)
 {
-	update_debugregs(current->thread.arch.debugregs_seq);
 }
 
 int is_syscall(unsigned long addr)
diff --git a/arch/um/sys-i386/ptrace_user.c b/arch/um/sys-i386/ptrace_user.c
index 397e3c3..e6826ef 100644
--- a/arch/um/sys-i386/ptrace_user.c
+++ b/arch/um/sys-i386/ptrace_user.c
@@ -14,6 +14,7 @@
 #include "sysdep/thread.h"
 #include "user.h"
 #include "os.h"
+#include "uml-config.h"
 
 int ptrace_getregs(long pid, unsigned long *regs_out)
 {
@@ -43,6 +44,7 @@ int ptrace_setfpregs(long pid, unsigned 
 	return 0;
 }
 
+/* All the below stuff is of interest for TT mode only */
 static void write_debugregs(int pid, unsigned long *regs)
 {
 	struct user *dummy;
@@ -75,7 +77,6 @@ static void read_debugregs(int pid, unsi
 
 /* Accessed only by the tracing thread */
 static unsigned long kernel_debugregs[8] = { [ 0 ... 7 ] = 0 };
-static int debugregs_seq = 0;
 
 void arch_enter_kernel(void *task, int pid)
 {
@@ -89,6 +90,11 @@ void arch_leave_kernel(void *task, int p
 	write_debugregs(pid, TASK_DEBUGREGS(task));
 }
 
+#ifdef UML_CONFIG_PT_PROXY
+/* Accessed only by the tracing thread */
+static int debugregs_seq = 0;
+
+/* Only called by the ptrace proxy */
 void ptrace_pokeuser(unsigned long addr, unsigned long data)
 {
 	if((addr < offsetof(struct user, u_debugreg[0])) ||
@@ -109,6 +115,7 @@ static void update_debugregs_cb(void *ar
 	write_debugregs(pid, kernel_debugregs);
 }
 
+/* Optimized out in its header when not defined */
 void update_debugregs(int seq)
 {
 	int me;
@@ -118,6 +125,7 @@ void update_debugregs(int seq)
 	me = os_getpid();
 	initial_thread_cb(update_debugregs_cb, &me);
 }
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
