Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSEVIXC>; Wed, 22 May 2002 04:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSEVIXB>; Wed, 22 May 2002 04:23:01 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:36250 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S315463AbSEVIW6>; Wed, 22 May 2002 04:22:58 -0400
Date: Wed, 22 May 2002 01:22:33 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: wli@holomorpy.com
Subject: [RFC][PATCH] dump fragmentation stats for buddy allocator
Message-ID: <1376902511.1022030553@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch creates /proc/buddyinfo, which
shows how many of each order page groups are available.
It has *not* been well tested. 

Thanks to wli for pointing out that infinite loops whilst
holding vm locks with interrupts disbabled are probably
not a Good Thing (tm).

Comments / abuse / testing all welcome.

M.

--- virgin-2.4.19-pre8/fs/proc/proc_misc.c	Tue May  7 15:21:57 2002
+++ linux-2.4.19-pre8-buddystats/fs/proc/proc_misc.c	Tue May 21 20:02:18 2002
@@ -193,6 +193,21 @@
 #undef K
 }
 
+extern int buddyinfo(char *buf, int node_id);
+
+int buddyinfo_read_proc(char *page, char **start, off_t off,
+		        int count, int *eof, void *data)
+{
+        int node_id;
+	int len = 0;
+
+	for (node_id = 0; node_id < numnodes; node_id++) {
+		len += buddyinfo(page+len, node_id);
+	} 
+	
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -580,4 +595,7 @@
 				       slabinfo_read_proc, NULL);
 	if (entry)
 		entry->write_proc = slabinfo_write_proc;
+
+	create_proc_read_entry("buddyinfo", S_IWUSR | S_IRUGO, NULL,
+				       buddyinfo_read_proc, NULL);
 }
--- virgin-2.4.19-pre8/mm/page_alloc.c	Tue May  7 15:22:12 2002
+++ linux-2.4.19-pre8-buddystats/mm/page_alloc.c	Wed May 22 01:07:53 2002
@@ -877,3 +877,39 @@
 }
 
 __setup("memfrac=", setup_mem_frac);
+
+
+/* 
+ * This walks the freelist for each zone. Whilst this is slow, I'd rather 
+ * be slow here than slow down the fast path by keeping stats - mjbligh
+ */
+int buddyinfo(char *buf, int node_id)
+{
+	int zone_id, order, free, len = 0;
+	unsigned long flags;
+	zone_t *zone;
+	free_area_t * area;
+	struct list_head *head, *curr;
+	
+	for (zone_id = 0; zone_id < MAX_NR_ZONES; ++zone_id) {
+		zone = &(NODE_DATA(node_id)->node_zones[zone_id]);
+		if (zone->size == 0)
+			continue;
+		spin_lock_irqsave(&zone->lock, flags);
+		len += sprintf(buf+len, "Node %d, Zone %8s, ", 
+				node_id, zone->name);
+		for (order = 0; order < MAX_ORDER; ++order) {
+			area = zone->free_area + order;
+			head = &area->free_list;
+			free = 0;
+			for (curr = memlist_next(head); curr != head; curr = memlist_next(curr))
+				++free;
+			len += sprintf(buf+len, "%d ", free);
+		}	
+		len += sprintf(buf+len, "\n");
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+
+	return len;
+}
+

