Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVDFIBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVDFIBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDFIBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:01:54 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:52910 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262133AbVDFIBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:01:38 -0400
Message-ID: <4253975E.20804@yahoo.com.au>
Date: Wed, 06 Apr 2005 18:01:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 4/5] sched: RCU sched domains
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <20050406061838.GB5973@elte.hu>
In-Reply-To: <20050406061838.GB5973@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>4/5
> 
> 
>>One of the problems with the multilevel balance-on-fork/exec is that 
>>it needs to jump through hoops to satisfy sched-domain's locking 
>>semantics (that is, you may traverse your own domain when not 
>>preemptable, and you may traverse others' domains when holding their 
>>runqueue lock).
>>
>>balance-on-exec had to potentially migrate between more than one CPU 
>>before finding a final CPU to migrate to, and balance-on-fork needed 
>>to potentially take multiple runqueue locks.
>>
>>So bite the bullet and make sched-domains go completely RCU. This 
>>actually simplifies the code quite a bit.
>>
>>Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
> 
> 
> i like it conceptually, so:
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 

Oh good, thanks.

> from now on, all domain-tree readonly uses have to be rcu_read_lock()-ed 
> (or otherwise have to be in a non-preemptible section). But there's a 
> bug in show_shedstats() which does a for_each_domain() from within a 
> preemptible section. (It was a bug with the current hotplug logic too i 
> think.)
> 

Ah, thanks. That looks like a bug in the code with the locking
we have now too...

> At a minimum i think we need the fix+comment below.
> 

Well if we say "this is actually RCU", then yes. And we should
probably change the preempt_{dis|en}ables in other places to
rcu_read_lock.

OTOH, if we say we just want all running threads to process through
a preemption stage, then this would just be a preempt_disable/enable
pair.

In practice that makes no difference yet, but it looks like you and
Paul are working to distinguish these two cases in the RCU code, to
accomodate your low latency RCU stuff?

I'd prefer the latter (ie. just disable preempt, and use
synchronize_sched), but I'm not too sure of what is going on with
your the low latency RCU work...?

> 	Ingo
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 

Thanks for catching that. I may just push it through first as a fix
to the current 2.6 schedstats code (using preempt_disable), and
afterwards we can change it to rcu_read_lock if that is required.

-- 
SUSE Labs, Novell Inc.

