Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSCOW5z>; Fri, 15 Mar 2002 17:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293452AbSCOW5p>; Fri, 15 Mar 2002 17:57:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:42748 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293448AbSCOW5d>; Fri, 15 Mar 2002 17:57:33 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200203152257.g2FMv9h10896@eng2.beaverton.ibm.com>
Subject: [PATCH] page_to_phys() fix for >4GB pages (i386)
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        alan@lxorguk.ukuu.org.uk, axboe@suse.de, andrea@suse.de
Date: Fri, 15 Mar 2002 14:57:09 -0800 (PST)
Cc: pbadari@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that page_to_phys() is broken for pages > 4GB on x86.
It is truncating the physical addresses to 32bit, loosing higher
bits. (pci_map_sg() uses this).

Here is the patch to fix it. Marcelo, could you consider this
patch ? I have not looked at 2.5 yet, it may be needed there also.

Thanks,
Badari


--- linux/include/asm-i386/io.h Fri Mar 15 11:19:28 2002
+++ linux.new/include/asm-i386/io.h     Fri Mar 15 11:20:38 2002
@@ -76,7 +76,11 @@
 /*
  * Change "struct page" to physical address.
  */
+#ifdef CONFIG_HIGHMEM64G
+#define page_to_phys(page)     ((u64)(page - mem_map) << PAGE_SHIFT)
+#else
 #define page_to_phys(page)     ((page - mem_map) << PAGE_SHIFT)
+#endif

 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);



