Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131549AbQL1S5D>; Thu, 28 Dec 2000 13:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131534AbQL1S4x>; Thu, 28 Dec 2000 13:56:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39176 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131611AbQL1S4c>; Thu, 28 Dec 2000 13:56:32 -0500
Date: Thu, 28 Dec 2000 10:25:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Juan Quintela <quintela@fi.udc.es>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] not sleep while holding a locked page in block_truncate_page
In-Reply-To: <Pine.LNX.4.21.0012281411550.12364-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10012281022560.12064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Marcelo Tosatti wrote:
> 
> If we call mark_buffer_dirty() on an already dirty buffer, we may sleep
> waiting for bdflush even if we haven't caused _any_ real disk IO (because
> the buffer was already dirty anyway).
> 
> I think it makes more sense if we only call balance_dirty if we actually
> caused real disk IO.
> 
> Would you accept a patch to change that situation by making
> __mark_buffer_dirty return the old dirty bit value and make
> mark_buffer_dirty only sleep on bdflush if we dirtied a clean buffer?

I would actually prefer not having the balance_dirty() in
mark_buffer_dirty() at all, and then just potentially adding an explicit
balance_dirty to strategic places. There would probably not be that many
of those strategic places.

As it stands, this is a bit too subtle for my taste, having people who
sleep without really realizing it, and not necessarily really wanting to
(not for correctness issues, but for latency issues - that superblock lock
can be quite nasty)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
