Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTBKUIQ>; Tue, 11 Feb 2003 15:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTBKUIQ>; Tue, 11 Feb 2003 15:08:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36111 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266135AbTBKUIO>; Tue, 11 Feb 2003 15:08:14 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [2.5.60] dcachebench sleeps
Date: Tue, 11 Feb 2003 20:14:29 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b2blj5$1bp$1@penguin.transmeta.com>
References: <20030211181807.A1261@in.ibm.com>
X-Trace: palladium.transmeta.com 1044994653 26389 127.0.0.1 (11 Feb 2003 20:17:33 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 11 Feb 2003 20:17:33 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030211181807.A1261@in.ibm.com>,
Maneesh Soni  <maneesh@in.ibm.com> wrote:
>
>With 2.5.60, dcachebench no more completes. All threads
>go to sleep as below. Last time I tested was with an intermediated BK diff 
>(diff-bk-030204-2.5.59) and it was working fine. 

This should be fixed in the current BK tree. And for the non-BK-users,
here's the relevant changeset..

		Linus

---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.997.1.20 -> 1.997.1.21
#	     kernel/signal.c	1.67    -> 1.68   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/11	torvalds@home.transmeta.com	1.997.1.21
# If we set TIF_SIGPENDING for SIGCONT, we have to wake up any sleeping
# tasks (even if we don't otherwise need to wake anything up), since
# otherwise later signals would see that signals are already pending and
# wouldn't cause wakeups.
# --------------------------------------------
#
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Tue Feb 11 12:13:43 2003
+++ b/kernel/signal.c	Tue Feb 11 12:13:43 2003
@@ -619,6 +619,7 @@
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
 		t = p;
 		do {
+			unsigned int state;
 			rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
 			
 			/*
@@ -635,9 +636,12 @@
 			 * Wake up the stopped thread _after_ setting
 			 * TIF_SIGPENDING
 			 */
-			if (!sigismember(&t->blocked, SIGCONT))
+			state = TASK_STOPPED;
+			if (!sigismember(&t->blocked, SIGCONT)) {
 				set_tsk_thread_flag(t, TIF_SIGPENDING);
-			wake_up_state(t, TASK_STOPPED);
+				state |= TASK_INTERRUPTIBLE;
+			}
+			wake_up_state(t, state);
 
 			t = next_thread(t);
 		} while (t != p);

