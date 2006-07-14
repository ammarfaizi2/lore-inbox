Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWGNGJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWGNGJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWGNGJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:09:34 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:44772
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1161278AbWGNGJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:09:33 -0400
Date: Fri, 14 Jul 2006 08:09:32 +0200
From: andrea@cpushare.com
To: Andrew Morton <akpm@osdl.org>
Cc: bruce@andrew.cmu.edu, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       bunk@stusta.de, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       alan@redhat.com, torvalds@osdl.org, mingo@elte.hu
Subject: [PATCH] TIF_NOTSC and SECCOMP prctl
Message-ID: <20060714060932.GE18774@opteron.random>
References: <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random> <1152635055.18028.32.camel@localhost.localdomain> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <20060712185103.f41b51d2.akpm@osdl.org> <44B5F9E6.8070501@andrew.cmu.edu> <20060713083441.GD28310@opteron.random> <20060713021818.b0c0093e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713021818.b0c0093e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 02:18:18AM -0700, Andrew Morton wrote:
> removed me from cc.  Possibly an act of mercy ;)

;)

> I see "[compile tested only; requires just-sent fix to i386 system.h]", so
> an appropriate next step would be for you to review, test, sign-off and
> forward it, please.

I took the liberty to add Chuck's signoff as well since I started
hacking on top of his patch, if this is not ok Chuck please let us
know.

The below patch seems to work, I ported all my client code on top of
prctl already. (it's a bit more painful to autodetect a kernel with
CONFIG_SECCOMP turned off but I already adapted to it)

The only thing left worth discussing is why if I set TIF_NOTSC to 10
instead of 19 the kernel was crashing hard... After I checked and
rechecked everything else I deduced it had to be that number and after
changing it to 19 everything works fine... I also verified the first
rdtsc kills the task with a sigsegv. It would be nice to make sure
it's not a bug in the below patch that 10 didn't work but just some
hidden kernel "feature" ;).

The reduction of 36 lines should be a welcome thing. I also left a
CONFIG_SECCOMP in the slow path around the TIF_NOTSC stuff, so the ones
setting CONFIG_SECCOMP=n won't notice any bytecode size
difference. (those two CONFIG_SECCOMP should be removed if somebody
adds a standalone prctl that only calls disable_TSC()).

Compared to Chuck's patch I also moved the io_bitmap in a path that
only executes if either prev or next have the TIF_IO_BITMAP set, which
seems more optimal.

Reviews are welcome (then I will move into x86-64, all other archs
supporting seccomp should require no changes despite the API
change). Thanks.

 arch/i386/kernel/process.c     |  124 +++++++++++++++++++++--------------------
 fs/proc/base.c                 |   91 ------------------------------
 include/asm-i386/processor.h   |    4 +
 include/asm-i386/thread_info.h |    5 +
 include/linux/prctl.h          |    4 +
 include/linux/seccomp.h        |   19 +++---
 kernel/seccomp.c               |   31 +++++++++-
 kernel/sys.c                   |    8 ++
 8 files changed, 125 insertions(+), 161 deletions(-)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>

# HG changeset patch
# User andrea@cpushare.com
# Date 1152856077 -7200
# Node ID 9be99cbb325935c2a7af96ac39411fdde58d4eef
# Parent  bcfd682ea605a2ab00469eaa875988de6b910814
Removes the overhead of disabling the TSC under SECCCOMP
with a new TIF_NOTSC bitflag (idea and part of the code from Chuck Ebbert).
disable_TSC can be called by other kernel code without interfering with SECCOMP
in any way. A prctl could be added just to disable the TSC if anybody needs it.
Only the "current" task can call disable_TSC.

To reduce the bytes of .text to the minimum, the seccomp API is moved from
/proc to prctl. /proc wasn't necessary anymore because only the "current" task
can safely turn on the NOTSC bit without SMP race conditions.

diff -r bcfd682ea605 -r 9be99cbb3259 arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Thu Jul 13 03:03:35 2006 +0700
+++ b/arch/i386/kernel/process.c	Fri Jul 14 07:47:57 2006 +0200
@@ -535,8 +535,29 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
 
-static noinline void __switch_to_xtra(struct task_struct *next_p,
-				    struct tss_struct *tss)
+#ifdef CONFIG_SECCOMP
+void hard_disable_TSC(void)
+{
+	write_cr4(read_cr4() | X86_CR4_TSD);
+}
+void disable_TSC(void)
+{
+	if (!test_and_set_thread_flag(TIF_NOTSC))
+		/*
+		 * Must flip the CPU state synchronously with
+		 * TIF_NOTSC in the current running context.
+		 */
+		hard_disable_TSC();
+}
+void hard_enable_TSC(void)
+{
+	write_cr4(read_cr4() & ~X86_CR4_TSD);
+}
+#endif /* CONFIG_SECCOMP */
+
+static noinline void
+__switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
+		 struct tss_struct *tss)
 {
 	struct thread_struct *next;
 
@@ -552,60 +573,47 @@ static noinline void __switch_to_xtra(st
 		set_debugreg(next->debugreg[7], 7);
 	}
 
-	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
+#ifdef CONFIG_SECCOMP
+	if (test_tsk_thread_flag(prev_p, TIF_NOTSC) ^
+	    test_tsk_thread_flag(next_p, TIF_NOTSC)) {
+		/* prev and next are different */
+		if (test_tsk_thread_flag(next_p, TIF_NOTSC))
+			hard_disable_TSC();
+		else
+			hard_enable_TSC();
+	}
+#endif
+
+	if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP) ||
+	    test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
+		if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
+			/*
+			 * Disable the bitmap via an invalid offset. We still cache
+			 * the previous bitmap owner and the IO bitmap contents:
+			 */
+			tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
+			return;
+		}
+
+		if (likely(next == tss->io_bitmap_owner)) {
+			/*
+			 * Previous owner of the bitmap (hence the bitmap content)
+			 * matches the next task, we dont have to do anything but
+			 * to set a valid offset in the TSS:
+			 */
+			tss->io_bitmap_base = IO_BITMAP_OFFSET;
+			return;
+		}
 		/*
-		 * Disable the bitmap via an invalid offset. We still cache
-		 * the previous bitmap owner and the IO bitmap contents:
+		 * Lazy TSS's I/O bitmap copy. We set an invalid offset here
+		 * and we let the task to get a GPF in case an I/O instruction
+		 * is performed.  The handler of the GPF will verify that the
+		 * faulting task has a valid I/O bitmap and, it true, does the
+		 * real copy and restart the instruction.  This will save us
+		 * redundant copies when the currently switched task does not
+		 * perform any I/O during its timeslice.
 		 */
-		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
-		return;
-	}
-
-	if (likely(next == tss->io_bitmap_owner)) {
-		/*
-		 * Previous owner of the bitmap (hence the bitmap content)
-		 * matches the next task, we dont have to do anything but
-		 * to set a valid offset in the TSS:
-		 */
-		tss->io_bitmap_base = IO_BITMAP_OFFSET;
-		return;
-	}
-	/*
-	 * Lazy TSS's I/O bitmap copy. We set an invalid offset here
-	 * and we let the task to get a GPF in case an I/O instruction
-	 * is performed.  The handler of the GPF will verify that the
-	 * faulting task has a valid I/O bitmap and, it true, does the
-	 * real copy and restart the instruction.  This will save us
-	 * redundant copies when the currently switched task does not
-	 * perform any I/O during its timeslice.
-	 */
-	tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET_LAZY;
-}
-
-/*
- * This function selects if the context switch from prev to next
- * has to tweak the TSC disable bit in the cr4.
- */
-static inline void disable_tsc(struct task_struct *prev_p,
-			       struct task_struct *next_p)
-{
-	struct thread_info *prev, *next;
-
-	/*
-	 * gcc should eliminate the ->thread_info dereference if
-	 * has_secure_computing returns 0 at compile time (SECCOMP=n).
-	 */
-	prev = task_thread_info(prev_p);
-	next = task_thread_info(next_p);
-
-	if (has_secure_computing(prev) || has_secure_computing(next)) {
-		/* slow path here */
-		if (has_secure_computing(prev) &&
-		    !has_secure_computing(next)) {
-			write_cr4(read_cr4() & ~X86_CR4_TSD);
-		} else if (!has_secure_computing(prev) &&
-			   has_secure_computing(next))
-			write_cr4(read_cr4() | X86_CR4_TSD);
+		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET_LAZY;
 	}
 }
 
@@ -690,11 +698,9 @@ struct task_struct fastcall * __switch_t
 	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
-	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
-		__switch_to_xtra(next_p, tss);
-
-	disable_tsc(prev_p, next_p);
+	if (unlikely(task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV ||
+		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
+		__switch_to_xtra(prev_p, next_p, tss);
 
 	return prev_p;
 }
diff -r bcfd682ea605 -r 9be99cbb3259 fs/proc/base.c
--- a/fs/proc/base.c	Thu Jul 13 03:03:35 2006 +0700
+++ b/fs/proc/base.c	Fri Jul 14 07:47:57 2006 +0200
@@ -67,7 +67,6 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
-#include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
@@ -98,9 +97,6 @@ enum pid_directory_inos {
 	PROC_TGID_TASK,
 	PROC_TGID_STATUS,
 	PROC_TGID_MEM,
-#ifdef CONFIG_SECCOMP
-	PROC_TGID_SECCOMP,
-#endif
 	PROC_TGID_CWD,
 	PROC_TGID_ROOT,
 	PROC_TGID_EXE,
@@ -141,9 +137,6 @@ enum pid_directory_inos {
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
-#ifdef CONFIG_SECCOMP
-	PROC_TID_SECCOMP,
-#endif
 	PROC_TID_CWD,
 	PROC_TID_ROOT,
 	PROC_TID_EXE,
@@ -212,9 +205,6 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_NUMA_MAPS, "numa_maps", S_IFREG|S_IRUGO),
 #endif
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
-#ifdef CONFIG_SECCOMP
-	E(PROC_TGID_SECCOMP,   "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
-#endif
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
@@ -255,9 +245,6 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_NUMA_MAPS,  "numa_maps",    S_IFREG|S_IRUGO),
 #endif
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
-#ifdef CONFIG_SECCOMP
-	E(PROC_TID_SECCOMP,    "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
-#endif
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
@@ -970,78 +957,6 @@ static struct file_operations proc_login
 	.write		= proc_loginuid_write,
 };
 #endif
-
-#ifdef CONFIG_SECCOMP
-static ssize_t seccomp_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *ppos)
-{
-	struct task_struct *tsk = get_proc_task(file->f_dentry->d_inode);
-	char __buf[20];
-	loff_t __ppos = *ppos;
-	size_t len;
-
-	if (!tsk)
-		return -ESRCH;
-	/* no need to print the trailing zero, so use only len */
-	len = sprintf(__buf, "%u\n", tsk->seccomp.mode);
-	put_task_struct(tsk);
-	if (__ppos >= len)
-		return 0;
-	if (count > len - __ppos)
-		count = len - __ppos;
-	if (copy_to_user(buf, __buf + __ppos, count))
-		return -EFAULT;
-	*ppos = __ppos + count;
-	return count;
-}
-
-static ssize_t seccomp_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
-{
-	struct task_struct *tsk = get_proc_task(file->f_dentry->d_inode);
-	char __buf[20], *end;
-	unsigned int seccomp_mode;
-	ssize_t result;
-
-	result = -ESRCH;
-	if (!tsk)
-		goto out_no_task;
-
-	/* can set it only once to be even more secure */
-	result = -EPERM;
-	if (unlikely(tsk->seccomp.mode))
-		goto out;
-
-	result = -EFAULT;
-	memset(__buf, 0, sizeof(__buf));
-	count = min(count, sizeof(__buf) - 1);
-	if (copy_from_user(__buf, buf, count))
-		goto out;
-
-	seccomp_mode = simple_strtoul(__buf, &end, 0);
-	if (*end == '\n')
-		end++;
-	result = -EINVAL;
-	if (seccomp_mode && seccomp_mode <= NR_SECCOMP_MODES) {
-		tsk->seccomp.mode = seccomp_mode;
-		set_tsk_thread_flag(tsk, TIF_SECCOMP);
-	} else
-		goto out;
-	result = -EIO;
-	if (unlikely(!(end - __buf)))
-		goto out;
-	result = end - __buf;
-out:
-	put_task_struct(tsk);
-out_no_task:
-	return result;
-}
-
-static struct file_operations proc_seccomp_operations = {
-	.read		= seccomp_read,
-	.write		= seccomp_write,
-};
-#endif /* CONFIG_SECCOMP */
 
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
@@ -1726,12 +1641,6 @@ static struct dentry *proc_pident_lookup
 		case PROC_TGID_MEM:
 			inode->i_fop = &proc_mem_operations;
 			break;
-#ifdef CONFIG_SECCOMP
-		case PROC_TID_SECCOMP:
-		case PROC_TGID_SECCOMP:
-			inode->i_fop = &proc_seccomp_operations;
-			break;
-#endif /* CONFIG_SECCOMP */
 		case PROC_TID_MOUNTS:
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
diff -r bcfd682ea605 -r 9be99cbb3259 include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Thu Jul 13 03:03:35 2006 +0700
+++ b/include/asm-i386/processor.h	Fri Jul 14 07:47:57 2006 +0200
@@ -256,6 +256,10 @@ static inline void clear_in_cr4 (unsigne
 	cr4 &= ~mask;
 	write_cr4(cr4);
 }
+
+extern void hard_disable_TSC(void);
+extern void disable_TSC(void);
+extern void hard_enable_TSC(void);
 
 /*
  *      NSC/Cyrix CPU configuration register indexes
diff -r bcfd682ea605 -r 9be99cbb3259 include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Thu Jul 13 03:03:35 2006 +0700
+++ b/include/asm-i386/thread_info.h	Fri Jul 14 07:47:57 2006 +0200
@@ -142,6 +142,7 @@ static inline struct thread_info *curren
 #define TIF_MEMDIE		16
 #define TIF_DEBUG		17	/* uses debug registers */
 #define TIF_IO_BITMAP		18	/* uses I/O bitmap */
+#define TIF_NOTSC		19	/* TSC is not accessible in userland */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -153,6 +154,7 @@ static inline struct thread_info *curren
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
+#define _TIF_NOTSC		(1<<TIF_NOTSC)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
 
@@ -164,7 +166,8 @@ static inline struct thread_info *curren
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+#define _TIF_WORK_CTXSW_NEXT (_TIF_IO_BITMAP | _TIF_NOTSC | _TIF_DEBUG)
+#define _TIF_WORK_CTXSW_PREV (_TIF_IO_BITMAP | _TIF_NOTSC)
 
 /*
  * Thread-synchronous status.
diff -r bcfd682ea605 -r 9be99cbb3259 include/linux/prctl.h
--- a/include/linux/prctl.h	Thu Jul 13 03:03:35 2006 +0700
+++ b/include/linux/prctl.h	Fri Jul 14 07:47:57 2006 +0200
@@ -59,4 +59,8 @@
 # define PR_ENDIAN_LITTLE	1	/* True little endian mode */
 # define PR_ENDIAN_PPC_LITTLE	2	/* "PowerPC" pseudo little endian */
 
+/* Get/set process seccomp mode */
+#define PR_GET_SECCOMP	21
+#define PR_SET_SECCOMP	22
+
 #endif /* _LINUX_PRCTL_H */
diff -r bcfd682ea605 -r 9be99cbb3259 include/linux/seccomp.h
--- a/include/linux/seccomp.h	Thu Jul 13 03:03:35 2006 +0700
+++ b/include/linux/seccomp.h	Fri Jul 14 07:47:57 2006 +0200
@@ -3,8 +3,6 @@
 
 
 #ifdef CONFIG_SECCOMP
-
-#define NR_SECCOMP_MODES 1
 
 #include <linux/thread_info.h>
 #include <asm/seccomp.h>
@@ -18,20 +16,23 @@ static inline void secure_computing(int 
 		__secure_computing(this_syscall);
 }
 
-static inline int has_secure_computing(struct thread_info *ti)
-{
-	return unlikely(test_ti_thread_flag(ti, TIF_SECCOMP));
-}
+extern long prctl_get_seccomp(void);
+extern long prctl_set_seccomp(unsigned long);
 
 #else /* CONFIG_SECCOMP */
 
 typedef struct { } seccomp_t;
 
 #define secure_computing(x) do { } while (0)
-/* static inline to preserve typechecking */
-static inline int has_secure_computing(struct thread_info *ti)
+
+static inline long prctl_get_seccomp(void)
 {
-	return 0;
+	return -EINVAL;
+}
+
+static inline long prctl_set_seccomp(unsigned long arg2)
+{
+	return -EINVAL;
 }
 
 #endif /* CONFIG_SECCOMP */
diff -r bcfd682ea605 -r 9be99cbb3259 kernel/seccomp.c
--- a/kernel/seccomp.c	Thu Jul 13 03:03:35 2006 +0700
+++ b/kernel/seccomp.c	Fri Jul 14 07:47:57 2006 +0200
@@ -1,7 +1,7 @@
 /*
  * linux/kernel/seccomp.c
  *
- * Copyright 2004-2005  Andrea Arcangeli <andrea@cpushare.com>
+ * Copyright 2004-2006  Andrea Arcangeli <andrea@cpushare.com>
  *
  * This defines a simple but solid secure-computing mode.
  */
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 
 /* #define SECCOMP_DEBUG 1 */
+#define NR_SECCOMP_MODES 1
 
 /*
  * Secure computing mode 1 allows only read/write/exit/sigreturn.
@@ -54,3 +55,31 @@ void __secure_computing(int this_syscall
 #endif
 	do_exit(SIGKILL);
 }
+
+long prctl_get_seccomp(void)
+{
+	return current->seccomp.mode;
+}
+
+long prctl_set_seccomp(unsigned long seccomp_mode)
+{
+	long ret;
+
+	/* can set it only once to be even more secure */
+	ret = -EPERM;
+	if (unlikely(current->seccomp.mode))
+		goto out;
+
+	ret = -EINVAL;
+	if (seccomp_mode && seccomp_mode <= NR_SECCOMP_MODES) {
+		current->seccomp.mode = seccomp_mode;
+		set_thread_flag(TIF_SECCOMP);
+#ifdef TIF_NOTSC
+		disable_TSC();
+#endif
+		ret = 0;
+	}
+
+ out:
+	return ret;
+}
diff -r bcfd682ea605 -r 9be99cbb3259 kernel/sys.c
--- a/kernel/sys.c	Thu Jul 13 03:03:35 2006 +0700
+++ b/kernel/sys.c	Fri Jul 14 07:47:57 2006 +0200
@@ -28,6 +28,7 @@
 #include <linux/tty.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
+#include <linux/seccomp.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2056,6 +2057,13 @@ asmlinkage long sys_prctl(int option, un
 			error = SET_ENDIAN(current, arg2);
 			break;
 
+		case PR_GET_SECCOMP:
+			error = prctl_get_seccomp();
+			break;
+		case PR_SET_SECCOMP:
+			error = prctl_set_seccomp(arg2);
+			break;
+
 		default:
 			error = -EINVAL;
 			break;
