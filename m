Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWA2UEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWA2UEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWA2UEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:04:45 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:33959 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751145AbWA2UEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:04:45 -0500
Message-ID: <43DD1FDC.4080302@cosmosbay.com>
Date: Sun, 29 Jan 2006 21:04:44 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: instead of poisoning .init zone, change protection
 bits to force a fault
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>	<20060128235113.697e3a2c.akpm@osdl.org>	<200601291620.28291.ioe-lkml@rameria.de> <20060129113312.73f31485.akpm@osdl.org>
In-Reply-To: <20060129113312.73f31485.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090501040707070002010900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501040707070002010900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chasing some invalid accesses to .init zone, I found that free_init_pages() 
was properly freeing the pages but virtual was still usable.

A poisoning (memset(page, 0xcc, PAGE_SIZE)) was done but this is not reliable.

Applying this patch at least in mm is a good thing...

(After that we could map non possible cpu percpu data to the initial 
percpudata that is included in .init and discarded in free_initmem())

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------090501040707070002010900
Content-Type: text/plain;
 name="i386_mm_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386_mm_init.patch"

--- linux-2.6.16-rc1-mm3/arch/i386/mm/init.c	2006-01-25 10:17:24.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/arch/i386/mm/init.c	2006-01-29 21:46:39.000000000 +0100
@@ -750,11 +750,12 @@
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
-		memset((void *)addr, 0xcc, PAGE_SIZE);
+               change_page_attr(virt_to_page(addr), 1, __pgprot(0));
 		free_page(addr);
 		totalram_pages++;
 	}
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
+	global_flush_tlb();
 }
 
 void free_initmem(void)

--------------090501040707070002010900--
