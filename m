Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270445AbTG1Sx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbTG1Sx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:53:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:6632 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270445AbTG1SxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:53:22 -0400
Date: Mon, 28 Jul 2003 15:08:37 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: pmd_large vs. pmd_huge
Message-ID: <20030728150837.A29122@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at the 2.6.0-test2 to find out the difference between
large and huge pages, but it seems they are one and the same.
The ia64 only implements pmd_huge, so how about just going
with that everywhere? For starters, we can do this to strike
down an evil #ifdef:

diff -urN -X dontdiff linux-2.6.0-test1-bk2/mm/slab.c linux-2.6.0-test1-bk2-nip/mm/slab.c
--- linux-2.6.0-test1-bk2/mm/slab.c	2003-07-23 18:20:17.000000000 -0700
+++ linux-2.6.0-test1-bk2-nip/mm/slab.c	2003-07-28 11:58:46.000000000 -0700
@@ -91,6 +91,7 @@
 #include	<linux/cpu.h>
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
+#include	<linux/hugetlb.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -2728,12 +2729,10 @@
 			printk("No pmd.\n");
 			break;
 		}
-#ifdef CONFIG_X86
-		if (pmd_large(*pmd)) {
-			printk("Large page.\n");
+		if (pmd_huge(*pmd)) {
+			printk("Huge page.\n");
 			break;
 		}
-#endif
 		printk("normal page, pte_val 0x%llx\n",
 		  (unsigned long long)pte_val(*pte_offset_kernel(pmd, addr)));
 	} while(0);
