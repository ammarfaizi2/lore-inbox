Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVDPBnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVDPBnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVDPBnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:43:50 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:24165 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262558AbVDPBnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:43:47 -0400
Message-ID: <42606DCA.8050602@yahoo.com.au>
Date: Sat, 16 Apr 2005 11:43:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix sched domain degenerate
References: <20050413192616.A28163@unix-os.sc.intel.com> <425FBB98.2000200@yahoo.com.au> <20050415163633.C7296@unix-os.sc.intel.com>
In-Reply-To: <20050415163633.C7296@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Fri, Apr 15, 2005 at 11:03:20PM +1000, Nick Piggin wrote:
> 
>>Index: linux-2.6/kernel/sched.c
>>===================================================================
>>--- linux-2.6.orig/kernel/sched.c	2005-04-15 22:52:25.000000000 +1000
>>+++ linux-2.6/kernel/sched.c	2005-04-15 22:58:54.000000000 +1000
>>@@ -4844,7 +4844,14 @@ static int __devinit sd_parent_degenerat
>> 	/* WAKE_BALANCE is a subset of WAKE_AFFINE */
>> 	if (cflags & SD_WAKE_AFFINE)
>> 		pflags &= ~SD_WAKE_BALANCE;
>>-	if ((~sd->flags) & parent->flags)
>>+	/* Flags needing groups don't count if only 1 group in parent */
>>+	if (parent->groups == parent->groups->next) {
>>+		pflags &= ~(SD_LOAD_BALANCE |
>>+				SD_BALANCE_NEWIDLE |
>>+				SD_BALANCE_FORK |
>>+				SD_BALANCE_EXEC);
>>+	}
> 
> 
> This patch works fine and I like this fix. But should n't we be adding 
> SD_WAKE_AFFINE and SD_WAKE_BALANCE to this list?
> 

Hmm, well they don't use groups, but I guess they can be excluded,
because if the parent span is the same as the child span (and that
is true at this point), then SD_WAKE_AFFFINE/BALANCE in the parent
will never be executed. Good point.

wake_idle should be doing a similar thing too, but that needs a bit
of work.

> And about SD_BALANCE_FORK, now that we have multi level sbe/sbf, we should 
> add this flag to SD_CPU/SIBLING_INIT too..
> 

I guess we should think about it. It depends - does SD_BALANCE_FORK
make sense on a plain SMP machine? If so, then it probably makes
sense to be in the 'SMP' domain on a NUMA system, otherwise not.

I suspect that for BALANCE_FORK, the answer may be no. On an SMP, it
is far less disastrous to misplace tasks and have them picked up by
the periodic rebalancer. What's more, BALANCE_FORK does add a non
trivial overhead when moving tasks to other CPUs.

But it's open for debate. I haven't done comprehensive tests.

-- 
SUSE Labs, Novell Inc.

