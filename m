Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVCKEQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVCKEQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVCKEM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:12:26 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:23739 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263189AbVCKEAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:00:13 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 15:00:06 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.6086.829201.185231@berry.gelato.unsw.EDU.AU>
Subject: Microstate Accounting for 2.6.11, patch 2/6
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Microstate Accounting:
Add hooks into the scheduler to track state changes.
Arrange for parent process's child times to be updated at process exit. 


 kernel/sched.c |    8 ++++++++
 kernel/exit.c  |    3 +++

Index: linux-2.6-ustate/kernel/sched.c
===================================================================
--- linux-2.6-ustate.orig/kernel/sched.c	2005-03-11 09:59:31.109628035 +1100
+++ linux-2.6-ustate/kernel/sched.c	2005-03-11 09:59:31.116463921 +1100
@@ -635,6 +635,7 @@
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
+	msa_set_timer(p, ONACTIVEQUEUE);
 	enqueue_task(p, rq->active);
 	rq->nr_running++;
 }
@@ -1238,6 +1239,7 @@
 			if (unlikely(!current->array))
 				__activate_task(p, rq);
 			else {
+				msa_set_timer(p, ONACTIVEQUEUE);
 				p->prio = current->prio;
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array = current->array;
@@ -2422,6 +2424,7 @@
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+			msa_next_state(p, ONEXPIREDQUEUE);
 			enqueue_task(p, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
 				rq->best_expired_prio = p->static_prio;
@@ -2733,6 +2736,7 @@
 		array = rq->active;
 		rq->expired_timestamp = 0;
 		rq->best_expired_prio = MAX_PRIO;
+		msa_flip_expired(prev);
 	} else
 		schedstat_inc(rq, sched_noswitch);
 
@@ -2773,6 +2777,8 @@
 		rq->curr = next;
 		++*switch_count;
 
+		msa_switch(prev, next);
+
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
@@ -3693,6 +3699,8 @@
 	 */
 	if (rt_task(current))
 		target = rq->active;
+	else
+		msa_next_state(current, ONEXPIREDQUEUE);
 
 	if (current->array->nr_active == 1) {
 		schedstat_inc(rq, yld_act_empty);


Index: linux-2.6-ustate/kernel/exit.c
===================================================================
--- linux-2.6-ustate.orig/kernel/exit.c	2005-03-11 09:59:36.360564796 +1100
+++ linux-2.6-ustate/kernel/exit.c	2005-03-11 09:59:36.364471017 +1100
@@ -93,6 +93,9 @@
 	}
 
 	sched_exit(p);
+
+	msa_update_parent(p->parent, p);
+
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
