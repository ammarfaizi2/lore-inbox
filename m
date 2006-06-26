Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933340AbWFZWq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbWFZWq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933338AbWFZWmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:09 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43191 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933273AbWFZWlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 14/28] [Suspend2] Release swapwriter storage.
Date: Tue, 27 Jun 2006 08:41:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224151.4975.89305.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Free storage that has been allocated and also clear out the extent chains
that record the sectors.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index ae0dfad..ae33a4e 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -452,3 +452,34 @@ static void swapwriter_cleanup(int endin
 	close_bdevs();
 }
 
+static int swapwriter_release_storage(void)
+{
+	int i = 0;
+
+	if (test_action_state(SUSPEND_KEEP_IMAGE) &&
+	    test_suspend_state(SUSPEND_NOW_RESUMING))
+		return 0;
+
+	header_pages_allocated = 0;
+	
+	if (swapextents.first) {
+		/* Free swap entries */
+		struct extent *extentpointer;
+		unsigned long extentvalue;
+		swp_entry_t entry;
+		suspend_extent_for_each(&swapextents, extentpointer, 
+				extentvalue) {
+			entry = extent_val_to_swap_entry(extentvalue);
+			swap_free(entry);
+		}
+
+		suspend_put_extent_chain(&swapextents);
+		
+		for (i = 0; i < MAX_SWAPFILES; i++)
+			if (block_chain[i].first)
+				suspend_put_extent_chain(&block_chain[i]);
+	}
+	
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
