Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268498AbUHTSId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268498AbUHTSId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUHTSGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:06:05 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:61408 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S268498AbUHTSCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:02:16 -0400
From: mita akinobu <amgta@yacht.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] shows Active/Inactive on per-node meminfo
Date: Sat, 21 Aug 2004 03:02:25 +0900
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Matthew Dobson <colpatch@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408210302.25053.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch below enable to display the size of Active/Inactive pages on per-node
meminfo (/sys/devices/system/node/node%d/meminfo) like /proc/meminfo.

By a little change to procps, "vmstat -a" can show these statistics about
particular node.

Please apply.

Signed-off-by: Akinobu Mita <amgta@yacht.ocn.ne.jp>

 drivers/base/node.c    |   10 ++++++++++
 include/linux/mmzone.h |    2 ++
 mm/page_alloc.c        |   28 +++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff -Nurp linux-2.6.8.1-mm3.orig/drivers/base/node.c linux-2.6.8.1-mm3/drivers/base/node.c
--- linux-2.6.8.1-mm3.orig/drivers/base/node.c	2004-08-21 00:15:43.000000000 +0900
+++ linux-2.6.8.1-mm3/drivers/base/node.c	2004-08-21 00:16:47.000000000 +0900
@@ -38,11 +38,19 @@ static ssize_t node_read_meminfo(struct 
 	int n;
 	int nid = dev->id;
 	struct sysinfo i;
+	unsigned long inactive;
+	unsigned long active;
+	unsigned long free;
+
 	si_meminfo_node(&i, nid);
+	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
+
 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
 		       "Node %d MemFree:      %8lu kB\n"
 		       "Node %d MemUsed:      %8lu kB\n"
+		       "Node %d Active:       %8lu kB\n"
+		       "Node %d Inactive:     %8lu kB\n"
 		       "Node %d HighTotal:    %8lu kB\n"
 		       "Node %d HighFree:     %8lu kB\n"
 		       "Node %d LowTotal:     %8lu kB\n"
@@ -50,6 +58,8 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
 		       nid, K(i.totalram - i.freeram),
+		       nid, K(active),
+		       nid, K(inactive),
 		       nid, K(i.totalhigh),
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram - i.totalhigh),
diff -Nurp linux-2.6.8.1-mm3.orig/include/linux/mmzone.h linux-2.6.8.1-mm3/include/linux/mmzone.h
--- linux-2.6.8.1-mm3.orig/include/linux/mmzone.h	2004-08-21 00:15:17.000000000 +0900
+++ linux-2.6.8.1-mm3/include/linux/mmzone.h	2004-08-21 00:16:46.000000000 +0900
@@ -272,6 +272,8 @@ typedef struct pglist_data {
 extern int numnodes;
 extern struct pglist_data *pgdat_list;
 
+void __get_zone_counts(unsigned long *active, unsigned long *inactive,
+			unsigned long *free, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free);
 void build_all_zonelists(void);
diff -Nurp linux-2.6.8.1-mm3.orig/mm/page_alloc.c linux-2.6.8.1-mm3/mm/page_alloc.c
--- linux-2.6.8.1-mm3.orig/mm/page_alloc.c	2004-08-21 00:16:18.000000000 +0900
+++ linux-2.6.8.1-mm3/mm/page_alloc.c	2004-08-21 00:16:47.000000000 +0900
@@ -1072,18 +1072,36 @@ unsigned long __read_page_state(unsigned
 	return ret;
 }
 
+void __get_zone_counts(unsigned long *active, unsigned long *inactive,
+			unsigned long *free, struct pglist_data *pgdat)
+{
+	struct zone *zones = pgdat->node_zones;
+	int i;
+
+	*active = 0;
+	*inactive = 0;
+	*free = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		*active += zones[i].nr_active;
+		*inactive += zones[i].nr_inactive;
+		*free += zones[i].free_pages;
+	}
+}
+
 void get_zone_counts(unsigned long *active,
 		unsigned long *inactive, unsigned long *free)
 {
-	struct zone *zone;
+	struct pglist_data *pgdat;
 
 	*active = 0;
 	*inactive = 0;
 	*free = 0;
-	for_each_zone(zone) {
-		*active += zone->nr_active;
-		*inactive += zone->nr_inactive;
-		*free += zone->free_pages;
+	for_each_pgdat(pgdat) {
+		unsigned long l, m, n;
+		__get_zone_counts(&l, &m, &n, pgdat);
+		*active += l;
+		*inactive += m;
+		*free += n;
 	}
 }
 

