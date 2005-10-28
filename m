Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVJ1JTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVJ1JTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVJ1JTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:19:20 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:115 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965197AbVJ1JTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:19:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tNy/03G2SnJAgyHUYh+wc0m4c83GiQ69H47RTO4OR6ImpVFkvxsQ/d0Oh6FQndvmp0ta11JOGgB3Ltd1fsetZvDWXZQwDb5vvkyvnrwyCzIkI3R/yh13RNTufhe2rhPqgqmos5HO03M5tQ+tIXZFFWH9oZcBF9JreZjUsEabKy8=  ;
Message-ID: <4361EC95.5040800@yahoo.com.au>
Date: Fri, 28 Oct 2005 19:17:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Ingo Molnar'" <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better wake-balancing: respin
References: <200510270124.j9R1OPg27107@unix-os.sc.intel.com>
In-Reply-To: <200510270124.j9R1OPg27107@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Once upon a time, this patch was in -mm tree (2.6.13-mm1):
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112265450426975&w=2
> 
> It is neither in Linus's official tree, nor it is in -mm anymore.
> 
> I guess I missed the objection for dropping the patch.  I'm bringing

My objection for the patch is that it seems to be designed just to
improve your TPC - and I don't think we've seen results yet... or
did I miss that?

Also - by no means do I think improving TPC is wrong, but I think
such a patch may not be the right way to go. It doesn't seem to solve
your problem well.

Now you may have one of two problems. Well it definitely looks like
you are taking a lot of cache misses in try_to_wake_up - however this
won't be due to the load balancing stuff, but rather from locking the
remote CPUs runqueue and touching its runqueues, and cachelines in
the task_struct that had been last touched by the remote CPU.

In fact, if the balancing stuff in try_to_wake_up is working as it
should, then it will result in fewer "remote wakups" because tasks
will be moved to the same CPU that wakes them. Schedstats can tell
us a lot about this, BTW.

The second problem you may have is that the balancing stuff is going
haywire and actually causing tasks to move around too much. If this
is the case, then I really need to look at your workload (at least
schedstats output) and try to get things working a bit better. Knocking
half its brains out with a hammer is just going to make it perform
poorly in more cases without fixing your underlying problem.

Well - you may have a 3rd problem: that schedule and wake_up are simply
being called too often. What's going on with your workload? How many
context switches? What's the schedule profile look like? (we should get
a wake up profile too).

Basically I'd like to see a lot more information.

> up this discussion again.  The wake-up path is a lot hotter on numa
> system running database benchmark.  Even on a moderate 8P numa box,
> __wake_up and try_to_wake_up is showing up as #1 and #4 hottest kernel
> functions.  While on a comparable 4P smp box, these two functions are
> #5 and #9 respectively.
> 

With all else being equal, an 8P box is going to have 133% more remote
wakeups than a 4P box, and each of those cacheline transfers is going
to have a higher latency. The difference in numbers when moving from
4 to 8 way isn't very surprising.

> I think situation will be worse on 32P numa box in the wake up path.
> I don't have any measurement on 32P setup yet, because 8P numa
> performance sucks at the moment and it is a blocker for us before
> proceed any bigger setup.
> 

That's a pity. What do we suck in comparison to? What's our ratio
between actual and expected performance?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
