Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTAXWbj>; Fri, 24 Jan 2003 17:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTAXWbj>; Fri, 24 Jan 2003 17:31:39 -0500
Received: from [63.205.85.133] ([63.205.85.133]:64783 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S261370AbTAXWbi>;
	Fri, 24 Jan 2003 17:31:38 -0500
Date: Fri, 24 Jan 2003 14:40:45 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: David Mansfield <lkml@dm.cobite.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59mm5, raid1 resync speed regression.
Message-ID: <20030124144045.D97036@sfgoth.com>
References: <3E31701E.4020101@cyberone.com.au> <Pine.LNX.4.44.0301241311350.32240-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.44.0301241311350.32240-100000@admin>; from lkml@dm.cobite.com on Fri, Jan 24, 2003 at 01:18:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield wrote:
> decide which half of the mirror is more current.  Read blocks from this 
> partition, write to other.  Periodically update raid-superblock or 
> something.

Well I haven't looked at the code (or the academic paper it's based on) but
this makes some sense based on Andrew's description of the new algorithm.
It sounds like the RAID resync is reading/writing the same block and
(I'm theorizing here) is doing the write back synchronously so it gets
delayed by the anticipatory post-read delay.  Does this sound possible?

(Or does it just blindly write over the entire "old" mirror in which case I
don't know how that would affect RAID resync.  I think this scenario might
be possible under at least some workloads though, read on...)

One idea (assuming it doesn't to it already) would be to cancel the post-read
delay if we get a synchronous (or maybe any) write for the same (or very near)
block.  The rationale would be that it's likely from the same application and
the short seek will be cheap anyway (there's a high probability the drive's
track-buffer will take care of it).

Questions:

  * Has anyone tested what happens when an application is alternately doing
    reads and sync-writes to the same large file/partition?  (I'm thinking
    about databases here)  It sounds like an algorithm like this could slow
    them down.

  * What are the current heuristics used to prevent write-starvation?  Do
    they need to be tuned now that reads are getting even more of an
    advantage?

  * Has anyone looked at other "hints" that the higher levels can give the
    I/O scheduler that would indicate that a post-read delay is not
    likely to be fruitful (like from syscalls like close() or exit())
    Obviously the trick of communicating these all the way down to the
    I/O scheduler would be tricky but it might be worth at least thinking
    about.

Also, would it be possible to get profile data about these post-read delays?
Specifically it would be good to know:

  1. How many expired without another nearby read happening
  1a. How many of those had other I/O waiting to go when they expired
  2. How many were cut short by another nearby read (i.e. a "success")
  3. How many were cut short by some other heuristic (like described above)

That way we could see how much these delays are helping or hurting various
workloads.

Sorry if any of this is obvious or already implemented - they're just my
first thoughts after reading the announcement.  Sounds like really
interesting work though.

-Mitch
