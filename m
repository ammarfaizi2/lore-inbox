Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbSJ3Ben>; Tue, 29 Oct 2002 20:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJ3Ben>; Tue, 29 Oct 2002 20:34:43 -0500
Received: from dp.samba.org ([66.70.73.150]:9393 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262914AbSJ3Bel>;
	Tue, 29 Oct 2002 20:34:41 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, dhinds@zen.stanford.edu, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Get rid of check_resource() before it becomes a problem
Date: Wed, 30 Oct 2002 12:40:14 +1100
Message-Id: <20021030014105.1A9F82C47A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICT, it has the same race issues as the old check_region() which is
being slowly and painfully eliminated.

Remove the temptation, and open-code the one user (PCMCIA).

Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.44/drivers/pcmcia/rsrc_mgr.c working-2.5.44-proc-register/drivers/pcmcia/rsrc_mgr.c
--- linux-2.5.44/drivers/pcmcia/rsrc_mgr.c	2002-10-15 15:29:59.000000000 +1000
+++ working-2.5.44-proc-register/drivers/pcmcia/rsrc_mgr.c	2002-10-30 12:35:20.000000000 +1100
@@ -124,16 +124,36 @@ static struct resource *resource_parent(
 	return &ioport_resource;
 }
 
+/* FIXME: Fundamentally racy. */
 static inline int check_io_resource(unsigned long b, unsigned long n,
 				    struct pci_dev *dev)
 {
-	return check_resource(resource_parent(b, n, IORESOURCE_IO, dev), b, n);
+	struct resource *region;
+
+	region = __request_region(resource_parent(b, n, IORESOURCE_IO, dev),
+				  b, n, "check_io_resource");
+	if (!region)
+		return -EBUSY;
+
+	release_resource(region);
+	kfree(region);
+	return 0;
 }
 
+/* FIXME: Fundamentally racy. */
 static inline int check_mem_resource(unsigned long b, unsigned long n,
 				     struct pci_dev *dev)
 {
-	return check_resource(resource_parent(b, n, IORESOURCE_MEM, dev), b, n);
+	struct resource *region;
+
+	region = __request_region(resource_parent(b, n, IORESOURCE_MEM, dev),
+				  b, n, "check_mem_resource");
+	if (!region)
+		return -EBUSY;
+
+	release_resource(region);
+	kfree(region);
+	return 0;
 }
 
 static struct resource *make_resource(unsigned long b, unsigned long n,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.44/include/linux/ioport.h working-2.5.44-proc-register/include/linux/ioport.h
--- linux-2.5.44/include/linux/ioport.h	2002-05-09 12:40:19.000000000 +1000
+++ working-2.5.44-proc-register/include/linux/ioport.h	2002-10-30 12:25:54.000000000 +1100
@@ -85,7 +85,6 @@ extern struct resource iomem_resource;
 
 extern int get_resource_list(struct resource *, char *buf, int size);
 
-extern int check_resource(struct resource *root, unsigned long, unsigned long);
 extern int request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.44/kernel/resource.c working-2.5.44-proc-register/kernel/resource.c
--- linux-2.5.44/kernel/resource.c	2002-08-11 15:31:43.000000000 +1000
+++ working-2.5.44-proc-register/kernel/resource.c	2002-10-30 12:26:12.000000000 +1100
@@ -131,20 +131,6 @@ int release_resource(struct resource *ol
 	return retval;
 }
 
-int check_resource(struct resource *root, unsigned long start, unsigned long len)
-{
-	struct resource *conflict, tmp;
-
-	tmp.start = start;
-	tmp.end = start + len - 1;
-	write_lock(&resource_lock);
-	conflict = __request_resource(root, &tmp);
-	if (!conflict)
-		__release_resource(&tmp);
-	write_unlock(&resource_lock);
-	return conflict ? -EBUSY : 0;
-}
-
 /*
  * Find empty slot in the resource tree given range and alignment.
  */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
