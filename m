Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283360AbRK2SCp>; Thu, 29 Nov 2001 13:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283356AbRK2SCf>; Thu, 29 Nov 2001 13:02:35 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36101 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283360AbRK2SCX>; Thu, 29 Nov 2001 13:02:23 -0500
Message-ID: <3C0677FB.88AE4196@zip.com.au>
Date: Thu, 29 Nov 2001 10:01:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: war war <war@starband.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <B7F1F9B7DE30EDF47ADB4F8F44CAC84B@war.starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war war wrote:
> 
> Issue:
> 

Here I go again.

> Is it possible to set the disk cache size to a higher value to avoid
> temporary freezing while untarring large files?  Memory is not an
> issue, I have plenty of it.  The disk drive is a good drive, does
> 29.2MB/s sustained in single user mode, 25MB/s when I have a lot of
> processes open.  Here is what I think is going on.  Sometimes, when I
> untar things, or do things that consume a lot of disk space rapidly,
> they do it VERY quickly, and then the disk rumbles on for 5-20
> seconds after it is done.  What accounts for this?

What is unclear from your report is how this behaviour differs
from what linux has _always_ done.  The kernel implements
delayed writeback.  Write data isn't fully flushed until up
to thirty seconds after it was written.

So... what filesystem do you use, and how do you think current
behaviour differs from earlier kernels?

I can tell you a few things:  there are basically three ways in
which write() data gets IO started on it:

1: Directly, when someone does a write(), if the amount of pending write
   data is too high.

2: From within the VM code, when it detects that the ratios of
   free-to-dirty-to-clean memory are getting out of whack.

3: Within the kupdate daemon, when it is detected that the
   data is thirty seconds old.

In current kernels, with your sort of workload, it appears that
all IO is being initiated by method 2.  It also appears that
method 2 simply doesn't do it very well - I've earlier observed
that simply writing a 650 megabyte chunk of /dev/zero into a
file runs 30% faster on ext3 than on ext2.  Because ext2 uses
method 2, and it should be using method 1, and ext3 uses, err,
method 4.

Are you inclined to try a patch, and let us know if the result
is better? (coz if you don't nothing will happen!)

http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/vm-fixes.patch

It causes writeout to be initiated via the dirty buffer LRU, not the
inactive list.

Also,

http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/elevator.patch

It lets you read data from the disk when writes are happening.

-
