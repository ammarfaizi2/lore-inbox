Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVCUUF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVCUUF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCUUFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:05:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31466 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261843AbVCUUDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:03:49 -0500
Message-ID: <423F288F.7010202@sgi.com>
Date: Mon, 21 Mar 2005 15:03:27 -0500
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC]: DEBUG for PCI IO & MEM allocation
References: <4235C88B.9090708@sgi.com> <20050314212812.3657cfd4.akpm@osdl.org>
In-Reply-To: <20050314212812.3657cfd4.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090801070203000909010008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090801070203000909010008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Andrew.

>Shouldn't this also be printing the ->name of the new resource?
>
>A lot of the statements which you're adding will look screwy in an 80-col
>xterm.  Please wrap 'em.
>
-- new patch with Andrew's comments fixed.

P.

--------------090801070203000909010008
Content-Type: text/plain;
 name="resource2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resource2.patch"

Index: io_debug/kernel/resource.c
===================================================================
RCS file: /usr/local/src/cvsroot/bk/linux-2.5/kernel/resource.c,v
retrieving revision 1.1.1.1
diff -u -1 -0 -p -r1.1.1.1 resource.c
--- io_debug/kernel/resource.c	16 Mar 2005 18:48:54 -0000	1.1.1.1
+++ io_debug/kernel/resource.c	21 Mar 2005 20:00:16 -0000
@@ -13,20 +13,25 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/io.h>
 
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt , a...)
+#endif
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
 	.start	= 0x0000,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
 
 EXPORT_SYMBOL(ioport_resource);
 
@@ -148,58 +153,70 @@ __initcall(ioresources_init);
 
 #endif /* CONFIG_PROC_FS */
 
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
 	unsigned long start = new->start;
 	unsigned long end = new->end;
 	struct resource *tmp, **p;
 
+	DEBUGP("%s: %s resource request at 0x%lx-0x%lx\n", __FUNCTION__, 
+	       new->name, new->start, new->end);
+
 	if (end < start)
 		return root;
 	if (start < root->start)
 		return root;
 	if (end > root->end)
 		return root;
 	p = &root->child;
 	for (;;) {
 		tmp = *p;
 		if (!tmp || tmp->start > end) {
 			new->sibling = tmp;
 			*p = new;
 			new->parent = root;
+			DEBUGP("%s: %s resource allocated\n", __FUNCTION__, 
+			       new->name);
 			return NULL;
 		}
 		p = &tmp->sibling;
 		if (tmp->end < start)
 			continue;
+		DEBUGP("%s: %s resource conflicted with 0x%lx-0x%lx\n", 
+		       __FUNCTION__, new->name, tmp->start, tmp->end);
 		return tmp;
 	}
 }
 
 static int __release_resource(struct resource *old)
 {
 	struct resource *tmp, **p;
 
+	DEBUGP("%s: %s resource release for 0x%lx-0x%lx\n", __FUNCTION__, 
+	       old->name, old->start, old->end);
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;
 		if (!tmp)
 			break;
 		if (tmp == old) {
 			*p = tmp->sibling;
 			old->parent = NULL;
+			DEBUGP("%s: %s resource released\n", __FUNCTION__, 
+			       old->name);
 			return 0;
 		}
 		p = &tmp->sibling;
 	}
+	DEBUGP("%s: %s resource cannot be released\n", __FUNCTION__, old->name);
 	return -EINVAL;
 }
 
 int request_resource(struct resource *root, struct resource *new)
 {
 	struct resource *conflict;
 
 	write_lock(&resource_lock);
 	conflict = __request_resource(root, new);
 	write_unlock(&resource_lock);
@@ -425,42 +442,49 @@ EXPORT_SYMBOL(adjust_resource);
  * Request-region creates a new busy region.
  *
  * Check-region returns non-zero if the area is already busy
  *
  * Release-region releases a matching busy region.
  */
 struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
 {
 	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
 
+	DEBUGP("%s: %s requesting region 0x%lx - 0x%lx\n", __FUNCTION__, 
+	       name, start, start + n - 1);
 	if (res) {
 		memset(res, 0, sizeof(*res));
 		res->name = name;
 		res->start = start;
 		res->end = start + n - 1;
 		res->flags = IORESOURCE_BUSY;
 
 		write_lock(&resource_lock);
 
 		for (;;) {
 			struct resource *conflict;
 
 			conflict = __request_resource(parent, res);
-			if (!conflict)
+			if (!conflict) {
+				DEBUGP("%s: %s region assigned\n", __FUNCTION__,
+				       name);
 				break;
+			}
 			if (conflict != parent) {
 				parent = conflict;
 				if (!(conflict->flags & IORESOURCE_BUSY))
 					continue;
 			}
 
 			/* Uhhuh, that didn't work out.. */
+			DEBUGP("%s: %s request for region 0x%lx - 0x%lx fail\n",
+			       __FUNCTION__, res->name, res->start, res->end);
 			kfree(res);
 			res = NULL;
 			break;
 		}
 		write_unlock(&resource_lock);
 	}
 	return res;
 }
 
 EXPORT_SYMBOL(__request_region);
@@ -497,28 +521,33 @@ void __release_region(struct resource *p
 			break;
 		if (res->start <= start && res->end >= end) {
 			if (!(res->flags & IORESOURCE_BUSY)) {
 				p = &res->child;
 				continue;
 			}
 			if (res->start != start || res->end != end)
 				break;
 			*p = res->sibling;
 			write_unlock(&resource_lock);
+			DEBUGP("%s: %s releasing region 0x%lx - 0x%lx\n", 
+			       __FUNCTION__, res->name, res->start, res->end);
 			kfree(res);
 			return;
 		}
 		p = &res->sibling;
 	}
 
 	write_unlock(&resource_lock);
 
+	DEBUGP("%s: release regions  0x%lx - 0x%lx failed\n", __FUNCTION__,
+	       start, end);
+
 	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
 }
 
 EXPORT_SYMBOL(__release_region);
 
 /*
  * Called from init/main.c to reserve IO ports.
  */
 #define MAXRESERVE 4
 static int __init reserve_setup(char *str)

--------------090801070203000909010008--
