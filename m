Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbTGIIhq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbTGIIe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:34:59 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:53930 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265818AbTGIIcw
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 9 Jul 2003 04:32:52 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.54945.45955.840028@laputa.namesys.com>
Date: Wed, 9 Jul 2003 12:47:29 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH] 4/5 VM changes: zoneinfo.patch
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add /proc/zoneinfo file to display information about memory zones.



diff -puN fs/proc/proc_misc.c~zoneinfo fs/proc/proc_misc.c
--- i386/fs/proc/proc_misc.c~zoneinfo	Wed Jul  9 12:24:52 2003
+++ i386-god/fs/proc/proc_misc.c	Wed Jul  9 12:24:52 2003
@@ -251,6 +251,20 @@ static struct file_operations fragmentat
 	.release	= seq_release,
 };
 
+extern struct seq_operations zoneinfo_op;
+static int zoneinfo_open(struct inode *inode, struct file *file)
+{
+	(void)inode;
+	return seq_open(file, &zoneinfo_op);
+}
+
+static struct file_operations proc_zoneinfo_file_operations = {
+	.open		= zoneinfo_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -694,6 +708,7 @@ void __init proc_misc_init(void)
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
+	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
diff -puN mm/page_alloc.c~zoneinfo mm/page_alloc.c
--- i386/mm/page_alloc.c~zoneinfo	Wed Jul  9 12:24:52 2003
+++ i386-god/mm/page_alloc.c	Wed Jul  9 12:24:52 2003
@@ -1464,6 +1464,61 @@ struct seq_operations fragmentation_op =
 	.show	= frag_show,
 };
 
+/* 
+ * Output information about zones in @pgdat.
+ */
+static int zoneinfo_show(struct seq_file *m, void *arg)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+	struct zone *zone;
+	struct zone *node_zones = pgdat->node_zones;
+	unsigned long flags;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+		if (!zone->present_pages)
+			continue;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
+		seq_printf(m, 
+			   "\n\tpages free %lu"
+			   "\n\tpages min %lu"
+			   "\n\tpages low %lu"
+			   "\n\tpages high %lu"
+			   "\n\tpages active %lu"
+			   "\n\tpages inactive %lu"
+			   "\n\tpages scanned %lu"
+			   "\n\tpages spanned %lu"
+			   "\n\tpages present %lu",
+			   zone->free_pages, 
+			   zone->pages_min, 
+			   zone->pages_low, 
+			   zone->pages_high, 
+			   zone->nr_active, 
+			   zone->nr_inactive,
+			   zone->pages_scanned,
+			   zone->spanned_pages,
+			   zone->present_pages);
+		seq_printf(m, 
+			   "\n\trefill %i"
+			   "\n\tall_unreclaimable: %u"
+			   "\n\tpressure: %i",
+			   atomic_read(&zone->refill_counter), 
+			   zone->all_unreclaimable, zone->pressure);
+		spin_unlock_irqrestore(&zone->lock, flags);
+		seq_putc(m, '\n');
+	}
+	return 0;
+}
+
+struct seq_operations zoneinfo_op = {
+	.start	= frag_start, /* iterate over all zones. The same as in
+			       * fragmentation. */
+	.next	= frag_next,
+	.stop	= frag_stop,
+	.show	= zoneinfo_show,
+};
+
 static char *vmstat_text[] = {
 	"nr_dirty",
 	"nr_writeback",

_
