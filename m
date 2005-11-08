Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965378AbVKHEih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965378AbVKHEih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbVKHEih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:38:37 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:13572 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965378AbVKHEig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:38:36 -0500
Date: Mon, 7 Nov 2005 20:38:34 -0800
Message-Id: <200511080438.jA84cY0X009945@zach-dev.vmware.com>
Subject: [PATCH 18/21] i386 Ldt cleanups 2
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
X-OriginalArrivalTime: 08 Nov 2005 04:38:35.0457 (UTC) FILETIME=[47CB1310:01C5E41E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an acessor function to get a pointer to an LDT descriptor.  Add one for
the GDT too, while we are here, and a function to tell the difference.

Turns out on some GCC versions, converting to char * and back gives better
code output than gdt[seg >> 3].  Lets keep that trick in the header file
so the C-code can be clean.

Not used yet, but soon.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-04 18:10:53.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 00:28:03.000000000 -0800
@@ -30,7 +30,24 @@ static inline struct desc_struct *get_cp
 {
 	return ((struct desc_struct *)cpu_gdt_descr[cpu].address);
 }
-  
+
+static inline int segment_from_ldt(unsigned int segment)
+{
+	return segment & LDT_SEGMENT;
+}
+
+static inline struct desc_struct *get_gdt_desc(int cpu, unsigned int segment)
+{
+	char *gdt = (char *)get_cpu_gdt_table(cpu);
+	return (struct desc_struct *)&gdt[segment & ~7];
+}
+
+static inline struct desc_struct *get_ldt_desc(mm_context_t *ctx, unsigned int segment)
+{
+	char *ldt = (char *)ctx->ldt;
+	return (struct desc_struct *)&ldt[segment & ~7];
+}
+
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
