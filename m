Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWHKA7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWHKA7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWHKA7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:59:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:24205 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932415AbWHKA7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:59:05 -0400
Subject: Re: [PATCH 2/9] sector_t format string
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060809234019.c8a730e3.akpm@osdl.org>
References: <1155172843.3161.81.camel@localhost.localdomain>
	 <20060809234019.c8a730e3.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 10 Aug 2006 17:59:01 -0700
Message-Id: <1155257941.4505.32.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 23:40 -0700, Andrew Morton wrote:
> On Wed, 09 Aug 2006 18:20:43 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> > 
> > Define SECTOR_FMT to print sector_t in proper format
> > 
> > ...
> >
> >  #define HAVE_SECTOR_T
> >  typedef u64 sector_t;
> > +#define SECTOR_FMT "%llu"
> 
> We've thus-far avoided doing this.  In fact a similar construct in
> device-mapper was recently removed.
> 
> Unlike many other attempts, this one appears to be correct (people usually
> get powerpc wrong, due to its u64=unsigned long).
> 
> That being said, I'm not really sure we want to add this.  It produces
> rather nasty-looking source code and thus far we've just used %llu and we've
> typecasted the sector_t to `unsigned long long'.  That happens in a lot of
> places in the kernel and perhaps we don't want to start innovating in ext4
> ;)
> 
> That also being said...  does a 32-bit sector_t make any sense on a
> 48-bit-blocknumber filesystem?  I'd have thought that we'd just make ext4
> depend on 64-bit sector_t and be done with it.
> 
> Consequently, sector_t should largely vanish from ext4 and JBD2, except for
> those places where it interfaces with the VFS and the block layer. 
> Internally it should just use 64-bit quantities.  That could be u64, but
> I'd suggest that the fs simply open-code `unsigned long long' so that we
> don't need to play any gams at all when passing these things into printk.
> 

I am fine with unsigned long long -- it does makes the printk a lot
simplier--- I think we had a debate about whether to use sector_t or
just unsigned long long on ext2-devel before, the argument at that time
is to avoid unnecssary memory for in-kernel block variables on 32 bit
machine ..I think that's the concern about using unsigned long long. 

I intend to agree with you that the benefit is not so obvious. And since
the on-disk data block number and some metadata are 48bit all the time,
we do have to check the bits of the sector_t to make sure the in-kernel
block variable have enough room to store the blocks when read it from
disk. Not very pretty.


> Finally, perhaps the code is printing block numbers too much ;)
> 


> <Notices E3FSBLK, wonders how that snuck through>
> 
When we cleanup ext3 code to fix some "int" type block numbers to
"unsigned long" type to able to truely support 2^32 bit ext3 (otherwise
ext3 is limited to 2^31 blocks (8TB)), we had to go through a lot of
printk to modify the format string from %d to %lu. It's a pain.

At that time we are planning to have 48 bit ext3 (now ext4) too, so we
need to go through the same pain again: replace all %lu to %llu in all
the places where the blocks are being print out. Another huge chunk of
patch.

So the decision at that time is to do it once: identify all the printk
cases and use a micro to replace the format string.  That is the reason
behind the E3FSBLK

I agree with you that this makes the code hard to read -- I'm fine to
remove it. Fortunately with the previous work, removing it is not so
hard, just simplely search/replace.

The only thing is that we need to type cast every block numbers to be
printed, if the block type is sector_t -- that's a pain. For this reason
I do like to use unsigned long long instead of sector_t.

> I'd suggest that "[patch] ext3: remove E3FSBLK" be written and merged
> before we clone ext4, too...
> 

Mingming

