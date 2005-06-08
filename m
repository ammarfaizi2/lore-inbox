Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVFHVI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVFHVI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVFHVI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:08:57 -0400
Received: from res2.iGuide.co.il ([194.90.246.244]:12976 "EHLO
	stalker.iGuide.co.il") by vger.kernel.org with ESMTP
	id S261689AbVFHVIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:08:49 -0400
Date: Thu, 9 Jun 2005 00:08:30 +0300 (IDT)
From: Vassilii Khachaturov <vassilii@tarunz.org>
To: mark@alpha.dyndns.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ov511-2.28 patch for 2.6.11 kernel compat.
In-Reply-To: <Pine.LNX.4.44.0505181722450.27303-100000@stalker.iGuide.co.il>
Message-ID: <Pine.LNX.4.44.0506082356410.8821-100000@stalker.iGuide.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mark,

included is a patch for you to apply to your ov511-2.28 driver.
It's basically a re-make of the in-kernel ov511 1.64 driver modification
wrt the remap_page_range -> remap_pfn_range API obsoleting (2.6.10)
and removal (2.6.11), applied to your 2.28 source.

(This should eliminate the unresolved symbol error for remap_page_range
for those who try out your 2.28 source against 2.6.11 or newer trees).

There is a bit of cut-and-paste involved in the page, but
it follows from the corresponding cut-and-paste in your
original code.

Tested on Linux asus3 2.6.11-gentoo-r9 #3 Wed Jun 8 21:41:40 IDT 2005 i686
Pentium III (Coppermine) GenuineIntel GNU/Linux, camera
chipset OV518/OV6630AF.

Please apply,
Vassilii
-- cut here --
diff -rbup orig/ov511-2.28/ov511_core.c ov511-2.28/ov511_core.c
--- orig/ov511-2.28/ov511_core.c	2004-07-13 14:54:22.000000000 +0300
+++ ov511-2.28/ov511_core.c	2005-06-08 23:38:04.000000000 +0300
@@ -4881,12 +4881,18 @@ ov51x_mmap(struct file *file, struct vm_

 	pos = (unsigned long)ov->fbuf;
 	while (size > 0) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
+		page = vmalloc_to_pfn((void *)pos);
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE,
+				     PAGE_SHARED)) {
+#else
 		page = kvirt_to_pa(pos);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
+# if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
 		if (remap_page_range(vma, start, page, PAGE_SIZE,
 				     PAGE_SHARED)) {
-#else
+# else
 		if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED)) {
+# endif
 #endif
 			up(&ov->lock);
 			return -EAGAIN;
diff -rbup orig/ov511-2.28/ovfx2.c ov511-2.28/ovfx2.c
--- orig/ov511-2.28/ovfx2.c	2004-07-16 02:32:08.000000000 +0300
+++ ov511-2.28/ovfx2.c	2005-06-08 23:34:32.000000000 +0300
@@ -2502,12 +2502,18 @@ ovfx2_mmap(struct file *file, struct vm_

 	pos = (unsigned long)ov->fbuf;
 	while (size > 0) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
+		page = vmalloc_to_pfn((void *)pos);
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE,
+				     PAGE_SHARED)) {
+#else
 		page = kvirt_to_pa(pos);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
+# if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
 		if (remap_page_range(vma, start, page, PAGE_SIZE,
 				     PAGE_SHARED)) {
-#else
+# else
 		if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED)) {
+# endif
 #endif
 			up(&ov->lock);
 			return -EAGAIN;

