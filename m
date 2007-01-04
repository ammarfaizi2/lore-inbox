Return-Path: <linux-kernel-owner+w=401wt.eu-S932257AbXADDwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbXADDwZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXADDwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:52:24 -0500
Received: from ricci.tusc.com.au ([203.2.177.24]:19490 "EHLO ricci.tusc.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932248AbXADDwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:52:19 -0500
Subject: [PATCH 2.6.19 2/2] X.25: Adds /proc/net/x25/forward to view active
	forwarded calls.
From: ahendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Jan 2007 14:37:15 +1100
Message-Id: <1167881835.5124.89.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

View the active forwarded call list
cat /proc/net/x25/forward

Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

--- linux-2.6.19-vanilla/net/x25/x25_proc.c	2006-12-31 22:31:07.000000000 +1100
+++ linux-2.6.19/net/x25/x25_proc.c	2007-01-01 19:16:56.000000000 +1100
@@ -165,6 +165,75 @@ out:
 	return 0;
 } 
 
+static __inline__ struct x25_forward *x25_get_forward_idx(loff_t pos)
+{
+	struct x25_forward *f;
+	struct list_head *entry;
+
+	list_for_each(entry, &x25_forward_list) {
+		f = list_entry(entry, struct x25_forward, node);
+		if (!pos--)
+			goto found;
+	}
+
+	f = NULL;
+found:
+	return f;
+}
+
+static void *x25_seq_forward_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t l = *pos;
+
+	read_lock_bh(&x25_forward_list_lock);
+	return l ? x25_get_forward_idx(--l) : SEQ_START_TOKEN;
+}
+
+static void *x25_seq_forward_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct x25_forward *f;
+
+	++*pos;
+	if (v == SEQ_START_TOKEN) {
+		f = NULL;
+		if (!list_empty(&x25_forward_list))
+			f = list_entry(x25_forward_list.next,
+					struct x25_forward, node);
+		goto out;
+	}
+	f = v;
+	if (f->node.next != &x25_forward_list)
+		f = list_entry(f->node.next, struct x25_forward, node);
+	else 
+		f = NULL;
+out:
+	return f;
+
+}
+
+static void x25_seq_forward_stop(struct seq_file *seq, void *v)
+{
+	read_unlock_bh(&x25_forward_list_lock);
+}
+
+static int x25_seq_forward_show(struct seq_file *seq, void *v)
+{
+	struct x25_forward *f;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(seq, "lci dev1       dev2\n");
+		goto out;
+	}
+
+	f = v;
+
+	seq_printf(seq, "%d %-10s %-10s\n",
+			f->lci, f->dev1->name, f->dev2->name);
+
+out:
+	return 0;
+} 
+
 static struct seq_operations x25_seq_route_ops = {
 	.start  = x25_seq_route_start,
 	.next   = x25_seq_route_next,
@@ -179,6 +248,13 @@ static struct seq_operations x25_seq_soc
 	.show   = x25_seq_socket_show,
 };
 
+static struct seq_operations x25_seq_forward_ops = {
+	.start  = x25_seq_forward_start,
+	.next   = x25_seq_forward_next,
+	.stop   = x25_seq_forward_stop,
+	.show   = x25_seq_forward_show,
+};
+
 static int x25_seq_socket_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &x25_seq_socket_ops);
@@ -189,6 +265,11 @@ static int x25_seq_route_open(struct ino
 	return seq_open(file, &x25_seq_route_ops);
 }
 
+static int x25_seq_forward_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &x25_seq_forward_ops);
+}
+
 static struct file_operations x25_seq_socket_fops = {
 	.owner		= THIS_MODULE,
 	.open		= x25_seq_socket_open,
@@ -205,6 +286,14 @@ static struct file_operations x25_seq_ro
 	.release	= seq_release,
 };
 
+static struct file_operations x25_seq_forward_fops = {
+	.owner		= THIS_MODULE,
+	.open		= x25_seq_forward_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static struct proc_dir_entry *x25_proc_dir;
 
 int __init x25_proc_init(void)
@@ -225,9 +314,17 @@ int __init x25_proc_init(void)
 	if (!p)
 		goto out_socket;
 	p->proc_fops = &x25_seq_socket_fops;
+
+	p = create_proc_entry("forward", S_IRUGO, x25_proc_dir);
+	if (!p)
+		goto out_forward;
+	p->proc_fops = &x25_seq_forward_fops;
 	rc = 0;
+
 out:
 	return rc;
+out_forward:
+	remove_proc_entry("socket", x25_proc_dir);
 out_socket:
 	remove_proc_entry("route", x25_proc_dir);
 out_route:
@@ -237,6 +334,7 @@ out_route:
 
 void __exit x25_proc_exit(void)
 {
+	remove_proc_entry("forward", x25_proc_dir);
 	remove_proc_entry("route", x25_proc_dir);
 	remove_proc_entry("socket", x25_proc_dir);
 	remove_proc_entry("x25", proc_net);

