Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbULTDpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbULTDpP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 22:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbULTDpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 22:45:15 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62885 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261402AbULTDpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 22:45:06 -0500
Date: Sun, 19 Dec 2004 19:44:46 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: <200412182202.iBIM2RaZ030987@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412191940310.1708@schroedinger.engr.sgi.com>
References: <200412182202.iBIM2RaZ030987@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that simply removes support for negative clockids from
2.6.10-rc. The support for positive clock_id should stay the same in
future kernels and follow straighforwardly the posix API without special
encodigns for CLOCK_*_CPUTIME_ID. Roland's patches would implement
negative clockid's to access process clocks but keep the existing
interface for positive clock_ids.

Index: linux-2.6.9/kernel/posix-timers.c
===================================================================
--- linux-2.6.9.orig/kernel/posix-timers.c	2004-12-17 14:40:16.000000000 -0800
+++ linux-2.6.9/kernel/posix-timers.c	2004-12-19 19:35:43.000000000 -0800
@@ -1307,28 +1307,8 @@

 static int do_clock_gettime(clockid_t which_clock, struct timespec *tp)
 {
-	/* Process process specific clocks */
-	if (which_clock < 0) {
-		task_t *t;
-		int pid = -which_clock;
-
-		if (pid < PID_MAX_LIMIT) {
-			if ((t = find_task_by_pid(pid))) {
-				jiffies_to_timespec(process_ticks(t), tp);
-				return 0;
-			}
-			return -EINVAL;
-		}
-		if (pid < 2*PID_MAX_LIMIT) {
-			if ((t = find_task_by_pid(pid - PID_MAX_LIMIT))) {
-				jiffies_to_timespec(thread_ticks(t), tp);
-				return 0;
-			}
-			return -EINVAL;
-		}
-		/* More process specific clocks could follow here */
+	if (which_clock < 0)
 		return -EINVAL;
-	}

 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
@@ -1356,8 +1336,8 @@
 {
 	struct timespec rtn_tp;

-	/* All process clocks have the resolution of CLOCK_PROCESS_CPUTIME_ID */
-	if (which_clock < 0 ) which_clock = CLOCK_PROCESS_CPUTIME_ID;
+	if (which_clock < 0 )
+		return -EINVAL;

 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
