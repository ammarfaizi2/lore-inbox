Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTB0Uwn>; Thu, 27 Feb 2003 15:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTB0Uwn>; Thu, 27 Feb 2003 15:52:43 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45444 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266091AbTB0Uwl>; Thu, 27 Feb 2003 15:52:41 -0500
Message-Id: <200302272102.h1RL2tJT014398@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: Thomas Molina <tmolina@cox.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [UPDATED PATCH] Re: 2.5.63 - if/ifdef janitor work - actual bug found.. 
In-Reply-To: Your message of "Thu, 27 Feb 2003 14:42:50 CST."
             <Pine.LNX.4.44.0302271440000.1074-100000@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0302271440000.1074-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1409932887P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Feb 2003 16:02:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1409932887P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <14388.1046379775.1@turing-police.cc.vt.edu>

On Thu, 27 Feb 2003 14:42:50 CST, Thomas Molina said:

> Why couldn't it be MAY_OWNER_OVERRIDE??? There are occurrences of 
> MAY_OWNER_OVERRIDE

Yes, but then the logic becomes:

#if (a | b | MAY_OWNER_OVERRIDE) & (c | d | MAY_OWNER_OVERRIDE)
#error ....
#endif
 
so it will *alway* error out.  Tried it, it #errored, I looked at it
more closely.  The logic there is that it wants to have the two sets
(SATTR, TRUNC, LOCK, LOCAL_ACCESS) and (READ, WRITE, EXEC, OVERRIDE) 
as disjoint sets of bits.

And yes, somebody else pointed out that the #error test probably needs
to be cleaned up too..

/Valdis

--- include/linux/nfsd/nfsd.h.dist	2003-02-24 14:06:01.000000000 -0500
+++ include/linux/nfsd/nfsd.h	2003-02-27 16:01:59.000000000 -0500
@@ -39,8 +39,8 @@
 #define MAY_LOCK		32
 #define MAY_OWNER_OVERRIDE	64
 #define	MAY_LOCAL_ACCESS	128 /* IRIX doing local access check on device special file*/
-#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAX_OWNER_OVERRIDE | MAY_LOCAL_ACCESS) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
-# error "please use a different value for MAY_SATTR or MAY_TRUNC or MAY_LOCK or MAY_OWNER_OVERRIDE."
+#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAY_LOCAL_ACCESS) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
+# error "please use a different value for MAY_SATTR or MAY_TRUNC or MAY_LOCK or MAY_LOCAL_ACCESS."
 #endif
 #define MAY_CREATE		(MAY_EXEC|MAY_WRITE)
 #define MAY_REMOVE		(MAY_EXEC|MAY_WRITE|MAY_TRUNC)


--==_Exmh_1409932887P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Xnz/cC3lWbTT17ARAnXbAKDhV3cXEo/cZYe02dkK31nfVmT9OQCggTJE
ZhHgoiSzkZE+S4DNEQSKSWI=
=UM2J
-----END PGP SIGNATURE-----

--==_Exmh_1409932887P--
