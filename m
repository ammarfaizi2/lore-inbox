Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRIQSIz>; Mon, 17 Sep 2001 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272008AbRIQSIp>; Mon, 17 Sep 2001 14:08:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50449 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271978AbRIQSIc>; Mon, 17 Sep 2001 14:08:32 -0400
Date: Mon, 17 Sep 2001 11:07:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33.0109171010280.8961-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109171101040.9092-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Linus Torvalds wrote:
>
> NOTE NOTE NOTE! This is _literally_ a 15-minute hack, and I expect that
> there are paths where I forget to remove the page from the LRU queue
> (which should result in a nice big oops in __free_pages_ok()).

Actually, the most common failure mode seems to be that we have plenty of
inactive pages (all the anonymous pages that we added to the LRU list and
thus to the statistics). And because we have tons of these pages, the VM
scanning is never even started, because do_try_to_free_pages() thinks
that it can just launder them.

Which means that we'll never get rid of them. Oops.

So it's easy adding anonymous pages to the LRU lists per se, but it
obviously needs some more work to make the scanners be aware of the fact
that they are there...

(I suspect that the easiest way to make them be aware of the anonymous
pages is to have a bogus address space associated with the anonymous
pages, with no actual hashing going on. And then make that address space
have a "writepage()" function that turns an anonymous pages into a swap
cache page. But I was hoping to get off more easily ;).

		Linus

