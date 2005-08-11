Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVHKEw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVHKEw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVHKEw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:52:58 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:25606 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932221AbVHKEw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:52:57 -0400
Date: Wed, 10 Aug 2005 21:52:51 -0700
From: zach@vmware.com
Message-Id: <200508110452.j7B4qpSE019505@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwame@arm.linux.org.uk
Subject: [PATCH 1/14] i386 / Make write ldt return error code
X-OriginalArrivalTime: 11 Aug 2005 04:53:07.0781 (UTC) FILETIME=[90F96750:01C59E30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xen requires error returns from the hypercall to update LDT entries,
and this generates completely equivalent code on native.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc ldt paravirt xen
Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.13/include/asm-i386/mach-default/mach_desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_desc.h	2005-08-09 18:19:39.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_desc.h	2005-08-09 18:24:10.000000000 -0700
@@ -62,11 +62,12 @@
 	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
 }
 
-static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
+static inline int write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
 {
 	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
 	*lp = entry_a;
 	*(lp+1) = entry_b;
+	return 0;
 }
 
 #if TLS_SIZE != 24
Index: linux-2.6.13/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ldt.c	2005-08-09 18:19:37.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ldt.c	2005-08-09 18:22:56.000000000 -0700
@@ -221,8 +221,7 @@
 
 	/* Install the new entry ...  */
 install:
-	write_ldt_entry(mm->context.ldt, ldt_info.entry_number, entry_1, entry_2);
-	error = 0;
+	error = write_ldt_entry(mm->context.ldt, ldt_info.entry_number, entry_1, entry_2);
 
 out_unlock:
 	up(&mm->context.sem);
