Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWBVTE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWBVTE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWBVTE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:04:56 -0500
Received: from ctb-mesg3.saix.net ([196.25.240.73]:48784 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S1751401AbWBVTEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:04:55 -0500
Subject: Problems with read() on /proc/devices with x86_64 system
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JaBEtog+9wjK3NgSKp+H"
Date: Wed, 22 Feb 2006 21:07:45 +0200
Message-Id: <1140635265.26079.16.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JaBEtog+9wjK3NgSKp+H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Not sure when it started, but 2.6.16-rc[1234] at least have problems
with unbuffered read() and /proc/devices on my x86_64 box.  I first
picked it up with dmsetup that did not want to work properly built
against klibc (glibc with fread() worked fine though, as it mmap()'d the
file).

Following code (from HPA and klibc mailing lists), when compiled and run
with /proc/devices only reads the first two lines and then exits
normally, where with any other file works as expected.

-----
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/stat.h>

int main(int argc, char *argv[])
{
  char c;
  int i, fd, rv;

  for ( i =3D 1 ; i < argc ; i++ ) {
    fd =3D open(argv[i], O_RDONLY);
    if ( fd < 0 ) {
      perror(argv[i]);
      exit(1);
    }

    while ( (rv =3D read(fd, &c, 1)) ) {
      if ( rv =3D=3D -1 ) {
        if ( errno =3D=3D EINTR || errno =3D=3D EAGAIN )
          continue;

        perror(argv[i]);
        exit(1);
      }
      putchar(c);
    }

    close(fd);
  }

  return 0;
}
-----

Output over here:

-----
 # ./readbychar.klibc /proc/devices
Character devices:
  1 mem
 #
-----


Thanks,

--=20
Martin Schlemmer


--=-JaBEtog+9wjK3NgSKp+H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD/LaBqburzKaJYLYRAhnzAJ9LkxW0c4FmgEDpfqF+l4/q5wPqMQCdG4FZ
11VUydTlWNBUgEvxXqha3Xg=
=ynJy
-----END PGP SIGNATURE-----

--=-JaBEtog+9wjK3NgSKp+H--

