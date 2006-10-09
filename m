Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWJIBJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWJIBJz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 21:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWJIBJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 21:09:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49634 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751576AbWJIBJy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 21:09:54 -0400
Date: Mon, 9 Oct 2006 02:09:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: it's OK to pass pointer to volatile as iounmap() argument...
Message-ID: <20061009010949.GJ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/mm/ioremap.c |    6 +++---
 include/asm-arm/io.h  |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 591fc31..4654405 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -361,14 +361,14 @@ __ioremap(unsigned long phys_addr, size_
 }
 EXPORT_SYMBOL(__ioremap);
 
-void __iounmap(void __iomem *addr)
+void __iounmap(volatile void __iomem *addr)
 {
 #ifndef CONFIG_SMP
 	struct vm_struct **p, *tmp;
 #endif
 	unsigned int section_mapping = 0;
 
-	addr = (void __iomem *)(PAGE_MASK & (unsigned long)addr);
+	addr = (volatile void __iomem *)(PAGE_MASK & (unsigned long)addr);
 
 #ifndef CONFIG_SMP
 	/*
@@ -395,6 +395,6 @@ #ifndef CONFIG_SMP
 #endif
 
 	if (!section_mapping)
-		vunmap(addr);
+		vunmap((void __force *)addr);
 }
 EXPORT_SYMBOL(__iounmap);
diff --git a/include/asm-arm/io.h b/include/asm-arm/io.h
index 8076a85..34aaaac 100644
--- a/include/asm-arm/io.h
+++ b/include/asm-arm/io.h
@@ -63,7 +63,7 @@ #define __raw_readl(a)		(__chk_io_ptr(a)
  */
 extern void __iomem * __ioremap_pfn(unsigned long, unsigned long, size_t, unsigned long);
 extern void __iomem * __ioremap(unsigned long, size_t, unsigned long);
-extern void __iounmap(void __iomem *addr);
+extern void __iounmap(volatile void __iomem *addr);
 
 /*
  * Bad read/write accesses...
-- 
1.4.2.GIT

