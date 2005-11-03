Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVKCUqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVKCUqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVKCUqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:46:20 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:4773 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030471AbVKCUqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:46:19 -0500
Date: Thu, 3 Nov 2005 20:46:06 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.64.0511030955110.27915@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0511032016050.9172@skynet>
References: <4366C559.5090504@yahoo.com.au>
 <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au>
 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu>
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au>
 <306020000.1131032193@[10.10.2.4]><1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org><Pine.LNX.4.58.0511031613560.3571@skynet>
 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org><309420000.1131036740@[10.10.2.4]>
 <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]>
 <Pine.LNX.4.64.0511030955110.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Linus Torvalds wrote:

>
>
> On Thu, 3 Nov 2005, Martin J. Bligh wrote:
> > > And I suspect that by default, there should be zero of them. Ie you'd have
> > > to set them up the same way you now set up a hugetlb area.
> >
> > So ... if there are 0 by default, and I run for a while and dirty up
> > memory, how do I free any pages up to put into them? Not sure how that
> > works.
>
> You don't.
>
> Just face it - people who want memory hotplug had better know that
> beforehand (and let's be honest - in practice it's only going to work in
> virtualized environments or in environments where you can insert the new
> bank of memory and copy it over and remove the old one with hw support).
>
> Same as hugetlb.
>

For HugeTLB, there are cases were the sysadmin won't configure the server
because it's a tunable that can badly affect the machine if they get it
wrong. In those cases, the users just get small pages, the performance
penalty and are told to like it.

> Nobody sane _cares_. Nobody sane is asking for these things. Only people
> with special needs are asking for it, and they know their needs.
>
> You have to realize that the first rule of engineering is to work out the
> balances. The undeniable fact is, that 99.99% of all users will never care
> one whit, and memory management is complex and fragile. End result: the
> 0.01% of users will have to do some manual configuration to keep things
> simpler for the cases that really matter.
>

Ok, so lets consider the 99.99% of users then. One two machines, aim9
benchmarks posted during this thread show some improvements on page_test,
fork_test and brk_test, the paths you would expect to be hit by these
patches. They are very minor improvements but 99.99% of users benefit from
this. Aim9 might be considered artifical so somewhere in that 99.99% of
users are kernel developers who care about kbuild so here are the timings
of "kernel untar ; make defconfig ; make"

2.6.14-rc5-mm1:				1093 seconds
2.6.14-rc5-mm1-mbuddy-v19-withoutdefrag 1089 seconds
2.6.14-rc5-mm1-mbuddy-v19-withdefrag::  1086 seconds

The withoutdefrag mark is with the core of anti-defrag disabled via a
configure option. The option to disable was a separate patch produced
during this thread. To be really honest, I don't think a configurable page
allocator is a great idea.

Building kernels is faster with this set of patches which a few people on
this list care about. aim9 shows very minor improvements which benefit a
very large number of people and 0.01% of people who care about
fragmentation get lower fragmentation.

Of course, maybe there is something magic with my test machines (or maybe
I am willing it faster) so figures from other people wouldn't hurt whether
they show gains or regressions. On my machine at least, 99.99% of people
are still benefitting.

I am going to wait to see if people post figures that show regressions
before asking "are you still saying no?" to this set of patches

> Because the case that really matters is the sane case. The one where we
>  - don't change memory (normal)
>  - only add memory (easy)
>  - only switch out memory with hardware support (ie the _hardware_
>    supports parallel memory, and you can switch out a DIMM without
>    software ever really even noticing)
>  - have system maintainers that do strange things, but _know_ that.
>
> We simply DO NOT CARE about some theoretical "general case", because the
> general case is (a) insane and (b) impossible to cater to without
> excessive complexity.
>
> Guys, a kernel developer needs to know when to say NO.
>
> And we say NO, HELL NO!! to generic software-only memory hotplug.
>
> If you are running a DB that needs to benchmark well, you damn well KNOW
> IT IN ADVANCE, AND YOU TUNE FOR IT.
>
> Nobody takes a random machine and says "ok, we'll now put our most
> performance-critical database on this machine, and oh, btw, you can't
> reboot it and tune for it beforehand". And if you have such a person, you
> need to learn to IGNORE THE CRAZY PEOPLE.
>
> When you hear voices in your head that tell you to shoot the pope, do you
> do what they say? Same thing goes for customers and managers. They are the
> crazy voices in your head, and you need to set them right, not just
> blindly do what they ask for.
>
> 		Linus
>

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
