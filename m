Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278941AbRJVVVu>; Mon, 22 Oct 2001 17:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278943AbRJVVVl>; Mon, 22 Oct 2001 17:21:41 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:25354 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278941AbRJVVV0>; Mon, 22 Oct 2001 17:21:26 -0400
Message-ID: <3BD48CE9.C8F5FD60@zip.com.au>
Date: Mon, 22 Oct 2001 14:17:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: kjournald and disk sleeping
In-Reply-To: <3BD4655E.82ED21CC@zip.com.au> <Pine.LNX.4.33.0110221424500.25281-100000@hp11.labcomp.famaf.unc.edu.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcos Dione wrote:
> 
> On Mon, 22 Oct 2001, Andrew Morton wrote:
> 
> > Yes, this is a bit of a problem - it's probably atime updates,
> > things which write to inodes, etc.  A commit will be forced within
> > five seconds of this happening.
> 
>         Reading journal.c I guessed that kjournald flushes thing *even if
> it doesn't have things to flush*. I guess that from commit_timeout and
> the comments on the thread process, but I can be wrong.

It's rather convoluted, but a commit fires if:

1: more than approx 1/4 of the journal has been used by the
   current transaction or

2: this transaction has been open for >5 seconds.

And a commit will close off the current transaction, but will *not*
open a new one.  Opening a new transaction will only happen when
new writes come in.

So there should be no commit activity on an fs which isn't being
written to.

You can watch all this happening by building with debug support and
running

	echo 1 > /proc/sys/fs/jbd-debug

You may want to stop syslogd first though - otherwise you get into
this loop where commits create logs and logs create commits.  Tends
to fill your logs up rather boringly.

-
