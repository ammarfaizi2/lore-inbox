Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312321AbSCYGVl>; Mon, 25 Mar 2002 01:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312320AbSCYGVb>; Mon, 25 Mar 2002 01:21:31 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:34691 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312314AbSCYGVU>; Mon, 25 Mar 2002 01:21:20 -0500
Date: Sun, 24 Mar 2002 23:21:16 -0700
Message-Id: <200203250621.g2P6LG023329@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: bit ops on unsigned long? 
In-Reply-To: <E16pM5N-0000zb-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
> In message <200203250245.g2P2jQa20821@vindaloo.ras.ucalgary.ca> you write:
> > Rusty Russell writes:
> > > Richard: 3 bugs in devfs.  Particularly note that the memset was
> > > bogus.  I can't convince myself that your memcpy & memset stuff is
> > > right anyway, given that you can ONLY treat them as unsigned longs
> > > (ie. bit 31 will be in byte 0 or byte 3, depending on endianness).
> > 
> > Yes, the memset is bogus because I didn't cast the pointer to a
> > char * or void *.
> 
> Yes.
> 
> > The memcpy should be fine, though. And so should
> > everything else, because the bitfield array is allocated in 16 byte
> > multiples.
> 
> No:
[...]
> These changed are required because otherwise you try to do set_bit on
> something not aligned as a long on all archs.

But of course. I'm not denying that. Naturally the type should be
changed. I thought that was obvious so I didn't bother agreeing. But
in fact, it already *is* aligned on a long boundary. Better, in
fact. It's aligned on a 16 byte boundary. Even though the type was
__u32.

> (Turning to the gallery) I assert: if you're going to do bitops on it,
> make it a "unsigned long".

Agreed.

> > So there should be no issues with big vs. little endian,
> > since memset/memcpy operations are done in blocks of sufficient
> > alignment.
> 
> I think you're right, as long as length is always a multiple of
> sizeof(long).  This is not obvious from this hunk of code alone, which
> is why I queried it...
> 
>     if (space->num_free < 1)
>     {
> 	if (space->length < 16) length = 16;
> 	else length = space->length << 1;

Assuming sizeof (long) <= 16 bytes, then length will always be a
multiple of sizeof (long). So, even for a 128 bit CPU, this code is
fine. It might break down on a 256 bit CPU...

Anyway, it looks like we're in agreement.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
