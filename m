Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSCOMUa>; Fri, 15 Mar 2002 07:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291948AbSCOMUL>; Fri, 15 Mar 2002 07:20:11 -0500
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:2732 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S291766AbSCOMUB>; Fri, 15 Mar 2002 07:20:01 -0500
Subject: Re: 2.4.19pre3aa2
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
In-Reply-To: <3C912ACF.AF3EE6F0@pp.inet.fi>
In-Reply-To: <20020314032801.C1273@dualathlon.random> 
	<3C912ACF.AF3EE6F0@pp.inet.fi>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-vZQNWIFlM6gOrI4Z+qBw"
X-Mailer: Evolution/1.0.2 
Date: 15 Mar 2002 13:19:44 +0100
Message-Id: <1016194785.5713.200.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vZQNWIFlM6gOrI4Z+qBw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello!

On Thu, 2002-03-14 at 23:57, Jari Ruusu wrote:
> Andrea Arcangeli wrote:
> > Only in 2.4.19pre3aa2: 00_loop-IV-API-hvr-1
> >=20
> >         Make the IV API not to be in function of the blkdev
> >         of the underlying fs, so you can copy your cryptoloop
> >         around without risking to lose data. This breaks the
> >         on-disk format of some encrypted transfer module though,
> >         if you don't like it please discuss it here in CC with
> >         Herbert Valerio Riedel <hvr@hvrlab.org>, the patch
> >         is from him. I think writing a converter in place of
> >         the loop data would be the preferred solution if needed. It cou=
ld
> >         be done in a way to link transparently with the source of
> >         the kernel modules.

just as a side note to compatibility to the old IV metric;

the patch I sent to andrea is quite minimal, it only changes the IV
metric, and adds a few #define's to loop.h in order to recognize the IV
metric when compiling filter modules against it; as to jari's patch, if
the following def's were added, it can be used instead of my minimal
patch...

/* definitions for IV metric */
#define LOOP_IV_SECTOR_BITS 9
#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)

typedef int loop_iv_t;

...except maybe for when backward compatibility is needed. As it is a
major concern to some of us to be able to convert their old iv-metric
encrypted volumes to the new "atomic"-IV-metric, it can be usefull to be
able to have both IV metrics available on the same system...

one approach could be to losetup the concerned volume w/ an old loop.o v
ersion and decipher the content on-the-fly by doing something like

# set up the loop dev
losetup -e cipher /dev/loop0 /dev/partition

# make sure we got the right passphrase etc...; and also make sure the
# kernel fs code set the right transfer-block-size...
mount /dev/loop0 /mnt/tmp; umount /dev/loop0

# decrypt on-the-fly...
dd if=3D/dev/loop0 of=3D/dev/partition

...now in theory we should have the unencrypted data lying in
/dev/partition=20


now we could replace the loop.o module by one feature the new IV metric,
and just reverse the process..

so far ok... but some of us might want to decrypt and encrypt directly,
w/o having to have some unencrypted (thus unprotected) data lying around
for the meantime; so we might want to have 2 IV metrics available at the
same time... this can either be done by cooperation from the loop.o
module, i.e. some option for setting the IV size to calculate... _or_ it
can be calculated by the filter module, by finding out what IV blocksize
to assume, and then dividing the 512-IV-metric by some integral factor
to reflect the old metric...

the latter approach is possible w/ my patch, and has been implemented
cryptoapi's cryptoloop filter through ioctl()...

this relays on the IV-fix not modifying the transfer block size (if the
blocks passed to the transfer filter should become smaller than the old
metric's IV block size, we simply can't emulate the old metric...), but
only the passed IV value...

ps: just to make one thing clear (again), I don't care too much whether
my loop-fix or jari's goes in; I primarily care for a fixed IV situation
(including the above mentioned #define's/typedef) and if possible anyhow
to allow for limited compatibility to the old metric...

regards,
--=20
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

--=-vZQNWIFlM6gOrI4Z+qBw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8kebgSYHgZIg/QUIRAumTAKCIjhH0/wDLeE8z5kkYNAWZc56WLACgjZAc
CfZi8af+VWfGaOST8GjCIdU=
=e+Zs
-----END PGP SIGNATURE-----

--=-vZQNWIFlM6gOrI4Z+qBw--

