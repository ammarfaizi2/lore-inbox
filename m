Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVDLADL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVDLADL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDLADL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:03:11 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:62616 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261792AbVDLADE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:03:04 -0400
Message-ID: <425B1034.6080906@yahoo.com.au>
Date: Tue, 12 Apr 2005 10:03:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 4/5] sched: RCU sched domains
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <20050406061838.GB5973@elte.hu> <4253975E.20804@yahoo.com.au> <20050407071101.GA26607@elte.hu> <4254E830.5040703@yahoo.com.au> <20050411221506.GA1304@us.ibm.com>
In-Reply-To: <20050411221506.GA1304@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Thu, Apr 07, 2005 at 05:58:40PM +1000, Nick Piggin wrote:
> 

>>
>>OK thanks for the good explanation. So I'll keep it as is for now,
>>and whatever needs cleaning up later can be worked out as it comes
>>up.
> 
> 
> Looking forward to the split of synchronize_kernel() into synchronize_rcu()
> and synchronize_sched(), the two choices are:
> 
> o	Use synchronize_rcu(), but insert rcu_read_lock()/rcu_read_unlock()
> 	pairs on the read side.
> 
> o	Use synchronize_sched(), and make sure all read-side code is
> 	under preempt_disable().
> 

Yep, I think we'll go for the second option initially (because that
pretty closely matches the homebrew locking scheme that it used to
use).

> Either way, there may also need to be some rcu_dereference()s when picking
> up pointer and rcu_assign_pointer()s when updating the pointers.
> For example, if traversing the domain parent list is to be RCU protected,
> the for_each_domain() macro should change to something like:
> 

Yes, I think you're right, because there's no barriers or synchronisation
when attaching a new domain. Just a small point though:

> #define for_each_domain(cpu, domain) \
> 	for (domain = cpu_rq(cpu)->sd; domain; domain = rcu_dereference(domain->parent))
> 

This should probably be done like so?

#define for_each_domain(cpu, domain) \
	for (domain = rcu_dereference(cpu_rq(cpu)->sd); domain; domain = domain->parent)

And I think it would be wise to use rcu_assign_pointer in the update too.
Thanks Paul.

-- 
SUSE Labs, Novell Inc.

