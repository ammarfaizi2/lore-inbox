Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWCWUAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWCWUAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCWUAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:00:19 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35477 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751461AbWCWUAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:00:17 -0500
Date: Thu, 23 Mar 2006 14:59:44 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 1/10] 64 bit resources core changes
Message-ID: <20060323195944.GE7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323195752.GD7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Core changes for 64bit resources. Changes start and end field to u64
  from unsigned long.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 include/linux/ioport.h |   23 ++++++++++++-----------
 kernel/resource.c      |   48 +++++++++++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff -puN include/linux/ioport.h~64bit-resources-core-changes include/linux/ioport.h
--- linux-2.6.16-mm1/include/linux/ioport.h~64bit-resources-core-changes	2006-03-23 11:38:53.000000000 -0500
+++ linux-2.6.16-mm1-root/include/linux/ioport.h	2006-03-23 11:38:53.000000000 -0500
@@ -9,13 +9,14 @@
 #define _LINUX_IOPORT_H
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
  */
 struct resource {
+	u64 start, end;
 	const char *name;
-	unsigned long start, end;
 	unsigned long flags;
 	struct resource *parent, *sibling, *child;
 };
@@ -96,31 +97,31 @@ extern struct resource * ____request_res
 extern int release_resource(struct resource *new);
 extern __deprecated_for_modules int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
-			     unsigned long size,
-			     unsigned long min, unsigned long max,
-			     unsigned long align,
+			     u64 size,
+			     u64 min, u64 max,
+			     u64 align,
 			     void (*alignf)(void *, struct resource *,
-					    unsigned long, unsigned long),
+					    u64, u64),
 			     void *alignf_data);
-int adjust_resource(struct resource *res, unsigned long start,
-		    unsigned long size);
+int adjust_resource(struct resource *res, u64 start,
+		    u64 size);
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name))
 #define rename_region(region, newname) do { (region)->name = (newname); } while (0)
 
-extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
+extern struct resource * __request_region(struct resource *, u64 start, u64 n, const char *name);
 
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __check_region(struct resource *, unsigned long, unsigned long);
-extern void __release_region(struct resource *, unsigned long, unsigned long);
+extern int __check_region(struct resource *, u64, u64);
+extern void __release_region(struct resource *, u64, u64);
 
-static inline int __deprecated check_region(unsigned long s, unsigned long n)
+static inline int __deprecated check_region(u64 s, u64 n)
 {
 	return __check_region(&ioport_resource, s, n);
 }
diff -puN kernel/resource.c~64bit-resources-core-changes kernel/resource.c
--- linux-2.6.16-mm1/kernel/resource.c~64bit-resources-core-changes	2006-03-23 11:38:53.000000000 -0500
+++ linux-2.6.16-mm1-root/kernel/resource.c	2006-03-23 11:38:53.000000000 -0500
@@ -23,7 +23,7 @@
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
-	.start	= 0x0000,
+	.start	= 0x0000ULL,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
@@ -32,8 +32,8 @@ EXPORT_SYMBOL(ioport_resource);
 
 struct resource iomem_resource = {
 	.name	= "PCI mem",
-	.start	= 0UL,
-	.end	= ~0UL,
+	.start	= 0ULL,
+	.end	= ~0ULL,
 	.flags	= IORESOURCE_MEM,
 };
 
@@ -83,10 +83,10 @@ static int r_show(struct seq_file *m, vo
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
 		if (p->parent == root)
 			break;
-	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
+	seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
 			depth * 2, "",
-			width, r->start,
-			width, r->end,
+			width, (unsigned long long) r->start,
+			width, (unsigned long long) r->end,
 			r->name ? r->name : "<BAD>");
 	return 0;
 }
@@ -151,8 +151,8 @@ __initcall(ioresources_init);
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
-	unsigned long start = new->start;
-	unsigned long end = new->end;
+	u64 start = new->start;
+	u64 end = new->end;
 	struct resource *tmp, **p;
 
 	if (end < start)
@@ -246,11 +246,11 @@ EXPORT_SYMBOL(release_resource);
  * Find empty slot in the resource tree given range and alignment.
  */
 static int find_resource(struct resource *root, struct resource *new,
-			 unsigned long size,
-			 unsigned long min, unsigned long max,
-			 unsigned long align,
+			 u64 size,
+			 u64 min, u64 max,
+			 u64 align,
 			 void (*alignf)(void *, struct resource *,
-					unsigned long, unsigned long),
+					u64, u64),
 			 void *alignf_data)
 {
 	struct resource *this = root->child;
@@ -292,11 +292,11 @@ static int find_resource(struct resource
  * Allocate empty slot in the resource tree given range and alignment.
  */
 int allocate_resource(struct resource *root, struct resource *new,
-		      unsigned long size,
-		      unsigned long min, unsigned long max,
-		      unsigned long align,
+		      u64 size,
+		      u64 min, u64 max,
+		      u64 align,
 		      void (*alignf)(void *, struct resource *,
-				     unsigned long, unsigned long),
+				     u64, u64),
 		      void *alignf_data)
 {
 	int err;
@@ -388,10 +388,10 @@ EXPORT_SYMBOL(insert_resource);
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of
  * the resource are assumed to be immutable.
  */
-int adjust_resource(struct resource *res, unsigned long start, unsigned long size)
+int adjust_resource(struct resource *res, u64 start, u64 size)
 {
 	struct resource *tmp, *parent = res->parent;
-	unsigned long end = start + size - 1;
+	u64 end = start + size - 1;
 	int result = -EBUSY;
 
 	write_lock(&resource_lock);
@@ -438,7 +438,7 @@ EXPORT_SYMBOL(adjust_resource);
  *
  * Release-region releases a matching busy region.
  */
-struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
+struct resource * __request_region(struct resource *parent, u64 start, u64 n, const char *name)
 {
 	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
 
@@ -474,7 +474,7 @@ struct resource * __request_region(struc
 
 EXPORT_SYMBOL(__request_region);
 
-int __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __check_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource * res;
 
@@ -489,10 +489,10 @@ int __check_region(struct resource *pare
 
 EXPORT_SYMBOL(__check_region);
 
-void __release_region(struct resource *parent, unsigned long start, unsigned long n)
+void __release_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource **p;
-	unsigned long end;
+	u64 end;
 
 	p = &parent->child;
 	end = start + n - 1;
@@ -521,7 +521,9 @@ void __release_region(struct resource *p
 
 	write_unlock(&resource_lock);
 
-	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
+	printk(KERN_WARNING "Trying to free nonexistent resource "
+		"<%16llx-%16llx>\n", (unsigned long long)start,
+		(unsigned long long) end);
 }
 
 EXPORT_SYMBOL(__release_region);
_
