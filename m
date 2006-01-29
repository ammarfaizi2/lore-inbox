Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWA2U4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWA2U4x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWA2U4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:56:53 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:40296 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751056AbWA2U4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:56:53 -0500
Message-ID: <43DD2C15.1090800@cosmosbay.com>
Date: Sun, 29 Jan 2006 21:56:53 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH, V2] i386: instead of poisoning .init zone, change protection
 bits to force a fault
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com> <m17j8jfs03.fsf@ebiederm.dsl.xmission.com> <20060128235113.697e3a2c.akpm@osdl.org> <200601291620.28291.ioe-lkml@rameria.de> <20060129113312.73f31485.akpm@osdl.org> <43DD1FDC.4080302@cosmosbay.com> <20060129200504.GD28400@kvack.org>
In-Reply-To: <20060129200504.GD28400@kvack.org>
Content-Type: multipart/mixed;
 boundary="------------010906000103030105020403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010906000103030105020403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Chasing some invalid accesses to .init zone, I found that free_init_pages() 
was properly freeing the pages but virtual was still usable.

A poisoning (memset(page, 0xcc, PAGE_SIZE)) was done but this is not reliable.

A new config option DEBUG_INITDATA is introduced to mark this initdata as not 
present at all so that buggy code can trigger a fault.

This option is not meant for production machines because it may split one or 
two huge page (2MB or 4MB) into small pages and thus slow down kernel a bit.

(After that we could map non possible cpu percpu data to the initial 
percpudata that is included in .init and discarded in free_initmem())

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------010906000103030105020403
Content-Type: text/plain;
 name="i386_mm_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386_mm_init.patch"

--- a/arch/i386/Kconfig.debug	2006-01-29 22:30:10.000000000 +0100
+++ b/arch/i386/Kconfig.debug	2006-01-29 22:35:54.000000000 +0100
@@ -61,6 +61,18 @@
 	  portion of the kernel code won't be covered by a 2MB TLB anymore.
 	  If in doubt, say "N".
 
+config DEBUG_INITDATA
+	bool "Read/Write protect kernel init data structures"
+	depends on DEBUG_KERNEL
+	help
+	  The init data is normally freed when kernel has booted.
+	  Some code may still try to read or write to data in this area.
+	  If you say Y here, the kernel will mark this zone as not readable
+	  or writeable at all. Buggy code will then fault.
+	  This option may have a slight performance impact because a
+	  portion of the kernel code won't be covered by a 2MB TLB anymore.
+	  If in doubt, say "N".
+
 config 4KSTACKS
 	bool "Use 4Kb + 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
 	default y
--- a/arch/i386/mm/init.c	2006-01-25 10:17:24.000000000 +0100
+++ b/arch/i386/mm/init.c	2006-01-29 22:38:53.000000000 +0100
@@ -750,11 +750,18 @@
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
+#ifdef CONFIG_DEBUG_INITDATA
+		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
+#else
 		memset((void *)addr, 0xcc, PAGE_SIZE);
+#endif
 		free_page(addr);
 		totalram_pages++;
 	}
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
+#ifdef CONFIG_DEBUG_INITDATA
+	global_flush_tlb();
+#endif
 }
 
 void free_initmem(void)

--------------010906000103030105020403--
