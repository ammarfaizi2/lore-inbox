Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTITPro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 11:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTITPro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 11:47:44 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:14065 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261906AbTITPrm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 11:47:42 -0400
Subject: Re: __make_request() bug and a fix variant
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Zabolotny <zap@homelink.ru>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030920193626.31d2b8f5.zap@homelink.ru>
References: <20030919231732.7f7874e6.zap@homelink.ru>
	 <20030920113737.GQ21870@suse.de>  <20030920193626.31d2b8f5.zap@homelink.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yB+QuqSXpEk4FCRKQVe6"
Organization: Red Hat, Inc.
Message-Id: <1064072854.5071.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sat, 20 Sep 2003 17:47:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yB+QuqSXpEk4FCRKQVe6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-09-20 at 17:36, Andrew Zabolotny wrote:
> On Sat, 20 Sep 2003 13:37:37 +0200
> Jens Axboe <axboe@suse.de> wrote:
>=20
> > I dunno if you were the one posting this issue here some months ago?
> No, it wasn't me :-)
>=20
> > Show me a regular kernel path that passes invalid b_reqnext to
> > __make_request? That would be a bug, indeed, but I've never heard of
> > such a bug. Most likely it's a bug in your driver, not initialising
> > b_reqnext.
> I have been calling bread() which was causing me troubles. bread does
> not accept a buffer_head from outside, it gets a new one and returns it.
> So I don't have any control over b_reqnext field - the bug happens
> inside bread() between these lines:
>=20
> bh =3D getblk(dev, block, size);
> /* here bh_reqnext is already junk. In fact, I partially solved this
>    problem by making my own clone of bread() and setting b_reqnext
>    to NULL right here. But unfortunately, there is no guarantee we'll
>    fix all invalid buffer_heads - maybe some remain in the pool and
>    will be returned to other innocent drivers requesting them. */
> if (buffer_uptodate(bh))
> 	return bh;
> /* and now ll_rw_block will try to merge the bh with those already in
>    the queue, and if it will take the ELEVATOR_NO_MERGE path, bh_reqnext
>    will still remain junk. */
> ll_rw_block(READ, 1, &bh);
>=20
> > You can see the initialisor for buffer_heads is
> > init_buffer_head, which memsets the entire buffer_head. When a
> > buffer_head is detached from the request list, b_reqnext is cleared
> > too.
> Ah, so I was correct that __make_request expects b_reqnext to be already
> set to NULL. In this case the bug should be somewhere else - in some
> code that returns buffer_head's back to the pool of buffers.
>=20
> Interesting that right before the driver crashes in bread() I call
> grok_partitions. I think the bug is somewhere there. I will do a new
> debug session at Monday (the code that breaks is at work), so I will
> post new details if I find any.

it may help if you post the url to your full driver code here; others
may help you debugging....

--=-yB+QuqSXpEk4FCRKQVe6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/bHaVxULwo51rQBIRAmToAKCZutaGcULB/WREYXkEM9EMNnynxACeL5om
0xVm0XSu9t1/7QiDdcAeMO8=
=iEtA
-----END PGP SIGNATURE-----

--=-yB+QuqSXpEk4FCRKQVe6--
