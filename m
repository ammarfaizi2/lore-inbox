Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVCNRXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVCNRXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVCNRXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:23:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36796 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261631AbVCNRX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:23:28 -0500
Message-ID: <4235C88B.9090708@sgi.com>
Date: Mon, 14 Mar 2005 12:23:23 -0500
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC]: DEBUG for PCI IO & MEM allocation
Content-Type: multipart/mixed;
 boundary="------------010105040403070903040605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105040403070903040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Colleagues,

Over the past few years I've been heavily involved in two projects that 
deal with PCI HotPlug.  While doing this work, one area of code always 
seems to require printk's to debug through -- the allocation & freeing 
of IO & MEM resources.

I've discovered many bugs surrounding Hotplug PCI IO & MEM allocations 
that would have been much easier to debug had there been printk's 
existing within the code, including one recently which impacts all of 
PCI Hotplug and appears to have been around since pre-2.6.9 (a patch to 
fix this issue has already been reviewed & accepted by Greg Kroah). 

As Hotplug continues to mature and more Hotplug drivers are introduced, 
I suspect that more and more bugs will be introduced in the resource space.

I propose the following patch to add a compile time DEBUG option to 
kernel/resource.c that would help in analyzing problems in this area.  
It's a few simple lines of output in  __request_resource, 
__release_resource, __request_region, and __release_region .

Thanks,

P.



--------------010105040403070903040605
Content-Type: text/x-patch;
 name="resource.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resource.patch"

===== kernel/resource.c 1.26 vs edited =====
--- 1.26/kernel/resource.c	2005-01-08 00:44:13 -05:00
+++ edited/kernel/resource.c	2005-03-14 17:14:36 -05:00
@@ -20,6 +20,11 @@
 #include <linux/seq_file.h>
 #include <asm/io.h>
 
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt , a...)
+#endif
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
@@ -155,6 +160,8 @@
 	unsigned long end = new->end;
 	struct resource *tmp, **p;
 
+	DEBUGP("%s: resource request at 0x%lx-0x%lx\n", __FUNCTION__, new->start, new->end);
+
 	if (end < start)
 		return root;
 	if (start < root->start)
@@ -168,11 +175,13 @@
 			new->sibling = tmp;
 			*p = new;
 			new->parent = root;
+			DEBUGP("%s: resource allocated\n", __FUNCTION__);
 			return NULL;
 		}
 		p = &tmp->sibling;
 		if (tmp->end < start)
 			continue;
+		DEBUGP("%s: resource conflicted with 0x%lx-0x%lx\n", __FUNCTION__, tmp->start, tmp->end);
 		return tmp;
 	}
 }
@@ -181,6 +190,7 @@
 {
 	struct resource *tmp, **p;
 
+	DEBUGP("%s: resource release for 0x%lx-0x%lx\n", __FUNCTION__, old->start, old->end);
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;
@@ -189,10 +199,12 @@
 		if (tmp == old) {
 			*p = tmp->sibling;
 			old->parent = NULL;
+			DEBUGP("%s: resource free'd\n", __FUNCTION__);
 			return 0;
 		}
 		p = &tmp->sibling;
 	}
+	DEBUGP("%s: resource cannot be released\n", __FUNCTION__);
 	return -EINVAL;
 }
 
@@ -432,6 +444,7 @@
 {
 	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
 
+	DEBUGP("%s: requesting region 0x%lx - 0x%lx\n", __FUNCTION__, start, start + n - 1);
 	if (res) {
 		memset(res, 0, sizeof(*res));
 		res->name = name;
@@ -445,8 +458,10 @@
 			struct resource *conflict;
 
 			conflict = __request_resource(parent, res);
-			if (!conflict)
+			if (!conflict) {
+				DEBUGP("%s: region assigned\n", __FUNCTION__);
 				break;
+			}
 			if (conflict != parent) {
 				parent = conflict;
 				if (!(conflict->flags & IORESOURCE_BUSY))
@@ -454,6 +469,8 @@
 			}
 
 			/* Uhhuh, that didn't work out.. */
+			DEBUGP("%s: request for region 0x%lx - 0x%lx failed\n", __FUNCTION__, res->start, 
+				res->end);
 			kfree(res);
 			res = NULL;
 			break;
@@ -504,6 +521,7 @@
 				break;
 			*p = res->sibling;
 			write_unlock(&resource_lock);
+			DEBUGP("%s: releasing region 0x%lx - 0x%lx\n", __FUNCTION__, res->start, res->end);
 			kfree(res);
 			return;
 		}
@@ -512,6 +530,7 @@
 
 	write_unlock(&resource_lock);
 
+	DEBUGP("%s: release regions  0x%lx - 0x%lx failed\n", __FUNCTION__, start, end);
 	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
 }
 

--------------010105040403070903040605--
