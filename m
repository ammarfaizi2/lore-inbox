Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267307AbUHTPup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267307AbUHTPup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268224AbUHTPup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:50:45 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:15548 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267307AbUHTPum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:50:42 -0400
Date: Fri, 20 Aug 2004 17:50:41 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CPU stuck in wake_up_forked_thread()
Message-ID: <Pine.A41.4.53.0408201742100.20680@isabelle.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems (as of 2.6.8-rc3) that there is an issue in
wake_up_forked_thread():

from kernel/sched.c:

        local_irq_save(flags);
lock_again:
        rq = cpu_rq(cpu);
        double_rq_lock(this_rq, rq);

        BUG_ON(p->state != TASK_RUNNING);

        /*
         * We did find_idlest_cpu() unlocked, so in theory
         * the mask could have changed - just dont migrate
         * in this case:
         */
        if (unlikely(!cpu_isset(cpu, p->cpus_allowed))) {
                cpu = this_cpu;
                double_rq_unlock(this_rq, rq);
                goto lock_again;
        }


But what if 'this_cpu' is not set in p->cpus_allowed ?
Then this CPU might loop here forever.

I someone is interested I have an ugly test program that does trigger
this.


One possible solution could be:

Signed-off-by: Simon Derr <Simon.Derr@bull.net>

Index: kdb_268/kernel/sched.c
===================================================================
--- kdb_268.orig/kernel/sched.c	2004-08-20 16:44:53.033231213 +0200
+++ kdb_268/kernel/sched.c	2004-08-20 17:20:35.439454969 +0200
@@ -1249,7 +1249,11 @@
 	 * in this case:
 	 */
 	if (unlikely(!cpu_isset(cpu, p->cpus_allowed))) {
-		cpu = this_cpu;
+		if (cpu_isset(this_cpu, p->cpus_allowed))
+			cpu = this_cpu;
+		else
+			cpu = first_cpu(p->cpus_allowed);
+
 		double_rq_unlock(this_rq, rq);
 		goto lock_again;
 	}
