Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTFDTd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTFDTd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:33:26 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:41457 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263980AbTFDTdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:33:24 -0400
Date: Wed, 4 Jun 2003 20:46:51 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <Pine.LNX.4.44.0306041050250.14593-100000@home.transmeta.com>
Message-ID: <Pine.HPX.4.33L.0306041937290.18475-100000@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Linus Torvalds wrote:
>
> A much better fix might well be to actually not allow over-long tty writes
> at all, and thus avoid the "block out" thing at the source of the problem,
> instead of trying to make programs who play nice be the ones that suffer.
>
> If somebody does a 1MB write to a tty, do we actually have any reason to
> try to make it so damn atomic and not return early?

The problem isn't to do with large writes. It's to do with any sequence of
writes that fills up the receive buffer, which is only 4K for N_TTY. If
the receiving program is suspended, the buffer will fill sooner or later.

I am half-tempted by this style of fix, but I can't help but feel that
we'll discover a huge set of programs that assume short writes never
happen if they aren't playing with signals.

It's also not as easy a fix as it sounds: for blocking writes, we've gone
into into ldisc.write and then in tty->driver->write before we discover
that that we can't write any bytes, by which time we already have the
write semaphore. I suspect that it requires just as much effort to ensure
that this case is handled correctly as it does to stop the non-blocking
write/poll loop.

I compared 2.4.20 and 2.5.70 to see if I could find the patch Hua
referred to. n_tty.c and pty.c look almost the same - I don't think the
patch is in 2.4.20.

Peter


