Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbTH0A6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 20:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTH0A6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 20:58:16 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9089 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262954AbTH0A6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 20:58:09 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@digeo.com
Date: Wed, 27 Aug 2003 10:57:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test4 -- add context switch counters
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, the context switch counters reported by getrusage() are
always zero.  The appended patch adds fields to struct task_struct to
count context switches, and adds code to do the counting.

The patch adds 4 longs to struct task struct, and a single addition to
the fast path in schedule().

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1291  -> 1.1292 
#	include/linux/sched.h	1.162   -> 1.163  
#	       kernel/fork.c	1.137   -> 1.138  
#	        kernel/sys.c	1.54    -> 1.55   
#	      kernel/sched.c	1.207   -> 1.208  
#	       kernel/exit.c	1.111   -> 1.112  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/27	peterc@gelato.unsw.edu.au	1.1292
# Add context switch counters to struct task_struct; add code to 
# update them in schedule(), initialise them in copy_mm(), and copy
# them to user space in getrusage().
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Wed Aug 27 10:57:24 2003
+++ b/include/linux/sched.h	Wed Aug 27 10:57:24 2003
@@ -391,6 +391,7 @@
 	struct timer_list real_timer;
 	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
+	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Wed Aug 27 10:57:24 2003
+++ b/kernel/exit.c	Wed Aug 27 10:57:24 2003
@@ -80,6 +80,8 @@
 	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnswap += p->nswap + p->cnswap;
+	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
+	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Wed Aug 27 10:57:24 2003
+++ b/kernel/fork.c	Wed Aug 27 10:57:24 2003
@@ -461,6 +461,7 @@
 	tsk->min_flt = tsk->maj_flt = 0;
 	tsk->cmin_flt = tsk->cmaj_flt = 0;
 	tsk->nswap = tsk->cnswap = 0;
+	tsk->nvcsw = tsk->nivcsw = tsk->cnvcsw = tsk->cnivcsw = 0;
 
 	tsk->mm = NULL;
 	tsk->active_mm = NULL;
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Aug 27 10:57:24 2003
+++ b/kernel/sched.c	Wed Aug 27 10:57:24 2003
@@ -1325,8 +1325,9 @@
 		}
 	default:
 		deactivate_task(prev, rq);
+		prev->nvcsw++;
 	case TASK_RUNNING:
-		;
+		prev->nivcsw++;
 	}
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Aug 27 10:57:24 2003
+++ b/kernel/sys.c	Wed Aug 27 10:57:24 2003
@@ -1309,6 +1309,8 @@
 		case RUSAGE_SELF:
 			jiffies_to_timeval(p->utime, &r.ru_utime);
 			jiffies_to_timeval(p->stime, &r.ru_stime);
+			r.ru_nvcsw = p->nvcsw;
+			r.ru_nivcsw = p->nivcsw;
 			r.ru_minflt = p->min_flt;
 			r.ru_majflt = p->maj_flt;
 			r.ru_nswap = p->nswap;
@@ -1316,6 +1318,8 @@
 		case RUSAGE_CHILDREN:
 			jiffies_to_timeval(p->cutime, &r.ru_utime);
 			jiffies_to_timeval(p->cstime, &r.ru_stime);
+			r.ru_nvcsw = p->cnvcsw;
+			r.ru_nivcsw = p->cnivcsw;
 			r.ru_minflt = p->cmin_flt;
 			r.ru_majflt = p->cmaj_flt;
 			r.ru_nswap = p->cnswap;
@@ -1323,6 +1327,8 @@
 		default:
 			jiffies_to_timeval(p->utime + p->cutime, &r.ru_utime);
 			jiffies_to_timeval(p->stime + p->cstime, &r.ru_stime);
+			r.ru_nvcsw = p->nvcsw + p->cnvcsw;
+			r.ru_nivcsw = p->nivcsw + p->cnivcsw;
 			r.ru_minflt = p->min_flt + p->cmin_flt;
 			r.ru_majflt = p->maj_flt + p->cmaj_flt;
 			r.ru_nswap = p->nswap + p->cnswap;
