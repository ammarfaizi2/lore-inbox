Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbUKXNEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbUKXNEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbUKXNDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:03:52 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41876 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262649AbUKXNBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:30 -0500
Subject: Suspend 2 merge: 13/51: Disable highmem tlb flush for copyback.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101294761.5805.241.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we're making/restoring our atomic copy of the image, secondary
processors are frozen. Trying an SMP call at that time could thus lead
to deadlock. Secondary processors have their tlbs unconditionally
flushed when leaving the processor refrigerator, so this doesn't come
back to bite us.


diff -ruN 502-disable-highmem-tlb-flush-for-copyback-old/mm/highmem.c 502-disable-highmem-tlb-flush-for-copyback-new/mm/highmem.c
--- 502-disable-highmem-tlb-flush-for-copyback-old/mm/highmem.c	2004-11-03 21:54:14.000000000 +1100
+++ 502-disable-highmem-tlb-flush-for-copyback-new/mm/highmem.c	2004-11-04 16:27:40.000000000 +1100
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/hash.h>
 #include <linux/highmem.h>
+#include <linux/suspend.h>
 #include <asm/tlbflush.h>
 
 static mempool_t *page_pool, *isa_page_pool;
@@ -94,7 +95,10 @@
 
 		set_page_address(page, NULL);
 	}
-	flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
+	if (test_suspend_state(SUSPEND_FREEZE_SMP))
+		__flush_tlb();
+	else
+		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
 }
 
 static inline unsigned long map_new_virtual(struct page *page)


