Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264140AbUDGUod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUDGUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:44:33 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:4451 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264140AbUDGUnm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:43:42 -0400
Date: Wed, 7 Apr 2004 15:43:41 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407204341.GF2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <20040407111841.78ae0021.akpm@osdl.org> <20040407192432.GD2814@hexapodia.org> <20040407123455.0de9ffa9.akpm@osdl.org> <20040407194727.GE2814@hexapodia.org> <20040407130308.7c7ec8dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407130308.7c7ec8dc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 01:03:08PM -0700, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> > I claim that O_DIRECT on of= is important because you just plain *can
> > not* do the minimal-sized IDE block scrub without it.  I don't yet see a
> > similar benefit to O_DIRECT on if= side.
> 
> If you want a block scrubber then write a block scrubber.

They exist.  They're a pain in the ass to find when you need one.  dd is
almost there; a small patch that might have a chance of getting accepted
upstream seemed like a reasonable time investment.

> If you want to add O_DIRECT support to dd then it should be implemented
> properly, and that means implementing it for both read and write.
> 
> In fact the user should be able to specify the read-O_DIRECT and the
> write-O_DIRECT independently - if for no other reason than that the source
> and dest filesytems may not both support O_DIRECT.

Of course if both directions are supported they must be independently
specifiable.  I just don't see a compelling use case for the input side.

Nevertheless, here you go.  Still needs some autoconfiscation.

2004-04-07  Andy Isaacson  <adi@hexapodia.org>

	* add conv=direct, conv=idirect, and conv=fsync options.

diff -u'rx*.1' coreutils-5.0.91/doc/coreutils.texi coreutils-5.0.91-adi/doc/coreutils.texi
--- coreutils-5.0.91/doc/coreutils.texi	2003-09-04 16:26:51.000000000 -0500
+++ coreutils-5.0.91-adi/doc/coreutils.texi	2004-04-07 15:24:17.000000000 -0500
@@ -6373,6 +6373,20 @@
 Pad every input block to size of @samp{ibs} with trailing zero bytes.
 When used with @samp{block} or @samp{unblock}, pad with spaces instead of
 zero bytes.
+
+@item fsync
+@opindex fsync
+Call @samp{fsync(2)} on the output file before exiting.  This ensures
+that the file data is written to permanent store.
+
+@item direct
+@opindex direct
+Open the output file with O_DIRECT, avoiding (on Linux) using the buffer
+cache.
+
+@item idirect
+@opindex idirect
+Open the input file with O_DIRECT, avoiding (on Linux) using the buffer
 @end table
 
 @end table
diff -u'rx*.1' coreutils-5.0.91/src/dd.c coreutils-5.0.91-adi/src/dd.c
--- coreutils-5.0.91/src/dd.c	2003-07-25 02:43:09.000000000 -0500
+++ coreutils-5.0.91-adi/src/dd.c	2004-04-07 15:23:24.000000000 -0500
@@ -66,6 +66,9 @@
 /* Default input and output blocksize. */
 #define DEFAULT_BLOCKSIZE 512
 
+/* XXX hack */
+#define HAVE_O_DIRECT 1
+
 /* Conversions bit masks. */
 #define C_ASCII 01
 #define C_EBCDIC 02
@@ -78,6 +81,9 @@
 #define C_NOERROR 0400
 #define C_NOTRUNC 01000
 #define C_SYNC 02000
+#define C_FSYNC 010000
+#define C_DIRECT 020000
+#define C_IDIRECT 040000
 /* Use separate input and output buffers, and combine partial input blocks. */
 #define C_TWOBUFS 04000
 
@@ -162,6 +168,11 @@
   {"noerror", C_NOERROR},	/* Ignore i/o errors. */
   {"notrunc", C_NOTRUNC},	/* Do not truncate output file. */
   {"sync", C_SYNC},		/* Pad input records to ibs with NULs. */
+  {"fsync", C_FSYNC},		/* call fsync(2) before closing output file */
+#ifdef HAVE_O_DIRECT
+  {"direct", C_DIRECT | C_TWOBUFS},	/* open output with O_DIRECT */
+  {"idirect", C_IDIRECT | C_TWOBUFS},	/* open input with O_DIRECT */
+#endif
   {NULL, 0}
 };
 
@@ -1177,7 +1188,14 @@
 
   if (input_file != NULL)
     {
-      if (open_fd (STDIN_FILENO, input_file, O_RDONLY, 0) < 0)
+      int opts = O_RDONLY;
+
+#if HAVE_O_DIRECT
+      if (conversions_mask & C_IDIRECT)
+	opts |= O_DIRECT;
+#endif
+
+      if (open_fd (STDIN_FILENO, input_file, opts, 0) < 0)
 	error (EXIT_FAILURE, errno, _("opening %s"), quote (input_file));
     }
   else
@@ -1190,6 +1208,11 @@
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
@@ -1240,5 +1263,11 @@
 
   exit_status = dd_copy ();
 
+  if (conversions_mask & C_FSYNC)
+    {
+      if (fsync (STDOUT_FILENO) != 0)
+	error(0, errno, _("cannot fsync %s"), quote (output_file));
+    }
+
   quit (exit_status);
 }
