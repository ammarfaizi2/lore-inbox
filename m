Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288782AbSAVQvK>; Tue, 22 Jan 2002 11:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSAVQu7>; Tue, 22 Jan 2002 11:50:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29713 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288782AbSAVQus>; Tue, 22 Jan 2002 11:50:48 -0500
Date: Tue, 22 Jan 2002 08:49:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Andre Hedrick <andre@linuxdiskcert.org>, Jens Axboe <axboe@suse.de>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020122082030.A12720@suse.cz>
Message-ID: <Pine.LNX.4.33.0201220844120.1799-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Jan 2002, Vojtech Pavlik wrote:
>
> That's pretty much nonsense, beg my pardon. The real correct way would
> be:
>
> issue read of 255 sectors using READ_MULTI, max_mult = 16
> receive interrupt
> 	inw() first 4k to buffer A
> 	inw() second 4k to buffer B
> don't do anything else until the next interrupt

Definitely.

There is no way the controller can even _know_ the difference between

 - one large 8kB "rep insw" instruction
 - two (or more) smaller chunks of "rep insw" adding up to 8kB worth of
   "inw"

as long as there are no other IO instructions to that controller in
between. The two look _exactly_ the same on the bus - there aren't even
any bursting issues (you can only burst on MMIO, not PIO accesses).

Sure, there are some timing issues, but (a) data cache misses are much
bigger things than just a few instructions, and (b) we allow interrupts
from other devices anyway, so the timing _really_ isn't even an issue.

So just call "ata_input_data()" several times in a loop for discontinuous
buffers. I told Andre this before.

			Linus

