Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285477AbRLGToZ>; Fri, 7 Dec 2001 14:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285478AbRLGToF>; Fri, 7 Dec 2001 14:44:05 -0500
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:56587 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285477AbRLGToB>;
	Fri, 7 Dec 2001 14:44:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Fri, 7 Dec 2001 20:46:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>,
        Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CP0X-0000uE-00@starship.berlin> <3C110B3F.D94DDE62@zip.com.au>
In-Reply-To: <3C110B3F.D94DDE62@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16CQwl-0000vL-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 07:32 pm, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > Because Ext2 packs multiple entries onto a single inode table block, the
> > major effect is not due to lack of readahead but to partially processed
> > inode table blocks being evicted.
> 
> Inode and directory lookups are satisfied direct from the icache/dcache,
> and the underlying fs is not informed of a lookup, which confuses the VM.
> 
> Possibly, implementing a d_revalidate() method which touches the
> underlying block/page when a lookup occurs would help.

Very interesting point, the same thing happens with file index blocks vs page 
cache accesses.  You're suggesting we need some kind of mechanism for 
propagating hits on cache items, either back to the underlying data or the 
information used to regenerate the cache items.

On the other hand, having the underlying itable blocks get evicted can be 
looked at as a feature, not a bug - it reduces double storage, allowing more 
total items in cache.

There's also a subtle mechanism at work here - if any of the icache items on 
an itable block gets evicted, then recreated before the itable block is 
evicted, we *will* get an access hit on the itable block and grandma won't 
have to sell the farm (I made that last part up).

--
Daniel


