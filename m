Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316233AbSEVQHu>; Wed, 22 May 2002 12:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSEVQHu>; Wed, 22 May 2002 12:07:50 -0400
Received: from holomorphy.com ([66.224.33.161]:52371 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316233AbSEVQHo>;
	Wed, 22 May 2002 12:07:44 -0400
Date: Wed, 22 May 2002 09:07:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
        akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020522160731.GC14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	"M. Edward Borasky" <znmeb@aracnet.com>,
	linux-kernel@vger.kernel.org, andrea@suse.de, riel@surriel.com,
	torvalds@transmeta.com, akpm@zip.com.au
In-Reply-To: <20020522143651.GA14918@holomorphy.com> <1403412981.1022057064@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 08:44:25AM -0700, Martin J. Bligh wrote:
> 1. PTEs (5000 tasks sharing a 2Gb SGA = 10GB of PTEs).
> 	We have two different implementations of highpte, Andrea's
> 	latest seems to work fairly well, and is much more scalable
> 	than earlier versions. We need to have shared	PTEs as well.
> 	I'd encourage people to benchmark the hell out of each
> 	solution, and help us come down to one, or a hybrid of both.

pte-highmem isn't enough. On an 8GB machine it's already dead. Sharing
is required just to avoid running out of space period. IIRC Dave
McCracken has been working on daniel's original pte sharing patch.


On Wed, May 22, 2002 at 08:44:25AM -0700, Martin J. Bligh wrote:
> 2. rmap pte_chains. 
> 	As far as I can see, these consume twice as much space as 
> 	the PTEs (ie 20Gb in the case above).

If the rmap is to fly at all under those conditions the reverse
translation structures and algorithm will need to be heavily revised
for space consumption. If they're not also shared in some way then they
incur the same or greater space cost as the original pagetables.


On Wed, May 22, 2002 at 08:44:25AM -0700, Martin J. Bligh wrote:
> 4. struct page
> 	Bill Irwin has already done great things in shrinking this
> 	somewhat, but I think we need to be even more drastic at 
> 	some point, and only map the PTEs we need for each process,
> 	into a task (well address-space) specific KVA area, which
> 	I call user-kernel address space or UKVA (search back for
> 	my proposal to do this a couple of months ago).

People really don't like the idea of kmapping struct page; but it is
straightforward. I've been stalling on this because people hate the
idea so badly. I'm also plotting to shrink struct page further still.

OTOH 64GB with a 32B struct page gives us a whopping 512MB of KVA
eaten alive at boot, which effectively castrates the machine.

Please, don't reply with "Get a Hammer" or "Get a 64-bit machine",
I've heard enough of that refrain already and it's also quite useless
to say, as we can neither dictate the replacement of others' hardware
nor ignore the fact their hardware isn't working.


On Wed, May 22, 2002 at 08:44:25AM -0700, Martin J. Bligh wrote:
> 5. kmap
> 	Persistent kmap sucks, and the global systemwide TLB flushes
> 	scale as O(1/N^2) with the number of CPUs. Enlarging the kmap 
> 	area helps a little, but really we need to stop doing this to
> 	ourselves. I will have a patch (hopefully within a week) to do 
> 	per-task kmap, based on the	UKVA patch that Dave McCracken has
> 	already implemented.

O(1/N^2)? wouldn't that get progressively better as the number of cpu's
grows without bound?


Cheers,
Bill
