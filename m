Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVDFIJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVDFIJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVDFIJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:09:47 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:51893 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261983AbVDFIJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:09:36 -0400
Message-ID: <4253993C.4020505@yahoo.com.au>
Date: Wed, 06 Apr 2005 18:09:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 5/5] sched: consolidate sbe sbf
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <42532427.3030100@yahoo.com.au> <20050406062723.GC5973@elte.hu>
In-Reply-To: <20050406062723.GC5973@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>5/5
>>
>>Any ideas about what to do with schedstats?
>>Do we really need balance on exec and fork as seperate
>>statistics?
> 
> 
>>Consolidate balance-on-exec with balance-on-fork. This is made easy
>>by the sched-domains RCU patches.
>>
>>As well as the general goodness of code reduction, this allows
>>the runqueues to be unlocked during balance-on-fork.
>>
>>schedstats is a problem. Maybe just have balance-on-event instead
>>of distinguishing fork and exec?
>>
>>Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
> 
> 
> looks good.
> 

One problem I just noticed, sorry. This is doing set_cpus_allowed
without holding the runqueue lock and without checking the hard
affinity mask either.

We could just do a set_cpus_allowed, or take the lock, set_cpus_allowed,
and take the new lock, but that's probably a bit heavy if we can avoid it.
In the interests of speed in this fast path, do you think we can do this
in sched_fork, before the task has even been put on the tasklist?

That would avoid all locking problems. Passing clone_flags into sched_fork
would not be a problem if we want to distinguish fork() and clone(CLONE_VM).

Yes? I'll cut a new patch to do just that.

>  Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> while the code is now consolidated, i think we still need the separate 
> fork/exec stats for schedstat.

This makes it a bit harder then, to get good stats in the sched-domain
(which is really what we want). It would basically mean doing
if (balance fork)
	schedstat_inc(sbf_cnt);
else if (balance exec)
	schedstat_inc(sbe_cnt);
etc.

That should all get optimised out by the compiler, but still a bit ugly.
Any ideas?


-- 
SUSE Labs, Novell Inc.

