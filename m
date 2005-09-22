Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVIVHhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVIVHhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVIVHhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:37:48 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:22789 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751042AbVIVHhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:37:47 -0400
Date: Thu, 22 Sep 2005 00:37:20 -0700
Message-Id: <200509220737.j8M7bKgh000928@zach-dev.vmware.com>
Subject: [PATCH 1/3] Bogus tls from gdt
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>,
       Zachary Amsden <zach@vmware.com>
From: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 22 Sep 2005 07:37:19.0758 (UTC) FILETIME=[768F4AE0:01C5BF48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The per-CPU initialization code is copying in bogus data into
thread->tls_array.  Note that it copies &per_cpu(cpu_gdt_table, cpu),
not &per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN).  That is totally
broken and unnecessary.  Make the initialization explicitly NULL.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.14-rc1/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-rc1.orig/arch/i386/kernel/cpu/common.c	2005-09-20 14:49:10.000000000 -0700
+++ linux-2.6.14-rc1/arch/i386/kernel/cpu/common.c	2005-09-20 14:49:41.000000000 -0700
@@ -607,12 +607,6 @@ void __devinit cpu_init(void)
 	cpu_gdt_descr[cpu].address =
 	    (unsigned long)&per_cpu(cpu_gdt_table, cpu);
 
-	/*
-	 * Set up the per-thread TLS descriptor cache:
-	 */
-	memcpy(thread->tls_array, &per_cpu(cpu_gdt_table, cpu),
-		GDT_ENTRY_TLS_ENTRIES * 8);
-
 	load_gdt(&cpu_gdt_descr[cpu]);
 	load_idt(&idt_descr);
 
