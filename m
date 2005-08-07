Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVHGLEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVHGLEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbVHGLEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:04:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:31752 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751501AbVHGLEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:04:35 -0400
Message-ID: <42F5EA8F.2010406@vmware.com>
Date: Sun, 07 Aug 2005 04:03:43 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 5/8 Move descriptor table management into the sub-arch
 layer
References: <42F4643E.4030402@vmware.com> <20050807011043.GJ7762@shell0.pdx.osdl.net>
In-Reply-To: <20050807011043.GJ7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Aug 2005 11:04:00.0765 (UTC) FILETIME=[B7224AD0:01C59B3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>This change encapsulates descriptor and task register management.
>>    
>>
>
>These will need some merging together, will take a stab tomorrow.
>
>
>--- linux-2.6.12-xen0-arch.orig/include/asm-i386/desc.h
>+++ linux-2.6.12-xen0-arch/include/asm-i386/desc.h
>@@ -14,9 +14,6 @@
>
> static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
> {
>-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
>+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
>  
>

What is Xen doing for the GDT on SMP?  Does Xen have 16 pages of GDT per 
CPU?

>+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_desc.h
>@@ -0,0 +1,57 @@
>+#ifndef __ASM_MACH_DESC_H
>+#define __ASM_MACH_DESC_H
>+
>+extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
>+DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
>+#define get_cpu_gdt_table(_cpu) per_cpu(cpu_gdt_table, cpu)
>+
>+#define _set_tssldt_desc(n,addr,limit,type) \
>+__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
>+	"movw %%ax,2(%2)\n\t" \
>+	"rorl $16,%%eax\n\t" \
>+	"movb %%al,4(%2)\n\t" \
>+	"movb %4,5(%2)\n\t" \
>+	"movb $0,6(%2)\n\t" \
>+	"movb %%ah,7(%2)\n\t" \
>+	"rorl $16,%%eax" \
>+	: "=m"(*(n)) : "a" (addr), "r"(n), "ir"(limit), "i"(type))
>  
>

This actually doesn't need to move into sub-arch.  You can redefine the 
call sites (set_ldt_desc / set_tss_desc) to operate on stack (implicit 
register) values instead and then notify the hypervisor about GDT 
updates.  Course, which way is cleaner looks still TBD.

>+static inline void clear_LDT(void)
>+{
>+	int cpu = get_cpu();
>+
>+	set_ldt_desc(cpu, &default_ldt[0], 5);
>+	load_LDT_desc();
>+	put_cpu();
>+}
>+
>+/*
>+ * load one particular LDT into the current CPU
>+ */
>+static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
>+{
>+	void *segments = pc->ldt;
>+	int count = pc->size;
>+
>+	if (likely(!count)) {
>+		segments = &default_ldt[0];
>+		count = 5;
>+	}
>+		
>+	set_ldt_desc(cpu, segments, count);
>+	load_LDT_desc();
>+}
>+
>+#endif
>  
>

These two don't actually need to move into sub-arch ; they can call 
functions that have already moved.

So far looks like we are pretty much on the same page, with mostly 
cosmetic differences.

Zach
