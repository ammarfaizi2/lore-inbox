Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVB1TW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVB1TW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVB1TWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:22:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:31372 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261728AbVB1TVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:21:10 -0500
Date: Mon, 28 Feb 2005 11:22:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: two pipe bugfixes
In-Reply-To: <20050228190437.GI8880@opteron.random>
Message-ID: <Pine.LNX.4.58.0502281113380.25732@ppc970.osdl.org>
References: <20050228042544.GA8742@opteron.random>
 <Pine.LNX.4.58.0502272143500.25732@ppc970.osdl.org> <20050228190437.GI8880@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Feb 2005, Andrea Arcangeli wrote:
> 
> > [..] And python-twisted is just plain bogus.
> 
> What do you mean with this, could you elaborate? You mean it shouldn't
> check for in/out set at the same time? I've no idea why it got confused
> by out/in set at the same time, but I guess it could be some
> compatibility thing with some other os.

I wonder. It migth just be a latent bug in python-twisted, rather than any 
"designed behaviour".

> Still my point is that such code should never trigger since pollin
> should never be set for an output-pipe-fd.

Equally arguably, POLLERR should _always_ be set if you select a
write-only pipe for reading, and guess what? That would cause "select()"
to return readable. It's true too: select returns whether a read() would
return immediately, and it _would_ - with an error code.

The basic fact is that an application that asks whether the pipe that it
opened for writing is readable is doing something stupid, and the old
behaviour was at most surprising, but I'd argue it isn't really
necessarily a _bug_.

Of course, "surprising" is bad, even if it's not necessarily a bug. So 
making the return value be "unsurprising" can in any case be considered an 
improvement.

> > I don't agree with your patch, though - I don't like your lack of
> > parenthesis ;)
> 
> ;)

I ended up editing it a bit more: the other bits (POLLHUP and POLLERR)  
also really only make sense for only one side of the reader/writer
schenario, so logically they should be grouped the same way.

Of course, in those cases, you can't get the "wrong" answer anyway, since
those only trigger if there are no readers or no writers (and if you're
open as a reader, that in itself obviously guarantees that there _are_
readers, and POLLERR cannot happen according to either the old or the new
rules).

Anyway, I think I made the code look more logical while there.

		Linus
