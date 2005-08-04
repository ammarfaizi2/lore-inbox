Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVHDAr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVHDAr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVHDApe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:45:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:24339 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261667AbVHDApI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:45:08 -0400
Date: Wed, 3 Aug 2005 17:44:04 -0700
From: zach@vmware.com
Message-Id: <200508040044.j740i4uj004192@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name,
       zach@vmware.com
Subject: [PATCH] 4/5 gdt-tss-redundant
X-OriginalArrivalTime: 04 Aug 2005 00:44:01.0921 (UTC) FILETIME=[9BA7E710:01C5988D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing GDT updates, I found the code:

	set_tss_desc(cpu,t);	/* This just modifies memory; ... */
        per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &= 0xfffffdff;

This second line is unnecessary, since set_tss_desc() has already cleared
the busy bit.

Commented disassembly, line 1:

c028b8bd:       8b 0c 86                mov    (%esi,%eax,4),%ecx
c028b8c0:       01 cb                   add    %ecx,%ebx
c028b8c2:       8d 0c 39                lea    (%ecx,%edi,1),%ecx

  => %ecx = per_cpu(cpu_gdt_table, cpu)

c028b8c5:       8d 91 80 00 00 00       lea    0x80(%ecx),%edx

  => %edx = &per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS]

c028b8cb:       66 c7 42 00 73 20       movw   $0x2073,0x0(%edx)
c028b8d1:       66 89 5a 02             mov    %bx,0x2(%edx)
c028b8d5:       c1 cb 10                ror    $0x10,%ebx
c028b8d8:       88 5a 04                mov    %bl,0x4(%edx)
c028b8db:       c6 42 05 89             movb   $0x89,0x5(%edx)

  => ((char *)%edx)[5] = 0x89
  (equivalent) ((char *)per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS])[5] = 0x89

c028b8df:       c6 42 06 00             movb   $0x0,0x6(%edx)
c028b8e3:       88 7a 07                mov    %bh,0x7(%edx)
c028b8e6:       c1 cb 10                ror    $0x10,%ebx

  => other bits

Commented disassembly, line 2:

c028b8e9:       8b 14 86                mov    (%esi,%eax,4),%edx
c028b8ec:       8d 04 3a                lea    (%edx,%edi,1),%eax

  => %eax = per_cpu(cpu_gdt_table, cpu)

c028b8ef:       81 a0 84 00 00 00 ff    andl   $0xfffffdff,0x84(%eax)

  => per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &= 0xfffffdff;
  (equivalent) ((char *)per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS])[5] &= 0xfd

Note that (0x89 & ~0xfd) == 0; i.e, set_tss_desc(cpu,t) has already stored the
type field in the GDT with the busy bit clear.

Eliminating redundant and obscure code is always a good thing; in fact, I
pointed out this same optimization many moons ago in arch/i386/setup.c, back
when it used to be called that.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.13/arch/i386/power/cpu.c
===================================================================
--- linux-2.6.13.orig/arch/i386/power/cpu.c	2005-08-02 17:06:21.000000000 -0700
+++ linux-2.6.13/arch/i386/power/cpu.c	2005-08-03 15:27:57.000000000 -0700
@@ -84,7 +84,6 @@
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
-        per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
 	load_LDT(&current->active_mm->context);	/* This does lldt */
