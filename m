Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315522AbSEMEwF>; Mon, 13 May 2002 00:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315739AbSEMEwE>; Mon, 13 May 2002 00:52:04 -0400
Received: from mail.eskimo.com ([204.122.16.4]:50959 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S315522AbSEMEwE>;
	Mon, 13 May 2002 00:52:04 -0400
Date: Sun, 12 May 2002 21:51:27 -0700
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Alexander Viro <viro@math.psu.edu>, Peter Chubb <peter@chubb.wattle.id.au>,
        Elladan <elladan@eskimo.com>, Jakob ?stergaard <jakob@unthought.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020512215127.A26807@eskimo.com>
In-Reply-To: <Pine.GSO.4.21.0205121848080.27629-100000@weyl.math.psu.edu> <3CDF3F92.B3C3A18A@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 06:22:42AM +0200, Kasper Dupont wrote:
> Alexander Viro wrote:
> > 
> > On Mon, 13 May 2002, Peter Chubb wrote:
> > 
> > > This is why in SVr4, struct cred is cloned at open time, and passed
> > > down to each VFS operation.
> > 
> > That doesn't work for shared mappings over holes.  Unfortunately.
> > Yes, credentials cache a-la 4.4BSD would help in many cases, but
> > we have no reasonably credentials when kswapd writes a dirty page
> > on disk.  It _can_ cause allocations.  And many processes might've
> > touched that page until it finally got written out - which credentials
> > would you use?
> 
> I'd rather have the check done when the page gets dirty in the
> first place. Refuse the CoW if there is not diskspace to write
> it back. Right now we can go beyond the diskspace we are allowed
> to use and we will silently loose data if we go beyond the
> available diskspace.

So, the way this would work (presumably) is that space gets reserved on
the filesystem as soon as the page goes dirty, if space is not presently
allocated for that page.  The process would receive a SIGBUS if they
attempt to write to the page, but backing store reservation failed, as
they do when, eg., there's an IO error on a page or some such.

If the mapping was held by more than one process, and one had permission
to dirty the page and the other did not, then whose credentials should
get used would just be a matter of which one writes first.  If the disk
is full for users and root dirties the page first, then the user can
re-dirty it.  If the user dirties it first, then the user receives
SIGBUS.  If the disk is full for everyone, then either one would receive
the signal.

-J
