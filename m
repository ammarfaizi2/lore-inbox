Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVCQTJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVCQTJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 14:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVCQTJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 14:09:25 -0500
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:23945 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP id S261161AbVCQTJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 14:09:16 -0500
Subject: binfmt_elf padzero problems
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
Reply-To: tzachar@cs.bgu.ac.il
To: linux-kernel@vger.kernel.org
Cc: juhl-lkml@dif.dk, akpm@osdl.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-skHqWKUx+jLLLmhCRgNk"
Organization: bgu
Date: Thu, 17 Mar 2005 21:10:09 +0200
Message-Id: <1111086609.12193.27.camel@nexus.cs.bgu.ac.il>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-skHqWKUx+jLLLmhCRgNk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello.

i am seeing a problem(?) with the patch described at:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109865760703851&w=3D2
i'm using vanilla 2.6.11 (not .1/.2/.3/.4 ...)

the short version:
padzero does not alway do the right thing (more correctly, it's caller,
load_elf_binary).
=20
the longer version:

padzero calls clear_user. clear_user first checks if the address passed
is writable. if it is not, an error is returned.=20
the problem manifest itself when the area being cleared is not
writable... this should not normally happen in the context of
load_elf_binary, however it _can_ happen with the following assembly
code (intel syntax):

section .text
global _start
_start:
        mov eax,0x1
        mov ebx,0x0
        int 0x80
        hlt

assembled with nasm -f elf, produces a binary with a bss segment of zero
size, aligned to 1, and one program header.
now, the when calling padzero, elf_bss holds an address which belongs
to .text (since no (fake)program header for .bss wad created), i.e; not
writable....
when padzero is called, it tries to clean the rest of the .text section,
which clearly results with an error.....

thus, my (very) small binary always segfaults under 2.6.11+ ....

on the other hand, i can be dead wrong.. if so, id like to know why...

p.s. please cc me, im not subscribed,
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nir Tzachar.

--=-skHqWKUx+jLLLmhCRgNk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCOdYRIHR+zI+Dam4RAns9AJ9jYzJEgUO1QEthoPJJvkv31D8klgCdFTd6
EvQ8Dd6tVv/rc9UnZnZxpcw=
=5JzB
-----END PGP SIGNATURE-----

--=-skHqWKUx+jLLLmhCRgNk--

