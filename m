Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWDKB5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWDKB5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDKB5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:57:16 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:12888 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932255AbWDKB5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:57:15 -0400
Message-ID: <443B0CF8.6060707@bigpond.net.au>
Date: Tue, 11 Apr 2006 11:57:12 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: move enough load to balance average load per task
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com>
In-Reply-To: <20060410181237.A26977@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 11 Apr 2006 01:57:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Mon, Apr 10, 2006 at 04:45:32PM +1000, Peter Williams wrote:
>> Problem:
>>
>> The current implementation of find_busiest_group() recognizes that 
>> approximately equal average loads per task for each group/queue are 
>> desirable (e.g. this condition will increase the probability that the 
>> top N highest priority tasks on an N CPU system will be on different 
>> CPUs) by being slightly more aggressive when *imbalance is small but the 
>> average load per task in "busiest" group is more than that in "this" 
>> group.  Unfortunately, the amount moved from "busiest" to "this" is too 
>> small to reduce the average load per task on "busiest" (at best there 
>> will be no change and at worst it will get bigger).
> 
> Peter, We don't need to reduce the average load per task on "busiest"
> always. By moving a "busiest_load_per_task", we will increase the 
> average load per task of lesser busy cpu (there by trying to achieve
> the equality with busiest...)
> 
> Can you give an example scenario where this patch helps? And doesn't
> the normal imabalance calculations capture those issues?

Yes, I think that the normal imbalance calculations (in 
find_busiest_queue()) will generally capture the aim of having 
approximately equal average loads per task on run queues.  But this bit 
of code is a special case in that the extra aggression being taken by 
the load balancer (in response to a scenario raised by you) is being 
justified by the imbalance in the average loads per task so it behooves 
us to do the best we can to ensure that that imbalance is addressed.

I don't think this is true for try_to_wake_up() and some changes may be 
desirable there.  However, any such changes would interact with the RT 
load balancing that Ingo is working on and would need to be considered 
in conjunction with that.

Why I think "approximately equal average loads per task" is worthwhile 
secondary aim for the load balancer is because it helps restore an 
implicit aim (approximately equal numbers of tasks per run queue) that 
was present in the original version.  This in turn means that the 
distribution of priorities within the queues will be similar and this 
increases the chances that (on an N CPU system) the N highest priority 
tasks will be on different CPUs.  This is a desirable state of affairs.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
