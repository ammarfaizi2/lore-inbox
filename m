Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbULBQal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbULBQal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbULBQal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:30:41 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:43960 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261665AbULBQaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:30:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kmAftAoE93iLPNhiTYKKBp0WRR/N7CHyHJcqvJ6k0svjzaS3RM9WUFwHc/31vkqLzeyelGh3jdxF5+VHYqCsHSgez7Da7ELsp0bwzgn/qVNwIjidDSyQT8mH5oZtvwkNdFcoPGWx6LVyEWz3J+/GF0pHNP2GBT2XYRLn9f5rReM=
Message-ID: <3b2b320041202082812ee4709@mail.gmail.com>
Date: Thu, 2 Dec 2004 11:28:53 -0500
From: Linh Dang <dang.linh@gmail.com>
Reply-To: Linh Dang <dang.linh@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3b2b32004120206497a471367@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3b2b32004120206497a471367@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.9 on non-APUS ppc32 platforms, virt_to_bus() will just subtract
KERNELBASE  from the the virtual address. bus_to_virt() will perform
the reverse operation.

This patch will make virt_to_bus():

     - perform the current operation if the virtual address is between
       KERNELBASE and ioremap_bot.

     - use iopa() (as on APUS platform) otherwise.

The patch will make bus_to_virt():

     - perform the current operation if the bus address is between
       PCI_DRAM_OFFSET and (ioremap_bot - KERNELBASE + PCI_DRAM_OFFSET).

     - use mm_ptov() (as on APUS platform) otherwise.


The patch also changes virt_to_phys()/phys_to_virt() in a similar way.

--  Linh Dang




--- include/asm-ppc/io.h~2.6.9	2004-11-12 14:24:46.000000000 -0500
+++ include/asm-ppc/io.h	2004-12-02 11:20:21.000000000 -0500
@@ -6,10 +6,11 @@
 #include <linux/types.h>
 
 #include <asm/page.h>
 #include <asm/byteorder.h>
 #include <asm/mmu.h>
+#include <asm/pgtable.h>
 
 #define SIO_CONFIG_RA	0x398
 #define SIO_CONFIG_RD	0x399
 
 #define SLOW_DOWN_IO
@@ -222,49 +223,56 @@ extern void io_block_mapping(unsigned lo
  * have to be modified [mapped] appropriately.
  */
 extern inline unsigned long virt_to_bus(volatile void * address)
 {
 #ifndef CONFIG_APUS
-        if (address == (void *)0)
+	if (unlikely(address == (void *)0))
 		return 0;
+	if (likely((address >= (void*) KERNELBASE) &&
+		   (address < ((void*) ioremap_bot))))
         return (unsigned long)address - KERNELBASE + PCI_DRAM_OFFSET;
-#else
-	return iopa ((unsigned long) address);
+	else
 #endif
+		return iopa ((unsigned long) address);
 }
 
 extern inline void * bus_to_virt(unsigned long address)
 {
 #ifndef CONFIG_APUS
-        if (address == 0)
+	if (unlikely (address == 0))
 		return NULL;
+	if (likely((address >= PCI_DRAM_OFFSET) &&
+		   (address < (ioremap_bot - KERNELBASE + PCI_DRAM_OFFSET))))
         return (void *)(address - PCI_DRAM_OFFSET + KERNELBASE);
-#else
-	return (void*) mm_ptov (address);
+	else
 #endif
+		return (void*) mm_ptov (address);
 }
 
 /*
  * Change virtual addresses to physical addresses and vv, for
  * addresses in the area where the kernel has the RAM mapped.
  */
 extern inline unsigned long virt_to_phys(volatile void * address)
 {
 #ifndef CONFIG_APUS
+	if (likely((address >= (void*) KERNELBASE) &&
+		   (address < ((void*) ioremap_bot))))
 	return (unsigned long) address - KERNELBASE;
-#else
-	return iopa ((unsigned long) address);
+	else
 #endif
+                return iopa ((unsigned long) address);
 }
 
 extern inline void * phys_to_virt(unsigned long address)
 {
 #ifndef CONFIG_APUS
+	if (likely(address < (ioremap_bot - KERNELBASE)))
 	return (void *) (address + KERNELBASE);
-#else
-	return (void*) mm_ptov (address);
+	else
 #endif
+                return (void*) mm_ptov (address);
 }
 
 /*
  * Change "struct page" to physical address.
  */
