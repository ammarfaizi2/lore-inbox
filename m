Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWB0Wnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWB0Wnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWB0WmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:42:11 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51331 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932349AbWB0Wb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:26 -0500
Message-Id: <20060227223349.377796000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:16 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Oleg Nesterov <oleg@tv-sign.ru>, Roland McGrath <roland@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@lst.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/39] [PATCH] fix zap_threads ptrace related problems
Content-Disposition: inline; filename=fix-zap_thread-s-ptrace-related-problems.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

1. The tracee can go from ptrace_stop() to do_signal_stop()
   after __ptrace_unlink(p).

2. It is unsafe to __ptrace_unlink(p) while p->parent may wait
   for tasklist_lock in ptrace_detach().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Roland McGrath <roland@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/exec.c              |    2 +-
 include/linux/ptrace.h |    1 +
 kernel/ptrace.c        |   25 +++++++++++++++----------
 3 files changed, 17 insertions(+), 11 deletions(-)

--- linux-2.6.15.4.orig/fs/exec.c
+++ linux-2.6.15.4/fs/exec.c
@@ -1403,7 +1403,7 @@ static void zap_threads (struct mm_struc
 		do_each_thread(g,p) {
 			if (mm == p->mm && p != tsk &&
 			    p->ptrace && p->parent->mm == mm) {
-				__ptrace_unlink(p);
+				__ptrace_detach(p, 0);
 			}
 		} while_each_thread(g,p);
 		write_unlock_irq(&tasklist_lock);
--- linux-2.6.15.4.orig/include/linux/ptrace.h
+++ linux-2.6.15.4/include/linux/ptrace.h
@@ -84,6 +84,7 @@ extern int ptrace_readdata(struct task_s
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
 extern int ptrace_detach(struct task_struct *, unsigned int);
+extern void __ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
 extern int ptrace_request(struct task_struct *child, long request, long addr, long data);
--- linux-2.6.15.4.orig/kernel/ptrace.c
+++ linux-2.6.15.4/kernel/ptrace.c
@@ -71,8 +71,8 @@ void ptrace_untrace(task_t *child)
  */
 void __ptrace_unlink(task_t *child)
 {
-	if (!child->ptrace)
-		BUG();
+	BUG_ON(!child->ptrace);
+
 	child->ptrace = 0;
 	if (!list_empty(&child->ptrace_list)) {
 		list_del_init(&child->ptrace_list);
@@ -183,22 +183,27 @@ bad:
 	return retval;
 }
 
+void __ptrace_detach(struct task_struct *child, unsigned int data)
+{
+	child->exit_code = data;
+	/* .. re-parent .. */
+	__ptrace_unlink(child);
+	/* .. and wake it up. */
+	if (child->exit_state != EXIT_ZOMBIE)
+		wake_up_process(child);
+}
+
 int ptrace_detach(struct task_struct *child, unsigned int data)
 {
 	if (!valid_signal(data))
-		return	-EIO;
+		return -EIO;
 
 	/* Architecture-specific hardware disable .. */
 	ptrace_disable(child);
 
-	/* .. re-parent .. */
-	child->exit_code = data;
-
 	write_lock_irq(&tasklist_lock);
-	__ptrace_unlink(child);
-	/* .. and wake it up. */
-	if (child->exit_state != EXIT_ZOMBIE)
-		wake_up_process(child);
+	if (child->ptrace)
+		__ptrace_detach(child, data);
 	write_unlock_irq(&tasklist_lock);
 
 	return 0;

--
