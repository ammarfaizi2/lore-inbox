Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWFZQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWFZQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFZQyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:32 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51334 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750915AbWFZQyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:18 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 5/9] [Suspend2] Serialise extent chains.
Date: Tue, 27 Jun 2006 02:54:22 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165420.11065.26195.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines for storing extent chains in an image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
index 31fcb65..f7db014 100644
--- a/kernel/power/extent.c
+++ b/kernel/power/extent.c
@@ -141,3 +141,68 @@ int suspend_add_to_extent_chain(struct e
 	return 0;
 }
 
+/* suspend_serialise_extent_chain
+ *
+ * Write a chain in the image.
+ */
+int suspend_serialise_extent_chain(struct suspend_module_ops *owner,
+		struct extent_chain *chain)
+{
+	struct extent *this;
+	int ret, i = 0;
+	
+	if ((ret = suspend_active_writer->rw_header_chunk(WRITE, owner,
+		(char *) chain,
+		3 * sizeof(int))))
+		return ret;
+
+	this = chain->first;
+	while (this) {
+		if ((ret = suspend_active_writer->rw_header_chunk(WRITE, owner,
+				(char *) this,
+				2 * sizeof(unsigned long))))
+			return ret;
+		this = this->next;
+		i++;
+	}
+
+	if (i != (chain->allocs - chain->frees)) {
+		printk(KERN_EMERG "Saved %d extents but chain metadata says there should be %d-%d.\n",
+				i, chain->allocs, chain->frees);
+		BUG();
+	}
+
+	return ret;
+}
+
+/* suspend_load_extent_chain
+ *
+ * Read back a chain saved in the image.
+ */
+int suspend_load_extent_chain(struct extent_chain *chain)
+{
+	struct extent *this, *last = NULL;
+	int i, ret;
+
+	if (!(ret = suspend_active_writer->rw_header_chunk(READ, NULL,
+		(char *) chain,
+		3 * sizeof(int))))
+		return ret;
+
+	for (i = 0; i < (chain->allocs - chain->frees); i++) {
+		this = kmalloc(sizeof(struct extent), GFP_ATOMIC);
+		BUG_ON(!this); /* Shouldn't run out of memory trying this! */
+		this->next = NULL;
+		if (!(ret = suspend_active_writer->rw_header_chunk(READ, NULL,
+				(char *) this, 2 * sizeof(unsigned long))))
+			return ret;
+		if (last)
+			last->next = this;
+		else
+			chain->first = this;
+		last = this;
+	}
+	chain->last = last;
+	return ret;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
