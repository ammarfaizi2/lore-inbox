Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVG2TDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVG2TDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVG2TBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:01:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40585 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262730AbVG2TB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:01:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 machine_kexec: Cleanup inline assembly
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 13:01:18 -0600
Message-ID: <m1r7dh308x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reason I was telling my inline assembly that the
input argument was an output argument.

Playing in the trampoline code I have seen a couple of
instances where lgdt get the wrong size (because the
trampolines run in 16bit mode) so use lgdtl and lidtl to
be explicit.

Additionally gcc-3.3 and gcc-3.4 want's an lvalue for a
memory argument and it doesn't think an array of characters
is an lvalue so use a packed structure instead.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/i386/kernel/machine_kexec.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

325a7d01008f3553104879cd64f82b68d00c85cd
diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -16,6 +16,7 @@
 #include <asm/io.h>
 #include <asm/apic.h>
 #include <asm/cpufeature.h>
+#include <asm/desc.h>
 
 static inline unsigned long read_cr3(void)
 {
@@ -90,33 +91,32 @@ static void identity_map_page(unsigned l
 }
 #endif
 
-
 static void set_idt(void *newidt, __u16 limit)
 {
-	unsigned char curidt[6];
+	struct Xgt_desc_struct curidt;
 
 	/* ia32 supports unaliged loads & stores */
-	(*(__u16 *)(curidt)) = limit;
-	(*(__u32 *)(curidt +2)) = (unsigned long)(newidt);
+	curidt.size    = limit;
+	curidt.address = (unsigned long)newidt;
 
 	__asm__ __volatile__ (
-		"lidt %0\n"
-		: "=m" (curidt)
+		"lidtl %0\n"
+		:: "m" (curidt)
 		);
 };
 
 
 static void set_gdt(void *newgdt, __u16 limit)
 {
-	unsigned char curgdt[6];
+	struct Xgt_desc_struct curgdt;
 
 	/* ia32 supports unaligned loads & stores */
-	(*(__u16 *)(curgdt)) = limit;
-	(*(__u32 *)(curgdt +2)) = (unsigned long)(newgdt);
+	curgdt.size    = limit;
+	curgdt.address = (unsigned long)newgdt;
 
 	__asm__ __volatile__ (
-		"lgdt %0\n"
-		: "=m" (curgdt)
+		"lgdtl %0\n"
+		:: "m" (curgdt)
 		);
 };
 
