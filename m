Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131769AbQJ2Onh>; Sun, 29 Oct 2000 09:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbQJ2On1>; Sun, 29 Oct 2000 09:43:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33447 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131762AbQJ2OnL>;
	Sun, 29 Oct 2000 09:43:11 -0500
Date: Sun, 29 Oct 2000 09:43:08 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: killing read_ahead[]
In-Reply-To: <Pine.LNX.4.10.10010261332390.2575-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0010290932060.27484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Oct 2000, Linus Torvalds wrote:

> The alternative is to have an entirely different approach, where the page
> cache itself only knows about the maximum page (in which case your current
> "last_page" calculation is right on), and then anybody who needs to know
> about partial pages needs to get THAT information from the inode.
> 
> I'd almost prefer the alternative approach. Especially as right now the
> only real problem we're fighting is to make sure we never return an
> invalid page - the sub-page offset really doesn't matter for those things,
> and everybody who cares about the sub-page-information already obviously
> has it.

s/everybody/almost &/
There are only two places where we really care. And one of them can be
trivially shot.
	* O_APPEND handling. Well, duh - we can take the main loop
of generic_file_write() into a separate function (do_generic_file_write())
and be done with that - grab the semaphore, possibly adjust the ->f_pos,
pass the actor to do_generic_file_write(), be happy.
	* do_generic_file_read() should know how much to copy from the
last page. We could push that into the actor. Or we could mirror that
data in struct address_space.

	But yes, 99% of cases care only about the index of last page. So
I really don't think that size>>PAGE_CACHE_SHIFT makes sense from VM point
of view.

	OK, I have the "push to actor" variant and I'll send it once it
will get some testing. Changing it to "mirror both" is not a problem, anyway.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
