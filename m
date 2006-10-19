Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWJSIRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWJSIRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbWJSIRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:17:06 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:55673 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422805AbWJSIRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:17:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=C6fSkCREZmBzICW+b83S0akjJ0vV/Tp6fv8JwEWngI0ZFPUrUpRmzf3f/2ffNrpkjPJ1Oo7JkJAB6B97OukKWrECPCWbsu0wJ+ib9t0UKoV+Ouxc/BTg9BxnfAD+dDgEvcQLfyeWgCH3sVDR/X1Gcws9dlvOEGuwGmYbirk44AY=  ;
Message-ID: <45373478.1030004@yahoo.com.au>
Date: Thu, 19 Oct 2006 18:16:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
References: <20061017192547.B19901@unix-os.sc.intel.com>	<20061018001424.0c22a64b.pj@sgi.com>	<20061018095621.GB15877@lnx-holt.americas.sgi.com>	<20061018031021.9920552e.pj@sgi.com>	<45361B32.8040604@yahoo.com.au>	<20061018231559.8d3ede8f.pj@sgi.com>	<45371CBB.2030409@yahoo.com.au>	<20061018235746.95343e77.pj@sgi.com>	<4537238A.7060106@yahoo.com.au> <20061019003316.f6a77b34.pj@sgi.com>
In-Reply-To: <20061019003316.f6a77b34.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>So that depends on what cpusets asks for. If, when setting up a and
>>b, it asks to partition the domains, then yes that breaks the parent
>>cpuset gets broken.
> 
> 
> That probably makes good sense from the sched domain side of things.
> 
> It is insanely counterintuitive from the cpuset side of things.
> 
> Using heirarchical cpuset properties to drive this is the wrong
> approach.
> 
> In the general case, looking at it (as best I can) from the sched
> domain side of things, it seems that the sched domain could be
> defined on a system as follows.
> 
>     Partition the CPUs on the system - into one or more subsets
>     (partitions), non-overlapping, and covering.
> 
>     Each of those partitions can either have a sched domain setup on
>     it, to support load balancing across the CPUs in that partition,
>     or can be isolated, with no load balancing occuring within that
>     partition.
> 
>     No load balancing occurs across partitions.

Correct. But you don't have to treat isolated CPUs differently - they
are just the degenerate case of a partition of 1 CPU. I assume cpusets
could create similar "isolated" domains where no balancing takes place.

> Using cpu_exclusive cpusets for this is next to impossible.  It could
> be approximated perhaps by having just the immediate children of the
> root cpuset, /dev/cpuset/*, define the partition.

Fine.

> But if any lower level cpusets have any affect on the partitioning,
> by setting their cpu_exclusive flag in the current implementation,
> it is -always- the case, by the basic structure of the cpuset
> hierarchy, that the lower level cpuset is a subset of its parents
> cpus, and that that parent also has cpu_exclusive set.
> 
> The resulting partitioning, even in such simple examples as above, is
> not obvious.  If you look back a couple days, when I first presented
> essentially this example, I got the resulting sched domain partitioning
> entirely wrong.
> 
> The essential detail in my big patch of yesterday, to add new specific
> sched_domain flags to cpusets, is that it -removed- the requirement to
> mark a parent as defining a sched domain anytime a child defined one.
> 
> That requirement is one of the defining properties of the cpu_exclusive
> flag, and makes that flag -outrageously- unsuited for defining sched
> domain partitions.

So make the new rule "cpu_exclusive && direct-child-of-root-cpuset".
Your problems go away, and they haven't been pushed to userspace.

If a user wants to, for some crazy reason, have a set of cpu_exclusive
sets deep in the cpuset hierarchy, such that no load balancing happens
between them... just tell them they can't; they should just make those
cpusets children of the root.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
