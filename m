Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293109AbSB1SAy>; Thu, 28 Feb 2002 13:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293643AbSB1R55>; Thu, 28 Feb 2002 12:57:57 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:64495 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S293645AbSB1R4E>; Thu, 28 Feb 2002 12:56:04 -0500
Date: Thu, 28 Feb 2002 18:55:50 +0100 (MET)
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] scheduler: migration_task deadlock
Message-ID: <Pine.LNX.4.21.0202281852200.13192-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

