Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTFGQQM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTFGQQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:16:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13216 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263245AbTFGQQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:16:07 -0400
Date: Sat, 7 Jun 2003 09:29:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Always passing mm and vma down (was: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race)
Message-ID: <20030607162936.GD1552@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030530164150.A26766@us.ibm.com> <20030531104617.J672@nightmaster.csn.tu-chemnitz.de> <20030531234816.GB1408@us.ibm.com> <20030601122200.GB1455@x30.local> <20030601200056.GA1471@us.ibm.com> <20030604103808.GP3412@x30.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604103808.GP3412@x30.school.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:38:08PM +0200, Andrea Arcangeli wrote:
> On Sun, Jun 01, 2003 at 01:00:56PM -0700, Paul E. McKenney wrote:
> > The immediate motivation is to avoid the race with zap_page_range()
> > when another node writes to the corresponding portion of the file,
> > similar to the situation with vmtruncate().  The thought was to
> > leverage locking within the distributed filesystem, but if the
> > race is solved locally, then, as you say, perhaps this is not 
> > necessary.
> 
> exactly, this was my idea. Since we've the same race locally even on
> ext2, maybe it worth to share the fix for all the fs somehow, the
> problem sounds the same. You may still need callbacks to get right the
> distributed fs though. still I was just wondering if the conceptual fix
> could live in the highlevel rather than replicating it in the lowlevel.

I believe that we would need callbacks for DFSes because many of them
have different locking granularities.  For example, a number of them allow
writes from different clients to different pages of the same file
fully in parallel, with no communication between the clients required.
Communication is required only when one client attempts to write to
a page most recently written to by another client.

The locking required to support this is more complex than would
be justified in most local-filesystem cases, I suspect.  ;-)

> > This sounds good to me, though am checking with some DFS people.
> 
> cool thanks!

Good news, they are OK with your approach for handling the truncation
race!  They still believe they need the callback for handling fine-grained
locking required for invalidations.

> > > And w/o proper high level locking, the non distributed filesystems will
> > > corrupt the VM too with truncate against nopage. I already fixed this in
> > > my tree. (see the attachment) So I wonder if the fixes could be shared.
> > > I mean, you definitely need my fixes even when using the DFS on a
> > > isolated box, and if you don't need them while using the fs locally, it
> > > means we're duplicating effort somehow.
> > 
> > True -- my patches simply provided hooks to allow DFSs and local
> > filesystems to fix the problem.  
> > 
> > So, the idea is for the DFS to hold a fr_write_lock on the
> > truncate_lock across the invalidate_mmap_range() call, thus
> > preventing the PTEs from any racing pagefaults from being
> > installed?  This seems plausible at first glance, but need
> > to stare at it some more.  This might permit the current
> > do_no_page(), do_anonymous_page(), and ->nopage APIs to
> > be used, but again, need to stare at it some more.
> 
> btw, we can discuss this some more next month at OLS too, if we didn't
> clear all the issues first.

Sounds great!!!  Of course, if we get it all agreed to before then,
we will just have to find other things to talk about at OLS.  ;-)

Hopefully by that time, one of the DFSes will be released under GPL.
Don't ask.  :-/

> > (If I am not too confused, fr_write_lock() became
> > write_seqlock() in the 2.5 tree...)
> 
> exactly, I didn't rename it yet in 2.4 since it would provide no runtime
> benefit, but it is exactly the same thing ;).

Cool!  Then there is no need to worry about fr_lock getting accepted
into 2.5.  ;-)

> > > Since I don't see the users of the new hook, it's a bit hard to judje if
> > > the duplication is legitimate or not. So overall I'd agree with Andrew
> > > that to judje the patch it'd make sense to see (or know more) about the
> > > users of the hook too.
> > 
> > A simple change that takes care of all the cases certainly does
> > seem better than a more complex change that only takes care of
> > distributed filesystems!
> 
> agreed.

Unless you have other thoughts, I will take a stab at making
the patches safe for each other.

					Thanx, Paul

> thanks,
> 
> Andrea
