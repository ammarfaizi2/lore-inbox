Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUGVKyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUGVKyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 06:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUGVKyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 06:54:18 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:34209 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266459AbUGVKyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 06:54:17 -0400
Message-ID: <40FF9CD1.7050705@yahoo.com.au>
Date: Thu, 22 Jul 2004 20:54:09 +1000
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
References: <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu>
In-Reply-To: <20040722070743.GA7553@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Given that we're looking for something acceptable for 2.6, how about
>>adding
>>
>>if (rt_task(current))
>>	kick ksoftirqd instead
>>
>>Otherwise, what is the performance penalty of doing all softirq
>>processing from ksoftirqd?
> 
> 
> this is insufficient too. An RT task might be _waiting to run_ and
> spending our time in a non-RT context (including the idle task) doing
> softirq processing might delay it indefinitely.
> 
> what we could do is to add a rq->nr_running_rt and do the deferred
> softirq processing unconditionally if (rq->nr_running_rt). I'd still add
> a sysctl to make it unconditional for user processes too - if someone
> really cares about latency and doesnt want to make all his tasks RT. 
> I'll code this up for the next version of the patch.
> 

Or just if (rt_task || need_resched). Another thing that may be
worthwhile thinking about is allowing softirqs to be run directly
from interrupt if the idle thread is running, maybe with an early
exit if something becomes runnable. Although this all may be going
down the path of too much complexity.

Maybe just the simple approach of "if you care about hard latency
then let ksoftirq do everything" is best?
