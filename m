Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVDNXrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVDNXrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDNXrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:47:02 -0400
Received: from mail.dif.dk ([193.138.115.101]:54658 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261654AbVDNXqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:46:53 -0400
Date: Fri, 15 Apr 2005 01:49:41 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: fix never executed code due to expression always
 false
Message-ID: <Pine.LNX.4.62.0504150140250.3466@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are two expressions in kernel/sched.c that are always false since 
they test for <0 but the result of the expression is unsigned so they will 
never be less than zero. This patch implement the logic that I believe is 
intended without the signedness issue and without the nasty casts.
<disclaimer>patch is compile tested only</disclaimer>


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 sched.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/kernel/sched.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/sched.c	2005-04-15 01:37:48.000000000 +0200
@@ -2697,9 +2697,10 @@ need_resched_nonpreemptible:
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
 	if (likely((long long)now - prev->timestamp < NS_MAX_SLEEP_AVG)) {
-		run_time = now - prev->timestamp;
-		if (unlikely((long long)now - prev->timestamp < 0))
+		if (unlikely(prev->timestamp > now))
 			run_time = 0;
+		else
+			run_time = now - prev->timestamp;
 	} else
 		run_time = NS_MAX_SLEEP_AVG;
 
@@ -2776,7 +2777,7 @@ go_idle:
 
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
-		if (unlikely((long long)now - next->timestamp < 0))
+		if (unlikely(next->timestamp > now))
 			delta = 0;
 
 		if (next->activated == 1)


