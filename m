Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWC0BVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWC0BVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 20:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWC0BVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 20:21:46 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:33198 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751227AbWC0BVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 20:21:46 -0500
Message-ID: <44273E26.5090203@bigpond.net.au>
Date: Mon, 27 Mar 2006 12:21:42 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: protect calculation of max_pull from integer wrap
Content-Type: multipart/mixed;
 boundary="------------000608090402040807020901"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 27 Mar 2006 01:21:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000608090402040807020901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

As the comment above the calculation of max_pull in the function states, 
there is a need to ensure that negative results of the subtractions do 
not wrap around to large numbers.  This has not been implemented for the 
(max_load - busiest_load_per_task) expression and the possible 
consequences are for undesirable movement of tasks from one group to 
another group. E.g. consider a numa system with two nodes, each
node containing four processors.  If there are two processes in node-0 
and with node-1 being completely idle,  one of those processes will be 
moved to node-1 whereas the desired behavior is to retain those two 
processes in node-0.

Fix:

Make sure that max_load is greater than busiest_load_per_task before 
making the calculation.  If it isn't max_pull will be zero and we skip 
directly to out_balanced.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------000608090402040807020901
Content-Type: text/plain;
 name="smpnice-protect-max_pull-calculation"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-protect-max_pull-calculation"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-03-27 11:07:52.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-03-27 12:08:47.000000000 +1100
@@ -2179,6 +2179,8 @@ find_busiest_group(struct sched_domain *
 	 * by pulling tasks to us.  Be careful of negative numbers as they'll
 	 * appear as very large values with unsigned longs.
 	 */
+	if (max_load <= busiest_load_per_task)
+		goto out_balanced;
 
 	/* Don't want to pull so many tasks that a group would go idle */
 	max_pull = min(max_load - avg_load, max_load - busiest_load_per_task);

--------------000608090402040807020901--
