Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWFZQ6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWFZQ6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWFZQ6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:58:32 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52870 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750967AbWFZQy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:28 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 8/9] [Suspend2] Extent state save and restore.
Date: Tue, 27 Jun 2006 02:54:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165431.11065.18807.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for remembering a position and restoring it later. This is used
to divide the storage into streams (the header, and two parts to the data
proper).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
index 248e4de..a3b9569 100644
--- a/kernel/power/extent.c
+++ b/kernel/power/extent.c
@@ -260,3 +260,50 @@ void suspend_extent_state_goto_start(str
 	state->current_offset = 0;
 }
 
+/* suspend_extent_start_save
+ *
+ * Given a state and a struct extent_state_store, save the crreutn
+ * position in a format that can be used with relocated chains (at
+ * resume time).
+ */
+void suspend_extent_state_save(struct extent_iterate_state *state,
+		struct extent_iterate_saved_state *saved_state)
+{
+	struct extent *extent;
+
+	saved_state->chain_num = state->current_chain;
+	saved_state->extent_num = 0;
+	saved_state->offset = state->current_offset;
+
+	if (saved_state->chain_num == -1)
+		return;
+	
+	extent = (state->chains + state->current_chain)->first;
+
+	while (extent != state->current_extent) {
+		saved_state->extent_num++;
+		extent = extent->next;
+	}
+}
+
+/* suspend_extent_start_restore
+ *
+ * Restore the position saved by extent_state_save.
+ */
+void suspend_extent_state_restore(struct extent_iterate_state *state,
+		struct extent_iterate_saved_state *saved_state)
+{
+	int posn = saved_state->extent_num;
+
+	if (saved_state->chain_num == -1) {
+		suspend_extent_state_goto_start(state);
+		return;
+	}
+
+	state->current_chain = saved_state->chain_num;
+	state->current_extent = (state->chains + state->current_chain)->first;
+	state->current_offset = saved_state->offset;
+
+	while (posn--)
+		state->current_extent = state->current_extent->next;
+}

--
Nigel Cunningham		nigel at suspend2 dot net
