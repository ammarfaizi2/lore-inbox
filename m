Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTH2QXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbTH2QXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:23:09 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36224 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261396AbTH2QW6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:22:58 -0400
Message-Id: <200308291622.h7TGMQGG010465@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm3 
In-Reply-To: Your message of "Fri, 29 Aug 2003 08:35:40 PDT."
             <20030829083540.58c9dd47.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <3F4F22D3.9080104@freemail.hu>
            <20030829083540.58c9dd47.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_445810014P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Aug 2003 12:22:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_445810014P
Content-Type: text/plain; charset=us-ascii

On Fri, 29 Aug 2003 08:35:40 PDT, Andrew Morton said:

> Meanwhile, I'll alter Valdis's patch so that it warns, but does not fail
> the make.
> 

I've sent Andrew an updated patch (attached) which issues a warning if the
final depmod actually fails.  The user won't know there's a problem till the
very end of 'make modules_install', but at least it will give them a hint of
where to go for self-help.  

--- Makefile.hold	2003-08-27 01:52:20.000000000 -0400
+++ Makefile	2003-08-29 11:52:15.542286300 -0400
@@ -209,7 +209,7 @@
 RPM 		:= $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo rpmbuild; \
 		    	else echo rpm; fi)
 GENKSYMS	= scripts/genksyms/genksyms
-DEPMOD		= /sbin/depmod
+DEPMOD		= /sbin/depmod.old
 KALLSYMS	= scripts/kallsyms
 PERL		= perl
 CHECK		= sparse
@@ -612,7 +612,14 @@
 endif
 .PHONY: _modinst_post
 _modinst_post: _modinst_
-	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+	@if [ -r System.map ]; then \
+		if ! $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE)   ; then \
+			echo "*** Depmod failed!!!"; \
+			echo "*** You may need to install a current version of module-init-tools"; \
+			echo "*** See http://www.codemonkey.org.uk/post-halloween-2.5.txt"; \
+			exit 1; \
+	 	fi \
+	fi
 
 else # CONFIG_MODULES
 



--==_Exmh_445810014P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/T33CcC3lWbTT17ARAoPVAKCERc4cvB5UaKK/lptZx/WZvet3gACeOuZw
axTKcjTY2rn1Wi/+vz8Dkig=
=faSS
-----END PGP SIGNATURE-----

--==_Exmh_445810014P--
