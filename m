Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUB1JTr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 04:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUB1JTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 04:19:47 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28629 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261159AbUB1JTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 04:19:45 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040228070521.GQ8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random>
	 <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
	 <20040227122936.4c1be1fd.akpm@osdl.org>
	 <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay>
	 <20040228023236.GL8834@dualathlon.random>
	 <20040228045713.GA388@ca-server1.us.oracle.com>
	 <20040228061838.GO8834@dualathlon.random>
	 <472800000.1077950719@[10.10.2.4]>
	 <20040228070521.GQ8834@dualathlon.random>
Content-Type: text/plain
Message-Id: <1077959940.24528.28.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 01:19:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 23:05, Andrea Arcangeli wrote:
> > I'm not sure it's that straightforward really - doing the non-pgd aligned
> > split is messy. 2.5 might actually be much cleaner than 3.5 though, as we
> > never updated the mappings of the PMD that's shared between user and kernel.
> > Hmmm ... that's quite tempting.
> 
> I read the 3.5:0.5 PAE sometime last year and it was pretty
> strightforward too, the only single reason I didn't merge it is that
> it had the problem that it changed common code that every archs depends
> on, so it broke all other archs, but it's not really a matter of
> difficult code, as worse it just needs a few liner change in every arch
> to make them compile again. So I'm quite optimistic 2.5:1.5 will be
> doable with a reasonably clean patch and with ~zero performance downside
> compared to 3:1 and 2:2.

The only performance problem with using PMDs which are shared between
kernel and user PTE pages is that you have a potential to be required to
instantiate the kernel portion of the shared PMD each time you need a
new set of page tables.  A slab for these partial PMDs is quite helpful
in this case.  

The real logistical problem with partial PMDs is just making sure that
all of the 0 ... PTRS_PER_PMD loops are correct.  The last few times
I've implemented it, I just made PTRS_PER_PMD take a PGD index, and made
sure to start all of the loops from things like pmd_index(PAGE_OFFSET)
instead of 0.  

Here are a couple of patches that allowed partial user/kernel PMDs. 
These conflicted with 4:4 and got dropped somewhere along the way, but
the generic approaches worked.  I believe they at least compiled on all
of the arches, too.  

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.5.68/2.5.68-mjb1/540-separate_pmd
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.5.68/2.5.68-mjb1/650-banana_split

-- dave

