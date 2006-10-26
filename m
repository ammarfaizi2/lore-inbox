Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423516AbWJZQp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423516AbWJZQp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423614AbWJZQp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:45:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1233 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423516AbWJZQpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:45:55 -0400
Date: Thu, 26 Oct 2006 09:44:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 3/5] Use next_balance instead of last_balance
In-Reply-To: <4540AACE.3010804@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610260924440.16978@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
 <20061024183119.4530.64973.sendpatchset@schroedinger.engr.sgi.com>
 <4540A676.1070802@yahoo.com.au> <4540AACE.3010804@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, Nick Piggin wrote:

> Actually, it is wrong, so nack.
> 
> You didn't take into account that balance_interval may have changed,
> and so might the idle status.

Hmmmm... We change the point at which we calculate the interval relative 
to load balancing. So move it after the load balance. This also avoids 
having to do the calculation if the sched_domain has not expired.

Want a new rollup/testing cycle for all of this?

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-26 11:31:04.000000000 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-26 11:41:07.129561438 -0500
@@ -2867,15 +2867,6 @@ static void rebalance_domains(unsigned l
 		if (!(sd->flags & SD_LOAD_BALANCE))
 			continue;
 
-		interval = sd->balance_interval;
-		if (idle != SCHED_IDLE)
-			interval *= sd->busy_factor;
-
-		/* scale ms to jiffies */
-		interval = msecs_to_jiffies(interval);
-		if (unlikely(!interval))
-			interval = 1;
-
 		if (jiffies >= sd->next_balance) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
@@ -2885,6 +2876,14 @@ static void rebalance_domains(unsigned l
 				 */
 				idle = NOT_IDLE;
 			}
+			interval = sd->balance_interval;
+			if (idle != SCHED_IDLE)
+				interval *= sd->busy_factor;
+
+			/* scale ms to jiffies */
+			interval = msecs_to_jiffies(interval);
+			if (unlikely(!interval))
+				interval = 1;
 			sd->next_balance += interval;
 		}
 		next_balance = min(next_balance, sd->next_balance);
