Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbUCWXf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUCWXf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:35:57 -0500
Received: from mail.ccur.com ([208.248.32.212]:43535 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262912AbUCWXf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:35:56 -0500
Date: Tue, 23 Mar 2004 18:35:54 -0500
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH] 2.6.3 Posix scheduling violation for !SCHED_OTHER
Message-ID: <20040323233554.GA24010@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
 The following fixes a problem where a SCHED_FIFO task would on occasion
be moved to the end of its runqueue when returned to from a preemption.
Cause was do to some SCHED_OTHER code in schedule() which was being
run for tasks of every policy.

Regards,
Joe


--- 2.6.3/kernel/sched.c.orig	2004-02-17 22:59:10.000000000 -0500
+++ 2.6.3/kernel/sched.c	2004-03-23 18:34:19.000000000 -0500
@@ -1677,7 +1677,7 @@
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (next->activated > 0) {
+	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
 
 		if (next->activated == 1)
