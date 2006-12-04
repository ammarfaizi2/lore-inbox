Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936090AbWLDLfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936090AbWLDLfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936089AbWLDLfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:35:53 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:24244 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S936090AbWLDLfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:35:52 -0500
Date: Mon, 4 Dec 2006 12:35:49 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>,
       jpdenheijer@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] actually delete the as-instr/ld-option tmp file
Message-ID: <20061204113549.GD31637@quickstop.soohrt.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>,
	jpdenheijer@gmail.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I noticed another problem in the
kbuild-dont-put-temp-files-in-the-source-tree.patch: A "normal" make
variable is being expanded recursively on each use, therefore multiple
uses of $(ASTMP) yield different temporary files. So $(AS) -o $(ASTMP)
writes to a file other than the one rm -f $(ASTMP) deletes, leaving
behind the first file in /tmp.

Using "simply expanded variables" (by assigning the mktemp output with
:=3D instead of =3D) can be problematic, as parallel make processes would
all write to and delete the very same tmp file, so I chose to fix this
by storing the $(ASTMP) output in a shell variable and reusing it.

Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
---

 Kbuild.include |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linux/scripts/Kbuild.include.current-mm	2006-12-04 11:31:55.000000000 +=
0100
+++ linux/scripts/Kbuild.include	2006-12-04 11:40:10.000000000 +0100
@@ -67,9 +67,10 @@ as-option =3D $(shell if $(CC) $(CFLAGS) $
 # Usage: cflags-y +=3D $(call as-instr, instr, option1, option2)
=20
 ASTMP =3D $(shell mktemp $${TMPDIR:-/tmp}/asXXXXXX)
-as-instr =3D $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o $(=
ASTMP) ; \
+as-instr =3D $(shell ASTMP=3D$(ASTMP); \
+		   if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o $$ASTMP ; \
 		   then echo "$(2)"; else echo "$(3)"; fi; \
-	           rm -f $(ASTMP))
+	           rm -f $$ASTMP)
=20
 # cc-option
 # Usage: cflags-y +=3D $(call cc-option, -march=3Dwinchip-c6, -march=3Di58=
6)
@@ -99,10 +100,10 @@ cc-ifversion =3D $(shell if [ $(call cc-ve
 # ld-option
 # Usage: ldflags +=3D $(call ld-option, -Wl$(comma)--hash-style=3Dboth)
 LDTMP =3D $(shell mktemp $${TMPDIR:-/tmp}/ldXXXXXX)
-ld-option =3D $(shell if $(CC) $(1) \
-			     -nostdlib -o $(LDTMP) -xc /dev/null \
+ld-option =3D $(shell LDTMP=3D$(LDTMP); \
+	     if $(CC) $(1) -nostdlib -o $$LDTMP -xc /dev/null \
              > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
-	     rm -f $(LDTMP))
+	     rm -f $$LDTMP)
=20
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=3D

--=20
PGP-Key 0xD40E0E7A

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdAgVB6mkGNQODnoRAoUdAJ9+Vxn6JiFdcw20OMkYIvg1uT6ccACeIINx
rnsLcFmOI3waH0oNdaCFCIU=
=FoWW
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
