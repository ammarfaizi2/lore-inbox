Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277716AbRJRQRj>; Thu, 18 Oct 2001 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRJRQR3>; Thu, 18 Oct 2001 12:17:29 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:25728 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S277716AbRJRQRT>; Thu, 18 Oct 2001 12:17:19 -0400
Date: Thu, 18 Oct 2001 19:17:32 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Kamil Iskra <kamil@science.uva.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
Message-ID: <20011018191732.B1262@niksula.cs.hut.fi>
In-Reply-To: <20011018092837.C1144@turbolinux.com> <Pine.LNX.4.33.0110181734270.7583-100000@krakow.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110181734270.7583-100000@krakow.science.uva.nl>; from kamil@science.uva.nl on Thu, Oct 18, 2001 at 05:42:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 05:42:44PM +0200, you [Kamil Iskra] claimed:
> On Thu, 18 Oct 2001, Andreas Dilger wrote:
> 
> > > The behaviour is as if no caching was done,
> > > there is a slowdown by a factor of two.
> > I think this is a result of the "blockdev in pagecache" change added in
> > 2.4.10.  One of the byproducts of this change is that if a block device
> > is closed (no other openers) then all of the pages from this device are
> > dropped from the cache.  In the case of a floppy drive, this is very
> > important, as you don't want to be cacheing data from one floppy after
> > you have inserted a new floppy.
> >
> > In contrast, if you mounted the floppy instead of using mtools, it would
> > probably have good performance for small files as well.
> 
> That's very interesting.  It would explain why it takes 2 seconds _every_
> time you invoke "mdir", whereas before the invocations after the first one
> were more or less instantenous.  And indeed, as you say, mounting a floppy
> does result in a good performance.
> 
> However, it does not explain why the first invocation is two times slower
> (it's 1 sec with kernel 2.4.9 and 2 secs with 2.4.10, the effect is even
> more visible for mcopy of a small file, like 30KB).  I strace'd mdir and
> it's opening /dev/fd0 just once, at the beginning, and closing it at the
> end.

That's propably beacause it syncs the writes on close().

Perhaps you could try the trick Linus suggested in another thread, namely:

sleep 1000 < /dev/fd0 &

mdir 
mcopy
mdir
mcopy
<do whatever>

kill %1

That keeps one (dummy) reference to the floppy device open until you're done
using it.


-- v --

v@iki.fi
