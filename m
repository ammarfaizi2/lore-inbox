Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTETNuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 09:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTETNuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 09:50:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:15314 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263786AbTETNtc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 09:49:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com
Subject: Re: userspace irq balancer
Date: Tue, 20 May 2003 09:07:41 -0500
User-Agent: KMail/1.4.3
Cc: mbligh@aracnet.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
References: <88560000.1053409990@[10.10.2.4]> <1053412583.13289.322.camel@nighthawk> <20030519.234055.35511478.davem@redhat.com>
In-Reply-To: <20030519.234055.35511478.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305200907.41443.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 May 2003 01:40, David S. Miller wrote:
>    From: Dave Hansen <haveblue@us.ibm.com>
>    Date: 19 May 2003 23:36:23 -0700
>
>    I don't even think we can do that.  That code was being integrated
>    around the same time that our Specweb setup decided to go south on us
>    and start physically frying itself.
>
> This gets more amusing by the second.  Let's kill this code
> already.  People who like the current algorithms can push
> them into the userspace solution.

Remember this all started with some idea of "fairness" among cpus and very 
little to do with performance.   particularly on P4 with HT, where the first 
logical cpu got all the ints and tasks running on that cpu were slower than 
other cpus.  This was in most cases the highest performing situation, -but- 
it was unfair to the tasks running on cpu0.  irq_balance fixed this with a 
random target cpu that was in theory supposed to not change often enough to 
preserve cache warmth.  In practice is the target cpus changed too often 
which thrashed cache and the HW overhead of changing the destination that 
often was way way to high.  

Although kirq was a step in the right direction (compared to irq_balance), I'd 
rather see it in user space in the long term, too.  That way we can make 
policy changes much much easier.  IMO, networking performance was always 
better with all net card ints going to only one cpu, -until- that cpu would 
be saturated.   This situation point can come much sooner with HT since the 
core is shared, and as far as I know, there is no way to bias the core to the 
one sibling handling ints when int load is high.  The only thing better than 
all ints to cpu0 is aligning irq a process affinity together, which is 99% 
unrealistic for all actual workloads.  

Now, if someone can figure out how/when the first cpu is saturated, and 
measure int load properly, maybe we can have a policy that keeps all ints on 
cpu0, spills some ints to another cpu when that cpu is saturated, -and- 
modifies find_busiest_queue to compensate nr_running on cpus with high int 
load to make the process thingy more fair.

If kirq gets ripped out, at least have some default policy that is somewhat 
harmless, like destination cpu = int_number % nr_cpus.   I think Suse8 had 
this, and it performed reasonably well.

-Andrew Theurer
