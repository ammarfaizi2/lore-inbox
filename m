Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSIEUMM>; Thu, 5 Sep 2002 16:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318158AbSIEUMM>; Thu, 5 Sep 2002 16:12:12 -0400
Received: from zeus.kernel.org ([204.152.189.113]:18351 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318151AbSIEUMK>;
	Thu, 5 Sep 2002 16:12:10 -0400
Message-ID: <3D77B1EF.97B1FDDD@zip.com.au>
Date: Thu, 05 Sep 2002 12:35:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
References: <3D77A58F.B35779A1@zip.com.au> <Pine.LNX.4.33.0209051155091.1307-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 5 Sep 2002, Andrew Morton wrote:
> >
> > It would be simpler if it was nr_of_pages_completed.
> 
> Well.. Maybe.
> 
> I actually think that you in practice really only have two cases:
> 
>  - we only care about full completion. Easily tested for by just looking
>    at bi_size, and leaving the code as it is right now.

OK.

>  - the code really cares about and uses the incremental information. At
>    which point it will already have "handled" any previous incremental
>    stuff, and the only thing it really cares about is the "new increment".

So the BIO client would need to keep some state somewhere about "this is
the next page to unlock".  That would best be in the BIO somewhere.

(I assume the block layer handles the case where the hardware signals
completion in non-sector-ascending-order?  That must have been fun to
code and test).
 
> So I'd suggest making at least the first cut only have the incremental
> information, since the global information already exists through bi_size.

Well we still will have the problem where reading 512 bytes from /dev/fd0
does 64k of IO.  That is most sweet for reading a bunch of 32k ext2 files
from a hard drive, not so nice for reading fd0's partition table.

We can do all sorts of things by dropping parameters, hints and tunables
into q->backing_dev_info.  We just need to work out what is sensible for
this.  ummm.  I guess backing_dev_info.read_k_per_sec would suffice.

Or .i_am_a_floppy ;)
