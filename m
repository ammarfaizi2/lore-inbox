Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279688AbRJ3ATb>; Mon, 29 Oct 2001 19:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279689AbRJ3ATV>; Mon, 29 Oct 2001 19:19:21 -0500
Received: from waste.org ([209.173.204.2]:31328 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S279688AbRJ3ATN>;
	Mon, 29 Oct 2001 19:19:13 -0500
Date: Mon, 29 Oct 2001 18:23:31 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
In-Reply-To: <20011029163920.F806@lynx.no>
Message-ID: <Pine.LNX.4.30.0110291814100.30096-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Andreas Dilger wrote:

> On Oct 29, 2001  10:58 -0600, Oliver Xymoron wrote:
> > > > (*) I don't know enough about the hash functions to know how to add a
> > > >     few odd bytes into the store in a useful and safe way.  We don't
> > > >     really want to discard them either - think if a user-space random
> > > >     daemon on an otherwise entropy-free system only writes one byte at
> > > >     a time...
> > >
> > > I'm no expert either, but padding with anything (zeroes?) to get the right
> > > length should be safe, no?
> >
> > No. A 4-byte accumulator is the right answer. We have to be careful here
> > though - the actual entropy might be in the partial words, we have to
> > account for it conservatively.
>
> In a large majority of the cases, there are only full-word entropy additions.
> The only time we need to deal with sub-word additions is from random_write()
> and from the equivalent ioctl.  It also appears that we do this when filling
> the secondary pool, but that is OK because we periodically dump far more
> entropy into the secondary pool than we could possibly lose through rounding
> errors.

They're not rounding errors per se though. This is what I mean by
conservative accounting. If you have three extra bytes, you must assume
that they're worth a full 24 bits of entropy. Throwing them away is fairly
expensive.

> Having an accumulator would only handle a rarely-used corner case.  We
> could just as easily fix any user-space entropy daemon to write at least
> 4 bytes at a time.  Alternately, we could "pad" with enough bytes from
> the random pool, and not accumulate at all.

Padding -from the pool- is acceptable (and simple enough a slow path to
add to the low-level function). Padding with constants is bad and padding
with zeros tends to be really bad.

> In any case, this is in the noise compared to not using the input data
> at all (which I fixed in the other patch).

Any of this made it into recent kernels yet? Backport to 2.2 might be a
good idea too..

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

