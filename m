Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbQLGNyv>; Thu, 7 Dec 2000 08:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbQLGNyl>; Thu, 7 Dec 2000 08:54:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17859 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129780AbQLGNy1>;
	Thu, 7 Dec 2000 08:54:27 -0500
Date: Thu, 7 Dec 2000 08:23:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.LNX.4.21.0012071007420.970-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0012070709400.20144-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2000, Tigran Aivazian wrote:

> The rationale for being compatible with 4.4BSD on append-only but not on
> immutable is -- for immutable we can do the test by means of permission()
> fast but for append-only we would need an extra if() above permission so
> let's just be BSD-compatible.  Alternatively, one could ignore BSD
> altogether and return EACCES in both. Or, one could ignore SuS altogether
> and return EPERM for both immutable and append-only. It is a matter of
> taste so... I chose something in the middle , perhaps non-intuitive but
> optimized for speed and the size of code.

Big, loud "yuck". The first rule of optimization: don't. I agree that
in the current code test for immutable is dead. However, the rationale
above is a BS. The path is nowhere near time-critical ones. Moreover,
it doesn't make the code simpler.

History: 4.4BSD treats immutable and append-only the same way it treats
removal from sticky-bit directories, etc. I.e. consistenly returns
-EPERM. Yes, on access(), open() for write, directory operations, yodda,
yodda.

So correct solution may very well be to change the return value of
permission(9). FWIW, MAY_TRUNCATE might be a good idea - notice that
knfsd already has something like that. It makes sense for directories,
BTW - having may_delete() drop the IS_APPEND() test and pass MAY_TRUNCATE
to permission() instead.

<looking at the truncate(2) manpage>
Oh, lovely - where the hell had the following come from?
% man truncate
...
       EINVAL The  pathname  contains  a character with the high-
              order bit set.
...
Andries, would you mind removing that, erm, statement? I'm curious about
its genesis - AFAIK we had 8bit-clean namei for ages (quite possibly since
0.01).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
