Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbVLWXP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbVLWXP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbVLWXP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:15:58 -0500
Received: from ns1.siteground.net ([207.218.208.2]:17592 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1161128AbVLWXP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:15:57 -0500
Date: Fri, 23 Dec 2005 15:15:49 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       nippung@calsoftinc.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded process at getrusage()
Message-ID: <20051223231549.GA3848@localhost.localdomain>
References: <20051221182320.GA4514@localhost.localdomain> <Pine.LNX.4.62.0512211209300.2829@schroedinger.engr.sgi.com> <20051221211135.GB4514@localhost.localdomain> <Pine.LNX.4.62.0512211318070.3443@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512211318070.3443@schroedinger.engr.sgi.com>
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

On Wed, Dec 21, 2005 at 01:22:24PM -0800, Christoph Lameter wrote:
> On Wed, 21 Dec 2005, Ravikiran G Thirumalai wrote:
> 
> > We did look at that. Cases RUSAGE_CHILDREN and RUSAGE_SELF are always called by the 
> > current task, so we can avoid tasklist locking there.
> > getrusage for non-current tasks are always called with RUSAGE_BOTH.
> > We ensure we  always take the siglock for RUSAGE_BOTH case, so that the
> > p->signal* fields are protected and take the tasklist_lock only if we have 
> > to traverse the tasklist hashlist. Isn't this safe?
> 
> Sounds okay. But its complex in the way its is coded now and its easy to 
> assume that one can call getrusage with any parameter from inside the 
> kernel. Maybe we can have a couple of separate functions 
> 
> rusage_children()
> rusage_self()
> rusage_both()
> 
> ?
> 
> Only rusage_both would take a task_struct * parameter. The others would 
> only operate on current. Change all the locations that call getrusage with 
> RUSAGE_BOTH to call rusage_both().

Here is the modified patch.  Andrew, pleas apply.

---

Following patch avoids taking the global tasklist_lock when possible,
if a process is single threaded during getrusage().  Any avoidance of 
tasklist_lock is good for NUMA boxes (and possibly for large SMPs).  We found 
that this optimization reduces the runtime of a certain scientific application 
by half on a 16 cpu NUMA box.

This optimization is similar to the sys_times tasklist_lock optimization.

Change from prev post: Split getrusage to getrusage_self, getrusage_children
and getrusage_both.

Signed-off-by: Nippun Goel <nippung@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc6/arch/mips/kernel/irixsig.c
===================================================================
--- linux-2.6.15-rc6.orig/arch/mips/kernel/irixsig.c	2005-12-19 15:17:51.000000000 -0800
+++ linux-2.6.15-rc6/arch/mips/kernel/irixsig.c	2005-12-23 10:42:16.000000000 -0800
@@ -540,7 +540,7 @@
 #define IRIX_P_PGID   2
 #define IRIX_P_ALL    7
 
-extern int getrusage(struct task_struct *, int, struct rusage __user *);
+extern int getrusage_both(struct task_struct *, struct rusage __user *);
 
 #define W_EXITED     1
 #define W_TRAPPED    2
@@ -605,7 +605,7 @@
 			remove_parent(p);
 			add_parent(p, p->parent);
 			write_unlock_irq(&tasklist_lock);
-			retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+			retval = ru ? getrusage_both(p, ru) : 0;
 			if (retval)
 				goto end_waitsys;
 
@@ -626,7 +626,7 @@
 			current->signal->cutime += p->utime + p->signal->cutime;
 			current->signal->cstime += p->stime + p->signal->cstime;
 			if (ru != NULL)
-				getrusage(p, RUSAGE_BOTH, ru);
+				getrusage_both(p, ru);
 			retval = __put_user(SIGCHLD, &info->sig);
 			retval |= __put_user(1, &info->code);      /* CLD_EXITED */
 			retval |= __put_user(p->pid, &info->stuff.procinfo.pid);
Index: linux-2.6.15-rc6/arch/mips/kernel/sysirix.c
===================================================================
--- linux-2.6.15-rc6.orig/arch/mips/kernel/sysirix.c	2005-12-19 15:17:51.000000000 -0800
+++ linux-2.6.15-rc6/arch/mips/kernel/sysirix.c	2005-12-23 10:42:16.000000000 -0800
@@ -234,7 +234,8 @@
 #undef DEBUG_PROCGRPS
 
 extern unsigned long irix_mapelf(int fd, struct elf_phdr __user *user_phdrp, int cnt);
-extern int getrusage(struct task_struct *p, int who, struct rusage __user *ru);
+extern int getrusage_self(struct rusage __user *ru);
+extern int getrusage_children(struct rusage __user *ru);
 extern char *prom_getenv(char *name);
 extern long prom_setenv(char *name, char *value);
 
@@ -405,12 +406,12 @@
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
Index: linux-2.6.15-rc6/kernel/exit.c
===================================================================
--- linux-2.6.15-rc6.orig/kernel/exit.c	2005-12-19 15:17:55.000000000 -0800
+++ linux-2.6.15-rc6/kernel/exit.c	2005-12-23 10:42:16.000000000 -0800
@@ -38,7 +38,7 @@
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
 
-int getrusage(struct task_struct *, int, struct rusage __user *);
+int getrusage_both(struct task_struct *, struct rusage __user *);
 
 static void exit_mm(struct task_struct * tsk);
 
@@ -994,7 +994,7 @@
 			       struct siginfo __user *infop,
 			       struct rusage __user *rusagep)
 {
-	int retval = rusagep ? getrusage(p, RUSAGE_BOTH, rusagep) : 0;
+	int retval = rusagep ? getrusage_both(p, rusagep) : 0;
 	put_task_struct(p);
 	if (!retval)
 		retval = put_user(SIGCHLD, &infop->si_signo);
@@ -1111,7 +1111,7 @@
 	 */
 	read_unlock(&tasklist_lock);
 
-	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+	retval = ru ? getrusage_both(p, ru) : 0;
 	status = (p->signal->flags & SIGNAL_GROUP_EXIT)
 		? p->signal->group_exit_code : p->exit_code;
 	if (!retval && stat_addr)
@@ -1260,7 +1260,7 @@
 
 	write_unlock_irq(&tasklist_lock);
 
-	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+	retval = ru ? getrusage_both(p, ru) : 0;
 	if (!retval && stat_addr)
 		retval = put_user((exit_code << 8) | 0x7f, stat_addr);
 	if (!retval && infop)
@@ -1321,7 +1321,7 @@
 	read_unlock(&tasklist_lock);
 
 	if (!infop) {
-		retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+		retval = ru ? getrusage_both(p, ru) : 0;
 		put_task_struct(p);
 		if (!retval && stat_addr)
 			retval = put_user(0xffff, stat_addr);
Index: linux-2.6.15-rc6/kernel/sys.c
===================================================================
--- linux-2.6.15-rc6.orig/kernel/sys.c	2005-12-23 10:41:47.000000000 -0800
+++ linux-2.6.15-rc6/kernel/sys.c	2005-12-23 12:08:32.000000000 -0800
@@ -1657,6 +1657,10 @@
 }
 
 /*
+ * getrusage routines:
+ * getrusage_self() and getrusage_children() always use current.
+ * getrusage_both() need not be for the current task.
+ *
  * It would make sense to put struct rusage in the task_struct,
  * except that would make the task_struct be *really big*.  After
  * task_struct gets moved into malloc'ed memory, it would
@@ -1664,9 +1668,6 @@
  * a lot simpler!  (Which we're not doing right now because we're not
  * measuring them yet).
  *
- * This expects to be called with tasklist_lock read-locked or better,
- * and the siglock not locked.  It may momentarily take the siglock.
- *
  * When sampling multiple threads for RUSAGE_SELF, under SMP we might have
  * races with threads incrementing their own counters.  But since word
  * reads are atomic, we either get new values or old values and we don't
@@ -1674,84 +1675,166 @@
  * the c* fields from p->signal from races with exit.c updating those
  * fields when reaping, so a sample either gets all the additions of a
  * given child after it's reaped, or none so this sample is before reaping.
+ *
+ * Locking semantics for the following three functions:
+ * 
+ * If we have a multithreaded process, we need to take tasklist read lock
+ * for getrusage_self() and getrusage_both(). We don't need to take the
+ * tasklist lock for getrusage_children() and just the siglock should
+ * suffice there.
+ *
+ * If we are a single threaded process, we donot need to take the tasklist_lock
+ * for reading the non c* vars from struct signal.  However, we need to take
+ * siglock for the getrusage_both() case to access the c* fields from signal.
+ * getrusage_self() and getrusage_children() are for the current process,
+ * unlike getrusage_both(). So not taking siglock for SELF and CHILDREN
+ * cases is safe.
+ *
+ * In the multithreaded scenario, while we have the tasklist_lock held for
+ * read, the non c* p->signal field updates cannot take place as the
+ * __exit_signal thread is called with write lock taken on tasklist_lock.
+ * Reads on the p->signal c* fields however can race if a child is being reaped.
+ * we avoid the race by taking the siglock to read the c* fileds.
+ *
+ * Hence, tasklist lock for read is sufficient for getrusage_self()
  */
 
-static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
+int getrusage_children(struct rusage __user *ru)
 {
-	struct task_struct *t;
 	unsigned long flags;
+	int lockflag = 0;
 	cputime_t utime, stime;
-
-	memset((char *) r, 0, sizeof *r);
+	struct rusage r;
+	struct task_struct *p = current;
+	memset((char *) &r, 0, sizeof (r));
 
 	if (unlikely(!p->signal))
-		return;
+		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 
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
+	if (!thread_group_empty(p)) {
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
+	if (lockflag)
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	cputime_to_timeval(utime, &r.ru_utime);
+	cputime_to_timeval(stime, &r.ru_stime);
+
+	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+}
+
+int getrusage_self(struct rusage __user *ru)
+{
+	int lockflag = 0;
+	cputime_t utime, stime;
+	struct rusage r;
+	struct task_struct *t, *p = current;
+
+	memset((char *) &r, 0, sizeof (r));
+
+	if (unlikely(!p->signal))
+		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+	if (!thread_group_empty(p)) {
+		read_lock(&tasklist_lock);
+		lockflag = 1;
 	}
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
+	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
 
-int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
+
+int getrusage_both(struct task_struct *p, struct rusage __user *ru)
 {
+	unsigned long flags;
+	int lockflag = 0;
+	cputime_t utime, stime;
 	struct rusage r;
-	read_lock(&tasklist_lock);
-	k_getrusage(p, who, &r);
-	read_unlock(&tasklist_lock);
+	struct task_struct *t;
+	memset((char *) &r, 0, sizeof (r));
+
+	if (unlikely(!p->signal))
+		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+
+	if (!thread_group_empty(p)) {
+		read_lock(&tasklist_lock);
+		lockflag = 1;
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
+	if (lockflag)
+		read_unlock(&tasklist_lock);
+	cputime_to_timeval(utime, &r.ru_utime);
+	cputime_to_timeval(stime, &r.ru_stime);
+
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
