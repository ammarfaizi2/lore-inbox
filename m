Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135831AbRDTIuA>; Fri, 20 Apr 2001 04:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135827AbRDTItu>; Fri, 20 Apr 2001 04:49:50 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:55821
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S135832AbRDTItm>;
	Fri, 20 Apr 2001 04:49:42 -0400
Date: Fri, 20 Apr 2001 01:49:40 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        autofs@linux.kernel.org
Subject: Fix for SMP deadlock in autofs4
Message-ID: <20010420014940.F8578@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
	autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a fix for a potential deadlock in autofs4's expire routine.
It tries to use dput() while holding the dcache_lock.  This isn't a
problem in principle since dput() should only try to take the dcache_lock
when the counter makes a transition to zero, which can't happen in
this case.  Unfortunately the generic (and only) implementation of
atomic_dec_and_lock always takes the lock, so deadlocks.

Obviously, this only effects SMP.  UP's wise avoidance of spinlocks
saves it once again.

The simple solution is simply to replace dput() with atomic_dec().
The count can't reach zero because we did a dget_locked() and held
dcache_lock the whole time, so we never need to worry about the rest of
the dput() logic.

--- ../2.4/fs/autofs4/expire.c	Wed Jan 31 00:20:50 2001
+++ fs/autofs4/expire.c	Fri Apr 20 01:29:53 2001
@@ -223,7 +223,8 @@
 			mntput(p);
 			return dentry;
 		}
-		dput(d);
+
+		atomic_dec(&d->d_count); /* dput(), but we'll never hit zero */
 		mntput(p);
 	}
 	spin_unlock(&dcache_lock);

	J

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrf+CQACgkQf6p1nWJ6IgLy2gCfYxkeZks6pS8ZeI3KajQHsPV7
WigAoISarCrRCAdenygR4Hlsw55/zftC
=BRGC
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
