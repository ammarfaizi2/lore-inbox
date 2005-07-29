Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVG2TGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVG2TGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVG2TDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:03:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42889 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262730AbVG2TCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:02:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH] x86_64 machine_kexec: Cleanup inline assembly.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 13:02:09 -0600
Message-ID: <m1mzo5307i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In an uncensored copy of code from i386 to x86_64 I wound up
with inline assembly with the wrong constraints.  Use input
constraints instead of output constraints.

So I know the assembler will do the right thing specify the size
of the operand lidtq and lgdtq instead of just lidt and lgdt.

Make load_segments use an input constraint, and delete the macro fun.
Without having to reload %cs like I do on i386 this code is noticeably
simpler.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/machine_kexec.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

d5f1c67bf3b1c8ebfd146ea2782af48a6c6a9bbc
diff --git a/arch/x86_64/kernel/machine_kexec.c b/arch/x86_64/kernel/machine_kexec.c
--- a/arch/x86_64/kernel/machine_kexec.c
+++ b/arch/x86_64/kernel/machine_kexec.c
@@ -122,45 +122,43 @@ static int init_pgtable(struct kimage *i
 
 static void set_idt(void *newidt, u16 limit)
 {
-	unsigned char curidt[10];
+	struct desc_ptr curidt;
 
 	/* x86-64 supports unaliged loads & stores */
-	(*(u16 *)(curidt)) = limit;
-	(*(u64 *)(curidt +2)) = (unsigned long)(newidt);
+	curidt.size    = limit;
+	curidt.address = (unsigned long)newidt;
 
 	__asm__ __volatile__ (
-		"lidt %0\n"
-		: "=m" (curidt)
+		"lidtq %0\n"
+		:: "m" (curidt)
 		);
 };
 
 
 static void set_gdt(void *newgdt, u16 limit)
 {
-	unsigned char curgdt[10];
+	struct desc_ptr curgdt;
 
 	/* x86-64 supports unaligned loads & stores */
-	(*(u16 *)(curgdt)) = limit;
-	(*(u64 *)(curgdt +2)) = (unsigned long)(newgdt);
+	curgdt.size    = limit;
+	curgdt.address = (unsigned long)newgdt;
 
 	__asm__ __volatile__ (
-		"lgdt %0\n"
-		: "=m" (curgdt)
+		"lgdtq %0\n"
+		:: "m" (curgdt)
 		);
 };
 
 static void load_segments(void)
 {
 	__asm__ __volatile__ (
-		"\tmovl $"STR(__KERNEL_DS)",%eax\n"
-		"\tmovl %eax,%ds\n"
-		"\tmovl %eax,%es\n"
-		"\tmovl %eax,%ss\n"
-		"\tmovl %eax,%fs\n"
-		"\tmovl %eax,%gs\n"
+		"\tmovl %0,%%ds\n"
+		"\tmovl %0,%%es\n"
+		"\tmovl %0,%%ss\n"
+		"\tmovl %0,%%fs\n"
+		"\tmovl %0,%%gs\n"
+		:: "a" (__KERNEL_DS)
 		);
-#undef STR
-#undef __STR
 }
 
 typedef NORET_TYPE void (*relocate_new_kernel_t)(unsigned long indirection_page,
