Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbRHFNZH>; Mon, 6 Aug 2001 09:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268428AbRHFNY5>; Mon, 6 Aug 2001 09:24:57 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:49674
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S266974AbRHFNYt>; Mon, 6 Aug 2001 09:24:49 -0400
Date: Mon, 06 Aug 2001 09:24:01 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
Message-ID: <316580000.997104241@tiny>
In-Reply-To: <01080607394704.00294@starship>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, August 06, 2001 07:39:47 AM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:
 
>> there are at least 3 reasons to write buffers to disk
>> 
>> 1) they are too old
>> 2) the percentage of dirty buffers is too high
>> 3) you need to reclaim them due to memory pressure
>> 
>> There are 3 completely different things; there's no trumping of
>> priorities.
> 
> There is.  If your heavily loaded machine goes down and you lose edits 
> from 1/2 an hour ago even though your bdflush parms specify a 30 second 
> update cycle you'll call the system broken, whereas if it runs 5% slower 
> under heavy write+swap load that's just life.

Ok, we're getting caught up in semantics here.  I'm not saying kupdate
should switch over to write buffers that might get reclaimed instead of old
buffers.  There still needs to be proper flushing of old data.

I am saying that it should be possible to have the best buffer flushed
under memory pressure (by kswapd/bdflush) and still get the old data to
disk in time through kupdate.

> 
>> Under memory pressure you write buffers you have a high
>> chance of freeing, during write throttling you write buffers that
>> won't get dirty again right away, and when writing old buffers you
>> write the oldest first.
>> 
>> This doesn't mean you can always make the right decision on all 3
>> cases, or that making the right decision is worth the effort ;-)
> 
> If we need to do write throttling we should do it at the point where we 
> still know its a write, i.e., somewhere in sys_write.  

The rest of the stuff below does make sense, but we need to keep in mind
that sys_write isn't the only way to dirty file pages.

> Some time after 
> writes are throttled (specified by bdflush parms) all the old write 
> buffers will have worked their way through to the drives and your case 
> (3) gets all the bandwidth.  I don't see a conflict, except that we 
> don't have such an upstream write throttling mechanism yet.  We sort-of 
> have one in that a writer will busy itself trying to help out with lru 
> scanning when it can't get a free page for the page cache.  This has the 
> ugly result that we have bunches of processes spinning on the lru lock 
> and we have no idea what the queue scanning rates really are.  We can do 
> something much more intelligent and predictable there and we'll be a lot 
> closer to being able to balance intelligently between your cases.
> 
> By the way, I think you should combine (2) and (3) using an and, which 
> gets us back to the "kupdate thing" vs the "bdflush thing".

Perhaps, since I think they would be handled in roughly the same way.

-chris

