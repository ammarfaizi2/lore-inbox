Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290806AbSCFAOG>; Tue, 5 Mar 2002 19:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290946AbSCFAN7>; Tue, 5 Mar 2002 19:13:59 -0500
Received: from dsl-213-023-039-135.arcor-ip.net ([213.23.39.135]:7587 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290806AbSCFANu>;
	Tue, 5 Mar 2002 19:13:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, arjan@fenrus.demon.nl
Subject: Re: 2.4.19pre1aa1
Date: Wed, 6 Mar 2002 01:09:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0203050934340.1413-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0203050934340.1413-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iOzg-0002qI-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 5, 2002 01:41 pm, Rik van Riel wrote:
> On Tue, 5 Mar 2002 arjan@fenrus.demon.nl wrote:
> > In article <20020305005215.U20606@dualathlon.random> you wrote:
> >
> > > I don't see how per-zone lru lists are related to the kswapd deadlock.
> > > as soon as the ZONE_DMA will be filled with filedescriptors or with
> > > pagetables (or whatever non pageable/shrinkable kernel datastructure you
> > > prefer) kswapd will go mad without classzone, period.
> >
> > So does it with class zone on a scsi system....
> 
> Furthermore, there is another problem which is present in
> both 2.4 vanilla, -aa and -rmap.
> 
> Suppose that (1) we are low on memory in ZONE_NORMAL and
> (2) we have enough free memory in ZONE_HIGHMEM and (3) the
> memory in ZONE_NORMAL is for a large part taken by buffer
> heads belonging to pages in ZONE_HIGHMEM.
> 
> In that case, none of the VMs will bother freeing the buffer
> heads associated with the highmem pages and kswapd will have
> to work hard trying to free something else in ZONE_NORMAL.
> 
> Now before you say this is a strange theoretical situation,
> I've seen it here when using highmem emulation. Low memory
> was limited to 30 MB (16 MB ZONE_DMA, 14 MB ZONE_NORMAL)
> and the rest of the machine was HIGHMEM.  Buffer heads were
> taking up 8 MB of low memory, dcache and inode cache were a
> good second with 2 MB and 5 MB respectively.
> 
> 
> How to efficiently fix this case ?   I wouldn't know right now...
> However, I guess we might want to come up with a fix because it's
> a quite embarassing scenario ;)

There's the short term fix - hack the vm - and the long term fix:
get rid of buffers.  A buffers are does three jobs at the moment:

  1) cache the physical block number
  2) io handle for a file block
  3) data handle for a file block, including locking

The physical block number could be moved either into the struct
page - which desireable since it wastes space for pages that don't
have physical blocks - or my preferred solution, move it into the
page cache radix tree.

For (2) we have a whole flock of solutions on the way.  I guess
bio does the job quite nicely as Andrew Morton demonstrated last
week.

For (3), my idea is to generalize the size of the object referred
to by struct page so that it can match the filesystem block size.
This is still in the research stage, and there are a few issues I'm
looking at, but the more I look the more practical it seems.  How
nice it would be to get rid of the page->buffers->page tangle, for
one thing.

--
Daniel
