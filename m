Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWF0FMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWF0FMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWF0FMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:12:06 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20443 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030673AbWF0Eiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/10] [Suspend2] Initialise nosave zone table
Date: Tue, 27 Jun 2006 14:38:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043852.14546.37005.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
References: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend2 uses swsusp code to restore lowmem pages, but (like swsusp) has a
separate routine for restoring highmem pages. This routine sets up a copy
of the start and end pfn numbers for use in restoring highmem pages. It is
invoked prior to the atomic restore beginning.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/atomic_copy.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/atomic_copy.c b/kernel/power/atomic_copy.c
index e54de43..07b418c 100644
--- a/kernel/power/atomic_copy.c
+++ b/kernel/power/atomic_copy.c
@@ -50,3 +50,28 @@ struct zone_data {
 static __nosavedata struct zone_data *zone_nosave;
 static __nosavedata int num_zones;
 
+/**
+ * suspend_init_nosave_zone_table: Set up nosave copy of zone table data.
+ *
+ * Zone information might be overwritten during the copy back, so we copy
+ * the fields we need to a non-conflicting page and use it.
+ **/
+static void suspend_init_nosave_zone_table(void)
+{
+	struct zone *zone;
+	
+	zone_nosave = (struct zone_data *) suspend_get_nonconflicting_page();
+
+	BUG_ON(!zone_nosave);
+
+	for_each_zone(zone) {
+		if (zone->spanned_pages) {
+			zone_nosave[num_zones].start_pfn = zone->zone_start_pfn;
+			zone_nosave[num_zones].end_pfn = zone->zone_start_pfn +
+				zone->spanned_pages - 1;
+			zone_nosave[num_zones].is_highmem = is_highmem(zone);
+		}
+		num_zones++;
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
