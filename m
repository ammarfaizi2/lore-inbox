Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTI0KGA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 06:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTI0KGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 06:06:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8929 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261719AbTI0KF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 06:05:57 -0400
Date: Sat, 27 Sep 2003 12:05:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Brian Gerst <bgerst@quark.didntduck.org>
Subject: [2.6 patch] select ZLIB_{IN,DE}FLATE
Message-ID: <20030927100551.GJ2881@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

similar to the patch Brian Gerst sent for CRC32, this patch changes
ZLIB_{IN,DE}FLATE to be select'ed.

IMHO, the dependencies are much better maintainable that way.

diffstat output:

 crypto/Kconfig      |    2 ++
 drivers/net/Kconfig |    2 ++
 fs/Kconfig          |    4 ++++
 fs/Kconfig.binfmt   |    1 +
 lib/Kconfig         |    7 +------
 5 files changed, 10 insertions(+), 6 deletions(-)


cu
Adrian

--- linux-2.6.0-test5/lib/Kconfig.old	2003-09-27 11:46:16.000000000 +0200
+++ linux-2.6.0-test5/lib/Kconfig	2003-09-27 11:53:15.000000000 +0200
@@ -13,18 +13,13 @@
 	  require M here.
 
 #
-# Do we need the compression support?
+# compression support is select'ed if needed
 #
 config ZLIB_INFLATE
 	tristate
-	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || BINFMT_ZFLAT=y || CRYPTO_DEFLATE=y
-	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || BINFMT_ZFLAT=m || CRYPTO_DEFLATE=m
 
 config ZLIB_DEFLATE
 	tristate
-	default m if PPP_DEFLATE!=y && JFFS2_FS!=y && CRYPTO_DEFLATE!=y && \
-		(PPP_DEFLATE=m || JFFS2_FS=m || CRYPTO_DEFLATE=m)
-	default y if PPP_DEFLATE=y || JFFS2_FS=y || CRYPTO_DEFLATE=y
 
 endmenu
 
--- linux-2.6.0-test5/fs/Kconfig.old	2003-09-27 11:47:11.000000000 +0200
+++ linux-2.6.0-test5/fs/Kconfig	2003-09-27 11:49:40.000000000 +0200
@@ -496,6 +496,7 @@
 config ZISOFS
 	bool "Transparent decompression extension"
 	depends on ISO9660_FS
+	select ZLIB_INFLATE
 	help
 	  This is a Linux-specific extension to RockRidge which lets you store
 	  data in compressed form on a CD-ROM and have it transparently
@@ -1047,6 +1048,8 @@
 	tristate "Journalling Flash File System v2 (JFFS2) support"
 	depends on MTD
 	select CRC32
+	select ZLIB_INFLATE
+	select ZLIB_DEFLATE
 	help
 	  JFFS2 is the second generation of the Journalling Flash File System
 	  for use on diskless embedded devices. It provides improved wear
@@ -1092,6 +1095,7 @@
 
 config CRAMFS
 	tristate "Compressed ROM file system support"
+	select ZLIB_INFLATE
 	help
 	  Saying Y here includes support for CramFs (Compressed ROM File
 	  System).  CramFs is designed to be a simple, small, and compressed
--- linux-2.6.0-test5/fs/Kconfig.binfmt.old	2003-09-27 11:59:57.000000000 +0200
+++ linux-2.6.0-test5/fs/Kconfig.binfmt	2003-09-27 12:00:44.000000000 +0200
@@ -36,6 +36,7 @@
 config BINFMT_ZFLAT
 	bool "Enable ZFLAT support"
 	depends on BINFMT_FLAT
+	select ZLIB_INFLATE
 	help
 	  Support FLAT format compressed binaries
 
--- linux-2.6.0-test5/drivers/net/Kconfig.old	2003-09-27 11:51:35.000000000 +0200
+++ linux-2.6.0-test5/drivers/net/Kconfig	2003-09-27 11:52:04.000000000 +0200
@@ -2268,6 +2268,8 @@
 config PPP_DEFLATE
 	tristate "PPP Deflate compression"
 	depends on PPP
+	select ZLIB_INFLATE
+	select ZLIB_DEFLATE
 	---help---
 	  Support for the Deflate compression method for PPP, which uses the
 	  Deflate algorithm (the same algorithm that gzip uses) to compress
--- linux-2.6.0-test5/crypto/Kconfig.old	2003-09-27 11:52:17.000000000 +0200
+++ linux-2.6.0-test5/crypto/Kconfig	2003-09-27 11:57:55.000000000 +0200
@@ -143,6 +143,8 @@
 config CRYPTO_DEFLATE
 	tristate "Deflate compression algorithm"
 	depends on CRYPTO
+	select ZLIB_INFLATE
+	select ZLIB_DEFLATE
 	help
 	  This is the Deflate algorithm (RFC1951), specified for use in
 	  IPSec with the IPCOMP protocol (RFC3173, RFC2394).
