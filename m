Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVHDAuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVHDAuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVHDAsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:48:11 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:28179 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261667AbVHDApn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:45:43 -0400
Date: Wed, 3 Aug 2005 17:44:25 -0700
From: zach@vmware.com
Message-Id: <200508040044.j740iPwB004200@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 5/5 ldt-accessors
X-OriginalArrivalTime: 04 Aug 2005 00:44:21.0921 (UTC) FILETIME=[A793A910:01C5988D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a write acessor for updating the current LDT.  This is required for
hypervisors like Xen that do not allow LDT pages to be directly written.

Testing - here's a fun little LDT test that can be trivially modified to test
limits as well.

/*
 * Copyright (c) 2005, Zachary Amsden (zach@vmware.com)
 * This is licensed under the GPL.
 */

#include <stdio.h>
#include <signal.h>
#include <asm/ldt.h>
#include <asm/segment.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/mman.h>
#define __KERNEL__
#include <asm/page.h>

void main(void)
{
        struct user_desc desc;
        char *code;
        unsigned long long tsc;

        code = (char *)mmap(0, 8192, PROT_EXEC|PROT_READ|PROT_WRITE,
                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        desc.entry_number = 0;
        desc.base_addr = code;
        desc.limit = 1;
        desc.seg_32bit = 1;
        desc.contents = MODIFY_LDT_CONTENTS_CODE;
        desc.read_exec_only = 0;
        desc.limit_in_pages = 1;
        desc.seg_not_present = 0;
        desc.useable = 1;
        if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
                perror("modify_ldt");
        }
        printf("code base is 0x%08x\n", (unsigned)code);
        code[0x0ffe] = 0x0f;  /* rdtsc */
        code[0x0fff] = 0x31;
        code[0x1000] = 0xcb;  /* lret */
        __asm__ __volatile("lcall $7,$0xffe" : "=A" (tsc));
        printf("TSC is 0x%016llx\n", tsc);
}

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ldt.c	2005-08-03 15:44:24.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ldt.c	2005-08-03 15:48:53.000000000 -0700
@@ -177,7 +177,7 @@
 static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
 {
 	struct mm_struct * mm = current->mm;
-	__u32 entry_1, entry_2, *lp;
+	__u32 entry_1, entry_2;
 	int error;
 	struct user_desc ldt_info;
 
@@ -205,8 +205,6 @@
 			goto out_unlock;
 	}
 
-	lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.ldt);
-
    	/* Allow LDTs to be cleared by the user. */
    	if (ldt_info.base_addr == 0 && ldt_info.limit == 0) {
 		if (oldmode || LDT_empty(&ldt_info)) {
@@ -223,8 +221,7 @@
 
 	/* Install the new entry ...  */
 install:
-	*lp	= entry_1;
-	*(lp+1)	= entry_2;
+	write_ldt_entry(mm->context.ldt, ldt_info.entry_number, entry_1, entry_2);
 	error = 0;
 
 out_unlock:
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-03 15:44:24.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-03 16:17:25.000000000 -0700
@@ -96,6 +96,13 @@
 	(info)->seg_not_present	== 1	&& \
 	(info)->useable		== 0	)
 
+static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
+{
+	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
+	*lp = entry_a;
+	*(lp+1) = entry_b;
+}
+
 #if TLS_SIZE != 24
 # error update this code.
 #endif
