Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUGWHLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUGWHLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267564AbUGWHLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:11:17 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:13489 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262406AbUGWHLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:11:14 -0400
Message-ID: <4100BA0E.3080204@yahoo.com.au>
Date: Fri, 23 Jul 2004 17:11:10 +1000
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
References: <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au> <20040722162357.GB23972@elte.hu> <41003BA3.70806@yahoo.com.au> <20040723054735.GA14108@elte.hu> <4100B403.6080402@yahoo.com.au> <20040723065504.GA15118@elte.hu>
In-Reply-To: <20040723065504.GA15118@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>look at my latest patches to see how it's done. We can preempt softirq
>>>handlers via lock-break methods. The same method doesnt work in the idle
>>
>>Are you referring to this patch?
>>http://people.redhat.com/mingo/voluntary-preempt/defer-softirqs-2.6.8-rc2-A2
> 
> 
> no, i'm referring to this one:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I1
> 
> (disregard the debugging induced complexity.)
> 

OK... help me out here, you are referring to this:

+/*
+ * Preempt a softirq context if necessary:
+ */
+int cond_resched_softirq(void)
+{
+	BUG_ON(!in_softirq());
+	if (softirq_need_resched()) {
+		__local_bh_enable();
+		__cond_resched();
+		local_bh_disable();
+		return 1;
+	}
+	return 0;
+}

To break out of softirq processing, right?

You wouldn't need to do this to break out of interrupt context softirqs
because you wouldn't bother returning to it. Just hand the work off to
ksoftirqd.

The main thing I am looking at is getting low latency softirqs without
always handing them off to ksoftirqd. Not to mention that my patch
disables softirqs in critical regions, which can't be bad for scalability.

> 
>>Surely something similar could easily be done for irq context softirq
>>processing with a patch like my earlier one? And it would prevent
>>spilling to ksoftirq when a RT thread isn't waiting to run.
> 
> 
> the softirq-defer patch is just the first step to enable lock-break of
> softirqs - the lock-break is done in the -I1 patch.
> 
> (what patch do you refer to via 'my earlier one'? Did you mean your 'if
> (rt_task())' suggestion?)
> 

Well yeah, obviously it would need a bit of help before it gets there.

But I'll shut up for now because I'm not the one doing all the coding :)
It seems like you're getting good results.
