Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261992AbSIYOoH>; Wed, 25 Sep 2002 10:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261993AbSIYOoH>; Wed, 25 Sep 2002 10:44:07 -0400
Received: from h24-68-71-10.vc.shawcable.net ([24.68.71.10]:39948 "EHLO
	kruhftwerk.dyndns.org") by vger.kernel.org with ESMTP
	id <S261992AbSIYOoF>; Wed, 25 Sep 2002 10:44:05 -0400
Date: Wed, 25 Sep 2002 07:49:20 -0700
From: Burton Samograd <kruhft@kruhft.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Some questions about Linux Framebuffer programming
Message-ID: <20020925144920.GA4398@kruhft.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020925141906.78323.qmail@web12302.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20020925141906.78323.qmail@web12302.mail.yahoo.com>
X-GPG-key: http://kruhftwerk.dyndns.org/kruhft.pubkey.asc
X-Operating-System: Linux kruhft.dyndns.org 2.4.19-gentoo-r9 
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2002 at 07:19:06AM -0700, Eric Miao wrote:
>=20
> 1. How can I switch to another virtual terminal by
> normal user process?
> VT_ACTIVATE ioctl can only be called by processes
> having root rights.
>

This is a snippet of a little program I wrote called vtswitch that
shows how to use the VT_ACTIVATE ioctl.  This works as a normal user,
so you might be using it wrong.  I can send the whole program if you
want to see how the whole thing works but this is the guts:

<--- begin code block ---->

int vtfd;

#define VT_DEVICE_FILE "/dev/tty"
vtfd =3D open(VT_DEVICE_FILE, O_RDWR, 0);
  if(vtfd < 0)
    {
      printf("*error* Could not open /dev/tty\n");
    }

  /* Save the current vt index to the history file */
  save_cur_vt_index(vtfd);

  /* Switch to the terminal if there wasn't an error looking up the
  alias */
  if(ioctl(vtfd, VT_ACTIVATE, terminal))
    {
      printf("*error* Error switching to terminal %s (%d)\n", vt,
  terminal);
      return -1;
    }

<-- end code block -->


> 2. When I switch away from and again back to the
> virtual terminal where I do frame buffer drawing,
> screen content is destroyed and replaced by original
> console text?
> How can I avoid this problem?

You can save the framebuffer contents to a program array and then poll
the current vt every once and a while (using VT_GETSTATE and
vt_stat.vt_active), check to see if your program is on the visible vt
and then copy it back to restore it.  This could also keep your
program from drawing to the framebuffer when it's not visible.

>=20
> 3. What is FBIOPUT_CON2FBMAP? What does it do?

Not sure.

>=20
> 4. How can I do flipping between primary frame and
> secondary frame?

Create an offscreen surface using malloc and do your rendering to that
and then do a memcpy (simple way) or hardware accellerated blt (faster
but harder to setup).

burton
--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9kczvLq/0KC7fYbURAtT4AKCy9ipJIVqNFZfeuJ/qG7NQH9UZPgCgs29Z
/aAlaZ08kmnmj9oU2GQK3dk=
=p1Vt
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
