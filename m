Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265472AbRGJFL7>; Tue, 10 Jul 2001 01:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbRGJFLu>; Tue, 10 Jul 2001 01:11:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13424 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265472AbRGJFLl>; Tue, 10 Jul 2001 01:11:41 -0400
Date: Tue, 10 Jul 2001 07:11:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VM in 2.4.7-pre hurts...
Message-ID: <20010710071125.L1594@athlon.random>
In-Reply-To: <20010710045617.J1594@athlon.random> <Pine.LNX.4.33.0107092053130.10187-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107092053130.10187-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jul 09, 2001 at 09:03:33PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 09:03:33PM -0700, Linus Torvalds wrote:
> No. Playing with the bh count for those two makes the rules be the same
> for everybody, because the sync_io handler needs it, and then we might as
> well just make it a general rule: IO in-flight shows up as an elevated
> count. It also makes sense from a "reference count" standpoint - the

At least for the kiobuf case the notion of IO in flight is hold in the
iobuf->io_count, about the reference count there isn't a reference count
at all on those bh, they're just an array of ram in the iobuf.

Infact the b_count is also never read, exactly because the notion of
reference-count/in-flight-I/O doesn't belong there.

One valid argument is to do the same thing before all sumbit_bh which
doesn't seem to have a big value to me at the moment, maybe I'm wrong
in the long term but certainly at this moment that sounds more like
wasted cpu than cleaner code.

so I guess I'd prefer something like this:

--- 2.4.7pre5/fs/buffer.c.~1~	Tue Jul 10 03:55:21 2001
+++ 2.4.7pre5/fs/buffer.c	Tue Jul 10 06:52:38 2001
@@ -2006,7 +2006,6 @@
 
 	kiobuf = bh->b_private;
 	__unlock_buffer(bh);
-	put_bh(bh);
 	end_kio_request(kiobuf, uptodate);
 }
 
@@ -2131,7 +2130,6 @@
 				offset += size;
 
 				atomic_inc(&iobuf->io_count);
-				get_bh(tmp);
 				submit_bh(rw, tmp);
 				/* 
 				 * Wait for IO if we have got too much 


(personally I guess I'd still prefer to do the same for the async-IO
handler, but for it at least the b_count is checked eventually by
somebody [try_to_free_pages] so it somehow make more sense even if in
practice it isn't not needed there either)

Andrea
