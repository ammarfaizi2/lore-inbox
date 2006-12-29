Return-Path: <linux-kernel-owner+w=401wt.eu-S1754113AbWL2G3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbWL2G3J (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbWL2G3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:29:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36415 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbWL2G3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:29:08 -0500
Date: Fri, 29 Dec 2006 01:29:01 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Fix implicit declarations in i386 process.c
Message-ID: <20061229062901.GA23251@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kernel with -Werror-implicit fails pretty fast with this..

arch/i386/kernel/process.c: In function '__switch_to':
arch/i386/kernel/process.c:645: error: implicit declaration of function 'load_user_cs_desc'
arch/i386/kernel/process.c: In function 'arch_add_exec_range':
arch/i386/kernel/process.c:915: error: implicit declaration of function 'set_user_cs'

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


-- 
http://www.codemonkey.org.uk
