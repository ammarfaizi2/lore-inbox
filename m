Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSCTWAq>; Wed, 20 Mar 2002 17:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSCTWAh>; Wed, 20 Mar 2002 17:00:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23656 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285850AbSCTWA3>; Wed, 20 Mar 2002 17:00:29 -0500
Date: Wed, 20 Mar 2002 23:00:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320230002.A16801@dualathlon.random>
In-Reply-To: <127930000.1016651345@flay> <20020320212341.M4268@dualathlon.random> <20020320203520.A2003@infradead.org> <20020320223425.P4268@dualathlon.random> <20020320214607.A6363@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 09:46:07PM +0000, Christoph Hellwig wrote:
> On Wed, Mar 20, 2002 at 10:34:25PM +0100, Andrea Arcangeli wrote:
> > > The problem is not the 4GB ZONE_NORMAL but the ~1GB KVA space.
> > 
> > Then you misunderstood what's the zone-normal, the zone normal is 800M
> > in size not 4GB.
> 
> No, it was braino when writing.

never mind.

> 
> > The 1GB of KVA is what constraint the size of the zone
> > normal to 800M. We're talking about the same thing, just looking at it
> > from different point of views.
> 
> Okay agreed now after the 'reminder'.

:)

> 
> > > UnixWare/OpenUnix had huge problems getting all kernel structs for managing
> > > 16GB virtual into that - on the other hand their struct page is more
> > > then twice as big as ours..
> > 
> > We do pretty well with pte-highmem, there is some other bit that will be
> > better to optimize, but nothing major.
> 
> One major area to optimize are the kernel stacks I think.

Thet's another bit yes, but we'll need 200000 tasks to overflow the
lowmem (ignoring the fact the lowmem is shared also for the other lowmem
data structures) and there's the PID limit of 64k tasks. So I don't see
it as a major thing. Anyways if we really wanted to put the stack [and
task structure of course] in highmem, we could do that in two additional
entries after the user stack together with the two entries for the
pagecache and pagetable persistent kmaps. I think we can officially call
that area the "userfixmap" or "per-process-fixmap" (no matter if it's in
user or kernel space).  But it is much faster to keep the kernel stack
always in 4M global tlbs, thus I don't think we need to change that in
2.5.  (also USB was used to do dma in the kernel stack, not sure if they
changed it recently)

Andrea
