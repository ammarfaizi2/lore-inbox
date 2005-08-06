Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVHFHWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVHFHWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVHFHU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:20:27 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:14355 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262343AbVHFHTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:19:18 -0400
Message-ID: <42F4643E.4030402@vmware.com>
Date: Sat, 06 Aug 2005 00:18:22 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH] 5/8 Move descriptor table management into the sub-arch layer
Content-Type: multipart/mixed;
 boundary="------------080906090507010704040608"
X-OriginalArrivalTime: 06 Aug 2005 07:18:40.0280 (UTC) FILETIME=[11E24180:01C59A57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080906090507010704040608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------080906090507010704040608
Content-Type: text/plain;
 name="subarch-desc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-desc"

i386 Transparent paravirtualization subarch patch #5

This change encapsulates descriptor and task register management.

Diffs against: 2.6.13-rc4-mm1

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-03 16:24:09.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-03 16:31:40.000000000 -0700
@@ -27,19 +27,6 @@
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
 
-#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
-#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
-
-#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
-#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
-#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
-#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
-
-#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
-#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
-#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
-#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
-
 /*
  * This is the ldt that every process will get unless we need
  * something other than this.
@@ -58,19 +45,10 @@
 	"rorl $16,%1" \
 	: "=m"(*(n)) : "q" (addr), "r"(n), "ir"(limit), "i"(type))
 
-static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
-{
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
-		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
-}
+#include <mach_desc.h>
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 
-static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
-{
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
-}
-
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
@@ -96,24 +74,6 @@
 	(info)->seg_not_present	== 1	&& \
 	(info)->useable		== 0	)
 
-static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
-{
-	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
-	*lp = entry_a;
-	*(lp+1) = entry_b;
-}
-
-#if TLS_SIZE != 24
-# error update this code.
-#endif
-
-static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
-{
-#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
-	C(0); C(1); C(2);
-#undef C
-}
-
 static inline void clear_LDT(void)
 {
 	int cpu = get_cpu();
Index: linux-2.6.13/include/asm-i386/mach-default/mach_desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_desc.h	2005-08-03 16:31:40.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_desc.h	2005-08-03 16:32:52.000000000 -0700
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ * Copyright (C) 1992-2004, Linus Torvalds and authors
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef __MACH_DESC_H
+#define __MACH_DESC_H
+
+#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
+#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
+
+#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
+#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
+#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
+#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
+
+#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
+#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
+#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
+#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
+
+static inline unsigned int get_TR_desc(void)
+{
+	unsigned int tr;
+	__asm__ ("str %w0":"=q" (tr));
+	return tr;
+}
+
+static inline unsigned int get_LDT_desc(void)
+{
+	unsigned int ldt;
+	__asm__ ("sldt %w0":"=q" (ldt));
+	return ldt;
+}
+
+static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
+{
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
+		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
+}
+
+static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
+{
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+}
+
+static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
+{
+	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
+	*lp = entry_a;
+	*(lp+1) = entry_b;
+}
+
+#if TLS_SIZE != 24
+# error update this code.
+#endif
+
+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
+{
+#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
+	C(0); C(1); C(2);
+#undef C
+}
+
+#endif

--------------080906090507010704040608--
