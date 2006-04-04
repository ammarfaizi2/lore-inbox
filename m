Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWDDJZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWDDJZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDDJZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:25:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932405AbWDDJZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:25:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fix pacct bug in multithreading case.
In-Reply-To: KaiGai Kohei's message of  Tuesday, 28 March 2006 20:43:49 +0900 <44292175.6030605@ak.jp.nec.com>
X-Windows: it could be worse, but it'll take time.
Message-Id: <20060404092507.753721809CE@magilla.sf.frob.com>
Date: Tue,  4 Apr 2006 02:25:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That change looks correct to me, and I see that it's gone in.

It made me think of another issue affecting the accounting records in
related circumstances when the old group leader died after a non-leader exec.
I think this patch addresses that, and along with your patch, gives more
sensible times in all cases.


Thanks,
Roland


[PATCH] Take original leader's start_time in non-leader exec.

The only record we have of the real-time age of a process, regardless of
execs it's done, is start_time.  When a non-leader thread exec, the
original start_time of the process is lost.  Things looking at the
real-time age of the process are fooled, for example the process
accounting record when the process finally dies.  This change makes the
oldest start_time stick around with the process after a non-leader exec.
This way the association between PID and start_time is kept constant,
which seems correct to me.

Signed-off-by: Roland McGrath <roland@redhat.com>

---

 fs/exec.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

7cda52efb6ff969f049bc2ab3742b0341e45184a
diff --git a/fs/exec.c b/fs/exec.c
index 0291a68..a45f712 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -678,6 +678,18 @@ static int de_thread(struct task_struct 
 		while (leader->exit_state != EXIT_ZOMBIE)
 			yield();
 
+		/*
+		 * The only record we have of the real-time age of a
+		 * process, regardless of execs it's done, is start_time.
+		 * All the past CPU time is accumulated in signal_struct
+		 * from sister threads now dead.  But in this non-leader
+		 * exec, nothing survives from the original leader thread,
+		 * whose birth marks the true age of this process now.
+		 * When we take on its identity by switching to its PID, we
+		 * also take its birthdate (always earlier than our own).
+		 */
+		current->start_time = leader->start_time;
+
 		spin_lock(&leader->proc_lock);
 		spin_lock(&current->proc_lock);
 		proc_dentry1 = proc_pid_unhash(current);
-- 
1.2.4

