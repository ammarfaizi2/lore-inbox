Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVB1QYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVB1QYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVB1QYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:24:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:2507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbVB1QX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:23:59 -0500
Date: Mon, 28 Feb 2005 08:25:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: two pipe bugfixes
In-Reply-To: <20050228042544.GA8742@opteron.random>
Message-ID: <Pine.LNX.4.58.0502272143500.25732@ppc970.osdl.org>
References: <20050228042544.GA8742@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Feb 2005, Andrea Arcangeli wrote:
> 
> and it started to return this since 2.6.11-rc:
> 
> pipe([3, 4])                            = 0
> write(4, "qqqqq", 5)                    = 5
> select(5, [4], [4], [4], {0, 0})        = 2 (in [4], out [4], left {0,
> 0})
> close(3)                                = 0
> write(4, "qqqqq", 5)                    = 5

Ahh, yes. The write merging code doesn't check for no readers. 

> IMHO the really wrong thing is that we always set POLLIN (even for
> output filedescriptors that will never allow any data to be read).

However, that has always been true. Look at the old code: it would set
POLLIN for a non-empty pipe for both readers and writers (and do POLLOUT
for empty pipes both for readers and writers). In fact, your very own
original strace shows that - it shows "in [4]" even though fd 4 is a
write-only fd.

The new code does nothing really different. POLLIN is still there for a
non-empty pipe, just like it was before. It's just that when you have
multiple buffers, POLLOUT can _also_ be true, since even if you have
_some_ data in the pipe, you can still do a write of a full PIPE_BUF.

So the difference is not at all the one you're talking about, and the 
"bug" you claim to fix was there before too.

The fact is that if this broke python-twisted, then it just happened to
work before by mistake. And python-twisted is just plain bogus.

That said, I agree with the fact that it's probably not the right thing to
do, and never was. And if fixing it makes a difference to python-twisted,
then hey, that's a benefit, but not a reason for the patch.

I don't agree with your patch, though - I don't like your lack of
parenthesis ;)

			Linus
