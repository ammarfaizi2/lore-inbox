Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWJADro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWJADro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 23:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWJADro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 23:47:44 -0400
Received: from xenotime.net ([66.160.160.81]:29090 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751837AbWJADrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 23:47:43 -0400
Date: Sat, 30 Sep 2006 20:49:02 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc for kernel/resource.c
Message-Id: <20060930204902.fe751378.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add kernel-doc function headers in kernel/resource.c and use them
in DocBook.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    1 
 kernel/resource.c                     |   83 +++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 11 deletions(-)

--- linux-2618-g12.orig/kernel/resource.c
+++ linux-2618-g12/kernel/resource.c
@@ -193,6 +193,13 @@ static int __release_resource(struct res
 	return -EINVAL;
 }
 
+/**
+ * request_resource - request and reserve an I/O or memory resource
+ * @root: root resource descriptor
+ * @new: resource descriptor desired by caller
+ *
+ * Returns 0 for success, negative error code on error.
+ */
 int request_resource(struct resource *root, struct resource *new)
 {
 	struct resource *conflict;
@@ -205,6 +212,15 @@ int request_resource(struct resource *ro
 
 EXPORT_SYMBOL(request_resource);
 
+/**
+ * ____request_resource - reserve a resource, with resource conflict returned
+ * @root: root resource descriptor
+ * @new: resource descriptor desired by caller
+ *
+ * Returns:
+ * On success, NULL is returned.
+ * On error, a pointer to the conflicting resource is returned.
+ */
 struct resource *____request_resource(struct resource *root, struct resource *new)
 {
 	struct resource *conflict;
@@ -217,6 +233,10 @@ struct resource *____request_resource(st
 
 EXPORT_SYMBOL(____request_resource);
 
+/**
+ * release_resource - release a previously reserved resource
+ * @old: resource pointer
+ */
 int release_resource(struct resource *old)
 {
 	int retval;
@@ -315,8 +335,16 @@ static int find_resource(struct resource
 	return -EBUSY;
 }
 
-/*
- * Allocate empty slot in the resource tree given range and alignment.
+/**
+ * allocate_resource - allocate empty slot in the resource tree given range & alignment
+ * @root: root resource descriptor
+ * @new: resource descriptor desired by caller
+ * @size: requested resource region size
+ * @min: minimum size to allocate
+ * @max: maximum size to allocate
+ * @align: alignment requested, in bytes
+ * @alignf: alignment function, optional, called if not NULL
+ * @alignf_data: arbitrary data to pass to the @alignf function
  */
 int allocate_resource(struct resource *root, struct resource *new,
 		      resource_size_t size, resource_size_t min,
@@ -407,10 +435,15 @@ int insert_resource(struct resource *par
 	return result;
 }
 
-/*
+/**
+ * adjust_resource - modify a resource's start and size
+ * @res: resource to modify
+ * @start: new start value
+ * @size: new size
+ *
  * Given an existing resource, change its start and size to match the
- * arguments.  Returns -EBUSY if it can't fit.  Existing children of
- * the resource are assumed to be immutable.
+ * arguments.  Returns 0 on success, -EBUSY if it can't fit.
+ * Existing children of the resource are assumed to be immutable.
  */
 int adjust_resource(struct resource *res, resource_size_t start, resource_size_t size)
 {
@@ -456,11 +489,19 @@ EXPORT_SYMBOL(adjust_resource);
  * Note how this, unlike the above, knows about
  * the IO flag meanings (busy etc).
  *
- * Request-region creates a new busy region.
+ * request_region creates a new busy region.
  *
- * Check-region returns non-zero if the area is already busy
+ * check_region returns non-zero if the area is already busy.
  *
- * Release-region releases a matching busy region.
+ * release_region releases a matching busy region.
+ */
+
+/**
+ * __request_region - create a new busy resource region
+ * @parent: parent resource descriptor
+ * @start: resource start address
+ * @n: resource region size
+ * @name: reserving caller's ID string
  */
 struct resource * __request_region(struct resource *parent,
 				   resource_size_t start, resource_size_t n,
@@ -497,9 +538,23 @@ struct resource * __request_region(struc
 	}
 	return res;
 }
-
 EXPORT_SYMBOL(__request_region);
 
+/**
+ * __check_region - check if a resource region is busy or free
+ * @parent: parent resource descriptor
+ * @start: resource start address
+ * @n: resource region size
+ *
+ * Returns 0 if the region is free at the moment it is checked,
+ * returns %-EBUSY if the region is busy.
+ *
+ * NOTE:
+ * This function is deprecated because its use is racy.
+ * Even if it returns 0, a subsequent call to request_region()
+ * may fail because another driver etc. just allocated the region.
+ * Do NOT use it.  It will be removed from the kernel.
+ */
 int __check_region(struct resource *parent, resource_size_t start,
 			resource_size_t n)
 {
@@ -513,9 +568,16 @@ int __check_region(struct resource *pare
 	kfree(res);
 	return 0;
 }
-
 EXPORT_SYMBOL(__check_region);
 
+/**
+ * __release_region - release a previously reserved resource region
+ * @parent: parent resource descriptor
+ * @start: resource start address
+ * @n: resource region size
+ *
+ * The described resource region must match a currently busy region.
+ */
 void __release_region(struct resource *parent, resource_size_t start,
 			resource_size_t n)
 {
@@ -553,7 +615,6 @@ void __release_region(struct resource *p
 		"<%016llx-%016llx>\n", (unsigned long long)start,
 		(unsigned long long)end);
 }
-
 EXPORT_SYMBOL(__release_region);
 
 /*
--- linux-2618-g12.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2618-g12/Documentation/DocBook/kernel-api.tmpl
@@ -331,6 +331,7 @@ X!Ekernel/module.c
 
      <sect1><title>Resources Management</title>
 !Ikernel/resource.c
+!Ekernel/resource.c
      </sect1>
 
      <sect1><title>MTRR Handling</title>


---
