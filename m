Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVL1W55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVL1W55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 17:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVL1W54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 17:57:56 -0500
Received: from ns1.siteground.net ([207.218.208.2]:37301 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932546AbVL1W54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 17:57:56 -0500
Date: Wed, 28 Dec 2005 14:57:52 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20051228225752.GB3755@localhost.localdomain>
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228183345.GA3755@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 10:33:45AM -0800, Ravikiran G Thirumalai wrote:
> On Wed, Dec 28, 2005 at 03:38:39PM +0300, Oleg Nesterov wrote:
> > Christoph Lameter wrote:
> > > 
> > > On Sat, 24 Dec 2005, Oleg Nesterov wrote:
> > > 
> > > > I can't understand this. 'p' can do clone(CLONE_THREAD) immediately
> > > > after 'if (!thread_group_empty(p))' check.
> > > 
> > > Only if p != current. As discussed later the lockless approach is
> > > intened to only be used if p == current.
> > 
> > Unless I missed something this function (getrusage_both) is called
> > from wait_noreap_copyout,
> 
> Hi Oleg,
> Yes, this patch needs to be reworked.  I am on it.  I'd also missed that
> p->signal was protected by the tasklist_lock.  Thanks for pointing it out.
> I will put out the modified version soon.

Oleg, Here's the reworked patch.  
Comments?

It would have been nice if we could avoid tasklist locking on the 
getrusage_both case.  Maybe we should explore using RCU here along with 
other patches from Paul McKenney.... 

Thanks,
Kiran

Following patch avoids taking the global tasklist_lock when possible,
if a process is single threaded during getrusage().  Any avoidance of
tasklist_lock is good for NUMA boxes (and possibly for large SMPs).

Signed-off-by: Nippun Goel <nippung@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: arch/mips/kernel/irixsig.c
===================================================================
--- arch/mips/kernel/irixsig.c.orig	2005-12-27 14:49:57.000000000 -0800
+++ arch/mips/kernel/irixsig.c	2005-12-27 14:52:47.000000000 -0800
@@ -540,7 +540,7 @@ out:
 #define IRIX_P_PGID   2
 #define IRIX_P_ALL    7
 
-extern int getrusage(struct task_struct *, int, struct rusage __user *);
+extern int getrusage_both(struct task_struct *, struct rusage __user *);
 
 #define W_EXITED     1
 #define W_TRAPPED    2
@@ -605,7 +605,7 @@ repeat:
 			remove_parent(p);
 			add_parent(p, p->parent);
 			write_unlock_irq(&tasklist_lock);
-			retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+			retval = ru ? getrusage_both(p, ru) : 0;
 			if (retval)
 				goto end_waitsys;
 
@@ -626,7 +626,7 @@ repeat:
 			current->signal->cutime += p->utime + p->signal->cutime;
 			current->signal->cstime += p->stime + p->signal->cstime;
 			if (ru != NULL)
-				getrusage(p, RUSAGE_BOTH, ru);
+				getrusage_both(p, ru);
 			retval = __put_user(SIGCHLD, &info->sig);
 			retval |= __put_user(1, &info->code);      /* CLD_EXITED */
 			retval |= __put_user(p->pid, &info->stuff.procinfo.pid);
Index: arch/mips/kernel/sysirix.c
===================================================================
--- arch/mips/kernel/sysirix.c.orig	2005-12-27 14:49:57.000000000 -0800
+++ arch/mips/kernel/sysirix.c	2005-12-27 14:52:47.000000000 -0800
@@ -234,7 +234,8 @@ asmlinkage int irix_prctl(unsigned optio
 #undef DEBUG_PROCGRPS
 
 extern unsigned long irix_mapelf(int fd, struct elf_phdr __user *user_phdrp, int cnt);
-extern int getrusage(struct task_struct *p, int who, struct rusage __user *ru);
+extern int getrusage_self(struct rusage __user *ru);
+extern int getrusage_children(struct rusage __user *ru);
 extern char *prom_getenv(char *name);
 extern long prom_setenv(char *name, char *value);
 
@@ -405,12 +406,12 @@ asmlinkage int irix_syssgi(struct pt_reg
 		switch((int) regs->regs[base + 5]) {
 		case 0:
 			/* rusage self */
-			retval = getrusage(current, RUSAGE_SELF, ru);
+			retval = getrusage_self(ru);
 			goto out;
 
 		case -1:
 			/* rusage children */
-			retval = getrusage(current, RUSAGE_CHILDREN, ru);
+			retval = getrusage_children(ru);
 			goto out;
 
 		default:
Index: kernel/exit.c
===================================================================
--- kernel/exit.c.orig	2005-12-27 14:49:57.000000000 -0800
+++ kernel/exit.c	2005-12-27 14:52:47.000000000 -0800
@@ -38,7 +38,7 @@
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
 
-int getrusage(struct task_struct *, int, struct rusage __user *);
+int getrusage_both(struct task_struct *, struct rusage __user *);
 
 static void exit_mm(struct task_struct * tsk);
 
@@ -994,7 +994,7 @@ static int wait_noreap_copyout(task_t *p
 			       struct siginfo __user *infop,
 			       struct rusage __user *rusagep)
 {
-	int retval = rusagep ? getrusage(p, RUSAGE_BOTH, rusagep) : 0;
+	int retval = rusagep ? getrusage_both(p, rusagep) : 0;
 	put_task_struct(p);
 	if (!retval)
 		retval = put_user(SIGCHLD, &infop->si_signo);
@@ -1111,7 +1111,7 @@ static int wait_task_zombie(task_t *p, i
 	 */
 	read_unlock(&tasklist_lock);
 
-	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+	retval = ru ? getrusage_both(p, ru) : 0;
 	status = (p->signal->flags & SIGNAL_GROUP_EXIT)
 		? p->signal->group_exit_code : p->exit_code;
 	if (!retval && stat_addr)
@@ -1260,7 +1260,7 @@ bail_ref:
 
 	write_unlock_irq(&tasklist_lock);
 
-	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+	retval = ru ? getrusage_both(p, ru) : 0;
 	if (!retval && stat_addr)
 		retval = put_user((exit_code << 8) | 0x7f, stat_addr);
 	if (!retval && infop)
@@ -1321,7 +1321,7 @@ static int wait_task_continued(task_t *p
 	read_unlock(&tasklist_lock);
 
 	if (!infop) {
-		retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+		retval = ru ? getrusage_both(p, ru) : 0;
 		put_task_struct(p);
 		if (!retval && stat_addr)
 			retval = put_user(0xffff, stat_addr);
Index: kernel/sys.c
===================================================================
--- kernel/sys.c.orig	2005-12-27 14:49:57.000000000 -0800
+++ kernel/sys.c	2005-12-28 14:14:05.000000000 -0800
@@ -1657,6 +1657,10 @@ asmlinkage long sys_setrlimit(unsigned i
 }
 
 /*
+ * getrusage routines:
+ * getrusage_self() and getrusage_children() always use current.
+ * getrusage_both() need not be for the current task.
+ *
  * It would make sense to put struct rusage in the task_struct,
  * except that would make the task_struct be *really big*.  After
  * task_struct gets moved into malloc'ed memory, it would
@@ -1664,94 +1668,190 @@ asmlinkage long sys_setrlimit(unsigned i
  * a lot simpler!  (Which we're not doing right now because we're not
  * measuring them yet).
  *
- * This expects to be called with tasklist_lock read-locked or better,
- * and the siglock not locked.  It may momentarily take the siglock.
- *
- * When sampling multiple threads for RUSAGE_SELF, under SMP we might have
- * races with threads incrementing their own counters.  But since word
- * reads are atomic, we either get new values or old values and we don't
- * care which for the sums.  We always take the siglock to protect reading
+ * In multi threaded scenario, we always take the siglock to protect reading
  * the c* fields from p->signal from races with exit.c updating those
  * fields when reaping, so a sample either gets all the additions of a
  * given child after it's reaped, or none so this sample is before reaping.
+ *
+ * getrusage_children -- locking:
+ * In multithreaded scenario, we need to take tasklist_lock for read
+ * to avoid races against another thread doing exec and changing/freeing
+ * signal_struct of the current task.  We need to take the sighand->siglock
+ * too as another thread could be reaping its children.  However, both locks
+ * can be avoided if we are a single threaded process, since we are current; 
+ * No one else can take our signal_struct away, and no one else can reap
+ * children to update our signal->c*  counters.
+ *
  */
-
-static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
+int getrusage_children(struct rusage __user *ru)
 {
-	struct task_struct *t;
 	unsigned long flags;
+	int lockflag = 0;
 	cputime_t utime, stime;
+	struct task_struct *p = current;
+	struct rusage r;
+	memset((char *) &r, 0, sizeof (r));
 
-	memset((char *) r, 0, sizeof *r);
+	if (!thread_group_empty(p)) {
+		read_lock(&tasklist_lock);
+		if (unlikely(!p->signal)) {
+			read_unlock(&tasklist_lock);
+			goto ret;
+		}
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		lockflag = 1;
+	}
+	
+	utime = p->signal->cutime;
+	stime = p->signal->cstime;
+	r.ru_nvcsw = p->signal->cnvcsw;
+	r.ru_nivcsw = p->signal->cnivcsw;
+	r.ru_minflt = p->signal->cmin_flt;
+	r.ru_majflt = p->signal->cmaj_flt;
+	if (lockflag) {
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		read_unlock(&tasklist_lock);
+	}
+	cputime_to_timeval(utime, &r.ru_utime);
+	cputime_to_timeval(stime, &r.ru_stime);
 
-	if (unlikely(!p->signal))
-		return;
+ret:
+	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+}
 
-	switch (who) {
-		case RUSAGE_CHILDREN:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			utime = p->signal->cutime;
-			stime = p->signal->cstime;
-			r->ru_nvcsw = p->signal->cnvcsw;
-			r->ru_nivcsw = p->signal->cnivcsw;
-			r->ru_minflt = p->signal->cmin_flt;
-			r->ru_majflt = p->signal->cmaj_flt;
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			cputime_to_timeval(utime, &r->ru_utime);
-			cputime_to_timeval(stime, &r->ru_stime);
-			break;
-		case RUSAGE_SELF:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			utime = stime = cputime_zero;
-			goto sum_group;
-		case RUSAGE_BOTH:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			utime = p->signal->cutime;
-			stime = p->signal->cstime;
-			r->ru_nvcsw = p->signal->cnvcsw;
-			r->ru_nivcsw = p->signal->cnivcsw;
-			r->ru_minflt = p->signal->cmin_flt;
-			r->ru_majflt = p->signal->cmaj_flt;
-		sum_group:
-			utime = cputime_add(utime, p->signal->utime);
-			stime = cputime_add(stime, p->signal->stime);
-			r->ru_nvcsw += p->signal->nvcsw;
-			r->ru_nivcsw += p->signal->nivcsw;
-			r->ru_minflt += p->signal->min_flt;
-			r->ru_majflt += p->signal->maj_flt;
-			t = p;
-			do {
-				utime = cputime_add(utime, t->utime);
-				stime = cputime_add(stime, t->stime);
-				r->ru_nvcsw += t->nvcsw;
-				r->ru_nivcsw += t->nivcsw;
-				r->ru_minflt += t->min_flt;
-				r->ru_majflt += t->maj_flt;
-				t = next_thread(t);
-			} while (t != p);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			cputime_to_timeval(utime, &r->ru_utime);
-			cputime_to_timeval(stime, &r->ru_stime);
-			break;
-		default:
-			BUG();
+/*
+ * getrusage_self:
+ * In multithreaded scenario, we need to take the tasklist_lock for read
+ * since we traverse the task TGID hash list.  However, we do not need to 
+ * take the siglock even for the multithreaded case,  as the signal fields, 
+ * which the siglock protects are only updated at __exit_signal  with
+ * tasklist_lock taken for write, which cannot happen as we have the read_lock
+ * on tasklist_lock.
+ * If we are single threaded, since we are current, we don't need to take
+ * the tasklist_lock or the siglock as no one else can race with the
+ * signal fields.
+ *
+ * When sampling multiple threads for getrusage_self(), under SMP we might have
+ * races with threads incrementing their own counters.  But since word
+ * reads are atomic, we either get new values or old values and we don't
+ * care which for the sums.
+ *
+ */
+int getrusage_self(struct rusage __user *ru)
+{
+	int lockflag = 0;
+	cputime_t utime, stime;
+	struct task_struct *t, *p = current;
+	struct rusage r;
+	memset((char *) &r, 0, sizeof (r));
+
+	if (!thread_group_empty(p)) {
+		read_lock(&tasklist_lock);
+		lockflag = 1;
 	}
+
+	if (unlikely(!p->signal)) {
+		if (lockflag)
+			read_unlock(&tasklist_lock);
+		goto ret;
+	}
+
+	utime = p->signal->utime;
+	stime = p->signal->stime;
+	r.ru_nvcsw = p->signal->nvcsw;
+	r.ru_nivcsw = p->signal->nivcsw;
+	r.ru_minflt = p->signal->min_flt;
+	r.ru_majflt = p->signal->maj_flt;
+	t = p;
+	do {
+		utime = cputime_add(utime, t->utime);
+		stime = cputime_add(stime, t->stime);
+		r.ru_nvcsw += t->nvcsw;
+		r.ru_nivcsw += t->nivcsw;
+		r.ru_minflt += t->min_flt;
+		r.ru_majflt += t->maj_flt;
+		t = next_thread(t);
+	} while (t != p);
+
+	if (lockflag)
+		read_unlock(&tasklist_lock);
+	cputime_to_timeval(utime, &r.ru_utime);
+	cputime_to_timeval(stime, &r.ru_stime);
+
+ret:
+	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
 
-int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
+/*
+ * getrusage_both:
+ * getrusage_both can be invoked for non current processes -- usually from
+ * wait_* routines, on the children. As even a single threaded process 
+ * we are waiting on can spawn another thread and exec, we cannot 
+ * avoid tasklist_lock for both single threaded and multithreaded cases.
+ * We also need to take the siglock to protect the c* fields of the 
+ * signal_struct for both single threaded and multi threaded case.
+ *
+ */
+int getrusage_both(struct task_struct *p, struct rusage __user *ru)
 {
+	unsigned long flags;
+	cputime_t utime, stime;
 	struct rusage r;
+	struct task_struct *t;
+	memset((char *) &r, 0, sizeof (r));
+
 	read_lock(&tasklist_lock);
-	k_getrusage(p, who, &r);
+	if (unlikely(!p->signal)) {
+		read_unlock(&tasklist_lock);
+		goto ret;
+	}
+
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	utime = p->signal->cutime;
+	stime = p->signal->cstime;
+	r.ru_nvcsw = p->signal->cnvcsw;
+	r.ru_nivcsw = p->signal->cnivcsw;
+	r.ru_minflt = p->signal->cmin_flt;
+	r.ru_majflt = p->signal->cmaj_flt;
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+
+	utime = cputime_add(utime, p->signal->utime);
+	stime = cputime_add(stime, p->signal->stime);
+	r.ru_nvcsw += p->signal->nvcsw;
+	r.ru_nivcsw += p->signal->nivcsw;
+	r.ru_minflt += p->signal->min_flt;
+	r.ru_majflt += p->signal->maj_flt;
+
+	t = p;
+	do {
+		utime = cputime_add(utime, t->utime);
+		stime = cputime_add(stime, t->stime);
+		r.ru_nvcsw += t->nvcsw;
+		r.ru_nivcsw += t->nivcsw;
+		r.ru_minflt += t->min_flt;
+		r.ru_majflt += t->maj_flt;
+		t = next_thread(t);
+	} while (t != p);
+
 	read_unlock(&tasklist_lock);
+	cputime_to_timeval(utime, &r.ru_utime);
+	cputime_to_timeval(stime, &r.ru_stime);
+
+ret:
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
 
 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
-	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
-		return -EINVAL;
-	return getrusage(current, who, ru);
+	switch (who) {
+		case RUSAGE_SELF:
+			return getrusage_self(ru);
+		case RUSAGE_CHILDREN:
+			return getrusage_children(ru);
+		default:
+			break;
+	}
+	return -EINVAL;
 }
 
 asmlinkage long sys_umask(int mask)
