Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVHBM3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVHBM3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVHBM1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:27:13 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:26556 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261477AbVHBMZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:25:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=e204JyaiHUAZdpL1FKBOykA67IaXFcyb3PW4AZ2IhkqIEQFp9Qmk69Cb5KThDWqIOFAwK4+pKV2x7Pzsay6IHjvCenHGQyPZkqBITNFbTquDcEDxIuf6rysZTTAzHGctj5GZIaFm3lDOKiqxLKjk4EQky0Euwztc8GQn3uQcO98=  ;
Message-ID: <42EF6628.4070102@yahoo.com.au>
Date: Tue, 02 Aug 2005 22:25:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: [patch 2/2] sched: reduce locking in periodic balancing
References: <42EF65A9.1060408@yahoo.com.au> <42EF65FF.2000102@yahoo.com.au>
In-Reply-To: <42EF65FF.2000102@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090908010103070105090008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090908010103070105090008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/2

-- 
SUSE Labs, Novell Inc.


--------------090908010103070105090008
Content-Type: text/plain;
 name="sched-less-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-less-locking.patch"

During periodic load balancing, don't hold this runqueue's lock while
scanning remote runqueues, which can take a non trivial amount of time
especially on very large systems.

Holding the runqueue lock will only help to stabalise ->nr_running,
however this isn't doesn't do much to help because tasks being woken
will simply get held up on the runqueue lock, so ->nr_running would
not provide a really accurate picture of runqueue load in that case
anyway.

What's more, ->nr_running (and possibly the cpu_load averages) of
remote runqueues won't be stable anyway, so load balancing is always
an inexact operation.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-08-02 21:35:38.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-08-02 21:35:38.000000000 +1000
@@ -2051,7 +2051,6 @@ static int load_balance(int this_cpu, ru
 	int nr_moved, all_pinned = 0;
 	int active_balance = 0;
 
-	spin_lock(&this_rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
 
 	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
@@ -2078,18 +2077,16 @@ static int load_balance(int this_cpu, ru
 		 * still unbalanced. nr_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		double_lock_balance(this_rq, busiest);
+		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
 					imbalance, sd, idle, &all_pinned);
-		spin_unlock(&busiest->lock);
+		double_rq_unlock(this_rq, busiest);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
 		if (unlikely(all_pinned))
 			goto out_balanced;
 	}
 
-	spin_unlock(&this_rq->lock);
-
 	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[idle]);
 		sd->nr_balance_failed++;
@@ -2132,8 +2129,6 @@ static int load_balance(int this_cpu, ru
 	return nr_moved;
 
 out_balanced:
-	spin_unlock(&this_rq->lock);
-
 	schedstat_inc(sd, lb_balanced[idle]);
 
 	sd->nr_balance_failed = 0;

--------------090908010103070105090008--
Send instant messages to your online friends http://au.messenger.yahoo.com 
