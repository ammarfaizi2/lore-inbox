Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVDIHLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVDIHLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 03:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVDIHLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 03:11:37 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:39549 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261301AbVDIHLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 03:11:25 -0400
Message-ID: <42578019.7050501@yahoo.com.au>
Date: Sat, 09 Apr 2005 17:11:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com> <20050409043848.GA2677@elte.hu> <42577602.8090507@yahoo.com.au> <20050409065507.GA4866@elte.hu>
In-Reply-To: <20050409065507.GA4866@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 

>>I did propose doing unconditionally unlocked switches a while back 
>>when my patch first popped up - you were against it then, but I guess 
>>you've had second thoughts?
> 
> 
> the reordering of switch_to() and the switch_mm()-related logic was that 
> made it really worthwile and clean. I.e. we pick a task atomically, we 
> switch stacks, and then we switch the MM. Note that this setup still 
> leaves the possibility open to move the stack-switching back under the 
> irq-disabled section in a natural way.
> 

Yeah true. I didn't come up with code for you to look at at
that point anyway so you were obviously just speculating!

> 
>>It does add an extra couple of stores to on_cpu, and a wmb() for 
>>architectures that didn't previously need the unlocked switches. And 
>>ia64 needs the extra interrupt disable / enable. Probably worth it?
> 
> 
> it also removes extra stores to rq->prev_mm and other stores. I havent 
> measured any degradation on x86.
> 

Yeah true, although that is just a single cacheline (which will be
hot for any context switch heavy workload).

On the other hand, I tried put oncpu near other fields that are
accessed during context switch, so maybe its not an issue.

> If the irq disable/enable becomes widespread i'll do another patch to 
> push the irq-enabling into switch_to() so the arch can do the 
> stack-switch first and then enable interrupts and do the rest - but i 
> didnt want to complicate things unnecessarily for now.
> 
> 
>>Minor style request: I like that you're accessing ->on_cpu through 
>>functions so the !SMP case doesn't clutter the code with ifdefs... but 
>>can you do set_task_on_cpu(p) and clear_task_on_cpu(p) ?
> 
> 
> yeah, i thought about these two variants and went for set_task_on_cpu() 
> so that it's less encapsulated (it's really just a conditional 
> assignment) and that it parallels set_task_cpu() use. But no strong 
> feelings either way. Anyway, lets try what we have now, i'll do the rest 
> in deltas.
> 

Sounds good.

-- 
SUSE Labs, Novell Inc.

