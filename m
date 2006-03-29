Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWC2W32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWC2W32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWC2W32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:29:28 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:7084 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751058AbWC2W31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:29:27 -0500
Message-ID: <442B0A45.90808@bigpond.net.au>
Date: Thu, 30 Mar 2006 09:29:25 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Mike Galbraith <efault@gmx.de>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: improve stability of smpnice load balancing
Content-Type: multipart/mixed;
 boundary="------------000406080309050309020505"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 29 Mar 2006 22:29:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000406080309050309020505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem:

Due to an injudicious piece of code near the end of find_busiest_group() 
smpnice load balancing is too aggressive resulting in excessive movement 
of tasks from one CPU to another.

Solution:

Remove the offending code.  The thinking that caused it to be included 
became invalid when find_busiest_queue() was modified to use average 
load per task (on the relevant run queue) instead of SCHED_LOAD_SCALE 
when evaluating small imbalance values to see whether they warranted 
being moved.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------000406080309050309020505
Content-Type: text/plain;
 name="smpnice-increase-stability"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-increase-stability"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-03-29 16:18:37.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-03-29 16:20:37.000000000 +1100
@@ -2290,13 +2290,10 @@ find_busiest_group(struct sched_domain *
 		pwr_move /= SCHED_LOAD_SCALE;
 
 		/* Move if we gain throughput */
-		if (pwr_move > pwr_now)
-			*imbalance = busiest_load_per_task;
-		/* or if there's a reasonable chance that *imbalance is big
-		 * enough to cause a move
-		 */
-		 else if (*imbalance <= busiest_load_per_task / 2)
+		if (pwr_move <= pwr_now)
 			goto out_balanced;
+
+		*imbalance = busiest_load_per_task;
 	}
 
 	return busiest;

--------------000406080309050309020505--
