Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030677AbWF0EjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030677AbWF0EjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbWF0EjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:19 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23515 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030677AbWF0EjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:14 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/10] [Suspend2] Atomic copy routine
Date: Tue, 27 Jun 2006 14:39:13 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043912.14546.41377.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When suspending, this routine is used to make the atomic copy of memory.
Like swsusp, it is done in C.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index cb3663c..75e3beb 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -302,3 +302,50 @@ int suspend_post_context_save(void)
 	return 0;
 }
 
+/* suspend_copy_pageset1: Do the atomic copy of pageset1.
+ *
+ * Make the atomic copy of pageset1. We can't use copy_page (as we once did)
+ * because we can't be sure what side effects it has. On my old Duron, with
+ * 3DNOW, kernel_fpu_begin increments preempt count, making our preempt
+ * count at resume time 4 instead of 3.
+ * 
+ * We don't want to call kmap_atomic unconditionally because it has the side
+ * effect of incrementing the preempt count, which will leave it one too high
+ * post resume (the page containing the preempt count will be copied after
+ * its incremented. This is essentially the same problem.
+ */
+
+void suspend_copy_pageset1(void)
+{
+	int i, source_index, dest_index;
+
+	source_index = get_next_bit_on(pageset1_map, -1);
+	dest_index = get_next_bit_on(pageset1_copy_map, -1);
+
+	for (i = 0; i < pagedir1.pageset_size; i++) {
+		unsigned long *origvirt, *copyvirt;
+		struct page *origpage;
+		int loop = (PAGE_SIZE / sizeof(unsigned long)) - 1;
+
+		origpage = pfn_to_page(source_index);
+		
+	       	if (PageHighMem(origpage))
+			origvirt = kmap_atomic(origpage, KM_USER0);
+		else
+			origvirt = page_address(origpage);
+
+		copyvirt = (unsigned long *) page_address(pfn_to_page(dest_index));
+
+		while (loop >= 0) {
+			*(copyvirt + loop) = *(origvirt + loop);
+			loop--;
+		}
+		
+		if (PageHighMem(origpage))
+			kunmap_atomic(origvirt, KM_USER0);
+		
+		source_index = get_next_bit_on(pageset1_map, source_index);
+		dest_index = get_next_bit_on(pageset1_copy_map, dest_index);
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
