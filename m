Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289824AbSA2Sqm>; Tue, 29 Jan 2002 13:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289823AbSA2Sqd>; Tue, 29 Jan 2002 13:46:33 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:10492 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289820AbSA2SqZ>;
	Tue, 29 Jan 2002 13:46:25 -0500
Date: Tue, 29 Jan 2002 11:44:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: Alexander Viro <viro@math.psu.edu>, Hans Reiser <reiser@namesys.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-list] Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020129114415.S763@lynx.adilger.int>
Mail-Followup-To: Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	Alexander Viro <viro@math.psu.edu>,
	Hans Reiser <reiser@namesys.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
	reiserfs-dev@namesys.com
In-Reply-To: <3C55E9E3.50207@namesys.com> <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu> <20020129092858.D8740@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020129092858.D8740@helen.CS.Berkeley.EDU>; from jmacd@CS.Berkeley.EDU on Tue, Jan 29, 2002 at 09:28:58AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 29, 2002  09:28 -0800, Josh MacDonald wrote:
> Quoting Alexander Viro (viro@math.psu.edu):
> > On Tue, 29 Jan 2002, Hans Reiser wrote:
> > > This fails to recover an object (e.g. dcache entry) which is used once, 
> > > and then spends a year in cache on the same page as an object which is 
> > > hot all the time.  This means that the hot set of objects becomes 
> > > diffused over an order of magnitude more pages than if garbage 
> > > collection squeezes them all together.  That makes for very poor caching.
> > 
> > Any GC that is going to move active dentries around is out of question.
> > It would need a locking of such strength that you would be the first
> > to cry bloody murder - about 5 seconds after you look at the scalability
> > benchmarks.
> 
> We're not talking about actively referenced entries, we're talking about
> entries on the d_lru list with zero references.  Relocating those objects
> should not require any more locking than currently required to remove and
> re-insert the dcache entry.  Right?

But if it is unused and not recently referenced, there is little benefit
in keeping it around, is there?  I suppose there might be some benefit in
moving hot negative dentries to be on the same page as other hot dentries,
and that should be possible.  Negative dentries are a special case, though,
in that they are not actually in use, but their presence is a performance
improvement (i.e. not having to look up /usr/bin/ls, /usr/sbin/ls, etc).

Being able to move active entries between slabs is just too hard in
most cases, and the overhead (locking, back references, etc) in doing so
would probably outweigh the benefits of more tightly packed slab caches.
This could be up to the per-page (or per-slab) "try_to_free_page"
callback function to handle though.


I do agree with the assertion that you shouldn't judge the utility of
all objects on the page in which it lives by just the page use, otherwise
you will never free any other entries on a hot page.  There should still
be per-item reference bits that give hints on which entries in the slab
should be freed.

For example we can use the following simple algorithm to free pages/entries:
1) Walk slab pages (maybe page LRU order), and if all entries in the page
   can be freed, free them and then remove the page from the slab.
   This gives the VM a free page to work with, and any entries that
   are later reloaded will go to another page.
   
   As a special case for dcache (which would be handled in the dcache
   try_to_free_page callback) we could potentially move referenced
   negative dentries to another free entry in that slab page in order to
   free a page but not take the hit to go out to disk again to recreate
   the negative dentry.

2) For slab pages with in-use entries, free some fraction of entries based
   on whether the entries have been referenced.  There is no point in
   freeing all but one of the entries on a page if we can't free the page
   in the end, and having a 10% cache page utilization does nobody any good.
   Freeing some of the entries gives us free space to add new entries, but
   does not discard too many entries when we can't free the pages anyways.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

