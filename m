Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUKDCCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUKDCCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUKDCBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:01:35 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:61843
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262049AbUKDBzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:32 -0500
Subject: [patch 16/20] uml-use-sysemu-for-tt
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:52 +0100
Message-Id: <20041103231752.6928455C87@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/include/ptrace_user.h             |   11 +
 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c                  |    3 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/process_kern.c             |   56 ++++++++++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/ptrace-skas.h |   10 -
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process.c             |   18 +--
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process_kern.c        |   55 ---------
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/tt.h            |    2 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/syscall_user.c          |    5 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/tracer.c                |    9 +
 9 files changed, 86 insertions(+), 83 deletions(-)

diff -puN arch/um/include/ptrace_user.h~uml-use-sysemu-for-tt arch/um/include/ptrace_user.h
--- vanilla-linux-2.6.9/arch/um/include/ptrace_user.h~uml-use-sysemu-for-tt	2004-11-03 23:45:35.809994784 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/ptrace_user.h	2004-11-03 23:45:35.861986880 +0100
@@ -15,4 +15,15 @@ extern void arch_enter_kernel(void *task
 extern void arch_leave_kernel(void *task, int pid);
 extern void ptrace_pokeuser(unsigned long addr, unsigned long data);
 
+
+/* syscall emulation path in ptrace */
+
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU 31
+#endif
+
+void set_using_sysemu(int value);
+int get_using_sysemu(void);
+extern int sysemu_supported;
+
 #endif
diff -puN arch/um/kernel/skas/include/ptrace-skas.h~uml-use-sysemu-for-tt arch/um/kernel/skas/include/ptrace-skas.h
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/ptrace-skas.h~uml-use-sysemu-for-tt	2004-11-03 23:45:35.811994480 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/ptrace-skas.h	2004-11-03 23:45:35.861986880 +0100
@@ -10,16 +10,6 @@
 
 #ifdef UML_CONFIG_MODE_SKAS
 
-/* syscall emulation path in ptrace */
-
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-
-void set_using_sysemu(int value);
-int get_using_sysemu(void);
-extern int sysemu_supported;
-
 #include "skas_ptregs.h"
 
 #define HOST_FRAME_SIZE 17
diff -puN arch/um/kernel/process.c~uml-use-sysemu-for-tt arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-use-sysemu-for-tt	2004-11-03 23:45:35.812994328 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:45:35.862986728 +0100
@@ -242,9 +242,6 @@ static void __init check_sysemu(void)
 	void *stack;
 	int pid, n, status;
 
-	if (mode_tt)
-		return;
-
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
diff -puN arch/um/kernel/tt/syscall_user.c~uml-use-sysemu-for-tt arch/um/kernel/tt/syscall_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/tt/syscall_user.c~uml-use-sysemu-for-tt	2004-11-03 23:45:35.814994024 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/syscall_user.c	2004-11-03 23:45:35.862986728 +0100
@@ -50,7 +50,7 @@ void syscall_handler_tt(int sig, union u
 	record_syscall_end(index, result);
 }
 
-int do_syscall(void *task, int pid)
+int do_syscall(void *task, int pid, int local_using_sysemu)
 {
 	unsigned long proc_regs[FRAME_SIZE];
 	union uml_pt_regs *regs;
@@ -70,6 +70,9 @@ int do_syscall(void *task, int pid)
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
 		tracer_panic("I'm tracing myself and I can't get out");
 
+	if(local_using_sysemu)
+		return(1);
+
 	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, 
 		  __NR_getpid) < 0)
 		tracer_panic("do_syscall : Nullifying syscall failed, "
diff -puN arch/um/kernel/tt/tracer.c~uml-use-sysemu-for-tt arch/um/kernel/tt/tracer.c
--- vanilla-linux-2.6.9/arch/um/kernel/tt/tracer.c~uml-use-sysemu-for-tt	2004-11-03 23:45:35.815993872 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/tracer.c	2004-11-03 23:45:35.862986728 +0100
@@ -184,6 +184,7 @@ int tracer(int (*init_proc)(void *), voi
 	unsigned long eip = 0;
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
 	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
+	int pt_syscall_parm, local_using_sysemu;
 
 	capture_signal_stack();
 	signal(SIGPIPE, SIG_IGN);
@@ -297,6 +298,9 @@ int tracer(int (*init_proc)(void *), voi
 			tracing = is_tracing(task);
 			old_tracing = tracing;
 
+			local_using_sysemu = get_using_sysemu();
+			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
+
 			switch(sig){
 			case SIGUSR1:
 				sig = 0;
@@ -330,7 +334,7 @@ int tracer(int (*init_proc)(void *), voi
 					continue;
 				}
 				tracing = 0;
-				if(do_syscall(task, pid))
+				if(do_syscall(task, pid, local_using_sysemu))
 					sig = SIGUSR2;
 				else clear_singlestep(task);
 				break;
@@ -349,6 +353,7 @@ int tracer(int (*init_proc)(void *), voi
 			case SIGBUS:
 			case SIGILL:
 			case SIGWINCH:
+
 			default:
 				tracing = 0;
 				break;
@@ -370,7 +375,7 @@ int tracer(int (*init_proc)(void *), voi
 			if(tracing){
 				if(singlestepping_tt(task))
 					cont_type = PTRACE_SINGLESTEP;
-				else cont_type = PTRACE_SYSCALL;
+				else cont_type = pt_syscall_parm;
 			}
 			else cont_type = PTRACE_CONT;
 
diff -puN arch/um/kernel/skas/process.c~uml-use-sysemu-for-tt arch/um/kernel/skas/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/skas/process.c~uml-use-sysemu-for-tt	2004-11-03 23:45:35.817993568 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process.c	2004-11-03 23:45:35.863986576 +0100
@@ -139,17 +139,16 @@ void start_userspace(int cpu)
 
 void userspace(union uml_pt_regs *regs)
 {
-	int err, status, op, pid = userspace_pid[0];
+	int err, status, op, pt_syscall_parm, pid = userspace_pid[0];
 	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
 
 	restore_registers(regs);
 		
 	local_using_sysemu = get_using_sysemu();
 
-	if (local_using_sysemu)
-		err = ptrace(PTRACE_SYSEMU, pid, 0, 0);
-	else
-		err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
+	pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
+	err = ptrace(pt_syscall_parm, pid, 0, 0);
+
 	if(err)
 		panic("userspace - PTRACE_%s failed, errno = %d\n",
 		       local_using_sysemu ? "SYSEMU" : "SYSCALL", errno);
@@ -189,13 +188,10 @@ void userspace(union uml_pt_regs *regs)
 
 		/*Now we ended the syscall, so re-read local_using_sysemu.*/
 		local_using_sysemu = get_using_sysemu();
+		pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
 
-		if (local_using_sysemu)
-			op = singlestepping_skas() ? PTRACE_SINGLESTEP :
-				PTRACE_SYSEMU;
-		else
-			op = singlestepping_skas() ? PTRACE_SINGLESTEP :
-				PTRACE_SYSCALL;
+		op = singlestepping_skas() ? PTRACE_SINGLESTEP :
+			pt_syscall_parm;
 
 		err = ptrace(op, pid, 0, 0);
 		if(err)
diff -puN arch/um/kernel/skas/process_kern.c~uml-use-sysemu-for-tt arch/um/kernel/skas/process_kern.c
--- vanilla-linux-2.6.9/arch/um/kernel/skas/process_kern.c~uml-use-sysemu-for-tt	2004-11-03 23:45:35.836990680 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process_kern.c	2004-11-03 23:45:35.863986576 +0100
@@ -24,61 +24,6 @@
 #include "mode.h"
 #include "proc_mm.h"
 
-static atomic_t using_sysemu = ATOMIC_INIT(0);
-int sysemu_supported;
-
-void set_using_sysemu(int value)
-{
-	atomic_set(&using_sysemu, sysemu_supported && value);
-}
-
-int get_using_sysemu(void)
-{
-	return atomic_read(&using_sysemu);
-}
-
-int proc_read_sysemu(char *buf, char **start, off_t offset, int size,int *eof, void *data)
-{
-	if (snprintf(buf, size, "%d\n", get_using_sysemu()) < size) /*No overflow*/
-		*eof = 1;
-
-	return strlen(buf);
-}
-
-int proc_write_sysemu(struct file *file,const char *buf, unsigned long count,void *data)
-{
-	char tmp[2];
-
-	if (copy_from_user(tmp, buf, 1))
-		return -EFAULT;
-
-	if (tmp[0] == '0' || tmp[0] == '1')
-		set_using_sysemu(tmp[0] - '0');
-	return count; /*We use the first char, but pretend to write everything*/
-}
-
-int __init make_proc_sysemu(void)
-{
-	struct proc_dir_entry *ent;
-	if (mode_tt || !sysemu_supported)
-		return 0;
-
-	ent = create_proc_entry("sysemu", 0600, &proc_root);
-
-	if (ent == NULL)
-	{
-		printk("Failed to register /proc/sysemu\n");
-		return(0);
-	}
-
-	ent->read_proc  = proc_read_sysemu;
-	ent->write_proc = proc_write_sysemu;
-
-	return 0;
-}
-
-late_initcall(make_proc_sysemu);
-
 int singlestepping_skas(void)
 {
 	int ret = current->ptrace & PT_DTRACE;
diff -puN arch/um/kernel/process_kern.c~uml-use-sysemu-for-tt arch/um/kernel/process_kern.c
--- vanilla-linux-2.6.9/arch/um/kernel/process_kern.c~uml-use-sysemu-for-tt	2004-11-03 23:45:35.838990376 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process_kern.c	2004-11-03 23:45:35.932976088 +0100
@@ -18,6 +18,7 @@
 #include "linux/capability.h"
 #include "linux/vmalloc.h"
 #include "linux/spinlock.h"
+#include "linux/proc_fs.h"
 #include "asm/unistd.h"
 #include "asm/mman.h"
 #include "asm/segment.h"
@@ -398,6 +399,61 @@ int cpu(void)
 	return(current_thread->cpu);
 }
 
+static atomic_t using_sysemu = ATOMIC_INIT(0);
+int sysemu_supported;
+
+void set_using_sysemu(int value)
+{
+	atomic_set(&using_sysemu, sysemu_supported && value);
+}
+
+int get_using_sysemu(void)
+{
+	return atomic_read(&using_sysemu);
+}
+
+static int proc_read_sysemu(char *buf, char **start, off_t offset, int size,int *eof, void *data)
+{
+	if (snprintf(buf, size, "%d\n", get_using_sysemu()) < size) /*No overflow*/
+		*eof = 1;
+
+	return strlen(buf);
+}
+
+static int proc_write_sysemu(struct file *file,const char *buf, unsigned long count,void *data)
+{
+	char tmp[2];
+
+	if (copy_from_user(tmp, buf, 1))
+		return -EFAULT;
+
+	if (tmp[0] == '0' || tmp[0] == '1')
+		set_using_sysemu(tmp[0] - '0');
+	return count; /*We use the first char, but pretend to write everything*/
+}
+
+int __init make_proc_sysemu(void)
+{
+	struct proc_dir_entry *ent;
+	if (!sysemu_supported)
+		return 0;
+
+	ent = create_proc_entry("sysemu", 0600, &proc_root);
+
+	if (ent == NULL)
+	{
+		printk("Failed to register /proc/sysemu\n");
+		return(0);
+	}
+
+	ent->read_proc  = proc_read_sysemu;
+	ent->write_proc = proc_write_sysemu;
+
+	return 0;
+}
+
+late_initcall(make_proc_sysemu);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -puN arch/um/kernel/tt/include/tt.h~uml-use-sysemu-for-tt arch/um/kernel/tt/include/tt.h
--- vanilla-linux-2.6.9/arch/um/kernel/tt/include/tt.h~uml-use-sysemu-for-tt	2004-11-03 23:45:35.839990224 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/tt.h	2004-11-03 23:45:35.864986424 +0100
@@ -28,7 +28,7 @@ extern int singlestepping_tt(void *t);
 extern void clear_singlestep(void *t);
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
-extern int do_syscall(void *task, int pid);
+extern int do_syscall(void *task, int pid, int local_using_sysemu);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
 
_
