Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277806AbRJRQnW>; Thu, 18 Oct 2001 12:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277805AbRJRQnR>; Thu, 18 Oct 2001 12:43:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60632 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277806AbRJRQnA>; Thu, 18 Oct 2001 12:43:00 -0400
Date: Thu, 18 Oct 2001 11:42:45 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix reparenting in exit.c
Message-ID: <33770000.1003423365@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The code that attempts to reparent the children of a dying task to
another task in the thread group has a nasty race condition.  Since
it is called early in the exit sequence, the task it picks as the new
parent could also be exiting.  This has the effect of reparenting the
task to a zombie, and eventually the parent pointer will point to
re-used memory.

Given that this feature is unused and would be difficult to fix, I
believe it should be removed entirely and it should just always reparent
to init.

The patch to change this is below.

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

