Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933157AbWFZWfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157AbWFZWfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933117AbWFZWev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30111 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933123AbWFZWeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 5/9] [Suspend2] Mark pages for pageset 2.
Date: Tue, 27 Jun 2006 08:34:29 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223428.3963.94287.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the contents of pageset 2: clear the map, mark LRU pages as being in,
then remove userspace helpers' pages.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
index b7fc3bc..c23ca58 100644
--- a/kernel/power/pagedir.c
+++ b/kernel/power/pagedir.c
@@ -178,3 +178,95 @@ void suspend_mark_task_as_pageset1(struc
 		up_read(&mm->mmap_sem);
 }
 
+/* mark_pages_for_pageset2
+ *
+ * Description:	Mark unshared pages in processes not needed for suspend as
+ * 		being able to be written out in a separate pagedir.
+ * 		HighMem pages are simply marked as pageset2. They won't be
+ * 		needed during suspend.
+ */
+
+struct attention_list {
+	struct task_struct *task;
+	struct attention_list *next;
+};
+
+void suspend_mark_pages_for_pageset2(void)
+{
+	struct zone *zone;
+	struct task_struct *p;
+	struct attention_list *attention_list = NULL, *last = NULL;
+	unsigned long flags;
+
+	BUG_ON(in_atomic() && !irqs_disabled());
+
+	clear_dyn_pageflags(pageset2_map);
+
+	if (test_action_state(SUSPEND_NO_PAGESET2))
+		return;
+
+	/* 
+	 * Note that we don't clear the map to begin with!
+	 * This is because if we eat memory, we loose track
+	 * of LRU pages that are still in use but taken off
+	 * the LRU. If I can figure out how the VM keeps
+	 * track of them, I might be able to tweak this a
+	 * little further and decrease pageset one's size
+	 * further.
+	 *
+	 * (Memory grabbing clears the pageset2 flag on
+	 * pages that are really freed!).
+	 */
+	
+	for_each_zone(zone) {
+		spin_lock_irqsave(&zone->lru_lock, flags);
+		if (zone->nr_inactive) {
+			struct page *page;
+			list_for_each_entry(page, &zone->inactive_list, lru)
+				SetPagePageset2(page);
+		}
+		if (zone->nr_active) {
+			struct page *page;
+			list_for_each_entry(page, &zone->active_list, lru)
+				SetPagePageset2(page);
+		}
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
+	}
+
+	BUG_ON(in_atomic() && !irqs_disabled());
+
+	/* Now we find all userspace process (with task->mm) marked PF_NOFREEZE
+	 * and move them into pageset1.
+	 */
+	read_lock(&tasklist_lock);
+	for_each_process(p)
+		if ((p->flags & PF_NOFREEZE) || p == current) {
+			struct attention_list *this = kmalloc(sizeof(struct attention_list), GFP_ATOMIC);
+			BUG_ON(!this);
+			this->task = p;
+			this->next = NULL;
+			if (attention_list) {
+				last->next = this;
+				last = this;
+			} else
+				attention_list = last = this;
+		}
+	read_unlock(&tasklist_lock);
+
+	BUG_ON(in_atomic() && !irqs_disabled());
+
+	/* Because the tasks in attention_list are ones related to suspending,
+	 * we know that they won't go away under us.
+	 */
+
+	while (attention_list) {
+		suspend_mark_task_as_pageset1(attention_list->task);
+		last = attention_list;
+		attention_list = attention_list->next;
+		kfree(last);
+	}
+
+	BUG_ON(in_atomic() && !irqs_disabled());
+
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
