Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSGUVXX>; Sun, 21 Jul 2002 17:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSGUVXX>; Sun, 21 Jul 2002 17:23:23 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:24965 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S314459AbSGUVXW>; Sun, 21 Jul 2002 17:23:22 -0400
Date: Sun, 21 Jul 2002 14:24:07 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Ed Tomlinson <tomlins@cam.org>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
In-Reply-To: <200207210933.01211.tomlins@cam.org>
Message-ID: <Pine.LNX.4.44.0207211253080.13101-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Ed Tomlinson wrote:

> Well not quite random.  It prunes the oldest entries. 

Yes, you're right, I was speaking sloppily.  

I meant "random" in the sense that "those pruned entries don't correspond
to the page I'm scanning right now in refill_inactive_zone".  Establishing
that connection seems simultaneously very interesting and confusing. :)

> What I tried to do here was keep the rate of aging in sync with the VM.  

I think it works darn well too!  But maybe a page-centric freeing system
would do that too.  In your patch, you distinguish between:

	- aging prunable slab pages by "counting" the slab pages
	  to determine the rate of pruning, and using the caches' internal 
	  lru order to determine the actual entries that get pruned
and
	- aging non-prunable slabs with page->age.  

Can we unify them and just use page->age (or, in the case of stock 2.5.27,
do it in the VM's LRU order)?  That is, if you encounter a cold slab page
in scanning the active list, try to prune just *that* page's slab 
resources.  If it manages to free the slab, free the page.  Otherwise, 
try again next time we visit the page.

> Thats a question I have asked myself too.  What could be done is, scan 
> the entries in the slab encountered,

I think *that's* the part I'm having difficulty envisioning.  If
cachep->pruner, then I might find myself in dcache.c (for example)  
living in a pruner callback that no longer remembers "my" slab page.  
Seems like we need a "dentry_lookup" method that returns a list of
[di]cache objects living in a specified slab (page).  Then feed that
list to a modified prune_[di]cache and see if that frees the slab.

Not the current "prune 'N' old entries from the cache, and I don't care
where they live in memory".  We're coming in instead and saying "I _know_
this page is old, so try to free its entries".  This is, I suppose, saying
that we want to throw out (or at least ignore) the caches' internal LRU
aging methods and use the VM's LRU order (2.5.27), or page->age (2.5.27
plus full rmap).  Uh oh.  This is getting scary.  And maybe wrong.  :)

So, that list-returning method has me befuddled.  And maybe we don't
really want to do any of this.  Which is why I asked. :)

> Looking at the Intermezzo dcache code, I think you made the right choise.
> I do not think this needs a pruner method.

Whew! :)

Comments?

Craig Kulesa
Steward Obs.
Univ. of Arizona

