Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRLGNcU>; Fri, 7 Dec 2001 08:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRLGNcB>; Fri, 7 Dec 2001 08:32:01 -0500
Received: from mail.2d3d.co.za ([196.14.185.200]:26830 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S280971AbRLGNbm>;
	Fri, 7 Dec 2001 08:31:42 -0500
Date: Fri, 7 Dec 2001 15:34:44 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: DRI Development <dri-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: agpgart & i810 & agp_bridge.gatt_table question
Message-ID: <20011207153444.A6996@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	DRI Development <dri-devel@lists.sourceforge.net>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.16 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 3:20pm  up 8 days, 8 min, 11 users,  load average: 0.00, 0.01, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

What is agp_bridge.gatt_table used for on the Intel 810 series?

Looking at agpgart_be.c, it seems either 64k or 32k is allocated (depending
on the value of MISCC register) and all the entries is set to the scratch
page for i810, but that gatt table is never used except in
intel_i810_insert_entries() where we have this check:

------------< snip <------< snip <------< snip <------------
    for (j =3D pg_start; j < (pg_start + mem->page_count); j++) {
        if (!PGE_EMPTY(agp_bridge.gatt_table[j])) {
            return -EBUSY;
        }
------------< snip <------< snip <------< snip <------------
	=09
!PGE_EMPTY roughly translates to agp_bridge.gatt_table[j] &&
agp_bridge.gatt_table[j] !=3D agp_bridge.scratch_page.

Of course, this is always true, so we'll never return EBUSY there, but the
whole thing is silly because we're wasting precious 64k/32k physical
contigious ram and valuable CPU time for this useless check...

The other odd thing I noticed is that this gatt_table is initialized in
agp_backend_initialize(). Look at the 'if (agp_bridge.create_gatt_table()) =
{'
line in that function. For i810 this translates to
agp_generic_create_gatt_table(), which goes and queries
agp_bridge.current_size.

The problem is that at that stage agp_bridge.current is not initialized yet,
so we're going to get bogus sizes. (Note: this doesn't only go for i810, but
for any chipset that uses agp_generic_create_gatt_table and doesn't have a
size type LVL2_APER_SIZE (for which that function doesn't work))

--=20

Regards
 Abraham

Experience is what you get when you were expecting something else.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8EMV0zNXhP0RCUqMRAhpgAKCOtAjYEpzh4gKHmpcyxb+4+D3ihwCfQ23N
eViqUicZqGhafEP1T5UdiwU=
=zBFA
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
