Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267895AbTBRRCv>; Tue, 18 Feb 2003 12:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBRRCv>; Tue, 18 Feb 2003 12:02:51 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:59909 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S267895AbTBRRCr>;
	Tue, 18 Feb 2003 12:02:47 -0500
Date: Tue, 18 Feb 2003 18:12:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andrew Rodland <arodland@noln.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] morse code panics for 2.5.62
Message-ID: <20030218171247.GA351@lug-owl.de>
Mail-Followup-To: Andrew Rodland <arodland@noln.com>,
	linux-kernel@vger.kernel.org
References: <20030218135038.GA1048@louise.pinerecords.com> <20030218141757.GV351@lug-owl.de> <b2tl9c$48c$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9U9oWULJx7fFSwf"
Content-Disposition: inline
In-Reply-To: <b2tl9c$48c$1@main.gmane.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z9U9oWULJx7fFSwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-02-18 11:00:23 -0500, Andrew Rodland <arodland@noln.com>
wrote in message <b2tl9c$48c$1@main.gmane.org>:
> Jan-Benedict Glaw wrote:
> > On Tue, 2003-02-18 14:50:38 +0100, Tomas Szepe <szepe@pinerecords.com>
> > wrote in message <20030218135038.GA1048@louise.pinerecords.com>:
> >=20
> > This is the first time I really look at the code, so please forgive if I
> > talk about things where already a consens was given...
>=20
> >> +const unsigned char morsetable[] =3D {
> >> +    0122, 0, 0310, 0, 0, 0163,                              /* "#$%&'=
 */
> >> +    055, 0155, 0, 0, 0163, 0141, 0152, 0051,                /* ()*+,-=
./ */
> >> +    077, 076, 074, 070, 060, 040, 041, 043, 047, 057,       /* 0-9 */
> >> +    0107, 0125, 0, 0061, 0, 0114, 0,                        /* :;<=3D=
>?@ */
> >> +    006, 021, 025, 011, 002, 024, 013, 020, 004,            /* A-I */
> >> +    036, 015, 022, 007, 005, 017, 026, 033, 012,            /* J-R */
> >> +    010, 003, 014, 030, 016, 031, 035, 023,                 /* S-Z */
> >> +    0, 0, 0, 0, 0154                                        /* [\]^_ =
*/
> >> +};
>=20
> >=20
> > You're using a set bit for long and an unset bit for a short beep, don't
> > you? Storing these values in octal/as chars is quite low on memory
> > consumption, but I'd like to learn so I suggest:
>=20
> It's slightly more complicated than that:
> It's set bits for long, unset bits for short, and termination when the by=
te
> equals 0x01 (in other words, there's an extra set bit to the left of what
> we want). This lets us represent any variable-length morse of up to 7
> dits/dahs with a byte, which is cool because nothing is more than 6, that
> I've ever seen.

So you've got a leading I bit set. Morse alphabet has got 2, 3, 4, 5 or
6 dots/dashes, right? Then I vote for either having a macro like this:

#define MORSE(letter, len, b1, b2, b3, b4, b5, b6, b7)		\
	(1<<(len)| [all the shifting stuff here as of the last mail])

or let's have5 separate macros for all possible lengths (which are
possibly defined by using the above macro).

Really, I'm 100% for learning!

> The use of macros is an OK hack though, it reminds me of the nethack sour=
ce.
> :)
>=20
> The reason someone proposed this in the first place is because I had had
>=20
> const unsigned char * morsetable [] =3D {
>         ".-..-.", NULL, "...-..-"
>=20
> and so on in the initial revision of my patch, which is quite readable, b=
ut
> takes up a lot more space, and makes the code actually a bit messier too.=
=20

Oh, that's long, too...


What about

#define IS_DASH(letter, shift)					\
	((letter) =3D=3D '-'? (1 << shift): (0 << shift))
MORSE(shift, b1, b2, b3, b4, b5, b6)				\
	(1 << (shift)	| IS_DASH((b1), 5) | IS_DASH((b2), 4)	\
			| IS_DASH((b3), 3) | IS_DASH((b4), 2)	\
			| IS_DASH((b5), 1) | IS_DASH((b6), 0)
#define MORSE1(letter, b1)				\
	MORSE(1, '.', '.', '.', '.', '.', (b1)))
#define MORSE2(letter, b1, b2)				\
	MORSE(2, '.', '.', '.', '.', (b1), (b2)))
#define MORSE3(letter, b1, b2, b3)			\
	MORSE(3, '.', '.', '.', (b1), (b2), (b3))
#define MORSE4(letter, b1, b2, b3, b4)			\
	MORSE(4, '.', '.', (b1), (b1), (b3), (b4))
#define MORSE5(letter, b1, b2, b3, b4, b5)		\
	MORSE(5, '.', (b1), (b2), (b3), (b4), (b5))
#define MORSE6(letter, b1, b2, b3, b4, b5, b6)		\
	MORSE(6, (b1), (b2), (b3), (b4), (b5), (b6))

Then, you can have
const char morses[] =3D {
	MORSE2('A', '.', '-'),
	MORSE4('B', '-', '.', '.', '.'),
	MORSE4('C', '-', '.', '-', '.'),
	MORSE3('D', '-', '.', '.'),
	MORSE1('E', '.'),
	MORSE4('F', '.', '.', '-', '.')
	...
};

That's going to take exactly the same memory in the compiled vmlinux
image, *and* it's really readable:-) Of course, gcc will optimize any
added "bloat" away...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--z9U9oWULJx7fFSwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+UmmPHb1edYOZ4bsRAuWdAKCDK6B4W3PUqDtOqzu8mEag6kre6wCfVnUR
jVJyR3MaeVp7U5+Du0eeRic=
=jVaV
-----END PGP SIGNATURE-----

--z9U9oWULJx7fFSwf--
