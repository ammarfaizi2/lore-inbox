Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265032AbRFUQ4T>; Thu, 21 Jun 2001 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbRFUQz7>; Thu, 21 Jun 2001 12:55:59 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34308 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265032AbRFUQzw>; Thu, 21 Jun 2001 12:55:52 -0400
Date: Thu, 21 Jun 2001 09:54:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <Stefan.Bader@de.ibm.com>, <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>
Subject: Re: correction: fs/buffer.c underlocking async pages
In-Reply-To: <20010621170813.F29084@athlon.random>
Message-ID: <Pine.LNX.4.33.0106210951530.1260-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Jun 2001, Andrea Arcangeli wrote:
>
> It seems we can more simply drop the tmp->b_end_io == end_buffer_io_async
> check enterely and safely.

I doubt it.

Think about somebody who writes a partial page (but a full buffer).
Somebody _else_ then reads the rest of the page. You'll have one buffer
up-to-date (but possibly under write-back IO), and the others being read
in asynchronously.

> +++ 2.4.6pre5aa1/fs/buffer.c	Thu Jun 21 17:05:18 2001
> @@ -850,7 +850,7 @@
>  	atomic_dec(&bh->b_count);
>  	tmp = bh->b_this_page;
>  	while (tmp != bh) {
> -		if (tmp->b_end_io == end_buffer_io_async && buffer_locked(tmp))
> +		if (buffer_locked(tmp))
>  			goto still_busy;
>  		tmp = tmp->b_this_page;
>  	}
>
> can anybody see a problem in the above patch? Al, Ingo, Linus?

The above _will_ break. "tmp" may be locked due to the write - and the
write will never call "end_buffer_io_async" because writes do not unlock
the page. So if the write finishes last, you'll _never_ unlock the page.

I don't see why Stefan wants to change the current logic. The current
logic is correct, and if there are double-unlock problems then those are
due to some other bug.

		Linus

