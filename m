Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292752AbSCRUQP>; Mon, 18 Mar 2002 15:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSCRUQG>; Mon, 18 Mar 2002 15:16:06 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:9744 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S291948AbSCRUP5>; Mon, 18 Mar 2002 15:15:57 -0500
Message-ID: <3C964AA3.4B85EA0B@zip.com.au>
Date: Mon, 18 Mar 2002 12:14:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
In-Reply-To: <3C8D9999.83F991DB@zip.com.au> <7820000.1016478976@w-hlinder.des>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> 
> --On Monday, March 11, 2002 22:00:57 -0800 Andrew Morton <akpm@zip.com.au> wrote:
> 
> >    "help, help - there's no point in just one guy testing this" (thanks Randy).
> 
>         Will you accept the testing of a gal? ;)

With alacrity :)  Thanks.

> >
> > This is an update of the delayed-allocation and multipage pagecache I/O
> > patches.  I'm calling this a beta, because it all works, and I have
> > other stuff to do for a while.
> >
> 
>         Here are the dbench throughput results on an 8-way SMP with 2GB memory.
> These are run with 64 then 128 clients 15 times each averaged. It looked
> pretty good.
>         Running with more than 180 clients caused the system to hang, after
> a reset there was much filesystem corruption. This happened twice. Probably
> related to filling up disk space.

It could be space-related.  A couple of gigs should have been plenty..

One other possible explanation is to do with radix-tree pagecache.
It has to allocate memory to add nodes to the tree.  When these
allocations start failing due to out-of-memory, the VM will keep
on calling swap_out() a trillion times without noticing that it
didn't work out.  But if this happened, yo would have seen a huge
number of "0-order allocation failed" messages.

> There are no ServerRaid drivers for 2.5 yet
> so the biggest disks on this system are unusable. lockmeter results are forthcoming (day or two).
> 
> Running dbench on an 8-way SMP 15 times each.
> 
> 2.5.6 clean
> 
> Clients         Avg
> 
> 64              37.9821
> 128             29.8258
> 
> 2.5.6 with everything.patch
> 
> Clients         Avg
> 
> 64              41.0204
> 128             30.6431
> 

That's odd.  I'm showing 50% increases in dbench throughput.  Not
that there's anything particularly clever about that - these patches
allow the kernel to just throw more memory in dbench's direction, and
it likes that.  But it does indicate that something funny is up.
I'll take a closer look - thanks again.

-
