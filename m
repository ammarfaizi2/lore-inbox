Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUFEUvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUFEUvX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUFEUvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:51:23 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:42679 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261984AbUFEUvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:51:19 -0400
Date: Sat, 5 Jun 2004 22:51:17 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Spinlock-timeout
Message-ID: <20040605205117.GD20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReGtrnFZPvtbUCOi"
Content-Disposition: inline
In-Reply-To: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReGtrnFZPvtbUCOi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-05 15:31:26 -0500, Jake Moilanen <moilanen@austin.ibm.com>
wrote in message <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.c=
om>:
> Here's a patch that will BUG() when a spinlock is held for longer then X
> seconds.  It is useful for catching deadlocks since not all archs have a
> NMI watchdog. =20

I like the idea. However, I don't like touching all arch's Kconfig
files. I think it's better to either put this into ./lib/Kconfig (well,
doesn't really fit there), ot (even better:) put it into the Debug
Kconfig file.

> diff -Nru a/include/linux/spinlock.h b/include/linux/spinlock.h
> --- a/include/linux/spinlock.h	Sat Jun  5 14:25:51 2004
> +++ b/include/linux/spinlock.h	Sat Jun  5 14:25:51 2004
> @@ -38,6 +38,16 @@
>  #ifdef CONFIG_SMP
>  #include <asm/spinlock.h>
> =20
> +#if defined(CONFIG_SPINLOCK_TIMEOUT)
> +
> +#include <asm/param.h>
> +
> +#define SPINLOCK_TIMEOUT CONFIG_SPINLOCK_TIMEOUT_TIME
> +extern unsigned long volatile jiffies;
> +
> +#endif /* CONFIG_SPINLOCK_TIMEOUT */
> +
> +
>  #else
> =20
>  #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)

I'd say just include <linux/jiffies.h> and drop the whole #ifdef/#endif
block.

> @@ -218,11 +228,27 @@
>  } while (0)
> =20
>  #else
> +#if defined(CONFIG_SPINLOCK_TIMEOUT)
> +
> +static inline void spin_lock(spinlock_t * lock) {
> +	unsigned long jiffy_timeout =3D jiffies + (SPINLOCK_TIMEOUT * HZ);=20
> +
> +	preempt_disable();=20
> +	do {=20
> +		if (jiffies >=3D jiffy_timeout)=20
> +		        BUG();
> +	} while (!_raw_spin_trylock(lock));=20
> +}
> +
> +#else /* CONFIG_SPINLOCK_TIMEOUT */
> +
>  #define spin_lock(lock)	\
>  do { \
>  	preempt_disable(); \
>  	_raw_spin_lock(lock); \
>  } while(0)
> +
> +#endif /* CONFIG_SPINLOCK_TIMEOUT */
> =20
>  #define write_lock(lock) \
>  do { \

Also, printing out ->module, ->owner and ->oline might help additionally
to just BUG()ing. So you see the (former) owner of the lock.

> @@ -3967,6 +3971,10 @@
>  		while (spin_is_locked(lock))
>  			cpu_relax();
>  		preempt_disable();
> +#if defined(CONFIG_SPINLOCK_TIMEOUT)
> +		if (jiffies > =3D jiffy_timeout)
> +			BUG();
> +#endif
>  	} while (!_raw_spin_trylock(lock));
>  }
> =20

Dito.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--ReGtrnFZPvtbUCOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwjJFHb1edYOZ4bsRAgTBAJ9uAuJbWTked2ztV/zfIzDjd1DkuwCZAQxO
L95/5S5mw3x+xVrvV56z7yQ=
=tqFs
-----END PGP SIGNATURE-----

--ReGtrnFZPvtbUCOi--
