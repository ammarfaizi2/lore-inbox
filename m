Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293460AbSCFKXa>; Wed, 6 Mar 2002 05:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSCFKXK>; Wed, 6 Mar 2002 05:23:10 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:4521 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S293457AbSCFKXH>; Wed, 6 Mar 2002 05:23:07 -0500
Date: Wed, 6 Mar 2002 11:22:58 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] scheduler: migration_task deadlock (resend)
Message-ID: <Pine.LNX.4.21.0203061120180.2743-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm resending this because the deadlock still exists in 2.5.6-pre2.

Regards,
Erich


---------- Resent message ----------
Date: Thu, 28 Feb 2002 18:55:50 +0100 (MET)

Hi,

in the migration scheme included into the 2.5.6-pre1 kernel there is a
potential deadlock (which I encountered several times) in the migration
task. If interrupts are not disabled before aquiring the double rq lock
this task can be interrupted by a scheduler_tick() which will spinwait
forever.

Best regards,
Erich

diff -urN 2.5.6-pre1/kernel/sched.c 2.5.6-pre1-fix/kernel/sched.c
--- 2.5.6-pre1/kernel/sched.c	Thu Feb 28 19:10:49 2002
+++ 2.5.6-pre1-fix/kernel/sched.c	Thu Feb 28 19:14:29 2002
@@ -1626,9 +1626,11 @@
 		cpu_src = p->thread_info->cpu;
 		rq_src = cpu_rq(cpu_src);
 
+		local_irq_save(flags);
 		double_rq_lock(rq_src, rq_dest);
 		if (p->thread_info->cpu != cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
+			local_irq_restore(flags);
 			goto repeat;
 		}
 		if (rq_src == rq) {
@@ -1639,6 +1641,7 @@
 			}
 		}
 		double_rq_unlock(rq_src, rq_dest);
+		local_irq_restore(flags);
 
 		up(&req->sem);
 	}


