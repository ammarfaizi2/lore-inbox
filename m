Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267307AbUGVWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267307AbUGVWMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUGVWMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:12:12 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:23673 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267307AbUGVWL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:11:57 -0400
Message-ID: <41003BA3.70806@yahoo.com.au>
Date: Fri, 23 Jul 2004 08:11:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption
 Patch
References: <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au> <20040722162357.GB23972@elte.hu>
In-Reply-To: <20040722162357.GB23972@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>this is insufficient too. An RT task might be _waiting to run_ and
>>>spending our time in a non-RT context (including the idle task) doing
>>>softirq processing might delay it indefinitely.
>>>
>>>what we could do is to add a rq->nr_running_rt and do the deferred
>>>softirq processing unconditionally if (rq->nr_running_rt). I'd still add
>>>a sysctl to make it unconditional for user processes too - if someone
>>>really cares about latency and doesnt want to make all his tasks RT. 
>>>I'll code this up for the next version of the patch.
>>>
>>
>>Or just if (rt_task || need_resched). Another thing that may be
>>worthwhile thinking about is allowing softirqs to be run directly from
>>interrupt if the idle thread is running, maybe with an early exit if
>>something becomes runnable. Although this all may be going down the
>>path of too much complexity.
> 
> 
> this doesnt work either: once we've committed ourselves to do an
> 'immediate' softirq processing pass we are risking latencies. We cannot
> preempt the idle task while it's processing softirqs the same way we can
> do the lock-break if they are always deferred.
> 

It is a preempt off region no matter where it is run. I don't see how
moving it to ksoftirqd can shorten that time any further.

> Also, it's not really a performance issue if the system is idle then can
> switch to ksoftirqd cheaply (lazy-TLB) and once we switch away from
> ksoftirqd it costs as much as switching away from the idle task.

Yeah you are probably right.
