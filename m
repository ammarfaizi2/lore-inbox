Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135631AbRDSLqM>; Thu, 19 Apr 2001 07:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135633AbRDSLqC>; Thu, 19 Apr 2001 07:46:02 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:60938 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135631AbRDSLpy>; Thu, 19 Apr 2001 07:45:54 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: riel@conectiva.com.br, viro@math.psu.edu
Subject: Re: Ext2 Directory Index - Delete Performance
Cc: adilger@turbolinux.com, ext2-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, phillips@nl.linux.org
Message-Id: <20010419114416Z92314-11620+7@humbolt.nl.linux.org>
Date: Thu, 19 Apr 2001 13:44:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 18 Apr 2001, Rik van Riel wrote:
> > One thing we should do is make sure the buffer cache code sets
> > the referenced bit on pages, so we don't recycle buffer cache
> > pages early.
> >
> > This should leave more space for the buffercache and lead to us
> > reclaiming the (now unused) space in the dentry cache instead...
> 
> Sorry, but that's just plain wrong. We shouldn't keep inode table in
> buffer-cache at all. And we should be more aggressive on icache -
> dcache looks sane now (recent 2.4.4-pre), but icache holds unused
> inodes for too long. And freeing them is very slow _and_ random -
> recipe for kmem_cache fragmentation.
>  
> /me sits down to port inode-table-in-pagecache to 2.4.4-pre4...

The Ext2 inode-table maps nicely to the page cache with the current
page cache interface because it has uniform sized chunks that are accessed one
at a time, and likewise for the group descriptor cache.

*But* the directory code in page cache with your current approach does not
work out nicely with my directory index - it doesn't have page-sized chunks
and access to them is overlapped.  This isn't an isolated problem, it's a
problem we've managed to avoid dealing with so far because much of the file
code we have does satisfy your two pre-conditions:

  - Data groups naturally into pages
  - Access to data items is strictly serial

We need a way of accessing the page cache that doesn't rely on either of
those two assumptions.
--
Daniel
