Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTI3VFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTI3VFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:05:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46533 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261723AbTI3VEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:04:11 -0400
Date: Tue, 30 Sep 2003 22:04:10 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] expand_resource
Message-ID: <20030930210410.GD24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rewrite expand_resource() to be racefree and move it to kernel/resource.c.

Index: linux-2.6/kernel/resource.c
===================================================================
RCS file: /var/cvs/linux-2.6/kernel/resource.c,v
retrieving revision 1.3.2.1
retrieving revision 1.4
diff -u -p -r1.3.2.1 -r1.4
--- linux-2.6/kernel/resource.c	28 Sep 2003 02:27:48 -0000	1.3.2.1
+++ linux-2.6/kernel/resource.c	28 Sep 2003 04:06:24 -0000	1.4
@@ -266,6 +268,53 @@ int allocate_resource(struct resource *r
 		err = -EBUSY;
 	write_unlock(&resource_lock);
 	return err;
+}
+
+/*
+ * Expand an existing resource by size amount.
+ */
+int expand_resource(struct resource *res, unsigned long size,
+			   unsigned long align)
+{
+	unsigned long start, end;
+
+	/* see if we can expand above */
+	end = (res->end + size + align - 1) & ~(align - 1);
+
+	write_lock(&resource_lock);
+	if (res->sibling) {
+		if (res->sibling->start > end)
+			goto end;
+	} else {
+		if (res->parent->end >= end)
+			goto end;
+	}
+
+	/* now try below */
+	start = ((res->start - size + align) & ~(align - 1)) - align;
+
+	if (res->parent->child == res) {
+		if (res->start <= start)
+			goto start;
+	} else {
+		struct resource *prev = res->parent->child;
+		while (prev->sibling != res)
+			prev = prev->sibling;
+		if (prev->end < start)
+			goto start;
+	}
+
+	write_unlock(&resource_lock);
+	return -ENOMEM;
+
+ start:
+	res->start = start;
+	write_unlock(&resource_lock);
+	return 0;
+ end:
+	res->end = end;
+	write_unlock(&resource_lock);
+	return 0;
 }
 
 /*
Index: linux-2.6/drivers/parisc/ccio-dma.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/parisc/ccio-dma.c,v
retrieving revision 1.7.2.1
retrieving revision 1.7
diff -u -p -r1.7.2.1 -r1.7
--- linux-2.6/drivers/parisc/ccio-dma.c	28 Sep 2003 02:27:09 -0000	1.7.2.1
+++ linux-2.6/drivers/parisc/ccio-dma.c	27 Sep 2003 20:03:16 -0000	1.7
@@ -1534,42 +1534,6 @@ static void __init ccio_init_resources(s
 			(unsigned long)&ioc->ioc_hpa->io_io_low_hv);
 }
 
-static int expand_resource(struct resource *res, unsigned long size,
-			   unsigned long align)
-{
-	struct resource *temp_res;
-	unsigned long start = res->start;
-	unsigned long end ;
-
-	/* see if we can expand above */
-	end = (res->end + size + align - 1) & ~(align - 1);;
-	
-	temp_res = __request_region(res->parent, res->end, end - res->end,
-				    "expansion");
-	if(!temp_res) {
-		/* now try below */
-		start = ((res->start - size + align) & ~(align - 1)) - align;
-		end = res->end;
-		temp_res = __request_region(res->parent, start, size,
-					    "expansion");	
-		if(!temp_res) {
-			return -ENOMEM;
-		}
-	} 
-	release_resource(temp_res);
-	temp_res = res->parent;
-	release_resource(res);
-	res->start = start;
-	res->end = end;
-
-	/* This could be caused by some sort of race.  Basically, if
-	 * this tripped something stole the region we just reserved
-	 * and then released to check for expansion */
-	BUG_ON(request_resource(temp_res, res) != 0);
-
-	return 0;
-}
-
 static void expand_ioc_area(struct resource *parent, struct ioc *ioc,
 			    unsigned long size,	unsigned long min,
 			    unsigned long max, unsigned long align)
Index: linux-2.6/include/linux/ioport.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/ioport.h,v
retrieving revision 1.2.2.1
retrieving revision 1.2
diff -u -p -r1.2.2.1 -r1.2
--- linux-2.6/include/linux/ioport.h	28 Sep 2003 02:27:45 -0000	1.2.2.1
+++ linux-2.6/include/linux/ioport.h	27 Sep 2003 20:03:18 -0000	1.2
@@ -97,6 +97,8 @@ extern int allocate_resource(struct reso
 			     void (*alignf)(void *, struct resource *,
 					    unsigned long, unsigned long),
 			     void *alignf_data);
+int expand_resource(struct resource *res, unsigned long size,
+		    unsigned long align);
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
