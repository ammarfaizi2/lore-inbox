Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVHZTW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVHZTW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVHZTW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:22:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030211AbVHZTWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:22:55 -0400
Message-Id: <20050826191837.205011000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
Date: Fri, 26 Aug 2005 12:17:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, "Kathleen Glass" <kkglass@avaya.com>,
       "James E Rhodes" <jrhodes@avaya.com>,
       Roland McGrath <roland@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 2/7] [PATCH] NPTL signal delivery deadlock fix
Content-Disposition: inline; filename=nptl-signal-delivery-deadlock-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

This bug is quite subtle and only happens in a very interesting
situation where a real-time threaded process is in the middle of a
coredump when someone whacks it with a SIGKILL. However, this deadlock
leaves the system pretty hosed and you have to reboot to recover.

Not good for real-time priority-preemption applications like our
telephony application, with 90+ real-time (SCHED_FIFO and SCHED_RR)
processes, many of them multi-threaded, interacting with each other for
high volume call processing.

Acked-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 kernel/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12.y/kernel/signal.c
===================================================================
--- linux-2.6.12.y.orig/kernel/signal.c
+++ linux-2.6.12.y/kernel/signal.c
@@ -686,7 +686,7 @@ static void handle_stop_signal(int sig, 
 {
 	struct task_struct *t;
 
-	if (p->flags & SIGNAL_GROUP_EXIT)
+	if (p->signal->flags & SIGNAL_GROUP_EXIT)
 		/*
 		 * The process is in the middle of dying already.
 		 */

--
