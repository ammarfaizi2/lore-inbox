Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbRG0EVm>; Fri, 27 Jul 2001 00:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268601AbRG0EVc>; Fri, 27 Jul 2001 00:21:32 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:16146 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267208AbRG0EVU>; Fri, 27 Jul 2001 00:21:20 -0400
Message-ID: <3B60EDD3.2CE54732@zip.com.au>
Date: Fri, 27 Jul 2001 14:28:03 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Pang <ozone@algorithm.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com>,
		<20010726095452.L27780@work.bitmover.com> <996167751.209473.2263.nullmailer@bozar.algorithm.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andre Pang wrote:
> 
> it would be _nice_ if the ext3 guys would be more willing to
> implement directory-syncing on link/rename/etc, though, even as
> an option.  a 'mount -o dirsync' would be enough; no need for
> chattr +D stuff.  Linux tends to have a bad name as a platform
> as an MTA just because of all this, which is a shame.  it would be
> nice if a fix is possible.  *nudge nudge Mr. Morton* :)

Perhaps I didn't understand the requirement.

I believe that `dirsync' would provide synchronous metadata
operations (ie: the metadata is crashproofed on-disk when
the syscall returns), but non-sync data.  Correct?

Whereas `mount -o sync' or `chattr +S' would provide synchronous
metadata operations PLUS synchronous data, so when write()
returns, the data which was written is crashproofed.

Is that your understanding of the difference?

If so, then with `dirsync', the application would have to
open the file O_SYNC (which would make the whole thing pointless!)
or it would run fsync() when it had finished writing the file.

So what it boils down to is that dirsync will improve the
efficiency of applications which do a bunch of small writes
and then an fsync.

If, however, the application is capable of doing a nice big
write() (setvbuf!) then really, the two things will be pretty
much the same.

Wait and see how the benchmarks turn out, yes?


One problem at present is that an application could be in the
middle of a nice big write(), but another thread comes up and
does a synchronous creat().  That will force a commit right in the middle
of the write().  It would be better (I think) if the write's transaction
were allowed to run to completion and the creat() caller blocks until
the write() finishes - this way the write(), the creat() and anything
else which happened during the write() would all be written out in a
single compound transaction.

Alas, we cannot run a transaction handle for more than a single
page in write() because of locking inversion problems with i_sem
and the lock_page outside ->writepage().  i_sem is trivial to fix,
but writepage is not.  It has not really proven to be a problem
yet, but it would be nice to be able to _guarantee_ that writes
up to a particular size (100k, say) were 100% atomic.

-
