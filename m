Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRHAOwu>; Wed, 1 Aug 2001 10:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbRHAOwj>; Wed, 1 Aug 2001 10:52:39 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:59396 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267196AbRHAOwV>; Wed, 1 Aug 2001 10:52:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] using writepage to start io
Date: Wed, 1 Aug 2001 16:57:35 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org, torvalds@transmeta.com
In-Reply-To: <233400000.996606471@tiny>
In-Reply-To: <233400000.996606471@tiny>
MIME-Version: 1.0
Message-Id: <01080116573506.00303@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 July 2001 21:07, Chris Mason wrote:
> This has been tested a little more now, both ext2 (1k, 4k) and
> reiserfs.  dbench and iozone testing don't show any difference, but I
> need to spend a little more time on the benchmarks.

It's impressive that such seemingly radical surgery on the vm innards 
is a) possible and b) doesn't make the system perform noticably worse.

> The idea is that using flush_dirty_buffers to start i/o under memory
> pressure is less than optimal.  flush_dirty_buffers knows the oldest
> dirty buffer, but has no page aging info, so it might not flush a
> page that we actually want to free.

Note that the fact that buffers dirtied by ->writepage are ordered by 
time-dirtied means that the dirty_buffers list really does have 
indirect knowledge of page aging.  There may well be benefits to your 
approach but I doubt this is one of them.

It's surprising that 1K buffer size isn't bothered by being grouped by 
page in their IO requests.  I'd have thought that this would cause a 
significant number of writes to be blocked waiting on the page lock 
held by an unrelated buffer writeout.

The most interesting part of your patch to me is the anon_space_mapping.
It's nice to make buffer handling look more like page cache handling, 
and get rid of some special cases in the vm scanning.  On the other 
hand, buffers are different from pages in that, once buffers heads are 
removed, nobody can find them any more, so they can not be rescued.
Now, if I'm reading this correctly, buffer pages *will* progress on to 
the inactive_clean list from the inactive_dirty list instead of jumping 
that queue and being directly freed by the page_cache_release.  Maybe 
this is good because it avoids the expensive-looking __free_pages_ok.

This looks scary:

+        index = atomic_read(&buffermem_pages) ;

Because buffermem_pages isn't unique.  This must mean you're never 
doing page cache lookups for anon_space_mapping, because the 
mapping+index key isn't unique.  There is a danger here of overloading 
some hash buckets, which becomes a certainty if you use 0 or some other 
constant for the index.  If you're never doing page cache lookups, why 
even enter it into the page hash?

That's all for now.  It's a very interesting patch.

--
Daniel
