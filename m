Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVHBM3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVHBM3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVHBM1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:27:20 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:13401 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261463AbVHBMYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:24:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=sLTQg1PvpBYmdCBgDwOorqxsLz+RP46Nsn5PTOsQbB/L96ShJDYdPThvpwA72mxRg3/eexYpzzKJ94D0+sIC5AlxkSZ8vf/Rap83VDv9v7CNybaL4FJl1Qdy6oWV4ZD1ThFXI14F6BKtsfjmFJiX7D60sHApoQGOlUGUAL78nC8=  ;
Message-ID: <42EF65FF.2000102@yahoo.com.au>
Date: Tue, 02 Aug 2005 22:24:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: [patch 1/2] sched: reduce locking in newidle balancing
References: <42EF65A9.1060408@yahoo.com.au>
In-Reply-To: <42EF65A9.1060408@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050608000108030402070409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050608000108030402070409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/2

-- 
SUSE Labs, Novell Inc.


--------------050608000108030402070409
Content-Type: text/plain;
 name="sched-less-newidle-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-less-newidle-locking.patch"

Similarly to the earlier change in load_balance, only lock the runqueue
in load_balance_newidle if the busiest queue found has a nr_running > 1.
This will reduce frequency of expensive remote runqueue lock aquisitions
in the schedule() path on some workloads.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-08-02 21:35:36.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-08-02 21:56:40.000000000 +1000
@@ -2080,8 +2080,7 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
-						imbalance, sd, idle,
-						&all_pinned);
+					imbalance, sd, idle, &all_pinned);
 		spin_unlock(&busiest->lock);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
@@ -2176,18 +2175,22 @@ static int load_balance_newidle(int this
 
 	BUG_ON(busiest == this_rq);
 
-	/* Attempt to move tasks */
-	double_lock_balance(this_rq, busiest);
-
 	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
-	nr_moved = move_tasks(this_rq, this_cpu, busiest,
+
+	nr_moved = 0;
+	if (busiest->nr_running > 1) {
+		/* Attempt to move tasks */
+		double_lock_balance(this_rq, busiest);
+		nr_moved = move_tasks(this_rq, this_cpu, busiest,
 					imbalance, sd, NEWLY_IDLE, NULL);
+		spin_unlock(&busiest->lock);
+	}
+
 	if (!nr_moved)
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
 	else
 		sd->nr_balance_failed = 0;
 
-	spin_unlock(&busiest->lock);
 	return nr_moved;
 
 out_balanced:

--------------050608000108030402070409--
Send instant messages to your online friends http://au.messenger.yahoo.com 
