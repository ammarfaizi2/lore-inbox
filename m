Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933208AbWFZXiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbWFZXiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFZXid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:38:33 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31135 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933143AbWFZWej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:39 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 7/9] [Suspend2] Relocate a piece of memory if required.
Date: Tue, 27 Jun 2006 08:34:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223435.3963.65981.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given an address and size (never more than a page and never overlapping
page boundaries), relocate the data to an address that can be safely used
during the atomic restore if that relocation is necessary. The memory to be
freed might be slab or a normal page.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
index 4cdc0ef..ec75e79 100644
--- a/kernel/power/pagedir.c
+++ b/kernel/power/pagedir.c
@@ -288,3 +288,23 @@ unsigned long suspend_get_nonconflicting
 	return (unsigned long) page_address(page);
 }
 
+/* relocate_page_if_required
+ *
+ * Description: Given the address of a pointer to a page, we check if the page
+ * 		needs relocating and do so if needs be, adjusting the pointer
+ * 		too.
+ */
+
+void suspend_relocate_if_required(unsigned long *current_value, unsigned int size)
+{
+	if (PagePageset1(virt_to_page(*current_value))) {
+		unsigned long new_page = suspend_get_nonconflicting_page();
+		memcpy((char *) new_page, (char *) *current_value, size);
+		if (PageSlab(virt_to_page(*current_value)))
+			kfree((void *) *current_value);
+		else
+			free_page((unsigned long) *current_value);
+		*current_value = new_page;
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
