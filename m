Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVAGVDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVAGVDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVAGVC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:02:28 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:40410 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261557AbVAGU71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:59:27 -0500
Date: Fri, 07 Jan 2005 15:59:07 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Make pipe data structure be a circular list of pages, rather than
In-reply-to: <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <41DEF81B.60905@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41DE9D10.B33ED5E4@tv-sign.ru>
 <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
 <1105113998.24187.361.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Fri, 7 Jan 2005, Linus Torvalds wrote:
> 
>>So the "standard behaviour" (aka just plain read/write on the pipe) is all
>>the same copies that it used to be.
> 
> 
> I want to highlight this again. The increase in throughput did _not_ come
> from avoiding a copy. It came purely from the fact that we have multiple
> buffers, and thus a throughput-intensive load gets to do several bigger
> chunks before it needs to wait for the recipient. So the increase in
> throughput comes from fewer synchronization points (scheduling and
> locking), not from anything else.
> 
> Another way of saying the same thing: pipes actually used to have clearly
> _lower_ bandwidth than UNIX domain sockets, even though clearly pipes are
> simpler and should thus be able to be faster. The reason? UNIX domain
> sockets allow multiple packets in flight, and pipes only used to have a
> single buffer. With the new setup, pipes get roughly comparable
> performance to UNIX domain sockets for me.
> 
> Sockets can still outperform pipes, truth be told - there's been more
> work on socket locking than on pipe locking. For example, the new pipe
> code should conceptually really allow one CPU to empty one pipe buffer
> while another CPU fills another pipe buffer, but because I kept the
> locking structure the same as it used to be, right now read/write
> serialize over the whole pipe rather than anything else.
> 
> This is the main reason why I want to avoid coalescing if possible: if you
> never coalesce, then each "pipe_buffer" is complete in itself, and that
> simplifies locking enormously.

This got me to thinking about how you can heuristically optimize away
coalescing support and still allow PAGE_SIZE bytes minimum in the
effective buffer.


Method 1)

Simply keep track of how much data is in the effective buffer.  If the
count is < PAGE_SIZE, then coalesce, otherwise, don't.  Very simple, but
means a high traffic pipe might see 'stuttering' between coalescing mode
and fastpath.

Method 2)

It would be interesting to see the performance of a simple heuristic
whereby writes smaller than a given threshold (PAGE_SIZE >> 3?) are
coalesced with the previous iff the previous also was less than the
threshold and there is room for the write in the given page.

With this heuristic, the minimum size of the effective buffer is only
possible if the sequence consists of alternating threshold (T) bytes and
1 byte writes.

If 'number of pages in circular buffer' (C) is even, this produces a
minimum of (T*C + C)/2 bytes in the effective buffer.  We can figure out
a minimum T value for a given page count C by isolating T from:

(T*C + C)/2 = PAGE_SIZE

which is:

T = (2 * PAGE_SIZE / C) - 1

So with the assumption that we only coalesce if

- - the previous write count was < T
- - the current write count is < T
- - there is room for the current write count in the current page

and if we set C = 16, we can safely let T = (PAGE_SIZE >> 3) - 1 and the
minimum effective buffer is guaranteed to be at least PAGE_SIZE bytes.

This should reduce the amount of coalescing work required and thus
reduce the amount of locking required for the case where performance
counts (on x86, the writer would have to write 511 bytes to use the
non-coalescing fast path).

This method is probably better as many writers will be buffering their
writes, and the size also nicely fits with block layer's blocksize.

Just my two cents.

> 
> (The other reason to potentially avoid coalescing is that I think it might
> be useful to allow the "sendmsg()/recvmsg()" interfaces that honour packet
> boundaries. The new pipe code _is_ internally "packetized" after all).
> 
> 				Linus

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3vgbdQs4kOxk3/MRAhN1AKCD6/o04URPYphGRh13P5GLNfV4JgCaA3wx
QpMbLHqBtmAB3sy7mmxXCEI=
=687H
-----END PGP SIGNATURE-----
