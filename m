Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVBMCv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVBMCv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 21:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVBMCv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 21:51:29 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:25291 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261234AbVBMCvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 21:51:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [RFC UPDATE PATCH] add wait_event_*_lock() functions and comments
Date: Sun, 13 Feb 2005 03:41:01 +0100
User-Agent: KMail/1.6.2
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Al Borchers <alborchers@steinerpoint.com>, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
References: <1108105628.420c599cf3558@my.visi.com> <200502121238.31478.arnd@arndb.de> <20050212162835.4b95d635.vsu@altlinux.ru>
In-Reply-To: <20050212162835.4b95d635.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_D5rDCQk0hc7wcDJ";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502130341.07746.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_D5rDCQk0hc7wcDJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 12 Februar 2005 14:28, Sergey Vlasov wrote:
> On Sat, 12 Feb 2005 12:38:26 +0100 Arnd Bergmann wrote:
> > #define __wait_event_lock(wq, condition, lock, flags)                  \
> > do {                                                                   \
> >        DEFINE_WAIT(__wait);                                            \
> >                                                                        \
> >        for (;;) {                                                      \
> >                prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);    \
> >                spin_lock_irqsave(lock, flags);                         \
> >                if (condition)                                          \
> >                        break;                                          \
> >                spin_unlock_irqrestore(lock, flags);                    \
> >                schedule();                                             \
> >        }                                                               \
> >        spin_unlock_irqrestore(lock, flags);                            \
> >        finish_wait(&wq, &__wait);                                      \
> > } while (0)
>=20
> But in this case the result of testing the condition becomes useless
> after spin_unlock_irqrestore - someone might grab the lock and change
> things.   Therefore the calling code would need to add a loop around
> wait_event_lock - and the wait_event_* macros were added precisely to
> encapsulate such a loop and avoid the need to code it manually.

Ok, i understand now what the patch really wants to achieve. However,
I'm not convinced it's a good idea. In the usb/gadget/serial.c driver,
this appears to work only because an unconventional locking scheme is
used, i.e. there is an extra flag (port->port_in_use) that is set to
tell other functions about the state of the lock in case the lock holder
wants to sleep.

Is there any place in the kernel that would benefit of the=20
wait_event_lock() macro family while using locks without such
special magic?

	Arnd <><

--Boundary-02=_D5rDCQk0hc7wcDJ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCDr5D5t5GS2LDRf4RAnXpAJ0a99U3VYH4dG8QbU5bZmdD9dNtiwCdH5o0
mmZLiyDSGgPVXLMWJBRjwfE=
=r+C3
-----END PGP SIGNATURE-----

--Boundary-02=_D5rDCQk0hc7wcDJ--
