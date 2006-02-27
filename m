Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWB0ATL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWB0ATL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWB0ATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:19:11 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:13296 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751456AbWB0ATJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:19:09 -0500
Date: Mon, 27 Feb 2006 11:18:23 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: RFC: Block reservation for hugetlbfs
Message-ID: <20060227001823.GB24422@localhost.localdomain>
Mail-Followup-To: David Gibson <dwg@au1.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20060221022124.GA18535@localhost.localdomain> <43FA94B3.4040904@yahoo.com.au> <20060221233950.GB20872@localhost.localdomain> <43FBB292.1000304@yahoo.com.au> <20060222021106.GB23574@localhost.localdomain> <43FBD5D5.5020706@yahoo.com.au> <20060224041154.GF28368@localhost.localdomain> <43FEA60E.5040607@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FEA60E.5040607@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 05:22:06PM +1100, Nick Piggin wrote:
> David Gibson wrote:
> >On Wed, Feb 22, 2006 at 02:09:09PM +1100, Nick Piggin wrote:
> 
> >>I mean a new core mm lock depenency (ie. lru_lock -> tree_lock).
> >>
> >>But I must have been smoking something last night: for the life
> >>of me I can't see why I thought there was already a hugetlb_lock
> >>-> lru_lock dependency in there...?!
> >>
> >>So I retract my statement. What you have there seems OK.
> >
> >
> >Sadly, you weren't smoking something, and it's not OK.  As akpm
> >pointed out later, the lru_lock dependecy is via __free_pages() which
> >is called from update_and_free_page() with hugetlb_lock held.
> 
> You're either thinking of zone->lock, or put_page/page_cache_release.
> The former is happy to nest inside anything because it is confined to
> page_alloc. The latter AFAIKS is not called from inside the hugepage
> lock.

Um.. I guess so.  I know I spotted the zone->lock in the
__free_pages() path, but I also thought I found the lru_lock.  Can't
find it now though, guess I was mistaken.

> >>>Also, any thoughts on whether I need i_lock or i_mutex or something
> >>>else would be handy..
> >>
> >>I'm not much of an fs guy. How come you don't use i_size?
> >
> >
> >i_size is already used for a hard limit on the file size - faulting a
> >page beyond i_size will SIGBUS, whereas faulting a page beyond
> >i_blocks just isn't guaranteed.  In particular, we always extend
> >i_size when makiing a new mapping, whereas we only extend i_blocks
> >(and thus reserve pages) on a SHARED mapping (because space is being
> >guaranteed for things in the mapping, not for a random processes
> >MAP_PRIVATE copy).
> 
> Oh OK I misread how you're using it. I thought you wanted to be
> able to guarantee the whole thing would be guaranteed.

No.  Well... "whole thing" is kind of misleading.  I don't want to
reserve on MAP_PRIVATE mappings (because I haven't found any semantics
for that which really make any sense).  But we do extend i_size on
MAP_PRIVATE mappings, so we can (privately) instantiate things in that
space without getting a SIGBUS.

> The other thing you might be able to do is use hugetlbfs inode
> private data so you don't have to overload vfs things?

Yeah, I'm thinking that would be more sensible.  Only curly bit is
that it would need to be set up from fs/hugetlbfs/inode.c, but
accessed from mm/hugetlb.c.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
