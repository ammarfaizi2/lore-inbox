Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbRHFFeR>; Mon, 6 Aug 2001 01:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRHFFeI>; Mon, 6 Aug 2001 01:34:08 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:9747 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266723AbRHFFd4>; Mon, 6 Aug 2001 01:33:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] using writepage to start io
Date: Mon, 6 Aug 2001 07:39:47 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org, torvalds@transmeta.com
In-Reply-To: <276480000.997054344@tiny>
In-Reply-To: <276480000.997054344@tiny>
MIME-Version: 1.0
Message-Id: <01080607394704.00294@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 August 2001 01:32, Chris Mason wrote:
> On Monday, August 06, 2001 12:38:01 AM +0200 Daniel Phillips
>
> <phillips@bonn-fries.net> wrote:
> > On Sunday 05 August 2001 20:34, Chris Mason wrote:
> >> I wrote:
> >> > Note that the fact that buffers dirtied by ->writepage are
> >> > ordered by time-dirtied means that the dirty_buffers list really
> >> > does have indirect knowledge of page aging.  There may well be
> >> > benefits to your approach but I doubt this is one of them.
> >>
> >> A problem is that under memory pressure, we'll flush a buffer that
> >> has been dirty for a long time, even if we are constantly
> >> redirtying it and have it more or less pinned.  This might not be
> >> common enough to cause problems, but it still isn't optimal.  Yes,
> >> it is a good idea to flush that page at some time, but under memory
> >> pressure we want to do the least amount of work that will lead to a
> >> freeable page.
> >
> > But we don't have a choice.  The user has set an explicit limit on
> > how long a dirty buffer can hang around before being flushed.  The
> > old-buffer rule trumps the need to allocate new memory.  As you
> > noted, it doesn't cost a lot because if the system is that heavily
> > loaded then the rate of dirty buffer production is naturally
> > throttled.
>
> there are at least 3 reasons to write buffers to disk
>
> 1) they are too old
> 2) the percentage of dirty buffers is too high
> 3) you need to reclaim them due to memory pressure
>
> There are 3 completely different things; there's no trumping of
> priorities.

There is.  If your heavily loaded machine goes down and you lose edits 
from 1/2 an hour ago even though your bdflush parms specify a 30 second 
update cycle you'll call the system broken, whereas if it runs 5% slower 
under heavy write+swap load that's just life.

> Under memory pressure you write buffers you have a high
> chance of freeing, during write throttling you write buffers that
> won't get dirty again right away, and when writing old buffers you
> write the oldest first.
>
> This doesn't mean you can always make the right decision on all 3
> cases, or that making the right decision is worth the effort ;-)

If we need to do write throttling we should do it at the point where we 
still know its a write, i.e., somewhere in sys_write.  Some time after 
writes are throttled (specified by bdflush parms) all the old write 
buffers will have worked their way through to the drives and your case 
(3) gets all the bandwidth.  I don't see a conflict, except that we 
don't have such an upstream write throttling mechanism yet.  We sort-of 
have one in that a writer will busy itself trying to help out with lru 
scanning when it can't get a free page for the page cache.  This has the 
ugly result that we have bunches of processes spinning on the lru lock 
and we have no idea what the queue scanning rates really are.  We can do 
something much more intelligent and predictable there and we'll be a lot 
closer to being able to balance intelligently between your cases.

By the way, I think you should combine (2) and (3) using an and, which 
gets us back to the "kupdate thing" vs the "bdflush thing".

--
Daniel
