Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTEWJpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTEWJpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:45:52 -0400
Received: from ip68-4-255-84.oc.oc.cox.net ([68.4.255.84]:6528 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S263986AbTEWJpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:45:50 -0400
Date: Fri, 23 May 2003 02:58:56 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: marcelo@conectiva.com.br, arjanv@redhat.com
Cc: alan@lxorguk.ukuu.org.uk, m.c.p@wolk-project.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH] *really* fix ioperm in 2.4
Message-ID: <20030523095856.GA2310@ip68-101-124-193.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous 2.4 ioperm fix is broken. This patch against 2.4.21-rc3
fixes the fix, so that ioperm actually works. The "fixed" ioperm was
only copying 1/4th of the bitmap, not the whole thing. The real-world
bug was that FCE Ultra (and possibly other svgalib apps) tended to
segfault rather than actually run.

This patch also backports the IO_BITMAP_BYTES #define from 2.5, because
IO_BITMAP_SIZE can be a mental booby trap in some contexts. If that's
too invasive, let me know, but IMO it makes the code cleaner and it's
an obviously correct change.

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.21-rc3/arch/i386/kernel/ioport.c linux-2.4.21-rc3-bkn1/arch/i386/kernel/ioport.c
--- linux-2.4.21-rc3/arch/i386/kernel/ioport.c	2003-05-22 23:04:48.000000000 -0700
+++ linux-2.4.21-rc3-bkn1/arch/i386/kernel/ioport.c	2003-05-23 02:10:23.000000000 -0700
@@ -81,7 +81,7 @@
 	if (tss->bitmap == IO_BITMAP_OFFSET) { /* already active? */
 		set_bitmap(tss->io_bitmap, from, num, !turn_on);
 	} else {
-		memcpy(tss->io_bitmap, t->io_bitmap, IO_BITMAP_SIZE);
+		memcpy(tss->io_bitmap, t->io_bitmap, IO_BITMAP_BYTES);
 		tss->bitmap = IO_BITMAP_OFFSET; /* Activate it in the TSS */
 	}
 
diff -ruN linux-2.4.21-rc3/arch/i386/kernel/process.c linux-2.4.21-rc3-bkn1/arch/i386/kernel/process.c
--- linux-2.4.21-rc3/arch/i386/kernel/process.c	2003-03-26 16:42:28.000000000 -0800
+++ linux-2.4.21-rc3-bkn1/arch/i386/kernel/process.c	2003-05-23 02:12:36.000000000 -0700
@@ -727,7 +727,7 @@
 			 * is not really acceptable.]
 			 */
 			memcpy(tss->io_bitmap, next->io_bitmap,
-				 IO_BITMAP_SIZE*sizeof(unsigned long));
+				 IO_BITMAP_BYTES);
 			tss->bitmap = IO_BITMAP_OFFSET;
 		} else
 			/*
diff -ruN linux-2.4.21-rc3/include/asm-i386/processor.h linux-2.4.21-rc3-bkn1/include/asm-i386/processor.h
--- linux-2.4.21-rc3/include/asm-i386/processor.h	2003-05-23 01:30:01.000000000 -0700
+++ linux-2.4.21-rc3-bkn1/include/asm-i386/processor.h	2003-05-23 02:08:15.000000000 -0700
@@ -281,6 +281,7 @@
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
  */
 #define IO_BITMAP_SIZE	32
+#define IO_BITMAP_BYTES (IO_BITMAP_SIZE * 4)
 #define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
 #define INVALID_IO_BITMAP_OFFSET 0x8000
 
