Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbQLIR73>; Sat, 9 Dec 2000 12:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbQLIR7S>; Sat, 9 Dec 2000 12:59:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64018 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129601AbQLIR7N>; Sat, 9 Dec 2000 12:59:13 -0500
Date: Sat, 9 Dec 2000 09:28:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@chiara.elte.hu>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.GSO.4.21.0012090415330.29053-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012090924390.1574-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Alexander Viro wrote:
> 	Fine
> > -		atomic_inc(&bh->b_count);
> 
> 	Why? It's cleaner the old way - why bother postponing that until we
> lock the thing?

I had a rule: we always do the "lock_buffer()" and "b_count increment"
together with setting "b_end_io = end_buffer_io_async". Why? Because that
way we pair up the actions, and I could easily verify that every single
user of "end_buffer_io_async" will increment the count (that is
decremented in "end_buffer_io_async").

We never used to have any rules in this area, and it was sometimes hard to
match up the actions with each other.

> >  int brw_page(int rw, struct page *page, kdev_t dev, int b[], int size)
> 
> >  	if (!page->buffers)
> > +		create_page_buffers(rw, page, dev, b, size);
> 
> 		create_empty_buffers(page, dev, size);

Agreed.

> 	Modulo the comments above - fine with me. However, there is stuff in
> drivers/md that I don't understand. Ingo, could you comment on the use of
> ->b_end_io there?

I already sent him mail about it for the same reason. 

> 	Another bad thing is in mm/filemap.c::writeout_one_page() - it doesn't
> even check for buffers being mapped, let alone attempt to map them.
> 	Fortunately, ext2 doesn't use it these days, but the rest of block
> filesystems... <doubletake> WTF? fsync() merrily ignores mmap()'ed stuff?

fsync() has _always_ ignored mmap'ed stuff. 

If you want to get your mappings synchronized, you absolutely positively
have to call "msync()".

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
