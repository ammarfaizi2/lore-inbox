Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263483AbTCNT7O>; Fri, 14 Mar 2003 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263484AbTCNT7O>; Fri, 14 Mar 2003 14:59:14 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:5104 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S263483AbTCNT7L>; Fri, 14 Mar 2003 14:59:11 -0500
Message-ID: <3E723705.3010800@quark.didntduck.org>
Date: Fri, 14 Mar 2003 15:09:41 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ioperm() fix
Content-Type: multipart/mixed;
 boundary="------------090805090707070707040501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090805090707070707040501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Properly initialize the IO bitmap in the TSS on the first ioperm() call.

--
				Brian Gerst

--------------090805090707070707040501
Content-Type: text/plain;
 name="iobitmap-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iobitmap-1"

diff -urN linux-2.5.64-bk5/arch/i386/kernel/ioport.c linux/arch/i386/kernel/ioport.c
--- linux-2.5.64-bk5/arch/i386/kernel/ioport.c	2003-02-24 14:59:03.000000000 -0500
+++ linux/arch/i386/kernel/ioport.c	2003-03-14 10:19:48.000000000 -0500
@@ -84,15 +84,17 @@
 		t->ts_io_bitmap = bitmap;
 	}
 
-	tss = init_tss + get_cpu();
-	if (bitmap)
-		tss->bitmap = IO_BITMAP_OFFSET;	/* Activate it in the TSS */
-
 	/*
 	 * do it in the per-thread copy and in the TSS ...
 	 */
 	set_bitmap(t->ts_io_bitmap, from, num, !turn_on);
-	set_bitmap(tss->io_bitmap, from, num, !turn_on);
+	tss = init_tss + get_cpu();
+	if (tss->bitmap == IO_BITMAP_OFFSET) { /* already active? */
+		set_bitmap(tss->io_bitmap, from, num, !turn_on);
+	} else {
+		memcpy(tss->io_bitmap, t->ts_io_bitmap, IO_BITMAP_BYTES);
+		tss->bitmap = IO_BITMAP_OFFSET;	/* Activate it in the TSS */
+	}
 	put_cpu();
 out:
 	return ret;

--------------090805090707070707040501--

