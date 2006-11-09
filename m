Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161855AbWKIWAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161855AbWKIWAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161858AbWKIWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:00:20 -0500
Received: from vena.lwn.net ([206.168.112.25]:54765 "EHLO vena.lwn.net")
	by vger.kernel.org with ESMTP id S1161855AbWKIWAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:00:19 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent an oops in vmalloc_user()
cc: akpm@osdl.org
From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 09 Nov 2006 15:00:19 -0700
Message-ID: <31360.1163109619@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent an oops in vmalloc_user()

If an attempt to allocate memory with vmalloc_user() fails, the result
will be an oops when it tries to tweak the flags in the (non-existent)
VMA.  One could argue that __find_vm_area() should not return a random
pointer on failure, but vmalloc_user() requires a check regardless.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

--- 2.6.19-rc5/mm/vmalloc.c.orig	2006-11-09 13:51:38.000000000 -0700
+++ 2.6.19-rc5/mm/vmalloc.c	2006-11-09 13:52:10.000000000 -0700
@@ -532,10 +532,12 @@ void *vmalloc_user(unsigned long size)
 	void *ret;
 
 	ret = __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
-	write_lock(&vmlist_lock);
-	area = __find_vm_area(ret);
-	area->flags |= VM_USERMAP;
-	write_unlock(&vmlist_lock);
+	if (ret) {
+		write_lock(&vmlist_lock);
+		area = __find_vm_area(ret);
+		area->flags |= VM_USERMAP;
+		write_unlock(&vmlist_lock);
+	}
 
 	return ret;
 }
