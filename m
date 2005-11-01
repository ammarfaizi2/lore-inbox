Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVKASYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVKASYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKASYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:24:40 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:6638 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751098AbVKASYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:24:39 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Tue, 1 Nov 2005 12:23:42 -0600
User-Agent: KMail/1.8
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
References: <20051030235440.6938a0e9.akpm@osdl.org> <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
In-Reply-To: <20051101135651.GA8502@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011223.43841.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 07:56, Ingo Molnar wrote:
> * Mel Gorman <mel@csn.ul.ie> wrote:
> > The set of patches do fix a lot and make a strong start at addressing
> > the fragmentation problem, just not 100% of the way. [...]
>
> do you have an expectation to be able to solve the 'fragmentation
> problem', all the time, in a 100% way, now or in the future?

Considering anybody can allocate memory and never release it, _any_ 100% 
solution is going to require migrating existing pages, regardless of 
allocation strategy.

> > So, with this set of patches, how fragmented you get is dependant on
> > the workload and it may still break down and high order allocations
> > will fail. But the current situation is that it will defiantly break
> > down. The fact is that it has been reported that memory hotplug remove
> > works with these patches and doesn't without them. Granted, this is
> > just one feature on a high-end machine, but it is one solid operation
> > we can perform with the patches and cannot without them. [...]
>
> can you always, under any circumstance hot unplug RAM with these patches
> applied? If not, do you have any expectation to reach 100%?

You're asking intentionally leading questions, aren't you?  Without on-demand 
page migration a given area of physical memory would only ever be free by 
sheer coincidence.  Less fragmented page allocation doesn't address _where_ 
the free areas are, it just tries to make them contiguous.

A page migration strategy would have to do less work if there's less 
fragmention, and it also allows you to cluster the "difficult" cases (such as 
kernel structures that just ain't moving) so you can much more easily 
hot-unplug everything else.  It also makes larger order allocations easier to 
do so drivers needing that can load as modules after boot, and it also means 
hugetlb comes a lot closer to general purpose infrastructure rather than a 
funky boot-time reservation thing.  Plus page prezeroing approaches get to 
work on larger chunks, and so on.

But any strategy to demand that "this physical memory range must be freed up 
now" will by definition require moving pages...

>  Ingo

Rob
