Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWFZQyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWFZQyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWFZQy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:26 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51846 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750925AbWFZQyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:21 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 6/9] [Suspend2] Get next extent in an extent state.
Date: Tue, 27 Jun 2006 02:54:25 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165424.11065.71173.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a routine for getting the next device and block to which a page will be
written. We are essentially iterating through a series of one (filewriter)
or more (swapwriter) devices, each having a chain of sectors in which the
image is stored.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
index f7db014..8cbb48a 100644
--- a/kernel/power/extent.c
+++ b/kernel/power/extent.c
@@ -206,3 +206,46 @@ int suspend_load_extent_chain(struct ext
 	return ret;
 }
 
+/* suspend_extent_state_next
+ *
+ * Given a state, progress to the next valid entry. We may begin in an
+ * invalid state, as we do when invoked after extent_state_goto_start below.
+ *
+ * When using compression and expected_compression > 0, we allocate fewer
+ * swap entries, so we can validly run out of data to return.
+ */
+unsigned long suspend_extent_state_next(struct extent_iterate_state *state)
+{
+	if (state->current_chain > state->num_chains)
+		return 0;
+
+	if (state->current_extent) {
+		if (state->current_offset == state->current_extent->maximum) {
+			if (state->current_extent->next) {
+				state->current_extent = state->current_extent->next;
+				state->current_offset = state->current_extent->minimum;
+			} else {
+				state->current_extent = NULL;
+				state->current_offset = 0;
+			}
+		} else
+			state->current_offset++;
+	}
+
+	while(!state->current_extent) {
+		int chain_num = ++(state->current_chain);
+
+		if (chain_num > state->num_chains)
+			return 0;
+
+		state->current_extent = (state->chains + chain_num)->first;
+
+		if (!state->current_extent)
+			continue;
+
+		state->current_offset = state->current_extent->minimum;
+	}
+
+	return state->current_offset;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
