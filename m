Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318600AbSGSRE2>; Fri, 19 Jul 2002 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSGSRE1>; Fri, 19 Jul 2002 13:04:27 -0400
Received: from holomorphy.com ([66.224.33.161]:62351 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318600AbSGSRDm>;
	Fri, 19 Jul 2002 13:03:42 -0400
Date: Fri, 19 Jul 2002 10:06:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com
Subject: [RFC/CFT] convert buddyinfo to seq_file()
Message-ID: <20020719170641.GY1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch thought this might be a good idea. Basically, it just changes it to
seq_file instead of the sprintf into the buffer + proc_calc_metrics. I
think there might be some extra buffer overflow safety with seq_file.
Most of this code was borrowed/stolen from my lazy_buddy tree.

Against 2.4.19rc2aa1


Cheers,
Bill


diff -urN linux-aa-virgin/fs/proc/proc_misc.c linux-aa-wli/fs/proc/proc_misc.c
--- linux-aa-virgin/fs/proc/proc_misc.c	Fri Jul 19 08:52:39 2002
+++ linux-aa-wli/fs/proc/proc_misc.c	Fri Jul 19 10:01:54 2002
@@ -234,21 +234,20 @@
 #undef K
 }
 
-extern int buddyinfo(char *buf, int node_id);
-
-int buddyinfo_read_proc(char *page, char **start, off_t off,
-		        int count, int *eof, void *data)
+extern struct seq_operations fragmentation_op;
+static int fragmentation_open(struct inode *inode, struct file *file)
 {
-	int node_id;
-	int len = 0;
-
-	for (node_id = 0; node_id < numnodes; node_id++) {
-		len += buddyinfo(page+len, node_id);
-	} 
-	
-	return proc_calc_metrics(page, start, off, count, eof, len);
+	(void)inode;
+	return seq_open(file, &fragmentation_op);
 }
 
+static struct file_operations fragmentation_file_operations = {
+	open:		fragmentation_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -691,6 +690,7 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif
@@ -715,7 +715,4 @@
 			entry->proc_fops = &ppc_htab_operations;
 	}
 #endif
-
-	create_proc_read_entry("buddyinfo", S_IWUSR | S_IRUGO, NULL,
-			       buddyinfo_read_proc, NULL);
 }
diff -urN linux-aa-virgin/mm/page_alloc.c linux-aa-wli/mm/page_alloc.c
--- linux-aa-virgin/mm/page_alloc.c	Fri Jul 19 08:52:39 2002
+++ linux-aa-wli/mm/page_alloc.c	Fri Jul 19 09:45:55 2002
@@ -1028,37 +1028,70 @@
 
 __setup("lower_zone_reserve=", setup_lower_zone_reserve);
 
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *frag_start(struct seq_file *m, loff_t *pos)
+{
+	pg_data_t *pgdat;
+	loff_t node = *pos;
+
+	(void)m;
+
+	for (pgdat = pgdat_list; pgdat && node; pgdat = pgdat->node_next)
+		--node;
+
+	return pgdat;
+}
+
+static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+
+	(void)m;
+	(*pos)++;
+	return pgdat->node_next;
+}
+
+static void frag_stop(struct seq_file *m, void *arg)
+{
+	(void)m;
+	(void)arg;
+}
+
 /* 
  * This walks the freelist for each zone. Whilst this is slow, I'd rather 
  * be slow here than slow down the fast path by keeping stats - mjbligh
  */
-int buddyinfo(char *buf, int node_id)
+static int frag_show(struct seq_file *m, void *arg)
 {
-	int zone_id, order, free, len = 0;
+	pg_data_t *pgdat = (pg_data_t *)arg;
+	zone_t *zone, *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	zone_t *zone;
-	free_area_t * area;
-	struct list_head *head, *curr;
-	
-	for (zone_id = 0; zone_id < MAX_NR_ZONES; ++zone_id) {
-		zone = &(NODE_DATA(node_id)->node_zones[zone_id]);
-		if (zone->size == 0)
-			continue;
+	int order;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		spin_lock_irqsave(&zone->lock, flags);
-		len += sprintf(buf+len, "Node %d, Zone %8s, ", 
-				node_id, zone->name);
+		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
 		for (order = 0; order < MAX_ORDER; ++order) {
-			area = zone->free_area + order;
-			head = &area->free_list;
-			free = 0;
-			for (curr = head->next; curr != head; curr = curr->next)
-				++free;
-			len += sprintf(buf+len, "%d ", free);
-		}	
-		len += sprintf(buf+len, "\n");
+			unsigned long nr_bufs = 0;
+			list_t *elem;
+			list_for_each(elem, &zone->free_area[order].free_list)
+				++nr_bufs;
+			seq_printf(m, "%6lu ", nr_bufs);
+		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+		seq_putc(m, '\n');
 	}
-
-	return len;
+	return 0;
 }
 
+struct seq_operations fragmentation_op = {
+	start:	frag_start,
+	next:	frag_next,
+	stop:	frag_stop,
+	show:	frag_show,
+};
+
+#endif /* CONFIG_PROC_FS */
