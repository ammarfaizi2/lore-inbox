Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933187AbWFZXiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbWFZXiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933136AbWFZXhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:37:41 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31647 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933147AbWFZWel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 8/9] [Suspend2] Get pageset1 load addresses.
Date: Tue, 27 Jun 2006 08:34:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223438.3963.82572.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the addresses into which the atomically copied memory should loaded
prior to restoring it. They need to be locations that won't be overwritten
in the process.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
index ec75e79..daf498a 100644
--- a/kernel/power/pagedir.c
+++ b/kernel/power/pagedir.c
@@ -308,3 +308,29 @@ void suspend_relocate_if_required(unsign
 	}
 }
 
+/* get_pageset1_load_addresses
+ * 
+ * Description: We check here that pagedir & pages it points to won't collide
+ * 		with pages where we're going to restore from the loaded pages
+ * 		later.
+ * Returns:	Zero on success, one if couldn't find enough pages (shouldn't
+ * 		happen).
+ */
+
+int suspend_get_pageset1_load_addresses(void)
+{
+	int i, result = 0;
+	void *this;
+
+	for(i=0; i < pagedir1.pageset_size; i++) {
+		this = (void *) suspend_get_nonconflicting_page();
+		if (!this) {
+			abort_suspend("Error: Ran out of memory seeking locations for reloading data.");
+			result = 1;
+			break;
+		}
+		SetPagePageset1Copy(virt_to_page(this));
+	}
+
+	return result;
+}

--
Nigel Cunningham		nigel at suspend2 dot net
