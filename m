Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269811AbSISDVh>; Wed, 18 Sep 2002 23:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269837AbSISDVh>; Wed, 18 Sep 2002 23:21:37 -0400
Received: from crack.them.org ([65.125.64.184]:25359 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S269811AbSISDVe>;
	Wed, 18 Sep 2002 23:21:34 -0400
Date: Wed, 18 Sep 2002 23:26:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel@vger.kernel.org
Subject: ptrace() event tracing [1/3]
Message-ID: <20020919032633.GA1640@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending to a larger audience... Linus, patch 2/3 has been updated to fix
some assembly errors on my part.  They're in the BK repository also.]

Linus,

Now that all  of the known ptrace bugs in 2.5-BK have been fixed, I'm back
to the patch that got me into this code in the first place.  I spent more
time testing the new mechanism; I have both GDB and strace using it; and I
discussed it with several people in Debian and Red Hat who have been
involved with strace recently - they all seemed to like it.  Ingo had no
objections either.

I'm submitting it as a series of three patches:

 1. Factor out some common ptrace code; implement PTRACE_O_TRACESYSGOOD
    and PTRACE_SETOPTIONS for every architecture.  This one will let me unify
    a great deal more of the architecture ptrace implementations later.
 2. Add a new clone flag, CLONE_UNTRACED, and force it in all kernel_thread
    implementations.  Needed by the next patch.  This one touches every
    architecture and some of them in assembly; I've tried to get them all 
    correct.
 3. Add PTRACE_GETEVENTMSG and four new flags to PTRACE_SETOPTIONS, to allow
    tracing fork, vfork, clone, and exec events.

These three patches are in a BK tree at:
  bk://nevyn.them.org:5000
if you prefer.

Here's the first patch.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.558   -> 1.559  
#	include/linux/sched.h	1.95    -> 1.96   
#	include/linux/ptrace.h	1.4     -> 1.5    
#	       kernel/fork.c	1.77    -> 1.78   
#	    fs/binfmt_aout.c	1.12    -> 1.13   
#	     fs/binfmt_elf.c	1.29    -> 1.30   
#	     kernel/ptrace.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/17	drow@nevyn.them.org	1.559
# Add new ptrace event tracing mechanism
# --------------------------------------------
#
diff -Nru a/fs/binfmt_aout.c b/fs/binfmt_aout.c
--- a/fs/binfmt_aout.c	Tue Sep 17 20:29:42 2002
+++ b/fs/binfmt_aout.c	Tue Sep 17 20:29:42 2002
@@ -425,8 +425,12 @@
 	regs->gp = ex.a_gpvalue;
 #endif
 	start_thread(regs, ex.a_entry, current->mm->start_stack);
-	if (current->ptrace & PT_PTRACED)
-		send_sig(SIGTRAP, current, 0);
+	if (unlikely(current->ptrace & PT_PTRACED)) {
+		if (current->ptrace & PT_TRACE_EXEC)
+			ptrace_notify ((PTRACE_EVENT_EXEC << 8) | SIGTRAP);
+		else
+			send_sig(SIGTRAP, current, 0);
+	}
 	return 0;
 }
 
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	Tue Sep 17 20:29:42 2002
+++ b/fs/binfmt_elf.c	Tue Sep 17 20:29:42 2002
@@ -792,8 +792,12 @@
 #endif
 
 	start_thread(regs, elf_entry, bprm->p);
-	if (current->ptrace & PT_PTRACED)
-		send_sig(SIGTRAP, current, 0);
+	if (unlikely(current->ptrace & PT_PTRACED)) {
+		if (current->ptrace & PT_TRACE_EXEC)
+			ptrace_notify ((PTRACE_EVENT_EXEC << 8) | SIGTRAP);
+		else
+			send_sig(SIGTRAP, current, 0);
+	}
 	retval = 0;
 out:
 	return retval;
diff -Nru a/include/linux/ptrace.h b/include/linux/ptrace.h
--- a/include/linux/ptrace.h	Tue Sep 17 20:29:42 2002
+++ b/include/linux/ptrace.h	Tue Sep 17 20:29:42 2002
@@ -25,9 +25,20 @@
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
+#define PTRACE_GETEVENTMSG	0x4201
 
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD	0x00000001
+#define PTRACE_O_TRACEFORK	0x00000002
+#define PTRACE_O_TRACEVFORK	0x00000004
+#define PTRACE_O_TRACECLONE	0x00000008
+#define PTRACE_O_TRACEEXEC	0x00000010
+
+/* Wait extended result codes for the above trace options.  */
+#define PTRACE_EVENT_FORK	1
+#define PTRACE_EVENT_VFORK	2
+#define PTRACE_EVENT_CLONE	3
+#define PTRACE_EVENT_EXEC	4
 
 #include <asm/ptrace.h>
 #include <linux/sched.h>
@@ -39,6 +50,7 @@
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
 extern int ptrace_request(struct task_struct *child, long request, long addr, long data);
+extern void ptrace_notify(int exit_code);
 extern void __ptrace_link(struct task_struct *child,
 				struct task_struct *new_parent);
 extern void __ptrace_unlink(struct task_struct *child);
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Sep 17 20:29:42 2002
+++ b/include/linux/sched.h	Tue Sep 17 20:29:42 2002
@@ -397,6 +397,8 @@
 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+
+	unsigned long ptrace_message;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -435,6 +437,10 @@
 #define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
 #define PT_TRACESYSGOOD	0x00000004
 #define PT_PTRACE_CAP	0x00000008	/* ptracer can follow suid-exec */
+#define PT_TRACE_FORK	0x00000010
+#define PT_TRACE_VFORK	0x00000020
+#define PT_TRACE_CLONE	0x00000040
+#define PT_TRACE_EXEC	0x00000080
 
 /*
  * Limit the stack by to some sane default: root can always
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Tue Sep 17 20:29:42 2002
+++ b/kernel/fork.c	Tue Sep 17 20:29:42 2002
@@ -923,6 +923,22 @@
 	goto fork_out;
 }
 
+static inline int fork_traceflag (unsigned clone_flags)
+{
+	if (clone_flags & (CLONE_UNTRACED | CLONE_IDLETASK))
+		return 0;
+	else if (clone_flags & CLONE_VFORK) {
+		if (current->ptrace & PT_TRACE_VFORK)
+			return PTRACE_EVENT_VFORK;
+	} else if ((clone_flags & CSIGNAL) != SIGCHLD) {
+		if (current->ptrace & PT_TRACE_CLONE)
+			return PTRACE_EVENT_CLONE;
+	} else if (current->ptrace & PT_TRACE_FORK)
+		return PTRACE_EVENT_FORK;
+
+	return 0;
+}
+
 /*
  *  Ok, this is the main fork-routine.
  *
@@ -936,6 +952,13 @@
 			    int *user_tid)
 {
 	struct task_struct *p;
+	int trace = 0;
+
+	if (unlikely(current->ptrace)) {
+		trace = fork_traceflag (clone_flags);
+		if (trace)
+			clone_flags |= CLONE_PTRACE;
+	}
 
 	p = copy_process(clone_flags, stack_start, regs, stack_size, user_tid);
 	if (!IS_ERR(p)) {
@@ -951,6 +974,12 @@
 
 		wake_up_forked_process(p);		/* do this last */
 		++total_forks;
+
+		if (unlikely (trace)) {
+			current->ptrace_message = (unsigned long) p->pid;
+			ptrace_notify ((trace << 8) | SIGTRAP);
+		}
+
 		if (clone_flags & CLONE_VFORK)
 			wait_for_completion(&vfork);
 		else
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Tue Sep 17 20:29:42 2002
+++ b/kernel/ptrace.c	Tue Sep 17 20:29:42 2002
@@ -249,14 +249,37 @@
 	return copied;
 }
 
-int ptrace_setoptions(struct task_struct *child, long data)
+static int ptrace_setoptions(struct task_struct *child, long data)
 {
 	if (data & PTRACE_O_TRACESYSGOOD)
 		child->ptrace |= PT_TRACESYSGOOD;
 	else
 		child->ptrace &= ~PT_TRACESYSGOOD;
 
-	if ((data & PTRACE_O_TRACESYSGOOD) != data)
+	if (data & PTRACE_O_TRACEFORK)
+		child->ptrace |= PT_TRACE_FORK;
+	else
+		child->ptrace &= ~PT_TRACE_FORK;
+
+	if (data & PTRACE_O_TRACEVFORK)
+		child->ptrace |= PT_TRACE_VFORK;
+	else
+		child->ptrace &= ~PT_TRACE_VFORK;
+
+	if (data & PTRACE_O_TRACECLONE)
+		child->ptrace |= PT_TRACE_CLONE;
+	else
+		child->ptrace &= ~PT_TRACE_CLONE;
+
+	if (data & PTRACE_O_TRACEEXEC)
+		child->ptrace |= PT_TRACE_EXEC;
+	else
+		child->ptrace &= ~PT_TRACE_EXEC;
+
+	if ((data & (PTRACE_O_TRACESYSGOOD | PTRACE_O_TRACEFORK
+		    | PTRACE_O_TRACEVFORK | PTRACE_O_TRACECLONE
+		    | PTRACE_O_TRACEEXEC))
+	    != data)
 		return -EINVAL;
 
 	return 0;
@@ -274,9 +297,23 @@
 	case PTRACE_SETOPTIONS:
 		ret = ptrace_setoptions(child, data);
 		break;
+	case PTRACE_GETEVENTMSG:
+		ret = put_user(child->ptrace_message, (unsigned long *) data);
+		break;
 	default:
 		break;
 	}
 
 	return ret;
+}
+
+void ptrace_notify(int exit_code)
+{
+	BUG_ON (!(current->ptrace & PT_PTRACED));
+
+	/* Let the debugger run.  */
+	current->exit_code = exit_code;
+	set_current_state(TASK_STOPPED);
+	notify_parent(current, SIGCHLD);
+	schedule();
 }


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
