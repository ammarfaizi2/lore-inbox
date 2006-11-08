Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753129AbWKHAWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbWKHAWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 19:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbWKHAWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 19:22:02 -0500
Received: from gw.goop.org ([64.81.55.164]:36825 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1753391AbWKHAWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 19:22:00 -0500
Message-ID: <4551232A.4020203@goop.org>
Date: Tue, 07 Nov 2006 16:22:02 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix kunmap_atomic's use of kpte_clear_flush()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kunmap_atomic() will call kpte_clear_flush with vaddr/ptep arguments
which don't correspond if the vaddr is just a normal lowmem address
(ie, not in the KMAP area).  This patch makes sure that the pte is
only cleared if kmap area was actually used for the mapping.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/mm/highmem.c
+++ b/arch/i386/mm/highmem.c
@@ -56,22 +56,20 @@ void kunmap_atomic(void *kvaddr, enum km
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
-#ifdef CONFIG_DEBUG_HIGHMEM
-	if (vaddr >= PAGE_OFFSET && vaddr < (unsigned long)high_memory) {
-		pagefault_enable();
-		return;
-	}
-
-	if (vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx))
-		BUG();
-#endif
 	/*
 	 * Force other mappings to Oops if they'll try to access this pte
 	 * without first remap it.  Keeping stale mappings around is a bad idea
 	 * also, in case the page changes cacheability attributes or becomes
 	 * a protected page in a hypervisor.
 	 */
-	kpte_clear_flush(kmap_pte-idx, vaddr);
+	if (vaddr == __fix_to_virt(FIX_KMAP_BEGIN+idx))
+		kpte_clear_flush(kmap_pte-idx, vaddr);
+	else {
+#ifdef CONFIG_DEBUG_HIGHMEM
+		BUG_ON(vaddr < PAGE_OFFSET);
+		BUG_ON(vaddr >= (unsigned long)high_memory);
+#endif
+	}
 
 	pagefault_enable();
 }

