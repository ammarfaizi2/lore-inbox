Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUBLEu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 23:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUBLEu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 23:50:59 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28628 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266281AbUBLEu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 23:50:57 -0500
Date: Thu, 12 Feb 2004 13:50:01 +0900 (JST)
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: [PATCH] __release_region() race
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, maeda.naoaki@jp.fujitsu.com
Message-id: <20040212.135001.85390321.maeda@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Mew version 2.2 on Emacs 20.3 / Mule 4.0 (HANANOEN)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am testing PCI hot-plug in 2.6.2 kernel, but sometimes
a struct resource tree in kernel/resource.c was broken
if multiple hot-plug requests are issued at the same time.

The reason is lots of drivers call release_region() on hot removal,
and __release_region(), which is invoked by release_region() macro,
changes the tree without holding a writer lock for resource_lock.

I think __release_region() must hold a writer lock as well as
__request_region() does.

A following patch fixes the issue in my environment.

Regards,
Naoaki Maeda

diff -Naur linux-2.6.3-rc2.org/kernel/resource.c linux-2.6.3-rc2/kernel/resource.c
--- linux-2.6.3-rc2.org/kernel/resource.c	2004-02-10 12:01:04.000000000 +0900
+++ linux-2.6.3-rc2/kernel/resource.c	2004-02-12 11:53:14.011014921 +0900
@@ -475,6 +475,8 @@
 	p = &parent->child;
 	end = start + n - 1;
 
+	write_lock(&resource_lock);
+
 	for (;;) {
 		struct resource *res = *p;
 
@@ -488,11 +490,15 @@
 			if (res->start != start || res->end != end)
 				break;
 			*p = res->sibling;
+			write_unlock(&resource_lock);
 			kfree(res);
 			return;
 		}
 		p = &res->sibling;
 	}
+
+	write_unlock(&resource_lock);
+
 	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
 }
 

