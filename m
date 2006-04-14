Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWDNUty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWDNUty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWDNUty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:49:54 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:63999 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S965157AbWDNUty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:49:54 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] mm: fix mm_struct reference counting bugs in mm/oom_kill.c
Date: Fri, 14 Apr 2006 13:49:02 -0700
User-Agent: KMail/1.5.3
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com
References: <200604131452.08292.dsp@llnl.gov> <200604141214.35806.dsp@llnl.gov> <20060414124530.24a36d51.akpm@osdl.org>
In-Reply-To: <20060414124530.24a36d51.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141349.02047.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 12:45, Andrew Morton wrote:
> Dave Peterson <dsp@llnl.gov> wrote:
> > On Friday 14 April 2006 00:26, Andrew Morton wrote:
> > > task_lock() can be used to pin a task's ->mm.  To use task_lock() in
> > > badness() we'd need to either
> > >
> > > a) nest task_lock()s.  I don't know if we're doing that anywhere else,
> > >    but the parent->child ordering is a natural one.  or
> > >
> > > b) take a ref on the parent's mm_struct, drop the parent's task_lock()
> > >    while we walk the children, then do mmput() on the parent's mm
> > > outside tasklist_lock.  This is probably better.
> >
> > Looking a bit more closely at the code, I see that
> > select_bad_process() iterates over all tasks, repeatedly calling
> > badness().  This would complicate option 'b' since the iteration is
> > done while holding tasklist_lock.  An alternative to option 'a' that
> > avoids nesting task_lock()s would be to define a couple of new
> > functions that might look something like this:
> >
> >     void mmput_atomic(struct mm_struct *mm)
> >     {
> >             if (atomic_dec_and_test(&mm->mm_users)) {
> >                     add mm to a global list of expired mm_structs
> >             }
> >     }
> >
> >     void mmput_atomic_cleanup(void)
> >     {
> >             empty the global list of expired mm_structs and do
> >             cleanup stuff for each one
> >     }
>
> I think that's way too elaborate.
>
> What's wrong with this?

Yes of course... no need to nest task_lock()s after all.  Looks good
to me.

Another thing I noticed: oom_kill_task() calls mmput() while holding
tasklist_lock.  Here the calls to get_task_mm() and mmput() appear to
be unnecessary.  We shouldn't need to use any kind of locking or
reference counting since oom_kill_task() doesn't dereference into the
mm_struct or require the value of p->mm to stay constant.  I believe
the following (untested) code changes should fix the problem (and
simplify some other parts of the code).  Does this look correct?


diff -urNp -X /home/dsp/dontdiff linux-2.6.17-rc1/mm/oom_kill.c linux-2.6.17-rc1-fix/mm/oom_kill.c
--- linux-2.6.17-rc1/mm/oom_kill.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc1-fix/mm/oom_kill.c	2006-04-14 13:22:15.000000000 -0700
@@ -244,17 +244,15 @@ static void __oom_kill_task(task_t *p, c
 	force_sig(SIGKILL, p);
 }
 
-static struct mm_struct *oom_kill_task(task_t *p, const char *message)
+static int oom_kill_task(task_t *p, const char *message)
 {
-	struct mm_struct *mm = get_task_mm(p);
+	struct mm_struct *mm;
 	task_t * g, * q;
 
-	if (!mm)
-		return NULL;
-	if (mm == &init_mm) {
-		mmput(mm);
-		return NULL;
-	}
+	mm = p->mm;
+
+	if ((mm == NULL) || (mm == &init_mm))
+		return 1;
 
 	__oom_kill_task(p, message);
 	/*
@@ -266,13 +264,12 @@ static struct mm_struct *oom_kill_task(t
 			__oom_kill_task(q, message);
 	while_each_thread(g, q);
 
-	return mm;
+	return 0;
 }
 
-static struct mm_struct *oom_kill_process(struct task_struct *p,
-				unsigned long points, const char *message)
+static int oom_kill_process(struct task_struct *p, unsigned long points,
+		const char *message)
 {
- 	struct mm_struct *mm;
 	struct task_struct *c;
 	struct list_head *tsk;
 
@@ -283,9 +280,8 @@ static struct mm_struct *oom_kill_proces
 		c = list_entry(tsk, struct task_struct, sibling);
 		if (c->mm == p->mm)
 			continue;
-		mm = oom_kill_task(c, message);
-		if (mm)
-			return mm;
+		if (!oom_kill_task(c, message))
+			return 0;
 	}
 	return oom_kill_task(p, message);
 }
@@ -300,7 +296,6 @@ static struct mm_struct *oom_kill_proces
  */
 void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
 {
-	struct mm_struct *mm = NULL;
 	task_t *p;
 	unsigned long points = 0;
 
@@ -320,12 +315,12 @@ void out_of_memory(struct zonelist *zone
 	 */
 	switch (constrained_alloc(zonelist, gfp_mask)) {
 	case CONSTRAINT_MEMORY_POLICY:
-		mm = oom_kill_process(current, points,
+		oom_kill_process(current, points,
 				"No available memory (MPOL_BIND)");
 		break;
 
 	case CONSTRAINT_CPUSET:
-		mm = oom_kill_process(current, points,
+		oom_kill_process(current, points,
 				"No available memory in cpuset");
 		break;
 
@@ -347,8 +342,7 @@ retry:
 			panic("Out of memory and no killable processes...\n");
 		}
 
-		mm = oom_kill_process(p, points, "Out of memory");
-		if (!mm)
+		if (oom_kill_process(p, points, "Out of memory"))
 			goto retry;
 
 		break;
@@ -357,8 +351,6 @@ retry:
 out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
-	if (mm)
-		mmput(mm);
 
 	/*
 	 * Give "p" a good chance of killing itself before we

