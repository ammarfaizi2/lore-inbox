Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268428AbTBZA12>; Tue, 25 Feb 2003 19:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbTBZA12>; Tue, 25 Feb 2003 19:27:28 -0500
Received: from ool-182f525d.dyn.optonline.net ([24.47.82.93]:25829 "EHLO
	j0nah.ath.cx") by vger.kernel.org with ESMTP id <S268428AbTBZA11>;
	Tue, 25 Feb 2003 19:27:27 -0500
Date: Tue, 25 Feb 2003 14:38:17 -0500
From: Jonah Sherman <jsherman@stuy.edu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.5.63 - NULL pointer dereference in loop device
Message-ID: <20030225193817.GA2157@j0nah.ath.cx>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030224212530.GA631@j0nah.ath.cx> <Pine.LNX.4.44.0302252059370.1430-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302252059370.1430-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2003 at 09:15:56PM +0000, Hugh Dickins wrote:
> If you "losetup /dev/loop0 /dev/hdN", then it's LO_FLAGS_BH_REMAP
> and doesn't even call bio_copy: it doesn't copy bio or buffers or

It appears this way if you just look at none_status, but you didn't look
at loop_init_xfer().  Notice that it doesn't call xfer->init unless
type !=3D 0, so that flag is infact never set.

> pages (unless you have highmem, which you don't mention: then its
> pointless wasteful blk_queue_bounce might cause trouble), it's a
> straight route through to disk, which should be using mempools
> to complete i/o even if the rest of the system is out of memory.

I'm not using highmem.

> Of course the loop driver is wrong to ignore NULL return from bio_copy
> (if you used losetup -e), and there's a lot of unnecessary allocation
> and copying and a lot of opportunity for deadlock, for which I have
> some perpetually unfinished patches.
>=20
> But the loop to disk is relatively straightforward, pdflush should
> take care of the dirty pages Andrew worries about (though in writing
> to blockdev when there's highmem, pdflush may kick in too late); and
> I couldn't even reproduce your oops using "-e xor".
>=20
> Can you shed more light on how to reproduce this?

The block dev it is being used on must be larger than your RAM.  I don't
have any swap on this machine, so I don't know if it must be bigger than
that too.  Maybe disabling swap before testing this oops will make it
work?

In any case, the patch sent by Andrew Morton fixed this bug.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+W8YpflGtzWCyItURAkKDAJ9bVKCQ8MLq29tnAX4GZ+v9zW/kuwCgwG8m
sh5zJ37lbSz1aQvFokGhVEE=
=SyYx
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
