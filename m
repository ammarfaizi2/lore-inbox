Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272997AbTGaMO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272998AbTGaMO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:14:56 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:29069 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272997AbTGaMOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:14:50 -0400
Date: Thu, 31 Jul 2003 14:14:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Emulating i486 on i386 (was: TSCs are a no-no on i386)
Message-ID: <20030731121448.GW1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local> <20030731113838.GU1873@lug-owl.de> <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HGaRQb5hTaIGBN4N"
Content-Disposition: inline
In-Reply-To: <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HGaRQb5hTaIGBN4N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 12:51:09 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote in message <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>:
> On Iau, 2003-07-31 at 12:38, Jan-Benedict Glaw wrote:
> > Thanks for that. In the meantime, I've started to give a try to the
> > userspace version (using a LD_PRELOAD lib). My current Problem:
> >=20
> > amtus:~/sigill_catcher# LD_PRELOAD=3D./libsigill.so ls
> > sigill.c:_init():69: sigill started, sigaction() =3D 0
> > build.sh  intercept.h  libsigill.so  run.sh  sigill.c  sigill.o
> > amtus:~/sigill_catcher# LD_PRELOAD=3D./libsigill.so apt-get update
> > Illegal instruction
> >=20
> > See? It's loaded at the "ls" call, but it seems to be not loaded for
> > apt-get.
>=20
> Remember you need to overload signal setting functions like sigaction.
> My guess is apt decided to disable your signal and you didnt stop it

I thought about that. Though, strace shows this is straight after ldso
mapped all libs. So apt-get's main() didn't yet start.

amtus:~/sigill_catcher# cat run.sh=20
#!/bin/sh

LD_PRELOAD=3D./libsigill.so apt-get update

amtus:~/sigill_catcher# strace -o xxx -f -ff ./run.sh=20
Process 681 attached (waiting for parent)
Process 681 resumed (parent 680 ready)
Process 680 suspended
Process 680 resumed
Process 681 detached
=2E/run.sh: line 3:   681 Illegal instruction LD_PRELOAD=3D./libsigill.so a=
pt-get update
amtus:~/sigill_catcher# grep -i sig xx* | grep -i ILL
xxx:stat64("/root/sigill_catcher", {st_mode=3DS_IFDIR|0755, st_size=3D4096,=
 ...}) =3D 0
xxx:wait4(-1, [WIFSIGNALED(s) && WTERMSIG(s) =3D=3D SIGILL], 0, NULL) =3D 6=
81
xxx.681:open("./libsigill.so", O_RDONLY)        =3D 3
xxx.681:getcwd("/root/sigill_catcher", 128)     =3D 21
xxx.681:--- SIGILL (Illegal instruction) @ 0 (0) ---

So my lib gets loaded, but it's _init() function seems to be called too
late (in prior, some parts of libstdc++5 decided to commit suicide).

Looking at the strace, libsigill is the loaded as the very first action.
Then, all the other libs are mapped. It seems that _init()ing them
happens somewhat in reverse order or something like that... I'm a but
hosed in that case:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--HGaRQb5hTaIGBN4N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KQg4Hb1edYOZ4bsRAkF/AJ94hSHj3I9fNcxInKyFGGeTa4WyegCeNiIE
bIH7t0LOyJsw94NHcNmYcoM=
=YRLl
-----END PGP SIGNATURE-----

--HGaRQb5hTaIGBN4N--
