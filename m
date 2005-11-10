Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVKJAfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVKJAfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVKJAf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:35:29 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4613 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751119AbVKJAf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:35:29 -0500
Date: Wed, 9 Nov 2005 16:32:42 -0800
Message-Id: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
Subject: [PATCH 1/10] Cr4 is valid on some 486s
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:32:42.0737 (UTC) FILETIME=[43502610:01C5E58E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So some 486 processors do have CR4 register.  Allow them to present it in
register dumps by using the old fault technique rather than testing processor
family.

Thanks to Maciej for noticing this.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/process.c	2005-11-08 03:25:24.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/process.c	2005-11-08 03:26:03.000000000 -0800
@@ -314,9 +314,7 @@
 	cr0 = read_cr0();
 	cr2 = read_cr2();
 	cr3 = read_cr3();
-	if (current_cpu_data.x86 > 4) {
-		cr4 = read_cr4();
-	}
+	cr4 = read_cr4_safe();
 	printk("CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n", cr0, cr2, cr3, cr4);
 	show_trace(NULL, &regs->esp);
 }
Index: linux-2.6.14/include/asm-i386/system.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/system.h	2005-11-08 03:25:29.000000000 -0800
+++ linux-2.6.14/include/asm-i386/system.h	2005-11-08 03:26:03.000000000 -0800
@@ -140,6 +140,19 @@
 		:"=r" (__dummy)); \
 	__dummy; \
 })
+
+#define read_cr4_safe() ({			      \
+	unsigned int __dummy;			      \
+	/* This could fault if %cr4 does not exist */ \
+	__asm__("1: movl %%cr4, %0		\n"   \
+		"2:				\n"   \
+		".section __ex_table,\"a\"	\n"   \
+		".long 1b,2b			\n"   \
+		".previous			\n"   \
+		: "=r" (__dummy): "0" (0));	      \
+	__dummy;				      \
+})
+
 #define write_cr4(x) \
 	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
 #define stts() write_cr0(8 | read_cr0())
