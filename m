Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbREHUBp>; Tue, 8 May 2001 16:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135239AbREHUBf>; Tue, 8 May 2001 16:01:35 -0400
Received: from quasar.osc.edu ([192.148.249.15]:12971 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S135225AbREHUBX>;
	Tue, 8 May 2001 16:01:23 -0400
Date: Tue, 8 May 2001 16:00:56 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ken Nicholson <knicholson@corp.iready.com>, Venkateshr@ami.com,
        pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Direct Sockets Support??
Message-ID: <20010508160056.B15867@quasar.osc.edu>
In-Reply-To: <034670D62D19D31180990090277A37B701811D72@mercury.corp.iready.com> <E14x7AW-0005bf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i-nntp2
In-Reply-To: <E14x7AW-0005bf-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 08, 2001 at 02:04:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> > A couple of concerns I have:
> >  * How to pin or pagelock the application buffer without
> > making a kernel transition.
> 
> You need to pin them in advance. And pinning pages is _expensive_ so you dont
> want to keep pinning/unpinning pages

I can't convince myself why this has to be so expensive.  The
current implementation does this for mlock:

    1.  Split vma if only a subset of the pages are being locked.
    2.  Mark bit in vma.
    3.  Make sure the pages are in core.

That third step has the potential of being the most expensive,
as changing the page tables requires invalidating the TLBs on all
processors.  Currently make_pages_present() does the work for 3.

But in the case of an application which fits in main memory, and
has been running for a while (so all pages are present and
dirty), all you'd really have to do is verify the page tables are
in the proper state and skip the TLB flush, right?

Then 3 turns into a single spin_lock pair for the page_table_lock, 
and walking down the page table.

The VMA splitting can be nasty, as it might require a couple of
slab allocations, and doing an AVL insertion.  (More nastiness in
the case of shared memory or file mapping, too.)  But nothing
like playing with TLBs.

Any reason why make_pages_present() is not the really oversized
hammer it seems to be?

		-- Pete
