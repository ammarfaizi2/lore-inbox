Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUCRCnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 21:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUCRCnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 21:43:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9867
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262368AbUCRCnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 21:43:53 -0500
Date: Thu, 18 Mar 2004 03:44:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040318024441.GH2113@dualathlon.random>
References: <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <20040228045713.GA388@ca-server1.us.oracle.com> <20040228061838.GO8834@dualathlon.random> <472800000.1077950719@[10.10.2.4]> <20040228070521.GQ8834@dualathlon.random> <1077959940.24528.28.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077959940.24528.28.camel@nighthawk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 01:19:01AM -0800, Dave Hansen wrote:
> On Fri, 2004-02-27 at 23:05, Andrea Arcangeli wrote:
> > > I'm not sure it's that straightforward really - doing the non-pgd aligned
> > > split is messy. 2.5 might actually be much cleaner than 3.5 though, as we
> > > never updated the mappings of the PMD that's shared between user and kernel.
> > > Hmmm ... that's quite tempting.
> > 
> > I read the 3.5:0.5 PAE sometime last year and it was pretty
> > strightforward too, the only single reason I didn't merge it is that
> > it had the problem that it changed common code that every archs depends
> > on, so it broke all other archs, but it's not really a matter of
> > difficult code, as worse it just needs a few liner change in every arch
> > to make them compile again. So I'm quite optimistic 2.5:1.5 will be
> > doable with a reasonably clean patch and with ~zero performance downside
> > compared to 3:1 and 2:2.
> 
> The only performance problem with using PMDs which are shared between
> kernel and user PTE pages is that you have a potential to be required to
> instantiate the kernel portion of the shared PMD each time you need a
> new set of page tables.  A slab for these partial PMDs is quite helpful
> in this case.  

that's a bigger cost during context switch but it's still zero cost for
the syscalls, and it never flushes away the user address space
unnecessairly. So I doubt it's measurable (unlike 4:4 which is a big hit).

> The real logistical problem with partial PMDs is just making sure that
> all of the 0 ... PTRS_PER_PMD loops are correct.  The last few times
> I've implemented it, I just made PTRS_PER_PMD take a PGD index, and made
> sure to start all of the loops from things like pmd_index(PAGE_OFFSET)
> instead of 0.  

it is indeed tricky, though your last patch for 3.5G on PAE looked fine.
But now I would like to include the 2.5:1.5 not 3.5:0.5 ;), maybe we can
support 3.5:0.5 too at the same time (though 3.5:0.5 is secondary).

> Here are a couple of patches that allowed partial user/kernel PMDs. 
> These conflicted with 4:4 and got dropped somewhere along the way, but
> the generic approaches worked.  I believe they at least compiled on all
> of the arches, too.  
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.5.68/2.5.68-mjb1/540-separate_pmd
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.5.68/2.5.68-mjb1/650-banana_split

would you be willing to implement config 15GB too (2.5:1.5)? In the next
days I'm going to work on the rbtree for the objrmap (just in case
somebody wants to swap the shm with vlm instead of mlocking it), but I
would like to get this done too ;).

you see my current tree in 2.6.5-rc1-aa1 on the ftp site, but you can
use any other kernel too since the code you will touch should be the
same for all 2.6.

It's up to you, only if you are interested, thanks.
