Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSHAUca>; Thu, 1 Aug 2002 16:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSHAUca>; Thu, 1 Aug 2002 16:32:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2579 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317012AbSHAUc2>;
	Thu, 1 Aug 2002 16:32:28 -0400
Message-ID: <3D499B28.242D07B8@zip.com.au>
Date: Thu, 01 Aug 2002 13:33:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Peter J. Braam" <braam@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
References: <20020731131620.M15238@lustre.cfs>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter J. Braam" wrote:
> 
> Hi,
> 
> I've just been told that some "limitations" of the following kind will
> remain:
>   page index = unsigned long
>   ino_t      = unsigned long
> 
> Lustre has definitely been asked to support much larger files than
> 16TB.  Also file systems with a trillion files have been requested by
> one of our supporters (you don't want to know who, besides I've no
> idea how many bits go in a trillion, but it's more than 32).
> 
> I understand why people don't want to sprinkle the kernel with u64's,
> and arguably we can wait a year or two and use 64 bit architectures,
> so I'm probably not going to kick up a fuss about it.
> 
> However, I thought I'd let you know that there are organizations that
> _really_ want to have such big files and file systems and get quite
> dismayed about "small integers".  And we will fail to deliver on a
> requirement to write a 50TB file because of this.

I don't know about the ino_t thing, but as far as the pagecache
indices goes it's simply a matter of

- s/unsigned long/pgoff_t/ in a zillion places
- modify the radix tree code a bit
- implement CONFIG_LL_PAGECACHE_INDEX
- make it all work
- convince Linus

Linus's objections are threefold:  it expands struct page, 64 bit
arith is slow and gcc tends to get it wrong.  And I would add "most
developers won't test 64-bit pgoff_t, and it'll get broken regularly".

The expansion of struct page and the performance impact is just a
cost which you'll have to balance against the benefits.  For a few
people, 32-bit pagecache index is a showstopper and they'll accept that
tradeoff.

Sprinkling `pgoff_t' everywhere is, IMO, not a bad thing - it aids code
readability because it tells you what the variable is used for.

As for broken gcc, well, the proponents of 64-bit pgoff_t would have
to work to identify the correct gcc version and generally get gcc
doing the right thing.
