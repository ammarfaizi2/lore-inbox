Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUI1Bir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUI1Bir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 21:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUI1Bir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 21:38:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5079 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265211AbUI1Big (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 21:38:36 -0400
Date: Mon, 27 Sep 2004 18:38:17 -0700
Message-Id: <200409280138.i8S1cH6L007754@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] add WCONTINUED support to wait4 syscall
X-Fcc: ~/Mail/linus
X-Zippy-Says: Go on, EMOTE!  I was RAISED on thought balloons!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX specifies the new WCONTINUED flag for waitpid, not just for waitid.
I overlooked this addition when I implemented waitid.  The real work was
already done to support waitid, but waitpid needs to report the results
differently.  This patch adds that support.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com> 

Index: linux-2.6/kernel/exit.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/exit.c,v
retrieving revision 1.154
diff -B -p -u -r1.154 exit.c
--- linux-2.6/kernel/exit.c 21 Sep 2004 14:15:21 -0000 1.154
+++ linux-2.6/kernel/exit.c 28 Sep 2004 01:17:56 -0000
@@ -1228,6 +1228,58 @@ bail_ref:
 	return retval;
 }
 
+/*
+ * Handle do_wait work for one task in a live, non-stopped state.
+ * read_lock(&tasklist_lock) on entry.  If we return zero, we still hold
+ * the lock and this task is uninteresting.  If we return nonzero, we have
+ * released the lock and the system call should return.
+ */
+static int wait_task_continued(task_t *p, int noreap,
+			       struct siginfo __user *infop,
+			       int __user *stat_addr, struct rusage __user *ru)
+{
+	int retval;
+	pid_t pid;
+	uid_t uid;
+
+	if (unlikely(!p->signal))
+		return 0;
+
+	if (p->signal->stop_state >= 0)
+		return 0;
+
+	spin_lock_irq(&p->sighand->siglock);
+	if (p->signal->stop_state >= 0) { /* Re-check with the lock held.  */
+		spin_unlock_irq(&p->sighand->siglock);
+		return 0;
+	}
+	if (!noreap)
+		p->signal->stop_state = 0;
+	spin_unlock_irq(&p->sighand->siglock);
+
+	pid = p->pid;
+	uid = p->uid;
+	get_task_struct(p);
+	read_unlock(&tasklist_lock);
+
+	if (!infop) {
+		retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
+		put_task_struct(p);
+		if (!retval && stat_addr)
+			retval = put_user(0xffff, stat_addr);
+		if (!retval)
+			retval = p->pid;
+	} else {
+		retval = wait_noreap_copyout(p, pid, uid,
+					     CLD_CONTINUED, SIGCONT,
+					     infop, ru);
+		BUG_ON(retval == 0);
+	}
+
+	return retval;
+}
+
+
 static long do_wait(pid_t pid, int options, struct siginfo __user *infop,
 		    int __user *stat_addr, struct rusage __user *ru)
 {
@@ -1290,27 +1342,11 @@ repeat:
 check_continued:
 				if (!unlikely(options & WCONTINUED))
 					continue;
-				if (unlikely(!p->signal))
-					continue;
-				spin_lock_irq(&p->sighand->siglock);
-				if (p->signal->stop_state < 0) {
-					pid_t pid;
-					uid_t uid;
-
-					if (!(options & WNOWAIT))
-						p->signal->stop_state = 0;
-					spin_unlock_irq(&p->sighand->siglock);
-					pid = p->pid;
-					uid = p->uid;
-					get_task_struct(p);
-					read_unlock(&tasklist_lock);
-					retval = wait_noreap_copyout(p, pid,
-							uid, CLD_CONTINUED,
-							SIGCONT, infop, ru);
-					BUG_ON(retval == 0);
+				retval = wait_task_continued(
+					p, (options & WNOWAIT),
+					infop, stat_addr, ru);
+				if (retval != 0) /* He released the lock.  */
 					goto end;
-				}
-				spin_unlock_irq(&p->sighand->siglock);
 				break;
 			}
 		}
@@ -1404,7 +1440,8 @@ asmlinkage long sys_waitid(int which, pi
 asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
 			  int options, struct rusage __user *ru)
 {
-	if (options & ~(WNOHANG|WUNTRACED|__WNOTHREAD|__WCLONE|__WALL))
+	if (options & ~(WNOHANG|WUNTRACED|WCONTINUED|
+			__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
 	return do_wait(pid, options | WEXITED, NULL, stat_addr, ru);
 }
