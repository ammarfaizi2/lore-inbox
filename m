Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSAVVYU>; Tue, 22 Jan 2002 16:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289316AbSAVVYK>; Tue, 22 Jan 2002 16:24:10 -0500
Received: from 216-42-72-169.ppp.netsville.net ([216.42.72.169]:53464 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289306AbSAVVXy>; Tue, 22 Jan 2002 16:23:54 -0500
Date: Tue, 22 Jan 2002 16:22:52 -0500
From: Chris Mason <mason@suse.com>
To: Steve Lord <lord@sgi.com>
cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <2124090000.1011734572@tiny>
In-Reply-To: <1011730398.1281.114.camel@jen.americas.sgi.com>
In-Reply-To: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com>
 <3C4DB36F.4090306@namesys.com>  <2080500000.1011727185@tiny>
 <1011730398.1281.114.camel@jen.americas.sgi.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, January 22, 2002 02:13:18 PM -0600 Steve Lord <lord@sgi.com>
wrote:

> Looks like I've been missing an interesting thread here ....

Hi Steve ;-)

> 
> Surely flushing pages (and hence cleaning them) is not a bad thing to
> do, provided you do not suck up all the available I/O bandwidth in the
> process. The filesystem decides to clean the pages as it is efficient
> from an I/O point of view. The vm is then free to reuse lots of pages
> it could not before, but it still gets to make the decision about the
> pages being good ones to reuse.

Very true, there are a few different workloads to consider.

1) The box really needs ram right now, and we should do the minimum amount
of work to get it done.  This is usually done by kswapd or a process doing
an allocation.  It should help if the FS gives the VM enough details to
skip pages that require extra allocations (like commit blocks) in favor of
less expensive ones.

2) There's lots of dirty pages around, it would be a good idea to flush
some, regardless of how many pages might be freeable afterwards.  This is
where we want most of the i/o to actually happen, and where we want to give
the FS the most freedom in regards to which pages get written.

> 
> The xfs kernel changes add a call to writepage into the buffer flushing
> path when the data is delayed allocate. We then end up issuing I/O on
> surrounding pages which end up being contiguous on disk and are not
> currently locked by some other thread.

This probably helps in both situations listed, assuming things like HIGHMEM
bounce buffers don't come into play.

-chris

