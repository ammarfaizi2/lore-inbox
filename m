Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUGNOKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUGNOKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUGNOKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:10:30 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:5052 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267411AbUGNOEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:04:07 -0400
Date: Wed, 14 Jul 2004 23:03:51 +0900 (JST)
Message-Id: <20040714.230351.22507490.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [5/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



$Id: va-proc_memhotplug.patch,v 1.14 2004/07/06 09:05:54 taka Exp $

diff -dpur linux-2.6.7/mm/page_alloc.c linux-2.6.7-mh/mm/page_alloc.c
--- linux-2.6.7/mm/page_alloc.c.orig	2004-06-17 16:28:03.000000000 +0900
+++ linux-2.6.7-mh/mm/page_alloc.c	2004-06-17 16:28:34.000000000 +0900
@@ -32,6 +32,7 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/proc_fs.h>
 
 #include <asm/tlbflush.h>
 
@@ -2120,3 +2121,244 @@ int lower_zone_protection_sysctl_handler
 	setup_per_zone_protection();
 	return 0;
 }
+
+#ifdef CONFIG_MEMHOTPLUG
+static int mhtest_read(char *page, char **start, off_t off, int count,
+    int *eof, void *data)
+{
+	char *p;
+	int i, j, len;
+	const struct pglist_data *pgdat;
+	const struct zone *z;
+
+	p = page;
+	for(i = 0; i < numnodes; i++) {
+		pgdat = NODE_DATA(i);
+		if (pgdat == NULL)
+			continue;
+		len = sprintf(p, "Node %d %sabled %shotremovable\n", i,
+		    pgdat->enabled ? "en" : "dis",
+		    pgdat->removable ? "" : "non");
+		p += len;
+		for (j = 0; j < MAX_NR_ZONES; j++) {
+			z = &pgdat->node_zones[j];
+			if (! z->present_pages)
+				/* skip empty zone */
+				continue;
+			len = sprintf(p,
+			    "\t%s[%d]: free %ld, active %ld, present %ld\n",
+			    z->name, NODEZONE(i, j),
+			    z->free_pages, z->nr_active, z->present_pages);
+			p += len;
+		}
+		*p++ = '\n';
+	}
+	len = p - page;
+
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len < 0)
+		len = 0;
+	if (len > count)
+		len = count;
+
+	return len;
+}
+
+static void mhtest_enable(int);
+static void mhtest_disable(int);
+static void mhtest_plug(int);
+static void mhtest_unplug(int);
+static void mhtest_purge(int);
+static void mhtest_remap(int);
+static void mhtest_active(int);
+static void mhtest_inuse(int);
+
+const static struct {
+	char *cmd;
+	void (*func)(int);
+	char zone_check;
+} mhtest_cmds[] = {
+	{ "disable", mhtest_disable, 0 },
+	{ "enable", mhtest_enable, 0 },
+	{ "plug", mhtest_plug, 0 },
+	{ "unplug", mhtest_unplug, 0 },
+	{ "purge", mhtest_purge, 1 },
+	{ "remap", mhtest_remap, 1 },
+	{ "active", mhtest_active, 1 },
+	{ "inuse", mhtest_inuse, 1 },
+	{ NULL, NULL }};
+
+static void
+mhtest_disable(int idx) {
+	int i, z;
+
+	printk("disable %d\n", idx);
+	/* XXX */
+	for (z = 0; z < MAX_NR_ZONES; z++) {
+		for (i = 0; i < NR_CPUS; i++) {
+			struct per_cpu_pages *pcp;
+
+			pcp = &zone_table[NODEZONE(idx, z)]->pageset[i].pcp[0];	/* hot */
+			pcp->low = pcp->high = 0;
+
+			pcp = &zone_table[NODEZONE(idx, z)]->pageset[i].pcp[1];	/* cold */
+			pcp->low = pcp->high = 0;
+		}
+		zone_table[NODEZONE(idx, z)]->pages_high =
+		    zone_table[NODEZONE(idx, z)]->present_pages;
+	}
+	disable_node(idx);
+}
+static void
+mhtest_enable(int idx) {
+	int i, z;
+
+	printk("enable %d\n", idx);
+	for (z = 0; z < MAX_NR_ZONES; z++) {
+		zone_table[NODEZONE(idx, z)]->pages_high = 
+		    zone_table[NODEZONE(idx, z)]->pages_min * 3;
+		/* XXX */
+		for (i = 0; i < NR_CPUS; i++) {
+			struct per_cpu_pages *pcp;
+
+			pcp = &zone_table[NODEZONE(idx, z)]->pageset[i].pcp[0];	/* hot */
+			pcp->low = 2 * pcp->batch;
+			pcp->high = 6 * pcp->batch;
+
+			pcp = &zone_table[NODEZONE(idx, z)]->pageset[i].pcp[1];	/* cold */
+			pcp->high = 2 * pcp->batch;
+		}
+	}
+	enable_node(idx);
+}
+
+static void
+mhtest_plug(int idx) {
+
+	if (NODE_DATA(idx) != NULL) {
+		printk("Already plugged\n");
+		return;
+	}
+	plug_node(idx);
+}
+
+static void
+mhtest_unplug(int idx) {
+
+	unplug_node(idx);
+}
+
+static void
+mhtest_purge(int idx)
+{
+	printk("purge %d\n", idx);
+	wake_up_interruptible(&zone_table[idx]->zone_pgdat->kswapd_wait);
+	/* XXX overkill, but who cares? */
+	on_each_cpu(drain_local_pages, NULL, 1, 1);
+}
+
+static void
+mhtest_remap(int idx) {
+
+	on_each_cpu(drain_local_pages, NULL, 1, 1);
+	kernel_thread(mmigrated, zone_table[idx], CLONE_KERNEL);
+}
+
+static void
+mhtest_active(int idx)
+{
+	struct list_head *l;
+	int i;
+
+	if (zone_table[idx] == NULL)
+		return;
+	spin_lock_irq(&zone_table[idx]->lru_lock);
+	i = 0;
+	list_for_each(l, &zone_table[idx]->active_list) {
+		printk(" %lx", (unsigned long)list_entry(l, struct page, lru));
+		i++;
+		if (i == 10)
+			break;
+	}
+	spin_unlock_irq(&zone_table[idx]->lru_lock);
+	printk("\n");
+}
+
+static void
+mhtest_inuse(int idx)
+{
+	int i;
+
+	if (zone_table[idx] == NULL)
+		return;
+	for(i = 0; i < zone_table[idx]->spanned_pages; i++)
+		if (page_count(&zone_table[idx]->zone_mem_map[i]))
+			printk(" %p", &zone_table[idx]->zone_mem_map[i]);
+	printk("\n");
+}
+
+static int mhtest_write(struct file *file, const char *buffer,
+    unsigned long count, void *data)
+{
+	int idx;
+	char buf[64], *p;
+	int i;
+
+	if (count > sizeof(buf) - 1)
+		count = sizeof(buf) - 1;
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+
+	buf[count] = 0;
+
+	p = strchr(buf, ' ');
+	if (p == NULL)
+		goto out;
+
+	*p++ = '\0';
+	idx = (int)simple_strtoul(p, NULL, 0);
+
+	if (idx > MAX_NR_ZONES*MAX_NUMNODES) {
+		printk("Argument out of range\n");
+		goto out;
+	}
+
+	for(i = 0; ; i++) {
+		if (mhtest_cmds[i].cmd == NULL)
+			break;
+		if (strcmp(buf, mhtest_cmds[i].cmd) == 0) {
+			if (mhtest_cmds[i].zone_check) {
+				if (zone_table[idx] == NULL) {
+					printk("Zone %d not plugged\n", idx);
+					return count;
+				}
+			} else if (strcmp(buf, "plug") != 0 &&
+			    NODE_DATA(idx) == NULL) {
+				printk("Node %d not plugged\n", idx);
+				return count;
+			}
+			(mhtest_cmds[i].func)(idx);
+			break;
+		}
+	}
+out:
+	return count;
+}
+
+static int __init procmhtest_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("memhotplug", 0, NULL);
+	if (entry == NULL)
+		return -1;
+
+	entry->read_proc = &mhtest_read;
+	entry->write_proc = &mhtest_write;
+	return 0;
+}
+__initcall(procmhtest_init);
+#endif
