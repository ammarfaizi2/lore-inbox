Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275156AbRJAPfT>; Mon, 1 Oct 2001 11:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275155AbRJAPfL>; Mon, 1 Oct 2001 11:35:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275161AbRJAPeu>; Mon, 1 Oct 2001 11:34:50 -0400
Date: Mon, 1 Oct 2001 08:35:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11-pre1 oops in bdget()
In-Reply-To: <1262100000.1001940100@tiny>
Message-ID: <Pine.LNX.4.33.0110010832060.1610-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Oct 2001, Chris Mason wrote:
>
> >>> EIP; c0133664 <bdget+f8/180>   <=====
> > Trace; c0133792 <bd_acquire+26/80>
> > Trace; c0133c16 <blkdev_open+16/b8>
>
> Well, this isn't good, looks like we've already freed something and are
> still using it.  Could you please turn on 'Debug memory allocations' in the
> kernel debugging section of make config, and try to reproduce again?

No, it's actually the thing that Al already warned me about, and I didn't
realize how serious it was.

The thing we oops on is the _old_ blksize_size[] array information for the
floppy, which was loaded as a module and then unloaded - it's ugly that it
doesn't clean up its copy of the blksize_size array, but the real cause
for the problem is that bdget() references it before it has opened the
device.

The (untested) fix is to just remove the line in bdget() that sets
i_blkbits, as the thing is later set correctly in blkdev_get().

		Linus

