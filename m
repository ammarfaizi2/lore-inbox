Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUDGRbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUDGRbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:31:25 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:38434 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S263831AbUDGRbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:31:19 -0400
Date: Wed, 7 Apr 2004 12:31:16 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407173116.GB2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406173326.0fbb9d7a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 05:33:26PM -0700, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> >          dd(1) is convenient for this purpose, but is lacking a method
> > to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
> > enable this usage.
> 
> This would be rather nice to have.  You'll need to ensure that the data
> is page-aligned in memory.

So, some confusion on my part about O_DIRECT:  I can't get O_DIRECT to
work on ext3, at all, on 2.4.25 -- open(O_DIRECT) succeeds, but the write
returns EINVAL.  Same code works fine when writing to a block device.
If the problem is that ext3 can't support O_DIRECT, why does the open
succeed?

> While you're there, please add an fsync-before-closing option.

Easy enough.  How does this look?  Note that C_TWOBUFS ensures the
output buffer is getpagesize()-aligned.

The next feature to add would be OpenBSD-style "KB/s" reporting.  I'm
not going there.

-andy

2004-04-07  Andy Isaacson  <adi@hexapodia.org>

	* add conv=direct and conv=fsync options.

diff -ur coreutils-5.0.91/doc/coreutils.texi coreutils-5.0.91-adi/doc/coreutils.texi
--- coreutils-5.0.91/doc/coreutils.texi	2003-09-04 16:26:51.000000000 -0500
+++ coreutils-5.0.91-adi/doc/coreutils.texi	2004-04-07 11:26:36.000000000 -0500
@@ -6373,6 +6373,16 @@
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
 @end table
 
 @end table
diff -ur coreutils-5.0.91/src/dd.c coreutils-5.0.91-adi/src/dd.c
--- coreutils-5.0.91/src/dd.c	2003-07-25 02:43:09.000000000 -0500
+++ coreutils-5.0.91-adi/src/dd.c	2004-04-07 11:45:23.000000000 -0500
@@ -66,6 +66,9 @@
 /* Default input and output blocksize. */
 #define DEFAULT_BLOCKSIZE 512
 
+/* XXX hack */
+#define HAVE_O_DIRECT 1
+
 /* Conversions bit masks. */
 #define C_ASCII 01
 #define C_EBCDIC 02
@@ -78,6 +81,8 @@
 #define C_NOERROR 0400
 #define C_NOTRUNC 01000
 #define C_SYNC 02000
+#define C_FSYNC 010000
+#define C_DIRECT 020000
 /* Use separate input and output buffers, and combine partial input blocks. */
 #define C_TWOBUFS 04000
 
@@ -162,6 +167,10 @@
   {"noerror", C_NOERROR},	/* Ignore i/o errors. */
   {"notrunc", C_NOTRUNC},	/* Do not truncate output file. */
   {"sync", C_SYNC},		/* Pad input records to ibs with NULs. */
+  {"fsync", C_FSYNC},		/* call fsync(2) before closing output file */
+#ifdef HAVE_O_DIRECT
+  {"direct", C_DIRECT | C_TWOBUFS},	/* open files with O_DIRECT */
+#endif
   {NULL, 0}
 };
 
@@ -1190,6 +1199,11 @@
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
@@ -1240,5 +1254,11 @@
 
   exit_status = dd_copy ();
 
+  if (conversions_mask & C_FSYNC)
+    {
+      if (fsync (STDOUT_FILENO) != 0)
+	error(0, errno, _("cannot fsync %s"), quote (output_file));
+    }
+
   quit (exit_status);
 }
