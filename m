Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319026AbSHTObl>; Tue, 20 Aug 2002 10:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319042AbSHTObk>; Tue, 20 Aug 2002 10:31:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57016 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319026AbSHTObk>;
	Tue, 20 Aug 2002 10:31:40 -0400
Date: Tue, 20 Aug 2002 16:36:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <Pine.LNX.4.33.0208191427220.1484-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208201634410.22388-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch ontop of BK-curr fixes the ptrace wait4() anomaly that
can be observed in any previous Linux kernel i could get my hands at. So
in fact ->ptrace_children, besides being a speedup, also fixed a bug that
couldnt be fixed in any satisfactory way before.

	Ingo

--- linux/kernel/exit.c.orig	Tue Aug 20 16:28:57 2002
+++ linux/kernel/exit.c	Tue Aug 20 16:30:13 2002
@@ -731,7 +731,7 @@
 		tsk = next_thread(tsk);
 	} while (tsk != current);
 	read_unlock(&tasklist_lock);
-	if (flag) {
+	if (flag || !list_empty(&current->ptrace_children)) {
 		retval = 0;
 		if (options & WNOHANG)
 			goto end_wait4;

