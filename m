Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTEYTWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 15:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTEYTWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 15:22:33 -0400
Received: from srv1.mail.cv.net ([167.206.112.40]:10701 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id S263688AbTEYTWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 15:22:32 -0400
Date: Sun, 25 May 2003 15:35:39 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Compile error in 2.5.69-bk18 + DRM + HIGHMEM
X-X-Sender: proski@localhost.localdomain
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk
Message-id: <Pine.LNX.4.44.0305251334580.14054-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm getting an error when compiling 2.5.69-bk18 with DRM and HIGHMEM
support for Athlon:

In file included from drivers/char/drm/radeon_drv.c:49:
drivers/char/drm/drm_memory.h: In function `drm_ioremapfree':
drivers/char/drm/drm_memory.h:170: `PKMAP_BASE' undeclared (first use in this function)
drivers/char/drm/drm_memory.h:170: (Each undeclared identifier is reported only once
drivers/char/drm/drm_memory.h:170: for each function it appears in.)

PKMAP_BASE is defined in include/asm-i386/highmem.h and is used in
include/asm-i386/pgtable.h to define VMALLOC_END, which is used in
drivers/char/drm/drm_memory.h

Unfortunately, including <asm/highmem.h> from pgtable.h doesn't help, and
I don't see how to untangle this dependency without changing many other
files:

In file included from include/asm/highmem.h:26,
                 from include/asm/pgtable.h:5,
                 from include/linux/mm.h:25,
                 from include/linux/pagemap.h:7,
                 from include/linux/blkdev.h:10,
                 from include/linux/blk.h:2,
                 from init/main.c:26:
include/asm/tlbflush.h: In function `flush_tlb_page':
include/asm/tlbflush.h:95: dereferencing pointer to incomplete type
include/asm/tlbflush.h: In function `flush_tlb_range':
include/asm/tlbflush.h:102: dereferencing pointer to incomplete type
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

This patch helps and it may be OK to apply because it only affects the 
file that has compile problems, i.e. drm_memory.h:

==========================
--- linux.orig/drivers/char/drm/drm_memory.h
+++ linux/drivers/char/drm/drm_memory.h
@@ -41,6 +41,7 @@
 #if __REALLY_HAVE_AGP
 
 #include <linux/vmalloc.h>
+#include <linux/highmem.h>
 
 #ifdef HAVE_PAGE_AGP
 #include <asm/agp.h>
==========================

-- 
Regards,
Pavel Roskin

