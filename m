Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTJEJTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTJEJTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:19:20 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:36320 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262850AbTJEJTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:19:16 -0400
Subject: [PATCH] (Updated) Add insert_resource()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1065306211.663.6.camel@gaston>
References: <1065306211.663.6.camel@gaston>
Content-Type: text/plain
Message-Id: <1065345513.1033.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 05 Oct 2003 11:18:34 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
X-Bad-Reply: References but no Re:
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

The insert_resource patch has a quite weak and misleading
documentation for the insert_resource() function. Here's an
updated version that should be more useful.

Please apply as I'll need that functionality for further
PowerMac updates.

Regards,
Ben.

--- linux-2.5/kernel/resource.c	2003-10-04 22:20:11.000000000 +0200
+++ linuxppc-2.5-benh/kernel/resource.c	2003-10-05 11:14:39.000000000 +0200
@@ -268,6 +268,65 @@
 	return err;
 }
 
+/**
+ * insert_resource - Inserts a resource in the resource tree
+ * @parent: parent of the new resource
+ * @new: new resource to insert
+ *
+ * Returns 0 on success, -EBUSY if the resource can't be inserted.
+ *
+ * This function is equivalent of request_resource when no
+ * conflict happens. If a conflict happens, and the conflicting
+ * resources entirely fit within the range of the new resource,
+ * then the new resource is inserted and the conflicting resources
+ * become childs of the new resource. 
+ */
+int insert_resource(struct resource *parent, struct resource *new)
+{
+	int result = 0;
+	struct resource *first, *next;
+
+	write_lock(&resource_lock);
+	first = __request_resource(parent, new);
+	if (!first)
+		goto out;
+
+	result = -EBUSY;
+	if (first == parent)
+		goto out;
+
+	for (next = first; next->sibling; next = next->sibling)
+		if (next->sibling->start > new->end)
+			break;
+
+	/* existing resource overlaps end of new resource */
+	if (next->end > new->end)
+		goto out;
+
+	result = 0;
+
+	new->parent = parent;
+	new->sibling = next->sibling;
+	new->child = first;
+
+	next->sibling = NULL;
+	for (next = first; next; next = next->sibling)
+		next->parent = new;
+
+	if (parent->child == first) {
+		parent->child = new;
+	} else {
+		next = parent->child;
+		while (next->sibling != first)
+			next = next->sibling;
+		next->sibling = new;
+	}
+
+ out:
+	write_unlock(&resource_lock);
+	return result;
+}
+
 /*
  * This is compatibility stuff for IO resources.
  *
--- linux-2.5/kernel/ksyms.c	2003-10-04 22:20:11.000000000 +0200
+++ linuxppc-2.5-benh/kernel/ksyms.c	2003-10-05 11:15:47.000000000 +0200
@@ -256,6 +256,7 @@
 EXPORT_SYMBOL(request_resource);
 EXPORT_SYMBOL(release_resource);
 EXPORT_SYMBOL(allocate_resource);
+EXPORT_SYMBOL(insert_resource);
 EXPORT_SYMBOL(__request_region);
 EXPORT_SYMBOL(__check_region);
 EXPORT_SYMBOL(__release_region);
--- linux-2.5/include/linux/ioport.h	2003-10-04 22:20:17.000000000 +0200
+++ linuxppc-2.5-benh/include/linux/ioport.h	2003-10-05 11:15:54.000000000 +0200
@@ -90,6 +90,7 @@
 
 extern int request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
+extern int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     unsigned long size,
 			     unsigned long min, unsigned long max,


