Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRJVQTE>; Mon, 22 Oct 2001 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276978AbRJVQSy>; Mon, 22 Oct 2001 12:18:54 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45263 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276984AbRJVQSq>; Mon, 22 Oct 2001 12:18:46 -0400
Date: Mon, 22 Oct 2001 11:18:59 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix broken reparenting in forget_original_parent()
 (resubmit)
Message-ID: <62470000.1003767539@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The code in forget_original_parent() that attempts to reparent a task to 
another task in the thread group is broken.  It's not safe to parent to any 
task other than init because of the race condition it introduces (init is 
only safe as long as it never dies, in fact).

The patch to change forget_original_parent() to always use init is below.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

---------------------

--- linux-2.4.12/kernel/exit.c	Mon Sep 10 15:04:33 2001
+++ linux-2.4.12-signal-kdb/kernel/exit.c	Thu Oct 18 11:31:57 2001
@@ -149,28 +149,21 @@
 }

 /*
- * When we die, we re-parent all our children.
- * Try to give them to another thread in our process
- * group, and if no such member exists, give it to
+ * When we die, we re-parent all our children to
  * the global child reaper process (ie "init")
  */
 static inline void forget_original_parent(struct task_struct * father)
 {
-	struct task_struct * p, *reaper;
+	struct task_struct * p;

 	read_lock(&tasklist_lock);

-	/* Next in our thread group */
-	reaper = next_thread(father);
-	if (reaper == father)
-		reaper = child_reaper;
-
 	for_each_task(p) {
 		if (p->p_opptr == father) {
 			/* We dont want people slaying init */
 			p->exit_signal = SIGCHLD;
 			p->self_exec_id++;
-			p->p_opptr = reaper;
+			p->p_opptr = child_reaper;
 			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
 		}
 	}

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

