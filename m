Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUDXDnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUDXDnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 23:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUDXDnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 23:43:25 -0400
Received: from linux.us.dell.com ([143.166.224.162]:25505 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261904AbUDXDnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 23:43:13 -0400
Date: Fri, 23 Apr 2004 22:41:09 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
Subject: Re: [patch 1/3] efivars driver update and move
Message-ID: <20040424034109.GA15589@lists.us.dell.com>
References: <200404221732.i3MHWJcc023373@snoqualmie.dp.intel.com> <20040423222945.GA9594@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20040423222945.GA9594@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2004 at 05:29:45PM -0500, Matt Domsch wrote:

> Trying these against 2.6.5 + ia64 patch, with efibootmgr-0.5.2-test2.
>=20
> Works: reading, deleting values.
> Doesn't work:  creating and editing values
>=20
> I note that efibootmgr prints out a warning when it can't read
> nonexistant variables, like BootNext.  I'll remove that warning.
>=20
> It's likely a bug in efibootmgr, as this is the first time I've tried
> the sysfs side of things.  If you're in a position to help debug, I'd
> appreciate it.

In fact, it *was* a bug in efibootmgr.  Here's the patch to fix it...=20

There's also a bug in efivars.c:efivar_delete(), this one-liner should fix =
it.

--- linux-2.6.5/drivers/firmware/efivars.c      2004-04-24 06:58:08.0000000=
00 -0400
+++ linux-2.6.5.mld/drivers/firmware/efivars.c  2004-04-24 12:09:28.0995454=
22 -0400
@@ -532,7 +532,7 @@ efivar_delete(struct subsystem *sub, con
        efivar_unregister(search_efivar);
 =20
        /* It's dead Jim.... */
-       return status;
+       return size;
 }


--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -urNp --exclude=3D'*~' efibootmgr-0.5.0-test2.orig/src/lib/efi.c efibo=
otmgr-0.5.0-test2/src/lib/efi.c
--- efibootmgr-0.5.0-test2.orig/src/lib/efi.c	2003-09-07 00:24:18.000000000=
 -0400
+++ efibootmgr-0.5.0-test2/src/lib/efi.c	2004-04-24 12:15:25.375908233 -0400
@@ -166,7 +166,7 @@ create_or_edit_variable(efi_variable_t *
 	memcpy(&testvar, var, sizeof(*var));
 	variable_to_name(var, name);
=20
-	if (read_variable(name, &testvar))
+	if (read_variable(name, &testvar) =3D=3D EFI_SUCCESS)
 		return edit_variable(var);
 	else
 		return create_variable(var);
diff -urNp --exclude=3D'*~' efibootmgr-0.5.0-test2.orig/src/lib/efivars_sys=
fs.c efibootmgr-0.5.0-test2/src/lib/efivars_sysfs.c
--- efibootmgr-0.5.0-test2.orig/src/lib/efivars_sysfs.c	2003-09-07 00:21:37=
.000000000 -0400
+++ efibootmgr-0.5.0-test2/src/lib/efivars_sysfs.c	2004-04-24 12:35:38.2079=
24626 -0400
@@ -49,8 +49,6 @@ sysfs_read_variable(const char *name, ef
 	snprintf(filename, PATH_MAX-1, "%s/%s/raw_var", SYSFS_DIR_EFI_VARS,name);
 	fd =3D open(filename, O_RDONLY);
 	if (fd =3D=3D -1) {
-		sprintf(buffer, "sysfs_read_variable():open(%s)", filename);
-		perror(buffer);
 		return EFI_NOT_FOUND;
 	}
 	readsize =3D read(fd, var, sizeof(*var));
@@ -74,8 +72,6 @@ sysfs_write_variable(const char *filenam
=20
 	fd =3D open(filename, O_WRONLY);
 	if (fd =3D=3D -1) {
-		sprintf(buffer, "sysfs_write_variable():open(%s)", filename);
-		perror(buffer);
 		return EFI_INVALID_PARAMETER;
 	}
 	writesize =3D write(fd, var, sizeof(*var));

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAieHVIavu95Lw/AkRAhvdAJ9zPlScvf/v2zF6MrkG8GHprynp2gCcCvbz
TC5aF5vJaJncO7OakfWYS4k=
=kVgz
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
