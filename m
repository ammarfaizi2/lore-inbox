Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWFZQ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWFZQ4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWFZQym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:42 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50310 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750921AbWFZQyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 3/9] [Suspend2] Free a whole extent chain.
Date: Tue, 27 Jun 2006 02:54:15 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165413.11065.69373.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a routine to free an entire extent chain at once.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
index 2fb6a23..ab19509 100644
--- a/kernel/power/extent.c
+++ b/kernel/power/extent.c
@@ -47,3 +47,26 @@ void suspend_put_extent(struct extent *e
 	suspend_extents_allocated--;
 }
 
+/* suspend_put_extent_chain.
+ *
+ * Frees a whole chain of extents.
+ */
+void suspend_put_extent_chain(struct extent_chain *chain)
+{
+	struct extent *this;
+
+	this = chain->first;
+
+	while(this) {
+		struct extent *next = this->next;
+		kfree(this);
+		chain->frees++;
+		suspend_extents_allocated --;
+		this = next;
+	}
+	
+	BUG_ON(chain->frees != chain->allocs);
+	chain->first = chain->last = chain->last_touched = NULL;
+	chain->size = chain->allocs = chain->frees = 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
