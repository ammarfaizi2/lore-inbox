Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVKWL4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKWL4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVKWL43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:56:29 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:8674 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750703AbVKWL42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:56:28 -0500
Date: Wed, 23 Nov 2005 09:56:33 -0200
From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, akpm@osdl.org
Subject: Re: [PATCH 2/2] - usbserial: race-condition fix.
Message-ID: <20051123115633.GS14440@duckman.conectiva>
References: <20051122195926.18c3221c.lcapitulino@mandriva.com.br> <20051122221353.GA10311@suse.de> <20051123093655.5555f23e.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n7zTieg8iIQ1Wja9"
Content-Disposition: inline
In-Reply-To: <20051123093655.5555f23e.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n7zTieg8iIQ1Wja9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2005 at 09:36:55AM -0200, Luiz Fernando Capitulino wrote:
> On Tue, 22 Nov 2005 14:13:53 -0800
> Greg KH <gregkh@suse.de> wrote:
>=20
> | On Tue, Nov 22, 2005 at 07:59:26PM -0200, Luiz Fernando Capitulino wrot=
e:
> | > @@ -60,6 +61,7 @@ struct usb_serial_port {
> | >  	struct usb_serial *	serial;
> | >  	struct tty_struct *	tty;
> | >  	spinlock_t		lock;
> | > +	struct semaphore        sem;
> |=20
> | You forgot to document what this semaphore is used for.
>=20
>  Okay.
>=20
> | Hm, can we just use the spinlock already present in the port structure
> | for this?  Well, drop the spinlock and use the semaphore?  Yeah, that
> | means grabbing a semaphore for ever write for some devices, but USB data
> | rates are slow enough it wouldn't matter :)
>=20
>  As far as I read the code, I found that spinlock is only used by the
> generic driver, in the
> drivers/usb/serial/generic.c:usb_serial_generic_write() function.
>=20
>  Can we drop the spinlock there and use our new semaphore? Or should we
> create a new spinlock just to use there?

The spin_lock is used only to protect write_urb_busy. An atomic_t seem
to be more appropriate for it. If we do that, I guess we can remove the
(then unused) spinlock.

So we have three proposed changes:

- Add semaphore to serialize close()/open() (properly documented)
- Replace write_urb_busy with an atomic_t
- Remove the spinlock

>=20
>  I ask it because the semaphore will be used to serialize open()/close()
> operations in the usb-serial driver, is a bit weird to use the same
> semaphore in a write() function of other driver.

I agree.

--=20
Eduardo

--n7zTieg8iIQ1Wja9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDhFjxcaRJ66w1lWgRAv5qAKCDfmBmYby5u7o/jWjGQJoOA0F+XQCfZXvW
86obQtoj2sZvMtmYOI8YKv0=
=Q9fM
-----END PGP SIGNATURE-----

--n7zTieg8iIQ1Wja9--
