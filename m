Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290656AbSAYM0r>; Fri, 25 Jan 2002 07:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290652AbSAYM02>; Fri, 25 Jan 2002 07:26:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13209 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290653AbSAYM0Y>;
	Fri, 25 Jan 2002 07:26:24 -0500
Date: Fri, 25 Jan 2002 15:23:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] set_cpus_allowed() fix, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201251516270.7264-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes set_cpus_allowed() to set p->state *before*
sending the migration IPI. This is a rare codepath used during bootup
only, so the race was never seen in action. The bug was noticed by Robert
Love.

	Ingo

--- linux/kernel/sched.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/sched.c	Fri Jan 25 12:06:36 2002
@@ -803,9 +837,9 @@
 	if (new_mask & (1UL << smp_processor_id()))
 		return;
 #if CONFIG_SMP
+	current->state = TASK_UNINTERRUPTIBLE;
 	smp_migrate_task(ffz(~new_mask), current);

-	current->state = TASK_UNINTERRUPTIBLE;
 	schedule();
 #endif
 }


