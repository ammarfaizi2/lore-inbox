Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030653AbWF0FFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030653AbWF0FFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030668AbWF0EjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:25 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:21979 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030649AbWF0EjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/10] [Suspend2] Highmem copyback routine.
Date: Tue, 27 Jun 2006 14:39:03 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043902.14546.87518.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A routine to restore highmem pages which were atomically copied. We use
data allocated prior to the atomic restore of lowmem, so also have to do
this before other processes are allowed to run.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index 556e481..e565bf3 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -136,6 +136,38 @@ static unsigned long __suspend_get_next_
 }
 
 /*
+ * copyback_high: Restore highmem pages.
+ *
+ * Iterate through the source and destination bitmaps, restoring
+ * highmem pages that were atomically copied.
+ */
+void copyback_high(void)
+{
+	unsigned long *origpage;
+	unsigned long *copypage;
+
+	origoffset = __suspend_get_next_bit_on(origmap, &o_zone_num, -1);
+	copyoffset = __suspend_get_next_bit_on(copymap, &c_zone_num, -1);
+
+	while (o_zone_num < num_zones) {
+		if (zone_nosave[o_zone_num].is_highmem) {
+			origpage = (unsigned long *) kmap_atomic(pfn_to_page(origoffset), KM_USER1);
+			copypage = (unsigned long *) __va(copyoffset << PAGE_SHIFT);
+
+			memcpy(origpage, copypage, PAGE_SIZE);
+
+			kunmap_atomic(origpage, KM_USER1);
+		}
+		
+		origoffset = __suspend_get_next_bit_on(origmap, &o_zone_num, origoffset);
+		copyoffset = __suspend_get_next_bit_on(copymap, &c_zone_num, copyoffset);
+	}
+}
+#else
+void copyback_high(void) { }
+#endif
+
+/*
  * prepare_suspend2_pbe_list
  *
  * Prepare pageset2 pages for doing the atomic copy. If necessary,

--
Nigel Cunningham		nigel at suspend2 dot net
