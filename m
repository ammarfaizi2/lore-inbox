Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbUCTMpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 07:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbUCTMpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 07:45:50 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35524
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263391AbUCTMps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 07:45:48 -0500
Date: Sat, 20 Mar 2004 13:46:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040320124639.GF9009@dualathlon.random>
References: <20040319024251.GA31498@dualathlon.random> <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 07:08:26AM +0000, Hugh Dickins wrote:
> On Fri, 19 Mar 2004, Andrea Arcangeli wrote:
> > On Thu, Mar 18, 2004 at 11:21:07PM +0000, Hugh Dickins wrote:
> > > +	if (!spin_trylock(&mm->page_table_lock))
> > > +		return 1;
> > > +
> > [..]
> > > +	if (down_trylock(&mapping->i_shared_sem))
> > > +		return 1;
> > > +	
> > 
> > those two will hang your kernel in the workload I posted to the list a
> > few days ago.
> 
> I missed the actual workload, will search the archives later.
> Fear I won't reproduce it exactly, and more anxious to plug
> the mremap-move and non-linear holes.
> 
> > With previous kernels the above didn't matter, but starting with
> > 2.6.5-rc1 it does matter, if we cannot know if it's referenced or not,
> > we must assume it's not and return 0 or it lives locks hard with all
> > tasks stuck and one must click reboot.
> 
> I don't much care whether we return 1 or 0 in that case, be happy to
> make the change if we understand _why_ it's suddenly become necessary.
> I don't remember seeing an explanation from you (and fair enough, you
> didn't want to get stuck on that detail) or anyone else.

it's the changes in the 2.6.5-rc1 page_referenced usage that requires us
to return 0, Andrew may want to elaborate those details.

if you don't fix it your set of patches will hang the box hard if you
hit swap with shared memory swap load.

> > I recommend you to share my objrmap patch, the objrmap should be exactly
> > the same for both of us.
> 
> I can't take its mm/mmap.c (and if Martin keeps that page_table_lock
> avoidance in his tree, then I think he shouldn't have followed your
> advice to skip Dave's mmap_sem in unuse_process).  But of course,
> I could have started from exactly yours and then a patch to change
> those back.  Just so long as we're aware they're not identical.
> 
> Hmm, where's page_test_and_clear_dirty gone in your final objrmap.c?

There's no such thing in Dave's objrmap patch.

> 
> There's a lot that could be shared between the two approaches.
> Nice if we kept to the same struct page layout: I put int mapcount
> after atomic_t count because almost all arches have atomic_t as an
> int, so won't that placing save us 4 bytes on the 64-bit arches?

my mapcount is an unsigned long, so it doesn't matter, but I think I can
make it an unsigned int, that sounds a good idea since I doubt anybody
will ever fork >4G processes with 2.6. Only after making it an unsigned
it it will matter to position it near the atomic_t on 64bit.
