Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUBRA36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUBRA3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:29:30 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:34021 "EHLO
	dagoban.timesys") by vger.kernel.org with ESMTP id S266850AbUBRA1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:27:47 -0500
Subject: [PATCH] sprintf modifiers in usr/gen_init_cpio.c
From: Pragnesh Sampat <pragnesh.sampat@timesys.com>
To: bos@serpentine.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1077063980.9721.22.camel@dagoban.timesys>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Feb 2004 19:26:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file initramfs_data.cpio is slightly different when generated on
cygwin, compared to linux, which causes the kernel to panic with the
message "no cpio magic" (See Documentation/early-userspace/README).

The problem in cpio generation is due to the difference in sprintf
modifiers on cygwin.  The code uses "%08ZX" for strlen of a device
node.  printf man pages discourages "Z" and has 'z' instead.
Both of these are not available on cygwin sprintf (at least some
versions of cygwin).  The net result of all of this is that the
generated file literally contains "ZX" and then the strlen after that
and messes up that 110 offset etc.  The file is 516 bytes long on the
system that I tested and on linux it is 512 bytes.

The fix below just uses "%08X" for that field.  Any basic portable
modifier should be ok, I think.

-Pragnesh
	
--- usr/gen_init_cpio.c-orig
+++ usr/gen_init_cpio.c

@@ -56,7 +56,7 @@
 	const char name[] = "TRAILER!!!";
 
 	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		0,			/* ino */
 		0,			/* mode */
@@ -87,7 +87,7 @@
 	time_t mtime = time(NULL);
 
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		S_IFDIR | mode,		/* mode */
@@ -119,7 +119,7 @@
 		mode |= S_IFCHR;
 
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
@@ -176,7 +176,7 @@
 	}
 
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */


