Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266693AbUBMDOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266694AbUBMDOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:14:43 -0500
Received: from h80ad26e2.async.vt.edu ([128.173.38.226]:33130 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266693AbUBMDOk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:14:40 -0500
Message-Id: <200402130314.i1D3EVNr030347@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with emu10k1 and gcc-3.4 
In-Reply-To: Your message of "Fri, 13 Feb 2004 00:18:02 +0100."
             <20040212231802.GG4092@werewolf.able.es> 
From: Valdis.Kletnieks@vt.edu
References: <20040212231802.GG4092@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1969030048P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 22:14:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1969030048P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 00:18:02 +0100, "J.A. Magallon" <jamagallon@able.es>  said:
> Hi al...
> 
> I have tried to build 2.6.3-rc2-mm1 with gcc-3.4, and it works apart from thi
s:

> emu10k1: Unknown symbol strcpy
> 

Alternate fix for a similar problem I hit is appended.  Basically, if
gcc-3.4 fails to inline all of them, we need to have a copy that's visible
from a module.

(Oh, the '#undef memcmp' was needed because memcmp was #defined to
__inline_memcmp so the wrong thing got EXPORT_SYMBOL'ed...)

I'll submit an extended patch that does all of string.c if people think
it's a good idea.

--- linux-2.6.2-rc1-mm1/lib/string.c.dist	2004-01-22 17:20:00.859598882 -0500
+++ linux-2.6.2-rc1-mm1/lib/string.c	2004-01-22 17:29:43.316730389 -0500
@@ -501,6 +501,9 @@
 #endif
 
 #ifndef __HAVE_ARCH_MEMCMP
+#ifdef memcmp
+#undef memcmp
+#endif
 /**
  * memcmp - Compare two areas of memory
  * @cs: One area of memory
@@ -517,6 +520,7 @@
 			break;
 	return res;
 }
+EXPORT_SYMBOL(memcmp);
 #endif
 
 #ifndef __HAVE_ARCH_MEMSCAN



--==_Exmh_1969030048P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALEEUcC3lWbTT17ARAtDqAKDrJ/9WQKu7nJZQvoyRY7s//oag0ACcCppQ
QTydB5yoOGe5sB+m8ys9L2o=
=x0jk
-----END PGP SIGNATURE-----

--==_Exmh_1969030048P--
