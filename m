Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVKHB6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVKHB6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVKHB6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:58:21 -0500
Received: from dvhart.com ([64.146.134.43]:29890 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965161AbVKHB6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:58:20 -0500
Date: Mon, 07 Nov 2005 17:58:16 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Anton Blanchard <anton@samba.org>, Brian Twichell <tbrian@us.ibm.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org, slpratt@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
Message-ID: <110320000.1131415096@flay>
In-Reply-To: <43700371.6040507@yahoo.com.au>
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <20051108011547.GP12353@krispykreme> <105220000.1131413677@flay> <43700371.6040507@yahoo.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Im also considering adding balance on fork for ppc64, it seems like a
>>> lot of people like to run stream like benchmarks and Im getting tired of
>>> telling them to lock their threads down to cpus.
>> 
>> Please don't screw up everything else just for stream. It's a silly 
>> frigging benchmark. There's very little real-world stuff that really
>> needs balance on fork, as opposed to balance on clone, and it'll slow
>> down everything else.
> 
> Long lived and memory intensive cloned or forked tasks will often
> [but far from always :(] want to be put on another memory controller
> from their siblings.
> 
> On workloads where there are lots of short lived ones (some bloated
> java programs), the load balancer should normally detect this and
> cut the balance-on-fork/clone.
> 
> Of course there are going to be cases where this fails. I haven't
> seen significant slowdowns in tests, although I'm sure there would
> be some at least small regressions. Have you seen any? Do you have
> any tests in mind that might show a problem?

Anything fork/exec-y should show it's slower. Most stuff either forks
and execs (in case it's silly to do it twice, and much cheaper to do
it at exec time), or it's a clone, in which case a different set of
rules applies for what you want (and actually, I suspect fork w/o exec
is much the same).

Of course the pig is you can't determine at fork whether it'll exec 
or not, so you optimise for the common case, which is "do exec", unless
given a hint otherwise.

For clone, and I suspect fork w/o exec, you have a tightly coupled 
group of processes that really would like to be close to each other.
If you have 1 app on the whole system, you *may* want it spread across
the system. If you have nr_apps >= nr_nodes, you probably want them
node local. Determining which workload you have is messy, and may
change.

Tweak the freak benchmark, not everything else ;-)

M.

