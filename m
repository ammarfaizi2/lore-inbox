Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261190AbREYRlZ>; Fri, 25 May 2001 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261230AbREYRlQ>; Fri, 25 May 2001 13:41:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30419 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261190AbREYRk6>;
	Fri, 25 May 2001 13:40:58 -0400
Date: Fri, 25 May 2001 13:40:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <Pine.LNX.4.21.0105250959580.11312-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105251325380.27664-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Linus Torvalds wrote:

> If somebody can show that the above is worth it and worth implementing (ie
> the Al Viro kind of "I have a real-life schenario where I'd like to use
> it"), and implements it (should be a fairly trivial exercise), then I'll
> happily accept new semantics like this.

OK, here's a real-world scenario: inode table on 1Kb ext2 (or 4Kb on
Alpha, etc.) consists of compact pieces - one per cylinder group.

There is a natural mapping from inodes to offsets in that beast.
However, these pieces can trivially be not page-aligned. readpage()
on a boundary of two pieces means large seek.

Another example (even funnier) is bitmaps. Same story, but here you can
have 1Kb per cylinder group. Which is 8Mb in that case. I.e. on Alpha
it means that readpage() will require 7 seeks, 8Mb each. And the worst
thing being, unless we have corrupted free inodes counters we _will_
find what we need in the first 1Kb chunk we are looking at.

I can easily give more examples - just ask. BTW, the fact that this stuff
is so fragmented is not a bug - we want it evenly spread over disk, just
to have the ability to allocate a block/inode not too far from the piece
of bitmap we'll need to modify.
								Al
PS: Uff... OK, looking at the locking stuff in fs/super.c was useful - I've
found a way to do it that is seriously simpler than what I used to do.
Just let me torture it for a couple of hours - so far it looks fine...

