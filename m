Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268682AbUGXPon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbUGXPon (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUGXPon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:44:43 -0400
Received: from ozlabs.org ([203.10.76.45]:30411 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268682AbUGXPol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:44:41 -0400
Date: Sun, 25 Jul 2004 01:39:57 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ppc64 max_pfn issue
Message-ID: <20040724153957.GK4556@krispykreme>
References: <20040724044720.GF4556@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040724044720.GF4556@krispykreme>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I noticed excessive time in the pid hash functions on a ppc64 box. It
> turns out the pid hash is being sized way too small, eg on a 16GB box:

It turns out in the non NUMA case, max_low_pfn doesnt get initialised
until init_bootmem so we need to move initialisation of max_pfn below
it.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -u linux-2.5/arch/ppc64/mm/init.c foobar2/arch/ppc64/mm/init.c
--- linux-2.5/arch/ppc64/mm/init.c	2004-07-25 00:40:04.263577944 +1000
+++ foobar2/arch/ppc64/mm/init.c	2004-07-25 01:32:48.030807187 +1000
@@ -533,8 +533,6 @@
 	unsigned long total_pages = lmb_end_of_DRAM() >> PAGE_SHIFT;
 	int boot_mapsize;
 
-        max_pfn = max_low_pfn;
-
 	/*
 	 * Find an area to use for the bootmem bitmap.  Calculate the size of
 	 * bitmap required as (Total Memory) / PAGE_SIZE / BITS_PER_BYTE.
@@ -547,6 +545,8 @@
 
 	boot_mapsize = init_bootmem(start >> PAGE_SHIFT, total_pages);
 
+        max_pfn = max_low_pfn;
+
 	/* add all physical memory to the bootmem map. Also find the first */
 	for (i=0; i < lmb.memory.cnt; i++) {
 		unsigned long physbase, size;
