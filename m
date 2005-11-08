Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVKHCMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVKHCMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVKHCMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:12:20 -0500
Received: from dvhart.com ([64.146.134.43]:31682 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030234AbVKHCMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:12:18 -0500
Date: Mon, 07 Nov 2005 18:12:15 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: David Lang <david.lang@digitalinsight.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Anton Blanchard <anton@samba.org>, Brian Twichell <tbrian@us.ibm.com>,
       linux-kernel@vger.kernel.org, slpratt@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
Message-ID: <112050000.1131415935@flay>
In-Reply-To: <Pine.LNX.4.62.0511071752550.9339@qynat.qvtvafvgr.pbz>
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <20051108011547.GP12353@krispykreme> <105220000.1131413677@flay> <43700371.6040507@yahoo.com.au> <Pine.LNX.4.62.0511071752550.9339@qynat.qvtvafvgr.pbz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, November 07, 2005 18:04:23 -0800 David Lang <david.lang@digitalinsight.com> wrote:

> On Tue, 8 Nov 2005, Nick Piggin wrote:
> 
>> Martin J. Bligh wrote:
>> 
>>>> Im also considering adding balance on fork for ppc64, it seems like a
>>>> lot of people like to run stream like benchmarks and Im getting tired of
>>>> telling them to lock their threads down to cpus.
>>> 
>>> 
>>> Please don't screw up everything else just for stream. It's a silly 
>>> frigging benchmark. There's very little real-world stuff that really
>>> needs balance on fork, as opposed to balance on clone, and it'll slow
>>> down everything else.
>>> 
>> 
>> Long lived and memory intensive cloned or forked tasks will often
>> [but far from always :(] want to be put on another memory controller
>> from their siblings.
>> 
>> On workloads where there are lots of short lived ones (some bloated
>> java programs), the load balancer should normally detect this and
>> cut the balance-on-fork/clone.
> 
> although if the primary workload is short-lived tasks and you don't do balance-on-fork/clone won't you have trouble ever balancing things? 
(anything that you do move over will probably exit quickly and put you 
right back where you started)

If you fork without execing a lot, with no hints, and they all exit
quickly, then yes. But I don't think that's a common workload ;-)

> at the risk of a slowdown from an extra test it almost sounds like what is needed is to get feedback from the last scheduled balance attempt and use that to decide per-fork what to do.
> 
> for example say the scheduled balance attempt leaves a per-cpu value that has it's high bit tested every fork/clone (and then rotated left 1 bit) and if it's a 1 do a balance for this new process.
> 
> with a reasonable sized item (I would guess the default int size would probably be the most efficiant to process, but even 8 bits may be enough) the scheduled balance attempt can leave quite an extensive range of behavior, from 'always balance' to 'never balance' to 'balance every 5th and 8th fork', etc.

That might work, yes. But I'd prefer to see a real workload that
suffers before worrying about it too much. You have something in mind?

>> Of course there are going to be cases where this fails. I haven't
>> seen significant slowdowns in tests, although I'm sure there would
>> be some at least small regressions. Have you seen any? Do you have
>> any tests in mind that might show a problem?
> 
> even though people will point out that it's a brin-dead workload (that should be converted to a state machine) I would expect that most fork-per-connection servers would show problems if the work per connection is small

I suspect most of those are either inetd (exec's) or multiple servers
that service requests by now. maybe not. Threads might be quicker if
it's heavy anyway ;-)

M.
