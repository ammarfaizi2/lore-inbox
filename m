Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbULORxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbULORxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbULORxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:53:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:36021 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262413AbULORx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:53:28 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Wed, 15 Dec 2004 18:47:09 +0100
User-Agent: KMail/1.6.2
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com
References: <20041215065650.GM27225@wotan.suse.de> <200412151745.32053.arnd@arndb.de> <20041215165703.GC26772@wotan.suse.de>
In-Reply-To: <20041215165703.GC26772@wotan.suse.de>
MIME-Version: 1.0
Message-Id: <200412151847.09598.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_diHwBSRPvk/bH8J";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_diHwBSRPvk/bH8J
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Middeweken 15 Dezember 2004 17:57, Andi Kleen wrote:
> > Do you mean it should call back
> > from its private ioctl_compat() function to the global ioctl32_hash_tab=
le[]
> > lookup?
>=20
> Yes.
>=20
> Some ioctl paths already work this way, e.g. in the block layer.

Hmm. I just had another idea. Maybe it's easier to return -ENOIOCTLCMD
from ->ioctl_compat() in order to get back to the hash lookup. How
about the change below?

      Arnd <><

=2D-- mst/fs/compat.c
+++ arnd/fs/compat.c
@@ somewhere in compat_sys_ioctl() @@
        else if (filp->f_op && filp->f_op->ioctl_compat) {
                error =3D filp->f_op->ioctl_compat(filp->f_dentry->d_inode,
                                                 filp, cmd, arg);
=2D               goto out;
+               if (error !=3D -ENOIOCTLCMD)
+                        goto out;
        }
=20



--Boundary-02=_diHwBSRPvk/bH8J
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBwHid5t5GS2LDRf4RAh9mAJ0fyflT3gP1RorvmWB0udrl2uGljwCgo/KB
9pKqLpv3/mVRLVV2iWXZJZk=
=9l1U
-----END PGP SIGNATURE-----

--Boundary-02=_diHwBSRPvk/bH8J--
