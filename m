Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161325AbWJSHEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161325AbWJSHEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWJSHEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:04:50 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:13929 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161325AbWJSHEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:04:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6gG1aFcXVjYS0/E60HHQqCevK8dSeRVBtBJxYxRuxjGGZoWYAFAcAbyi7bC/UCCtlvFb+IrbjrnDLdfHsNf9qfQ6lxkWNx02fqCIeJYIXDePPYxgX8WBMGRMViuiqt2TVaSpaH8TKWa2P5YeLKxd40RsN5IQn2MOqOmlYEW0n48=  ;
Message-ID: <4537238A.7060106@yahoo.com.au>
Date: Thu, 19 Oct 2006 17:04:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
References: <20061017192547.B19901@unix-os.sc.intel.com>	<20061018001424.0c22a64b.pj@sgi.com>	<20061018095621.GB15877@lnx-holt.americas.sgi.com>	<20061018031021.9920552e.pj@sgi.com>	<45361B32.8040604@yahoo.com.au>	<20061018231559.8d3ede8f.pj@sgi.com>	<45371CBB.2030409@yahoo.com.au> <20061018235746.95343e77.pj@sgi.com>
In-Reply-To: <20061018235746.95343e77.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>I don't understand why you think the "implicit" (as in, not directly user
>>controlled?) linkage is wrong.
> 
> 
> Twice now I've given the following specific example.  I am not yet
> confident that I have it right, and welcome feedback.

Sorry, I skimmed over that.

> 
> However, Suresh has apparently agreed with my conclusion that one
> can use the current linkage between cpu_exclusive cpusets and sched
> domains to get unexpected and perhaps undesirable sched domain setups.
> 
> What's your take on this example:
> 
> 
>>Example:
>>
>>    As best as I can tell (which is not very far ;), if some hapless
>>    user does the following:
>>
>>	    /dev/cpuset		cpu_exclusive == 1; cpus == 0-7
>>	    /dev/cpuset/a	cpu_exclusive == 1; cpus == 0-3
>>	    /dev/cpsuet/b	cpu_exclusive == 1; cpus == 4-7
>>
>>    and then runs a big job in the top cpuset (/dev/cpuset), then that
>>    big job will not load balance correctly, with whatever threads
>>    in the big job that got stuck on cpus 0-3 isolated from whatever
>>    threads got stuck on cpus 4-7.
>>
>>Is this correct?
> 
> 
> If I have concluded incorrectly what happens in the above example
> (good chance) then please educate me on how this stuff works.

So that depends on what cpusets asks for. If, when setting up a and
b, it asks to partition the domains, then yes that breaks the parent
cpuset gets broken.

> I should warn you that I have demonstrated a remarkable resistance
> to being educatible on this subject ;).

Don't worry about the whole sched-domains implementation if you just
consider that partitioning the domains creates a hard partition
among the system's CPUs (but the upshot is that within the partitions,
balancing works pretty nicely).

So in your above example, cpusets should only ask for a partition of
the 0-7 CPUs.

If you wanted to get fancy and detect that there are no jobs in the
root cpuset, then you could make the two smaller partitions, and revert
back to the one bigger one if something gets assigned to it.

But that's all a matter of how you want cpusets to manage it, I really
don't think a user should control this (we simply shouldn't allow
situations where we put a partition in the middle of a cpuset).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
