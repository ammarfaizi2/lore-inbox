Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVBOSBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVBOSBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVBOSBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:01:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26258 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261732AbVBOSAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:00:49 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [RFC UPDATE PATCH] add wait_event_*_lock() functions and comments
Date: Tue, 15 Feb 2005 18:50:45 +0100
User-Agent: KMail/1.6.2
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Sergey Vlasov <vsu@altlinux.ru>,
       Al Borchers <alborchers@steinerpoint.com>, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
References: <1108105628.420c599cf3558@my.visi.com> <29495f1d05021221003ef31c3e@mail.gmail.com> <20050215010435.GD2403@us.ibm.com>
In-Reply-To: <20050215010435.GD2403@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200502151850.46217.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_2ZjECu8LxrHVQdU";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_2ZjECu8LxrHVQdU
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dinsdag 15 Februar 2005 02:04, Nishanth Aravamudan wrote:
> Here's at least one example:
>=20
> drivers/ieee1394/video1394.c:__video1394_ioctl()
>=20
AFAICS, that one should work just fine using after converting

          while (d->buffer_status[v.buffer]!=3D VIDEO1394_BUFFER_READY) {
                  spin_unlock_irqrestore(&d->lock, flags);
                  interruptible_sleep_on(&d->waitq);
                  spin_lock_irqsave(&d->lock, flags);
                  if (signal_pending(current)) {
                           spin_unlock_irqrestore(&d->lock,flags);
                           return -EINTR;
                  }
          }

to

static inline unsigned video1394_buffer_state(struct dma_iso_ctx *d,
						unsigned int buffer)
{
	unsigned long flags;
	unsigned int ret;
	spin_lock_irqsave(&d->lock, flags);
	ret =3D d->buffer_status[buffer];
	spin_unlock_irqrestore(&d->lock, flags);
	return ret;
}
=2E..

	spin_unlock_irqrestore(&d->lock, flags);
	if (wait_event_interruptible(d->waitq,=20
	    video1394_buffer_state(d, v.buffer) =3D=3D VIDEO1394_BUFFER_READY))
		return -EINTR;
	spin_lock_irqsave(&d->lock, flags);

The trick here is that it is known in advance that the state does not actua=
lly
have to be protected by the lock after reading it, because the state can no=
t=20
change from READY to FREE in any other place in the code.
One exception might be two processes calling the ioctl at the same time, but
I think that is racy will any of these variations.

	Arnd <><



--Boundary-02=_2ZjECu8LxrHVQdU
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCEjZ25t5GS2LDRf4RAsKeAJ9AxXA045FZ9wIHfjlZrlzHvR2F1QCcCw0s
4AiKiYcmkwKFGy278OdbZrk=
=jjDZ
-----END PGP SIGNATURE-----

--Boundary-02=_2ZjECu8LxrHVQdU--
