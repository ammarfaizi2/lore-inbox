Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbSLWUBX>; Mon, 23 Dec 2002 15:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbSLWUBX>; Mon, 23 Dec 2002 15:01:23 -0500
Received: from splat.lanl.gov ([128.165.17.254]:61333 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S266962AbSLWUBV>; Mon, 23 Dec 2002 15:01:21 -0500
Date: Mon, 23 Dec 2002 13:09:31 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rwhron@earthlink.net
Subject: [idiotic patch, RFH] qlogicfc error "this should not happen", again
Message-ID: <20021223200931.GT23388@lanl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9hshNW4m6zn79FF/"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9hshNW4m6zn79FF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi-

Back in August, A couple people (at least rwhron@earthlink.net and myself)
were getting lock-ups with the qlogic driver in 2.5.31; a patch was posted
that apparently fixed rwhron's problems. While it decreased mine from crash=
ing
1-2 times a week to once a month, it didn't solve them. Over the past four
months I've still had three hard lock-ups. All occur under high load--
weekly mirroring of Debian archive for LANL. I've CCed him on this message,
maybe he'll have comments...

Any advice on how to debug this from the kernel gurus? Somewhere we seem to
be leaking handles.

The kernel is 2.5.44, but there have been no significant changes to any
of the qlogic files between .44 and .52. The memory in the box is solid
(memtest86) and the disks have never given me any errors. Unfortunately,
I don't know how to do any diagnostics on the qlogic card...

Right now, I just added the following patch because otherwise I have to come
in and physically power cycle the box to bring it back up. Even with ext3,
that's a bad thing.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
--- ./qlogicfc.c.20021223	Mon Dec 23 12:32:57 2002
+++ ./qlogicfc.c	Mon Dec 23 12:38:11 2002
@@ -1135,6 +1135,7 @@
  * interrupt handler may call this routine as part of
  * request-completion handling).
  */
+extern int panic_timeout;
 int isp2x00_queuecommand(Scsi_Cmnd * Cmnd, void (*done) (Scsi_Cmnd *))
 {
 	int i, sg_count, n, num_free;
@@ -1228,6 +1229,13 @@
 				printk("slot %d has %p\n", i, hostdata->handle_ptrs[i]);
 			}
 		}
+		/* When we hit this, the machine locks up hard anyway.
+		 * Big red button is the only fix.
+		 * Panic & reboot; we've got nothing to lose. */
+		panic_timeout=3D10;
+		panic("Hard lock-up 'avoided' via percussive maintenance (big sledgehamm=
er mode)\n");
+
+		/* never reached */
 		return 1;
 	}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

References:
    (The original thread)
    http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.2/1264.html
    (The patch that doesn't work for me)
    http://www.ussg.iu.edu/hypermail/linux/kernel/0209.0/0467.html


Thanks,
-Eric

--=20
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------

--9hshNW4m6zn79FF/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+B2171LDXWFnqnE8RAiEFAJ9lhSQRHGhNOXfLycg4NJ1F4w/ymwCgxrEF
bb0PMJvZSkjw0N/kcp7z5Ho=
=7rkG
-----END PGP SIGNATURE-----

--9hshNW4m6zn79FF/--
