Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbUKRCAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUKRCAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbUKQUlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:41:25 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3767 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262522AbUKQUjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:39:39 -0500
Message-Id: <200411171803.iAHI3wIG018055@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2-mm1 - detect-atomic-counter-underflows.patch
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1860354487P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Nov 2004 13:03:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1860354487P
Content-Type: text/plain; charset=us-ascii

Now, I *may* have simply shot myself in the foot, but when I tried booting
2.6.10-rc2-mm1, I got spewed *thousands* of messages triggered by this:

diff -puN include/asm-i386/atomic.h~detect-atomic-counter-underflows include/asm-i386/atomic.h
--- 25/include/asm-i386/atomic.h~detect-atomic-counter-underflows       Wed Nov  3 15:27:37 2004
+++ 25-akpm/include/asm-i386/atomic.h   Wed Nov  3 15:27:37 2004
@@ -132,6 +132,10 @@ static __inline__ int atomic_dec_and_tes
 {
        unsigned char c;
 
+       if (!atomic_read(v)) {
+               printk("BUG: atomic counter underflow at:\n");
+               dump_stack();
+       }
        __asm__ __volatile__(
                LOCK "decl %0; sete %1"
                :"=m" (v->counter), "=qm" (c)

Somehow, warning a *counter* is non-zero doesn't seem right (calling it an
underflow 4 times if the value goes 4, 3, 2, 1 and then NOT complain when it
hits zero?) , and I'm not flooded if it says:

	if (atomic_read(v) < 0) {

So is this code wrong, or did I introduce an now-detected underflow with some
self-inflicted patch that this is picking up?


--==_Exmh_-1860354487P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBm5KMcC3lWbTT17ARAkEqAJ908aVR9xFFlipq4V6XLx5WLueu2QCgtHGy
TOTsQ/IQ7QqzoDMNyc1ys2k=
=oTvN
-----END PGP SIGNATURE-----

--==_Exmh_-1860354487P--
