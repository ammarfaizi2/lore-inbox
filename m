Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWDXHU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWDXHU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWDXHU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:20:56 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:58635 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751010AbWDXHU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:20:56 -0400
Date: Mon, 24 Apr 2006 17:20:53 +1000
To: Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [NFSD]: Select things at the closest tristate instead of bool
Message-ID: <20060424072053.GA23449@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

I noticed recently that my CONFIG_CRYPTO_MD5 turned into a y again
instead of m.  It turns out that CONFIG_NFSD_V4 is selecting it.
In general when we have a bool sitting under a tristate it is
better to select things you need from the tristate rather than the
bool since that allows the things you select to be modules.

The following patch does it for nfsd.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfsd-md5-kconfig.patch"

diff --git a/fs/Kconfig b/fs/Kconfig
index f9b5842..7cb0210 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1431,8 +1431,13 @@
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
-	select NFS_ACL_SUPPORT if NFSD_V3_ACL || NFSD_V2_ACL
-	help
+	select NFSD_V2_ACL if NFSD_V3_ACL
+	select NFS_ACL_SUPPORT if NFSD_V2_ACL
+	select NFSD_TCP if NFSD_V4
+	select CRYPTO_MD5 if NFSD_V4
+	select CRYPTO if NFSD_V4
+	select FS_POSIX_ACL if NFSD_V4
+	help
 	  If you want your Linux box to act as an NFS *server*, so that other
 	  computers on your local network which support NFS can access certain
 	  directories on your box transparently, you have two options: you can
@@ -1469,7 +1474,6 @@
 config NFSD_V3_ACL
 	bool "Provide server support for the NFSv3 ACL protocol extension"
 	depends on NFSD_V3
-	select NFSD_V2_ACL
 	help
 	  Implement the NFSv3 ACL protocol extension for manipulating POSIX
 	  Access Control Lists on exported file systems. NFS clients should
@@ -1479,10 +1483,6 @@
 config NFSD_V4
 	bool "Provide NFSv4 server support (EXPERIMENTAL)"
 	depends on NFSD_V3 && EXPERIMENTAL
-	select NFSD_TCP
-	select CRYPTO_MD5
-	select CRYPTO
-	select FS_POSIX_ACL
 	help
 	  If you would like to include the NFSv4 server as well as the NFSv2
 	  and NFSv3 servers, say Y here.  This feature is experimental, and

--TB36FDmn/VVEgNH/--
