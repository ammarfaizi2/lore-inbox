Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWFMXCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWFMXCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWFMXCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:02:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9360 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751211AbWFMXCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:02:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] utrace core
In-Reply-To: Roland McGrath's message of  Tuesday, 13 June 2006 16:00:08 -0700 <20060613230008.9B564180072@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: I want the presidency so bad I can already taste the hors d'oeuvres.
Message-Id: <20060613230226.12A6B180072@magilla.sf.frob.com>
Date: Tue, 13 Jun 2006 16:02:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds the utrace facility, a new modular interface in the kernel for
implementing user thread tracing and debugging.  This fits on top of the
tracehook_* layer, so the new code is well-isolated.

The new interface is in <linux/utrace.h>, and Documentation/utrace.txt
describes it.  It allows for multiple separate tracing engines to work in
parallel without interfering with each other.  Higher-level tracing
facilities can be implemented as loadable kernel modules using this layer.

The new facility is made optional under CONFIG_UTRACE.
Normal configurations will always want to enable it.
It's optional to emphasize the clean separation of the code,
and in case some stripped-down embedded configurations might want to
omit it to save space (when ptrace and the like can never be used).

---

 Documentation/utrace.txt    |  451 +++++++++++++
 arch/x86_64/kernel/ptrace.c |   13 
 include/linux/sched.h       |    6 
 include/linux/tracehook.h   |  124 +++-
 include/linux/utrace.h      |  459 +++++++++++++
 init/Kconfig                |   17 
 kernel/Makefile             |    1 
 kernel/utrace.c             | 1475 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 2522 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/utrace.txt
 create mode 100644 include/linux/utrace.h
 create mode 100644 kernel/utrace.c

diff --git a/Documentation/utrace.txt b/Documentation/utrace.txt
new file mode 100644
index ...155d477 100644  
--- /dev/null
+++ b/Documentation/utrace.txt
@@ -0,0 +1,451 @@
+DRAFT DRAFT DRAFT	WORK IN PROGRESS	DRAFT DRAFT DRAFT
+
+This is work in progress and likely to change.
+
+
+	Roland McGrath <roland@redhat.com>
+
+---
+
+		User Debugging Data & Event Rendezvous
+		---- --------- ---- - ----- ----------
+
+See linux/utrace.h for all the declarations used here.
+See also linux/tracehook.h for the utrace_regset declarations.
+
+The UTRACE is infrastructure code for tracing and controlling user
+threads.  This is the foundation for writing tracing engines, which
+can be loadable kernel modules.  The UTRACE interfaces provide three
+basic facilities:
+
+* Thread event reporting
+
+  Tracing engines can request callbacks for events of interest in
+  the thread: signals, system calls, exit, exec, clone, etc.
+
+* Core thread control
+
+  Tracing engines can prevent a thread from running (keeping it in
+  TASK_TRACED state), or make it single-step or block-step (when
+  hardware supports it).  Engines can cause a thread to abort system
+  calls, they change the behaviors of signals, and they can inject
+  signal-style actions at will.
+
+* Thread machine state access
+
+  Tracing engines can read and write a thread's registers and
+  similar per-thread CPU state.
+
+
+	Tracing engines
+	------- -------
+
+The basic actors in UTRACE are the thread and the tracing engine.
+A tracing engine is some body of code that calls into the utrace_*
+interfaces, represented by a struct utrace_engine_ops.  (Usually it's a
+kernel module, though the legacy ptrace support is a tracing engine
+that is not in a kernel module.)  The UTRACE interface operates on
+individual threads (struct task_struct).  If an engine wants to
+treat several threads as a group, that is up to its higher-level
+code.  Using the UTRACE starts out by attaching an engine to a thread.
+
+	struct utrace_attached_engine *
+	utrace_attach(struct task_struct *target, int flags,
+		      const struct utrace_engine_ops *ops, unsigned long data);
+
+Calling utrace_attach is what sets up a tracing engine to trace a
+thread.  Use UTRACE_ATTACH_CREATE in flags, and pass your engine's ops.
+Check the return value with IS_ERR.  If successful, it returns a
+struct pointer that is the handle used in all other utrace_* calls.
+The data argument is stored in the utrace_attached_engine structure,
+for your code to use however it wants.
+
+	void utrace_detach(struct task_struct *target,
+			   struct utrace_attached_engine *engine);
+
+The utrace_detach call removes an engine from a thread.
+No more callbacks will be made after this returns.
+
+
+An attached engine does nothing by default.
+An engine makes something happen by setting its flags.
+
+	void utrace_set_flags(struct task_struct *target,
+			      struct utrace_attached_engine *engine,
+			      unsigned long flags);
+
+
+	Action Flags
+	------ -----
+
+There are two kinds of flags that an attached engine can set: event
+flags, and action flags.  Event flags register interest in particular
+events; when an event happens and an engine has the right event flag
+set, it gets a callback.  Action flags change the normal behavior of
+the thread.  The action flags available are:
+
+	UTRACE_ACTION_QUIESCE
+
+		The thread will stay quiescent (see below).
+		As long as any engine asserts the QUIESCE action flag,
+		the thread will not resume running in user mode.
+		(Usually it will be in TASK_TRACED state.)
+		Nothing will wake the thread up except for SIGKILL
+		(and implicit SIGKILLs such as a core dump in
+		another thread sharing the same address space, or a
+		group exit or fatal signal in another thread in the
+		same thread group).
+
+	UTRACE_ACTION_SINGLESTEP
+
+		When the thread runs, it will run one instruction
+		and then trap.  (Exiting a system call or entering a
+		signal handler is considered "an instruction" for this.)
+
+	UTRACE_ACTION_BLOCKSTEP
+
+		When the thread runs, it will run until the next branch,
+		and then trap.  (Exiting a system call or entering a
+		signal handler is considered a branch for this.)
+		When the SINGLESTEP flag is set, BLOCKSTEP has no effect.
+		This is only available on some machines (actually none yet).
+
+	UTRACE_ACTION_NOREAP
+
+		When the thread exits or stops for job control, its
+		parent process will not receive a SIGCHLD and the
+		parent's wait calls will not wake up or report the
+		child as dead.  A well-behaved tracing engine does not
+		want to interfere with the parent's normal notifications.
+		This is provided mainly for the ptrace compatibility
+		code to implement the traditional behavior.
+
+Event flags are specified using the macro UTRACE_EVENT(TYPE).
+Each event type is associated with a report_* callback in struct
+utrace_engine_ops.  A tracing engine can leave unused callbacks NULL.
+The only callbacks required are those used by the event flags it sets.
+
+Many engines can be attached to each thread.  When a thread has an
+event, each engine gets a report_* callback if it has set the event flag
+for that event type.  Engines are called in the order they attached.
+
+Each callback takes arguments giving the details of the particular
+event.  The first two arguments two every callback are the struct
+utrace_attached_engine and struct task_struct pointers for the engine
+and the thread producing the event.  Usually this will be the current
+thread that is running the callback functions.
+
+The return value of report_* callbacks is a bitmask.  Some bits are
+common to all callbacks, and some are particular to that callback and
+event type.  The value zero (UTRACE_ACTION_RESUME) always means the
+simplest thing: do what would have happened with no tracing engine here.
+These are the flags that can be set in any report_* return value:
+
+	UTRACE_ACTION_NEWSTATE
+
+		Update the action state flags, described above.  Those
+		bits from the return value (UTRACE_ACTION_STATE_MASK)
+		replace those bits in the engine's flags.  This has the
+		same effect as calling utrace_set_flags, but is a more
+		efficient short-cut.  To change the event flags, you must
+		call utrace_set_flags.
+
+	UTRACE_ACTION_DETACH
+
+		Detach this engine.  This has the effect of calling
+		utrace_detach, but is a more efficient short-cut.
+
+	UTRACE_ACTION_HIDE
+
+		Hide this event from other tracing engines.  This is
+		only appropriate to do when the event was induced by
+		some action of this engine, such as a breakpoint trap.
+		Some events cannot be hidden, since every engine has to
+		know about them: exit, death, reap.
+
+The return value bits in UTRACE_ACTION_OP_MASK indicate a change to the
+normal behavior of the event taking place.  If zero, the thread does
+whatever that event normally means.  For report_signal, other values
+control the disposition of the signal.
+
+
+	Quiescence
+	----------
+
+To control another thread and access its state, it must be "quiescent".
+This means that it is stopped and won't start running again while we access
+it.  A quiescent thread is stopped in a place close to user mode, where the
+user state can be accessed safely; either it's about to return to user
+mode, or it's just entered the kernel from user mode, or it has already
+finished exiting (TASK_ZOMBIE).  Setting the UTRACE_ACTION_QUIESCE action
+flag will force the attached thread to become quiescent soon.  After
+setting the flag, an engine must wait for an event callback when the thread
+becomes quiescent.  The thread may be running on another CPU, or may be in
+an uninterruptible wait.  When it is ready to be examined, it will make
+callbacks to engines that set the UTRACE_EVENT(QUIESCE) event flag.
+
+As long as some engine has UTRACE_ACTION_QUIESCE set, then the thread will
+remain stopped.  SIGKILL will wake it up, but it will not run user code.
+When the flag is cleared via utrace_set_flags or a callback return value,
+the thread starts running again.
+
+During the event callbacks (report_*), the thread in question makes the
+callback from a safe place.  It is not quiescent, but it can safely access
+its own state.  Callbacks can access thread state directly without setting
+the QUIESCE action flag.  If a callback does want to prevent the thread
+from resuming normal execution, it *must* use the QUIESCE action state
+rather than simply blocking; see "Core Events & Callbacks", below.
+
+
+	Thread control
+	------ -------
+
+These calls must be made on a quiescent thread (or the current thread):
+
+	int utrace_inject_signal(struct task_struct *target,
+				 struct utrace_attached_engine *engine,
+				 u32 action, siginfo_t *info,
+				 const struct k_sigaction *ka);
+
+Cause a specified signal delivery in the target thread.  This is not
+like kill, which generates a signal to be dequeued and delivered later.
+Injection directs the thread to deliver a signal now, before it next
+resumes in user mode or dequeues any other pending signal.  It's as if
+the tracing engine intercepted a signal event and its report_signal
+callback returned the action argument as its value (see below).  The
+info and ka arguments serve the same purposes as their counterparts in
+a report_signal callback.
+
+	const struct utrace_regset *
+	utrace_regset(struct task_struct *target,
+		      struct utrace_attached_engine *engine,
+		      const struct utrace_regset_view *view,
+		      int which);
+
+Get access to machine state for the thread.  The struct utrace_regset_view
+indicates a view of machine state, corresponding to a user mode
+architecture personality (such as 32-bit or 64-bit versions of a machine).
+The which argument selects one of the register sets available in that view.
+The utrace_regset call must be made before accessing any machine state,
+each time the thread has been running and has then become quiescent.
+It ensures that the thread's state is ready to be accessed, and returns
+the struct utrace_regset giving its accessor functions.
+
+XXX needs front ends for argument checks, export utrace_native_view
+
+
+	Core Events & Callbacks
+	---- ------ - ---------
+
+Event reporting callbacks have details particular to the event type, but
+are all called in similar environments and have the same constraints.
+Callbacks are made from safe spots, where no locks are held, no special
+resources are pinned, and the user-mode state of the thread is accessible.
+So, callback code has a pretty free hand.  But to be a good citizen,
+callback code should never block for long periods.  It is fine to block in
+kmalloc and the like, but never wait for i/o or for user mode to do
+something.  If you need the thread to wait, set UTRACE_ACTION_QUIESCE and
+return from the callback quickly.  When your i/o finishes or whatever, you
+can use utrace_set_flags to resume the thread.
+
+Well-behaved callbacks are important to maintain two essential properties
+of the interface.  The first of these is that unrelated tracing engines not
+interfere with each other.  If your engine's event callback does not return
+quickly, then another engine won't get the event notification in a timely
+manner.  The second important property is that tracing be as noninvasive as
+possible to the normal operation of the system overall and of the traced
+thread in particular.  That is, attached tracing engines should not perturb
+a thread's behavior, except to the extent that changing its user-visible
+state is explicitly what you want to do.  (Obviously some perturbation is
+unavoidable, primarily timing changes, ranging from small delays due to the
+overhead of tracing, to arbitrary pauses in user code execution when a user
+stops a thread with a debugger for examination.  When doing asynchronous
+utrace_attach to a thread doing a system call, more troublesome side
+effects are possible.)  Even when you explicitly want the pertrubation of
+making the traced thread block, just blocking directly in your callback has
+more unwanted effects.  For example, the CLONE event callbacks are called
+when the new child thread has been created but not yet started running; the
+child can never be scheduled until the CLONE tracing callbacks return.
+(This allows engines tracing the parent to attach to the child.)  If a
+CLONE event callback blocks the parent thread, it also prevents the child
+thread from running (even to process a SIGKILL).  If what you want is to
+make both the parent and child block, then use utrace_attach on the child
+and then set the QUIESCE action state flag on both threads.  A more crucial
+problem with blocking in callbacks is that it can prevent SIGKILL from
+working.  A thread that is blocking due to UTRACE_ACTION_QUIESCE will still
+wake up and die immediately when sent a SIGKILL, as all threads should.
+Relying on the utrace infrastructure rather than on private synchronization
+calls in event callbacks is an important way to help keep tracing robustly
+noninvasive.
+
+
+EVENT(REAP)		Dead thread has been reaped
+Callback:
+	void (*report_reap)(struct utrace_attached_engine *engine,
+			    struct task_struct *tsk);
+
+This means the parent called wait, or else this was a detached thread or
+a process whose parent ignores SIGCHLD.  This cannot happen while the
+UTRACE_ACTION_NOREAP flag is set.  This is the only callback you are
+guaranteed to get (if you set the flag).
+
+Unlike other callbacks, this can be called from the parent's context
+rather than from the traced thread itself--it must not delay the parent by
+blocking.  This callback is different from all others, it returns void.
+Once you get this callback, your engine is automatically detached and you
+cannot access this thread or use this struct utrace_attached_engine handle
+any longer.  This is the place to clean up your data structures and
+synchronize with your code that might try to make utrace_* calls using this
+engine data structure.  The struct is still valid during this callback,
+but will be freed soon after it returns (via RCU).
+
+In all other callbacks, the return value is as described above.
+The common UTRACE_ACTION_* flags in the return value are always observed.
+Unless otherwise specified below, other bits in the return value are ignored.
+
+
+EVENT(QUIESCE)		Thread is quiescent
+Callback:
+	u32 (*report_quiesce)(struct utrace_attached_engine *engine,
+			      struct task_struct *tsk);
+
+This is the least interesting callback.  It happens at any safe spot,
+including after any other event callback.  This lets the tracing engine
+know that it is safe to access the thread's state, or to report to users
+that it has stopped running user code.
+
+EVENT(CLONE)		Thread is creating a child
+Callback:
+	u32 (*report_clone)(struct utrace_attached_engine *engine,
+			    struct task_struct *parent,
+			    unsigned long clone_flags,
+			    struct task_struct *child);
+
+A clone/clone2/fork/vfork system call has succeeded in creating a new
+thread or child process.  The new process is fully formed, but not yet
+running.  During this callback, other tracing engines are prevented from
+using utrace_attach asynchronously on the child, so that engines tracing
+the parent get the first opportunity to attach.  After this callback
+returns, the child will start and the parent's system call will return.
+If CLONE_VFORK is set, the parent will block before returning.
+
+EVENT(VFORK_DONE)	Finished waiting for CLONE_VFORK child
+Callback:
+	u32 (*report_vfork_done)(struct utrace_attached_engine *engine,
+				 struct task_struct *parent,
+				 struct task_struct *child);
+
+Event reported for parent using CLONE_VFORK or vfork system call.
+The child has died or exec'd, so the vfork parent has unblocked
+and is about to return child->pid.
+
+UTRACE_EVENT(EXEC)		Completed exec
+Callback:
+	u32 (*report_exec)(struct utrace_attached_engine *engine,
+			   struct task_struct *tsk,
+			   const struct linux_binprm *bprm,
+			   struct pt_regs *regs);
+
+An execve system call has succeeded and the new program is about to
+start running.  The initial user register state is handy to be tweaked
+directly, or utrace_regset can be used for full machine state access.
+
+UTRACE_EVENT(EXIT)		Thread is exiting
+Callback:
+	u32 (*report_exit)(struct utrace_attached_engine *engine,
+			   struct task_struct *tsk,
+			   long orig_code, long *code);
+
+The thread is exiting and cannot be prevented from doing so, but all its
+state is still live.  The *code value will be the wait result seen by
+the parent, and can be changed by this engine or others.  The orig_code
+value is the real status, not changed by any tracing engine.
+
+UTRACE_EVENT(DEATH)		Thread has finished exiting
+Callback:
+	u32 (*report_death)(struct utrace_attached_engine *engine,
+			    struct task_struct *tsk);
+
+The thread is really dead now.  If the UTRACE_ACTION_NOREAP flag is set
+after this callback, it remains an unreported zombie.  Otherwise, it
+might be reaped by its parent, or self-reap immediately.
+
+
+UTRACE_EVENT(SYSCALL_ENTRY)	Thread has entered kernel for a system call
+Callback:
+	u32 (*report_syscall_entry)(struct utrace_attached_engine *engine,
+				    struct task_struct *tsk,
+				    struct pt_regs *regs);
+
+The system call number and arguments can be seen and modified in the
+registers.  The return value register has -ENOSYS, which will be
+returned for an invalid system call.  The macro tracehook_abort_syscall(regs)
+will abort the system call so that we go immediately to syscall exit,
+and return -ENOSYS (or whatever the register state is changed to).  If
+tracing enginges keep the thread quiescent here, the system call will
+not be performed until it resumes.
+
+UTRACE_EVENT(SYSCALL_EXIT)	Thread is leaving kernel after a system call
+Callback:
+	u32 (*report_syscall_exit)(struct utrace_attached_engine *engine,
+				   struct task_struct *tsk,
+				   struct pt_regs *regs);
+
+The return value can be seen and modified in the registers.  If the
+thread is allowed to resume, it will see any pending signals and then
+return to user mode.
+
+UTRACE_EVENT(SIGNAL)		Signal caught by user handler
+UTRACE_EVENT(SIGNAL_IGN)		Signal with no effect (SIG_IGN or default)
+UTRACE_EVENT(SIGNAL_STOP)	Job control stop signal
+UTRACE_EVENT(SIGNAL_TERM)	Fatal termination signal
+UTRACE_EVENT(SIGNAL_CORE)	Fatal core-dump signal
+UTRACE_EVENT_SIGNAL_ALL		All of the above (bitmask)
+Callback:
+	u32 (*report_signal)(struct utrace_attached_engine *engine,
+			     struct task_struct *tsk,
+			     u32 action, siginfo_t *info,
+			     const struct k_sigaction *orig_ka,
+			     struct k_sigaction *return_ka);
+
+There are five types of signal events, but all use the same callback.
+These happen when a thread is dequeuing a signal to be delivered.
+(Not immediately when the signal is sent, and not when the signal is
+blocked.)  No signal event is reported for SIGKILL; no tracing engine
+can prevent it from killing the thread immediately.  The specific
+event types allow an engine to trace signals based on what they do.
+UTRACE_EVENT_SIGNAL_ALL is all of them OR'd together, to trace all
+signals (except SIGKILL).  A subset of these event flags can be used
+e.g. to catch only fatal signals, not handled ones, or to catch only
+core-dump signals, not normal termination signals.
+
+The action argument says what the signal's default disposition is:
+
+	UTRACE_SIGNAL_DELIVER	Run the user handler from sigaction.
+	UTRACE_SIGNAL_IGN	Do nothing, ignore the signal.
+	UTRACE_SIGNAL_TERM	Terminate the process.
+	UTRACE_SIGNAL_CORE	Terminate the process a write a core dump.
+	UTRACE_SIGNAL_STOP	Absolutely stop the process, a la SIGSTOP.
+	UTRACE_SIGNAL_TSTP	Job control stop (no stop if orphaned).
+
+This selection is made from consulting the process's sigaction and the
+default action for the signal number, but may already have been
+changed by an earlier tracing engine (in which case you see its override).
+A return value of UTRACE_ACTION_RESUME means to carry out this action.
+If instead UTRACE_SIGNAL_* bits are in the return value, that overrides
+the normal behavior of the signal.
+
+The signal number and other details of the signal are in info, and
+this data can be changed to make the thread see a different signal.
+A return value of UTRACE_SIGNAL_DELIVER says to follow the sigaction in
+return_ka, which can specify a user handler or SIG_IGN to ignore the
+signal or SIG_DFL to follow the default action for info->si_signo.
+The orig_ka parameter shows the process's sigaction at the time the
+signal was dequeued, and return_ka initially contains this.  Tracing
+engines can modify return_ka to change the effects of delivery.
+For other UTRACE_SIGNAL_* return values, return_ka is ignored.
+
+UTRACE_SIGNAL_HOLD is a flag bit that can be OR'd into the return
+value.  It says to push the signal back on the thread's queue, with
+the signal number and details possibly changed in info.  When the
+thread is allowed to resume, it will dequeue and report it again.
diff --git a/arch/x86_64/kernel/ptrace.c b/arch/x86_64/kernel/ptrace.c
index 28de290..71f716d 100644  
--- a/arch/x86_64/kernel/ptrace.c
+++ b/arch/x86_64/kernel/ptrace.c
@@ -702,19 +702,6 @@ const struct utrace_regset_view utrace_x
 EXPORT_SYMBOL_GPL(utrace_x86_64_native);
 
 
-static void syscall_trace(struct pt_regs *regs)
-{
-
-#if 0
-	printk("trace %s rip %lx rsp %lx rax %d origrax %d caller %lx tiflags %x ptrace %x\n",
-	       current->comm,
-	       regs->rip, regs->rsp, regs->rax, regs->orig_rax, __builtin_return_address(0),
-	       current_thread_info()->flags, current->ptrace);
-#endif
-
-	tracehook_report_syscall(regs, 1);
-}
-
 asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 {
 	/* do the secure computing check first */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7894f20..b5ae996 100644  
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -811,6 +811,11 @@ struct task_struct {
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
 
+#ifdef CONFIG_UTRACE
+	struct utrace *utrace;
+	unsigned long utrace_flags;
+#endif
+
 /* Thread group tracking */
    	u32 parent_exec_id;
    	u32 self_exec_id;
@@ -917,6 +922,7 @@ static inline void put_task_struct(struc
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
+#define	PF_REAPED	0x02000000	/* release_task started */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 3262640..d0077b3 100644  
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -34,11 +34,12 @@ struct pt_regs;
  *	void tracehook_disable_single_step(struct task_struct *tsk);
  *	int tracehook_single_step_enabled(struct task_struct *tsk);
  *
- * Block-step control (trap on control transfer), when available.
- * If these are available, asm/tracehook.h does #define HAVE_ARCH_BLOCK_STEP.
- * tracehook_disable_block_step will be called after tracehook_enable_single_step.
- * When enabled, the next jump, or other control transfer or syscall exit,
- * produces a SIGTRAP.  Enabling or disabling redundantly is harmless.
+ * Block-step control (trap on control transfer), when available.  If these
+ * are available, asm/tracehook.h does #define HAVE_ARCH_BLOCK_STEP.
+ * tracehook_disable_block_step will be called after
+ * tracehook_enable_single_step.  When enabled, the next jump, or other
+ * control transfer or syscall exit, produces a SIGTRAP.  Enabling or
+ * disabling redundantly is harmless.
  *
  *	void tracehook_enable_block_step(struct task_struct *tsk);
  *	void tracehook_disable_block_step(struct task_struct *tsk);
@@ -167,12 +168,20 @@ struct ptrace_uarea_segment {
  ***
  ***/
 
+#ifdef CONFIG_UTRACE
+#include <linux/utrace.h>
+#endif
+
 /*
  * Return the value to display after "TracerPid:" in /proc/PID/status.
  * Called without locks.
  */
 static inline pid_t tracehook_tracer_pid(struct task_struct *p)
 {
+#ifdef CONFIG_UTRACE
+	if (p->utrace_flags)
+		return utrace_tracer_pid(p);
+#endif
 	return 0;
 }
 
@@ -182,6 +191,10 @@ static inline pid_t tracehook_tracer_pid
  */
 static inline void tracehook_init_task(struct task_struct *child)
 {
+#ifdef CONFIG_UTRACE
+	child->utrace_flags = 0;
+	child->utrace = NULL;
+#endif
 }
 
 /*
@@ -190,6 +203,12 @@ static inline void tracehook_init_task(s
  */
 static inline void tracehook_release_task(struct task_struct *p)
 {
+#ifdef CONFIG_UTRACE
+	p->flags |= PF_REAPED;
+	smp_mb();
+	if (p->utrace != NULL)
+		utrace_release_task(p);
+#endif
 }
 
 /*
@@ -200,6 +219,9 @@ static inline void tracehook_release_tas
  */
 static inline int tracehook_check_released(struct task_struct *p)
 {
+#ifdef CONFIG_UTRACE
+	return unlikely(p->utrace != NULL);
+#endif
 	return 0;
 }
 
@@ -211,6 +233,10 @@ static inline int tracehook_check_releas
 static inline int tracehook_notify_cldstop(struct task_struct *tsk,
 					   const siginfo_t *info)
 {
+#ifdef CONFIG_UTRACE
+	if (tsk->utrace_flags & UTRACE_ACTION_NOREAP)
+		return 1;
+#endif
 	return 0;
 }
 
@@ -223,6 +249,12 @@ static inline int tracehook_notify_cldst
  */
 static inline int tracehook_notify_death(struct task_struct *tsk, int *noreap)
 {
+#ifdef CONFIG_UTRACE
+	if (tsk->utrace_flags & UTRACE_ACTION_NOREAP) {
+		*noreap = 1;
+		return 1;
+	}
+#endif
 	*noreap = 0;
 	return 0;
 }
@@ -235,6 +267,10 @@ static inline int tracehook_notify_death
 static inline int tracehook_consider_fatal_signal(struct task_struct *tsk,
 						  int sig)
 {
+#ifdef CONFIG_UTRACE
+	return (tsk->utrace_flags & (UTRACE_EVENT(SIGNAL_TERM)
+				     | UTRACE_EVENT(SIGNAL_CORE)));
+#endif
 	return 0;
 }
 
@@ -247,6 +283,9 @@ static inline int tracehook_consider_fat
 static inline int tracehook_consider_ignored_signal(struct task_struct *tsk,
 						    int sig, void *handler)
 {
+#ifdef CONFIG_UTRACE
+	return (tsk->utrace_flags & UTRACE_EVENT(SIGNAL_IGN));
+#endif
 	return 0;
 }
 
@@ -258,6 +297,9 @@ static inline int tracehook_consider_ign
  */
 static inline int tracehook_induce_sigpending(struct task_struct *tsk)
 {
+#ifdef CONFIG_UTRACE
+	return unlikely(tsk->utrace_flags & UTRACE_ACTION_QUIESCE);
+#endif
 	return 0;
 }
 
@@ -273,6 +315,10 @@ static inline int tracehook_get_signal(s
 				       siginfo_t *info,
 				       struct k_sigaction *return_ka)
 {
+#ifdef CONFIG_UTRACE
+	if (unlikely(tsk->utrace_flags))
+		return utrace_get_signal(tsk, regs, info, return_ka);
+#endif
 	return 0;
 }
 
@@ -285,6 +331,11 @@ static inline int tracehook_get_signal(s
  */
 static inline int tracehook_finish_stop(int last_one)
 {
+#ifdef CONFIG_UTRACE
+	if (current->utrace_flags & UTRACE_EVENT(JCTL))
+		return utrace_report_jctl(CLD_STOPPED);
+#endif
+
 	return 0;
 }
 
@@ -306,6 +357,9 @@ static inline int tracehook_stop_now(voi
  */
 static inline int tracehook_inhibit_wait_stopped(struct task_struct *child)
 {
+#ifdef CONFIG_UTRACE
+	return (child->utrace_flags & UTRACE_ACTION_NOREAP);
+#endif
 	return 0;
 }
 
@@ -316,6 +370,9 @@ static inline int tracehook_inhibit_wait
  */
 static inline int tracehook_inhibit_wait_zombie(struct task_struct *child)
 {
+#ifdef CONFIG_UTRACE
+	return (child->utrace_flags & UTRACE_ACTION_NOREAP);
+#endif
 	return 0;
 }
 
@@ -326,6 +383,9 @@ static inline int tracehook_inhibit_wait
  */
 static inline int tracehook_inhibit_wait_continued(struct task_struct *child)
 {
+#ifdef CONFIG_UTRACE
+	return (child->utrace_flags & UTRACE_ACTION_NOREAP);
+#endif
 	return 0;
 }
 
@@ -363,6 +423,10 @@ static inline int tracehook_allow_access
 {
 	if (tsk == current)
 		return 1;
+#ifdef CONFIG_UTRACE
+	if (tsk->utrace_flags)
+		return utrace_allow_access_process_vm(tsk);
+#endif
 	return 0;
 }
 
@@ -383,14 +447,23 @@ static inline int tracehook_allow_access
  */
 static inline void tracehook_report_death(struct task_struct *tsk)
 {
+#ifdef CONFIG_UTRACE
+	if (tsk->utrace_flags & (UTRACE_EVENT(DEATH) | UTRACE_ACTION_QUIESCE))
+		utrace_report_death(tsk);
+#endif
 }
 
 /*
- * exec completed
+ * exec completed, we are shortly going to return to user mode.
+ * The freshly initialized register state can be seen and changed here.
  */
 static inline void tracehook_report_exec(struct linux_binprm *bprm,
 				    struct pt_regs *regs)
 {
+#ifdef CONFIG_UTRACE
+	if (current->utrace_flags & UTRACE_EVENT(EXEC))
+		utrace_report_exec(bprm, regs);
+#endif
 }
 
 /*
@@ -399,6 +472,10 @@ static inline void tracehook_report_exec
  */
 static inline void tracehook_report_exit(long *exit_code)
 {
+#ifdef CONFIG_UTRACE
+	if (current->utrace_flags & UTRACE_EVENT(EXIT))
+		utrace_report_exit(exit_code);
+#endif
 }
 
 /*
@@ -413,19 +490,28 @@ static inline void tracehook_report_exit
 static inline void tracehook_report_clone(unsigned long clone_flags,
 					  struct task_struct *child)
 {
+#ifdef CONFIG_UTRACE
+	if (current->utrace_flags & UTRACE_EVENT(CLONE))
+		utrace_report_clone(clone_flags, child);
+#endif
 }
 
 /*
- * Called after the child has started running, shortly after tracehook_report_clone.
- * This is just before the clone/fork syscall returns, or blocks for vfork
- * child completion if (clone_flags & CLONE_VFORK).
- * The child pointer may be invalid if a self-reaping child died and
- * tracehook_report_clone took no action to prevent it from self-reaping.
+ * Called after the child has started running, shortly after
+ * tracehook_report_clone.  This is just before the clone/fork syscall
+ * returns, or blocks for vfork child completion if (clone_flags &
+ * CLONE_VFORK).  The child pointer may be invalid if a self-reaping
+ * child died and tracehook_report_clone took no action to prevent it
+ * from self-reaping.
  */
 static inline void tracehook_report_clone_complete(unsigned long clone_flags,
 						   pid_t pid,
 						   struct task_struct *child)
 {
+#ifdef CONFIG_UTRACE
+	if (current->utrace_flags & UTRACE_ACTION_QUIESCE)
+		utrace_quiescent(current);
+#endif
 }
 
 /*
@@ -434,6 +520,10 @@ static inline void tracehook_report_clon
  */
 static inline void tracehook_report_vfork_done(struct task_struct *child)
 {
+#ifdef CONFIG_UTRACE
+	if (current->utrace_flags & UTRACE_EVENT(VFORK_DONE))
+		utrace_report_vfork_done(child);
+#endif
 }
 
 /*
@@ -441,6 +531,11 @@ static inline void tracehook_report_vfor
  */
 static inline void tracehook_report_syscall(struct pt_regs *regs, int is_exit)
 {
+#ifdef CONFIG_UTRACE
+	if (current->utrace_flags & (is_exit ? UTRACE_EVENT(SYSCALL_EXIT)
+				     : UTRACE_EVENT(SYSCALL_ENTRY)))
+		utrace_report_syscall(regs, is_exit);
+#endif
 }
 
 /*
@@ -460,6 +555,13 @@ static inline void tracehook_report_hand
 						  const sigset_t *oldset,
 						  struct pt_regs *regs)
 {
+#ifdef CONFIG_UTRACE
+	struct task_struct *tsk = current;
+	if ((tsk->utrace_flags & UTRACE_EVENT_SIGNAL_ALL)
+	    && (tsk->utrace_flags & (UTRACE_ACTION_SINGLESTEP
+				     | UTRACE_ACTION_BLOCKSTEP)))
+		utrace_signal_handler_singlestep(tsk, regs);
+#endif
 }
 
 
diff --git a/include/linux/utrace.h b/include/linux/utrace.h
new file mode 100644
index ...6575c8a 100644  
--- /dev/null
+++ b/include/linux/utrace.h
@@ -0,0 +1,459 @@
+/*
+ * User Debugging Data & Event Rendezvous
+ *
+ * This interface allows for notification of interesting events in a thread.
+ * It also mediates access to thread state such as registers.
+ * Multiple unrelated users can be associated with a single thread.
+ * We call each of these a tracing engine.
+ *
+ * A tracing engine starts by calling utrace_attach on the chosen thread,
+ * passing in a set of hooks (struct utrace_engine_ops), and some associated
+ * data.  This produces a struct utrace_attached_engine, which is the handle
+ * used for all other operations.  An attached engine has its ops vector,
+ * its data, and a flags word controlled by utrace_set_flags.
+ *
+ * Each engine's flags word contains two kinds of flags: events of
+ * interest, and action state flags.
+ *
+ * For each event flag that is set, that engine will get the
+ * appropriate ops->report_* callback when the event occurs.  The
+ * struct utrace_engine_ops need not provide callbacks for an event
+ * unless the engine sets one of the associated event flags.
+ *
+ * Action state flags change the normal behavior of the thread.
+ * These bits are in UTRACE_ACTION_STATE_MASK; these can be OR'd into
+ * flags set with utrace_set_flags.  Also, every callback that return
+ * an action value can reset these bits for the engine (see below).
+ *
+ * The bits UTRACE_ACTION_STATE_MASK of all attached engines are OR'd
+ * together, so each action is in force as long as any engine requests it.
+ * As long as some engine sets the UTRACE_ACTION_QUIESCE flag, the thread
+ * will block and not resume running user code.  When the last engine
+ * clears its UTRACE_ACTION_QUIESCE flag, the thread will resume running.
+ */
+
+#ifndef _LINUX_UTRACE_H
+#define _LINUX_UTRACE_H	1
+
+#include <linux/list.h>
+#include <linux/rcupdate.h>
+#include <linux/signal.h>
+
+struct linux_binprm;
+struct pt_regs;
+struct utrace_regset;
+struct utrace_regset_view;
+
+
+/*
+ * Flags in task_struct.utrace_flags and utrace_attached_engine.flags.
+ * Low four bits are UTRACE_ACTION_STATE_MASK bits (below).
+ * Higher bits are events of interest.
+ */
+
+#define UTRACE_FIRST_EVENT	4
+#define UTRACE_EVENT_BITS	(BITS_PER_LONG - UTRACE_FIRST_EVENT)
+#define UTRACE_EVENT_MASK	(-1UL &~ UTRACE_ACTION_STATE_MASK)
+
+enum utrace_events {
+	_UTRACE_EVENT_QUIESCE,	/* Tracing requests stop.  */
+	_UTRACE_EVENT_REAP,  	/* Zombie reaped, no more tracing possible.  */
+	_UTRACE_EVENT_CLONE,	/* Successful clone/fork/vfork just done.  */
+	_UTRACE_EVENT_VFORK_DONE, /* vfork woke from waiting for child.  */
+	_UTRACE_EVENT_EXEC,	/* Successful execve just completed.  */
+	_UTRACE_EVENT_EXIT,	/* Thread exit in progress.  */
+	_UTRACE_EVENT_DEATH,	/* Thread has died.  */
+	_UTRACE_EVENT_SYSCALL_ENTRY, /* User entered kernel for system call. */
+	_UTRACE_EVENT_SYSCALL_EXIT, /* Returning to user after system call.  */
+	_UTRACE_EVENT_SIGNAL,	/* Signal delivery will run a user handler.  */
+	_UTRACE_EVENT_SIGNAL_IGN, /* No-op signal to be delivered.  */
+	_UTRACE_EVENT_SIGNAL_STOP, /* Signal delivery will suspend.  */
+	_UTRACE_EVENT_SIGNAL_TERM, /* Signal delivery will terminate.  */
+	_UTRACE_EVENT_SIGNAL_CORE, /* Signal delivery will dump core.  */
+	_UTRACE_EVENT_JCTL,	/* Job control stop or continue completed.  */
+	_UTRACE_NEVENTS
+};
+#define UTRACE_EVENT_BIT(type)	(UTRACE_FIRST_EVENT + _UTRACE_EVENT_##type)
+#define UTRACE_EVENT(type)	(1UL << UTRACE_EVENT_BIT(type))
+
+/*
+ * All the kinds of signal events.  These all use the report_signal callback.
+ */
+#define UTRACE_EVENT_SIGNAL_ALL	(UTRACE_EVENT(SIGNAL) \
+				 | UTRACE_EVENT(SIGNAL_IGN) \
+				 | UTRACE_EVENT(SIGNAL_STOP) \
+				 | UTRACE_EVENT(SIGNAL_TERM) \
+				 | UTRACE_EVENT(SIGNAL_CORE))
+/*
+ * Both kinds of syscall events; these call the report_syscall_entry and
+ * report_syscall_exit callbacks, respectively.
+ */
+#define UTRACE_EVENT_SYSCALL	\
+	(UTRACE_EVENT(SYSCALL_ENTRY) | UTRACE_EVENT(SYSCALL_EXIT))
+
+
+/*
+ * Action flags, in return value of callbacks.
+ *
+ * UTRACE_ACTION_RESUME (zero) is the return value to do nothing special.
+ * For each particular callback, some bits in UTRACE_ACTION_OP_MASK can
+ * be set in the return value to change the thread's behavior (see below).
+ *
+ * If UTRACE_ACTION_NEWSTATE is set, then the UTRACE_ACTION_STATE_MASK
+ * bits in the return value replace the engine's flags as in utrace_set_flags
+ * (but the event flags remained unchanged).
+ *
+ * If UTRACE_ACTION_HIDE is set, then the callbacks to other engines
+ * should be suppressed for this event.  This is appropriate only when
+ * the event was artificially provoked by something this engine did,
+ * such as setting a breakpoint.
+ *
+ * If UTRACE_ACTION_DETACH is set, this engine is detached as by utrace_detach.
+ * The action bits in UTRACE_ACTION_OP_MASK work as normal, but the engine's
+ * UTRACE_ACTION_STATE_MASK bits will no longer affect the thread.
+ */
+#define UTRACE_ACTION_RESUME	0x0000 /* Continue normally after event.  */
+#define UTRACE_ACTION_HIDE	0x0010 /* Hide event from other tracing.  */
+#define UTRACE_ACTION_DETACH	0x0020 /* Detach me, state flags ignored.  */
+#define UTRACE_ACTION_NEWSTATE	0x0040 /* Replace state bits.  */
+
+/*
+ * These flags affect the state of the thread until they are changed via
+ * utrace_set_flags or by the next callback to the same engine that uses
+ * UTRACE_ACTION_NEWSTATE.
+ */
+#define UTRACE_ACTION_QUIESCE	0x0001 /* Stay quiescent after callbacks.  */
+#define UTRACE_ACTION_SINGLESTEP 0x0002 /* Resume for one instruction.  */
+#define UTRACE_ACTION_BLOCKSTEP 0x0004 /* Resume until next branch.  */
+#define UTRACE_ACTION_NOREAP	0x0008 /* Inhibit parent SIGCHLD and wait.  */
+#define UTRACE_ACTION_STATE_MASK 0x000f /* Lasting state bits.  */
+
+/* These flags have meanings specific to the particular event report hook.  */
+#define UTRACE_ACTION_OP_MASK	0xff00
+
+/*
+ * Action flags in return value and argument of report_signal callback.
+ */
+#define UTRACE_SIGNAL_DELIVER	0x0100 /* Deliver according to sigaction.  */
+#define UTRACE_SIGNAL_IGN	0x0200 /* Ignore the signal.  */
+#define UTRACE_SIGNAL_TERM	0x0300 /* Terminate the process.  */
+#define UTRACE_SIGNAL_CORE	0x0400 /* Terminate with core dump.  */
+#define UTRACE_SIGNAL_STOP	0x0500 /* Deliver as absolute stop.  */
+#define UTRACE_SIGNAL_TSTP	0x0600 /* Deliver as job control stop.  */
+#define UTRACE_SIGNAL_HOLD	0x1000 /* Flag, push signal back on queue.  */
+/*
+ * This value is passed to a report_signal callback after a signal
+ * handler is entered while UTRACE_ACTION_SINGLESTEP is in force.
+ * For this callback, no signal will never actually be delivered regardless
+ * of the return value, and the other callback parameters are null.
+ */
+#define UTRACE_SIGNAL_HANDLER	0x0700
+
+/* Action flag in return value of report_jctl.  */
+#define UTRACE_JCTL_NOSIGCHLD	0x0100 /* Do not notify the parent.  */
+
+
+/*
+ * Flags for utrace_attach.  If UTRACE_ATTACH_CREATE is not specified,
+ * you only look up an existing engine already attached to the
+ * thread.  If UTRACE_ATTACH_MATCH_* bits are set, only consider
+ * matching engines.  If UTRACE_ATTACH_EXCLUSIVE is set, attempting to
+ * attach a second (matching) engine fails with -EEXIST.
+ */
+#define UTRACE_ATTACH_CREATE		0x0010 /* Attach a new engine.  */
+#define UTRACE_ATTACH_EXCLUSIVE		0x0020 /* Refuse if existing match.  */
+#define UTRACE_ATTACH_MATCH_OPS		0x0001 /* Match engines on ops.  */
+#define UTRACE_ATTACH_MATCH_DATA	0x0002 /* Match engines on data.  */
+#define UTRACE_ATTACH_MATCH_MASK	0x000f
+
+
+/*
+ * Per-thread structure task_struct.utrace points to.
+ *
+ * The task itself never has to worry about this going away after
+ * some event is found set in task_struct.utrace_flags.
+ * Once created, this pointer is changed only when the task is quiescent
+ * (TASK_TRACED or TASK_STOPPED with the siglock held, or dead).
+ *
+ * For other parties, the pointer to this is protected by RCU and
+ * task_lock.  Since call_rcu is never used while the thread is alive and
+ * using this struct utrace, we can overlay the RCU data structure used
+ * only for a dead struct with some local state used only for a live utrace
+ * on an active thread.
+ */
+struct utrace
+{
+	union {
+		struct rcu_head dead;
+		struct {
+			struct task_struct *cloning;
+			struct utrace_signal *signal;
+		} live;
+		struct {
+			int notified;
+		} exit;
+	} u;
+
+	struct list_head engines;
+	spinlock_t lock;
+};
+#define utrace_lock(utrace)	spin_lock(&(utrace)->lock)
+#define utrace_unlock(utrace)	spin_unlock(&(utrace)->lock)
+
+
+/*
+ * Per-engine per-thread structure.
+ *
+ * The task itself never has to worry about engines detaching while
+ * it's doing event callbacks.  These structures are freed only when
+ * the task is quiescent.  For other parties, the list is protected
+ * by RCU and utrace_lock.
+ */
+struct utrace_attached_engine
+{
+	struct list_head entry;	/* Entry on thread's utrace.engines list.  */
+	struct rcu_head rhead;
+
+	const struct utrace_engine_ops *ops;
+	unsigned long data;
+
+	unsigned long flags;
+};
+
+
+struct utrace_engine_ops
+{
+	/*
+	 * Event reporting hooks.
+	 *
+	 * Return values contain UTRACE_ACTION_* flag bits.
+	 * The UTRACE_ACTION_OP_MASK bits are specific to each kind of event.
+	 *
+	 * All report_* hooks are called with no locks held, in a generally
+	 * safe environment when we will be returning to user mode soon.
+	 * It is fine to block for memory allocation and the like, but all
+	 * hooks are *asynchronous* and must not block on external events.
+	 * If you want the thread to block, request UTRACE_ACTION_QUIESCE in
+	 * your hook; then later wake it up with utrace_set_flags.
+	 *
+	 */
+
+	/*
+	 * Event reported for parent, before child might run.
+	 * The PF_STARTING flag prevents other engines from attaching
+	 * before this one has its chance.
+	 */
+	u32 (*report_clone)(struct utrace_attached_engine *engine,
+			    struct task_struct *parent,
+			    unsigned long clone_flags,
+			    struct task_struct *child);
+
+	/*
+	 * Event reported for parent using CLONE_VFORK or vfork system call.
+	 * The child has died or exec'd, so the vfork parent has unblocked
+	 * and is about to return child->pid.
+	 */
+	u32 (*report_vfork_done)(struct utrace_attached_engine *engine,
+				 struct task_struct *parent,
+				 struct task_struct *child);
+
+	/*
+	 * Event reported after UTRACE_ACTION_QUIESCE is set, when the target
+	 * thread is quiescent.  Either it's the current thread, or it's in
+	 * TASK_TRACED or TASK_STOPPED and will not resume running until the
+	 * UTRACE_ACTION_QUIESCE flag is no longer asserted by any engine.
+	 */
+	u32 (*report_quiesce)(struct utrace_attached_engine *engine,
+			      struct task_struct *tsk);
+
+	/*
+	 * Thread dequeuing a signal to be delivered.
+	 * The action and *return_ka values say what UTRACE_ACTION_RESUME
+	 * will do (possibly already influenced by another tracing engine).
+	 * An UTRACE_SIGNAL_* return value overrides the signal disposition.
+	 * The *info data (including info->si_signo) can be changed at will.
+	 * Changing *return_ka affects the sigaction that be used.
+	 * The *orig_ka value is the one in force before other tracing
+	 * engines intervened.
+	 */
+	u32 (*report_signal)(struct utrace_attached_engine *engine,
+			     struct task_struct *tsk,
+			     struct pt_regs *regs,
+			     u32 action, siginfo_t *info,
+			     const struct k_sigaction *orig_ka,
+			     struct k_sigaction *return_ka);
+
+	/*
+	 * Job control event completing, about to send SIGCHLD to parent
+	 * with CLD_STOPPED or CLD_CONTINUED as given in type.
+	 * UTRACE_JOBSTOP_NOSIGCHLD in the return value inhibits that.
+	 */
+	u32 (*report_jctl)(struct utrace_attached_engine *engine,
+			   struct task_struct *tsk,
+			   int type);
+
+	/*
+	 * Thread has just completed an exec.
+	 * The initial user register state is handy to be tweaked directly.
+	 */
+	u32 (*report_exec)(struct utrace_attached_engine *engine,
+			   struct task_struct *tsk,
+			   const struct linux_binprm *bprm,
+			   struct pt_regs *regs);
+
+	/*
+	 * Thread has entered the kernel to request a system call.
+	 * The user register state is handy to be tweaked directly.
+	 */
+	u32 (*report_syscall_entry)(struct utrace_attached_engine *engine,
+				    struct task_struct *tsk,
+				    struct pt_regs *regs);
+
+	/*
+	 * Thread is about to leave the kernel after a system call request.
+	 * The user register state is handy to be tweaked directly.
+	 */
+	u32 (*report_syscall_exit)(struct utrace_attached_engine *engine,
+				   struct task_struct *tsk,
+				   struct pt_regs *regs);
+
+	/*
+	 * Thread is exiting and cannot be prevented from doing so,
+	 * but all its state is still live.  The *code value will be
+	 * the wait result seen by the parent, and can be changed by
+	 * this engine or others.  The orig_code value is the real
+	 * status, not changed by any tracing engine.
+	 */
+	u32 (*report_exit)(struct utrace_attached_engine *engine,
+			   struct task_struct *tsk,
+			   long orig_code, long *code);
+
+	/*
+	 * Thread is really dead now.  If UTRACE_ACTION_NOREAP is in force,
+	 * it remains an unreported zombie.  Otherwise, it might be reaped
+	 * by its parent, or self-reap immediately.
+	 */
+	u32 (*report_death)(struct utrace_attached_engine *engine,
+			    struct task_struct *tsk);
+
+	/*
+	 * Called when someone reaps the dead task (parent, init, or self).
+	 * No more callbacks are made after this one.
+	 * The engine is always detached.
+	 * There is nothing more a tracing engine can do about this thread.
+	 */
+	void (*report_reap)(struct utrace_attached_engine *engine,
+			    struct task_struct *tsk);
+
+	/*
+	 * Miscellaneous hooks.  These are not associated with event reports.
+	 * Any of these may be null if the engine has nothing to say.
+	 * These hooks are called in more constrained environments and should
+	 * not block or do very much.
+	 */
+
+	/*
+	 * Return nonzero iff the caller task should be allowed to access
+	 * the memory of the target task via /proc/PID/mem and so forth,
+	 * by dint of this engine's attachment to the target.
+	 */
+	int (*allow_access_process_vm)(struct utrace_attached_engine *engine,
+				       struct task_struct *target,
+				       struct task_struct *caller);
+
+	/*
+	 * Return the value to display after "TracerPid:" in /proc/PID/status.
+	 * If this engine returns zero, another engine may supply the value.
+	 */
+	pid_t (*tracer_pid)(struct utrace_attached_engine *engine,
+			    struct task_struct *target);
+};
+
+
+/***
+ *** These are the exported entry points for tracing engines to use.
+ ***/
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
+
+/*
+ * Detach a tracing engine from a thread.  After this, the engine
+ * data structure is no longer accessible, and the thread might be reaped.
+ * The thread will start running again if it was being kept quiescent
+ * and no longer has any attached engines asserting UTRACE_ACTION_QUIESCE.
+ *
+ * If the target thread is not already quiescent, then a callback to this
+ * engine might be in progress or about to start on another CPU.  If it's
+ * quiescent when utrace_detach is called, then after return it's guaranteed
+ * that no more callbacks to the ops vector will be done.
+ */
+void utrace_detach(struct task_struct *target,
+		   struct utrace_attached_engine *engine);
+
+/*
+ * Change the flags for a tracing engine.
+ * This resets the event flags and the action state flags.
+ * If UTRACE_ACTION_QUIESCE and UTRACE_EVENT(QUIESCE) are set,
+ * this will cause a report_quiesce callback soon, maybe immediately.
+ * If UTRACE_ACTION_QUIESCE was set before and is no longer set by
+ * any engine, this will wake the thread up.
+ */
+void utrace_set_flags(struct task_struct *target,
+		      struct utrace_attached_engine *engine,
+		      unsigned long flags);
+
+/*
+ * Cause a specified signal delivery in the target thread, which must be
+ * quiescent (or the current thread).  The action has UTRACE_SIGNAL_* bits
+ * as returned from a report_signal callback.  If ka is non-null, it gives
+ * the sigaction to follow for UTRACE_SIGNAL_DELIVER; otherwise, the
+ * installed sigaction at the time of delivery is used.
+ */
+int utrace_inject_signal(struct task_struct *target,
+			 struct utrace_attached_engine *engine,
+			 u32 action, siginfo_t *info,
+			 const struct k_sigaction *ka);
+
+/*
+ * Prepare to access thread's machine state, see <linux/tracehook.h>.
+ * The given thread must be quiescent (or the current thread).
+ * When this returns, the struct utrace_regset calls may be used to
+ * interrogate or change the thread's state.  Do not cache the returned
+ * pointer when the thread can resume.  You must call utrace_regset to
+ * ensure that context switching has completed and consistent state is
+ * available.
+ */
+const struct utrace_regset *utrace_regset(struct task_struct *target,
+					  struct utrace_attached_engine *,
+					  const struct utrace_regset_view *,
+					  int which);
+
+
+/*
+ * Hooks in <linux/tracehook.h> call these entry points to the utrace dispatch.
+ */
+void utrace_quiescent(struct task_struct *);
+void utrace_release_task(struct task_struct *);
+int utrace_get_signal(struct task_struct *, struct pt_regs *,
+		      siginfo_t *, struct k_sigaction *);
+void utrace_report_clone(unsigned long clone_flags, struct task_struct *child);
+void utrace_report_vfork_done(struct task_struct *child);
+void utrace_report_exit(long *exit_code);
+void utrace_report_death(struct task_struct *);
+int utrace_report_jctl(int type);
+void utrace_report_exec(struct linux_binprm *bprm, struct pt_regs *regs);
+void utrace_report_syscall(struct pt_regs *regs, int is_exit);
+pid_t utrace_tracer_pid(struct task_struct *);
+int utrace_allow_access_process_vm(struct task_struct *);
+void utrace_signal_handler_singlestep(struct task_struct *, struct pt_regs *);
+
+
+#endif	/* linux/utrace.h */
diff --git a/init/Kconfig b/init/Kconfig
index 38416a1..21d6806 100644  
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -511,6 +511,23 @@ config STOP_MACHINE
 	  Need stop_machine() primitive.
 endmenu
 
+menu "Process debugging support"
+
+config UTRACE
+	bool "Infrastructure for tracing and debugging user processes"
+	default y
+	help
+	  Enable the utrace process tracing interface.
+	  This is an internal kernel interface to track events in user
+	  threads, extract and change user thread state.  This interface
+	  is exported to kernel modules, and is also used to implement ptrace.
+	  If you disable this, no facilities for debugging user processes
+	  will be available, nor the facilities used by UML and other
+	  applications.  Unless you are making a specially stripped-down
+	  kernel and are very sure you don't need these facilitiies,
+	  say Y.
+endmenu
+
 menu "Block layer"
 source "block/Kconfig"
 endmenu
diff --git a/kernel/Makefile b/kernel/Makefile
index 4ae0fbd..4bb2f60 100644  
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_UTRACE) += utrace.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --git a/kernel/utrace.c b/kernel/utrace.c
new file mode 100644
index ...d18eba0 100644  
--- /dev/null
+++ b/kernel/utrace.c
@@ -0,0 +1,1475 @@
+#include <linux/utrace.h>
+#include <linux/tracehook.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <asm/tracehook.h>
+
+
+static kmem_cache_t *utrace_cachep;
+static kmem_cache_t *utrace_engine_cachep;
+
+static int __init
+utrace_init(void)
+{
+	utrace_cachep =
+		kmem_cache_create("utrace_cache",
+				  sizeof(struct utrace), 0,
+				  SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+	utrace_engine_cachep =
+		kmem_cache_create("utrace_engine_cache",
+				  sizeof(struct utrace_attached_engine), 0,
+				  SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+	return 0;
+}
+subsys_initcall(utrace_init);
+
+
+/*
+ * Make sure target->utrace is allocated, and return with it locked on
+ * success.  This function mediates startup races.  The creating parent
+ * task has priority, and other callers will delay here to let its call
+ * succeed and take the new utrace lock first.
+ */
+static struct utrace *
+utrace_first_engine(struct task_struct *target,
+		    struct utrace_attached_engine *engine)
+{
+	struct utrace *utrace, *ret;
+
+	/*
+	 * If this is a newborn thread and we are not the creator,
+	 * we have to wait for it.  The creator gets the first chance
+	 * to attach.  The PF_STARTING flag is cleared after its
+	 * report_clone hook has had a chance to run.
+	 */
+	if ((target->flags & PF_STARTING)
+	    && (current->utrace == NULL
+		|| current->utrace->u.live.cloning != target)) {
+		yield();
+		return (signal_pending(current)
+			? ERR_PTR(-ERESTARTNOINTR) : NULL);
+	}
+
+	utrace = kmem_cache_alloc(utrace_cachep, SLAB_KERNEL);
+	if (unlikely(utrace == NULL))
+		return ERR_PTR(-ENOMEM);
+
+	utrace->u.live.cloning = NULL;
+	utrace->u.live.signal = NULL;
+	INIT_LIST_HEAD(&utrace->engines);
+	list_add(&engine->entry, &utrace->engines);
+	spin_lock_init(&utrace->lock);
+
+	ret = utrace;
+	utrace_lock(utrace);
+	task_lock(target);
+	if (likely(target->utrace == NULL)) {
+		rcu_assign_pointer(target->utrace, utrace);
+		/*
+		 * The task_lock protects us against another thread doing
+		 * the same thing.  We might still be racing against
+		 * tracehook_release_task.  It sets PF_REAPED and then
+		 * checks ->utrace with an smp_mb() in between.  If
+		 * PF_REAPED is set, then release_task might have checked
+		 * ->utrace already and saw it NULL; we can't attach.  If
+		 * we see PF_REAPED not yet set after our barrier, then we
+		 * know release_task will see our target->utrace pointer.
+		 */
+		smp_mb();
+		if (target->flags & PF_REAPED) {
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
+
+static void
+utrace_free(struct rcu_head *rhead)
+{
+	struct utrace *utrace = container_of(rhead, struct utrace, u.dead);
+	kmem_cache_free(utrace_cachep, utrace);
+}
+
+static void
+rcu_utrace_free(struct utrace *utrace)
+{
+	INIT_RCU_HEAD(&utrace->u.dead);
+	call_rcu(&utrace->u.dead, utrace_free);
+}
+
+static void
+utrace_engine_free(struct rcu_head *rhead)
+{
+	struct utrace_attached_engine *engine =
+		container_of(rhead, struct utrace_attached_engine, rhead);
+	kmem_cache_free(utrace_engine_cachep, engine);
+}
+
+/*
+ * Called with utrace locked and the target quiescent (maybe current).
+ * If this was the last engine, utrace is left locked and not freed,
+ * but is removed from the task.
+ */
+static void
+remove_engine(struct utrace_attached_engine *engine,
+	      struct task_struct *tsk, struct utrace *utrace)
+{
+	list_del_rcu(&engine->entry);
+	if (list_empty(&utrace->engines)) {
+		task_lock(tsk);
+		if (likely(tsk->utrace != NULL)) {
+			rcu_assign_pointer(tsk->utrace, NULL);
+			tsk->utrace_flags = 0;
+		}
+		task_unlock(tsk);
+	}
+	call_rcu(&engine->rhead, utrace_engine_free);
+}
+
+
+/*
+ * Called with utrace locked, after remove_engine may have run.
+ * Passed the flags from all remaining engines, i.e. zero if none left.
+ * Install the flags in tsk->utrace_flags and return with utrace unlocked.
+ * If no engines are left, utrace is freed and we return NULL.
+ */
+static struct utrace *
+check_dead_utrace(struct task_struct *tsk, struct utrace *utrace,
+		 unsigned long flags)
+{
+	if (flags) {
+		tsk->utrace_flags = flags;
+		utrace_unlock(utrace);
+		return utrace;
+	}
+
+	utrace_unlock(utrace);
+	rcu_utrace_free(utrace);
+	return NULL;
+}
+
+
+
+/*
+ * Get the target thread to quiesce.  Return nonzero if it's already quiescent.
+ * Return zero if it will report a QUIESCE event soon.
+ * If interrupt is nonzero, wake it like a signal would so it quiesces ASAP.
+ * If interrupt is zero, just make sure it quiesces before going to user mode.
+ */
+static int
+quiesce(struct task_struct *target, int interrupt)
+{
+	int quiescent;
+
+	target->utrace_flags |= UTRACE_ACTION_QUIESCE;
+	read_barrier_depends();
+
+	quiescent = (target->exit_state
+		     || target->state & (TASK_TRACED | TASK_STOPPED));
+
+	if (!quiescent) {
+		spin_lock_irq(&target->sighand->siglock);
+		quiescent = (unlikely(target->exit_state)
+			     || unlikely(target->state
+					 & (TASK_TRACED | TASK_STOPPED)));
+		if (!quiescent) {
+			if (interrupt)
+				signal_wake_up(target, 0);
+			else {
+				set_tsk_thread_flag(target, TIF_SIGPENDING);
+				kick_process(target);
+			}
+		}
+		spin_unlock_irq(&target->sighand->siglock);
+	}
+
+	return quiescent;
+}
+
+
+static struct utrace_attached_engine *
+matching_engine(struct utrace *utrace, int flags,
+		const struct utrace_engine_ops *ops, unsigned long data)
+{
+	struct utrace_attached_engine *engine;
+	list_for_each_entry_rcu(engine, &utrace->engines, entry) {
+		if ((flags & UTRACE_ATTACH_MATCH_OPS)
+		    && engine->ops != ops)
+			continue;
+		if ((flags & UTRACE_ATTACH_MATCH_DATA)
+		    && engine->data != data)
+			continue;
+		if (flags & UTRACE_ATTACH_EXCLUSIVE)
+			engine = ERR_PTR(-EEXIST);
+		return engine;
+	}
+	return NULL;
+}
+
+/*
+  option to stop it?
+  option to match existing on ops, ops+data, return it; nocreate:lookup only
+ */
+struct utrace_attached_engine *
+utrace_attach(struct task_struct *target, int flags,
+	     const struct utrace_engine_ops *ops, unsigned long data)
+{
+	struct utrace *utrace;
+	struct utrace_attached_engine *engine;
+
+restart:
+	rcu_read_lock();
+	utrace = rcu_dereference(target->utrace);
+	smp_rmb();
+	if (utrace == NULL) {
+		rcu_read_unlock();
+
+		if (!(flags & UTRACE_ATTACH_CREATE)) {
+			return ERR_PTR(-ENOENT);
+		}
+
+		engine = kmem_cache_alloc(utrace_engine_cachep, SLAB_KERNEL);
+		if (unlikely(engine == NULL))
+			return ERR_PTR(-ENOMEM);
+		engine->flags = 0;
+
+	first:
+		utrace = utrace_first_engine(target, engine);
+		if (IS_ERR(utrace)) {
+			kmem_cache_free(utrace_engine_cachep, engine);
+			return ERR_PTR(PTR_ERR(utrace));
+		}
+		if (unlikely(utrace == NULL)) /* Race condition.  */
+			goto restart;
+	}
+	else if (unlikely(target->flags & PF_REAPED)) {
+		/*
+		 * The target has already been through release_task.
+		 */
+		rcu_read_unlock();
+		return ERR_PTR(-ESRCH);
+	}
+	else {
+		if (!(flags & UTRACE_ATTACH_CREATE)) {
+			engine = matching_engine(utrace, flags, ops, data);
+			rcu_read_unlock();
+			return engine;
+		}
+
+		engine = kmem_cache_alloc(utrace_engine_cachep, SLAB_KERNEL);
+		if (unlikely(engine == NULL))
+			return ERR_PTR(-ENOMEM);
+		engine->flags = ops->report_reap ? UTRACE_EVENT(REAP) : 0;
+
+		rcu_read_lock();
+		utrace = rcu_dereference(target->utrace);
+		if (unlikely(utrace == NULL)) { /* Race with detach.  */
+			rcu_read_unlock();
+			goto first;
+		}
+
+		utrace_lock(utrace);
+		if (flags & UTRACE_ATTACH_EXCLUSIVE) {
+			struct utrace_attached_engine *old;
+			old = matching_engine(utrace, flags, ops, data);
+			if (old != NULL) {
+				utrace_unlock(utrace);
+				rcu_read_unlock();
+				kmem_cache_free(utrace_engine_cachep, engine);
+				return ERR_PTR(-EEXIST);
+			}
+		}
+
+		if (unlikely(rcu_dereference(target->utrace) != utrace)) {
+			/*
+			 * We lost a race with other CPUs doing a sequence
+			 * of detach and attach before we got in.
+			 */
+			utrace_unlock(utrace);
+			rcu_read_unlock();
+			kmem_cache_free(utrace_engine_cachep, engine);
+			goto restart;
+		}
+		list_add_tail_rcu(&engine->entry, &utrace->engines);
+	}
+
+	engine->ops = ops;
+	engine->data = data;
+
+	utrace_unlock(utrace);
+
+	return engine;
+}
+EXPORT_SYMBOL_GPL(utrace_attach);
+
+/*
+ * When an engine is detached, the target thread may still see it and make
+ * callbacks until it quiesces.  We reset its event flags to just QUIESCE
+ * and install a special ops vector whose callback is dead_engine_delete.
+ * When the target thread quiesces, it can safely free the engine itself.
+ */
+static u32
+dead_engine_delete(struct utrace_attached_engine *engine,
+		   struct task_struct *tsk)
+{
+	return UTRACE_ACTION_DETACH;
+}
+
+static const struct utrace_engine_ops dead_engine_ops =
+{
+	.report_quiesce = &dead_engine_delete
+};
+
+
+/*
+ * If tracing was preventing a SIGCHLD or self-reaping
+ * and is no longer, do that report or reaping right now.
+ */
+static void
+check_noreap(struct task_struct *target, struct utrace *utrace,
+	     u32 old_action, u32 action)
+{
+	if ((action | ~old_action) & UTRACE_ACTION_NOREAP)
+		return;
+
+	if (utrace && xchg(&utrace->u.exit.notified, 1))
+		return;
+
+	if (target->exit_signal == -1)
+		release_task(target);
+	else if (thread_group_empty(target)) {
+		read_lock(&tasklist_lock);
+		do_notify_parent(target, target->exit_signal);
+		read_unlock(&tasklist_lock);
+	}
+}
+
+/*
+ * We may have been the one keeping the target thread quiescent.
+ * Check if it should wake up now.
+ * Called with utrace locked, and unlocks it on return.
+ * If we were keeping it stopped, resume it.
+ * If we were keeping its zombie from reporting/self-reap, do it now.
+ */
+static void
+wake_quiescent(unsigned long old_flags,
+	       struct utrace *utrace, struct task_struct *target)
+{
+	unsigned long flags;
+	struct utrace_attached_engine *engine;
+
+	if (target->exit_state) {
+		/*
+		 * Update the set of events of interest from the union
+		 * of the interests of the remaining tracing engines.
+		 */
+		flags = 0;
+		list_for_each_entry(engine, &utrace->engines, entry)
+			flags |= engine->flags | UTRACE_EVENT(REAP);
+		utrace = check_dead_utrace(target, utrace, flags);
+
+		check_noreap(target, utrace, old_flags, flags);
+		return;
+	}
+
+	/*
+	 * Update the set of events of interest from the union
+	 * of the interests of the remaining tracing engines.
+	 */
+	flags = 0;
+	list_for_each_entry(engine, &utrace->engines, entry)
+		flags |= engine->flags | UTRACE_EVENT(REAP);
+	utrace = check_dead_utrace(target, utrace, flags);
+
+	if (flags & UTRACE_ACTION_QUIESCE)
+		return;
+
+	read_lock(&tasklist_lock);
+	if (!target->exit_state) {
+		/*
+		 * The target is not dead and should not be in tracing stop
+		 * any more.  Wake it unless it's in job control stop.
+		 */
+		spin_lock_irq(&target->sighand->siglock);
+		if (target->signal->flags & SIGNAL_STOP_STOPPED) {
+			int stop_count = target->signal->group_stop_count;
+			target->state = TASK_STOPPED;
+			spin_unlock_irq(&target->sighand->siglock);
+
+			/*
+			 * If tracing was preventing a CLD_STOPPED report
+			 * and is no longer, do that report right now.
+			 */
+			if (stop_count == 0
+			    && 0
+			    /*&& (events &~ interest) & UTRACE_INHIBIT_CLDSTOP*/
+				)
+				do_notify_parent_cldstop(target, CLD_STOPPED);
+		}
+		else {
+			/*
+			 * Wake the task up.
+			 */
+			recalc_sigpending_tsk(target);
+			wake_up_state(target, TASK_STOPPED | TASK_TRACED);
+			spin_unlock_irq(&target->sighand->siglock);
+		}
+	}
+	read_unlock(&tasklist_lock);
+}
+
+void
+utrace_detach(struct task_struct *target,
+	      struct utrace_attached_engine *engine)
+{
+	struct utrace *utrace;
+	unsigned long flags;
+
+	rcu_read_lock();
+	utrace = rcu_dereference(target->utrace);
+	smp_rmb();
+	if (unlikely(target->flags & PF_REAPED)) {
+		/*
+		 * Called after utrace_release_task has started.  A call to
+		 * this engine's report_reap callback might already be in
+		 * progress or engine might even have been freed already.
+		 */
+		rcu_read_unlock();
+		return;
+	}
+	utrace_lock(utrace);
+	rcu_read_unlock();
+
+	flags = engine->flags;
+	engine->flags = UTRACE_EVENT(QUIESCE) | UTRACE_ACTION_QUIESCE;
+	rcu_assign_pointer(engine->ops, &dead_engine_ops);
+
+	if (quiesce(target, 1)) {
+		remove_engine(engine, target, utrace);
+		wake_quiescent(flags, utrace, target);
+	}
+	else
+		utrace_unlock(utrace);
+}
+EXPORT_SYMBOL_GPL(utrace_detach);
+
+
+/*
+ * Called by release_task.  After this, target->utrace must be cleared.
+ */
+void
+utrace_release_task(struct task_struct *target)
+{
+	struct utrace *utrace;
+	struct utrace_attached_engine *engine, *next;
+	const struct utrace_engine_ops *ops;
+
+	task_lock(target);
+	utrace = target->utrace;
+	rcu_assign_pointer(target->utrace, NULL);
+	task_unlock(target);
+
+	if (unlikely(utrace == NULL))
+		return;
+
+restart:
+	utrace_lock(utrace);
+	list_for_each_entry_safe(engine, next, &utrace->engines, entry) {
+		list_del_rcu(&engine->entry);
+
+		/*
+		 * Now nothing else refers to this engine.
+		 */
+		if (engine->flags & UTRACE_EVENT(REAP)) {
+			ops = rcu_dereference(engine->ops);
+			utrace_unlock(utrace);
+			(*ops->report_reap)(engine, target);
+			call_rcu(&engine->rhead, utrace_engine_free);
+			goto restart;
+		}
+		else
+			call_rcu(&engine->rhead, utrace_engine_free);
+	}
+	utrace_unlock(utrace);
+
+	rcu_utrace_free(utrace);
+}
+
+
+void
+utrace_set_flags(struct task_struct *target,
+		 struct utrace_attached_engine *engine,
+		 unsigned long flags)
+{
+	struct utrace *utrace;
+	int report = 0;
+	unsigned long old_flags, old_utrace_flags;
+
+	rcu_read_lock();
+	utrace = rcu_dereference(target->utrace);
+	smp_rmb();
+	if (unlikely(target->flags & PF_REAPED)) {
+		/*
+		 * Race with utrace_release_task.
+		 */
+		rcu_read_unlock();
+		return;
+	}
+
+	utrace_lock(utrace);
+	rcu_read_unlock();
+
+	old_utrace_flags = target->utrace_flags;
+	old_flags = engine->flags;
+	engine->flags = flags;
+	target->utrace_flags |= flags;
+
+	if ((old_flags ^ flags) & UTRACE_ACTION_QUIESCE) {
+		if (flags & UTRACE_ACTION_QUIESCE) {
+			report = (quiesce(target, 1)
+				  && (flags & UTRACE_EVENT(QUIESCE)));
+			utrace_unlock(utrace);
+		}
+		else
+			wake_quiescent(old_flags, utrace, target);
+	}
+	else {
+		/*
+		 * If we're asking for single-stepping or syscall tracing,
+		 * we need to pass through utrace_quiescent before resuming
+		 * in user mode to get those effects, even if the target is
+		 * not going to be quiescent right now.
+		 */
+		if (!(target->utrace_flags & UTRACE_ACTION_QUIESCE)
+		    && ((flags &~ old_utrace_flags)
+			& (UTRACE_ACTION_SINGLESTEP | UTRACE_ACTION_BLOCKSTEP
+			   | UTRACE_EVENT_SYSCALL)))
+			quiesce(target, 0);
+		utrace_unlock(utrace);
+	}
+
+	if (report)	     /* Already quiescent, won't report itself.  */
+		(*engine->ops->report_quiesce)(engine, target);
+}
+EXPORT_SYMBOL_GPL(utrace_set_flags);
+
+/*
+ * While running an engine callback, no locks are held.
+ * If a callback updates its engine's action state, then
+ * we need to take the utrace lock to install the flags update.
+ */
+static inline u32
+update_action(struct task_struct *tsk, struct utrace *utrace,
+	      struct utrace_attached_engine *engine,
+	      u32 ret)
+{
+	if (ret & UTRACE_ACTION_DETACH)
+		rcu_assign_pointer(engine->ops, &dead_engine_ops);
+	else if ((ret & UTRACE_ACTION_NEWSTATE)
+		 && ((ret ^ engine->flags) & UTRACE_ACTION_STATE_MASK)) {
+		utrace_lock(utrace);
+		/*
+		 * If we're changing something other than just QUIESCE,
+		 * make sure we pass through utrace_quiescent before
+		 * resuming even if we aren't going to stay quiescent.
+		 * That's where we get the correct union of all engines'
+		 * flags after they've finished changing, and apply changes.
+		 */
+		if (((ret ^ engine->flags) & (UTRACE_ACTION_STATE_MASK
+					      & ~UTRACE_ACTION_QUIESCE)))
+			tsk->utrace_flags |= UTRACE_ACTION_QUIESCE;
+		engine->flags &= ~UTRACE_ACTION_STATE_MASK;
+		engine->flags |= ret & UTRACE_ACTION_STATE_MASK;
+		tsk->utrace_flags |= engine->flags;
+		utrace_unlock(utrace);
+	}
+	else
+		ret |= engine->flags & UTRACE_ACTION_STATE_MASK;
+	return ret;
+}
+
+#define REPORT(callback, ...) do { \
+	u32 ret = (*rcu_dereference(engine->ops)->callback) \
+		(engine, tsk, ##__VA_ARGS__); \
+	action = update_action(tsk, utrace, engine, ret); \
+	} while (0)
+
+
+
+static u32
+remove_detached(struct task_struct *tsk, struct utrace **utracep, u32 action)
+{
+	struct utrace *utrace = tsk->utrace;
+	struct utrace_attached_engine *engine, *next;
+	unsigned long flags;
+
+	flags = 0;
+	utrace_lock(utrace);
+	list_for_each_entry_safe(engine, next, &utrace->engines, entry) {
+		if (engine->ops == &dead_engine_ops)
+			remove_engine(engine, tsk, utrace);
+		else
+			flags |= engine->flags | UTRACE_EVENT(REAP);
+	}
+	utrace = check_dead_utrace(tsk, utrace, flags);
+	if (utracep)
+		*utracep = utrace;
+
+	flags &= UTRACE_ACTION_STATE_MASK;
+	return flags | (action & UTRACE_ACTION_OP_MASK);
+}
+
+/*
+ * Called after an event report loop.  Remove any engines marked for detach.
+ */
+static inline u32
+check_detach(struct task_struct *tsk, u32 action)
+{
+	if (action & UTRACE_ACTION_DETACH)
+		action = remove_detached(tsk, NULL, action);
+	return action;
+}
+
+static inline void
+check_quiescent(struct task_struct *tsk, u32 action)
+{
+	if (action & UTRACE_ACTION_STATE_MASK)
+		utrace_quiescent(tsk);
+}
+
+/*
+ * Called iff UTRACE_EVENT(CLONE) flag is set.
+ * This notification call blocks the wake_up_new_task call on the child.
+ * So we must not quiesce here.  tracehook_report_clone_complete will do
+ * a quiescence check momentarily.
+ */
+void
+utrace_report_clone(unsigned long clone_flags, struct task_struct *child)
+{
+	struct task_struct *tsk = current;
+	struct utrace *utrace = tsk->utrace;
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+	unsigned long action;
+
+	utrace->u.live.cloning = child;
+
+	/* XXX must change for sharing */
+	action = UTRACE_ACTION_RESUME;
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & UTRACE_EVENT(CLONE))
+			REPORT(report_clone, clone_flags, child);
+		if (action & UTRACE_ACTION_HIDE)
+			break;
+	}
+
+	utrace->u.live.cloning = NULL;
+
+	check_detach(tsk, action);
+}
+
+static unsigned long
+report_quiescent(struct task_struct *tsk, struct utrace *utrace, u32 action)
+{
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & UTRACE_EVENT(QUIESCE))
+			REPORT(report_quiesce);
+		action |= engine->flags & UTRACE_ACTION_STATE_MASK;
+	}
+
+	return check_detach(tsk, action);
+}
+
+/*
+ * Called iff UTRACE_EVENT(JCTL) flag is set.
+ */
+int
+utrace_report_jctl(int what)
+{
+	struct task_struct *tsk = current;
+	struct utrace *utrace = tsk->utrace;
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+	unsigned long action;
+
+	/* XXX must change for sharing */
+	action = UTRACE_ACTION_RESUME;
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & UTRACE_EVENT(JCTL))
+			REPORT(report_jctl, what);
+		if (action & UTRACE_ACTION_HIDE)
+			break;
+	}
+
+	/*
+	 * We are becoming quiescent, so report it now.
+	 * We don't block in utrace_quiescent because we are stopping anyway.
+	 * We know that upon resuming we'll go through tracehook_induce_signal,
+	 * which will keep us quiescent or set us up to resume with tracing.
+	 */
+	action = report_quiescent(tsk, utrace, action);
+
+	if (what == CLD_STOPPED && tsk->state != TASK_STOPPED) {
+		/*
+		 * The event report hooks could have blocked, though
+		 * it should have been briefly.  Make sure we're in
+		 * TASK_STOPPED state again to block properly, unless
+		 * we've just come back out of job control stop.
+		 */
+		spin_lock_irq(&tsk->sighand->siglock);
+		if (tsk->signal->flags & SIGNAL_STOP_STOPPED)
+			set_current_state(TASK_STOPPED);
+		spin_unlock_irq(&tsk->sighand->siglock);
+	}
+
+	return action & UTRACE_JCTL_NOSIGCHLD;
+}
+
+
+/*
+ * Called if UTRACE_EVENT(QUIESCE) or UTRACE_ACTION_QUIESCE flag is set.
+ * Also called after other event reports.
+ * It is a good time to block.
+ */
+void
+utrace_quiescent(struct task_struct *tsk)
+{
+	struct utrace *utrace = tsk->utrace;
+	unsigned long action;
+
+restart:
+	/* XXX must change for sharing */
+
+	action = report_quiescent(tsk, utrace, UTRACE_ACTION_RESUME);
+
+	/*
+	 * If some engines want us quiescent, we block here.
+	 */
+	if (action & UTRACE_ACTION_QUIESCE) {
+		spin_lock_irq(&tsk->sighand->siglock);
+		/*
+		 * If wake_quiescent is trying to wake us up now, it will
+		 * have cleared the QUIESCE flag before trying to take the
+		 * siglock.  Now we have the siglock, so either it has
+		 * already cleared the flag, or it will wake us up after we
+		 * release the siglock it's waiting for.
+		 * Never stop when there is a SIGKILL bringing us down.
+		 */
+		if ((tsk->utrace_flags & UTRACE_ACTION_QUIESCE)
+		    /*&& !(tsk->signal->flags & SIGNAL_GROUP_SIGKILL)*/) {
+			set_current_state(TASK_TRACED);
+			/*
+			 * If there is a group stop in progress,
+			 * we must participate in the bookkeeping.
+			 */
+			if (tsk->signal->group_stop_count > 0)
+				--tsk->signal->group_stop_count;
+			spin_unlock_irq(&tsk->sighand->siglock);
+			schedule();
+		}
+		else
+			spin_unlock_irq(&tsk->sighand->siglock);
+
+		/*
+		 * We've woken up.  One engine could be waking us up while
+		 * another has asked us to quiesce.  So check afresh.  We
+		 * could have been detached while quiescent.  Now we are no
+		 * longer quiescent, so don't need to do any RCU locking.
+		 * But we do need to check our utrace pointer anew.
+		 */
+		utrace = tsk->utrace;
+		if (tsk->utrace_flags
+		    & (UTRACE_EVENT(QUIESCE) | UTRACE_ACTION_STATE_MASK))
+			goto restart;
+	}
+	else if (tsk->utrace_flags & UTRACE_ACTION_QUIESCE) {
+		/*
+		 * Our flags are out of date.
+		 * Update the set of events of interest from the union
+		 * of the interests of the remaining tracing engines.
+		 */
+		struct utrace_attached_engine *engine;
+		unsigned long flags = 0;
+		utrace = rcu_dereference(tsk->utrace);
+		utrace_lock(utrace);
+		list_for_each_entry(engine, &utrace->engines, entry)
+			flags |= engine->flags | UTRACE_EVENT(REAP);
+		tsk->utrace_flags = flags;
+		utrace_unlock(utrace);
+	}
+
+	/*
+	 * We're resuming.  Update the machine layer tracing state and then go.
+	 */
+	if (action & UTRACE_ACTION_SINGLESTEP)
+		tracehook_enable_single_step(tsk);
+	else
+		tracehook_disable_single_step(tsk);
+#ifdef ARCH_HAS_BLOCK_STEP
+	if ((action & (UTRACE_ACTION_BLOCKSTEP|UTRACE_ACTION_SINGLESTEP))
+	    == UTRACE_ACTION_BLOCKSTEP)
+		tracehook_enable_block_step(tsk);
+	else
+		tracehook_disable_block_step(tsk);
+#endif
+	if (tsk->utrace_flags & UTRACE_EVENT_SYSCALL)
+		tracehook_enable_syscall_trace(tsk);
+	else
+		tracehook_disable_syscall_trace(tsk);
+}
+
+
+/*
+ * Called iff UTRACE_EVENT(EXIT) flag is set.
+ */
+void
+utrace_report_exit(long *exit_code)
+{
+	struct task_struct *tsk = current;
+	struct utrace *utrace = tsk->utrace;
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+	unsigned long action;
+	long orig_code = *exit_code;
+
+	/* XXX must change for sharing */
+	action = UTRACE_ACTION_RESUME;
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & UTRACE_EVENT(EXIT))
+			REPORT(report_exit, orig_code, exit_code);
+	}
+	action = check_detach(tsk, action);
+	check_quiescent(tsk, action);
+}
+
+/*
+ * Called iff UTRACE_EVENT(DEATH) flag is set.
+ */
+void
+utrace_report_death(struct task_struct *tsk)
+{
+	struct utrace *utrace = tsk->utrace;
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+	u32 action, oaction;
+
+	BUG_ON(!tsk->exit_state);
+
+	oaction = tsk->utrace_flags;
+
+	/* XXX must change for sharing */
+	action = UTRACE_ACTION_RESUME;
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & UTRACE_EVENT(DEATH))
+			REPORT(report_death);
+		if (engine->flags & UTRACE_EVENT(QUIESCE))
+			REPORT(report_quiesce);
+	}
+	/*
+	 * Unconditionally lock and recompute the flags.
+	 * This may notice that there are no engines left and
+	 * free the utrace struct.
+	 */
+	action = remove_detached(tsk, &utrace, action);
+
+	check_noreap(tsk, utrace, oaction, action);
+}
+
+/*
+ * Called iff UTRACE_EVENT(VFORK_DONE) flag is set.
+ */
+void
+utrace_report_vfork_done(struct task_struct *child)
+{
+	struct task_struct *tsk = current;
+	struct utrace *utrace = tsk->utrace;
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+	unsigned long action;
+
+	/* XXX must change for sharing */
+	action = UTRACE_ACTION_RESUME;
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & UTRACE_EVENT(VFORK_DONE))
+			REPORT(report_vfork_done, child);
+		if (action & UTRACE_ACTION_HIDE)
+			break;
+	}
+	action = check_detach(tsk, action);
+	check_quiescent(tsk, action);
+}
+
+/*
+ * Called iff UTRACE_EVENT(EXEC) flag is set.
+ */
+void
+utrace_report_exec(struct linux_binprm *bprm, struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	struct utrace *utrace = tsk->utrace;
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+	unsigned long action;
+
+	/* XXX must change for sharing */
+	action = UTRACE_ACTION_RESUME;
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & UTRACE_EVENT(EXEC))
+			REPORT(report_exec, bprm, regs);
+		if (action & UTRACE_ACTION_HIDE)
+			break;
+	}
+	action = check_detach(tsk, action);
+	check_quiescent(tsk, action);
+}
+
+/*
+ * Called iff UTRACE_EVENT(SYSCALL_{ENTRY,EXIT}) flag is set.
+ */
+void
+utrace_report_syscall(struct pt_regs *regs, int is_exit)
+{
+	struct task_struct *tsk = current;
+	struct utrace *utrace = tsk->utrace;
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+	unsigned long action, ev;
+
+/*
+  XXX pass syscall # to engine hook directly, let it return inhibit-action
+  to reset to -1
+	long syscall = tracehook_syscall_number(regs, is_exit);
+*/
+
+	ev = is_exit ? UTRACE_EVENT(SYSCALL_EXIT) : UTRACE_EVENT(SYSCALL_ENTRY);
+
+	/* XXX must change for sharing */
+	action = UTRACE_ACTION_RESUME;
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if (engine->flags & ev) {
+			if (is_exit)
+				REPORT(report_syscall_exit, regs);
+			else
+				REPORT(report_syscall_entry, regs);
+		}
+		if (action & UTRACE_ACTION_HIDE)
+			break;
+	}
+	action = check_detach(tsk, action);
+	check_quiescent(tsk, action);
+}
+
+
+/*
+ * This is pointed to by the utrace struct, but it's really a private
+ * structure between utrace_get_signal and utrace_inject_signal.
+ */
+struct utrace_signal
+{
+	siginfo_t *const info;
+	struct k_sigaction *return_ka;
+	int signr;
+};
+
+
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
+
+
+/*
+ * Call each interested tracing engine's report_signal callback.
+ */
+static u32
+report_signal(struct task_struct *tsk, struct pt_regs *regs,
+	      struct utrace *utrace, u32 action,
+	      unsigned long flags1, unsigned long flags2, siginfo_t *info,
+	      const struct k_sigaction *ka, struct k_sigaction *return_ka)
+{
+	struct list_head *pos, *next;
+	struct utrace_attached_engine *engine;
+
+	/* XXX must change for sharing */
+	list_for_each_safe_rcu(pos, next, &utrace->engines) {
+		engine = list_entry(pos, struct utrace_attached_engine, entry);
+		if ((engine->flags & flags1) && (engine->flags & flags2)) {
+			u32 disp = action & UTRACE_ACTION_OP_MASK;
+			action &= ~UTRACE_ACTION_OP_MASK;
+			REPORT(report_signal, regs, disp, info, ka, return_ka);
+			if ((action & UTRACE_ACTION_OP_MASK) == 0)
+				action |= disp;
+			if (action & UTRACE_ACTION_HIDE)
+				break;
+		}
+	}
+
+	return action;
+}
+
+void
+utrace_signal_handler_singlestep(struct task_struct *tsk, struct pt_regs *regs)
+{
+	u32 action;
+	action = report_signal(tsk, regs, tsk->utrace, UTRACE_SIGNAL_HANDLER,
+			       UTRACE_EVENT_SIGNAL_ALL,
+			       UTRACE_ACTION_SINGLESTEP|UTRACE_ACTION_BLOCKSTEP,
+			       NULL, NULL, NULL);
+	action = check_detach(tsk, action);
+	check_quiescent(tsk, action);
+}
+
+
+/*
+ * This is the hook from the signals code, called with the siglock held.
+ * Here is the ideal place to quiesce.  We also dequeue and intercept signals.
+ */
+int
+utrace_get_signal(struct task_struct *tsk, struct pt_regs *regs,
+		  siginfo_t *info, struct k_sigaction *return_ka)
+{
+	struct utrace *utrace = tsk->utrace;
+	struct utrace_signal signal = { info, return_ka, 0 };
+	struct k_sigaction *ka;
+	unsigned long action, event;
+
+#if 0				/* XXX */
+	if (tsk->signal->flags & SIGNAL_GROUP_SIGKILL)
+		return 0;
+#endif
+
+	/*
+	 * If we should quiesce, now is the time.
+	 * First stash a pointer to the state on our stack,
+	 * so that utrace_inject_signal can tell us what to do.
+	 */
+	if (utrace->u.live.signal == NULL)
+		utrace->u.live.signal = &signal;
+
+	if (tsk->utrace_flags & UTRACE_ACTION_QUIESCE) {
+		spin_unlock_irq(&tsk->sighand->siglock);
+		utrace_quiescent(tsk);
+		if (utrace->u.live.signal != &signal || signal.signr == 0)
+			/*
+			 * This return value says to reacquire the siglock
+			 * and check again.  This will check for a pending
+			 * group stop and process it before coming back here.
+			 */
+			return -1;
+		spin_lock_irq(&tsk->sighand->siglock);
+	}
+
+	/*
+	 * If a signal was injected previously, it could not use our
+	 * stack space directly.  It had to allocate a data structure,
+	 * which we can now copy out of and free.
+	 */
+	if (utrace->u.live.signal != &signal) {
+		signal.signr = utrace->u.live.signal->signr;
+		copy_siginfo(info, utrace->u.live.signal->info);
+		if (utrace->u.live.signal->return_ka)
+			*return_ka = *utrace->u.live.signal->return_ka;
+		else
+			signal.return_ka = NULL;
+		kfree(utrace->u.live.signal);
+	}
+	utrace->u.live.signal = NULL;
+
+	/*
+	 * If a signal was injected, everything is in place now.  Go do it.
+	 */
+	if (signal.signr != 0) {
+		if (signal.return_ka == NULL) {
+			ka = &tsk->sighand->action[signal.signr - 1];
+			if (ka->sa.sa_flags & SA_ONESHOT)
+				ka->sa.sa_handler = SIG_DFL;
+			*return_ka = *ka;
+		}
+		else
+			BUG_ON(signal.return_ka != return_ka);
+		return signal.signr;
+	}
+
+	/*
+	 * If noone is interested in intercepting signals, let the caller
+	 * just dequeue them normally.
+	 */
+	if ((tsk->utrace_flags & UTRACE_EVENT_SIGNAL_ALL) == 0)
+		return 0;
+
+	/*
+	 * Steal the next signal so we can let tracing engines examine it.
+	 * From the signal number and sigaction, determine what normal
+	 * delivery would do.  If no engine perturbs it, we'll do that
+	 * by returning the signal number after setting *return_ka.
+	 */
+	signal.signr = dequeue_signal(tsk, &tsk->blocked, info);
+	if (signal.signr == 0)
+		return 0;
+
+	BUG_ON(signal.signr != info->si_signo);
+
+	ka = &tsk->sighand->action[signal.signr - 1];
+	*return_ka = *ka;
+
+	if (ka->sa.sa_handler == SIG_IGN) {
+		event = UTRACE_EVENT(SIGNAL_IGN);
+		action = UTRACE_SIGNAL_IGN;
+	}
+	else if (ka->sa.sa_handler != SIG_DFL) {
+		event = UTRACE_EVENT(SIGNAL);
+		action = UTRACE_ACTION_RESUME;
+	}
+	else if (sig_kernel_coredump(signal.signr)) {
+		event = UTRACE_EVENT(SIGNAL_CORE);
+		action = UTRACE_SIGNAL_CORE;
+	}
+	else if (sig_kernel_ignore(signal.signr)) {
+		event = UTRACE_EVENT(SIGNAL_IGN);
+		action = UTRACE_SIGNAL_IGN;
+	}
+	else if (sig_kernel_stop(signal.signr)) {
+		event = UTRACE_EVENT(SIGNAL_STOP);
+		action = (signal.signr == SIGSTOP
+			  ? UTRACE_SIGNAL_STOP : UTRACE_SIGNAL_TSTP);
+	}
+	else {
+		event = UTRACE_EVENT(SIGNAL_TERM);
+		action = UTRACE_SIGNAL_TERM;
+	}
+
+	if (tsk->utrace_flags & event) {
+		/*
+		 * We have some interested engines, so tell them about the
+		 * signal and let them change its disposition.
+		 */
+
+		spin_unlock_irq(&tsk->sighand->siglock);
+
+		action = report_signal(tsk, regs, utrace, action, event, event,
+				       info, ka, return_ka);
+		action &= UTRACE_ACTION_OP_MASK;
+
+		if (action & UTRACE_SIGNAL_HOLD) {
+			struct sigqueue *q = sigqueue_alloc();
+			if (likely(q != NULL)) {
+				q->flags = 0;
+				copy_siginfo(&q->info, info);
+			}
+			action &= ~UTRACE_SIGNAL_HOLD;
+			spin_lock_irq(&tsk->sighand->siglock);
+			sigaddset(&tsk->pending.signal, info->si_signo);
+			if (likely(q != NULL))
+				list_add(&q->list, &tsk->pending.list);
+		}
+		else
+			spin_lock_irq(&tsk->sighand->siglock);
+
+		recalc_sigpending_tsk(tsk);
+	}
+
+	/*
+	 * We express the chosen action to the signals code in terms
+	 * of a representative signal whose default action does it.
+	 */
+	switch (action) {
+	case UTRACE_SIGNAL_IGN:
+		/*
+		 * We've eaten the signal.  That's all we do.
+		 * Tell the caller to restart.
+		 */
+		spin_unlock_irq(&tsk->sighand->siglock);
+		return -1;
+
+	case UTRACE_ACTION_RESUME:
+	case UTRACE_SIGNAL_DELIVER:
+		/*
+		 * The handler will run.  We do the SA_ONESHOT work here
+		 * since the normal path will only touch *return_ka now.
+		 */
+		if (return_ka->sa.sa_flags & SA_ONESHOT)
+			ka->sa.sa_handler = SIG_DFL;
+		break;
+
+	case UTRACE_SIGNAL_TSTP:
+		signal.signr = SIGTSTP;
+		tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
+		return_ka->sa.sa_handler = SIG_DFL;
+		break;
+
+	case UTRACE_SIGNAL_STOP:
+		signal.signr = SIGSTOP;
+		tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
+		return_ka->sa.sa_handler = SIG_DFL;
+		break;
+
+	case UTRACE_SIGNAL_TERM:
+		signal.signr = SIGTERM;
+		return_ka->sa.sa_handler = SIG_DFL;
+		break;
+
+	case UTRACE_SIGNAL_CORE:
+		signal.signr = SIGQUIT;
+		return_ka->sa.sa_handler = SIG_DFL;
+		break;
+
+	default:
+		BUG();
+	}
+
+	return signal.signr;
+}
+
+
+/*
+ * Cause a specified signal delivery in the target thread,
+ * which must be quiescent.  The action has UTRACE_SIGNAL_* bits
+ * as returned from a report_signal callback.  If ka is non-null,
+ * it gives the sigaction to follow for UTRACE_SIGNAL_DELIVER;
+ * otherwise, the installed sigaction at the time of delivery is used.
+ */
+int
+utrace_inject_signal(struct task_struct *target,
+		    struct utrace_attached_engine *engine,
+		    u32 action, siginfo_t *info,
+		    const struct k_sigaction *ka)
+{
+	struct utrace *utrace;
+	struct utrace_signal *signal;
+	int ret;
+
+	if (info->si_signo == 0 || !valid_signal(info->si_signo))
+		return -EINVAL;
+
+	rcu_read_lock();
+	utrace = rcu_dereference(target->utrace);
+	if (utrace == NULL) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+	utrace_lock(utrace);
+	rcu_read_unlock();
+
+	ret = 0;
+	signal = utrace->u.live.signal;
+	if (signal == NULL) {
+		ret = -ENOSYS;	/* XXX */
+	}
+	else if (signal->signr != 0)
+		ret = -EAGAIN;
+	else {
+		if (info != signal->info)
+			copy_siginfo(signal->info, info);
+
+		switch (action) {
+		default:
+			ret = -EINVAL;
+			break;
+
+		case UTRACE_SIGNAL_IGN:
+			break;
+
+		case UTRACE_ACTION_RESUME:
+		case UTRACE_SIGNAL_DELIVER:
+			/*
+			 * The handler will run.  We do the SA_ONESHOT work
+			 * here since the normal path will not touch the
+			 * real sigaction when using an injected signal.
+			 */
+			if (ka == NULL)
+				signal->return_ka = NULL;
+			else if (ka != signal->return_ka)
+				*signal->return_ka = *ka;
+			if (ka && ka->sa.sa_flags & SA_ONESHOT) {
+				struct k_sigaction *a;
+				a = &target->sighand->action[info->si_signo-1];
+				spin_lock_irq(&target->sighand->siglock);
+				a->sa.sa_handler = SIG_DFL;
+				spin_unlock_irq(&target->sighand->siglock);
+			}
+			signal->signr = info->si_signo;
+			break;
+
+		case UTRACE_SIGNAL_TSTP:
+			signal->signr = SIGTSTP;
+			spin_lock_irq(&target->sighand->siglock);
+			target->signal->flags |= SIGNAL_STOP_DEQUEUED;
+			spin_unlock_irq(&target->sighand->siglock);
+			signal->return_ka->sa.sa_handler = SIG_DFL;
+			break;
+
+		case UTRACE_SIGNAL_STOP:
+			signal->signr = SIGSTOP;
+			spin_lock_irq(&target->sighand->siglock);
+			target->signal->flags |= SIGNAL_STOP_DEQUEUED;
+			spin_unlock_irq(&target->sighand->siglock);
+			signal->return_ka->sa.sa_handler = SIG_DFL;
+			break;
+
+		case UTRACE_SIGNAL_TERM:
+			signal->signr = SIGTERM;
+			signal->return_ka->sa.sa_handler = SIG_DFL;
+			break;
+
+		case UTRACE_SIGNAL_CORE:
+			signal->signr = SIGQUIT;
+			signal->return_ka->sa.sa_handler = SIG_DFL;
+			break;
+		}
+	}
+
+	utrace_unlock(utrace);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(utrace_inject_signal);
+
+
+const struct utrace_regset *
+utrace_regset(struct task_struct *target,
+	      struct utrace_attached_engine *engine,
+	      const struct utrace_regset_view *view, int which)
+{
+	if (unlikely((unsigned) which >= view->n))
+		return NULL;
+
+	if (target != current)
+		wait_task_inactive(target);
+
+	return &view->regsets[which];
+}
+EXPORT_SYMBOL_GPL(utrace_regset);
+
+
+/*
+ * Return the value to display after "TracerPid:" in /proc/PID/status.
+ * Called without locks.
+ */
+pid_t
+utrace_tracer_pid(struct task_struct *target)
+{
+	struct utrace *utrace;
+	pid_t pid = 0;
+
+	rcu_read_lock();
+	utrace = rcu_dereference(target->utrace);
+	if (utrace != NULL) {
+		struct list_head *pos, *next;
+		struct utrace_attached_engine *engine;
+		const struct utrace_engine_ops *ops;
+		list_for_each_safe_rcu(pos, next, &utrace->engines) {
+			engine = list_entry(pos, struct utrace_attached_engine,
+					    entry);
+			ops = rcu_dereference(engine->ops);
+			if (ops->tracer_pid) {
+				pid = (*ops->tracer_pid)(engine, target);
+				if (pid)
+					break;
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	return pid;
+}
+
+int
+utrace_allow_access_process_vm(struct task_struct *target)
+{
+	struct utrace *utrace;
+	int ret = 0;
+
+	rcu_read_lock();
+	utrace = rcu_dereference(target->utrace);
+	if (utrace != NULL) {
+		struct list_head *pos, *next;
+		struct utrace_attached_engine *engine;
+		const struct utrace_engine_ops *ops;
+		list_for_each_safe_rcu(pos, next, &utrace->engines) {
+			engine = list_entry(pos, struct utrace_attached_engine,
+					    entry);
+			ops = rcu_dereference(engine->ops);
+			if (ops->allow_access_process_vm) {
+				ret = (*ops->allow_access_process_vm)(engine,
+								      target,
+								      current);
+				if (ret)
+					break;
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
