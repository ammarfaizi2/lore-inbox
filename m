Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbUDFWEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbUDFWEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:04:06 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:19763 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264043AbUDFWD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:03:59 -0400
Date: Tue, 6 Apr 2004 17:03:58 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: bug-coreutils@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: dd PATCH: add conv=direct
Message-ID: <20040406220358.GE4828@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-kernel:  is this patch horribly wrong?

On modern Linux, apparently the correct way to bypass the buffer cache
when writing to a block device is to open the block device with
O_DIRECT.  This enables, for example, the user to more easily force a
reallocation of a single sector of an IDE disk with a media error
(without overwriting anything but the 1k "sector pair" containing the
error).  dd(1) is convenient for this purpose, but is lacking a method
to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
enable this usage.

Alas, I don't do autoconf, so I hope someone else can add the
appropriate stanza to autoconfiscate HAS_O_DIRECT.

-andy

diff -ur coreutils-5.0.91/doc/coreutils.texi coreutils-5.0.91-adi/doc/coreutils.texi
--- coreutils-5.0.91/doc/coreutils.texi	2003-09-04 16:26:51.000000000 -0500
+++ coreutils-5.0.91-adi/doc/coreutils.texi	2004-04-06 13:48:54.000000000 -0500
@@ -6373,6 +6373,11 @@
 Pad every input block to size of @samp{ibs} with trailing zero bytes.
 When used with @samp{block} or @samp{unblock}, pad with spaces instead of
 zero bytes.
+
+@item direct
+@opindex direct
+Open the output file with O_DIRECT, avoiding (on Linux) using the buffer
+cache.
 @end table
 
 @end table
diff -ur coreutils-5.0.91/src/dd.c coreutils-5.0.91-adi/src/dd.c
--- coreutils-5.0.91/src/dd.c	2003-07-25 02:43:09.000000000 -0500
+++ coreutils-5.0.91-adi/src/dd.c	2004-04-06 13:44:09.000000000 -0500
@@ -66,6 +66,9 @@
 /* Default input and output blocksize. */
 #define DEFAULT_BLOCKSIZE 512
 
+/* XXX hack */
+#define HAVE_O_DIRECT 1
+
 /* Conversions bit masks. */
 #define C_ASCII 01
 #define C_EBCDIC 02
@@ -78,6 +81,7 @@
 #define C_NOERROR 0400
 #define C_NOTRUNC 01000
 #define C_SYNC 02000
+#define C_DIRECT 010000
 /* Use separate input and output buffers, and combine partial input blocks. */
 #define C_TWOBUFS 04000
 
@@ -162,6 +166,9 @@
   {"noerror", C_NOERROR},	/* Ignore i/o errors. */
   {"notrunc", C_NOTRUNC},	/* Do not truncate output file. */
   {"sync", C_SYNC},		/* Pad input records to ibs with NULs. */
+#ifdef HAVE_O_DIRECT
+  {"direct", C_DIRECT},		/* open files with O_DIRECT */
+#endif
   {NULL, 0}
 };
 
@@ -1190,6 +1197,11 @@
 	= (O_CREAT
 	   | (seek_records || (conversions_mask & C_NOTRUNC) ? 0 : O_TRUNC));
 
+#if HAVE_O_DIRECT
+      if (conversions_mask & C_DIRECT)
+	opts |= O_DIRECT;
+#endif
+
       /* Open the output file with *read* access only if we might
 	 need to read to satisfy a `seek=' request.  If we can't read
 	 the file, go ahead with write-only access; it might work.  */
