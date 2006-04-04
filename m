Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWDDI5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWDDI5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDDI5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:57:34 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:39174 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S932401AbWDDI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:57:33 -0400
Date: Tue, 4 Apr 2006 08:57:29 +0000
From: John Mylchreest <johnm@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060404085729.GH3443@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <20060402114215.GA30491@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <20060402114215.GA30491@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a7XSrSxqzVsaECgU
Content-Type: multipart/mixed; boundary="QDd5rp1wjxlDmy9q"
Content-Disposition: inline


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 01:42:15PM +0200, Olaf Hering <olh@suse.de> wrote:
>  On Sun, Apr 02, John Mylchreest wrote:
>=20
> > Going from that, I can push a patch for gcc upstream to remove the
> > __KERNEL__ dep, but gcc4.1 ships with ssp by standard, and the semantics
> > between the IBM patch for SSP applied to gcc-3 and ggc-4 have changed.
>=20
> gcc4.1 has no obvious problems with --enable-ssp
>=20
> > -fno-stack-protector would work for gcc4, but for gcc3 it could still be
> > patially enabled, and requires -fno-stack-protector-all. Mind If I ask
> > whats incorrect about defining __KERNEL__ for the bootcflags?
>=20
> arch/powerpc/boot is no kernel code, its supposed to be selfcontained.
> Prepare a patch which uses the cc-option macro.

As requested, please see attached a small patch which rectifies this
with negating cflags. The cc-option macro won't always work, and as such
I have declared a new macro to honour $(CROSS32CC).

Thoughts welcome,
John

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=utf8
Content-Disposition: attachment; filename="ppc32-2.6.16-sspcc.patch"
Content-Transfer-Encoding: quoted-printable

--- a/arch/powerpc/boot/Makefile	2006-04-03 17:33:44.000000000 +0000
+++ b/arch/powerpc/boot/aMakefile	2006-04-04 08:51:13.000000000 +0000
@@ -21,9 +21,19 @@
 #	in the toplevel makefile.
=20
=20
+# cc-option-crosscc
+# We can't rely on the host compiler in this situation, so we define
+# a modified cc-option macro for this task.
+# Usage: cflags-y +=3D $(call cc-option-crosscc, -march=3Dwinchip-c6, -mar=
ch=3Di586)
+
+cc-option-crosscc =3D $(shell if $(CROSS32CC) $(CFLAGS) $(1) -S -o /dev/nu=
ll -xc /dev/null \
+                     > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)";=
 fi ;)
+
 HOSTCC		:=3D gcc
 BOOTCFLAGS	:=3D $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
-		   $(shell $(CROSS32CC) -print-file-name=3Dinclude) -fPIC
+		   $(shell $(CROSS32CC) -print-file-name=3Dinclude) -fPIC \
+		   $(call cc-option-crosscc, -fno-stack-protector) \
+		   $(call cc-option-crosscc, -fno-stack-protector-all)
 BOOTAFLAGS	:=3D -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc=20
 OBJCOPYFLAGS    :=3D contents,alloc,load,readonly,data
 OBJCOPY_COFF_ARGS :=3D -O aixcoff-rs6000 --set-start 0x500000

--QDd5rp1wjxlDmy9q--

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMjT5NzVYcyGvtWURAmUFAKDBD1U3hmawYNK+EE/LVzswy2GH4gCgqZGv
6Lo32i8fZ3U03xbc89AkyAM=
=NzSU
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
