Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280422AbRKEJZw>; Mon, 5 Nov 2001 04:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280424AbRKEJZn>; Mon, 5 Nov 2001 04:25:43 -0500
Received: from [192.204.202.115] ([192.204.202.115]:36624 "EHLO
	marsupilami.stroucken.com") by vger.kernel.org with ESMTP
	id <S280422AbRKEJZZ>; Mon, 5 Nov 2001 04:25:25 -0500
Date: Mon, 5 Nov 2001 04:25:04 -0500
From: michael@stroucken.org
To: linux-kernel@vger.kernel.org
Subject: ISSUE and PATCH: failure to build certain modules on alpha
Message-ID: <20011105042504.A26578@stroucken.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
	This concerns a failure to build certain modules on the Alpha
platform. A patch to fix this is attached.

	The current kernel sources fail to build certain parts as modules
on the Alpha correctly. The modules in question are udf.o (UDF filesystem),
ext2.o (ext2 filesystem) and ymfpci.o (sound module).

	The apparent problem with the filesystem modules is that the function
'memscan' is implemented as a macro on the i386 platform, but as a regular
functions on other architectures like the Alpha. I only attempted to fix the
issue on the Alpha, as my experience in kernel hacking isn't extensive. If
other platforms are affected, I presume the fix would be similar to what I
did for the Alpha.

	From what I can see, the issue with the ymfpci module is general in
nature and probably affects all platforms. The macro 'mdelay' is defined in
include/linux/delay.h, which is not included by drivers/sound/ymfpci.c.

Keywords: drivers, modules, alpha, unresolved symbols

Versions affected: all 2.4 versions (confirmed on 2.4.10 and 2.4.13).
Environment:=20
  This is a Debian GNU/Linux system running unstable.
  marsupilami:~# cat /proc/version
  Linux version 2.4.10 (stroucki@marsupilami) (gcc version 2.95.4 20010902 =
(Debian prerelease)) #1 Tue Sep 25 02:02:22 EDT 2001
  marsupilami:~# uname -a
  Linux marsupilami 2.4.10 #1 Tue Sep 25 02:02:22 EDT 2001 alpha unknown

Triggering issue:
  Kernel compile (using make-kpkg) completes successfully, but on installing
  (via dpkg -i), unresolved symbols are found by depmod. The kernel boots,
  but the affected modules to not insert.
  Here's a detailed output of depmod:-
marsupilami:/lib/modules/2.4.13# depmod -e -a -F /boot/System.map-2.4.13 2.=
4.13
depmod: *** Unresolved symbols in /lib/modules/2.4.13/kernel/drivers/sound/=
ymfpci.o
depmod:         mdelay
depmod: *** Unresolved symbols in /lib/modules/2.4.13/kernel/fs/ext2/ext2.o
depmod:         memscan
depmod: *** Unresolved symbols in /lib/modules/2.4.13/kernel/fs/udf/udf.o
depmod:         memscan

Patch:
  The patch is attached to this message and fixes the issue on the Alpha.
  It is quite small, only 19 lines. It was generated from the 2.4.13 source=
s,
  but should apply to 2.4.10 and others also.

Verification:
  I first became annoyed enough to work on this with the 2.4.10 version.
  After the patch was applied, the warnings from depmod were absent, and
  upon booting, the relevant modules inserted (and removed) correctly:-
marsupilami:~# lsmod
Module                  Size  Used by
udf                   141904   0  (unused)
=2E..
ext2                   50024   2  (autoclean)

Personal info:
  I do not read the kernel mailing list regularly, but will do so for the
  next week. I am reachable at michael@stroucken.org .

Greetings,
Michael.
--=20
This message may have passed through thousands of machines throughout
the entire civilised world. It might have cost the net hundreds, if not
thousands of dollars to send everywhere.
Michael Stroucken ++ michael@stroucken.org ++ DEC Alpha ++ 1982 Honda CM450C

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Description: Fix for unresolved symbols on Alpha
Content-Disposition: attachment; filename="2.4.13-alphamodulefix.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN kernel-source-2.4.13.orig/arch/alpha/kernel/alpha_ksyms.c kernel-=
source-2.4.13/arch/alpha/kernel/alpha_ksyms.c
--- kernel-source-2.4.13.orig/arch/alpha/kernel/alpha_ksyms.c	Fri Oct 12 18=
:35:53 2001
+++ kernel-source-2.4.13/arch/alpha/kernel/alpha_ksyms.c	Sun Nov  4 18:12:4=
2 2001
@@ -257,3 +257,4 @@
 EXPORT_SYMBOL_NOVERS(memchr);
=20
 EXPORT_SYMBOL(get_wchan);
+EXPORT_SYMBOL(memscan);
diff -urN kernel-source-2.4.13.orig/drivers/sound/ymfpci.c kernel-source-2.=
4.13/drivers/sound/ymfpci.c
--- kernel-source-2.4.13.orig/drivers/sound/ymfpci.c	Mon Oct 22 11:38:18 20=
01
+++ kernel-source-2.4.13/drivers/sound/ymfpci.c	Sun Nov  4 18:12:56 2001
@@ -51,6 +51,7 @@
 #include <linux/soundcard.h>
 #include <linux/ac97_codec.h>
 #include <linux/sound.h>
+#include <linux/delay.h>
=20
 #include <asm/io.h>
 #include <asm/dma.h>

--sm4nu43k4a2Rpi4c--

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvmWvAACgkQwC4PkkOoPDau4ACfU9LDKHAADFn2HGJScsI2gSY8
nLEAn1U4fiuL6/dlBOfja0jy1DcyTS4e
=E6Os
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
