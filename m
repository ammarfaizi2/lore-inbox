Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbTIXVrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTIXVrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:47:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17382 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261581AbTIXVrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:47:15 -0400
Date: Wed, 24 Sep 2003 22:47:14 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, olof@austin.ibm.com
Subject: Re: [PATCH] [2.4] Re: /proc/ioports overrun patch
Message-ID: <20030924214713.GA7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva> <Pine.A41.4.44.0309241437330.22232-100000@forte.austin.ibm.com> <20030924195133.GY7665@parcelfarce.linux.theplanet.co.uk> <20030924195926.GZ7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924195926.GZ7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hey - it's already there.  That makes life very easy - ->next() should
> do the following:
> 	if (resource->child)
> 		return resource->child;
> 	while (!resource->sibling) {
> 		resource = resource->parent;
> 		if (!resource)
> 			return NULL;
> 	}
> 	return resource->sibling;
> 
> AFAICS that should be it - walks the tree in right order.  Depth can be
> trivially found by ->show(), so there's no problems either...

OK, here's the 2.6 variant; it should also apply on top of 2.4 backport,
AFAICS.  Works here...

It replaces iterator of /proc/io{ports,mem} with normal tree traversal and
cleans the thing up a bit.

diff -urN B5-09241809/kernel/resource.c B5-current/kernel/resource.c
--- B5-09241809/kernel/resource.c	Sat Aug  9 02:21:03 2003
+++ B5-current/kernel/resource.c	Wed Sep 24 17:28:22 2003
@@ -38,75 +38,91 @@
 
 #ifdef CONFIG_PROC_FS
 
-#define MAX_IORES_LEVEL		5
+enum { MAX_IORES_LEVEL = 5 };
 
-/*
- * do_resource_list():
- * for reports of /proc/ioports and /proc/iomem;
- * do current entry, then children, then siblings;
- */
-static int do_resource_list(struct seq_file *m, struct resource *res, const char *fmt, int level)
-{
-	while (res) {
-		const char *name;
-
-		name = res->name ? res->name : "<BAD>";
-		if (level > MAX_IORES_LEVEL)
-			level = MAX_IORES_LEVEL;
-		seq_printf (m, fmt + 2 * MAX_IORES_LEVEL - 2 * level,
-				res->start, res->end, name);
-
-		if (res->child)
-			do_resource_list(m, res->child, fmt, level + 1);
-
-		res = res->sibling;
-	}
-
-	return 0;
+static void *r_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct resource *p = v;
+	(*pos)++;
+	if (p->child)
+		return p->child;
+	while (!p->sibling && p->parent)
+		p = p->parent;
+	return p->sibling;
 }
 
-static int ioresources_show(struct seq_file *m, void *v)
+static void *r_start(struct seq_file *m, loff_t *pos)
 {
-	struct resource *root = m->private;
-	char *fmt;
-	int retval;
-
-	fmt = root->end < 0x10000
-		? "          %04lx-%04lx : %s\n"
-		: "          %08lx-%08lx : %s\n";
+	struct resource *p = m->private;
+	loff_t l = 0;
 	read_lock(&resource_lock);
-	retval = do_resource_list(m, root->child, fmt, 0);
+	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
+		;
+	return p;
+}
+
+static void r_stop(struct seq_file *m, void *v)
+{
 	read_unlock(&resource_lock);
-	return retval;
 }
 
-static int ioresources_open(struct file *file, struct resource *root)
+static int r_show(struct seq_file *m, void *v)
 {
-	return single_open(file, ioresources_show, root);
+	struct resource *root = m->private;
+	struct resource *r = v, *p;
+	int width = root->end < 0x10000 ? 4 : 8;
+	int depth;
+
+	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
+		if (p->parent == root)
+			break;
+	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
+			depth * 2, "",
+			width, r->start,
+			width, r->end,
+			r->name ? r->name : "<BAD>");
+	return 0;
 }
 
+struct seq_operations resource_op = {
+	.start	= r_start,
+	.next	= r_next,
+	.stop	= r_stop,
+	.show	= r_show,
+};
+
 static int ioports_open(struct inode *inode, struct file *file)
 {
-	return ioresources_open(file, &ioport_resource);
+	int res = seq_open(file, &resource_op);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+		m->private = &ioport_resource;
+	}
+	return res;
+}
+
+static int iomem_open(struct inode *inode, struct file *file)
+{
+	int res = seq_open(file, &resource_op);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+		m->private = &iomem_resource;
+	}
+	return res;
 }
 
 static struct file_operations proc_ioports_operations = {
 	.open		= ioports_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= seq_release,
 };
 
-static int iomem_open(struct inode *inode, struct file *file)
-{
-	return ioresources_open(file, &iomem_resource);
-}
-
 static struct file_operations proc_iomem_operations = {
 	.open		= iomem_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= seq_release,
 };
 
 static int __init ioresources_init(void)
