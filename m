Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTDFVX0 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTDFVX0 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:23:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36261 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263101AbTDFVXY (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:23:24 -0400
Date: Sun, 06 Apr 2003 14:34:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@digeo.com>, andrea@suse.de, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Bill Irwin <wli@holomorphy.com>,
       Rik van Riel <riel@conectiva.com.br>
Subject: subobj-rmap
Message-ID: <1070000.1049664851@[10.10.2.4]>
In-Reply-To: <77670000.1049645582@[10.10.2.4]>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay><20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com>  <72740000.1049599406@[10.10.2.4]> <1049640548.962.10.camel@dhcp22.swansea.linux.org.uk> <77670000.1049645582@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Humpf. Well I have a fairly simple plan to fix it now. I'll either publish
> some code or the plan later today, once I've thought about it a bit more.

I'm not sure we need a full 2-d tree to solve this, because the 2 dimensions
aren't independant. What we have is a list of virtual ranges of the 
address_space, which might (but probably don't) overlap. If they never 
overlapped, this would be easy, we'd just keep a sorted structure (list or
tree) of regions, and find the region we lay in. In fact, Dave already did
that (sort by start addr) ... but we have to walk the rest of the chains 
as well to find other regions.

Supposing we keep a list of areas (hung from the address_space) that 
describes independant linear ranges of memory that have the same set
of vma's mapping them (call those subobjects). Each subobject has a
chain of vma's from it that are mapping that subobject.


address_space ---> subobject ---> subobject ---> subobject ---> subobject
                       |              |              |              |
                       v              v              v              v
                      vma            vma            vma            vma
                       |                             |              |
                       v                             v              v
                      vma                           vma            vma
                       |                             |        
                       v                             v        
                      vma                           vma       

Now we can just find the first element in that sorted list that maps
the address we're looking for, and it has a chain of vma's that we
need to worry about. This should solve the 100x100 case. To solve the 
1x10000 case efficiently, we should be able to just turn the subobject 
sorted list into an rbtree.

When we map a new VMA, we need to look for overlaps with existing 
subobjects. I suspect (with no real proof, save intuition) that most
of the time we'll either map a new space (create a new subobject),
or an existing space completely (just tack yourself onto the vma chain
from the subobject). If we do get a partial overlap, we'll split the
subobject in twain, and add ourselves to the overlapping part. Note that
This now starts to look very like the process's tree of vma's, so there's 
lots of potential for code-reuse. If the overlaps don't happen a lot,
(and I suspect they won't) it should be dirt cheap to do.

This is a bit more expensive on the maintainance side than objrmap, but
cheaper than pte_chains, since it's per-vma, not per-page. It should be
much cheaper than objrmap in the corner cases we've been discussing though.

Thoughts / flames?

Part 2
------

Moreover, this can be used for sys_remap_file_pages (and indeed
my though process is partly based on some discussions with Dave last week
about how to solve that). However, if people think this is too heavy,
we can still use pte-chains for this, so don't discard the above if you
have the following bit. We just keep a subobject for each linear region 
within the non-linear VMA - it might need a little more info in the 
subobject to work. Yes, it's more expense at remap time, but we don't
have to do the per-page stuff (and it's lighter than vmas). I suspect 
that's a good tradeoff (unless some crazy person is worried about mapping 
lots of windows and never using them). However, it would need to be 
benchmarked, and it's independant of the above.
