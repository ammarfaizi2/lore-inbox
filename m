Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRKHREX>; Thu, 8 Nov 2001 12:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKHRED>; Thu, 8 Nov 2001 12:04:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275843AbRKHRDz>; Thu, 8 Nov 2001 12:03:55 -0500
Date: Thu, 8 Nov 2001 09:00:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
 (fwd)
In-Reply-To: <Pine.LNX.4.21.0111081319280.1689-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0111080855120.1511-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Marcelo Tosatti wrote:
>
> I remember Linus had a reasoning for the "scan _ALL_ ptes until success"
> behaviour.
>
> Linus, was that due to zone-specific (eg DMA shortage on bigmem machine)
> shortages or ?

No, the major reason simply _is_ because it's fairly easy to come up with
test-cases that are mostly MAP_SHARED, and are not out-of-memory.
Returning early from swap_out() is simply fundamentally wrong - whether we
have free swap-space or not has very little to do with anything.

(Well, whether we have free swap space or not _is_ meaningful once we have
scanned all VM's, but not before that).

But see my suggestion about potentially noticing the oom _before_ calling
swap_out(). Thanks to anonymous-in-LRU we have a _lot_ of powerful
information that we simply traditionally haven't had. It doesn't just tell
us when we should start swapping out, it can also tell us if swap-out is
going to need swap-space or not. It can even tell how _much_ swap-space
we'll need to satisfy the "free N pages from the VM".

> However, the current code breaks badly as I've tested on the 16GB boxen.

I understand. I just think the fix needs to be different.

		Linus

