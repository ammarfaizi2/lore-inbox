Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWF0QjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWF0QjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWF0Qh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:56 -0400
Received: from ns.suse.de ([195.135.220.2]:31190 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161184AbWF0Qho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:44 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 12/17] [PATCH] 64bit resource: change resource core to use resource_size_t
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:48 -0700
Message-Id: <11514260722341-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260692919-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com> <11514260612035-git-send-email-greg@kroah.com> <11514260651070-git-send-email-greg@kroah.com> <11514260692919-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/sparc/kernel/ioport.c |    4 ++--
 include/linux/ioport.h     |   23 +++++++++++++----------
 kernel/resource.c          |   34 ++++++++++++++++++----------------
 3 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 99d716b..79d1771 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -208,7 +208,7 @@ _sparc_ioremap(struct resource *res, u32
 	pa &= PAGE_MASK;
 	sparc_mapiorange(bus, pa, res->start, res->end - res->start + 1);
 
-	return (void __iomem *) (res->start + offset);
+	return (void __iomem *)(unsigned long)(res->start + offset);
 }
 
 /*
@@ -325,7 +325,7 @@ void *sbus_alloc_consistent(struct sbus_
 		res->name = sdev->prom_name;
 	}
 
-	return (void *)res->start;
+	return (void *)(unsigned long)res->start;
 
 err_noiommu:
 	release_resource(res);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 535bd95..d489523 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -98,31 +98,34 @@ extern struct resource * ____request_res
 extern int release_resource(struct resource *new);
 extern __deprecated_for_modules int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
-			     unsigned long size,
-			     unsigned long min, unsigned long max,
-			     unsigned long align,
+			     resource_size_t size, resource_size_t min,
+			     resource_size_t max, resource_size_t align,
 			     void (*alignf)(void *, struct resource *,
-					    unsigned long, unsigned long),
+					    resource_size_t, resource_size_t),
 			     void *alignf_data);
-int adjust_resource(struct resource *res, unsigned long start,
-		    unsigned long size);
+int adjust_resource(struct resource *res, resource_size_t start,
+		    resource_size_t size);
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name))
 #define rename_region(region, newname) do { (region)->name = (newname); } while (0)
 
-extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
+extern struct resource * __request_region(struct resource *,
+					resource_size_t start,
+					resource_size_t n, const char *name);
 
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __check_region(struct resource *, unsigned long, unsigned long);
-extern void __release_region(struct resource *, unsigned long, unsigned long);
+extern int __check_region(struct resource *, resource_size_t, resource_size_t);
+extern void __release_region(struct resource *, resource_size_t,
+				resource_size_t);
 
-static inline int __deprecated check_region(unsigned long s, unsigned long n)
+static inline int __deprecated check_region(resource_size_t s,
+						resource_size_t n)
 {
 	return __check_region(&ioport_resource, s, n);
 }
diff --git a/kernel/resource.c b/kernel/resource.c
index ea5f781..54835c0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -151,8 +151,8 @@ #endif /* CONFIG_PROC_FS */
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
-	unsigned long start = new->start;
-	unsigned long end = new->end;
+	resource_size_t start = new->start;
+	resource_size_t end = new->end;
 	struct resource *tmp, **p;
 
 	if (end < start)
@@ -236,11 +236,10 @@ EXPORT_SYMBOL(release_resource);
  * Find empty slot in the resource tree given range and alignment.
  */
 static int find_resource(struct resource *root, struct resource *new,
-			 unsigned long size,
-			 unsigned long min, unsigned long max,
-			 unsigned long align,
+			 resource_size_t size, resource_size_t min,
+			 resource_size_t max, resource_size_t align,
 			 void (*alignf)(void *, struct resource *,
-					unsigned long, unsigned long),
+					resource_size_t, resource_size_t),
 			 void *alignf_data)
 {
 	struct resource *this = root->child;
@@ -282,11 +281,10 @@ static int find_resource(struct resource
  * Allocate empty slot in the resource tree given range and alignment.
  */
 int allocate_resource(struct resource *root, struct resource *new,
-		      unsigned long size,
-		      unsigned long min, unsigned long max,
-		      unsigned long align,
+		      resource_size_t size, resource_size_t min,
+		      resource_size_t max, resource_size_t align,
 		      void (*alignf)(void *, struct resource *,
-				     unsigned long, unsigned long),
+				     resource_size_t, resource_size_t),
 		      void *alignf_data)
 {
 	int err;
@@ -378,10 +376,10 @@ EXPORT_SYMBOL(insert_resource);
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of
  * the resource are assumed to be immutable.
  */
-int adjust_resource(struct resource *res, unsigned long start, unsigned long size)
+int adjust_resource(struct resource *res, resource_size_t start, resource_size_t size)
 {
 	struct resource *tmp, *parent = res->parent;
-	unsigned long end = start + size - 1;
+	resource_size_t end = start + size - 1;
 	int result = -EBUSY;
 
 	write_lock(&resource_lock);
@@ -428,7 +426,9 @@ EXPORT_SYMBOL(adjust_resource);
  *
  * Release-region releases a matching busy region.
  */
-struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
+struct resource * __request_region(struct resource *parent,
+				   resource_size_t start, resource_size_t n,
+				   const char *name)
 {
 	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
 
@@ -464,7 +464,8 @@ struct resource * __request_region(struc
 
 EXPORT_SYMBOL(__request_region);
 
-int __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __check_region(struct resource *parent, resource_size_t start,
+			resource_size_t n)
 {
 	struct resource * res;
 
@@ -479,10 +480,11 @@ int __check_region(struct resource *pare
 
 EXPORT_SYMBOL(__check_region);
 
-void __release_region(struct resource *parent, unsigned long start, unsigned long n)
+void __release_region(struct resource *parent, resource_size_t start,
+			resource_size_t n)
 {
 	struct resource **p;
-	unsigned long end;
+	resource_size_t end;
 
 	p = &parent->child;
 	end = start + n - 1;
-- 
1.4.0

