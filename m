Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWCHCfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWCHCfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWCHCfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:35:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:10423 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932148AbWCHCfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:35:24 -0500
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, mmlnx@us.ibm.com,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] fix kexec asm
Date: Tue, 7 Mar 2006 21:35:15 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072135.16116.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Matz <matz@suse.de>

While testing kexec and kdump we hit problems where the new kernel would
freeze or instantly reboot.  The easiest way to trigger it was to kexec a
kernel compiled for CONFIG_M586 on an athlon cpu.  Compiling
for CONFIG_MK7 instead would work fine.

The patch below fixes a few problems with the kexec inline asm.

Signed-off-by: Chris Mason <mason@suse.com>

---

diff -urp linux-2.6.15.suse/arch/i386/kernel/machine_kexec.c linux-2.6.15/arch/i386/kernel/machine_kexec.c
--- linux-2.6.15.suse/arch/i386/kernel/machine_kexec.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/arch/i386/kernel/machine_kexec.c	2006-02-08 04:19:13.000000000 +0100
@@ -116,13 +116,13 @@ static void load_segments(void)
 	__asm__ __volatile__ (
 		"\tljmp $"STR(__KERNEL_CS)",$1f\n"
 		"\t1:\n"
-		"\tmovl $"STR(__KERNEL_DS)",%eax\n"
-		"\tmovl %eax,%ds\n"
-		"\tmovl %eax,%es\n"
-		"\tmovl %eax,%fs\n"
-		"\tmovl %eax,%gs\n"
-		"\tmovl %eax,%ss\n"
-		);
+		"\tmovl $"STR(__KERNEL_DS)",%%eax\n"
+		"\tmovl %%eax,%%ds\n"
+		"\tmovl %%eax,%%es\n"
+		"\tmovl %%eax,%%fs\n"
+		"\tmovl %%eax,%%gs\n"
+		"\tmovl %%eax,%%ss\n"
+		::: "eax", "memory");
 #undef STR
 #undef __STR
 }
diff -urp linux-2.6.15.suse/arch/x86_64/kernel/machine_kexec.c linux-2.6.15/arch/x86_64/kernel/machine_kexec.c
--- linux-2.6.15.suse/arch/x86_64/kernel/machine_kexec.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/arch/x86_64/kernel/machine_kexec.c	2006-02-08 04:21:13.000000000 +0100
@@ -140,7 +140,7 @@ static void load_segments(void)
 		"\tmovl %0,%%ss\n"
 		"\tmovl %0,%%fs\n"
 		"\tmovl %0,%%gs\n"
-		: : "a" (__KERNEL_DS)
+		: : "a" (__KERNEL_DS) : "memory"
 		);
 }
 
diff -urp linux-2.6.15.suse/include/asm-powerpc/kexec.h linux-2.6.15/include/asm-powerpc/kexec.h
--- linux-2.6.15.suse/include/asm-powerpc/kexec.h	2006-02-08 04:10:24.000000000 +0100
+++ linux-2.6.15/include/asm-powerpc/kexec.h	2006-02-08 04:31:15.000000000 +0100
@@ -93,7 +93,8 @@ static inline void crash_setup_regs(stru
 			"mfxer  %0\n"
 			"std    %0, 296(%2)\n"
 			: "=&r" (tmp1), "=&r" (tmp2)
-			: "b" (newregs));
+			: "b" (newregs)
+			: "memory");
 	}
 }
 #else
