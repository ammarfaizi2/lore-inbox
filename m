Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135926AbRDZVNh>; Thu, 26 Apr 2001 17:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135925AbRDZVN2>; Thu, 26 Apr 2001 17:13:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14410 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135926AbRDZVNQ>; Thu, 26 Apr 2001 17:13:16 -0400
Date: Thu, 26 Apr 2001 23:07:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426230751.J819@athlon.random>
In-Reply-To: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com> <Pine.GSO.4.21.0104261625550.15385-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0104261625550.15385-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 26, 2001 at 04:49:20PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 04:49:20PM -0400, Alexander Viro wrote:
> 	getblk(); if (!buffer_uptodate) wait_on_buffer();
> is not in that class. It _is_ OK on UP as long as we don't block, but on
> SMP it doesn't guarantee anything - buffer_head can be in any state
> when we are done. IMO all such places require fixing.

Yes, actually it's probably ok for most of other "fs" against "fs" cases
because those fses still hold the big lock while handling metadata but
they should really use the lock_buffer way if they want to protect
against the block_dev accesses too.

> How about adding
> 	if (!buffer_uptodate(bh)) {
> 		printk(KERN_ERR "IO error or racy use of wait_on_buffer()");
> 		show_task(current);
> 	}
> in the end of wait_on_buffer() for a while?

At the _top_ of wait_on_buffer would be better then at the end.

Andrea
