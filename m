Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRHDBjs>; Fri, 3 Aug 2001 21:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269753AbRHDBji>; Fri, 3 Aug 2001 21:39:38 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:44297 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269750AbRHDBj3>; Fri, 3 Aug 2001 21:39:29 -0400
Message-ID: <3B6B53A9.A9923E21@zip.com.au>
Date: Fri, 03 Aug 2001 18:45:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic 
 change patch)
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>,
		<3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Fri, Aug 03, 2001 at 06:08:49PM -0700, Andrew Morton wrote:
> 
>     Ow.  You just crippled ext3.
> 
> How so? The Flush all transactions on fsync behaviour that resierfs
> did/does have at present too?  (There are 'fixes' to reiserfs for
> this).

That, plus the fact that ext3 gets its synchronous-op scalability
from batching the transactions from multiple threads together.
The holding of parent->parent->i_sem across synchronous writes could
defeat that.

ext3 does physical, block-level journalling.  (its journalling layer is
actually designed to be fs-independent so one could journal other filesystems
with it).  So there is no tracking between a particular fs event and a
particular transaction.  A transaction is just a blob of blocks which
can encompass thousands of fs events.

>     I don't think an ext2 problem (which I don't think is a problem at
>     all) should be "fixed" at the VFS layer when other filesystems are
>     perfectly happy without it, no?
> 
> If you want to be sure that when you fsync a file, that, silly bugger
> rename games further up the path aside, the entire path is also on
> disk, the VFS is the only place to do it with the current fs API.
> 
> really, there is _some_ merit in the argument that
> 
>         open
>         fsync
>         close
> <crash>
> 
> shouldn't loose the file...

Agreed - I think it's the expected and sensible behaviour.  But I've seen
no complaints about it except for use in a few specialised applications.
Where "a few" == "one", actually.

>     This whole thread, talking about "linux this" and "linux that" is
>     off-base.  It's ext2 we're talking about.  This MTA requirement is
>     a highly unusual and specialised thing - I don't see why the
>     general-purpose ext2 should bear the burden of supporting it when
>     other filesystems such as reiserfs (I think?) and ext3 support it
>     naturally and better than ext2 ever will.
> 
> Well, since it will only sync dirty blocks, it will hardly hurt ext2
> that much at all --- and it will only force the dirty blocks in path
> components to be written when you fsync the file, thats probably only
> a single block anyhow.

mmm... Holding i_sem across multiple revs of the disk will hurt.  It
doesn't *need* to be held while we're waiting on IO, but fixing that
would be a big change, and there has been little motivation to change
things because it is for specialised apps.

-
