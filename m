Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWFVJK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWFVJK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWFVJKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:10:23 -0400
Received: from www.osadl.org ([213.239.205.134]:64989 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161011AbWFVJJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:09:54 -0400
Message-Id: <20060622082812.492564000@cruncher.tec.linutronix.de>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
Date: Thu, 22 Jun 2006 09:08:38 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 1/3] Drop tasklist lock in do_sched_setscheduler
Content-Disposition: inline;
	filename=drop-tasklist-lock-in-do-sched-setscheduler.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no need to hold tasklist_lock across the setscheduler call, when we
pin the task structure with get_task_struct(). Interrupts are disabled in 
setscheduler anyway and the permission checks do not need interrupts disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.17-mm/kernel/sched.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
+++ linux-2.6.17-mm/kernel/sched.c	2006-06-22 10:26:11.000000000 +0200
@@ -4140,8 +4140,10 @@
 		read_unlock_irq(&tasklist_lock);
 		return -ESRCH;
 	}
-	retval = sched_setscheduler(p, policy, &lparam);
+	get_task_struct(p);
 	read_unlock_irq(&tasklist_lock);
+	retval = sched_setscheduler(p, policy, &lparam);
+	put_task_struct(p);
 	return retval;
 }
 

--

