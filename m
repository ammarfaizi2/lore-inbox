Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUHZKCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUHZKCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUHZKB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:01:27 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:42368
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S268034AbUHZJyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:54:46 -0400
To: akpm@osdl.org
Subject: [PATCH] i386 bootmem restrictions
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Message-Id: <E1C0Gxq-00039Q-DE@localhost.localdomain>
From: Andy Whitcroft <apw@shadowen.org>
Date: Thu, 26 Aug 2004 10:54:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bootmem allocator is initialised before the kernel virtual address space
has been fully established.  As a result, any allocations which are made
before paging_init() has completed may point to invalid kernel addresses.
This patch notes this limitation and indicates where the allocator is
fully available.

Revision: $Rev: 572 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 100-ia32_bootmem
---
 setup.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/kernel/setup.c current/arch/i386/kernel/setup.c
--- reference/arch/i386/kernel/setup.c	2004-08-25 12:13:32.000000000 +0100
+++ current/arch/i386/kernel/setup.c	2004-08-26 10:27:59.000000000 +0100
@@ -1350,7 +1350,12 @@ void __init setup_arch(char **cmdline_p)
 
 	/*
 	 * NOTE: before this point _nobody_ is allowed to allocate
-	 * any memory using the bootmem allocator.
+	 * any memory using the bootmem allocator.  Although the
+	 * alloctor is now initialised only the first 8Mb of the kernel
+	 * virtual address space has been mapped.  All allocations before
+	 * paging_init() has completed must use the alloc_bootmem_low_pages()
+	 * variant (which allocates DMA'able memory) and care must be taken
+	 * not to exceed the 8Mb limit.
 	 */
 
 #ifdef CONFIG_SMP
@@ -1358,6 +1363,10 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	paging_init();
 
+	/*
+	 * NOTE: at this point the bootmem allocator is fully available.
+	 */
+
 #ifdef CONFIG_EARLY_PRINTK
 	{
 		char *s = strstr(*cmdline_p, "earlyprintk=");
