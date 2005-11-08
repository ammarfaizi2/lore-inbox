Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVKHCFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVKHCFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbVKHCEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:04:54 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:41135 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S965211AbVKHCEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:04:43 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Anton Blanchard <anton@samba.org>,
       Brian Twichell <tbrian@us.ibm.com>, linux-kernel@vger.kernel.org,
       slpratt@us.ibm.com
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <43700371.6040507@yahoo.com.au>
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <20051108011547.GP12353@krispykreme> <105220000.1131413677@flay> <43700371.6040507@yahoo.com.au>
Date: Mon, 7 Nov 2005 18:04:23 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Database regression due to scheduler changes ?
In-Reply-To: <43700371.6040507@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0511071752550.9339@qynat.qvtvafvgr.pbz>
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz>
 <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au>
 <20051108011547.GP12353@krispykreme> <105220000.1131413677@flay>
 <43700371.6040507@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Nick Piggin wrote:

> Martin J. Bligh wrote:
>
>>> Im also considering adding balance on fork for ppc64, it seems like a
>>> lot of people like to run stream like benchmarks and Im getting tired of
>>> telling them to lock their threads down to cpus.
>> 
>> 
>> Please don't screw up everything else just for stream. It's a silly 
>> frigging benchmark. There's very little real-world stuff that really
>> needs balance on fork, as opposed to balance on clone, and it'll slow
>> down everything else.
>> 
>
> Long lived and memory intensive cloned or forked tasks will often
> [but far from always :(] want to be put on another memory controller
> from their siblings.
>
> On workloads where there are lots of short lived ones (some bloated
> java programs), the load balancer should normally detect this and
> cut the balance-on-fork/clone.

although if the primary workload is short-lived tasks and you don't do 
balance-on-fork/clone won't you have trouble ever balancing things? 
(anything that you do move over will probably exit quickly and put you 
right back where you started)

at the risk of a slowdown from an extra test it almost sounds like what is 
needed is to get feedback from the last scheduled balance attempt and use 
that to decide per-fork what to do.

for example say the scheduled balance attempt leaves a per-cpu value that 
has it's high bit tested every fork/clone (and then rotated left 1 bit) 
and if it's a 1 do a balance for this new process.

with a reasonable sized item (I would guess the default int size would 
probably be the most efficiant to process, but even 8 bits may be enough) 
the scheduled balance attempt can leave quite an extensive range of 
behavior, from 'always balance' to 'never balance' to 'balance every 5th 
and 8th fork', etc.

> Of course there are going to be cases where this fails. I haven't
> seen significant slowdowns in tests, although I'm sure there would
> be some at least small regressions. Have you seen any? Do you have
> any tests in mind that might show a problem?

even though people will point out that it's a brin-dead workload (that 
should be converted to a state machine) I would expect that most 
fork-per-connection servers would show problems if the work per connection 
is small

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
