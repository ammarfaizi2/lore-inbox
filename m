Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUBCKBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUBCKBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:01:09 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:9135 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S265948AbUBCKBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:01:05 -0500
Date: Tue, 3 Feb 2004 11:49:40 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Emmanuel Guiton <emmanuel@netlab.hut.fi>
Cc: Duncan Sands <baldrick@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeing skbuff (was: Re: Sending built-by-hand packet and kernel panic.)
Message-ID: <20040203094938.GE5212@actcom.co.il>
References: <401E62C3.60503@netlab.hut.fi> <200402021602.56242.baldrick@free.fr> <401E8E33.7050305@netlab.hut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <401E8E33.7050305@netlab.hut.fi>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2004 at 07:51:47PM +0200, Emmanuel Guiton wrote:

> However, my overall problem is not solved. As far as my investigations=20
> led me, my sk_buff structure is never released after having been sent on=
=20
> the wire. So I guess I need an explicit destructor function in my=20
> sk_buff as the following is present in the definition of struct sk_buff:
> void         (*destructor)(struct sk_buff *);    /* Destruct function  */

Note that depending on what you're doing, you might not be able to use
the destructor, because the upper layers use it without regards to
whether it was set before. To the best of my understanding, the rules
for the destructor say that it is free for the use of whatever layer
owns the skbuff at the moment. There are three ways around it - the
first and obvious is to avoid relying on the destructor. The second is
that you can use skb_clone() to get your own copy of the headers and
the destructor (but that doesn't really help you because how does the
layer that ends up freeing the skb know to use your version of the
headers?) and the third is to use this patch,
http://www.mulix.org/patches/skb-destructor-chaining-A2-2.6.1, to=20
allow more than destructor per skb.=20

Hope this helps,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAH26xKRs727/VN8sRAscEAJ0Zp57+vlPXUL5Rc0ec4tfyGtIr3QCfb0Qt
6/JiXTdir/W3vHlFO16FKCU=
=yDOd
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
