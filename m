Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319274AbSIFRvD>; Fri, 6 Sep 2002 13:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSIFRvD>; Fri, 6 Sep 2002 13:51:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29930 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319274AbSIFRvC>;
	Fri, 6 Sep 2002 13:51:02 -0400
Subject: [PATCH] pid_max hang again...
From: Paul Larson <plars@linuxtestproject.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209061738330.24094-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209061738330.24094-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Sep 2002 12:43:15 -0500
Message-Id: <1031334205.30394.14.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 10:39, Ingo Molnar wrote:
> On 6 Sep 2002, Paul Larson wrote:
> > It looks like this change dropped us back to the same error all this was
> > originally supposed to fix.  When you hit PID_MAX, get_pid() starts
> > looping forever looking for a free pid and hangs.  I could probably make
> > my original fix work on this very easily if you'd like.
> 
> yes please send a patch for this. Reintroduction of the looping bug was
> unintended.

Here's the original one without all the bitmap stuff, JUST the fix for
the hang problem plain and simple.  It should apply cleanly against the
current bk.  The only other small bit in here moves the test for flags &
CLONE_IDLETASK outside of get_pid since we can skip the unnecessary call
to get_pid if it's true.  Except for the last part, this is the same
thing I put into 2.4 some time ago.

Please comment or apply.

Thanks,
Paul Larson

diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Sep  6 20:19:21 2002
+++ b/kernel/fork.c	Fri Sep  6 20:19:21 2002
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/futex.h>
 #include <linux/ptrace.h>
+#include <linux/compiler.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -162,12 +163,10 @@
 static int get_pid(unsigned long flags)
 {
 	struct task_struct *p;
-	int pid;
-
-	if (flags & CLONE_IDLETASK)
-		return 0;
+	int pid, beginpid;
 
 	spin_lock(&lastpid_lock);
+	beginpid = last_pid;
 	if (++last_pid > pid_max) {
 		last_pid = 300;		/* Skip daemons etc. */
 		goto inside;
@@ -188,6 +187,8 @@
 						last_pid = 300;
 					next_safe = pid_max;
 				}
+				if (unlikely(last_pid == beginpid))
+					goto nomorepids;
 				goto repeat;
 			}
 			if (p->pid > last_pid && next_safe > p->pid)
@@ -205,6 +206,11 @@
 	spin_unlock(&lastpid_lock);
 
 	return pid;
+
+nomorepids:
+	read_unlock(&tasklist_lock);
+	spin_unlock(&lastpid_lock);
+	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
@@ -707,7 +713,13 @@
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
-	p->pid = get_pid(clone_flags);
+	if (clone_flags & CLONE_IDLETASK)
+		p->pid = 0;
+	else {
+		p->pid = get_pid(clone_flags);
+		if (p->pid == 0)
+			goto bad_fork_cleanup;
+	}
 	p->proc_dentry = NULL;
 
 	INIT_LIST_HEAD(&p->run_list);

