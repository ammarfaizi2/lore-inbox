Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTK2ODR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 09:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTK2ODR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 09:03:17 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:2199 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263764AbTK2ODL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 09:03:11 -0500
Message-ID: <3FC8A71A.6050101@colorfullife.com>
Date: Sat, 29 Nov 2003 15:03:06 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] nr_slab accounting fix
Content-Type: multipart/mixed;
 boundary="------------020003030309000508000609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020003030309000508000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

if alloc_slabmgmt fails, then kmem_freepages() calls sub_page_state(), 
altough nr_slab was not yet increased. The attached patch fixes that by 
moving the inc_page_state into kmem_getpages().
Could you add it to your next -mm kernel?

--
    Manfred

--------------020003030309000508000609
Content-Type: text/plain;
 name="patch-slab-counter"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-counter"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 0
//  EXTRAVERSION = -test11
--- 2.6/mm/slab.c	2003-11-29 09:46:35.000000000 +0100
+++ build-2.6/mm/slab.c	2003-11-29 14:50:06.000000000 +0100
@@ -812,6 +812,7 @@
 		int i = (1 << cachep->gfporder);
 		struct page *page = virt_to_page(addr);
 
+		add_page_state(nr_slab, i);
 		while (i--) {
 			SetPageSlab(page);
 			page++;
@@ -1608,7 +1609,6 @@
 	do {
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
-		inc_page_state(nr_slab);
 		page++;
 	} while (--i);
 
--- 2.6/include/linux/page-flags.h	2003-10-25 20:44:06.000000000 +0200
+++ build-2.6/include/linux/page-flags.h	2003-11-29 14:45:57.000000000 +0100
@@ -133,6 +133,7 @@
 
 #define inc_page_state(member)	mod_page_state(member, 1UL)
 #define dec_page_state(member)	mod_page_state(member, 0UL - 1)
+#define add_page_state(member,delta) mod_page_state(member, (delta))
 #define sub_page_state(member,delta) mod_page_state(member, 0UL - (delta))
 
 

--------------020003030309000508000609--

