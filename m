Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264465AbRFORF6>; Fri, 15 Jun 2001 13:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264463AbRFORFs>; Fri, 15 Jun 2001 13:05:48 -0400
Received: from [212.1.33.3] ([212.1.33.3]:12627 "EHLO borg4.zapnet.de")
	by vger.kernel.org with ESMTP id <S264456AbRFORFf>;
	Fri, 15 Jun 2001 13:05:35 -0400
Message-Id: <200106151705.TAA07359@borg4.zapnet.de>
Date: Fri, 15 Jun 2001 19:05:37 +0200
From: Ivan Schreter <is@zapwerk.com>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buffer management - interesting idea
In-Reply-To: <Pine.LNX.4.33.0106151219430.9557-100000@pianoman.cluster.toy>
In-Reply-To: <200106150941.LAA18088@borg4.zapnet.de>
	<Pine.LNX.4.33.0106151219430.9557-100000@pianoman.cluster.toy>
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.8; Linux 2.2.16; i686)
Organization: zapwerk AG
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not subscribed to list, so please replies CC: to me

On Fri, 15 Jun 2001 12:20:52 -0400 (EDT)
John Clemens <john@deater.net> wrote:

> Is there any way for you to measure the relative computational overhead
> required for the two algorithms? the benefit of the higher hit rate may
> be lost of the computational time increases by too much.

Well, *computational* overhead is negligible - processing is O(1), like
LRU. Look at the program that was attached to my previous message. There
is an implementation of this algorithm.

In LRU, all you have to do is move page to the front of doubly-linked list
when page is accessed and swap out last page when buffer is full and
request for a new page is generated.

In 2Q, when a page is present in LRU queue, you move it to the front of
LRU queue as usual. Otherwise, if it is in memory, it must be in A1 queue
(the FIFO one), so you DON'T do anything. When the page is NOT in memory,
you load it conditionally to Am LRU queue (if it is present in A1out
queue) or to A1 queue (FIFO), if not.

It gets interesting when you need to swap out a page from memory. When the
size of A1 FIFO is greater than limit (e.g., 10% of buffer space), a page
from A1 is swapped out (and put into A1out list), otherwise a page from Am
LRU is swapped out (and NOT put into A1out, since it hasn't been accessed
for long time).

So the general algorithm is not much more complicated as LRU.

There is only one interesting question: How to implement A1out queue (also
FIFO) so that we can quickly tell a page is in A1out. I'm currently using
cyclic buffer for A1out in sample implementation and a flag in buffer map
if a page is in A1out. In real system this flag must be replaced by some
kind of hashtable which will contain an entry for all pages which are in
A1out queue, so that we can decide in O(1) if a page is or isn't in A1out
when loading it from the disk. Alternative is a bitmask, but then we need,
e.g., for 64GB at 4kB sized pages, 2MB of RAM (which is too much).
Considering we may have upto 32K pages mapped in memory (128MB buffer), is
a hashtable with say 64K entries at 50% A1out (16K entries) much more
memory efficient (512kB). If we limit A1out queue to something less (maybe
10-20% of buffer block count) we need even less space.

Since I use it for database application and know in advance the size of
the underlying dataspace, I use bitmask method in my program. This is
probably not good for the kernel.

Somebody should investigate the potential impact of the algorithm on real
system. If you send me a trace from live system, I am willing to analyze
it.

Form for the trace:

A text file with lines in format:

	time blockid buffersizecur buffersizemax
	time blockid touch

where time is monotonically increasing, blockid is some unique ID of block
requested (also for blocks already in memory!), buffersizecur is current
size of buffer space (since we have variable buffer space under linux) and
buffersizemax is buffersizecur + size of free memory (or a flag whether we
can put a new block in a free memory block).

Second form (with word "touch") is for the purposes of counting extra time
needed for swapping out the block back to the disk.

Optionally the time may be left out.

--
Ivan Schreter
is@zapwerk.com
