Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbSKRWTF>; Mon, 18 Nov 2002 17:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSKRWRg>; Mon, 18 Nov 2002 17:17:36 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:3459 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265085AbSKRWPJ>;
	Mon, 18 Nov 2002 17:15:09 -0500
Date: Mon, 18 Nov 2002 22:22:02 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
Message-ID: <20021118222202.GA3939@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain> <Pine.LNX.4.44.0211171452480.13106-100000@home.transmeta.com> <20021118014612.GA2483@bjl1.asuk.net> <3DD86146.6050207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD86146.6050207@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> [...] It the very basic concept of always having a correct
> thread descriptor.  A process created with fork() from an MT app is
> different from one created with fork() from a single threaded app.  In
> the latter case the thread descriptors are not used and can contain
> garbage.  In the former case the descriptor better be correct all the
> time.  It basically the same problem as with setting the TLS "register".
>  clone() get the CLONE_TLS flag because the child and parent have
> (potentially) different TLS address and it is not possible to set the
> value before the fork() call (since the parent would have the wrong
> value for some time) nor after the fork() (since then there would be a
> window for a signal to arrive for an uninitialized thread).

Ok, I understand now.

    1. You need the child to have a valid thread descriptor immediately after
       fork(), and the parent's thread descriptor to be the same
       before and after fork().

    2. At all times, get_current_thread()->tid must return the current
       thread's tid in both the parent and child.

That is fine.  Just allocate a new TLS for the child, use
CLONE_SETTID|CLONE_CLEARTID|CLONE_SETTLS in your threaded fork(), and
pass the child's tid address (in the child's tls area).

It does require allocating a new TLS area on fork().  Is that a
problem?

cheers,
-- Jamie
