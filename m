Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280275AbRJaPyu>; Wed, 31 Oct 2001 10:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280247AbRJaPy3>; Wed, 31 Oct 2001 10:54:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280245AbRJaPy0>; Wed, 31 Oct 2001 10:54:26 -0500
Date: Wed, 31 Oct 2001 07:52:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
In-Reply-To: <Pine.LNX.4.33L.0110311259570.2963-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0110310744070.32330-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Rik van Riel wrote:
>
> Linus, it seems Lorenzo's test program gets killed due
> to the new out_of_memory() heuristic ...

Hmm.. The oom killer really only gets invoced if we're really down to zero
swapspace (that's the _only_ non-rate-based heuristic in the whole thing).

Lorenzo, can you do a "vmstat 1" and show the output of it during the
interesting part of the test (ie around the kill).

I could probably argue that the machine really _is_ out of memory at this
point: no swap, and it obviously has to work very hard to free any pages.
Read the "out_of_memory()" code (which is _really_ simple), with the
realization that it only gets called when "try_to_free_pages()" fails and
I think you'll agree.

That said, it may be "try_to_free_pages()" itself that just gives up way
too easily - it simply didn't matter before, because all callers just
looped around and asked for more memory if it failed. So the code could
still trigger too easily not because the oom() logic itself is all that
bad, but simply because it makes the assumption that try_to_free_pages()
only fails in bad situations.

		Linus

