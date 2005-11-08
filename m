Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965657AbVKHAt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965657AbVKHAt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965656AbVKHAt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:49:58 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:55906 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965651AbVKHAt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:49:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5JkoJ2wD1x8p70DvZo4I3kuS6y4ezJDlGjCvamczhkxoJET906pdAiZBJ7EhWgfZA6fZSsFOVmwiBufKsr/chkn9NGeScgxcW2snS5OpCPeM65I9dcp9EoYoOL2y78P0++hfmlfdX5d4+3xToBkJeA1QqaTl9TbuAFWjW45QbS8=  ;
Message-ID: <436FF6A6.1040708@yahoo.com.au>
Date: Tue, 08 Nov 2005 11:51:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Twichell <tbrian@us.ibm.com>
CC: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, slpratt@us.ibm.com, anton@samba.org
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com>
In-Reply-To: <436FDDE2.4000708@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Twichell wrote:
> David Lang wrote:
> 
>>   If I am understanding the data you posted, it looks like you are 
>> useing sched_yield extensivly in your database. 
> 
> 
> Yes, I've seen problems in the past with workloads that use sched_yield 
> heavily.
> 
> But bear in mind, the ~2700 sched_yields shown in the schedstats 
> occurred over a 9 minute period. That means that sched_yield is being 
> called at a rate of around 5 per second -- this is not a heavy user of 
> sched_yield.
> 
> To put this into a broader perspective, this workload has around 270 
> tasks, and the context switch rate is around
> 45,000 per second.
> 

Hi,

Thanks for your detailed report (and schedstats analysis). Sorry
I didn't see it until now.

I think you are right that the NUMA domain is probably being too
constrictive of task balancing, and that is where the regression
is coming from.

For some workloads it is definitely important to have the NUMA
domain, because it helps spread load over memory controllers as
well as CPUs - so I guess eliminating that domain is not a good
long term solution.

I would look at changing parameters of SD_NODE_INIT in include/
asm-powerpc/topology.h so they are closer to SD_CPU_INIT parameters
(ie. more aggressive).

Reducing min_ and max_interval, busy_factor, cache_hot_time, will
all do this.

I would also take a look at removing SD_WAKE_IDLE from the flags.
This flag should make balancing more aggressive, but it can have
problems when applied to a NUMA domain due to too much task
movement.

I agree that sched_yield would be unlikely to be a problem at
those rates, and either way it doesn't explain the regression.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
