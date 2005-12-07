Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbVLGTHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbVLGTHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbVLGTHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:07:00 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:12698 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751420AbVLGTG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:06:59 -0500
Date: Wed, 7 Dec 2005 17:10:58 -0200
From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
To: Greg KH <gregkh@suse.de>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051207191058.GK20451@duckman.conectiva>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br> <20051207164118.GA28032@suse.de> <20051207145113.4cbdc264.lcapitulino@mandriva.com.br> <20051207171332.GI20451@duckman.conectiva> <20051207175614.GA29117@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/rDaUNvWv5XYRSKj"
Content-Disposition: inline
In-Reply-To: <20051207175614.GA29117@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/rDaUNvWv5XYRSKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi, Greg,

On Wed, Dec 07, 2005 at 09:56:14AM -0800, Greg KH wrote:
> On Wed, Dec 07, 2005 at 03:13:32PM -0200, Eduardo Pereira Habkost wrote:
> > I have a small question: in my view, this patch series is a small
> > step towards implementing the usb-serial drivers The Right Way, as it
> > removes a a bit of duplicated code.
>=20
> It doesn't remove any "duplicated code", it only changes a spinlock to
> an atomic_t for one single value (which I personally do not think is the
> best thing to do, and based on the number of comments on this thread, I
> think others also feel this way.)

Every usb-serial driver currently has:

spin_lock(port->lock);
if (port->write_urb_busy)
	return;
port->write_urb_busy =3D 1;
spin_unlock(port->lock);


Having the same 5 lines on many usb-serial drivers looks like duplicated
code to me. Maybe I am being too exigent. Anyway, this is unrelated to
the atomic_t change, and we could do it without dropping ths spinlock.

But I would like to know: would you would accept such change (that
encapsulate this write_urb_busy logic without necessarily dropping the
spinlock)?


And, about the atomic_t: I've felt most people didn't liked the atomic_t
approach for one of two reasons:

1. The existence of write_urb_busy looks like a hack, and we've
   make it explicit when we isolated the code that uses write_urb_busy
   in a set of functions (the point of Arjan in his "square wheel"
   comment)
2. The whole discussion about atomic_t vs. spinlock efficiency


I agree with (1), but I still don't see why using a spinlock to protect
a single field is better than using atomic_t. Both in code readability
and efficiency. Specially as the difference between each one (even which
one is more efficient) is very arch-specific.


Thank you very much for your advice,

--=20
Eduardo

--/rDaUNvWv5XYRSKj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlzPCcaRJ66w1lWgRAjo3AJ4gPpLXztFw85TxV6MQdpEUwhI4ugCfXmkl
li1+em/7+NHIrIfNgxnljXc=
=sqq0
-----END PGP SIGNATURE-----

--/rDaUNvWv5XYRSKj--
