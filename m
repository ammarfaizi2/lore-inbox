Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSHDDEH>; Sat, 3 Aug 2002 23:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318077AbSHDDEH>; Sat, 3 Aug 2002 23:04:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60165 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318075AbSHDDEH>;
	Sat, 3 Aug 2002 23:04:07 -0400
Message-ID: <3D4C9CB6.92504CF0@zip.com.au>
Date: Sat, 03 Aug 2002 20:17:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] slablru for linux-2.5 bk tree
References: <Pine.LNX.4.44.0207282324340.872-100000@home.transmeta.com> <200208011942.49342.tomlins@cam.org> <3D49C951.AB7C527E@zip.com.au> <200208031527.15093.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> Hi,
> 
> Here the slablru patch ported to 2.5.30.

Ed, it's going to take some time/effort to get this shaken down
and into the tree, I expect.  There's quite a bit banked up
at present.

I'll take care of any stability and performance stuff in slablru, but
the wider question is: what behaviour do we actually _want_ for slab
pages, and is this code delivering it?   Need to think about that.  But
we certainly can't do worse than we are at present ;)

I've merged your patch on top of the pagemap_lru_lock patches. A whole
bunch of nastiness went away because those patches allow us to take that
lock from interrupt context.

The locking in slab.c needs some going over - I think it's wrong from a
2.4 perspective: there's one ranking bug between pagemap_lru_lock and
the cachep->spinlock.  I'd suggest that you change the 2.4 implementation
to just drop pagemap_lru_lock before calling from vmscan into
kmem_shrink_slab().  One thing will lead to another and the locking in slab
will get simpler. Just make the lru lock nest inside the cachep->spinlock.

The fiddled patch is at http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.30/
I'll read through it a bit more next week, give it a bit of testing.

Thanks.
