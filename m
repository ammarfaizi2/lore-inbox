Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTIQUp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTIQUp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:45:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:1452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262672AbTIQUpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:45:15 -0400
Date: Wed, 17 Sep 2003 13:44:22 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2/2) drivers/char/misc -- seq_file
Message-Id: <20030917134422.1dee2d73.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use seq_file for /proc/misc, applies to 2.6.0-test5 bk latest after earlier patch.

diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Wed Sep 17 13:42:51 2003
+++ b/drivers/char/misc.c	Wed Sep 17 13:42:51 2003
@@ -43,6 +43,7 @@
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/stat.h>
 #include <linux/init.h>
@@ -73,32 +74,65 @@
 extern int tosh_init(void);
 extern int i8k_init(void);
 
-static int misc_read_proc(char *buf, char **start, off_t offset,
-			  int len, int *eof, void *private)
+#ifdef CONFIG_PROC_FS
+static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct miscdevice *p;
-	int written;
+	loff_t off = 0;
 
-	written=0;
+	down(&misc_sem);
 	list_for_each_entry(p, &misc_list, list) {
-		if (written >= len)
-			break;
-		written += sprintf(buf+written, "%3i %s\n",p->minor, p->name ?: "");
-		if (written < offset) {
-			offset -= written;
-			written = 0;
-		}
-	}
-	*start = buf + offset;
-	written -= offset;
-	if(written > len) {
-		*eof = 0;
-		return len;
+		if (*pos == off++) 
+			return p;
 	}
-	*eof = 1;
-	return (written<0) ? 0 : written;
+	return NULL;
 }
 
+static void *misc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct list_head *n = ((struct miscdevice *)v)->list.next;
+
+	++*pos;
+
+	return (n != &misc_list) ? list_entry(n, struct miscdevice, list)
+		 : NULL;
+}
+
+static void misc_seq_stop(struct seq_file *seq, void *v)
+{
+	up(&misc_sem);
+}
+
+static int misc_seq_show(struct seq_file *seq, void *v)
+{
+	const struct miscdevice *p = v;
+
+	seq_printf(seq, "%3i %s\n", p->minor, p->name ? p->name : "");
+	return 0;
+}
+
+
+static struct seq_operations misc_seq_ops = {
+	.start = misc_seq_start,
+	.next  = misc_seq_next,
+	.stop  = misc_seq_stop,
+	.show  = misc_seq_show,
+};
+
+static int misc_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &misc_seq_ops);
+}
+
+static struct file_operations misc_proc_fops = {
+	.owner	 = THIS_MODULE,
+	.open    = misc_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+#endif
+
 static int misc_open(struct inode * inode, struct file * file)
 {
 	int minor = iminor(inode);
@@ -245,7 +279,13 @@
 
 int __init misc_init(void)
 {
-	create_proc_read_entry("misc", 0, 0, misc_read_proc, NULL);
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *ent;
+
+	ent = create_proc_entry("misc", 0, NULL);
+	if (ent)
+		ent->proc_fops = &misc_proc_fops;
+#endif
 #ifdef CONFIG_MVME16x
 	rtc_MK48T08_init();
 #endif
