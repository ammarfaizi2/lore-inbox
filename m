Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271755AbRH0OmL>; Mon, 27 Aug 2001 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271754AbRH0OmC>; Mon, 27 Aug 2001 10:42:02 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:10128 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271748AbRH0Olr>;
	Mon, 27 Aug 2001 10:41:47 -0400
Date: Mon, 27 Aug 2001 15:42:00 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <499114355.998926919@[169.254.198.40]>
In-Reply-To: <20010827142441Z16237-32383+1641@humbolt.nl.linux.org>
In-Reply-To: <20010827142441Z16237-32383+1641@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, 27 August, 2001 4:31 PM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

>   - Readahead cache is important enough to get its own lru list.
>     We know it's a fifo so don't have to waste cycles scanning/aging.
>     Having a distinct list makes the accounting trivial, vs keeping
>     readahead on the active list for example.

A nit: I think it's a MRU list you want. If you are reading
ahead (let's have caps for a page that has been used for reading,
as well as read from the disk, and lowercase for read-ahead that
has not been used):
	ABCDefghijklmnopq
             |            |
            read         disk
	   ptr          head
and you want to reclaim memory, you want to drop (say) 'pq'
to get
	ABCDefghijklmno
for two reasons: firstly because 'efg' etc. are most likely
to be used NEXT, and secondly because the diskhead is nearer
'pq' when you (inevitably) have to read it again.

This seems even more imporant when considering multiple streams,
as if you drop the least recently 'used' (i.e. read in from disk),
you will instantly create a thrashing storm.

And an idea: when dropping read-ahead pages, you might be better
dropping many readahed pages for a single stream, rather than
hitting them all equally, else they will tend to run out of
readahead in sync.

--
Alex Bligh
