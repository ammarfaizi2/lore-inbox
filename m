Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbREROrj>; Fri, 18 May 2001 10:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbREROr3>; Fri, 18 May 2001 10:47:29 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:27088 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262323AbREROrV>; Fri, 18 May 2001 10:47:21 -0400
Date: Fri, 18 May 2001 15:46:35 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Pavel Machek <pavel@suse.cz>, Alexander Viro <viro@math.psu.edu>,
        Chris Wedgwood <cw@f00f.org>, Andrea Arcangeli <andrea@suse.de>,
        Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010518154635.B10515@redhat.com>
In-Reply-To: <20010506153218.A11911@tapu.f00f.org> <Pine.GSO.4.21.0105052338580.26799-100000@weyl.math.psu.edu> <20010507184224.A32@(none)> <01051116544400.01990@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01051116544400.01990@starship>; from phillips@bonn-fries.net on Fri, May 11, 2001 at 04:54:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 11, 2001 at 04:54:44PM +0200, Daniel Phillips wrote:

> The only reasonable way I can think of getting a block-coherent view 
> underneath a mounted fs is to have a reverse map, and update it each 
> time we map block into the page cache or unmap it.

It's called the "buffer cache", and Ingo's early page-cache code in
2.3 actually did install page-cache backing buffers into the buffer
cache as aliases, mainly for debugging purposes.

Even without that, though, an application can achieve almost-coherency
via invalidation of the buffer cache before reading it.  And yes, this
won't necessarily remain coherent over the lifetime of the application
process, but then unless the filesystem is 100% quiescent then you
don't get that on 2.2 either.

Which is rather the point.  If the filesystem is active, then
coherency cannot be obtained at the block-device level in any case
without knowledge of the fs transaction activity.  If the filesystem
is quiescent, then you can sync it and flush the buffer cache and you
already get the coherency that you need.

Cheers,
 Stephen
