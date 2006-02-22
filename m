Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWBVVXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWBVVXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBVVXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:23:07 -0500
Received: from ctb-mesg8.saix.net ([196.25.240.78]:36280 "EHLO
	ctb-mesg8.saix.net") by vger.kernel.org with ESMTP id S1750901AbWBVVXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:23:06 -0500
Subject: Re: Problems with read() on /proc/devices with x86_64 system
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0602221520080.11376@chaos.analogic.com>
References: <1140635265.26079.16.camel@lycan.lan>
	 <Pine.LNX.4.61.0602221520080.11376@chaos.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Sg5UnrHlzxBW+z025dfA"
Date: Wed, 22 Feb 2006 23:25:50 +0200
Message-Id: <1140643550.26079.30.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sg5UnrHlzxBW+z025dfA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-22 at 15:43 -0500, linux-os (Dick Johnson) wrote:
> On Wed, 22 Feb 2006, Martin Schlemmer wrote:
>=20
> > Hi,
> >
> > Not sure when it started, but 2.6.16-rc[1234] at least have problems
> > with unbuffered read() and /proc/devices on my x86_64 box.  I first
> > picked it up with dmsetup that did not want to work properly built
> > against klibc (glibc with fread() worked fine though, as it mmap()'d th=
e
> > file).
> >
> > Following code (from HPA and klibc mailing lists), when compiled and ru=
n
> > with /proc/devices only reads the first two lines and then exits
> > normally, where with any other file works as expected.
> >
> > -----
> > #include <stdlib.h>
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <errno.h>
> > #include <sys/stat.h>
> >
> > int main(int argc, char *argv[])
> > {
> >  char c;
> >  int i, fd, rv;
> >
> >  for ( i =3D 1 ; i < argc ; i++ ) {
> >    fd =3D open(argv[i], O_RDONLY);
> >    if ( fd < 0 ) {
> >      perror(argv[i]);
> >      exit(1);
> >    }
> >
> >    while ( (rv =3D read(fd, &c, 1)) ) {
> >      if ( rv =3D=3D -1 ) {
> >        if ( errno =3D=3D EINTR || errno =3D=3D EAGAIN )
> >          continue;
> >
> >        perror(argv[i]);
> >        exit(1);
> >      }
> >      putchar(c);
> >    }
> >
> >    close(fd);
> >  }
> >  return 0;
> > }
> > -----
> >
> > Output over here:
> >
> > -----
> > # ./readbychar.klibc /proc/devices
> > Character devices:
> >  1 mem
> > #
> > -----
> > Thanks,
> > Martin Schlemmer
>=20
> If your code ever worked, it's probably because of some
> fortuitous buffering in the 'C' runtime library.

Not my code .. I just did a minimal hack to get it to build with klibc
(klibc do not support fscanf(), so used fread() and sscanf() ..).

>  Most
> of the 'read' code in drivers that have a /proc interface
> is not designed for 1-character-at-a-time I/O. It's expected
> that it will be accessed like `cat` or `more` or other
> such tools access it, -- one read with 4096-byte buffer --
>=20
> read(3, "MemTotal:       773860 kB\nMemFre"..., 4096) =3D 670
> write(1, "MemTotal:       773860 kB\nMemFre"..., 670) =3D 670
>=20

Maybe, but the same code I posted works fine with any other file
in /proc, and works fine on my small p3 server with 2.6.14.

> The read code uses sprintf to write all the parameters to
> a buffer, then it copies the parameters to the user. The
> next read will return 0 for EOF and reset the interface
> for the next access.
>=20
> If your code read /proc without any help from the 'C' runtime
> library, you would read the same first character, every time
> you attempted to read a character. Don't do that! Your code
> should do (with some error-checking):
>=20
>          fd =3D open(argv[1], O_RDONLY);
>  	buffer =3D malloc(LEN);
>          read(fd, buffer, len);
>          puts(buffer);
>=20
> Also, something seems somewhat strange because it is not
> commonplace to provide a mmap() interface to /proc file-system
> capability in drivers and the /proc base code doesn't
> provide memory-map capability at least on 2.6.15.4. So,
> your reference to memory-mapping the file seems to be
> incorrect.
>=20

Might have misread the strace there.



Thanks,

--=20
Martin Schlemmer


--=-Sg5UnrHlzxBW+z025dfA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD/NbeqburzKaJYLYRAig6AJ9Htv/64k3RN1DuVWPYIc/nOVWoAQCdFWe7
LFDlfhQbbnonkEOPivJF3qA=
=cFZt
-----END PGP SIGNATURE-----

--=-Sg5UnrHlzxBW+z025dfA--

