Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSJQLsV>; Thu, 17 Oct 2002 07:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJQLr1>; Thu, 17 Oct 2002 07:47:27 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:5504 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261384AbSJQLev>; Thu, 17 Oct 2002 07:34:51 -0400
Date: Thu, 17 Oct 2002 20:40:03 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] add support for PC-9800 architecture (12/26) kernel
Message-ID: <20021017204003.A1217@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 12/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
  - add PC-9800 special features.
  - CLOCK_TICK is not constant.
  - odd/even only IO region mapping.

diffstat:
 include/linux/ioport.h |   14 ++++++
 kernel/dma.c           |    3 +
 kernel/resource.c      |  100 ++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/timer.c         |    5 ++
 4 files changed, 119 insertions(+), 3 deletions(-)

patch:
diff -urN linux/kernel/dma.c linux98/kernel/dma.c
--- linux/kernel/dma.c	Sun Aug 11 10:41:22 2002
+++ linux98/kernel/dma.c	Wed Aug 21 09:53:59 2002
@@ -9,6 +9,7 @@
  *   [It also happened to remove the sizeof(char *) == sizeof(int)
  *   assumption introduced because of those /proc/dma patches. -- Hennus]
  */
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -62,10 +63,12 @@
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 },
+#ifndef CONFIG_PC9800
 	{ 1, "cascade" },
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 }
+#endif
 };
 
 
diff -urN linux/kernel/resource.c linux98/kernel/resource.c
--- linux/kernel/resource.c	Fri May 10 10:07:53 2002
+++ linux98/kernel/resource.c	Fri May 10 10:19:19 2002
@@ -7,6 +7,7 @@
  * Arbitrary resource management.
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -15,6 +16,12 @@
 #include <linux/spinlock.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_PC9800
+/*
+#define RESOURCE98_DEBUG
+*/
+#endif
+
 struct resource ioport_resource = { "PCI IO", 0x0000, IO_SPACE_LIMIT, IORESOURCE_IO };
 struct resource iomem_resource = { "PCI mem", 0x00000000, 0xffffffff, IORESOURCE_MEM };
 
@@ -40,7 +47,13 @@
 		if (!name)
 			name = "<BAD>";
 
+#ifdef CONFIG_PC9800
+		buf += sprintf(buf, fmt + offset, from, to,
+			       entry->flags & IORESOURCE98_SPARSE ? '*' : ' ',
+			       name);
+#else
 		buf += sprintf(buf, fmt + offset, from, to, name);
+#endif
 		if (entry->child)
 			buf = do_resource_list(entry->child, fmt, offset-2, buf, end);
 		entry = entry->sibling;
@@ -54,9 +67,15 @@
 	char *fmt;
 	int retval;
 
+#ifdef CONFIG_PC9800
+	fmt = "        %08lx-%08lx%c : %s\n";
+	if (root->end < 0x10000)
+		fmt = "        %04lx-%04lx%c : %s\n";
+#else
 	fmt = "        %08lx-%08lx : %s\n";
 	if (root->end < 0x10000)
 		fmt = "        %04lx-%04lx : %s\n";
+#endif
 	read_lock(&resource_lock);
 	retval = do_resource_list(root->child, fmt, 8, buf, buf + size) - buf;
 	read_unlock(&resource_lock);
@@ -70,6 +89,11 @@
 	unsigned long end = new->end;
 	struct resource *tmp, **p;
 
+#ifdef RESOURCE98_DEBUG
+	printk(KERN_DEBUG "request_resource(): new={%lx-%lx%c, \"%s\"}\n",
+	       new->start, new->end,
+	       (new->flags&IORESOURCE98_SPARSE) ? '*' : ' ', new->name);
+#endif
 	if (end < start)
 		return root;
 	if (start < root->start)
@@ -79,7 +103,23 @@
 	p = &root->child;
 	for (;;) {
 		tmp = *p;
-		if (!tmp || tmp->start > end) {
+#ifdef RESOURCE98_DEBUG
+		if (tmp)
+			printk(KERN_DEBUG "request_resource(): "
+				"compare {%lx-%lx%c,\"%s\"}\n",
+				tmp->start, tmp->end,
+				(tmp->flags & IORESOURCE98_SPARSE) ? '*' : ' ',
+				tmp->name);
+#endif
+		if (!tmp || tmp->start > end
+#ifdef CONFIG_PC9800
+		    || ((tmp->flags & IORESOURCE98_SPARSE
+			 || tmp->end == tmp->start)
+			&& (new->flags & IORESOURCE98_SPARSE || end == start)
+			&& ((start ^ tmp->start) & 1) != 0
+			&& (tmp->start > start))
+#endif
+			) {
 			new->sibling = tmp;
 			*p = new;
 			new->parent = root;
@@ -88,6 +128,13 @@
 		p = &tmp->sibling;
 		if (tmp->end < start)
 			continue;
+#ifdef CONFIG_PC9800
+		if ((tmp->flags & IORESOURCE98_SPARSE
+		     || tmp->end == tmp->start)
+		    && (new->flags & IORESOURCE98_SPARSE || end == start)
+		    && ((start ^ tmp->start) & 1) != 0)
+			continue;
+#endif
 		return tmp;
 	}
 }
@@ -216,7 +263,11 @@
  *
  * Release-region releases a matching busy region.
  */
+#ifndef CONFIG_PC9800
 struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
+#else
+struct resource * __request_region(struct resource *parent, unsigned long start, long n, const char *name)
+#endif
 {
 	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
 
@@ -224,8 +275,15 @@
 		memset(res, 0, sizeof(*res));
 		res->name = name;
 		res->start = start;
-		res->end = start + n - 1;
 		res->flags = IORESOURCE_BUSY;
+#ifdef CONFIG_PC9800
+		if ((long) n < 0) {
+			n = -n;
+			if (n > 1)
+				res->flags |= IORESOURCE98_SPARSE;
+		}
+#endif
+		res->end = start + n - 1;
 
 		write_lock(&resource_lock);
 
@@ -251,7 +309,11 @@
 	return res;
 }
 
+#ifndef CONFIG_PC9800
 int __check_region(struct resource *parent, unsigned long start, unsigned long n)
+#else
+int __check_region(struct resource *parent, unsigned long start, long n)
+#endif
 {
 	struct resource * res;
 
@@ -264,12 +326,25 @@
 	return 0;
 }
 
+#ifndef CONFIG_PC9800
 void __release_region(struct resource *parent, unsigned long start, unsigned long n)
+#else
+void __release_region(struct resource *parent, unsigned long start, long n)
+#endif
 {
 	struct resource **p;
 	unsigned long end;
+#ifdef CONFIG_PC9800
+	unsigned long sparse_flag = 0;
+#endif
 
 	p = &parent->child;
+#ifdef CONFIG_PC9800
+	if ((long)n < 0) {
+		n = -n;
+		sparse_flag = IORESOURCE98_SPARSE;
+	}
+#endif
 	end = start + n - 1;
 
 	for (;;) {
@@ -277,11 +352,25 @@
 
 		if (!res)
 			break;
+#ifdef RESOURCE98_DEBUG
+		printk(KERN_DEBUG
+		       "__release_region(): compare {%lx-%lx%c,\"%s\"}\n",
+		       res->start, res->end,
+		       (res->flags & IORESOURCE98_SPARSE) ? '*' : ' ',
+		       res->name);
+#endif
 		if (res->start <= start && res->end >= end) {
 			if (!(res->flags & IORESOURCE_BUSY)) {
 				p = &res->child;
 				continue;
 			}
+#ifdef CONFIG_PC9800
+			if ((res->flags & IORESOURCE98_SPARSE) ^ sparse_flag) {
+				/* Sparseness does not match. */
+				p = &res->sibling;
+				continue;
+			}
+#endif
 			if (res->start != start || res->end != end)
 				break;
 			*p = res->sibling;
@@ -317,6 +406,13 @@
 			res->end = io_start + io_num - 1;
 			res->flags = IORESOURCE_BUSY;
 			res->child = NULL;
+#ifdef CONFIG_PC9800
+			if (io_num < 0) {
+				res->end = io_start - io_num - 1;
+				if (io_num < -1)
+					res->flags |= IORESOURCE98_SPARSE;
+			}
+#endif
 			if (request_resource(res->start >= 0x10000 ? &iomem_resource : &ioport_resource, res) == 0)
 				reserved = x+1;
 		}
diff -urN linux/kernel/timer.c linux98/kernel/timer.c
--- linux/kernel/timer.c	Sat Oct 12 13:21:36 2002
+++ linux98/kernel/timer.c	Sat Oct 12 14:18:54 2002
@@ -376,8 +376,13 @@
 /*
  * Timekeeping variables
  */
+#ifndef CONFIG_PC9800
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
 unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+#else
+extern unsigned long tick_usec; 		/* ACTHZ   period (usec) */
+extern unsigned long tick_nsec;			/* USER_HZ period (nsec) */
+#endif
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
diff -urN linux/include/linux/ioport.h linux98/include/linux/ioport.h
--- linux/include/linux/ioport.h	Fri May 10 10:07:53 2002
+++ linux98/include/linux/ioport.h	Fri May 10 10:19:19 2002
@@ -79,6 +79,10 @@
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
 
+#ifdef CONFIG_PC9800
+#define IORESOURCE98_SPARSE 0x100000 /* sparse region */
+#endif
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
@@ -99,8 +103,11 @@
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name))
-
+#ifndef CONFIG_PC9800
 extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
+#else
+extern struct resource * __request_region(struct resource *, unsigned long start, long n, const char *name);
+#endif
 
 /* Compatibility cruft */
 #define check_region(start,n)	__check_region(&ioport_resource, (start), (n))
@@ -108,8 +115,13 @@
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
+#ifndef CONFIG_PC9800
 extern int __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);
+#else
+extern int __check_region(struct resource *, unsigned long, long);
+extern void __release_region(struct resource *, unsigned long, long);
+#endif
 
 #define get_ioport_list(buf)	get_resource_list(&ioport_resource, buf, PAGE_SIZE)
 #define get_mem_list(buf)	get_resource_list(&iomem_resource, buf, PAGE_SIZE)
