Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRH0Teh>; Mon, 27 Aug 2001 15:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRH0Te2>; Mon, 27 Aug 2001 15:34:28 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:913 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S266827AbRH0TeO>;
	Mon, 27 Aug 2001 15:34:14 -0400
Date: Mon, 27 Aug 2001 20:34:26 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <516649838.998944465@[169.254.198.40]>
In-Reply-To: <Pine.LNX.4.33L.0108271213370.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108271213370.5646-100000@imladris.rielhome.cone
 ctiva>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

Terminological confusion - see below.

--On Monday, 27 August, 2001 12:14 PM -0300 Rik van Riel 
<riel@conectiva.com.br> wrote:

>> If you are reading
>> ahead (let's have caps for a page that has been used for reading,
>> as well as read from the disk, and lowercase for read-ahead that
>> has not been used):
>> 	ABCDefghijklmnopq
>>              |            |
>>             read         disk
>> 	   ptr          head
>> and you want to reclaim memory, you want to drop (say) 'pq'
>> to get
>> 	ABCDefghijklmno
>> for two reasons: firstly because 'efg' etc. are most likely
>> to be used NEXT, and secondly because the diskhead is nearer
>> 'pq' when you (inevitably) have to read it again.
>
> This is NOT MRU, since p and q have not been used yet.
> In this example you really want to drop D and C instead.

Daniel was (I think) suggesting readahed blocks that hadn't
be read were on a different list entirely from other blocks,
under his scheme managed by used once, he wrote:

>   - A new readahead page starts on the readahead queue.  When used
>     (by generic_file_read) the readahead page moves to the inactive
>     queue and becomes a used-once page (i.e., low priority).  If a
>     readahead page reaches the tail of the readahead queue it may
>     be culled by moving it to the inactive queue.

and:

>   - Readahead pages have higher priority than inactive pages, lower
>     than active.

So, in the context of this list, A-D are not even candidates
for dropping /in terms of this list/. Because they'd already
have become inactive pages, and have been dropped first.
My point was (after ABCD have been dropped), the pages
should be dropped in the order qponm... etc.

All the pages on this list have been read from disk, but
not read by generic_file_read. I guess I meant 'drop the
most recently /read from disk/'.

Thinking about it a bit more, we also want to drop pages
from fast streams faster, to an extent, than we drop
them from slow streams (as well as dropping quite
a few pages at once), as these 'cost' more to replace.

Let's assume we keep one queue per stream (this may have some
other advantages, like making it dead easy to make all
the pages inactive if the stream suddenly closes)

If we timestamp pages as they are read, we can approximate
the ease of dropping one page by QueueLength/(T(tail)-T(head))
(that's 1/TimeToReadAPage), and the ease of dropping the entire
queue by (roughly)

                  2
       QueueLength
  E = ------------------
   q   T       - T
        q,tail    q,head


So a possible heuristic is to drop HALF the pages in the
queue (q) with the highest E(q) value. This will half the queue
length, and approximately half the difference in T, halving
the value of E, and will ensure a long fast queue frees
up a fair number of pages. Repeat until you've reaped all
the pages you need.

As another optimization, we may need to think of pages used
by multiple streams. Think, for instance, of 'make -j' and
header files, or many users ftp'ing down the same file.
Just because one gcc process has read past
a block in a header file, I submit that we are less keen to
drop it if it is in the readahead chain for another. This
would imply that what we actually want to do is keep one
readahead queue per stream, AND keep blocks in (any) readahead
queue on the normal used-once list. However, keep a count
in this list of how many readahead queues the page is in.
Increment this count when the page is read from disk, and
decrement it when the page is read by generic_file_read.
When considering page aging, drop, in order

  inactive pages first that are no readahead queues
  inactive pages on exactly 1 readahead queue, using above
  inactive pages on >1 readahead queue (not sure what the
    best heuristic is here - perhaps just in order of
    number of queues)
  active pages

[Actually, if you don't care /which/ readahead pages get
dropped, you could do all of this a hell of a lot more
simply, JUST by using the counter to say how many readahead
queues it's in. Increment and Decrement the same way as before,
and add use this value to age out inactive pages on no
queues first, then inactive pages on queues, then active
pages - no extra LRU/MRU lists; if you reverse the age
for things on more than one readahead queue you stand a
good chance of dropping recent pages too.]

--
Alex Bligh
