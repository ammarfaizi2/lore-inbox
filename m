Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWGRN3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWGRN3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGRN3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:29:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50879 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932193AbWGRN3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:29:47 -0400
Date: Tue, 18 Jul 2006 06:29:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <1153224998.2041.15.camel@lappy>
Message-ID: <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy> 
 <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
 <1153224998.2041.15.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006, Peter Zijlstra wrote:

> > I thought we wanted to just track the number of unmapped clean pages and 
> > insure that they do not go under a certain limit? That would not require
> > any locking changes but just a new zoned counter and a check in the dirty
> > handling path.
> 
> The problem I see with that is that we cannot create new unmapped clean
> pages. Where will we get new pages to satisfy our demand when there is
> nothing mmap'ed.

Hmmm... I am not sure that we both have this straight yet.

Adding logic to determine the number of clean pages is not necessary. The 
number of clean pages in the pagecache can be determined by:

global_page_state(NR_FILE_PAGES) - global_page_state(NR_FILE_DIRTY) 

That number can be increased by writeout and so I think we want this to
be checked in the throttling path. Swapout is only useful for 
anonymous pages. Dirty anonymous pages are not tracked and do not 
contribute to the NR_FILE_DIRTY (formerly nr_dirty). We only track
the number of anonymous pages in NR_ANON_PAGES. Swapout could be used 
to reduce NR_ANON_PAGES if memory becomes tight.

The intend of insuring that a certain number of clean pages exist seems to
be to guarantee that a certain amount of memory is freeable without
having to go through a filesystem.

Pages that are available without file system activity are:

1. The already free pages.

2. The clean pagecache pages.

For a zone this is

zone->free_pages + zone_page_state(zone, NR_FILE_PAGES) - 
zone_page_state(zone, NR_FILE_DIRTY)

If this goes below a certain limit then we either have to:

1. If NR_FILE_DIRTY is significant then we can increase the number
   of reclaimable pages by writing them out.

2. If NR_FILE_DIRTY and NR_FILE_PAGES are low then writeout does 
   not help us. NR_ANON_PAGES is likely big. So we could swap some
   anonymous pages out to increase zone->free_pages instead. Performance
   wise this is a bad move. So we should prefer writeout.

However, the above scheme assumes that all pagecache pages can ne
unmapped if necessary. This may not be desirable since we may then
have no executable pages available anymore and create a significant
amount of disk traffic. If we would track the number of dirty unmapped
pages (by addding NR_UNMAPPED_DIRTY) then we could guarantee available
memory that would leave the pages in use by processes alone.

If we impose a limit on the number of free pages + the number of unmapped
clean pagecache pages then we have a reserve memory pool that can be
accessed without too much impact on performance. Its basically another
trigger for writeout.









