Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVDFRLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVDFRLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVDFRLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:11:49 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:9086 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262224AbVDFRLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:11:20 -0400
Message-ID: <42541830.1010201@yahoo.com.au>
Date: Thu, 07 Apr 2005 03:11:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org> <42523F5D.7020201@yahoo.com.au> <20050405115113.A17809@unix-os.sc.intel.com>
In-Reply-To: <20050405115113.A17809@unix-os.sc.intel.com>
Content-Type: multipart/mixed;
 boundary="------------080901040907000806030302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080901040907000806030302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Siddha, Suresh B wrote:
> On Tue, Apr 05, 2005 at 05:33:49PM +1000, Nick Piggin wrote:
> 

>>Lastly, I'd like to be a bit less intrusive with pinned task
>>handling improvements. I think we can do this while still being
>>effective in preventing livelocks.
> 
> 
> We want to see this fixed. Please post your patch and I can let you know
> the test results.
> 

Using the attached patch, a puny dual PIII-650 with ~400MB RAM swapped
itself to death after 20000 infinite loop tasks had been pinned to one
of the CPUs. See how you go.

-- 
SUSE Labs, Novell Inc.

--------------080901040907000806030302
Content-Type: text/plain;
 name="sched-relax-pinned-balancing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-relax-pinned-balancing.patch"

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-04-07 02:39:22.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-07 02:45:26.000000000 +1000
@@ -2041,6 +2041,12 @@ static runqueue_t *find_busiest_queue(st
 }
 
 /*
+ * Max backoff if we encounter pinned tasks. Pretty arbitrary value, but
+ * so long as it is large enough.
+ */
+#define MAX_PINNED_INTERVAL	1024
+
+/*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
  *
@@ -2052,7 +2058,7 @@ static int load_balance(int this_cpu, ru
 	struct sched_group *group;
 	runqueue_t *busiest;
 	unsigned long imbalance;
-	int nr_moved, all_pinned;
+	int nr_moved, all_pinned = 0;
 	int active_balance = 0;
 
 	spin_lock(&this_rq->lock);
@@ -2143,7 +2149,8 @@ out_balanced:
 
 	sd->nr_balance_failed = 0;
 	/* tune up the balancing interval */
-	if (sd->balance_interval < sd->max_interval)
+	if ((all_pinned && sd->balance_interval < MAX_PINNED_INTERVAL) ||
+			(sd->balance_interval < sd->max_interval))
 		sd->balance_interval *= 2;
 
 	return 0;

--------------080901040907000806030302--

