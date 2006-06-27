Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030683AbWF0Ejg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030683AbWF0Ejg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbWF0Ej2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:28 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:21467 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030658AbWF0EjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/10] [Suspend2] Prepare pbe list for atomic restore.
Date: Tue, 27 Jun 2006 14:39:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043858.14546.24568.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This routine prepares the list of page backup entries that is used by the
swsusp lowlevel code in doing the atomic restore.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   50 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index 6d1bc68..556e481 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -135,3 +135,53 @@ static unsigned long __suspend_get_next_
 	return counter;
 }
 
+/*
+ * prepare_suspend2_pbe_list
+ *
+ * Prepare pageset2 pages for doing the atomic copy. If necessary,
+ * we allocate extra pages.
+ *
+ */
+
+void prepare_suspend2_pbe_list(void)
+{
+	int orig_pfn, copy_pfn, i = 1;
+	struct pbe *this_pbe = NULL, *last_pbe = NULL;
+
+	orig_pfn = copy_pfn = -1;
+
+	pagedir_nosave = NULL;
+
+	do {
+		if (!this_pbe ||
+		    ((((unsigned long) this_pbe) & (PAGE_SIZE - 1)) 
+		     + 2 * sizeof(struct pbe)) > PAGE_SIZE) {
+			/* Get the next page for pbes */
+			this_pbe = (struct pbe *) suspend_get_nonconflicting_page();
+			BUG_ON(!this_pbe);
+			BUG_ON(PagePageset1(virt_to_page(this_pbe)));
+		} else
+			this_pbe++;
+
+		do {
+			orig_pfn = get_next_bit_on(pageset1_map, orig_pfn);
+			if (orig_pfn < 0)
+				return;
+			copy_pfn = get_next_bit_on(pageset1_copy_map, copy_pfn);
+		} while (PageHighMem(pfn_to_page(orig_pfn)));
+		
+		if (!last_pbe)
+			pagedir_nosave = this_pbe;
+		else
+			last_pbe->next = this_pbe;
+
+		last_pbe = this_pbe;
+		this_pbe->orig_address = (unsigned long) page_address(pfn_to_page(orig_pfn));
+		this_pbe->address = (unsigned long) page_address(pfn_to_page(copy_pfn));
+		this_pbe->next = NULL; /* get_nonconflicting_page doesn't get zeroed pages */
+
+		i++;
+
+	} while (1);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
