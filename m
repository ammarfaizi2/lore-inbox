Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154988AbQBQQd0>; Thu, 17 Feb 2000 11:33:26 -0500
Received: by vger.rutgers.edu id <S154926AbQBQQYo>; Thu, 17 Feb 2000 11:24:44 -0500
Received: from dukat.scot.redhat.com ([195.89.149.246]:3743 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S154865AbQBQLnJ>; Thu, 17 Feb 2000 06:43:09 -0500
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14508.6233.742081.199897@dukat.scot.redhat.com>
Date: Thu, 17 Feb 2000 15:48:41 +0000 (GMT)
To: Alexander Viro <viro@math.psu.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu, linux-fsdevel@vger.rutgers.edu
Subject: Re: Linux Status For 2.3.x: v 2.3.43
In-Reply-To: <Pine.GSO.4.10.10002170229060.18606-100000@weyl.math.psu.edu>
References: <14500.12114.578080.182829@dukat.scot.redhat.com> <Pine.GSO.4.10.10002170229060.18606-100000@weyl.math.psu.edu>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Thu, 17 Feb 2000 02:36:03 -0500 (EST), Alexander Viro
<viro@math.psu.edu> said:

> On Fri, 11 Feb 2000, Stephen C. Tweedie wrote:

>> There are basically three things we need to deal with.
>> 
>> * Freeing memory.
>> 
>> The simple one.  An application wants more memory, so we need to throw
>> something out of cache.

> Probable point where we call it being shrink_mmap(). Other candidates?

shrink_mmap() is the obvious place.  The biggest problem is that we will
need to export enough functionality to allow other filesystems to
hook their own data structures onto the page cache LRU list, so that
filesystem-specific caches can be reclaimed in the same shrink_mmap()
loop. 

>> * Write throttling.
>> 
>> There needs to be a way of detecting when we have too many dirty pages
>> in memory so that we can stall new write activity while we go about
>> flushing some old writes to disk.  ...

> Ahem... OK, we can put the counter for dirty pages and put them into the
> head of the ->pages.

Think about the buffer cache too.  But yes, if we restrict this to page
cache pages, then a page dirty bit and a separate lru for those pages
will do for this.

>> * Pinned memory thresholds.
>> 
>> Some filesystems create pages which simply cannot be flushed to disk
>> on demand.
...
>> There _must_ be a hard, system-wide limit on such pinned pages, so
>> that we can guarantee that when we do want to flush pinned pages,
>> there is enough unpinned memory available to the page stealer to allow
>> the fs transactions to complete and the pinned pages to be released.

> Ouch. Now, that may turn out nasty - deadlocks are fun...

The whole reason we need this is to avoid deadlocks.  If we don't have
it, we can deadlock if we have transactional filesystems --- it's pretty
much that simple.  It's not enough to detect deadlocks here, we really
do need to prevent them, and allowing for pre-reservation of pinned
pages is the simplest way to let that happen.

> OK, let's do the simple stuff first - are you OK with per-address_space
> -> shrink_mapping() being called from shrink_mmap()?

Absolutely.

--Stephen


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
