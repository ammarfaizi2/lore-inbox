Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRHEXeh>; Sun, 5 Aug 2001 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264932AbRHEXe0>; Sun, 5 Aug 2001 19:34:26 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:33798
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S264797AbRHEXeS>; Sun, 5 Aug 2001 19:34:18 -0400
Date: Sun, 05 Aug 2001 19:32:24 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
Message-ID: <276480000.997054344@tiny>
In-Reply-To: <01080600380103.00294@starship>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, August 06, 2001 12:38:01 AM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

> On Sunday 05 August 2001 20:34, Chris Mason wrote:
>> I wrote:
>> > Note that the fact that buffers dirtied by ->writepage are ordered
>> > by time-dirtied means that the dirty_buffers list really does have
>> > indirect knowledge of page aging.  There may well be benefits to
>> > your approach but I doubt this is one of them.
>> 
>> A problem is that under memory pressure, we'll flush a buffer that has
>> been dirty for a long time, even if we are constantly redirtying it
>> and have it more or less pinned.  This might not be common enough to
>> cause problems, but it still isn't optimal.  Yes, it is a good idea to
>> flush that page at some time, but under memory pressure we want to do
>> the least amount of work that will lead to a freeable page.
> 
> But we don't have a choice.  The user has set an explicit limit on how 
> long a dirty buffer can hang around before being flushed.  The 
> old-buffer rule trumps the need to allocate new memory.  As you noted,
> it doesn't cost a lot because if the system is that heavily loaded
> then the rate of dirty buffer production is naturally throttled.

there are at least 3 reasons to write buffers to disk

1) they are too old
2) the percentage of dirty buffers is too high
3) you need to reclaim them due to memory pressure

There are 3 completely different things; there's no trumping of priorities.
Under memory pressure you write buffers you have a high chance of freeing,
during write throttling you write buffers that won't get dirty again right
away, and when writing old buffers you write the oldest first.

This doesn't mean you can always make the right decision on all 3 cases, or
that making the right decision is worth the effort ;-)

> If you must enter it into the page hash you'd be safer generating a 
> random number for the page index.  But why not just take what you need
> from add_to_page_cache_locked:
> 

Mostly to keep down on the cut n' pasted code in the patch.  But I'll try
this out...

-chris

