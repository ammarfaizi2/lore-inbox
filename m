Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317316AbSGOEdS>; Mon, 15 Jul 2002 00:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317318AbSGOEdS>; Mon, 15 Jul 2002 00:33:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18619 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317316AbSGOEdR>;
	Mon, 15 Jul 2002 00:33:17 -0400
Date: Mon, 15 Jul 2002 00:36:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
cc: Thunder from the hill <thunder@ngforever.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <20020714234457.A21658@shookay.newview.com>
Message-ID: <Pine.GSO.4.21.0207150020540.20168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jul 2002, Mathieu Chouquet-Stringer wrote:

> On Sun, Jul 14, 2002 at 09:38:16PM -0600, Thunder from the hill wrote:
> > Hi,
> 
>   Hi,
>  
> > Please time the erase!
> 
> Had the same idea: :-)
> mchouque - /tmp/joerg %/usr/bin/time rm -rf rock
> 0.18user 6.10system 0:09.27elapsed 67%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (139major+20minor)pagefaults 0swaps
> /usr/bin/time rm -rf rock  0.18s user 6.10s system 67% cpu 9.277 total
> 
> Not too bad if you think it took 1 hour something to create the
> directory... 

No wonder - with FFS/ext2/ext3 adding files into directory takes linear
scan of the entire thing (presuming that directory was originally empty)
on each file.  Removing them in the order they were added is much faster -
removed entry is simply merged with the previous one in the same block.
So you skip the already emptied parts fast - each of these blocks consists
of a single (empty) entry.  Then you get to the block containing the entry
you are removing and either mark it unused (if it's the first one in block)
or make the previous one (first in block) longer.  You do only one name
comparison (empty entries are recognized by zero inode number).  So rm -rf
is O(blocks * entries).  Creating all that is O(entries^2) with much worse
constant.

FFS never had been intended to handle directories with huge amount of
entries.  Neiter are most of its derivatives, including ext2 and ext3
(and realistically it's not worth the extra complexity for most of
applications).

All of that is fs-specific and has nothing to the rest of kernel (or
to the kind of kernel, actually - if you look at *BSD implementations
of the same thing you'll find the same behaviour).  If you change
layout (as it had been done for several UFS variants and for htree
variant of ext3) you can get faster algorithms.  Whether it's practically
interesting is a separate question, though - even if kernel side is
fast, you still have userland side to deal with and it tends to behave
quite badly when confronted with huge directories.

