Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289196AbSA1Or0>; Mon, 28 Jan 2002 09:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSA1OrQ>; Mon, 28 Jan 2002 09:47:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42432 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289198AbSA1Oq7>;
	Mon, 28 Jan 2002 09:46:59 -0500
Date: Mon, 28 Jan 2002 17:43:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] exit-penalty fix, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201281741480.9701-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes the EXIT_WEIGHT code to only 'punish' tasks,
never reward them. (it would be a way too easy method to boost CPU hogs
unfairly via starting up bogus threads that exit() after a few seconds.)

	Ingo

diff -rNu linux/kernel/exit.c linux/kernel/exit.c
--- linux/kernel/exit.c	Mon Jan 28 15:23:50 2002
+++ linux/kernel/exit.c	Mon Jan 28 15:24:43 2002
@@ -59,8 +59,9 @@
 	current->time_slice += p->time_slice;
 	if (current->time_slice > MAX_TIMESLICE)
 		current->time_slice = MAX_TIMESLICE;
-	current->sleep_avg = (current->sleep_avg*EXIT_WEIGHT + p->sleep_avg) /
-					(EXIT_WEIGHT + 1);
+	if (p->sleep_avg < current->sleep_avg)
+		current->sleep_avg = (current->sleep_avg * EXIT_WEIGHT +
+				p->sleep_avg) / (EXIT_WEIGHT + 1);
 	__restore_flags(flags);

 	p->pid = 0;

