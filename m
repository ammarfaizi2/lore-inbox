Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264998AbRFUPJc>; Thu, 21 Jun 2001 11:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264995AbRFUPJW>; Thu, 21 Jun 2001 11:09:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:59004 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264998AbRFUPJQ>; Thu, 21 Jun 2001 11:09:16 -0400
Date: Thu, 21 Jun 2001 17:08:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stefan.Bader@de.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <20010621170813.F29084@athlon.random>
In-Reply-To: <C1256A72.00507ECF.00@d12mta05.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1256A72.00507ECF.00@d12mta05.de.ibm.com>; from Stefan.Bader@de.ibm.com on Thu, Jun 21, 2001 at 04:39:11PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 04:39:11PM +0200, Stefan.Bader@de.ibm.com wrote:
> 
> 
> 
> Hi,
> 
> I ran into some problems with buffer.c trying to unlock a page of

sorry for the huge delay in the answer, I was going to answer your
previous two emails very shortly (I didn't forgotten ;).

> async io buffer heads more than once.  IMHO end_buffer_io_async()
> shouldn't rely on the value of b_end_io to decide if the whole page
> can be unlocked. It would make it easier for other layers (well
> remappers like md or lvm) to create an end_io chain without the need
> of allocating new buffer heads just for that.  Is the comparision on

It seems we can more simply drop the tmp->b_end_io == end_buffer_io_async
check enterely and safely. Possibly we could build a debugging logic to
make sure nobody ever lock down a buffer mapped on a pagecache that is
under async I/O (which in realty is "sync" I/O, you know the async/sync
names of the kernel io callbacks are the opposite of realty ;).

The reason it seems safe to me is that when a pagecache is under async
I/O (async in kernel terms) it says locked all the time until the last
call of the async I/O callback, and _nobody_ is ever allowed to mess
with the anon bh overlapped on the pagecache while the page stays locked
down. As far as the async end_io callback is recalled it means the page
is still locked down so we know if the end_io callback points to
something else it's because of a underlying remapper, nobody else would
be allowed to play the bh of a page locked down.

so in short:

--- 2.4.6pre5aa1/fs/buffer.c.~1~	Thu Jun 21 16:22:40 2001
+++ 2.4.6pre5aa1/fs/buffer.c	Thu Jun 21 17:05:18 2001
@@ -850,7 +850,7 @@
 	atomic_dec(&bh->b_count);
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
-		if (tmp->b_end_io == end_buffer_io_async && buffer_locked(tmp))
+		if (buffer_locked(tmp))
 			goto still_busy;
 		tmp = tmp->b_this_page;
 	}

can anybody see a problem in the above patch? Al, Ingo, Linus?

Andrea
