Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVLUSXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVLUSXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVLUSXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:23:25 -0500
Received: from ns1.siteground.net ([207.218.208.2]:26332 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932489AbVLUSXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:23:24 -0500
Date: Wed, 21 Dec 2005 10:23:20 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       nippung@calsoftinc.com
Subject: [rfc][patch] Avoid taking global tasklist_lock for single threaded process at getrusage()
Message-ID: <20051221182320.GA4514@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Following patch avoids taking the global tasklist_lock when possible,
if a process is single threaded during getrusage().  Any avoidance of 
tasklist_lock is good for NUMA boxes (and possibly for large SMPs).  We found 
that this optimization reduces the runtime of a certain scientific application 
by half on a 16 cpu NUMA box.

This optimization is similar to the sys_times tasklist_lock optimization.

Signed-off-by: Nippun Goel <nippung@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc6/kernel/sys.c
===================================================================
--- linux-2.6.15-rc6.orig/kernel/sys.c	2005-12-20 14:10:52.000000000 -0800
+++ linux-2.6.15-rc6/kernel/sys.c	2005-12-21 00:39:41.000000000 -0800
@@ -1664,8 +1664,9 @@
  * a lot simpler!  (Which we're not doing right now because we're not
  * measuring them yet).
  *
- * This expects to be called with tasklist_lock read-locked or better,
- * and the siglock not locked.  It may momentarily take the siglock.
+ * This function was earlier called with tasklist_lock lock taken for read.
+ * Now, we take tasklist_lock for read (and the siglock) only when required.
+ * See notes below.
  *
  * When sampling multiple threads for RUSAGE_SELF, under SMP we might have
  * races with threads incrementing their own counters.  But since word
@@ -1674,6 +1675,25 @@
  * the c* fields from p->signal from races with exit.c updating those
  * fields when reaping, so a sample either gets all the additions of a
  * given child after it's reaped, or none so this sample is before reaping.
+ * 
+ * Locking: 
+ * If we have a multithreaded process, we need to take tasklist read lock 
+ * for RUSAGE_SELF and RUSAGE_BOTH.  We don't need to take the tasklist lock
+ * for RUSAGE_CHILDREN  and just the siglock should suffice there.
+ *
+ * If we are a single threaded process, we donot need to take the tasklist_lock
+ * for read.  However, we need to take siglock for the RUSAGE_BOTH case.  
+ * RUSAGE_SELF and RUSAGE_CHILDREN is invoked via the  syscall, and is 
+ * for the current process -- unlike RUSAGE_BOTH.  So not taking the siglock 
+ * for  RUSAGE_SELF and RUSAGE_CHILDREN is safe.
+ *
+ * In the multithreaded scenaio, while we have the tasklist_lock held for
+ * read, the non c* p->signal field updates cannot take place as the 
+ * __exit_signal thread is called with write lock taken on tasklist_lock.  
+ * Reads on the p->signal c* fields however can race if a child is being reaped.
+ * we avoid the race by taking the siglock to read the c* fileds.
+ * 
+ * Hence, tasklist lock for read is sufficient for RUSAGE_SELF.
  */
 
 static void k_getrusage(struct task_struct *p, int who, struct rusage *r)
@@ -1681,6 +1701,7 @@
 	struct task_struct *t;
 	unsigned long flags;
 	cputime_t utime, stime;
+	int lockflag = 0;
 
 	memset((char *) r, 0, sizeof *r);
 
@@ -1689,22 +1710,33 @@
 
 	switch (who) {
 		case RUSAGE_CHILDREN:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			if (!thread_group_empty(p)) {
+				spin_lock_irqsave(&p->sighand->siglock, flags);
+				lockflag = 1;
+			}
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
 			r->ru_nvcsw = p->signal->cnvcsw;
 			r->ru_nivcsw = p->signal->cnivcsw;
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			if (lockflag)
+				spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			cputime_to_timeval(utime, &r->ru_utime);
 			cputime_to_timeval(stime, &r->ru_stime);
 			break;
 		case RUSAGE_SELF:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			if (!thread_group_empty(p)) {
+				read_lock(&tasklist_lock);
+				lockflag = 1;
+			}
 			utime = stime = cputime_zero;
 			goto sum_group;
 		case RUSAGE_BOTH:
+			if (!thread_group_empty(p)) {
+				read_lock(&tasklist_lock);
+				lockflag = 1;
+			}
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
@@ -1712,6 +1744,7 @@
 			r->ru_nivcsw = p->signal->cnivcsw;
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
+			spin_unlock_irqrestore(&p->sighand->siglock, flags);
 		sum_group:
 			utime = cputime_add(utime, p->signal->utime);
 			stime = cputime_add(stime, p->signal->stime);
@@ -1729,7 +1762,8 @@
 				r->ru_majflt += t->maj_flt;
 				t = next_thread(t);
 			} while (t != p);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			if (lockflag)
+				read_unlock(&tasklist_lock);
 			cputime_to_timeval(utime, &r->ru_utime);
 			cputime_to_timeval(stime, &r->ru_stime);
 			break;
@@ -1741,9 +1775,7 @@
 int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
 {
 	struct rusage r;
-	read_lock(&tasklist_lock);
 	k_getrusage(p, who, &r);
-	read_unlock(&tasklist_lock);
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
 
