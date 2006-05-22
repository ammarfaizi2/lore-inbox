Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWEVLiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWEVLiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWEVLiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:38:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64705 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750767AbWEVLiv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:38:51 -0400
Message-Id: <200605221138.k4MBcgd2006492@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Michael Buesch <mb@bu3sch.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3
In-Reply-To: Your message of "Mon, 22 May 2006 13:25:10 +0200."
             <200605221325.10761.mb@bu3sch.de>
From: Valdis.Kletnieks@vt.edu
References: <20060522022709.633a7a7f.akpm@osdl.org> <200605221115.k4MBFq42013901@turing-police.cc.vt.edu>
            <200605221325.10761.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148297922_6073P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 07:38:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148297922_6073P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 May 2006 13:25:10 +0200, Michael Buesch said:
> On Monday 22 May 2006 13:15, you wrote:

> > It looks to me line the old code stayed in a while() loop in rng_dev_read
> > until it had fulfilled the read request (including possibly multiple
> > calls to need_resched() and friends).  The new code will bail on an -EAGAIN
> > as soon as the *first* poll fails, rather than waiting until something
> > is available - even if it is NOT flagged O_NONBLOCK.
> 
> Yeah. That is how it works. I am wondering why userspace doesn't
> simply retry, if it receives an EAGAIN.
> Should we return ERESTARTSYS or something like that instead?

That's not the way it worked in previous kernels, and it's not the way that
the current rng-utils RPM in Fedora expects it to work.

Here's a patch that makes it work the way it used to.  Adding the test
for O_NONBLOCK is the biggie - the old code did a resched test at that
point in the loop, so I added it here too.

--- linux-2.6.17-rc4-mm3/drivers/char/hw_random/core.c.rnd_fix	2006-05-22 07:23:34.000000000 -0400
+++ linux-2.6.17-rc4-mm3/drivers/char/hw_random/core.c	2006-05-22 07:22:29.000000000 -0400
@@ -125,7 +125,7 @@ static ssize_t rng_dev_read(struct file 
 		mutex_unlock(&rng_mutex);
 
 		err = -EAGAIN;
-		if (!bytes_read)
+		if (filp->f_flags & O_NONBLOCK && !bytes_read)
 			goto out;
 
 		err = -EFAULT;
@@ -138,6 +138,9 @@ static ssize_t rng_dev_read(struct file 
 			data >>= 8;
 		}
 
+		if (need_resched())
+                        schedule_timeout_interruptible(1);
+
 		if (signal_pending(current))
 			goto out;
 	}


--==_Exmh_1148297922_6073P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEcaLCcC3lWbTT17ARAtDgAJ0eN8mC5G3fA5OaILlyEPsqgdjFTwCg4gQB
RWCvJAJ8ghzWTpx1h82kj54=
=7onI
-----END PGP SIGNATURE-----

--==_Exmh_1148297922_6073P--
