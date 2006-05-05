Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWEER27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWEER27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWEER26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:28:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:25480 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751641AbWEER26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:28:58 -0400
Date: Fri, 5 May 2006 13:28:47 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH 1/6] kconfigurable resources core changes
Message-ID: <20060505172847.GC6450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Core changes for Kconfigurable memory and IO resources. By default resources
  are 64bit until chosen to be 32bit.

o Last time I posted the patches for 64bit memory resources but it raised
  the concerns regarding code bloat on 32bit systems who use 32 bit
  resources.

o This patch-set allows resources to be kconfigurable.

o I have done cross compilation on i386, x86_64, ppc, powerpc, sparc, sparc64
  ia64 and alpha.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 include/linux/ioport.h |   24 ++++++++++++++----------
 include/linux/types.h  |    6 ++++++
 kernel/resource.c      |   45 ++++++++++++++++++++++++++++-----------------
 3 files changed, 48 insertions(+), 27 deletions(-)

diff -puN include/linux/types.h~kconfigurable-resources-core-changes include/linux/types.h
--- linux-2.6.17-rc3-mm1-1M/include/linux/types.h~kconfigurable-resources-core-changes	2006-05-05 11:53:24.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/include/linux/types.h	2006-05-05 11:53:24.000000000 -0400
@@ -146,6 +146,12 @@ typedef u64 blkcnt_t;
 typedef unsigned long blkcnt_t;
 #endif
 
+#ifdef CONFIG_RESOURCES_32BIT
+typedef u32 resource_size_t;
+#else
+typedef u64 resource_size_t;
+#endif
+
 /*
  * The type of an index into the pagecache.  Use a #define so asm/types.h
  * can override it.
diff -puN include/linux/ioport.h~kconfigurable-resources-core-changes include/linux/ioport.h
--- linux-2.6.17-rc3-mm1-1M/include/linux/ioport.h~kconfigurable-resources-core-changes	2006-05-05 11:53:24.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/include/linux/ioport.h	2006-05-05 11:53:24.000000000 -0400
@@ -15,7 +15,7 @@
  * nesting etc..
  */
 struct resource {
-	u64 start, end;
+	resource_size_t start, end;
 	const char *name;
 	unsigned long flags;
 	struct resource *parent, *sibling, *child;
@@ -97,13 +97,13 @@ extern struct resource * ____request_res
 extern int release_resource(struct resource *new);
 extern int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
-			     u64 size,
-			     u64 min, u64 max,
-			     u64 align,
+			     resource_size_t size, resource_size_t min,
+			     resource_size_t max, resource_size_t align,
 			     void (*alignf)(void *, struct resource *,
-					    u64, u64),
+					    resource_size_t, resource_size_t),
 			     void *alignf_data);
-int adjust_resource(struct resource *res, u64 start, u64 size);
+int adjust_resource(struct resource *res, resource_size_t start,
+			resource_size_t size);
 
 /* get registered SYSTEM_RAM resources in specified area */
 extern int find_next_system_ram(struct resource *res);
@@ -113,17 +113,21 @@ extern int find_next_system_ram(struct r
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name))
 #define rename_region(region, newname) do { (region)->name = (newname); } while (0)
 
-extern struct resource * __request_region(struct resource *, u64 start, u64 n, const char *name);
+extern struct resource * __request_region(struct resource *,
+					resource_size_t start,
+					resource_size_t n, const char *name);
 
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __check_region(struct resource *, u64, u64);
-extern void __release_region(struct resource *, u64, u64);
+extern int __check_region(struct resource *, resource_size_t, resource_size_t);
+extern void __release_region(struct resource *, resource_size_t,
+				resource_size_t);
 
-static inline int __deprecated check_region(u64 s, u64 n)
+static inline int __deprecated check_region(resource_size_t s,
+						resource_size_t n)
 {
 	return __check_region(&ioport_resource, s, n);
 }
diff -puN kernel/resource.c~kconfigurable-resources-core-changes kernel/resource.c
--- linux-2.6.17-rc3-mm1-1M/kernel/resource.c~kconfigurable-resources-core-changes	2006-05-05 11:53:24.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/kernel/resource.c	2006-05-05 11:53:24.000000000 -0400
@@ -23,7 +23,11 @@
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
+#ifdef CONFIG_RESOURCES_32BIT
+	.start	= 0x0000UL,
+#else
 	.start	= 0x0000ULL,
+#endif
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
@@ -32,8 +36,13 @@ EXPORT_SYMBOL(ioport_resource);
 
 struct resource iomem_resource = {
 	.name	= "PCI mem",
+#ifdef CONFIG_RESOURCES_32BIT
+	.start	= 0UL,
+	.end	= ~0UL,
+#else
 	.start	= 0ULL,
 	.end	= ~0ULL,
+#endif
 	.flags	= IORESOURCE_MEM,
 };
 
@@ -151,8 +160,8 @@ __initcall(ioresources_init);
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
-	u64 start = new->start;
-	u64 end = new->end;
+	resource_size_t start = new->start;
+	resource_size_t end = new->end;
 	struct resource *tmp, **p;
 
 	if (end < start)
@@ -250,7 +259,7 @@ EXPORT_SYMBOL(release_resource);
  */
 int find_next_system_ram(struct resource *res)
 {
-	u64 start, end;
+	resource_size_t start, end;
 	struct resource *p;
 
 	BUG_ON(!res);
@@ -284,11 +293,10 @@ int find_next_system_ram(struct resource
  * Find empty slot in the resource tree given range and alignment.
  */
 static int find_resource(struct resource *root, struct resource *new,
-			 u64 size,
-			 u64 min, u64 max,
-			 u64 align,
+			 resource_size_t size, resource_size_t min,
+			 resource_size_t max, resource_size_t align,
 			 void (*alignf)(void *, struct resource *,
-					u64, u64),
+					resource_size_t, resource_size_t),
 			 void *alignf_data)
 {
 	struct resource *this = root->child;
@@ -330,11 +338,10 @@ static int find_resource(struct resource
  * Allocate empty slot in the resource tree given range and alignment.
  */
 int allocate_resource(struct resource *root, struct resource *new,
-		      u64 size,
-		      u64 min, u64 max,
-		      u64 align,
+		      resource_size_t size, resource_size_t min,
+		      resource_size_t max, resource_size_t align,
 		      void (*alignf)(void *, struct resource *,
-				     u64, u64),
+				     resource_size_t, resource_size_t),
 		      void *alignf_data)
 {
 	int err;
@@ -424,10 +431,10 @@ int insert_resource(struct resource *par
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of
  * the resource are assumed to be immutable.
  */
-int adjust_resource(struct resource *res, u64 start, u64 size)
+int adjust_resource(struct resource *res, resource_size_t start, resource_size_t size)
 {
 	struct resource *tmp, *parent = res->parent;
-	u64 end = start + size - 1;
+	resource_size_t end = start + size - 1;
 	int result = -EBUSY;
 
 	write_lock(&resource_lock);
@@ -474,7 +481,9 @@ EXPORT_SYMBOL(adjust_resource);
  *
  * Release-region releases a matching busy region.
  */
-struct resource * __request_region(struct resource *parent, u64 start, u64 n, const char *name)
+struct resource * __request_region(struct resource *parent,
+				   resource_size_t start, resource_size_t n,
+				   const char *name)
 {
 	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
 
@@ -510,7 +519,8 @@ struct resource * __request_region(struc
 
 EXPORT_SYMBOL(__request_region);
 
-int __check_region(struct resource *parent, u64 start, u64 n)
+int __check_region(struct resource *parent, resource_size_t start,
+			resource_size_t n)
 {
 	struct resource * res;
 
@@ -525,10 +535,11 @@ int __check_region(struct resource *pare
 
 EXPORT_SYMBOL(__check_region);
 
-void __release_region(struct resource *parent, u64 start, u64 n)
+void __release_region(struct resource *parent, resource_size_t start,
+			resource_size_t n)
 {
 	struct resource **p;
-	u64 end;
+	resource_size_t end;
 
 	p = &parent->child;
 	end = start + n - 1;
_
