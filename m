Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274172AbRI1AIL>; Thu, 27 Sep 2001 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274164AbRI1AIA>; Thu, 27 Sep 2001 20:08:00 -0400
Received: from [195.223.140.107] ([195.223.140.107]:29692 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274172AbRI1AH4>;
	Thu, 27 Sep 2001 20:07:56 -0400
Date: Fri, 28 Sep 2001 02:08:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928020810.C14277@athlon.random>
In-Reply-To: <20010928001321.L14277@athlon.random> <Pine.LNX.4.33.0109271605550.25667-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109271605550.25667-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Sep 27, 2001 at 04:16:11PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 04:16:11PM -0700, Linus Torvalds wrote:
> Thinking about it, I think GFP_NOIO also implies "we must not wait for
> other buffers", because that could deadlock for _other_ things too, like
> loop and NBD (which use NOIO to make sure that they don't recurse - but
> that should also imply not waiting for themselves). The GFP_xxx approach
> should fix those deadlocks too.

I don't understand very well your point about GFP_NOIO, GFP_NOIO is a no
brainer, loop/NDB etc.. all them are safe since GFP_NOIO will forbid to
arrive in sync_page_buffers in first place.

The only brainer is the GFP_NOHIGHIO that can arrive there on lowmem
pages since it only protects against itself from all the callers via the
pagehighmem logic, so only the callers that locks down highmem and then
nohighmem and then start the I/O on the highmem are subject to the
highmem deadlock. The only point that locks down highmem and then
nohighmem and then starts I/O on highmem seems to be the
write_some_buffers. However I could agree if you're worried other places
does it too, but if they do we could teach them to use the pending_IO
information too so we could be more finegrined with my approch.

Andrea
