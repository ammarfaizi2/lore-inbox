Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752194AbWCJXL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbWCJXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 18:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbWCJXL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 18:11:27 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:36846 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1752010AbWCJXL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 18:11:27 -0500
Message-ID: <4412079C.5000200@bigpond.net.au>
Date: Sat, 11 Mar 2006 10:11:24 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
References: <200603102054.20077.kernel@kolivas.org> <20060310143545.74a9a92a.akpm@osdl.org>
In-Reply-To: <20060310143545.74a9a92a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 10 Mar 2006 23:11:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> 
>>+	/*
>>+	 * get_page_state is super expensive so we only perform it every
>>+	 * SWAP_CLUSTER_MAX prefetched_pages.
> 
> 
> nr_running() is similarly expensive btw.
> 
> 
>>	 * We also test if we're the only
>>+	 * task running anywhere. We want to have as little impact on all
>>+	 * resources (cpu, disk, bus etc). As this iterates over every cpu
>>+	 * we measure this infrequently.
>>+	 */
>>+	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
>>+		unsigned long cpuload = nr_running();
>>+
>>+		if (cpuload > 1)
>>+			goto out;
> 
> 
> Sorry, this is just wrong.  If swap prefetch is useful then it's also
> useful if some task happens to be sitting over in the corner calculating
> pi.

On SMP systems, something based on the run queues' raw_weighted_load 
fields (comes with smpnice patch) might be more useful than nr_running() 
as it contains information about the priority of the running tasks. 
Perhaps (raw_weighted_load() > SCHED_LOAD_SCALE) or some variation, 
where raw_weighted_load() is the sum of that field for all CPUs) would 
suffice.  It would mean "there's more than the equivalent of one nice==0 
task running" and shouldn't be any more expensive than nr_running(). 
Dividing SCHED_LOAD_SCALE by some number would be an obvious variation 
to try as would taking into account this process's contribution to the 
weighted load.

Also if this was useful there's no real reason that raw_weighted_load 
couldn't be made available on non SMP systems as well as SMP ones.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
