Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUB1GKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 01:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUB1GKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 01:10:43 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:28334 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261818AbUB1GKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 01:10:39 -0500
Date: Fri, 27 Feb 2004 22:10:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <469160000.1077948622@[10.10.2.4]>
In-Reply-To: <20040228023236.GL8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 4:4 makes no sense at all, the only advantage of 4:4 w.r.t. 2:2 is that
>> > they can map 2.7G per task of shm instead of 1.7G per task of shm.
> 
> On Fri, Feb 27, 2004 at 02:03:07PM -0800, Martin J. Bligh wrote:
>> 
>> Eh? You have a 2GB difference of user address space, and a 1GB difference
>> of shm size. You lost a GB somewhere ;-) Depending on whether you move
>> TASK_UNMAPPPED_BASE or not, it you might mean 2.7 vs 0.7 or at a pinch
>> 3.5 vs 1.5, I'm not sure.
> 
> the numbers I wrote are right. No shm size is lost. The shm size is >20G,
> it doesn't fit in 4g of address space of 4:4 like it doesn't fit in 3G
> of address space of 3:1 like it doesn't fit in 2:2.

OK, I understand you can window it, but I still don't get where your
figures of 2.7GB/task vs 1.7GB per task come from?
 
> I think nobody tested 2:2 seriously on 64G boxes yet, I'm simply asking
> for that.
> 
> And I agree with you using 64G with 3:1 is not feasible for application
> like databases, it's feasible for other apps for example needing big
> caches (if you can manage to boot the machine ;) it's not a matter of
> opinion, it's a matter fact, for a generic misc load the high limit of
> 3:1 is mem=48G, which is not too bad.

48GB is sailing damned close to the wind. The problem I've had before is
distros saying "we support X GB of RAM", but it only works for some
workloads, and falls over on others. Oddly enough, that tends to upset
the customers quite a bit ;-) I'd agree with what you say - for a generic
misc load, it might work ... but I'd hate a customer to hear that and
misinterpret it.
 
> What changes between 3:1 and 2:2 is the "view" on the 20G shm file, not
> the size of the shm. you can do less simultaneous mmap with a 1.7G view
> instead of a 2.7G view. the nonlinear vma will be 1.7G in size with 2:2,
> instead of 2.7G in size with 3:1 or 4:4 (300M are as usual left for some
> hole, the binary itself and the stack)

Why is it 2.7GB with both 3:1 and 4:4 ... surely it can get bigger on 
4:4 ???

> the only chance it's faster is if you never use syscalls and you drive
> all interrupts to other cpus and you have an advantage by mapping >2G in
> the same address space. 

I think that's the key - when you need to map a LOT of data into the
address space. Unfortunately, I think that's the kind of app that the
large machines run.

> I've some doubt 4:4 runs faster anywhere. I could be wrong though.

There's only one real way to tell ;-)

>> If you send me a *simple* simulation test, I'll gladly run it for you ;-)
>> But I'm not going to go fiddle with Oracle, and thousands of disks ;-)
> 
> :)
> 
> thanks for the offer! ;) I would prefer a real life db bench since
> syscalls and irqs are an important part of the load that hurts 4:4 most,
> it doesn't need to be necessairly oracle though. And if it's a cpu with
> big tlb cache like p4 it would be prefereable. maybe we should talk
> about this offline.

I've been talking with others here about running a database workload
test, but it'll probably be on a machine with only 8GB or so. I still
think that's enough to show us something interesting.
 
> agreed. It's just lower prio at the moment since anon memory doesn't
> tend to be that much shared, so the overhead is minimal.

Yup, that's what my analysis found, most of it falls under the pte_direct
optimisation. The only problem seems to be that at fork/exec time we
set up the chain, then tear it down again, which is ugly. That's the bit
where I like Hugh's stuff.
 
>> I don't have time at the moment to go write it at the moment, but I
>> can certainly run it on large end hardware if that helps.
> 
> thanks, we should write it someday. that testcase isn't the one suitable
> for the 4:4 vs 2:2 thing though, for that a real life thing is needed
> since irqs, syscalls (and possibly page faults but not that many with a
> db) are fundamental parts of the load.  we could write a smarter
> testcase as well, but I guess using a db is simpler, evaluating 2:2 vs
> 4:4 is more a do-once thing, results won't change over time.

OK, I'll see what people here can do about that ;-)

M.

