Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314550AbSDSEqs>; Fri, 19 Apr 2002 00:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSDSEqr>; Fri, 19 Apr 2002 00:46:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34198 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314550AbSDSEqn>;
	Fri, 19 Apr 2002 00:46:43 -0400
Date: Fri, 19 Apr 2002 00:46:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (3/6) alpha fixes
In-Reply-To: <Pine.GSO.4.21.0204190045560.20383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204190046270.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-alpha-defines/arch/alpha/kernel/osf_sys.c C8-pptr/arch/alpha/kernel/osf_sys.c
--- C8-alpha-defines/arch/alpha/kernel/osf_sys.c	Tue Feb 19 22:32:51 2002
+++ C8-pptr/arch/alpha/kernel/osf_sys.c	Thu Apr 18 23:25:18 2002
@@ -219,7 +219,7 @@
 	 * isn't actually going to matter, as if the parent happens
 	 * to change we can happily return either of the pids.
 	 */
-	(&regs)->r20 = tsk->p_opptr->pid;
+	(&regs)->r20 = tsk->real_parent->pid;
 	return tsk->pid;
 }
 
diff -urN C8-alpha-defines/arch/alpha/kernel/ptrace.c C8-pptr/arch/alpha/kernel/ptrace.c
--- C8-alpha-defines/arch/alpha/kernel/ptrace.c	Tue Feb 19 22:32:51 2002
+++ C8-pptr/arch/alpha/kernel/ptrace.c	Thu Apr 18 23:25:18 2002
@@ -292,7 +292,7 @@
 		if (request != PTRACE_KILL)
 			goto out;
 	}
-	if (child->p_pptr != current) {
+	if (child->parent != current) {
 		DBG(DBG_MEM, ("child not parent of this process\n"));
 		goto out;
 	}
diff -urN C8-alpha-defines/arch/alpha/kernel/signal.c C8-pptr/arch/alpha/kernel/signal.c
--- C8-alpha-defines/arch/alpha/kernel/signal.c	Tue Feb 19 22:32:51 2002
+++ C8-pptr/arch/alpha/kernel/signal.c	Thu Apr 18 23:25:18 2002
@@ -661,8 +661,8 @@
 				info.si_signo = signr;
 				info.si_errno = 0;
 				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
+				info.si_pid = current->parent->pid;
+				info.si_uid = current->parent->uid;
 			}
 
 			/* If the (new) signal is now blocked, requeue it.  */
@@ -701,7 +701,7 @@
 			case SIGSTOP:
 				current->state = TASK_STOPPED;
 				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1]
+				if (!(current->parent->sig->action[SIGCHLD-1]
 				      .sa.sa_flags & SA_NOCLDSTOP))
 					notify_parent(current, SIGCHLD);
 				schedule();


