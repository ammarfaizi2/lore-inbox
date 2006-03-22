Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWCVWSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWCVWSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWCVWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:18:08 -0500
Received: from ns1.siteground.net ([207.218.208.2]:63974 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932107AbWCVWSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:18:01 -0500
Date: Wed, 22 Mar 2006 14:18:44 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20060322221844.GA3300@localhost.localdomain>
References: <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com> <20060106194623.GA4078@localhost.localdomain> <441EEEC8.D4D9C40A@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441EEEC8.D4D9C40A@tv-sign.ru>
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

On Mon, Mar 20, 2006 at 09:04:56PM +0300, Oleg Nesterov wrote:
> Hello Ravikiran,

Hi Oleg, sorry for the late response..

> 
> Ravikiran G Thirumalai wrote:
> > 
> > Following patch avoids taking the global tasklist_lock when possible,
> > if a process is single threaded during getrusage().  Any avoidance of
> > tasklist_lock is good for NUMA boxes (and possibly for large SMPs).
> >
> > ...
> >
> >  static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
> > @@ -1681,14 +1697,22 @@ static void k_getrusage(struct task_stru
> >         struct task_struct *t;
> >         unsigned long flags;
> >         cputime_t utime, stime;
> > +       int need_lock = 0;
> > 
> >         memset((char *) r, 0, sizeof *r);
> > -
> > -       if (unlikely(!p->signal))
> > -               return;
> > -
> >         utime = stime = cputime_zero;
> > 
> > +       need_lock = (p != current || !thread_group_empty(p));
> > +       if (need_lock) {
> > +               read_lock(&tasklist_lock);
> > +               if (unlikely(!p->signal)) {
> > +                       read_unlock(&tasklist_lock);
> > +                       return;
> > +               }
> > +       } else
> > +               /* See locking comments above */
> > +               smp_rmb();
> > +
> 
> I think now it is possible to improve this patch.
> 
> Could you look at these patches?
> 
> 	[PATCH] introduce lock_task_sighand() helper
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=114028190927763
> 
> 	[PATCH 0/3] make threads traversal ->siglock safe
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=114064825626496
> 
> I think we can forget about tasklist_lock in k_getrusage() completely
> and just use lock_task_sighand().
> 
> What do you think?

Great!! Nice patches to avoid tasklist lock on thread traversal.

However, I was trying to comprehend the tasklist locking changes in 
2.6.16-rc6mm2 and hit upon:

__exit_signal
	cleanup_sighand(tsk);
		kmem_cache_free(sighand)
	spin_unlock(sighand->lock)

It looked suspicious to me until I realised sighand cache now had 
SLAB_DESTROY_BY_RCU. Can we please add comments (at cleanup_sighand or 
__exit_signal) to make it a bit clearer for people like me :)

How is the following patch to avoid tasklist lock completely at getrusage?
(Andrew, I can remake the patch against a reverted 
avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage
if you prefer it that way)

Thanks,
Kiran


Change avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage
patch to not take the global tasklist lock at all. We don't need to take
the tasklist lock for thread traversal of a process since Oleg's
do-__unhash_process-under-siglock.patch and related work.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.16-rc6mm2/kernel/sys.c
===================================================================
--- linux-2.6.16-rc6mm2.orig/kernel/sys.c	2006-03-21 17:04:09.000000000 -0800
+++ linux-2.6.16-rc6mm2/kernel/sys.c	2006-03-22 12:46:03.000000000 -0800
@@ -1860,23 +1860,20 @@ out:
  * fields when reaping, so a sample either gets all the additions of a
  * given child after it's reaped, or none so this sample is before reaping.
  *
- * tasklist_lock locking optimisation:
- * If we are current and single threaded, we do not need to take the tasklist
- * lock or the siglock.  No one else can take our signal_struct away,
- * no one else can reap the children to update signal->c* counters, and
- * no one else can race with the signal-> fields.
- * If we do not take the tasklist_lock, the signal-> fields could be read
- * out of order while another thread was just exiting. So we place a
- * read memory barrier when we avoid the lock.  On the writer side,
- * write memory barrier is implied in  __exit_signal as __exit_signal releases
- * the siglock spinlock after updating the signal-> fields.
- *
- * We don't really need the siglock when we access the non c* fields
- * of the signal_struct (for RUSAGE_SELF) even in multithreaded
- * case, since we take the tasklist lock for read and the non c* signal->
- * fields are updated only in __exit_signal, which is called with
- * tasklist_lock taken for write, hence these two threads cannot execute
- * concurrently.
+ * Locking:
+ * We need to take the siglock for CHILDEREN, SELF and BOTH 
+ * for  the cases current multithreaded, non-current single threaded
+ * non-current multithreaded.  Thread traversal is now safe with 
+ * the siglock held. 
+ * Strictly speaking, we donot need to take the siglock if we are current and 
+ * single threaded,  as no one else can take our signal_struct away, no one 
+ * else can  reap the  children to update signal->c* counters, and no one else 
+ * can race with the signal-> fields. If we do not take any lock, the 
+ * signal-> fields could be read out of order while another thread was just 
+ * exiting. So we should  place a read memory barrier when we avoid the lock.  
+ * On the writer side,  write memory barrier is implied in  __exit_signal 
+ * as __exit_signal releases  the siglock spinlock after updating the signal-> 
+ * fields. But we don't do this yet to keep things simple.
  *
  */
 
@@ -1885,35 +1882,25 @@ static void k_getrusage(struct task_stru
 	struct task_struct *t;
 	unsigned long flags;
 	cputime_t utime, stime;
-	int need_lock = 0;
 
 	memset((char *) r, 0, sizeof *r);
 	utime = stime = cputime_zero;
 
-	if (p != current || !thread_group_empty(p))
-		need_lock = 1;
-
-	if (need_lock) {
-		read_lock(&tasklist_lock);
-		if (unlikely(!p->signal)) {
-			read_unlock(&tasklist_lock);
-			return;
-		}
-	} else
-		/* See locking comments above */
-		smp_rmb();
+	rcu_read_lock();
+	if (!lock_task_sighand(p, &flags)) {
+		rcu_read_unlock();
+		return;
+	}	
 
 	switch (who) {
 		case RUSAGE_BOTH:
 		case RUSAGE_CHILDREN:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
 			r->ru_nvcsw = p->signal->cnvcsw;
 			r->ru_nivcsw = p->signal->cnivcsw;
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
 
 			if (who == RUSAGE_CHILDREN)
 				break;
@@ -1940,9 +1927,10 @@ static void k_getrusage(struct task_stru
 		default:
 			BUG();
 	}
-
-	if (need_lock)
-		read_unlock(&tasklist_lock);
+	
+	unlock_task_sighand(p, &flags);
+	rcu_read_unlock();
+	
 	cputime_to_timeval(utime, &r->ru_utime);
 	cputime_to_timeval(stime, &r->ru_stime);
 }

