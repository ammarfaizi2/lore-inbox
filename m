Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271514AbRHZUKA>; Sun, 26 Aug 2001 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRHZUJu>; Sun, 26 Aug 2001 16:09:50 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:15123 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S271514AbRHZUJi>;
	Sun, 26 Aug 2001 16:09:38 -0400
Date: Sun, 26 Aug 2001 14:05:37 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826140537.A21106@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108261632520.5646-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 04:38:55PM -0300, Rik van Riel wrote:
> On Sun, 26 Aug 2001, Victor Yodaiken wrote:
> 
> > And scheduling gets even more complex as we try to account for work
> > done in this thread on behalf of other processes. And, of course, we
> > have all sorts of wacky merge problems
> 
> Actually, readahead is always done by the thread reading
> the data, so this is not an issue.

Daniel was suggesting a readahead thread, if I'm not mistaken.

> 
> > BTW: maybe I'm oversimplifying, but since read-ahead is an optimization
> > trading memory space for time, why doesn't it just turn off when there's
> > a shortage of free memory?
> > 		num_pages = (num_requestd_pages +  (there_is_a_boatload_of_free_space? readahead: 0)
> 
> When the VM load is high, the last thing you want to do is
> shrink the size of your IO operations, this would only lead
> to more disk seeks and possibly thrashing.

(obviously, I don't know anything about Linux VM, so 
my questions are ignorant)


Doesn't this very much depend on why VM load is high and on the 
kind of I/O load? For example, if your I/O load is already in 
big chunks or if VM stress is being caused by a bunch of big
threads hammering shared data that is in page cache already.
This is what I would guess happens in http servers where some more
seeks might not even show up as a cost - or might be compensated for
by read-ahead on the drive itself. And the OS should still be trying
hard to aggregate swap I/O and I/O for paging. 
At least to me, "thrashing" where the OS is shuffling pages in and
out without work getting done is different from "thrashing" where
user processes run with suboptimal I/O. 
I think the applications people are better if they know
	If memory fills up,  I/O may slow down because the OS won't
	do readaheads.
than
	The OS will attempt to guess aggregate optimial I/O patterns
	and may get it completely wrong, so that when memory is full
	performance becomes totally unpredictable.


But since I have no numbers this is just a stab in the dark.

> It would be nice to do something similar to TCP window
> collapse for readahead, though...
> 
> This would work by increasing the readahead size every
> time we reach the end of the last readahead window without
> having to re-read data twice and collapsing the readahead
> window if any of the pages we read in have to be read
> twice before we got around to using them.

So  suppose Dave Miller's  computer does
      Process A: request data; sleep;                       
      Process B: fill memory with graphics (high res pictures of sparc 4s. of course)
      Process A wake up, readahead failed (pages seized by graphics); read more; sleep
      Process B fill memory 
      Process A; get data; expand readahead; request readahead
      etc.
That is, failure to use readahead may be caused by memory pressure,
scheduling delays, etc - how do you tell the difference between a
process that would profit from readahead if the scheduler would let
it and one that would not?

> IA64: a worthy successor to i860.

Not the 432?

