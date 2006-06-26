Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933149AbWFZWef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbWFZWef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933145AbWFZWea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:30 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29087 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933124AbWFZWeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:24 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 3/9] [Suspend2] Allocate extra memory for the atomic copy.
Date: Tue, 27 Jun 2006 08:34:23 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223421.3963.39587.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate extra memory needed for an atomic copy when the page cache is too
small to store it.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
index 9c26990..76da2e5 100644
--- a/kernel/power/pagedir.c
+++ b/kernel/power/pagedir.c
@@ -54,3 +54,78 @@ void suspend_free_extra_pagedir_memory(v
 	extra_pagedir_pages_allocated = 0;
 }
 
+/* suspend_allocate_extra_pagedir_memory
+ *
+ * Description:	Allocate memory for making the atomic copy of pagedir1 in the
+ * 		case where it is bigger than pagedir2.
+ * Arguments:	struct pagedir *: 	The pagedir for which we should 
+ * 					allocate memory.
+ * 		int:			Size of pageset 1.
+ * 		int:			Size of pageset 2.
+ * Result:	int. Zero on success. One if unable to allocate enough memory.
+ */
+int suspend_allocate_extra_pagedir_memory(struct pagedir *p, int pageset_size,
+		int alloc_from)
+{
+	int num_to_alloc = pageset_size - alloc_from - extra_pagedir_pages_allocated;
+	int j, order, num_added = 0;
+
+	if (num_to_alloc < 1)
+		num_to_alloc = 0;
+
+	if (num_to_alloc) {
+		order = fls(num_to_alloc);
+		if (order >= MAX_ORDER)
+			order = MAX_ORDER - 1;
+
+		while (num_added < num_to_alloc) {
+			struct page *newpage;
+			unsigned long virt;
+			struct extras *extras_entry;
+			
+			while ((1 << order) > (num_to_alloc - num_added))
+				order--;
+
+			virt = __get_free_pages(GFP_ATOMIC | __GFP_NOWARN, order);
+			while ((!virt) && (order > 0)) {
+				order--;
+				virt = __get_free_pages(GFP_ATOMIC | __GFP_NOWARN, order);
+			}
+
+			if (!virt) {
+				p->pageset_size += num_added;
+				extra_pagedir_pages_allocated += num_added;
+				return 1;
+			}
+
+			newpage = virt_to_page(virt);
+
+			extras_entry = (struct extras *) kmalloc(sizeof(struct extras), GFP_ATOMIC);
+
+			if (!extras_entry) {
+				__free_pages(newpage, order);
+				extra_pagedir_pages_allocated += num_added;
+				return 1;
+			}
+
+			extras_entry->page = newpage;
+			extras_entry->order = order;
+			extras_entry->next = NULL;
+
+			if (extras_list)
+				extras_entry->next = extras_list;
+
+			extras_list = extras_entry;
+
+			for (j = 0; j < (1 << order); j++) {
+				SetPageNosave(newpage + j);
+				SetPagePageset1Copy(newpage + j);
+			}
+			num_added+= (1 << order);
+		}
+	}
+
+	extra_pagedir_pages_allocated += num_added;
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
