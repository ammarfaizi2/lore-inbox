Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWDFSJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWDFSJD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWDFSJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:09:03 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:19096 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932120AbWDFSJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:09:01 -0400
Date: Fri, 7 Apr 2006 02:06:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] coredump: optimize ->mm users traversal
Message-ID: <20060406220607.GA232@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zap_threads() iterates over all threads to find those ones which
share current->mm. All threads in the thread group share the same
->mm, so we can skip entire thread group if it has another ->mm.

This patch shifts the killing of thread group into the newly added
zap_process() function. This looks as unnecessary complication, but
it is used in further patches.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc1/fs/exec.c~1_ZAPT	2006-04-03 16:21:25.000000000 +0400
+++ rc1/fs/exec.c	2006-04-06 15:10:28.000000000 +0400
@@ -1384,6 +1384,22 @@ static void format_corename(char *corena
 	*out_ptr = 0;
 }
 
+static void zap_process(struct task_struct *start, int *ptraced)
+{
+	struct task_struct *t;
+
+	t = start;
+	do {
+		if (t != current && t->mm) {
+			t->mm->core_waiters++;
+			force_sig_specific(SIGKILL, t);
+			if (unlikely(t->ptrace) &&
+			    unlikely(t->parent->mm == t->mm))
+				*ptraced = 1;
+		}
+	} while ((t = next_thread(t)) != start);
+}
+
 static void zap_threads (struct mm_struct *mm)
 {
 	struct task_struct *g, *p;
@@ -1401,16 +1417,16 @@ static void zap_threads (struct mm_struc
 	}
 
 	read_lock(&tasklist_lock);
-	do_each_thread(g,p)
-		if (mm == p->mm && p != tsk) {
-			force_sig_specific(SIGKILL, p);
-			mm->core_waiters++;
-			if (unlikely(p->ptrace) &&
-			    unlikely(p->parent->mm == mm))
-				traced = 1;
-		}
-	while_each_thread(g,p);
-
+	for_each_process(g) {
+		p = g;
+		do {
+			if (p->mm) {
+				if (p->mm == mm)
+					zap_process(p, &traced);
+				break;
+			}
+		} while ((p = next_thread(p)) != g);
+	}
 	read_unlock(&tasklist_lock);
 
 	if (unlikely(traced)) {

