Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286196AbRLaKDs>; Mon, 31 Dec 2001 05:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287427AbRLaKDi>; Mon, 31 Dec 2001 05:03:38 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:58127 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286196AbRLaKD2>;
	Mon, 31 Dec 2001 05:03:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd =?iso-8859-1?q?	kern=20=20el=20panic?= woes
Date: Mon, 31 Dec 2001 11:06:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <20011229164056.H1356@athlon.random> <3C2EB208.B2BA7CBF@zip.com.au>
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16KzKy-0003hd-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2001 07:19 am, Andrew Morton wrote:
> Question: can someone please define BH_New?  Its lifecycle seems
> very vague.

That's because it is.  (vague)  In its current incarnation, BH_New is
valid right after calling xxx_get_block, otherwise it's like a floating
signal.  This is just sloppy.

> We never actually seem to *clear* it anywhere for 
> ext2, and it appears that the kernel will keep on treating a
> clearly non-new buffer as "new" all the time.  ext3 explicitly
> clears BH_New in get_block(), if it finds the block was already
> present in the file.  I did this because we need the newness
> info for internal purposes.

As I understand it, BH_New is set because xxx_get_block created a
block and didn't initialize it - the initialization is expected to
be done by someone else.  So somebody better pick it up before the
block starts transitioning to other states.  The correct model
would use scalars for block states, not bits, and we would
enumerate all the correct transitions.  Since that isn't going to
happen any time soon, we could clear BH_New every time we set some
other state bit.  Or maybe BUG if we ever change another state bit
and BH_NEW is still set, indicating somebody forgot to initialize
the buffer.

Hmm, I'm just taking a look at ext3/inode.c, line 863 - you've just
called getblk, and you will act on BH_New.  Does that code ever get
executed?

--
Daniel
