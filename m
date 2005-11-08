Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965345AbVKHEgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbVKHEgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbVKHEgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:36:18 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:5380 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965345AbVKHEgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:36:17 -0500
Date: Mon, 7 Nov 2005 20:36:16 -0800
Message-Id: <200511080436.jA84aGvD009933@zach-dev.vmware.com>
Subject: [PATCH 16/21] i386 Eliminate duplicate segment macros
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:36:16.0665 (UTC) FILETIME=[F5111890:01C5E41D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of duplicated and ugly segment macros, replacing them
with slightly less ugly versions in a more appropriate place.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/process.c	2005-11-04 18:07:41.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/process.c	2005-11-04 18:10:53.000000000 -0800
@@ -881,26 +881,6 @@ asmlinkage int sys_set_thread_area(struc
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
@@ -913,19 +893,8 @@ asmlinkage int sys_get_thread_area(struc
 		return -EINVAL;
 
 	memset(&info, 0, sizeof(info));
-
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
-
+	convert_desc_to_user(desc, &info, idx);
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;
 	return 0;
Index: linux-2.6.14-zach-work/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/ptrace.c	2005-11-04 12:12:35.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/ptrace.c	2005-11-05 00:28:05.000000000 -0800
@@ -285,41 +285,11 @@ ptrace_get_thread_area(struct task_struc
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
 
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-04 18:03:21.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 00:28:05.000000000 -0800
@@ -61,6 +61,13 @@ struct desc_internal_struct {
 	unsigned char	base2;
 } __attribute__((packed));
 
+#define get_desc_32bit(desc)	(((desc)->b >> 22) & 1)
+#define get_desc_contents(desc)	(((desc)->b >> 10) & 3)
+#define get_desc_writable(desc)	(((desc)->b >>  9) & 1)
+#define get_desc_gran(desc)	(((desc)->b >> 23) & 1)
+#define get_desc_present(desc)	(((desc)->b >> 15) & 1)
+#define get_desc_usable(desc)	(((desc)->b >> 20) & 1)
+
 static inline struct desc_internal_struct *desc_internal(struct desc_struct *d)
 {
 	return (struct desc_internal_struct *)d;
@@ -123,6 +130,19 @@ static inline void set_ldt_desc(unsigned
 	set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
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
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
