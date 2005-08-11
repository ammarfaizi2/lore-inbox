Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVHKExe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVHKExe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHKExe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:53:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:29702 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932253AbVHKExd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:53:33 -0400
Date: Wed, 10 Aug 2005 21:53:31 -0700
From: zach@vmware.com
Message-Id: <200508110453.j7B4rVYX019522@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwame@arm.linux.org.uk
Subject: [PATCH 3/14] i386 / Remove unnecessary tls init
X-OriginalArrivalTime: 11 Aug 2005 04:53:43.0875 (UTC) FILETIME=[A67CE930:01C59E30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The per-CPU initialization code is copying in bogus data into
thread->tls_array.  Note that it copies &per_cpu(cpu_gdt_table, cpu),
not &per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN).  That is totally
broken and unnecessary.  Make the initialization explicitly NULL.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 cleanup
Signed-off-by: Zachary Amsden <zach@vmware.com
Index: linux-2.6.13/include/asm-i386/processor.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/processor.h	2005-08-09 18:37:48.000000000 -0700
+++ linux-2.6.13/include/asm-i386/processor.h	2005-08-10 20:42:20.000000000 -0700
@@ -366,6 +366,7 @@
 };
 
 #define INIT_THREAD  {							\
+	.tls_array = { [ 0 ... GDT_ENTRY_TLS_ENTRIES-1 ] = { 0,0 } },	\
 	.vm86_info = NULL,						\
 	.sysenter_cs = __KERNEL_CS,					\
 	.io_bitmap_ptr = NULL,						\
Index: linux-2.6.13/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/cpu/common.c	2005-08-09 18:37:48.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/cpu/common.c	2005-08-10 20:42:04.000000000 -0700
@@ -607,12 +607,6 @@
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
 
