Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTLCUbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTLCUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:31:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31891 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261332AbTLCUbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:31:20 -0500
Date: Wed, 3 Dec 2003 21:31:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312032122420.6622@earth>
Message-ID: <Pine.LNX.4.58.0312032129580.6959@earth>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <Pine.LNX.4.58.0312032059040.4438@earth>
 <Pine.LNX.4.58.0312031203430.7406@home.osdl.org> <3FCE453D.9080701@colorfullife.com>
 <Pine.LNX.4.58.0312032122420.6622@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i didnt notice the pid_alive() check within the loop - it's incorrect. If
we are within the tasklist lock and the thread group leader is valid then
the thread chain should be fully intact. The patch that i believe fixes
the bug the right way is below.

	Ingo

--- linux/fs/proc/base.c.orig	
+++ linux/fs/proc/base.c	
@@ -1666,10 +1666,14 @@ static int get_tid_list(int index, unsig
 
 	index -= 2;
 	read_lock(&tasklist_lock);
-	do {
+	/*
+	 * The starting point task (leader_task) might be an already
+	 * unlinked task, which cannot be used to access the task-list
+	 * via next_thread().
+	 */
+	if (pid_alive(task)) do {
 		int tid = task->pid;
-		if (!pid_alive(task))
-			continue;
+
 		if (--index >= 0)
 			continue;
 		tids[nr_tids] = tid;
	
