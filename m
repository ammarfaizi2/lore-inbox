Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRKSUOU>; Mon, 19 Nov 2001 15:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280680AbRKSUOK>; Mon, 19 Nov 2001 15:14:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:993 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276956AbRKSUOC>;
	Mon, 19 Nov 2001 15:14:02 -0500
Date: Mon, 19 Nov 2001 15:13:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] problem with grow_dev_page()/readpage()
In-Reply-To: <Pine.LNX.4.33.0111191147040.8447-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111191501000.19969-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, Linus Torvalds wrote:

> 
> On Mon, 19 Nov 2001, Alexander Viro wrote:
> >
> > 	Look at block_read_full_page().  If it sees ->buffers != NULL, it
> > assumes that buffer size corresponds to ->i_blkbits.
> 
> It doesn't matter - it doesn't _use_ the thing, if the buffers are mapped
> (and they will always be mapped for block devices).

That breaks if you do bread() on something less than hardware sector size,
though.  Then all following attempts to read that page (until ->buffers
is evicted) will keep trying to submit IO on too small buffers.

So at the very least grow_dev_page() should check that size is not smaller than
hardware sector size, not 512.  ACK?

