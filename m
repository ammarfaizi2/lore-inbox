Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966145AbWKNQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966145AbWKNQJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966140AbWKNQJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:09:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:12687 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933453AbWKNQJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:09:02 -0500
From: Andi Kleen <ak@suse.de>
References: <20061114508.445749000@suse.de>
In-Reply-To: <20061114508.445749000@suse.de>
To: Amul Shah <amul.shah@unisys.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [4/9] x86_64: Handle reserve_bootmem_generic beyond end_pfn
Message-Id: <20061114160854.AFF6613D29@wotan.suse.de>
Date: Tue, 14 Nov 2006 17:08:54 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This can happen on kexec kernels with some configurations, in particularly
on Unisys ES7000 systems.

Analysis by Amul Shah 

Cc: Amul Shah <amul.shah@unisys.com>

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/mm/init.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/mm/init.c
===================================================================
--- linux.orig/arch/x86_64/mm/init.c
+++ linux/arch/x86_64/mm/init.c
@@ -655,9 +655,22 @@ void free_initrd_mem(unsigned long start
 
 void __init reserve_bootmem_generic(unsigned long phys, unsigned len) 
 { 
-	/* Should check here against the e820 map to avoid double free */ 
 #ifdef CONFIG_NUMA
 	int nid = phys_to_nid(phys);
+#endif
+	unsigned long pfn = phys >> PAGE_SHIFT;
+	if (pfn >= end_pfn) {
+		/* This can happen with kdump kernels when accessing firmware
+		   tables. */
+		if (pfn < end_pfn_map)
+			return;
+		printk(KERN_ERR "reserve_bootmem: illegal reserve %lx %u\n",
+				phys, len);
+		return;
+	}
+
+	/* Should check here against the e820 map to avoid double free */
+#ifdef CONFIG_NUMA
   	reserve_bootmem_node(NODE_DATA(nid), phys, len);
 #else       		
 	reserve_bootmem(phys, len);    
