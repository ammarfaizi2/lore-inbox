Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUANTBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUANTBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:01:12 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:55448 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262965AbUANTBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:01:06 -0500
Message-ID: <400591EF.6090808@colorfullife.com>
Date: Wed, 14 Jan 2004 20:01:03 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH, BACKPORT] shrink address space reserved for kmap
Content-Type: multipart/mixed;
 boundary="------------000506070609080203050301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506070609080203050301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If highmem is enabled, 32 MB at the top of the address space is reserved 
for kmap. This is not necessary: the kmap area is at most 4 MB long, 
reserving 8 MB is sufficient (the last few kB are needed for the 
fixmaps, and the kmap area must be 4 MB-aligned). Recovering these 24 MB 
is important - it's increases the size of the vmalloc pool.
2.6 contains a similar patch.
The patch also adds a safety check to detect a collision between fixmap 
and kmap mappings - just in case someone uses huge fixmaps.

Marcelo, could you add it to your tree?

--
    Manfred

--------------000506070609080203050301
Content-Type: text/plain;
 name="patch-kmap-24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kmap-24"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 21
//  EXTRAVERSION = -pre2
--- 2.4/include/asm-i386/highmem.h	2002-08-03 02:39:45.000000000 +0200
+++ build-2.4/include/asm-i386/highmem.h	2003-01-06 00:39:15.000000000 +0100
@@ -46,7 +46,7 @@
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
-#define PKMAP_BASE (0xfe000000UL)
+#define PKMAP_BASE (0xff800000UL)
 #ifdef CONFIG_X86_PAE
 #define LAST_PKMAP 512
 #else
--- 2.4/arch/i386/mm/init.c	2003-01-05 21:19:06.000000000 +0100
+++ build-2.4/arch/i386/mm/init.c	2003-01-06 00:40:23.000000000 +0100
@@ -510,7 +510,15 @@
 
 	if (!mem_map)
 		BUG();
-	
+#ifdef CONFIG_HIGHMEM
+	/* check that fixmap and pkmap do not overlap */
+	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
+		printk(KERN_ERR "fixmap and kmap areas overlap - this will crash\n");
+		printk(KERN_ERR "pkstart: %lxh pkend: %lxh fixstart %lxh\n",
+				PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE, FIXADDR_START);
+		BUG();
+	}
+#endif
 	set_max_mapnr_init();
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);

--------------000506070609080203050301--

