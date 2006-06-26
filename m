Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933219AbWFZXPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933219AbWFZXPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933240AbWFZWiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:14 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:62367 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933236AbWFZWiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:09 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 17/32] [Suspend2] Get an io_info struct.
Date: Tue, 27 Jun 2006 08:38:08 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223807.4376.81255.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate the struct used to store the details of an i/o in flight.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   59 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 728df04..48a2d09 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -573,3 +573,62 @@ static void add_to_batch(struct io_info 
 		submit_batched();
 }
 
+/*
+ * get_io_info_struct
+ *
+ * Description:	Get an I/O struct.
+ * Returns:	Pointer to the struct prepared for use.
+ */
+static struct io_info *get_io_info_struct(void)
+{
+	unsigned long newpage = 0, flags;
+	struct io_info *this = NULL;
+	int remaining = 0;
+
+	do {
+		while (atomic_read(&outstanding_io) >= MAX_OUTSTANDING_IO)
+			do_bio_wait(0);
+
+		/* Can start a new I/O. Is there a free one? */
+		if (!list_empty(&ioinfo_free)) {
+			/* Yes. Grab it. */
+			spin_lock_irqsave(&ioinfo_free_lock, flags);
+			break;
+		}
+
+		/* No. Need to allocate a new page for I/O info structs. */
+		newpage = get_zeroed_page(GFP_ATOMIC);
+		if (!newpage) {
+			do_bio_wait(1);
+			continue;
+		}
+
+		suspend_message(SUSPEND_MEMORY, SUSPEND_VERBOSE, 0,
+				"[NewIOPage %lx]", newpage);
+		infopages++;
+		if (infopages > maxinfopages)
+			maxinfopages++;
+
+		/* Prepare the new page for use. */
+		this = (struct io_info *) newpage;
+		remaining = PAGE_SIZE;
+		spin_lock_irqsave(&ioinfo_free_lock, flags);
+		while (remaining >= (sizeof(struct io_info))) {
+			list_add_tail(&this->list, &ioinfo_free);
+			this = (struct io_info *) (((char *) this) + 
+					sizeof(struct io_info));
+			remaining -= sizeof(struct io_info);
+		}
+		break;
+	} while (1);
+
+	/*
+	 * We have an I/O info struct. Remove it from the free list.
+	 * It will be added to the submit or busy list later.
+	 */
+	this = list_entry(ioinfo_free.next, struct io_info, list);
+	list_del_init(&this->list);
+	spin_unlock_irqrestore(&ioinfo_free_lock, flags);
+	return this;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
