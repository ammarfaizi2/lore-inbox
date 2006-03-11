Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWCKE2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWCKE2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWCKE2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:28:21 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:41812 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932429AbWCKE2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:28:20 -0500
Message-ID: <441251DD.8080704@bigpond.net.au>
Date: Sat, 11 Mar 2006 15:28:13 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
References: <200603102054.20077.kernel@kolivas.org> <20060310143545.74a9a92a.akpm@osdl.org> <4412079C.5000200@bigpond.net.au> <200603111518.46474.kernel@kolivas.org>
In-Reply-To: <200603111518.46474.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 11 Mar 2006 04:28:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 11 March 2006 10:11, Peter Williams wrote:
> 
>>Andrew Morton wrote:
>>
>>>Con Kolivas <kernel@kolivas.org> wrote:
>>>
>>>>+	/*
>>>>+	 * get_page_state is super expensive so we only perform it every
>>>>+	 * SWAP_CLUSTER_MAX prefetched_pages.
>>>
>>>nr_running() is similarly expensive btw.
>>>
>>>
>>>>	 * We also test if we're the only
>>>>+	 * task running anywhere. We want to have as little impact on all
>>>>+	 * resources (cpu, disk, bus etc). As this iterates over every cpu
>>>>+	 * we measure this infrequently.
>>>>+	 */
>>>>+	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
>>>>+		unsigned long cpuload = nr_running();
>>>>+
>>>>+		if (cpuload > 1)
>>>>+			goto out;
>>>
>>>Sorry, this is just wrong.  If swap prefetch is useful then it's also
>>>useful if some task happens to be sitting over in the corner calculating
>>>pi.
>>
>>On SMP systems, something based on the run queues' raw_weighted_load
>>fields (comes with smpnice patch) might be more useful than nr_running()
>>as it contains information about the priority of the running tasks.
>>Perhaps (raw_weighted_load() > SCHED_LOAD_SCALE) or some variation,
>>where raw_weighted_load() is the sum of that field for all CPUs) would
>>suffice.  It would mean "there's more than the equivalent of one nice==0
>>task running" and shouldn't be any more expensive than nr_running().
>>Dividing SCHED_LOAD_SCALE by some number would be an obvious variation
>>to try as would taking into account this process's contribution to the
>>weighted load.
>>
>>Also if this was useful there's no real reason that raw_weighted_load
>>couldn't be made available on non SMP systems as well as SMP ones.
> 
> 
> That does seem reasonable, but I'm looking at total system load, not per 
> runqueue. So a global_weighted_load() function would be required to return 
> that.

Yes. That's why I said "something based on".

> Because despite what anyone seems to want to believe, reading from disk 
> hurts. Why it hurts so much I'm not really sure, but it's not a SCSI vs IDE 
> with or without DMA issue. It's not about tweaking parameters. It doesn't 
> seem to be only about cpu cycles. This is not a mistuned system that it 
> happens on. It just plain hurts if we do lots of disk i/o, perhaps it's 
> saturating the bus or something. Whatever it is, as much as I'd _like_ swap 
> prefetch to just keep working quietly at ultra ultra low priority, the disk 
> reads that swap prefetch does are not innocuous so I really do want them to 
> only be done when nothing else wants cpu.

Would you like to try a prototype version of the soft caps patch I'm 
working on to see if it will help?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
