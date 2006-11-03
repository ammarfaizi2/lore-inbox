Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752981AbWKCCk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbWKCCk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbWKCCk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:40:59 -0500
Received: from ns.suse.de ([195.135.220.2]:50097 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752969AbWKCCk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:40:58 -0500
From: Andi Kleen <ak@suse.de>
To: Amul Shah <amul.shah@unisys.com>
Subject: Re: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when reserving MP Tables located in high memory
Date: Fri, 3 Nov 2006 03:40:55 +0100
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
In-Reply-To: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611030340.55952.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 23:24, Amul Shah wrote:

> 
> The ACPI tables and MP Tables reside higher in memory.  When reserving
> memory with reserve_bootmem_generic, the function has a BUG panic if the
> memory location to reserve is above the top of memory.  The MP table is
> above the top of memory in a user defined memory map.

I think it would be cleaner to add a check in reserve_bootmem_generic
that just returns when pfn >= end_pfn && pfn < end_pfn_mapped

How about this patch? Does it work?

-Andi

Handle reserve_bootmem_generic beyond end_pfn

This can happen on kexec kernels with some configurations, in particularly
on Unisys ES7000 systems.

Analysis by Amul Shah 

Cc: Amul Shah <amul.shah@unisys.com>

Signed-off-by: Andi Kleen <ak@suse.de>

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

