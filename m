Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTICUeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTICUdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:33:13 -0400
Received: from verein.lst.de ([212.34.189.10]:14021 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264388AbTICUcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:32:48 -0400
Date: Wed, 3 Sep 2003 22:32:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] fix ppc ioremap prototype
Message-ID: <20030903203231.GA8772@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, paulus@samba.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 44x merge fucked this up, bring it back in linux with the other
architectures.

/me still boggles how a patch like that could have sneaked in without
a review on lkml..


--- 1.13/arch/ppc/mm/pgtable.c	Wed Sep  3 14:16:34 2003
+++ edited/arch/ppc/mm/pgtable.c	Wed Sep  3 21:10:34 2003
@@ -119,9 +119,9 @@
 
 #ifndef CONFIG_44x
 void *
-ioremap(phys_addr_t addr, unsigned long size)
+ioremap(unsigned long addr, unsigned long size)
 {
-	return __ioremap(addr, size, _PAGE_NO_CACHE);
+	return __ioremap((phys_addr_t)addr, size, _PAGE_NO_CACHE);
 }
 #else /* CONFIG_44x */
 void *
@@ -131,9 +131,9 @@
 }
 
 void *
-ioremap(phys_addr_t addr, unsigned long size)
+ioremap(unsigned long addr, unsigned long size)
 {
-	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);;
+	phys_addr_t addr64 = fixup_bigphys_addr((phys_addr_t)addr, size);;
 
 	return ioremap64(addr64, size);
 }
--- 1.14/include/asm-ppc/io.h	Wed Sep  3 14:16:34 2003
+++ edited/include/asm-ppc/io.h	Wed Sep  3 21:13:40 2003
@@ -201,7 +201,7 @@
  */
 extern void *__ioremap(phys_addr_t address, unsigned long size,
 		       unsigned long flags);
-extern void *ioremap(phys_addr_t address, unsigned long size);
+extern void *ioremap(unsigned long address, unsigned long size);
 #ifdef CONFIG_44x
 extern void *ioremap64(unsigned long long address, unsigned long size);
 #endif
