Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135913AbRDZUvR>; Thu, 26 Apr 2001 16:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135911AbRDZUvI>; Thu, 26 Apr 2001 16:51:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54697 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135915AbRDZUut>;
	Thu, 26 Apr 2001 16:50:49 -0400
Date: Thu, 26 Apr 2001 16:49:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104261625550.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Linus Torvalds wrote:

> Note that I think all these arguments are fairly bogus.  Doing things like
> "dump" on a live filesystem is stupid and dangerous (in my opinion it is
> stupid and dangerous to use "dump" at _all_, but that's a whole 'nother
> discussion in itself), and there really are no valid uses for opening a
> block device that is already mounted. More importantly, I don't think
> anybody actually does.

Agreed.

> The fact that you _can_ do so makes the patch valid, and I do agree with
> Al on the "least surprise" issue. I've already applied the patch, in fact.
> But the fact is that nobody should ever do the thing that could cause
> problems.

IMO the real issue is in fuzzy rules for use of wait_on_buffer(). There is
one case when it's 100% correct - when we had done ll_rw_block() on that
bh at earlier point and want to make sure that it's completed. And there
is a lot of uses that are kinda-sorta correct for UP, but break on SMP.
unmap_buffer() was similar to that race. So are races in minix, sysvfs and
ufs. So is one in block_write() and here the problem is quite real - it's
not as idiotic as device/mounted fs races.

Basically, all legitimate cases are ones where we would be very unhappy
about buffer being not uptodate afterwards.
	getblk(); if (!buffer_uptodate) wait_on_buffer();
is not in that class. It _is_ OK on UP as long as we don't block, but on
SMP it doesn't guarantee anything - buffer_head can be in any state
when we are done. IMO all such places require fixing.

How about adding
	if (!buffer_uptodate(bh)) {
		printk(KERN_ERR "IO error or racy use of wait_on_buffer()");
		show_task(current);
	}
in the end of wait_on_buffer() for a while?
								Al

