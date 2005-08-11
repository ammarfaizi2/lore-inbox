Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVHKE5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVHKE5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVHKE5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:57:48 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:49414 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932262AbVHKE5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:57:46 -0400
Date: Wed, 10 Aug 2005 21:57:41 -0700
From: zach@vmware.com
Message-Id: <200508110457.j7B4vePN019611@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 11/14] i386 / Eliminate yet another redundant accessor
X-OriginalArrivalTime: 11 Aug 2005 04:57:54.0389 (UTC) FILETIME=[3BCE5050:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found yet another set of accessor functions for descriptors that really
belongs in desc.h - move it there.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc cleanup
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-08-09 21:10:00.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/process.c	2005-08-09 23:45:09.000000000 -0700
@@ -898,26 +898,6 @@
 	return 0;
 }
 
-/*
- * Get the current Thread-Local Storage area:
- */
-
-#define GET_BASE(desc) ( \
-	(((desc)->a >> 16) & 0x0000ffff) | \
-	(((desc)->b << 16) & 0x00ff0000) | \
-	( (desc)->b        & 0xff000000)   )
-
-#define GET_LIMIT(desc) ( \
-	((desc)->a & 0x0ffff) | \
-	 ((desc)->b & 0xf0000) )
-	
-#define GET_32BIT(desc)		(((desc)->b >> 22) & 1)
-#define GET_CONTENTS(desc)	(((desc)->b >> 10) & 3)
-#define GET_WRITABLE(desc)	(((desc)->b >>  9) & 1)
-#define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)
-#define GET_PRESENT(desc)	(((desc)->b >> 15) & 1)
-#define GET_USEABLE(desc)	(((desc)->b >> 20) & 1)
-
 asmlinkage int sys_get_thread_area(struct user_desc __user *u_info)
 {
 	struct user_desc info;
@@ -932,16 +912,7 @@
 	memset(&info, 0, sizeof(info));
 
 	desc = current->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
-
-	info.entry_number = idx;
-	info.base_addr = GET_BASE(desc);
-	info.limit = GET_LIMIT(desc);
-	info.seg_32bit = GET_32BIT(desc);
-	info.contents = GET_CONTENTS(desc);
-	info.read_exec_only = !GET_WRITABLE(desc);
-	info.limit_in_pages = GET_LIMIT_PAGES(desc);
-	info.seg_not_present = !GET_PRESENT(desc);
-	info.useable = GET_USEABLE(desc);
+	convert_desc_to_user(desc, &info, idx);
 
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;
Index: linux-2.6.13/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ptrace.c	2005-08-09 21:10:00.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ptrace.c	2005-08-09 21:10:24.000000000 -0700
@@ -283,41 +283,11 @@
 	struct user_desc info;
 	struct desc_struct *desc;
 
-/*
- * Get the current Thread-Local Storage area:
- */
-
-#define GET_BASE(desc) ( \
-	(((desc)->a >> 16) & 0x0000ffff) | \
-	(((desc)->b << 16) & 0x00ff0000) | \
-	( (desc)->b        & 0xff000000)   )
-
-#define GET_LIMIT(desc) ( \
-	((desc)->a & 0x0ffff) | \
-	 ((desc)->b & 0xf0000) )
-
-#define GET_32BIT(desc)		(((desc)->b >> 22) & 1)
-#define GET_CONTENTS(desc)	(((desc)->b >> 10) & 3)
-#define GET_WRITABLE(desc)	(((desc)->b >>  9) & 1)
-#define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)
-#define GET_PRESENT(desc)	(((desc)->b >> 15) & 1)
-#define GET_USEABLE(desc)	(((desc)->b >> 20) & 1)
-
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
 	desc = child->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
-
-	info.entry_number = idx;
-	info.base_addr = GET_BASE(desc);
-	info.limit = GET_LIMIT(desc);
-	info.seg_32bit = GET_32BIT(desc);
-	info.contents = GET_CONTENTS(desc);
-	info.read_exec_only = !GET_WRITABLE(desc);
-	info.limit_in_pages = GET_LIMIT_PAGES(desc);
-	info.seg_not_present = !GET_PRESENT(desc);
-	info.useable = GET_USEABLE(desc);
-
+	convert_desc_to_user(desc, &info, idx);
 	if (copy_to_user(user_desc, &info, sizeof(info)))
 		return -EFAULT;
 
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-09 21:10:00.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-10 20:40:26.000000000 -0700
@@ -20,6 +20,13 @@
 #define desc_equal(desc1, desc2) \
 		(((desc1)->a == (desc2)->a) && ((desc1)->b == (desc2)->b))
 
+#define get_desc_32bit(desc)	(((desc)->b >> 22) & 1)
+#define get_desc_contents(desc)	(((desc)->b >> 10) & 3)
+#define get_desc_writable(desc)	(((desc)->b >>  9) & 1)
+#define get_desc_gran(desc)	(((desc)->b >> 23) & 1)
+#define get_desc_present(desc)	(((desc)->b >> 15) & 1)
+#define get_desc_usable(desc)	(((desc)->b >> 20) & 1)
+
 static inline unsigned long get_desc_base(struct desc_struct *desc)
 {
 	unsigned long base;
@@ -36,6 +43,19 @@
 	return limit;
 }
 
+static inline void convert_desc_to_user(struct desc_struct *desc, struct user_desc *info, int idx)
+{
+	info->entry_number = idx;
+	info->base_addr = get_desc_base(desc);
+	info->limit = get_desc_limit(desc);
+	info->seg_32bit = get_desc_32bit(desc);
+	info->contents = get_desc_contents(desc);
+	info->read_exec_only = !get_desc_writable(desc);
+	info->limit_in_pages = get_desc_gran(desc);
+	info->seg_not_present = !get_desc_present(desc);
+	info->useable = get_desc_usable(desc);
+}
+
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
