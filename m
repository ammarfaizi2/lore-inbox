Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVI2SRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVI2SRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVI2SQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:16:47 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:49724 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S932320AbVI2SQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:16:44 -0400
Message-Id: <20050929181637.557740707@twins>
References: <20050929180845.910895444@twins>
Date: Thu, 29 Sep 2005 20:08:50 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: [PATCH 5/7] CART - an advanced page replacement policy
Content-Disposition: inline; filename=cart-cart-stats.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds some /proc debugging information to the CART patch.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 fs/proc/proc_misc.c |   15 ++++++++
 mm/cart.c           |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

Index: linux-2.6-git/fs/proc/proc_misc.c
===================================================================
--- linux-2.6-git.orig/fs/proc/proc_misc.c
+++ linux-2.6-git/fs/proc/proc_misc.c
@@ -233,6 +233,20 @@ static struct file_operations proc_zonei
 	.release	= seq_release,
 };
 
+extern struct seq_operations cart_op;
+static int cart_open(struct inode *inode, struct file *file)
+{
+       (void)inode;
+       return seq_open(file, &cart_op);
+}
+
+static struct file_operations cart_file_operations = {
+       .open           = cart_open,
+       .read           = seq_read,
+       .llseek         = seq_lseek,
+       .release        = seq_release,
+};
+
 extern struct seq_operations nonresident_op;
 static int nonresident_open(struct inode *inode, struct file *file)
 {
@@ -616,6 +630,7 @@ void __init proc_misc_init(void)
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
+	create_seq_entry("cart",S_IRUGO, &cart_file_operations);
 	create_seq_entry("nonresident",S_IRUGO, &nonresident_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);
Index: linux-2.6-git/mm/cart.c
===================================================================
--- linux-2.6-git.orig/mm/cart.c
+++ linux-2.6-git/mm/cart.c
@@ -675,3 +675,96 @@ void __cart_remember(struct zone *zone, 
 			break;
 	}
 }
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *stats_start(struct seq_file *m, loff_t *pos)
+{
+	if (*pos != 0)
+		return NULL;
+
+	lru_add_drain();
+
+	return pos;
+}
+
+static void *stats_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	return NULL;
+}
+
+static void stats_stop(struct seq_file *m, void *arg)
+{
+}
+
+static int stats_show(struct seq_file *m, void *arg)
+{
+	struct zone *zone;
+	for_each_zone(zone) {
+		spin_lock_irq(&zone->lru_lock);
+		seq_printf(m, "\n\n======> zone: %lu <=====\n", (unsigned long)zone);
+		seq_printf(m, "struct zone values:\n");
+		seq_printf(m, "  zone->nr_active: %lu\n", zone->nr_active);
+		seq_printf(m, "  zone->nr_inactive: %lu\n", zone->nr_inactive);
+		seq_printf(m, "  zone->nr_evicted_active: %lu\n", zone->nr_evicted_active);
+		seq_printf(m, "  zone->nr_evicted_inactive: %lu\n", zone->nr_evicted_inactive);
+		seq_printf(m, "  zone->nr_shortterm: %lu\n", zone->nr_shortterm);
+		seq_printf(m, "  zone->cart_p: %lu\n", zone->nr_p);
+		seq_printf(m, "  zone->cart_q: %lu\n", zone->nr_q);
+		seq_printf(m, "  zone->cart_r: %lu\n", zone->nr_r);
+		seq_printf(m, "  zone->present_pages: %lu\n", zone->present_pages);
+		seq_printf(m, "  zone->free_pages: %lu\n", zone->free_pages);
+		seq_printf(m, "  zone->pages_min: %lu\n", zone->pages_min);
+		seq_printf(m, "  zone->pages_low: %lu\n", zone->pages_low);
+		seq_printf(m, "  zone->pages_high: %lu\n", zone->pages_high);
+
+		seq_printf(m, "\n");
+		seq_printf(m, "implicit values:\n");
+		seq_printf(m, "  zone->nr_longterm: %lu\n", nr_Nl);
+		seq_printf(m, "  zone->cart_cT: %lu\n", cart_cT);
+		seq_printf(m, "  zone->cart_cB: %lu\n", cart_cB);
+
+		seq_printf(m, "\n");
+		seq_printf(m, "counted values:\n");
+
+		{
+			struct page *page;
+			unsigned long active = 0, s1 = 0, l1 = 0;
+			unsigned long inactive = 0, s2 = 0, l2 = 0;
+			unsigned long a1=0,i1=0,a2=0,i2=0;
+			list_for_each_entry(page, &zone->active_list, lru) {
+				++active;
+				if (PageLongTerm(page)) ++l1;
+				else ++s1;
+				if (PageActive(page)) ++a1;
+				else ++i1;
+			}
+			list_for_each_entry(page, &zone->inactive_list, lru) {
+				++inactive;
+				if (PageLongTerm(page)) ++l2;
+				else ++s2;
+				if (PageActive(page)) ++a2;
+				else ++i2;
+			}
+			seq_printf(m, "  zone->nr_active: %lu (%lu, %lu)(%lu, %lu)\n", active, s1, l1, a1, i1);
+			seq_printf(m, "  zone->nr_inactive: %lu (%lu, %lu)(%lu, %lu)\n", inactive, s2, l2, a2, i2);
+			seq_printf(m, "  zone->nr_shortterm: %lu\n", s1+s2);
+			seq_printf(m, "  zone->nr_longterm: %lu\n", l1+l2);
+		}
+
+		spin_unlock_irq(&zone->lru_lock);
+	}
+
+	return 0;
+}
+
+struct seq_operations cart_op = {
+	.start = stats_start,
+	.next = stats_next,
+	.stop = stats_stop,
+	.show = stats_show,
+};
+
+#endif /* CONFIG_PROC_FS */

--
