Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVB1TIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVB1TIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVB1TG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:06:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38455
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261712AbVB1TEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:04:39 -0500
Date: Mon, 28 Feb 2005 20:04:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: two pipe bugfixes
Message-ID: <20050228190437.GI8880@opteron.random>
References: <20050228042544.GA8742@opteron.random> <Pine.LNX.4.58.0502272143500.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502272143500.25732@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IMHO the really wrong thing is that we always set POLLIN (even for
> > output filedescriptors that will never allow any data to be read).
> 
On Mon, Feb 28, 2005 at 08:25:07AM -0800, Linus Torvalds wrote:
> However, that has always been true. Look at the old code: it would set
> POLLIN for a non-empty pipe for both readers and writers (and do POLLOUT
> for empty pipes both for readers and writers). In fact, your very own
> original strace shows that - it shows "in [4]" even though fd 4 is a
> write-only fd.

Sure, that has always been true, I also wanted to say it wasn't a
mistake of the new code, but just a mistake of the old code that has
seen the light thanks to the recent optimizations.

> The new code does nothing really different. POLLIN is still there for a
> non-empty pipe, just like it was before. It's just that when you have
> multiple buffers, POLLOUT can _also_ be true, since even if you have
> _some_ data in the pipe, you can still do a write of a full PIPE_BUF.
> 
> So the difference is not at all the one you're talking about, and the 
> "bug" you claim to fix was there before too.
> 
> The fact is that if this broke python-twisted, then it just happened to
> work before by mistake. [..]

Yes of course.

> [..] And python-twisted is just plain bogus.

What do you mean with this, could you elaborate? You mean it shouldn't
check for in/out set at the same time? I've no idea why it got confused
by out/in set at the same time, but I guess it could be some
compatibility thing with some other os.

Still my point is that such code should never trigger since pollin
should never be set for an output-pipe-fd.

> That said, I agree with the fact that it's probably not the right thing to
> do, and never was. And if fixing it makes a difference to python-twisted,
> then hey, that's a benefit, but not a reason for the patch.

Sure, I had no idea myself if it was going to work with python-twisted,
because I changed the behaviour compared to the 2.6.9 codebase, but I
tested it and it worked fine as well as the "old 2.6.9" behaviour.

I didn't write the patch to make python-twisted work but only to do
something that would remotely resemble the sus specs and it happened to
fix twisted as well in my testing.

> I don't agree with your patch, though - I don't like your lack of
> parenthesis ;)

;)
