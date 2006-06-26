Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933262AbWFZXQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262AbWFZXQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933233AbWFZWhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:43 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:57759 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933229AbWFZWhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:36 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/32] [Suspend2] Finish and cleanup all outstanding I/O.
Date: Tue, 27 Jun 2006 08:37:34 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223733.4376.61756.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wait for all outstanding I/O to complete, then clean it all up and free the
io_info structs.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   42 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 6f8b29e..5b93ad2 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -333,3 +333,45 @@ static void do_bio_wait(int caller)
 	suspend_cleanup_some_completed_io();
 }
 
+/*
+ * suspend_finish_all_io
+ *
+ * Description:	Finishes all IO and frees all IO info struct pages.
+ */
+static void suspend_finish_all_io(void)
+{
+	struct io_info *this, *next = NULL;
+	unsigned long flags;
+
+	/* Wait for all I/O to complete. */
+	while (atomic_read(&outstanding_io))
+		do_bio_wait(2);
+
+	spin_lock_irqsave(&ioinfo_free_lock, flags);
+	
+	/* 
+	 * Two stages, to avoid using freed pages.
+	 *
+	 * First free all io_info structs on a page except the first.
+	 */
+	list_for_each_entry_safe(this, next, &ioinfo_free, list) {
+		if (((unsigned long) this) & ~PAGE_MASK)
+			list_del(&this->list);
+	}
+
+	/* 
+	 * Now we have only one reference to each page, and can safely
+	 * free pages, knowing we're not going to be trying to access the
+	 * same page after freeing it.
+	 */
+	list_for_each_entry_safe(this, next, &ioinfo_free, list) {
+		list_del(&this->list);
+		free_page((unsigned long) this);
+		infopages--;
+		suspend_message(SUSPEND_MEMORY, SUSPEND_VERBOSE, 0,
+				"[FreedIOPage %lx]", this);
+	}
+	
+	spin_unlock_irqrestore(&ioinfo_free_lock, flags);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
