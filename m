Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUJFAnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUJFAnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUJFAnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:43:23 -0400
Received: from fmr03.intel.com ([143.183.121.5]:33704 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266512AbUJFAnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:43:20 -0400
Message-Id: <200410060042.i960gn631637@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: Default cache_hot_time value back to 10ms
Date: Tue, 5 Oct 2004 17:42:59 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSrPW1ZXV8mtWCWQIKtzmXaM1a6gg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote on Tuesday, October 05, 2004 10:31 AM
> We have experimented with similar thing, via bumping up sd->cache_hot_time to
> a very large number, like 1 sec.  What we measured was a equally low throughput.
> But that was because of not enough load balancing.

Since we are talking about load balancing, we decided to measure various
value for cache_hot_time variable to see how it affects app performance. We
first establish baseline number with vanilla base kernel (default at 2.5ms),
then sweep that variable up to 1000ms.  All of the experiments are done with
Ingo's patch posted earlier.  Here are the result (test environment is 4-way
SMP machine, 32 GB memory, 500 disks running industry standard db transaction
processing workload):

cache_hot_time  | workload throughput
--------------------------------------
         2.5ms  - 100.0   (0% idle)
         5ms    - 106.0   (0% idle)
         10ms   - 112.5   (1% idle)
         15ms   - 111.6   (3% idle)
         25ms   - 111.1   (5% idle)
         250ms  - 105.6   (7% idle)
         1000ms - 105.4   (7% idle)

Clearly the default value for SMP has the worst application throughput (12%
below peak performance).  When set too low, kernel is too aggressive on load
balancing and we are still seeing cache thrashing despite the perf fix.
However, If set too high, kernel gets too conservative and not doing enough
load balance.

This value was default to 10ms before domain scheduler, why does domain
scheduler need to change it to 2.5ms? And on what bases does that decision
take place?  We are proposing change that number back to 10ms.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.9-rc3/kernel/sched.c.orig	2004-10-05 17:37:21.000000000 -0700
+++ linux-2.6.9-rc3/kernel/sched.c	2004-10-05 17:38:02.000000000 -0700
@@ -387,7 +387,7 @@ struct sched_domain {
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000/2),	\
+	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_BALANCE_NEWIDLE	\


