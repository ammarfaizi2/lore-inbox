Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317212AbSFFWLR>; Thu, 6 Jun 2002 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSFFWLP>; Thu, 6 Jun 2002 18:11:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30699 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317212AbSFFWK4>; Thu, 6 Jun 2002 18:10:56 -0400
Date: Thu, 06 Jun 2002 15:10:55 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: davidm@hpl.hp.com, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <88670000.1023401455@flay>
In-Reply-To: <15615.53702.794957.958227@napali.hpl.hp.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't do anything special.  I'm not sure what the fragmentation
> statistics look like on machines with 1+GB memory; it's something I
> have been wondering about and hoping to look into at some point (if
> someone has done that already, I'd love to see the results).  In
> practice, every ia64 linux distro as of today ships with 16KB page
> size, so you only get order-1 allocations for stacks.

I mailed out a patch that creates /proc/buddyinfo, which should give
you frag stats very easily .... would be interested to know if that works
on your machine ... slightly updated patch against 2.4.19-pre10 below:

diff -urN virgin-2.4.19-pre10/fs/proc/proc_misc.c linux-2.4.19-pre10-buddyinfo/fs/proc/proc_misc.c
--- virgin-2.4.19-pre10/fs/proc/proc_misc.c	Wed Jun  5 16:32:15 2002
+++ linux-2.4.19-pre10-buddyinfo/fs/proc/proc_misc.c	Wed Jun  5 16:56:05 2002
@@ -213,6 +213,21 @@
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
@@ -589,6 +604,8 @@
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+	create_proc_read_entry("buddyinfo", S_IWUSR | S_IRUGO, NULL,
+				       buddyinfo_read_proc, NULL);
 #ifdef CONFIG_MODULES
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif
diff -urN virgin-2.4.19-pre10/mm/page_alloc.c linux-2.4.19-pre10-buddyinfo/mm/page_alloc.c
--- virgin-2.4.19-pre10/mm/page_alloc.c	Wed Jun  5 16:32:33 2002
+++ linux-2.4.19-pre10-buddyinfo/mm/page_alloc.c	Wed Jun  5 16:57:17 2002
@@ -853,3 +853,39 @@
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
+			for (curr = head->next; curr != head; curr = curr->next)
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

