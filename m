Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTJDWYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 18:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTJDWYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 18:24:16 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:51917 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262784AbTJDWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 18:24:13 -0400
Subject: [PATCH] Add insert_resource()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1065306211.663.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 05 Oct 2003 00:23:31 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

This patch adds an insert_resource() function to kernel/resource.c,
this function behaves like request_resource(), except that if a
conflict happens and the conflicting resources fit "inside" the
new resources, the new resource is inserted and the conflicting
ones moved as childs of the new resource.

This is necessary to deal with some corner cases on the PPC arch
at least, and maybe more later, where we have some early boot code
request things like serial ports or interrupt controller, and later
on, the PCI "macio" combo-asic that really contain these gets
probed and try to creates it's own resource tree based on open
firmware.

We implemented this in the arch code previously, but we lacked
locking as the resource lock is static to kernel/resource.c, and
we had to re-implement __request_resource() which is static as
well. Mattew Willcox has the idea of making this insert_resource()
function generic (and provided the first implementation).

Please apply, future PowerMac updates will rely on this

Regards,
Ben.


--- linux-2.5/kernel/resource.c	2003-10-04 22:20:11.000000000 +0200
+++ linuxppc-2.5-benh/kernel/resource.c	2003-10-04 22:20:56.000000000 +0200
@@ -268,6 +268,59 @@
 	return err;
 }
 
+/**
+ * insert_resource - Inserts a resource between two existing resources
+ * @parent
+ * @new
+ *
+ * Returns 0 on success, -EBUSY if the resource can't be inserted.
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
+++ linuxppc-2.5-benh/kernel/ksyms.c	2003-10-04 23:21:20.000000000 +0200
@@ -256,6 +256,7 @@
 EXPORT_SYMBOL(request_resource);
 EXPORT_SYMBOL(release_resource);
 EXPORT_SYMBOL(allocate_resource);
+EXPORT_SYMBOL(insert_resource);
 EXPORT_SYMBOL(__request_region);
 EXPORT_SYMBOL(__check_region);
 EXPORT_SYMBOL(__release_region);
--- linux-2.5/include/linux/ioport.h	2003-10-04 22:20:17.000000000 +0200
+++ linuxppc-2.5-benh/include/linux/ioport.h	2003-10-03 14:06:46.000000000 +0200
@@ -90,6 +90,7 @@
 
 extern int request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
+extern int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     unsigned long size,
 			     unsigned long min, unsigned long max,


