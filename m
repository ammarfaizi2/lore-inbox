Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTBTTu3>; Thu, 20 Feb 2003 14:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBTTu3>; Thu, 20 Feb 2003 14:50:29 -0500
Received: from mx1.elte.hu ([157.181.1.137]:59547 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266933AbTBTTu2>;
	Thu, 20 Feb 2003 14:50:28 -0500
Date: Thu, 20 Feb 2003 20:57:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302202053170.2164-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302202057020.2262-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ie. something like:

(untested yet.)

--- linux/kernel/exit.c.orig2	2003-02-20 21:55:56.000000000 +0100
+++ linux/kernel/exit.c	2003-02-20 21:56:02.000000000 +0100
@@ -66,9 +66,6 @@
  
 	BUG_ON(p->state < TASK_ZOMBIE);
  
-	if (p != current)
-		wait_task_inactive(p);
-
 	atomic_dec(&p->user->processes);
 	security_task_free(p);
 	free_uid(p->user);
--- linux/kernel/fork.c.orig2	2003-02-20 21:55:59.000000000 +0100
+++ linux/kernel/fork.c	2003-02-20 21:57:07.000000000 +0100
@@ -75,6 +75,8 @@
 void __put_task_struct(struct task_struct *tsk)
 {
 	if (tsk != current) {
+	        if (tsk != current)
+			wait_task_inactive(tsk);
 		free_thread_info(tsk->thread_info);
 		kmem_cache_free(task_struct_cachep,tsk);
 	} else {

