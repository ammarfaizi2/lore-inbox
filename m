Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758393AbWK0Qvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758393AbWK0Qvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758395AbWK0Qvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:51:49 -0500
Received: from verein.lst.de ([213.95.11.210]:61659 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1758393AbWK0Qvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:51:47 -0500
Date: Mon, 27 Nov 2006 17:51:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: utrace comments
Message-ID: <20061127165138.GA2991@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: 1.052 (*) DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,

a while ago you posted a set of patches implementing utrace, a very
promising debugging framework.  Unfortunately everything around it got
really silent and you haven't been posting updates for a long time.

Thas is rather unfortunate as beeing silent and only posting updates
on your website is definitly not the way to get things merged.
Especially not something that basically rewrites a core kernel
functionality and requires updates for every single architecture.

Is there a chance you could post regular updates again and outline
a schedule of when you plan to merge things?  I suspect we need to
stabilize things in -mm for quite a while and give all the architecture
maintainers a chance to update their port, as ripping out debugging
support for most architectures is most certainly not an option.

To get the ball rolling again I'm posting a first review below.
Note that this mostly focusses on codingstyle and general kernel
integration issues for now.  I have some ideas on more fundamental
things, but I want to understand the code a little bit better before
commenting on them.


--- linux-2.6/include/asm-i386/thread_info.h.utrace-ptrace-compat
+++ linux-2.6/include/asm-i386/thread_info.h
@@ -135,13 +135,13 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
-#define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		16
 #define TIF_DEBUG		17	/* uses debug registers */
 #define TIF_IO_BITMAP		18	/* uses I/O bitmap */
+#define TIF_FORCED_TF		19	/* true if TF in eflags artificially */

	I think it would make a lot of sense if you simply reused the
	existing flag number instead of leaving a hole.

+#define utrace_lock(utrace)	spin_lock(&(utrace)->lock)
+#define utrace_unlock(utrace)	spin_unlock(&(utrace)->lock)

	Please don't introduce such obsfucation macros.

+/***
+ *** These are the exported entry points for tracing engines to use.
+ ***/

	This is not a standard comment format.  It should be:

/*
 * These are the exported entry points for tracing engines to use.
 */

	Same comment style is in various other places that should
	be fixed up aswell.

+
+/*
+ * Attach a new tracing engine to a thread, or look up attached engines.
+ * See UTRACE_ATTACH_* flags, above.  The caller must ensure that the
+ * target thread does not get freed, i.e. hold a ref or be its parent.
+ */
+struct utrace_attached_engine *utrace_attach(struct task_struct *target,
+					     int flags,
+					     const struct utrace_engine_ops *,
+					     unsigned long data);

	Please don't put such long comments in headerfiles.  They should be
	part of the kerneldoc comments near the actual function body so
	we can extract them and autogenerate real documentation for it.
	A big thanks for the huge amount of comments, btw - they're just
	in the wrong place ;-)

--- linux-2.6/include/linux/ptrace.h.utrace-ptrace-compat
+++ linux-2.6/include/linux/ptrace.h
+#ifdef CONFIG_PTRACE
+#include <asm/tracehook.h>
+struct utrace_attached_engine;
+struct utrace_regset_view;

	Please make the include (and the forward-declarations while you're at
	it) unconditional.  That way we avoid the possiblity of come code
	compiling when CONFIG_PTRACE is set but failing if it's not set.

+#ifdef CONFIG_COMPAT
+#include <linux/compat.h>
+
+extern fastcall int arch_compat_ptrace(compat_long_t *request,
+				       struct task_struct *child,
+				       struct utrace_attached_engine *engine,
+				       compat_ulong_t a, compat_ulong_t d,
+				       compat_long_t *retval);
+#endif

...

+#ifdef CONFIG_COMPAT

 	Please try consolidate all the compat code in a single #ifdef block,
	preferably at the end of the file.

--- linux-2.6/include/linux/tracehook.h.utrace-ptrace-compat
+++ linux-2.6/include/linux/tracehook.h
@@ -0,0 +1,707 @@
+ *	void tracehook_enable_single_step(struct task_struct *tsk);
+ *	void tracehook_disable_single_step(struct task_struct *tsk);
+ *	int tracehook_single_step_enabled(struct task_struct *tsk);
+ *
+ * If those calls are defined, #define ARCH_HAS_SINGLE_STEP to nonzero.
+ * Do not #define it if these calls are never available in this kernel config.
+ * If defined, the value of ARCH_HAS_SINGLE_STEP can be constant or variable.
+ * It should evaluate to nonzero if the hardware is able to support
+ * tracehook_enable_single_step.  If it's a variable expression, it
+ * should be one that can be evaluated in modules, i.e. uses exported symbols.

	Please don't do this kind of conditional mess.  It leads to really
	ugly code like this (later in the patch):

#ifdef ARCH_HAS_SINGLE_STEP
	if (! ARCH_HAS_SINGLE_STEP)
#endif
		WARN_ON(flags & UTRACE_ACTION_SINGLESTEP);
#ifdef ARCH_HAS_BLOCK_STEP
	if (! ARCH_HAS_BLOCK_STEP)
#endif
		WARN_ON(flags & UTRACE_ACTION_BLOCKSTEP);

	Instead make it a

		arch_has_single_step()

	which must be defined by every architecture as a boolean value, with
	fixes like that the code above will become a lot more readable:

	WARN_ON(!arch_has_single_step() && (flags & UTRACE_ACTION_SINGLESTEP));
	WARN_ON(!arch_has_block_step() && (flags & UTRACE_ACTION_BLOCKSTEP));


+static inline int
+utrace_regset_copyout(unsigned int *pos, unsigned int *count,
+		      void **kbuf, void __user **ubuf,
+		      const void *data, int start_pos, int end_pos)
+{
+	if (*count == 0)
+		return 0;
+	BUG_ON(*pos < start_pos);
+	if (end_pos < 0 || *pos < end_pos) {
+		unsigned int copy = (end_pos < 0 ? *count
+				     : min(*count, end_pos - *pos));
+		data += *pos - start_pos;
+		if (*kbuf) {
+			memcpy(*kbuf, data, copy);
+			*kbuf += copy;
+		}
+		else if (copy_to_user(*ubuf, data, copy))
+			return -EFAULT;
+		else
+			*ubuf += copy;

	The coding style here is wrong.  The else should be on the line
	of the closing brace.  You're making that codingstyle mistake
	in a lot of places in this patch, please try to fix all of them
	up.

+		*pos += copy;
+		*count -= copy;
+	}
+	return 0;
+}

	This function is far too large to inline it.  Please move it out
	of line.

+static inline int
+utrace_regset_copyin(unsigned int *pos, unsigned int *count,
+		     const void **kbuf, const void __user **ubuf,
+		     void *data, int start_pos, int end_pos)
+{

	Should go out of line aswell.

+static inline int
+utrace_regset_copyout_zero(unsigned int *pos, unsigned int *count,
+			   void **kbuf, void __user **ubuf,
+			   int start_pos, int end_pos)

	Ditto.

+static inline int
+utrace_regset_copyin_ignore(unsigned int *pos, unsigned int *count,
+			    const void **kbuf, const void __user **ubuf,
+			    int start_pos, int end_pos)

+/*
+ * Called in copy_process when setting up the copied task_struct,
+ * with tasklist_lock held for writing.
+ */
+static inline void tracehook_init_task(struct task_struct *child)
+{
+#ifdef CONFIG_UTRACE
+	child->utrace_flags = 0;
+	child->utrace = NULL;
+#endif
+}

	This shows very nicely why the tracehooks vs utrace abstraction
	is utter madness.  Every tracehook 'abstraction' just conatains
	an ifdef block.  Just kill CONFIG_UTRACE as there is no point
	in making this functionality conditional an opencode the
	utrace functionality at the callers (or add a utrace_ helper
	for the few cases where it makes sense)

+static inline void tracehook_report_handle_signal(int sig,
+						  const struct k_sigaction *ka,
+						  const sigset_t *oldset,
+						  struct pt_regs *regs)
+{
+#ifdef CONFIG_UTRACE
+	struct task_struct *tsk = current;
+	if ((tsk->utrace_flags & UTRACE_EVENT_SIGNAL_ALL)
+	    && (tsk->utrace_flags & (UTRACE_ACTION_SINGLESTEP
+				     | UTRACE_ACTION_BLOCKSTEP)))
+		utrace_signal_handler_singlestep(tsk, regs);

	This doesn't follow kernel coding style at all, we always
	put the && or || operators at the end of the closing line.

	if ((tsk->utrace_flags & UTRACE_EVENT_SIGNAL_ALL) &&
	    (tsk->utrace_flags & (UTRACE_ACTION_SINGLESTEP |
	                          UTRACE_ACTION_BLOCKSTEP)))

	Also I'm not sure why you're doing this kind of test,
	as you could do a

	if (current->utrace_flags & (UTRACE_EVENT_SIGNAL_ALL|
			UTRACE_ACTION_SINGLESTEP|UTRACE_ACTION_BLOCKSTEP))

	aswell

@@ -1028,6 +1027,9 @@ static struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
+#ifdef CONFIG_PTRACE
+	INIT_LIST_HEAD(&p->ptracees);
+#endif

	This should be hidden behing a ptrace_init_task macro
	that does nothing in the !CONFIG_PTRACE case
 
--- linux-2.6/kernel/utrace.c.utrace-ptrace-compat
+++ linux-2.6/kernel/utrace.c
@@ -0,0 +1,1735 @@
+#include <linux/utrace.h>
+#include <linux/tracehook.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <asm/tracehook.h>

	Please add a block comment at the top of the file noting the
	copyright/license status author and basic desription of the
	contents.

+	if (likely(target->utrace == NULL)) {
+		rcu_assign_pointer(target->utrace, utrace);
+		/*
+		 * The task_lock protects us against another thread doing
+		 * the same thing.  We might still be racing against
+		 * tracehook_release_task.  It's called with ->exit_state
+		 * set to EXIT_DEAD and then checks ->utrace with an
+		 * smp_mb() in between.  If EXIT_DEAD is set, then
+		 * release_task might have checked ->utrace already and saw
+		 * it NULL; we can't attach.  If we see EXIT_DEAD not yet
+		 * set after our barrier, then we know release_task will
+		 * see our target->utrace pointer.
+		 */
+		smp_mb();
+		if (target->exit_state == EXIT_DEAD) {
+			/*
+			 * The target has already been through release_task.
+			 */
+			target->utrace = NULL;
+			goto cannot_attach;
+		}
+		task_unlock(target);
+
+		/*
+		 * If the thread is already dead when we attach, then its
+		 * parent was notified already and we shouldn't repeat the
+		 * notification later after a detach or NOREAP flag change.
+		 */
+		if (target->exit_state)
+			utrace->u.exit.notified = 1;
+	}
+	else {
+		/*
+		 * Another engine attached first, so there is a struct already.
+		 * A null return says to restart looking for the existing one.
+		 */
+	cannot_attach:
+		ret = NULL;
+		task_unlock(target);
+		utrace_unlock(utrace);
+		kmem_cache_free(utrace_cachep, utrace);
+	}
+
+	return ret;
+}

	This is written more than messy.  when you use gotos anyway (as
	recommended for kernel code), use it throughout to make the
	normal path be straight and the error path using gotos, e.g.:

	if (unlikely(target->utrace)) {
		/*
		 * Another engine attached first, so there is a struct already.
		 * A null return says to restart looking for the existing one.
		 */
		goto cannot_attach;
	}

	...

	return ret;
 cannot_attach:
	task_unlock(target);
	utrace_unlock(utrace);
	kmem_cache_free(utrace_cachep, utrace);
	return NULL;
}

+struct utrace_attached_engine *
+utrace_attach(struct task_struct *target, int flags,
+	     const struct utrace_engine_ops *ops, unsigned long data)

	Again, this is pretty bad goto spagetthi without much value,
	below is a slightly rewritten variant that should work the same:

struct utrace_attached_engine *
utrace_attach(struct task_struct *target, int flags,
	     const struct utrace_engine_ops *ops, unsigned long data)
{
	struct utrace_attached_engine *engine = NULL;
	struct utrace *utrace;

restart:
	rcu_read_lock();
	utrace = rcu_dereference(target->utrace);
	smp_rmb();
	if (!utrace) {
		rcu_read_unlock();

		if (!(flags & UTRACE_ATTACH_CREATE))
			return ERR_PTR(-ENOENT);

		engine = kmem_cache_alloc(utrace_engine_cachep, SLAB_KERNEL);
		if (unlikely(engine == NULL))
			return ERR_PTR(-ENOMEM);
		engine->flags = 0;
		goto first;
	}

	if (unlikely(target->exit_state == EXIT_DEAD)) {
		/*
		 * The target has already been reaped.
		 */
		rcu_read_unlock();
		return ERR_PTR(-ESRCH);
	}

	if (!(flags & UTRACE_ATTACH_CREATE)) {
		engine = matching_engine(utrace, flags, ops, data);
		rcu_read_unlock();
		return engine;
	}

	rcu_read_unlock();

	engine = kmem_cache_alloc(utrace_engine_cachep, SLAB_KERNEL);
	if (unlikely(engine == NULL))
		return ERR_PTR(-ENOMEM);
	engine->flags = ops->report_reap ? UTRACE_EVENT(REAP) : 0;

	rcu_read_lock();
	utrace = rcu_dereference(target->utrace);
	if (unlikely(!utrace)) { /* Race with detach.  */
		rcu_read_unlock();
		goto first;
	}
	utrace_lock(utrace);

	if (flags & UTRACE_ATTACH_EXCLUSIVE) {
		struct utrace_attached_engine *old;
		old = matching_engine(utrace, flags, ops, data);
		if (!IS_ERR(old)) {
			utrace_unlock(utrace);
			rcu_read_unlock();
			kmem_cache_free(utrace_engine_cachep, engine);
			return ERR_PTR(-EEXIST);
		}
	}

	if (unlikely(rcu_dereference(target->utrace) != utrace)) {
		/*
		 * We lost a race with other CPUs doing a sequence
		 * of detach and attach before we got in.
		 */
		utrace_unlock(utrace);
		rcu_read_unlock();
		kmem_cache_free(utrace_engine_cachep, engine);
		goto restart;
	}
	rcu_read_unlock();

	list_add_tail_rcu(&engine->entry, &utrace->engines);
	goto out;

 first:
	utrace = utrace_first_engine(target, engine);
	if (IS_ERR(utrace)) {
		kmem_cache_free(utrace_engine_cachep, engine);
		return ERR_PTR(PTR_ERR(utrace));
	}

	if (unlikely(!utrace)) /* Race condition.  */
		goto restart;
 out:
	engine->ops = ops;
	engine->data = data;

	utrace_unlock(utrace);
	return engine;
}

EXPORT_SYMBOL_GPL(utrace_attach);

	There is not modular user of this, so this and the other utrace_
	functions should not be exported.  Nor do I think that exporting
	such a low-level process control is nessecary a good idea, but
	we'll have to evaluate that if patches to add users show up.

+#define REPORT(callback, ...) do { \
+	u32 ret = (*rcu_dereference(engine->ops)->callback) \
+		(engine, tsk, ##__VA_ARGS__); \
+	action = update_action(tsk, utrace, engine, ret); \
+	} while (0)

	I don not think these kinds of macros are a very good idea.
	Just opencode the two lines of code instead of a single
	macro.

+// XXX copied from signal.c
+#ifdef SIGEMT
+#define M_SIGEMT	M(SIGEMT)
+#else
+#define M_SIGEMT	0
+#endif
+
+#if SIGRTMIN > BITS_PER_LONG
+#define M(sig) (1ULL << ((sig)-1))
+#else
+#define M(sig) (1UL << ((sig)-1))
+#endif
+#define T(sig, mask) (M(sig) & (mask))
+
+#define SIG_KERNEL_ONLY_MASK (\
+	M(SIGKILL)   |  M(SIGSTOP)                                   )
+
+#define SIG_KERNEL_STOP_MASK (\
+	M(SIGSTOP)   |  M(SIGTSTP)   |  M(SIGTTIN)   |  M(SIGTTOU)   )
+
+#define SIG_KERNEL_COREDUMP_MASK (\
+        M(SIGQUIT)   |  M(SIGILL)    |  M(SIGTRAP)   |  M(SIGABRT)   | \
+        M(SIGFPE)    |  M(SIGSEGV)   |  M(SIGBUS)    |  M(SIGSYS)    | \
+        M(SIGXCPU)   |  M(SIGXFSZ)   |  M_SIGEMT                     )
+
+#define SIG_KERNEL_IGNORE_MASK (\
+        M(SIGCONT)   |  M(SIGCHLD)   |  M(SIGWINCH)  |  M(SIGURG)    )
+
+#define sig_kernel_only(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_ONLY_MASK))
+#define sig_kernel_coredump(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_COREDUMP_MASK))
+#define sig_kernel_ignore(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_IGNORE_MASK))
+#define sig_kernel_stop(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))

	Copying and pasting this kind of stuff is a very bad idea.

	Just put a helper like the following into signal.c and use it from
	utrace.c:

void sigaction_to_utrace(struct k_sigaction *ka, unsigned long *action,
	unsigned long *event)
{
	if (ka->sa.sa_handler == SIG_IGN) {
		*event = UTRACE_EVENT(SIGNAL_IGN);
		*action = UTRACE_SIGNAL_IGN;
	} else if (ka->sa.sa_handler != SIG_DFL) {
	 	*event = UTRACE_EVENT(SIGNAL);
		*action = UTRACE_ACTION_RESUME;
	} else if (sig_kernel_coredump(signal.signr)) {
		*event = UTRACE_EVENT(SIGNAL_CORE);
		*action = UTRACE_SIGNAL_CORE;
	} else if (sig_kernel_ignore(signal.signr)) {
		*event = UTRACE_EVENT(SIGNAL_IGN);
		*action = UTRACE_SIGNAL_IGN;
	} else if (sig_kernel_stop(signal.signr)) {
		*event = UTRACE_EVENT(SIGNAL_STOP);
		*action = (signal.signr == SIGSTOP ?
			UTRACE_SIGNAL_STOP : UTRACE_SIGNAL_TSTP);
	} else {
		*event = UTRACE_EVENT(SIGNAL_TERM);
		*action = UTRACE_SIGNAL_TERM;
	}
}

+#ifdef CONFIG_PTRACE
+#include <linux/utrace.h>
+#include <linux/tracehook.h>
+#include <asm/tracehook.h>
+#endif

	A really huge NACK for putting #ifdef CONFIG_PTRACE into ptrace.c.
	The file should only be compile if CONFIG_PTRACE is set.
	sys_ptrace should become a cond_syscall, and ptrace_may_attach
	should move into a differnt file and get a more suitable name.
 
+int getrusage(struct task_struct *, int, struct rusage __user *);

 	Please never put prototypes like this into .c files.

+#ifdef PTRACE_DEBUG
+	printk("ptrace pid %ld => %p\n", pid, child);
+#endif

	Please don't do this kind of ifdef mess. just use pr_debug
	instead.

+const struct utrace_regset_view utrace_ppc32_view = {
+	.name = "ppc", .e_machine = EM_PPC,
+	.regsets = ppc32_regsets,
+	.n = sizeof ppc32_regsets / sizeof ppc32_regsets[0],
+};
+EXPORT_SYMBOL_GPL(utrace_ppc32_view);
+#endif

	Who would be using this from modular code?
	I see this is for all views, but I'd rather move the
	accessor out of line than exporting all them if we
	really have legitimate modular users.

