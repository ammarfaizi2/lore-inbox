Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbULTJCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbULTJCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbULTJCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:02:12 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:31641 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261247AbULTJBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:01:44 -0500
Message-ID: <41C69440.1090504@kolivas.org>
Date: Mon, 20 Dec 2004 19:58:40 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org> <41C682F1.20200@yahoo.com.au> <41C6876D.7070702@kolivas.org>
In-Reply-To: <41C6876D.7070702@kolivas.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig25CBECFB4CAF1DE0C94818B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25CBECFB4CAF1DE0C94818B0
Content-Type: multipart/mixed;
 boundary="------------000101020906020000080500"

This is a multi-part message in MIME format.
--------------000101020906020000080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Logistically what makes sense is if a timeout of 0 is used as a test 
> that completely disables it (avoids another sysctl too). In time for 
> 2.6.10 we should disable it by default until the regressions are better 
> understood. Tuning it into a useful "on" position can happen later and I 
> suspect requires more code.

This patch should have the desired effect.

Con

--------------000101020906020000080500
Content-Type: text/x-diff;
 name="disable_thrash_control.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disable_thrash_control.patch"

Index: linux-2.6.10-rc3/mm/rmap.c
===================================================================
--- linux-2.6.10-rc3.orig/mm/rmap.c	2004-12-06 13:14:01.000000000 +1100
+++ linux-2.6.10-rc3/mm/rmap.c	2004-12-20 19:54:42.416058897 +1100
@@ -395,6 +395,9 @@ int page_referenced(struct page *page, i
 {
 	int referenced = 0;
 
+	if (!swap_token_default_timeout)
+		ignore_token = 1;
+
 	if (page_test_and_clear_young(page))
 		referenced++;
 
Index: linux-2.6.10-rc3/mm/thrash.c
===================================================================
--- linux-2.6.10-rc3.orig/mm/thrash.c	2004-12-06 13:14:01.000000000 +1100
+++ linux-2.6.10-rc3/mm/thrash.c	2004-12-20 19:56:01.594602700 +1100
@@ -19,7 +19,10 @@ unsigned long swap_token_check;
 struct mm_struct * swap_token_mm = &init_mm;
 
 #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
-#define SWAP_TOKEN_TIMEOUT (HZ * 300)
+#define SWAP_TOKEN_TIMEOUT	0
+/*
+ * Currently disabled; Needs further code to work at HZ * 300.
+ */
 unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
 
 /*

--------------000101020906020000080500--

--------------enig25CBECFB4CAF1DE0C94818B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxpRAZUg7+tp6mRURAgywAKCFfgWFR43+OzvEnugWIlFgKiSsEQCgjlAE
er0W9Qq77Zc3gCehIOxEQyw=
=0Exx
-----END PGP SIGNATURE-----

--------------enig25CBECFB4CAF1DE0C94818B0--
