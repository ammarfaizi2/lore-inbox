Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWADXQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWADXQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWADXQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:16:00 -0500
Received: from ns1.siteground.net ([207.218.208.2]:36540 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751825AbWADXP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:15:58 -0500
Date: Wed, 4 Jan 2006 15:16:00 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20060104231600.GA3664@localhost.localdomain>
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B57515.967F53E3@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 08:57:41PM +0300, Oleg Nesterov wrote:
> > -	memset((char *) r, 0, sizeof *r);
> > +	if (!thread_group_empty(p)) {
> > +		read_lock(&tasklist_lock);
> > +		if (unlikely(!p->signal)) {
> > +			read_unlock(&tasklist_lock);
> > +			goto ret;
> 
> Is this possible? 'current' always has valid signal/sighand.
> Or better say, process can't call getrusage after exit_signal().

You are right, this check was unnecessary

> 
> > +		}
> > +		spin_lock_irqsave(&p->sighand->siglock, flags);
> > +		lockflag = 1;
> > +	}
> 
> What if another thread just exited? I think you need 'else smp_rmb()'.
> here. Otherwise cpu can read signal->c* out of order.

Yes, looks like we do.  We probably need to do the same at sys_times too...

> 
> >  }
> 
> Looks we can factor out some code.
> 
> Actually I dont't understand why can't we move the locking into
> k_getrusage,
> 
> k_getrusage()
> 
> 	lock_flag = (p == current && thread_group_empty(p));
> 	if (lockflag) {
> 		read_lock(&tasklist_lock);
> 		spin_lock_irqsave(&p->sighand->siglock, flags);
> 	}
> 
> 	and remove ->sighand locking under 'switch' statement.
> 
> Isn't this enough to solve perfomance problems?

Hmm, just that getrusage_self takes the siglock in the multi threaded
case which is not needed I think.  Howz this patch?


getrusage_tasklistlock_optimization-v4

Following patch avoids taking the global tasklist_lock when possible,
if a process is single threaded during getrusage().  Any avoidance of
tasklist_lock is good for NUMA boxes (and possibly for large SMPs).


Index: linux-2.6.15-rc6/kernel/sys.c
===================================================================
--- linux-2.6.15-rc6.orig/kernel/sys.c	2006-01-03 12:12:05.000000000 -0800
+++ linux-2.6.15-rc6/kernel/sys.c	2006-01-04 13:41:17.000000000 -0800
@@ -1664,9 +1664,6 @@ asmlinkage long sys_setrlimit(unsigned i
  * a lot simpler!  (Which we're not doing right now because we're not
  * measuring them yet).
  *
- * This expects to be called with tasklist_lock read-locked or better,
- * and the siglock not locked.  It may momentarily take the siglock.
- *
  * When sampling multiple threads for RUSAGE_SELF, under SMP we might have
  * races with threads incrementing their own counters.  But since word
  * reads are atomic, we either get new values or old values and we don't
@@ -1674,6 +1671,25 @@ asmlinkage long sys_setrlimit(unsigned i
  * the c* fields from p->signal from races with exit.c updating those
  * fields when reaping, so a sample either gets all the additions of a
  * given child after it's reaped, or none so this sample is before reaping.
+ *
+ * tasklist_lock locking optimisation:
+ * If we are current and single threaded, we do not need to take the tasklist
+ * lock or the siglock.  No one else can take our signal_struct away, 
+ * no one else can reap the children to update signal->c* counters, and
+ * no one else can race with the signal-> fields.
+ * If we do not take the tasklist_lock, the signal-> fields could be read
+ * out of order while another thread was just exiting. So we place a 
+ * read memory barrier when we avoid the lock.  On the writer side, 
+ * write memory barrier is implied in  __exit_signal as __exit_signal releases 
+ * the siglock spinlock after updating the signal-> fields.
+ *
+ * We don't really need the siglock when we access the non c* fields
+ * of the signal_struct (for RUSAGE_SELF) even in multithreaded
+ * case, since we take the tasklist lock for read and the non c* signal-> 
+ * fields are updated only in __exit_signal, which is called with 
+ * tasklist_lock taken for write, hence these two threads cannot execute
+ * concurrently.
+ *
  */
 
 static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
@@ -1681,37 +1697,51 @@ static void k_getrusage(struct task_stru
 	struct task_struct *t;
 	unsigned long flags;
 	cputime_t utime, stime;
+	int need_lock = 0;
 
 	memset((char *) r, 0, sizeof *r);
 
-	if (unlikely(!p->signal))
-		return;
+	need_lock = (p == current && thread_group_empty(p));
+
+	if (need_lock) {
+		read_lock(&tasklist_lock);
+		if (unlikely(!p->signal)) {
+			read_unlock(&tasklist_lock);
+			return;
+		}
+	} else
+		/* See locking comments above */
+		smp_rmb();
 
 	switch (who) {
 		case RUSAGE_CHILDREN:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			if (need_lock)
+				spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
 			r->ru_nvcsw = p->signal->cnvcsw;
 			r->ru_nivcsw = p->signal->cnivcsw;
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			if (need_lock)
+				spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			cputime_to_timeval(utime, &r->ru_utime);
 			cputime_to_timeval(stime, &r->ru_stime);
 			break;
 		case RUSAGE_SELF:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = stime = cputime_zero;
 			goto sum_group;
 		case RUSAGE_BOTH:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			if (need_lock)
+				spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
 			r->ru_nvcsw = p->signal->cnvcsw;
 			r->ru_nivcsw = p->signal->cnivcsw;
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
+			if (need_lock)
+				spin_unlock_irqrestore(&p->sighand->siglock, flags);
 		sum_group:
 			utime = cputime_add(utime, p->signal->utime);
 			stime = cputime_add(stime, p->signal->stime);
@@ -1729,21 +1759,21 @@ static void k_getrusage(struct task_stru
 				r->ru_majflt += t->maj_flt;
 				t = next_thread(t);
 			} while (t != p);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			cputime_to_timeval(utime, &r->ru_utime);
 			cputime_to_timeval(stime, &r->ru_stime);
 			break;
 		default:
 			BUG();
 	}
+	
+	if (need_lock)
+		read_unlock(&tasklist_lock);
 }
 
 int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
 {
 	struct rusage r;
-	read_lock(&tasklist_lock);
 	k_getrusage(p, who, &r);
-	read_unlock(&tasklist_lock);
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
 
