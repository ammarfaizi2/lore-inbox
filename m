Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274080AbRI0XQn>; Thu, 27 Sep 2001 19:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274082AbRI0XQX>; Thu, 27 Sep 2001 19:16:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57353 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274080AbRI0XQS>; Thu, 27 Sep 2001 19:16:18 -0400
Date: Thu, 27 Sep 2001 16:16:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
 2.4.9-ac14/15(+stuff)]
In-Reply-To: <20010928001321.L14277@athlon.random>
Message-ID: <Pine.LNX.4.33.0109271605550.25667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Andrea Arcangeli wrote:
>
> The deadlock happens in the middle of write_locked_buffers when we hit
> an highmem buffer, so while allocating with GFP_NOHIGHIO we end doing
> sync_page_buffers on any page that isn't highmem, but that incidentally is one of the
> other next buffers in the array that we previously locked in
> write_some_buffers but that aren't in the I/O queue yet (so we'll wait
> forever since they depends on us to be written).

Interesting, indeed..

However, your patch is racy:

> --- 2.4.10aa2/fs/buffer.c.~1~	Wed Sep 26 18:45:29 2001
> +++ 2.4.10aa2/fs/buffer.c	Fri Sep 28 00:04:44 2001
> @@ -194,6 +194,7 @@
>  		struct buffer_head * bh = *array++;
>  		bh->b_end_io = end_buffer_io_sync;
>  		submit_bh(WRITE, bh);
> +		clear_bit(BH_Pending_IO, &bh->b_state);

No way can we clear the bit here, because the submit_bh() may have caused
the buffer to be unlocked and IO to have completed, and it is no longer
"owned" by us - somebody else might have started IO on it and we'd be
clearing the bit for the wrong user.

I would suggest a totally different approach: make the "can we wait for
existing buffer heads" condition a GFP bit the same way the HIGHIO thing
is a GFP bit, and just not set it for GFP_NOHIGHIO.

Thinking about it, I think GFP_NOIO also implies "we must not wait for
other buffers", because that could deadlock for _other_ things too, like
loop and NBD (which use NOIO to make sure that they don't recurse - but
that should also imply not waiting for themselves). The GFP_xxx approach
should fix those deadlocks too.

		Linus


