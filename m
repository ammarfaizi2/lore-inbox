Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUBTWlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUBTWlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:41:04 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:943 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261335AbUBTWkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:40:40 -0500
Subject: [PATCH] 1/2 Make insert_resource work for alder IOAPIC resources
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Feb 2004 14:40:35 -0800
Message-Id: <1077316836.1886.8.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a necessary precursor patch for getting the Intel Alder
motherboard working (it has a PCI device corresponding to the IO-APIC
which has to be forcibly inserted into the machine's reserved memory
region).

Eric Biederman was going to come up with a more comprehensive fix, but
in the meantime, this is the minimum necessary to get insert_resource to
work when the covering region is larger than the resource being
inserted.

James

===== kernel/resource.c 1.20 vs edited =====
--- 1.20/kernel/resource.c	Wed Feb 18 19:43:09 2004
+++ edited/kernel/resource.c	Fri Feb 20 14:40:12 2004
@@ -306,11 +306,12 @@
  *
  * Returns 0 on success, -EBUSY if the resource can't be inserted.
  *
- * This function is equivalent of request_resource when no
- * conflict happens. If a conflict happens, and the conflicting
- * resources entirely fit within the range of the new resource,
- * then the new resource is inserted and the conflicting resources
- * become childs of the new resource. 
+ * This function is equivalent of request_resource when no conflict
+ * happens. If a conflict happens, and the conflicting resources
+ * entirely fit within the range of the new resource, then the new
+ * resource is inserted and the conflicting resources become childs of
+ * the new resource.  Otherwise the new resource becomes the child of
+ * the conflicting resource
  */
 int insert_resource(struct resource *parent, struct resource *new)
 {
@@ -318,6 +319,7 @@
 	struct resource *first, *next;
 
 	write_lock(&resource_lock);
+ begin:
 	first = __request_resource(parent, new);
 	if (!first)
 		goto out;
@@ -331,8 +333,10 @@
 			break;
 
 	/* existing resource overlaps end of new resource */
-	if (next->end > new->end)
-		goto out;
+	if (next->end > new->end) {
+		parent = next;
+		goto begin;
+	}
 
 	result = 0;
 

