Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVHBGJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVHBGJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVHBGJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:09:25 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:60283 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261267AbVHBGJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:09:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=yqQzD9G/hglw8LRt1rTCRNl1gLxtreurw7c7XFIz9rBiwZTfuo2izb/+mxC07bhewNOzWPNYvPUjPIdoOS2g5j+poIvkvbumUKVmeLnEEPjOooDJLqNOtBCd6Pace6IeqPgtERfJ8huHy8z1c6aZ/fVGIyvUCFwor7XifYODqDs=  ;
Message-ID: <42EF0E0D.8000906@yahoo.com.au>
Date: Tue, 02 Aug 2005 16:09:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org,
       steiner@sgi.com
Subject: Re: [Patch] don't kick ALB in the presence of pinned task
References: <20050801174221.B11610@unix-os.sc.intel.com>
In-Reply-To: <20050801174221.B11610@unix-os.sc.intel.com>
Content-Type: multipart/mixed;
 boundary="------------080102050607010009070300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080102050607010009070300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Siddha, Suresh B wrote:
> Jack Steiner brought this issue at my OLS talk.
> 
> Take a scenario where two tasks are pinned to two HT threads in a physical
> package. Idle packages in the system will keep kicking migration_thread
> on the busy package with out any success.
> 
> We will run into similar scenarios in the presence of CMP/NUMA.
> 
> Patch appended.
> 

Hmm, I would have hoped the new "all_pinned" logic should have
handled this case properly. Are you actually seeing this happen?

I have a patch here which I still need to do more testing with,
which might help performance on HT systems.

I found that idle siblings could cause SMP and NUMA balancing to
be too aggressive in some cases.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------080102050607010009070300
Content-Type: text/plain;
 name="sched-opt-ht.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-opt-ht.patch"

If an idle sibling of an HT queue encounters a busy sibling, then
make higher level load balancing of the non-idle variety.

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-07-29 19:30:39.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-07-29 19:35:01.000000000 +1000
@@ -1889,7 +1889,7 @@ out:
  */
 static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
-		   unsigned long *imbalance, enum idle_type idle)
+		   unsigned long *imbalance, enum idle_type idle, int *sd_idle)
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
@@ -1914,6 +1914,9 @@ find_busiest_group(struct sched_domain *
 		avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
+			if (*sd_idle && !idle_cpu(i))
+				*sd_idle = 0;
+
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
 				load = target_load(i, load_idx);
@@ -2057,11 +2060,15 @@ static int load_balance(int this_cpu, ru
 	unsigned long imbalance;
 	int nr_moved, all_pinned = 0;
 	int active_balance = 0;
+	int sd_idle = 0;
+
+	if (idle != NOT_IDLE && sd->flags & SD_SHARE_CPUPOWER)
+		sd_idle = 1;
 
 	spin_lock(&this_rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
 
-	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
+	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[idle]);
 		goto out_balanced;
@@ -2136,6 +2143,8 @@ static int load_balance(int this_cpu, ru
 			sd->balance_interval *= 2;
 	}
 
+	if (!nr_moved && !sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+		return -1;
 	return nr_moved;
 
 out_balanced:
@@ -2149,6 +2158,8 @@ out_balanced:
 			(sd->balance_interval < sd->max_interval))
 		sd->balance_interval *= 2;
 
+	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+		return -1;
 	return 0;
 }
 
@@ -2166,9 +2177,13 @@ static int load_balance_newidle(int this
 	runqueue_t *busiest = NULL;
 	unsigned long imbalance;
 	int nr_moved = 0;
+	int sd_idle = 0;
 
+	if (sd->flags & SD_SHARE_CPUPOWER)
+		sd_idle = 1;
+	
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
-	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
+	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE, &sd_idle);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2193,15 +2208,19 @@ static int load_balance_newidle(int this
 		spin_unlock(&busiest->lock);
 	}
 
-	if (!nr_moved)
+	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
-	else
+		if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+			return -1;
+	} else
 		sd->nr_balance_failed = 0;
 
 	return nr_moved;
 
 out_balanced:
 	schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
+	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+		return -1;
 	sd->nr_balance_failed = 0;
 	return 0;
 }

--------------080102050607010009070300--
Send instant messages to your online friends http://au.messenger.yahoo.com 
