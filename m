Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130230AbRATVUO>; Sat, 20 Jan 2001 16:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRATVUE>; Sat, 20 Jan 2001 16:20:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:4961 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130230AbRATVTt>; Sat, 20 Jan 2001 16:19:49 -0500
Date: Sat, 20 Jan 2001 22:20:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Linus Torvalds <torvalds@transmeta.COM>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010120222021.D5274@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10101201138100.10317-100000@penguin.transmeta.com> <200101202022.XAA05556@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101202022.XAA05556@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Jan 20, 2001 at 11:22:14PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 11:22:14PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > > 	write(100000*MSS)
> > > 	write(1)
> > > 	write(1)
> ...
> > As far as I can tell, the second "write(1)" will always merge with the
> > first one
> 
> This would be true, if Andrea wrote not exactly 100000*MSS,
> but 100000*MSS+1 or just write(<lots of data>).

So then this:

	val = 1
	setsockopt(TCP_CORK, &val) /* cork */

	write(100000*MSS+1)
	write(1)	

	val = 0
	setsockopt(TCP_CORK, &val) /* uncork */

is different from this:

	val = 1
	setsockopt(TCP_CORK, &val) /* cork */

	write(100000*MSS+1)
	write(1)	

	val = 0
	setsockopt(TCP_CORK, &val) /* uncork */

	val = 1
	setsockopt(TCP_NODELAY, &val)
	val = 0
	setsockopt(TCP_NODELAY, &val)

This was all my wondering about uncorking not being equivalent to SIOCPUSH.
(the two setsockopt(TCP_NODELAY) can be replaced with a SIOCPUSH of course)

If I understood wall they would been equivalent if I did write(100000*MSS)
instead of write(100000*MSS+1).

(and btw, the TCP_NODELAY being cleared immediatly means that if the last
packet can't be sent during the setsockopt it will be delayed with nagle as
usual when we get the acknowledgments from the receiver, that's the same
mistake of my SIOCPUSH first implementation that infact should be sligtly
improved in the way descriped a few emails ago adding a tp->push field and
then it will become different than going for a moment in TCP_NODELAY mode)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
