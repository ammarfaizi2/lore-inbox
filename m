Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUIBF2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUIBF2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUIBF2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:28:44 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:52185 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S267389AbUIBF2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:28:39 -0400
Date: Wed, 1 Sep 2004 22:28:32 -0700
Message-Id: <200409020528.i825SWhi025479@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] nix RUSAGE_GROUP
X-Fcc: ~/Mail/linus
X-Windows: graphics hacking :: Roman numerals : sqrt (pi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After my cleanup of the rusage semantics was so quickly taken in by Andrew
and Linus without comment, I wonder if I should not have tried to be so
accommodating of potential objections as I was. :-)

In my original posting, I solicited comment on whether introducing
RUSAGE_GROUP as distinct from RUSAGE_SELF was warranted.  Note that we've
now changed the behavior of the times system call when using CLONE_THREAD,
so changing getrusage RUSAGE_SELF to match would be consistent.  I think
that changing the meaning of the old RUSAGE_SELF value is preferable to
introducing the new value for the proper POSIX getrusage behavior.  This
patch against Linus's current tree dumps RUSAGE_GROUP and makes RUSAGE_SELF
have the fixed behavior.  

If there is interest in having a new explicit interface to sample a single
thread's stats alone, then I think that would be better done by introducing
a new value for RUSAGE_THREAD.  This is trivial to implement, but I won't
offer patches bloating the interface if noone is actually interested in
using it.


Thanks,
Roland


Index: linux-2.6.9/include/linux/resource.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/resource.h,v
retrieving revision 1.6
diff -b -B -p -u -r1.6 resource.h
--- linux-2.6.9/include/linux/resource.h 31 Aug 2004 17:35:38 -0000 1.6
+++ linux-2.6.9/include/linux/resource.h 1 Sep 2004 22:20:30 -0000
@@ -17,7 +17,6 @@
 #define	RUSAGE_SELF	0
 #define	RUSAGE_CHILDREN	(-1)
 #define RUSAGE_BOTH	(-2)		/* sys_wait4() uses this */
-#define RUSAGE_GROUP	(-3)		/* thread group sum + dead threads */
 
 struct	rusage {
 	struct timeval ru_utime;	/* user time used */
Index: linux-2.6.9/kernel/sys.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/sys.c,v
retrieving revision 1.88
diff -b -B -p -u -r1.88 sys.c
--- linux-2.6.9/kernel/sys.c 31 Aug 2004 17:35:38 -0000 1.88
+++ linux-2.6.9/kernel/sys.c 1 Sep 2004 22:20:24 -0000
@@ -1565,7 +1565,7 @@ asmlinkage long sys_setrlimit(unsigned i
  * This expects to be called with tasklist_lock read-locked or better,
  * and the siglock not locked.  It may momentarily take the siglock.
  *
- * When sampling multiple threads for RUSAGE_GROUP, under SMP we might have
+ * When sampling multiple threads for RUSAGE_SELF, under SMP we might have
  * races with threads incrementing their own counters.  But since word
  * reads are atomic, we either get new values or old values and we don't
  * care which for the sums.  We always take the siglock to protect reading
@@ -1586,14 +1586,6 @@ void k_getrusage(struct task_struct *p, 
 		return;
 
 	switch (who) {
-		case RUSAGE_SELF:
-			jiffies_to_timeval(p->utime, &r->ru_utime);
-			jiffies_to_timeval(p->stime, &r->ru_stime);
-			r->ru_nvcsw = p->nvcsw;
-			r->ru_nivcsw = p->nivcsw;
-			r->ru_minflt = p->min_flt;
-			r->ru_majflt = p->maj_flt;
-			break;
 		case RUSAGE_CHILDREN:
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
@@ -1606,7 +1598,7 @@ void k_getrusage(struct task_struct *p, 
 			jiffies_to_timeval(utime, &r->ru_utime);
 			jiffies_to_timeval(stime, &r->ru_stime);
 			break;
-		case RUSAGE_GROUP:
+		case RUSAGE_SELF:
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = stime = 0;
 			goto sum_group;
@@ -1655,8 +1647,7 @@ int getrusage(struct task_struct *p, int
 
 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
-	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN
-	    && who != RUSAGE_GROUP)
+	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
 		return -EINVAL;
 	return getrusage(current, who, ru);
 }
