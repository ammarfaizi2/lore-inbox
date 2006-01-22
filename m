Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWAVPDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWAVPDh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 10:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWAVPDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 10:03:37 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:17591 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932142AbWAVPDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 10:03:37 -0500
Date: Sun, 22 Jan 2006 17:03:20 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [TEST PATCH 3/3] lib bitmap region restructure
Message-ID: <20060122150320.GA19211@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Paul Jackson <pj@sgi.com>, akpm@osdl.org,
	James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
References: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com> <20060120020808.19584.3859.sendpatchset@jackhammer.engr.sgi.com> <20060120081305.GB3918@linux-sh.org> <20060120015643.11e8707c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20060120015643.11e8707c.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2006 at 01:56:43AM -0800, Paul Jackson wrote:
> Ah - I guess my problem is that I believed James code comment:
>=20
>  * This is used to allocate a memory region from a bitmap.  The idea is
>  * that the region has to be 1<<order sized and 1<<order aligned (this
>  * makes the search algorithm much faster).
>=20
> I thought this meant that it was a design requirement (the "idea")
> to have the alignment always be (1 << order).  Apparently it was
> just a useful performance tweak, for the sub-word sizes.
>=20
> Apparently for the multiword case you are adding, you recommend going
> for tighter packing of the allocated regions, rather than extending
> the alignment constraint past a single word.
>=20
=46rom a performance point of view going the (1 << order) route for
alignment and searching is much faster. I'm not too tightly bound to the
notion of tightly packing the allocated regions, that was just the
behaviour my implementation was following originally.

Speeding up the searches should take priority for this, though I expect
there's going to be very few corner cases where the search time is of
real relevance (primarily given the fact that it can only handle the <=3D
BITS_PER_LONG case now).

To give you an example of my use case, I have a 64MB chunk of address
space at a fixed virtual range in the SH-4 processors, which can be
accessed by both the kernel and userspace (unfortunately the address
range is in the mapped peripheral space, which exceeds TASK_SIZE, so
relying even on a custom ->get_unmapped_area() to prep the VMA location
and ->mmap() to setup the mappings simply isn't going to work).

Based off of this, I've got a bitmap for covering this space that both
the kernel and userspace interfaces hook in to to carve up the address
space amongst themselves, and it's not uncommon to map large memory
apertures (32M or so) through this space all at once, particularly in the
case where VRAM is remapped to parallelize with DMA for faster
throughput.

> The performance of bitmap_find_free_region() becomes essentially
> O(N**2) rather than O(Log2 N).  The search loop would scan forward
> with REG_OP_ISFREE from each word in succession, until it found
> the requested sequence of free words, rather than scanning just
> from the words on (1 << order) bits alignment.  Since it looks in
> more places, the worst case times are longer.
>=20
Yes, I think given this your patch 3/3 should be mostly fine as is. I've
gotten around to testing it in practice now and everything seems to hold
up. I'll clean up the comments a bit and submit the patch set to Andrew,
who I'm sure is rather tired of hearing about this by now :-)

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD05641K+teJFxZ9wRAkavAJ4054wmzRehbf32sJm9SWdq+Ai0XQCfZzcZ
vDYme9WAgIqbA4/jGmTCRnI=
=dlj6
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
