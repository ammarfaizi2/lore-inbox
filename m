Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSJ3DlW>; Tue, 29 Oct 2002 22:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSJ3DlV>; Tue, 29 Oct 2002 22:41:21 -0500
Received: from dp.samba.org ([66.70.73.150]:11227 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263837AbSJ3DlT>;
	Tue, 29 Oct 2002 22:41:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       dhinds@zen.stanford.edu, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Get rid of check_resource() before it becomes a problem 
In-reply-to: Your message of "Tue, 29 Oct 2002 21:33:28 CDT."
             <3DBF44F8.8010307@pobox.com> 
Date: Wed, 30 Oct 2002 14:15:01 +1100
Message-Id: <20021030034743.A05AA2C0DD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DBF44F8.8010307@pobox.com> you write:
> Need to zap the export from kernel/ksyms.c too

Ack.

Here it is, fresh against 2.5.44.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Remove inherently racy check_resource
Author: Rusty Russell
Status: Trivial

D: The new resource interface foolishly replicated the (obsolete,
D: racy) spirit of the check_region call as check_resource.  You
D: should use request_resource/release_resource instead.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8919-linux-2.5.45/drivers/pcmcia/rsrc_mgr.c .8919-linux-2.5.45.updated/drivers/pcmcia/rsrc_mgr.c
--- .8919-linux-2.5.45/drivers/pcmcia/rsrc_mgr.c	2002-10-15 15:29:59.000000000 +1000
+++ .8919-linux-2.5.45.updated/drivers/pcmcia/rsrc_mgr.c	2002-10-30 14:03:09.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8919-linux-2.5.45/include/linux/ioport.h .8919-linux-2.5.45.updated/include/linux/ioport.h
--- .8919-linux-2.5.45/include/linux/ioport.h	2002-05-09 12:40:19.000000000 +1000
+++ .8919-linux-2.5.45.updated/include/linux/ioport.h	2002-10-30 14:03:09.000000000 +1100
@@ -85,7 +85,6 @@ extern struct resource iomem_resource;
 
 extern int get_resource_list(struct resource *, char *buf, int size);
 
-extern int check_resource(struct resource *root, unsigned long, unsigned long);
 extern int request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8919-linux-2.5.45/kernel/ksyms.c .8919-linux-2.5.45.updated/kernel/ksyms.c
--- .8919-linux-2.5.45/kernel/ksyms.c	2002-10-30 12:53:10.000000000 +1100
+++ .8919-linux-2.5.45.updated/kernel/ksyms.c	2002-10-30 14:06:18.000000000 +1100
@@ -445,7 +445,6 @@ EXPORT_SYMBOL(enable_hlt);
 EXPORT_SYMBOL(request_resource);
 EXPORT_SYMBOL(release_resource);
 EXPORT_SYMBOL(allocate_resource);
-EXPORT_SYMBOL(check_resource);
 EXPORT_SYMBOL(__request_region);
 EXPORT_SYMBOL(__check_region);
 EXPORT_SYMBOL(__release_region);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8919-linux-2.5.45/kernel/resource.c .8919-linux-2.5.45.updated/kernel/resource.c
--- .8919-linux-2.5.45/kernel/resource.c	2002-08-11 15:31:43.000000000 +1000
+++ .8919-linux-2.5.45.updated/kernel/resource.c	2002-10-30 14:03:09.000000000 +1100
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
