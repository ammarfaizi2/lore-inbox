Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbULDWVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbULDWVy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbULDWVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:21:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261180AbULDWVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:21:46 -0500
Date: Sat, 4 Dec 2004 14:21:40 -0800
Message-Id: <200412042221.iB4MLeqo017550@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kladit@t-online.de (Klaus Dittrich)
Subject: [PATCH] fix bogus ECHILD return from wait* with zombie group leader
In-Reply-To: Klaus Dittrich's message of  Friday, 19 November 2004 20:01:55 +0100 <20041119190155.GA2970@xeon2.local.here>
X-Windows: you'd better sit down.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich observed this bug and posted a test case for it.  This patch
fixes both that failure mode and some others possible.  What Klaus saw was
a false negative (i.e. ECHILD when there was a child) when the group leader
was a zombie but delayed because other children live; in the test program
this happens in a race between the two threads dying on a signal.  The
change to the TASK_TRACED case avoids a potential false positive (blocking,
or WNOHANG returning 0, when there are really no children left), in the
race condition where my_ptrace_child returns zero.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -1319,6 +1319,10 @@ static long do_wait(pid_t pid, int optio
 
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
+	/*
+	 * We will set this flag if we see any child that might later
+	 * match our criteria, even if we are not able to reap it yet.
+	 */
 	flag = 0;
 	current->state = TASK_INTERRUPTIBLE;
 	read_lock(&tasklist_lock);
@@ -1337,11 +1341,14 @@ repeat:
 
 			switch (p->state) {
 			case TASK_TRACED:
-				flag = 1;
 				if (!my_ptrace_child(p))
 					continue;
 				/*FALLTHROUGH*/
 			case TASK_STOPPED:
+				/*
+				 * It's stopped now, so it might later
+				 * continue, exit, or stop again.
+				 */
 				flag = 1;
 				if (!(options & WUNTRACED) &&
 				    !my_ptrace_child(p))
@@ -1377,8 +1384,12 @@ repeat:
 						goto end;
 					break;
 				}
-				flag = 1;
 check_continued:
+				/*
+				 * It's running now, so it might later
+				 * exit, stop, or stop and then continue.
+				 */
+				flag = 1;
 				if (!unlikely(options & WCONTINUED))
 					continue;
 				retval = wait_task_continued(
