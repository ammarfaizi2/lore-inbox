Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSKRDd7>; Sun, 17 Nov 2002 22:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSKRDd7>; Sun, 17 Nov 2002 22:33:59 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:40066
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261375AbSKRDd6>; Sun, 17 Nov 2002 22:33:58 -0500
Message-ID: <3DD86146.6050207@redhat.com>
Date: Sun, 17 Nov 2002 19:40:54 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain> <Pine.LNX.4.44.0211171452480.13106-100000@home.transmeta.com> <20021118014612.GA2483@bjl1.asuk.net>
In-Reply-To: <20021118014612.GA2483@bjl1.asuk.net>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> The race condition which Ulrich brought up, which requires
> CLONE_CHILD_SETTID to be used without CLONE_PARENT_SETTID, only occurs
> when using the same address to store the tid of the forked child as
> the parent's tid address.  In other words, it's a user space error.
> (Please correct me if I'm mistaken, Ulrich).

It's not an error.  It the very basic concept of always having a correct
thread descriptor.  A process created with fork() from an MT app is
different from one created with fork() from a single threaded app.  In
the latter case the thread descriptors are not used and can contain
garbage.  In the former case the descriptor better be correct all the
time.  It basically the same problem as with setting the TLS "register".
 clone() get the CLONE_TLS flag because the child and parent have
(potentially) different TLS address and it is not possible to set the
value before the fork() call (since the parent would have the wrong
value for some time) nor after the fork() (since then there would be a
window for a signal to arrive for an uninitialized thread).


> Finally, it would be kinder to everyone if CLONE_SETTID stored the
> child's tid in _both_ the parent and child address spaces, atomically
> w.r.t. debuggers.

Yes, but then clone still has to get two addresses.  In case of the
fork() implementation the parent's TID value must not be overwritten
while the child's TID value is at exactly the same virtual address as
the value in the parent.  I've no problem with requiring the value
always to be written (the pointer can be to a scratch object) but there
must be two pointer parameters for that.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92GFG2ijCOnn/RHQRAjQSAKCIRuhc1wgZy1PFS+waFapXRYqGjACgt6Bn
T2uKMpj7gHJedPzXxQ5EjoM=
=0C7c
-----END PGP SIGNATURE-----

