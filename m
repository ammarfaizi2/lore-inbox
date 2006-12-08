Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425459AbWLHMGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425459AbWLHMGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425450AbWLHMGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:06:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40482 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425468AbWLHMFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:05:32 -0500
Date: Fri, 8 Dec 2006 07:05:25 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: compile failure in asm-i386/desc.h
Message-ID: <20061208120524.GB13841@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be on the wrong side of the ifdef.
Without it, I get implicit declarations of these functions when compiling
arch/i386/kernel/process.c

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.19.noarch/include/asm-i386/desc.h~	2006-12-08 06:52:55.000000000 -0500
+++ linux-2.6.19.noarch/include/asm-i386/desc.h	2006-12-08 06:53:14.000000000 -0500
@@ -185,6 +185,20 @@ static inline unsigned long get_desc_bas
 	return base;
 }
 
+static inline void set_user_cs(struct desc_struct *desc, unsigned long limit)
+{
+	limit = (limit - 1) / PAGE_SIZE;
+	desc->a = limit & 0xffff;
+	desc->b = (limit & 0xf0000) | 0x00c0fb00;
+}
+
+#define load_user_cs_desc(cpu, mm) \
+	get_cpu_gdt_table(cpu)[GDT_ENTRY_DEFAULT_USER_CS] = (mm)->context.user_cs
+
+extern void arch_add_exec_range(struct mm_struct *mm, unsigned long limit);
+extern void arch_remove_exec_range(struct mm_struct *mm, unsigned long limit);
+extern void arch_flush_exec_range(struct mm_struct *mm);
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -208,20 +222,6 @@ static inline unsigned long get_desc_bas
 	shll $16, base; \
 	movw idx*8+2(gdt), lo_w;
 
-static inline void set_user_cs(struct desc_struct *desc, unsigned long limit)
-{
-	limit = (limit - 1) / PAGE_SIZE;
-	desc->a = limit & 0xffff;
-	desc->b = (limit & 0xf0000) | 0x00c0fb00;
-}
-
-#define load_user_cs_desc(cpu, mm) \
-	get_cpu_gdt_table(cpu)[GDT_ENTRY_DEFAULT_USER_CS] = (mm)->context.user_cs
-
-extern void arch_add_exec_range(struct mm_struct *mm, unsigned long limit);
-extern void arch_remove_exec_range(struct mm_struct *mm, unsigned long limit);
-extern void arch_flush_exec_range(struct mm_struct *mm);
-
 #endif /* !__ASSEMBLY__ */
 
 #endif
