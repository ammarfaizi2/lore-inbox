Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSGILxI>; Tue, 9 Jul 2002 07:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSGILxH>; Tue, 9 Jul 2002 07:53:07 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:17590 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314514AbSGILxG>; Tue, 9 Jul 2002 07:53:06 -0400
Date: Tue, 9 Jul 2002 13:55:34 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix iounmap for non page aligned addresses
Message-ID: <20020709135534.A1155@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This fixes a problem introduced by the pageattr ioremap/unmap patches.
iounmap lost the ability to free non page aligned addresses, which
are e.g. used by the bootflag code.  This patch fixes this.

Also fix a potential off by one bug.

-Andi



--- linux-work/arch/i386/mm/ioremap.c.~2~	Tue Jun 18 02:13:09 2002
+++ linux/arch/i386/mm/ioremap.c	Fri Jun 21 14:42:23 2002
@@ -213,9 +213,9 @@
 void iounmap(void *addr)
 { 
 	struct vm_struct *p;
-	if (addr < high_memory) 
+	if (addr <= high_memory) 
 		return; 
-	p = remove_kernel_area(addr); 
+	p = remove_kernel_area(PAGE_MASK & (unsigned long) addr); 
 	if (!p) { 
 		printk("__iounmap: bad address %p\n", addr);
 		return;
