Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWCNJtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWCNJtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbWCNJtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:49:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:57028 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751867AbWCNJtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:49:49 -0500
X-Authenticated: #14349625
Subject: [2.6.16-rc6 patch] remove sleep_avg multiplier
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 10:51:01 +0100
Message-Id: <1142329861.9710.16.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The patchlet below removes the sleep_avg multiplier.  This multiplier
was necessary back when we had 10 seconds of dynamic range in sleep_avg,
but now that we only have one second, it causes that one second to be
compressed down to 100ms in some cases.  This is particularly noticeable
when compiling a kernel in a slow NFS mount, and I believe it to be a
very likely candidate for other recently reported network related
interactivity problems.

In testing, I can detect no negative impact of this removal.  IMHO, this
constitutes a bug-fix, and as such is suitable for 2.6.16.

	-Mike

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16rc6/kernel/sched.c.org	2006-03-14 10:30:35.000000000 +0100
+++ linux-2.6.16rc6/kernel/sched.c	2006-03-14 10:31:13.000000000 +0100
@@ -707,12 +707,6 @@
 						DEF_TIMESLICE);
 		} else {
 			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time.
-			 */
-			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
-
-			/*
 			 * Tasks waking from uninterruptible sleep are
 			 * limited in their sleep_avg rise as they
 			 * are likely to be waiting on I/O


