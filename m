Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267845AbTBROIA>; Tue, 18 Feb 2003 09:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbTBROIA>; Tue, 18 Feb 2003 09:08:00 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2833 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S267845AbTBROH5>;
	Tue, 18 Feb 2003 09:07:57 -0500
Date: Tue, 18 Feb 2003 15:17:57 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] morse code panics for 2.5.62
Message-ID: <20030218141757.GV351@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030218135038.GA1048@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DbCiEIZK/ffHkrHm"
Content-Disposition: inline
In-Reply-To: <20030218135038.GA1048@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DbCiEIZK/ffHkrHm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-02-18 14:50:38 +0100, Tomas Szepe <szepe@pinerecords.com>
wrote in message <20030218135038.GA1048@louise.pinerecords.com>:

This is the first time I really look at the code, so please forgive if I
talk about things where already a consens was given...

> diff -urN a/include/linux/morseops.h b/include/linux/morseops.h
> --- a/include/linux/morseops.h	1970-01-01 01:00:00.000000000 +0100
> +++ b/include/linux/morseops.h	2003-02-15 10:21:35.000000000 +0100
> @@ -0,0 +1,26 @@
> +/* Yes, it's morse code ops indeed. */
> +
> +#ifndef _LINUX_MORSEOPS_H
> +#define _LINUX_MORSEOPS_H
> +
> +#include <linux/config.h>
> +
> +#if defined(CONFIG_MORSE_PANICS)
> +
> +extern const unsigned char morsetable[];	/* in kernel/morse.c */
> +void panic_morseblink(char *buf);		/* in kernel/morse.c */
> +
> +static inline unsigned char tomorse(char c) {
> +	if (c >=3D 'a' && c <=3D 'z')
> +		c =3D c - 'a' + 'A';
> +	if (c >=3D '"' && c <=3D '_') {
> +		return morsetable[c - '"'];
> +	} else
> +		return 0;
> +}
> +
> +#else	/* CONFIG_MORSE_PANICS */
> + #define panic_morseblink(buf)

I think this has to read:

  +# define panic_morseblink(buf)

IIRC there's no leading whitespace allowed for the '#', but there may
follow some...


> +#endif	/* CONFIG_MORSE_PANICS */
> +
> +#endif	/* _LINUX_MORSEOPS_H */
> diff -urN a/include/linux/vt_kern.h b/include/linux/vt_kern.h
> --- a/include/linux/vt_kern.h	2002-12-16 07:01:55.000000000 +0100
> +++ b/include/linux/vt_kern.h	2003-02-15 10:21:35.000000000 +0100
> @@ -33,7 +33,10 @@
>  	wait_queue_head_t paste_wait;
>  } *vt_cons[MAX_NR_CONSOLES];
> =20
> +/* keyboard.c */
> +
>  extern void kd_mksound(unsigned int hz, unsigned int ticks);
> +extern void kd_turn_all_leds(int on_or_off);

Please, s/on_or_off/enlightened/ or something like that. That would keep
the semantics clear:-)

>  extern int kbd_rate(struct kbd_repeat *rep);
> =20
>  /* console.c */
> +#include <linux/jiffies.h>
> +#include <linux/vt_kern.h>
> +
> +#define DITLEN		(HZ / 5)
> +#define DAHLEN		(3 * DITLEN)
> +#define SPACELEN	(7 * DITLEN)
> +#define FREQ		844
> +
> +static int morse_setting =3D 1;
> +
> +const unsigned char morsetable[] =3D {
> +	0122, 0, 0310, 0, 0, 0163,				/* "#$%&' */
> +	055, 0155, 0, 0, 0163, 0141, 0152, 0051, 		/* ()*+,-./ */
> +	077, 076, 074, 070, 060, 040, 041, 043, 047, 057,	/* 0-9 */
> +	0107, 0125, 0, 0061, 0, 0114, 0, 			/* :;<=3D>?@ */
> +	006, 021, 025, 011, 002, 024, 013, 020, 004,		/* A-I */
> +	036, 015, 022, 007, 005, 017, 026, 033, 012,		/* J-R */
> +	010, 003, 014, 030, 016, 031, 035, 023,			/* S-Z */
> +	0, 0, 0, 0, 0154					/* [\]^_ */
> +};

You're using a set bit for long and an unset bit for a short beep, don't
you? Storing these values in octal/as chars is quite low on memory
consumption, but I'd like to learn so I suggest:

#define	NO	0	/* neither long nor short	*/
#define	LB	1	/* long beep			*/
#define SB	0	/* short beep			*/
#define MORSE(letter, beep1, beep2, beep3, beep4, beep5, beep6, beep7)	\
	(beep1 << 6 | beep2 << 5 | beep3 << 4 | beep4 << 3		\
		| beep5 << 2 | beep6 << 1 | beep7 << 0)

Then, do somethink like
const unsigned char morsetable[] =3D {
	MORSE('A', NO, NO, NO, NO, LB, LB, SB),
	...
};

(My values aren't right for sure, but this way, we all can easily learn
morse code:-)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--DbCiEIZK/ffHkrHm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+UkCVHb1edYOZ4bsRAgJHAJ9Lj4xYmvYWz+w/fZCsulNorHPq7gCeNdJV
x8GXosUYBOU+EbPnXqp6QEM=
=67XX
-----END PGP SIGNATURE-----

--DbCiEIZK/ffHkrHm--
