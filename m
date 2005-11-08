Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVKHE3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVKHE3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKHE3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:29:24 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:64530 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030261AbVKHE3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:29:23 -0500
Date: Mon, 7 Nov 2005 20:29:21 -0800
Message-Id: <200511080429.jA84TLhD009896@zach-dev.vmware.com>
Subject: [PATCH 10/21] i386 Use protected segment for 16bit stack
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
X-OriginalArrivalTime: 08 Nov 2005 04:29:21.0790 (UTC) FILETIME=[FDC831E0:01C5E41C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use prepare_protected_segment macro to set up the 16-bit stack.

Whee!! This code is almost readable now.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/cpu/common.c	2005-11-04 16:54:45.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c	2005-11-05 00:28:08.000000000 -0800
@@ -607,10 +607,8 @@ void __devinit cpu_init(void)
 	set_base(gdt[GDT_ENTRY_BAD_BIOS_CACHE], __va(BAD_BIOS_AREA));
 
 	/* Set up GDT entry for 16bit stack */
- 	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
-		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
-		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
-		(CPU_16BIT_STACK_SIZE - 1);
+	prepare_protected_segment(cpu, GDT_ENTRY_ESPFIX_SS, (void *) stk16_off,
+				  CPU_16BIT_STACK_SIZE);
 
 	cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
  	cpu_gdt_descr[cpu].address = (unsigned long)gdt;
