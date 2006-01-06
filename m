Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752503AbWAFTq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbWAFTq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbWAFTq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:46:26 -0500
Received: from ns1.siteground.net ([207.218.208.2]:30648 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1752503AbWAFTqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:46:25 -0500
Date: Fri, 6 Jan 2006 11:46:23 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Shai Fultheim <shai@scalex86.org>,
       Nippun Goel <nippung@calsoftinc.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20060106194623.GA4078@localhost.localdomain>
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com>
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

On Fri, Jan 06, 2006 at 09:23:30AM -0800, Christoph Lameter wrote:
> On Fri, 6 Jan 2006, Ravikiran G Thirumalai wrote:
> 
> > +	need_lock = !(p == current && thread_group_empty(p));
> 
> Isnt 
> 
> need_lock = (p != current || !thread_group_empty(b))
> 
> clearer?

All the same I felt, and the comments were bold and clear.  Also, the above was
c translation of what was said in the comment  :)...I am OK either ways.
So Here goes...

Following patch avoids taking the global tasklist_lock when possible,
if a process is single threaded during getrusage().  Any avoidance of
tasklist_lock is good for NUMA boxes (and possibly for large SMPs).
Thanks to Oleg Nesterov for review and suggestions.

Signed-off-by: Nippun Goel <nippung@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-delme/kernel/sys.c
===================================================================
--- linux-2.6.15-delme.orig/kernel/sys.c	2006-01-05 15:40:38.000000000 -0800
+++ linux-2.6.15-delme/kernel/sys.c	2006-01-06 00:43:08.000000000 -0800
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
@@ -1681,14 +1697,22 @@ static void k_getrusage(struct task_stru
 	struct task_struct *t;
 	unsigned long flags;
 	cputime_t utime, stime;
+	int need_lock = 0;
 
 	memset((char *) r, 0, sizeof *r);
-
-	if (unlikely(!p->signal))
-		return;
-
 	utime = stime = cputime_zero;
 
+	need_lock = (p != current || !thread_group_empty(p));
+	if (need_lock) {
+		read_lock(&tasklist_lock);
+		if (unlikely(!p->signal)) {
+			read_unlock(&tasklist_lock);
+			return;
+		}
+	} else
+		/* See locking comments above */
+		smp_rmb();
+
 	switch (who) {
 		case RUSAGE_BOTH:
 		case RUSAGE_CHILDREN:
@@ -1727,6 +1751,8 @@ static void k_getrusage(struct task_stru
 			BUG();
 	}
 
+	if (need_lock)
+		read_unlock(&tasklist_lock);
 	cputime_to_timeval(utime, &r->ru_utime);
 	cputime_to_timeval(stime, &r->ru_stime);
 }
@@ -1734,9 +1760,7 @@ static void k_getrusage(struct task_stru
 int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
 {
 	struct rusage r;
-	read_lock(&tasklist_lock);
 	k_getrusage(p, who, &r);
-	read_unlock(&tasklist_lock);
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
 }
 
