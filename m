Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVBLLtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVBLLtC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 06:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVBLLtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 06:49:02 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:39086 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261391AbVBLLsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 06:48:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [RFC UPDATE PATCH] add wait_event_*_lock() functions and comments
Date: Sat, 12 Feb 2005 12:38:26 +0100
User-Agent: KMail/1.6.2
Cc: Al Borchers <alborchers@steinerpoint.com>, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
References: <1108105628.420c599cf3558@my.visi.com> <20050211195553.GE2372@us.ibm.com>
In-Reply-To: <20050211195553.GE2372@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_3qeDCZf/K9qwBHQ";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502121238.31478.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_3qeDCZf/K9qwBHQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freedag 11 Februar 2005 20:55, Nishanth Aravamudan wrote:

> + * If the macro name contains:
> + * 	lock, then @lock should be held before calling wait_event*().
> + * 		It is released before sleeping and grabbed after
> + * 		waking, saving the current IRQ mask in @flags. This lock
> + * 		should also be held when changing any variables
> + * 		affecting the condition and when waking up the process.

Hmm, I see two problems with that approach:

1. It might lead to people not thinking about their locking order
thoroughly if you introduce a sleeping function that is called with
a spinlock held. Anyone relying on that lock introduces races because
it actually is given up by the macro. I'd prefer it to be called=20
without the lock and then have it acquire the lock only to check the
condition, e.g:

#define __wait_event_lock(wq, condition, lock, flags)                  \
do {                                                                   \
       DEFINE_WAIT(__wait);                                            \
                                                                       \
       for (;;) {                                                      \
               prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);    \
               spin_lock_irqsave(lock, flags);                         \
               if (condition)                                          \
                       break;                                          \
               spin_unlock_irqrestore(lock, flags);                    \
               schedule();                                             \
       }                                                               \
       spin_unlock_irqrestore(lock, flags);                            \
       finish_wait(&wq, &__wait);                                      \
} while (0)

2. You define the macros only for using spin_lock_irqsave. To make the
API complete, you would also need
spin_lock()
spin_lock_irq()
spin_lock_bh()
read_lock()
read_lock_irq()
read_lock_bh()
read_lock_irqsave()
write_lock()
write_lock_irq()
write_lock_bh()
write_lock_irqsave()

Of course, that is complete overkill if you want to define all the=20
wait_event variations for each of those locking variations, but sooner or
later someone will want another one.

One solution that might work could look like
#define __cond_spin_locked(cond, lock) \
	({ __typeof__(cond) c; spin_lock(lock); \
		c =3D (cond); spin_unlock(lock); c; })

#define wait_event_lock(wq, condition, lock) \
	wait_event(wq, __cond_spin_locked(condition, lock))

#define wait_event_timeout_lock(wq, condition, lock, flags, timeout) \
	wait_event_timeout(wq, __cond_spin_locked(condition, lock), timeout)

and so forth.

OTOH, that is easy enough that it can as well be encapsulated in the
places where it is needed.

	Arnd <><

--Boundary-02=_3qeDCZf/K9qwBHQ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCDeq35t5GS2LDRf4RAgzOAJ4o581+hE0YlfYK7lcVlT6HLhzSBQCbBTwP
Hy4gDLFMK5TogguXJ0h4lVU=
=8uMu
-----END PGP SIGNATURE-----

--Boundary-02=_3qeDCZf/K9qwBHQ--
