Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUIPXxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUIPXxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUIPXux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:50:53 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:56808 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268304AbUIPXtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:49:39 -0400
Subject: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [2/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095378662.5897.100.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 09:51:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2:

Disable trying to flush TLBs on other processors while they're frozen.
(Local TLBs are flushed on exit from the processor-freezer).

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/mm/highmem.c software-suspend-linux-2.6.9-rc1-rev3/mm/highmem.c
--- linux-2.6.9-rc1/mm/highmem.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/highmem.c	2004-09-09 19:36:24.000000000 +1000
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/hash.h>
 #include <linux/highmem.h>
+#include <linux/suspend.h>
 #include <asm/tlbflush.h>
 
 static mempool_t *page_pool, *isa_page_pool;
@@ -94,7 +95,12 @@
 
 		set_page_address(page, NULL);
 	}
-	flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
+#ifdef CONFIG_PM
+	if (software_suspend_state & SOFTWARE_SUSPEND_FREEZE_SMP)
+		__flush_tlb();
+	else
+#endif
+		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
 }
 
 static inline unsigned long map_new_virtual(struct page *page)

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

