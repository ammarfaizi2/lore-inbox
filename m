Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbUCWU4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 15:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbUCWU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 15:56:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10686 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262827AbUCWUzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 15:55:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16480.42052.58724.753984@neuro.alephnull.com>
Date: Tue, 23 Mar 2004 15:55:32 -0500
From: Rik Faith <faith@redhat.com>
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Light-weight Auditing Framework
In-Reply-To: [Paul E. McKenney <paulmck@us.ibm.com>] Wed 17 Mar 2004 16:45:02 -0800
References: <16464.30442.852919.24605@neuro.alephnull.com>
	<20040312185033.GA2507@us.ibm.com>
	<16472.5852.375648.739489@neuro.alephnull.com>
	<20040318004502.GA2595@us.ibm.com>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17 Mar 2004 16:45:02 -0800,
   Paul E. McKenney <paulmck@us.ibm.com> wrote:
> On Wed, Mar 17, 2004 at 04:14:04AM -0500, Rik Faith wrote:
> > On Fri 12 Mar 2004 10:50:33 -0800,
> >    Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > > o	I don't see any rcu_read_lock() or rcu_read_unlock() calls.
> > 
> > Fixed.
> 
> Much improved!
> 
> Since audit_receive_filter() is only called with audit_netlink_sem
> held, it cannot race with either audit_del_rule() or audit_add_rule(),
> so the list_for_each_entry_rcu()s may be replaced by
> list_for_each_entry()s, and the rcu_read_{un,}lock()s removed.
> 
> Not a fatal problem, just a bit of unnecessary overhead.

A fix for this is part of the attached patch.

Other features of the attached patch are:
    1) generalized the ability to test for inequality
    2) added syscall exit status reporting and testing
    3) added ability to report and test first 4 syscall arguments
       (this adds a large amount of flexibility for little cost;
       not implemented or tested on ppc64)
    4) added ability to report and test personality

User-space demo program enhanced for new fields and inequality testing:
http://people.redhat.com/faith/audit/auditd-0.5.tar.gz


This patch is against 2.6.5-rc2, but also applies against 2.6.5-rc2-mm1.

 arch/i386/kernel/ptrace.c   |    5 -
 arch/ppc64/kernel/ptrace.c  |    6 +
 arch/x86_64/kernel/ptrace.c |   11 +-
 include/linux/audit.h       |   19 +++-
 kernel/auditsc.c            |  170 ++++++++++++++++++++++++++------------------
 5 files changed, 126 insertions(+), 85 deletions(-)


diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/i386/kernel/ptrace.c linux-2.6.4/arch/i386/kernel/ptrace.c
--- linux-2.6.4-pristine/arch/i386/kernel/ptrace.c	2004-03-23 15:08:10.000000000 -0500
+++ linux-2.6.4/arch/i386/kernel/ptrace.c	2004-03-23 15:37:41.000000000 -0500
@@ -528,9 +528,10 @@ void do_syscall_trace(struct pt_regs *re
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
-					    regs->ebx);
+					    regs->ebx, regs->ecx,
+					    regs->edx, regs->esi);
 		else
-			audit_syscall_exit(current);
+			audit_syscall_exit(current, regs->eax);
 	}
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/ppc64/kernel/ptrace.c linux-2.6.4/arch/ppc64/kernel/ptrace.c
--- linux-2.6.4-pristine/arch/ppc64/kernel/ptrace.c	2004-03-23 15:08:10.000000000 -0500
+++ linux-2.6.4/arch/ppc64/kernel/ptrace.c	2004-03-23 15:37:38.000000000 -0500
@@ -308,7 +308,9 @@ static void do_syscall_trace(void)
 void do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (unlikely(current->audit_context))
-		audit_syscall_entry(current, regs->gpr[0], regs->gpr[3]);
+		audit_syscall_entry(current, regs->gpr[0],
+				    regs->gpr[3], regs->gpr[4],
+				    regs->gpr[5], regs->gpr[6]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
@@ -318,7 +320,7 @@ void do_syscall_trace_enter(struct pt_re
 void do_syscall_trace_leave(void)
 {
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current);
+		audit_syscall_exit(current, 0);	/* FIXME: pass pt_regs */
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/x86_64/kernel/ptrace.c linux-2.6.4/arch/x86_64/kernel/ptrace.c
--- linux-2.6.4-pristine/arch/x86_64/kernel/ptrace.c	2004-03-23 15:08:10.000000000 -0500
+++ linux-2.6.4/arch/x86_64/kernel/ptrace.c	2004-03-23 15:37:42.000000000 -0500
@@ -497,11 +497,6 @@ static void syscall_trace(struct pt_regs
 	       current_thread_info()->flags, current->ptrace); 
 #endif
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return; 
-	if (!(current->ptrace & PT_PTRACED))
-		return;
-	
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
 				? 0x80 : 0));
 	/*
@@ -518,7 +513,9 @@ static void syscall_trace(struct pt_regs
 asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 {
 	if (unlikely(current->audit_context))
-		audit_syscall_entry(current, regs->orig_rax, regs->rdi);
+		audit_syscall_entry(current, regs->orig_rax,
+				    regs->rdi, regs->rsi,
+				    regs->rdx, regs->r10);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
@@ -528,7 +525,7 @@ asmlinkage void syscall_trace_enter(stru
 asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 {
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current);
+		audit_syscall_exit(current, regs->rax);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/linux/audit.h linux-2.6.4/include/linux/audit.h
--- linux-2.6.4-pristine/include/linux/audit.h	2004-03-23 15:08:10.000000000 -0500
+++ linux-2.6.4/include/linux/audit.h	2004-03-23 15:09:58.000000000 -0500
@@ -66,6 +66,7 @@
 #define AUDIT_SGID	7
 #define AUDIT_FSGID	8
 #define AUDIT_LOGINUID	9
+#define AUDIT_PERS	10
 
 				/* These are ONLY useful when checking
 				 * at syscall exit time (AUDIT_AT_EXIT). */
@@ -73,7 +74,14 @@
 #define AUDIT_DEVMINOR	101
 #define AUDIT_INODE	102
 #define AUDIT_EXIT	103
-#define AUDIT_NOTEXIT	104
+#define AUDIT_SUCCESS   104	/* exit >= 0; value ignored */
+
+#define AUDIT_ARG0      200
+#define AUDIT_ARG1      (AUDIT_ARG0+1)
+#define AUDIT_ARG2      (AUDIT_ARG0+2)
+#define AUDIT_ARG3      (AUDIT_ARG0+3)
+
+#define AUDIT_NEGATE    0x80000000
 
 
 /* Status symbols */
@@ -134,8 +142,9 @@ struct audit_context;
 extern int  audit_alloc(struct task_struct *task);
 extern void audit_free(struct task_struct *task);
 extern void audit_syscall_entry(struct task_struct *task,
-				int major, int minor);
-extern void audit_syscall_exit(struct task_struct *task);
+				int major, unsigned long a0, unsigned long a1,
+				unsigned long a2, unsigned long a3);
+extern void audit_syscall_exit(struct task_struct *task, int return_code);
 extern void audit_getname(const char *name);
 extern void audit_putname(const char *name);
 extern void audit_inode(const char *name, unsigned long ino, dev_t rdev);
@@ -149,8 +158,8 @@ extern int  audit_set_loginuid(struct au
 #else
 #define audit_alloc(t) ({ 0; })
 #define audit_free(t) do { ; } while (0)
-#define audit_syscall_entry(t,a,b) do { ; } while (0)
-#define audit_syscall_exit(t) do { ; } while (0)
+#define audit_syscall_entry(t,a,b,c,d,e) do { ; } while (0)
+#define audit_syscall_exit(t,r) do { ; } while (0)
 #define audit_getname(n) do { ; } while (0)
 #define audit_putname(n) do { ; } while (0)
 #define audit_inode(n,i,d) do { ; } while (0)
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/kernel/auditsc.c linux-2.6.4/kernel/auditsc.c
--- linux-2.6.4-pristine/kernel/auditsc.c	2004-03-23 15:08:10.000000000 -0500
+++ linux-2.6.4/kernel/auditsc.c	2004-03-23 15:38:48.000000000 -0500
@@ -99,7 +99,9 @@ struct audit_context {
 	struct timespec	    ctime;      /* time of syscall entry */
 	uid_t		    loginuid;   /* login uid (identity) */
 	int		    major;      /* syscall number */
-	int		    minor;      /* function for multiplex syscalls */
+	unsigned long	    argv[4];    /* syscall arguments */
+	int		    return_valid; /* return code is valid */
+	int		    return_code;/* syscall return code */
 	int		    auditable;  /* 1 if record should be written */
 	int		    name_count;
 	struct audit_names  names[AUDIT_NAMES];
@@ -109,6 +111,7 @@ struct audit_context {
 	pid_t		    pid;
 	uid_t		    uid, euid, suid, fsuid;
 	gid_t		    gid, egid, sgid, fsgid;
+	unsigned long	    personality;
 
 #if AUDIT_DEBUG
 	int		    put_count;
@@ -231,17 +234,17 @@ int audit_receive_filter(int type, int p
 
 	switch (type) {
 	case AUDIT_LIST:
-		rcu_read_lock();
-		list_for_each_entry_rcu(entry, &audit_tsklist, list)
+		/* The *_rcu iterators not needed here because we are
+		   always called with audit_netlink_sem held. */ 
+		list_for_each_entry(entry, &audit_tsklist, list)
 			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
 					 &entry->rule, sizeof(entry->rule));
-		list_for_each_entry_rcu(entry, &audit_entlist, list)
+		list_for_each_entry(entry, &audit_entlist, list)
 			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
 					 &entry->rule, sizeof(entry->rule));
-		list_for_each_entry_rcu(entry, &audit_extlist, list)
+		list_for_each_entry(entry, &audit_extlist, list)
 			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
 					 &entry->rule, sizeof(entry->rule));
-		rcu_read_unlock();
 		audit_send_reply(pid, seq, AUDIT_LIST, 1, 1, NULL, 0);
 		break;
 	case AUDIT_ADD:
@@ -286,94 +289,100 @@ static int audit_filter_rules(struct tas
 			      enum audit_state *state)
 {
 	int i, j;
-	int found;
 
 	for (i = 0; i < rule->field_count; i++) {
-		u32 value = rule->values[i];
+		u32 field  = rule->fields[i] & ~AUDIT_NEGATE;
+		u32 value  = rule->values[i];
+		int result = 0;
 
-		switch (rule->fields[i]) {
+		switch (field) {
 		case AUDIT_PID:
-			if (tsk->pid   != value)
-				return 0;
+			result = (tsk->pid == value);
 			break;
 		case AUDIT_UID:
-			if (tsk->uid   != value)
-				return 0;
+			result = (tsk->uid == value);
 			break;
 		case AUDIT_EUID:
-			if (tsk->euid  != value)
-				return 0;
+			result = (tsk->euid == value);
 			break;
 		case AUDIT_SUID:
-			if (tsk->suid  != value)
-				return 0;
+			result = (tsk->suid == value);
 			break;
 		case AUDIT_FSUID:
-			if (tsk->fsuid != value)
-				return 0;
+			result = (tsk->fsuid == value);
 			break;
 		case AUDIT_GID:
-			if (tsk->gid   != value)
-				return 0;
+			result = (tsk->gid == value);
 			break;
 		case AUDIT_EGID:
-			if (tsk->egid  != value)
-				return 0;
+			result = (tsk->egid == value);
 			break;
 		case AUDIT_SGID:
-			if (tsk->sgid  != value)
-				return 0;
+			result = (tsk->sgid == value);
 			break;
 		case AUDIT_FSGID:
-			if (tsk->fsgid != value)
-				return 0;
+			result = (tsk->fsgid == value);
 			break;
+		case AUDIT_PERS:
+			result = (tsk->personality == value);
+			break;
+
 		case AUDIT_EXIT:
-			if (tsk->exit_code!=value)
-				return 0;
+			if (ctx && ctx->return_valid)
+				result = (ctx->return_code == value);
 			break;
-		case AUDIT_NOTEXIT:
-			if (tsk->exit_code==value)
-				return 0;
+		case AUDIT_SUCCESS:
+			if (ctx && ctx->return_valid)
+				result = (ctx->return_code >= 0);
 			break;
 		case AUDIT_DEVMAJOR:
-			if (!ctx)
-				return 0;
-			found = 0;
-			for (j = 0; !found && j < ctx->name_count; j++) {
-				if (MAJOR(ctx->names[j].rdev) == value)
-					++found;
+			if (ctx) {
+				for (j = 0; j < ctx->name_count; j++) {
+					if (MAJOR(ctx->names[j].rdev)==value) {
+						++result;
+						break;
+					}
+				}
 			}
-			if (!found)
-				return 0;
 			break;
 		case AUDIT_DEVMINOR:
-			if (!ctx)
-				return 0;
-			found = 0;
-			for (j = 0; !found && j < ctx->name_count; j++) {
-				if (MINOR(ctx->names[j].rdev) == value)
-					++found;
+			if (ctx) {
+				for (j = 0; j < ctx->name_count; j++) {
+					if (MINOR(ctx->names[j].rdev)==value) {
+						++result;
+						break;
+					}
+				}
 			}
-			if (!found)
-				return 0;
 			break;
 		case AUDIT_INODE:
-			if (!ctx)
-				return 0;
-			found = 0;
-			for (j = 0; !found && j < ctx->name_count; j++) {
-				if (ctx->names[j].ino == value)
-					++found;
+			if (ctx) {
+				for (j = 0; j < ctx->name_count; j++) {
+					if (MINOR(ctx->names[j].ino)==value) {
+						++result;
+						break;
+					}
+				}
 			}
-			if (!found)
-				return 0;
 			break;
 		case AUDIT_LOGINUID:
-			if (!ctx || ctx->loginuid != value)
-				return 0;
+			result = 0;
+			if (ctx)
+				result = (ctx->loginuid == value);
+			break;
+		case AUDIT_ARG0:
+		case AUDIT_ARG1:
+		case AUDIT_ARG2:
+		case AUDIT_ARG3:
+			if (ctx)
+				result = (ctx->argv[field-AUDIT_ARG0]==value);
 			break;
 		}
+
+		if (rule->fields[i] & AUDIT_NEGATE)
+			result = !result;
+		if (!result)
+			return 0;
 	}
 	switch (rule->action) {
 	case AUDIT_NEVER:    *state = AUDIT_DISABLED;	    break;
@@ -430,12 +439,17 @@ static enum audit_state audit_filter_sys
 }
 
 /* This should be called with task_lock() held. */
-static inline struct audit_context *audit_get_context(struct task_struct *tsk)
+static inline struct audit_context *audit_get_context(struct task_struct *tsk,
+						      int return_valid,
+						      int return_code)
 {
 	struct audit_context *context = tsk->audit_context;
 
 	if (likely(!context))
 		return NULL;
+	context->return_valid = return_valid;
+	context->return_code  = return_code;
+
 	if (context->in_syscall && !context->auditable) {
 		enum audit_state state;
 		state = audit_filter_syscall(tsk, context, &audit_extlist);
@@ -452,6 +466,7 @@ static inline struct audit_context *audi
 	context->egid = tsk->egid;
 	context->sgid = tsk->sgid;
 	context->fsgid = tsk->fsgid;
+	context->personality = tsk->personality;
 	tsk->audit_context = NULL;
 	return context;
 }
@@ -565,14 +580,25 @@ static inline void audit_free_context(st
 static void audit_log_exit(struct audit_context *context)
 {
 	int i;
+	struct audit_buffer *ab;
 
-	audit_log(context,
-		  "syscall=%d,0x%x items=%d"
+	ab = audit_log_start(context);
+	if (!ab)
+		return;		/* audit_panic has been called */
+	audit_log_format(ab, "syscall=%d", context->major);
+	if (context->personality != PER_LINUX)
+		audit_log_format(ab, " per=%lx", context->personality);
+	if (context->return_valid)
+		audit_log_format(ab, " exit=%u", context->return_code);
+	audit_log_format(ab,
+		  " a0=%lx a1=%lx a2=%lx a3=%lx items=%d"
 		  " pid=%d loginuid=%d uid=%d gid=%d"
 		  " euid=%d suid=%d fsuid=%d"
 		  " egid=%d sgid=%d fsgid=%d",
-		  context->major,
-		  context->minor,
+		  context->argv[0],
+		  context->argv[1],
+		  context->argv[2],
+		  context->argv[3],
 		  context->name_count,
 		  context->pid,
 		  context->loginuid,
@@ -580,8 +606,9 @@ static void audit_log_exit(struct audit_
 		  context->gid,
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid);
+	audit_log_end(ab);
 	for (i = 0; i < context->name_count; i++) {
-		struct audit_buffer  *ab = audit_log_start(context);
+		ab = audit_log_start(context);
 		if (!ab)
 			continue; /* audit_panic has been called */
 		audit_log_format(ab, "item=%d", i);
@@ -608,7 +635,7 @@ void audit_free(struct task_struct *tsk)
 	struct audit_context *context;
 
 	task_lock(tsk);
-	context = audit_get_context(tsk);
+	context = audit_get_context(tsk, 0, 0);
 	task_unlock(tsk);
 
 	if (likely(!context))
@@ -659,7 +686,9 @@ static inline unsigned int audit_serial(
  * then the record will be written at syscall exit time (otherwise, it
  * will only be written if another part of the kernel requests that it
  * be written). */
-void audit_syscall_entry(struct task_struct *tsk, int major, int minor)
+void audit_syscall_entry(struct task_struct *tsk, int major,
+			 unsigned long a1, unsigned long a2,
+			 unsigned long a3, unsigned long a4)
 {
 	struct audit_context *context = tsk->audit_context;
 	enum audit_state     state;
@@ -712,7 +741,10 @@ void audit_syscall_entry(struct task_str
 		return;
 
 	context->major      = major;
-	context->minor      = minor; /* Only valid for some calls */
+	context->argv[0]    = a1;
+	context->argv[1]    = a2;
+	context->argv[2]    = a3;
+	context->argv[3]    = a4;
 
 	state = context->state;
 	if (state == AUDIT_SETUP_CONTEXT || state == AUDIT_BUILD_CONTEXT)
@@ -731,13 +763,13 @@ void audit_syscall_entry(struct task_str
  * filtering, or because some other part of the kernel write an audit
  * message), then write out the syscall information.  In call cases,
  * free the names stored from getname(). */
-void audit_syscall_exit(struct task_struct *tsk)
+void audit_syscall_exit(struct task_struct *tsk, int return_code)
 {
 	struct audit_context *context;
 
 	get_task_struct(tsk);
 	task_lock(tsk);
-	context = audit_get_context(tsk);
+	context = audit_get_context(tsk, 1, return_code);
 	task_unlock(tsk);
 
 	/* Not having a context here is ok, since the parent may have


