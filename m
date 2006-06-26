Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933182AbWFZXhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbWFZXhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933136AbWFZWeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:44 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28575 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933112AbWFZWeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:20 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/9] [Suspend2] Free extra memory allocated for the atomic copy.
Date: Tue, 27 Jun 2006 08:34:19 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223418.3963.82600.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the page cache is not large enough to store the atomic copy, we allocate
extra pages. This routine is used at cleanup to free that memory.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
index 1e0995e..9c26990 100644
--- a/kernel/power/pagedir.c
+++ b/kernel/power/pagedir.c
@@ -31,3 +31,26 @@ struct extras {
 	struct extras *next;
 } *extras_list;
 
+/* suspend_free_extra_pagedir_memory
+ *
+ * Description:	Free previously allocated extra pagedir memory.
+ */
+void suspend_free_extra_pagedir_memory(void)
+{
+	/* Free allocated pages */
+	while (extras_list) {
+		struct extras *this = extras_list;
+		int i;
+
+		extras_list = this->next;
+
+		for (i = 0; i < (1 << this->order); i++)
+			ClearPageNosave(this->page + i);
+
+		__free_pages(this->page, this->order);
+		kfree(this);
+	}
+
+	extra_pagedir_pages_allocated = 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
