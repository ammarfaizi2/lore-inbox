Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUCNT2n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 14:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUCNT2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 14:28:42 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:20638 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261582AbUCNT2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 14:28:36 -0500
Subject: [PATCH] Fix voyager to boot again
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Mar 2004 14:28:29 -0500
Message-Id: <1079292510.2022.52.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The very early memory detection patch broke voyager.

This fixes it again.

James

===== arch/i386/Kconfig 1.108 vs edited =====
--- 1.108/arch/i386/Kconfig	Fri Mar 12 03:33:00 2004
+++ edited/arch/i386/Kconfig	Sun Mar 14 11:22:59 2004
@@ -1332,6 +1332,11 @@
 	depends on !(X86_VISWS || X86_VOYAGER)
 	default y
 
+config X86_TRAMPOLINE
+	bool
+	depends on X86_SMP || (X86_VOYAGER && SMP)
+	default y
+
 config PC
 	bool
 	depends on X86 && !EMBEDDED
===== arch/i386/defconfig 1.107 vs edited =====
--- 1.107/arch/i386/defconfig	Fri Mar 12 03:30:22 2004
+++ edited/arch/i386/defconfig	Sun Mar 14 11:23:00 2004
@@ -1212,4 +1212,5 @@
 CONFIG_X86_SMP=y
 CONFIG_X86_HT=y
 CONFIG_X86_BIOS_REBOOT=y
+CONFIG_X86_TRAMPOLINE=y
 CONFIG_PC=y
===== arch/i386/kernel/Makefile 1.56 vs edited =====
--- 1.56/arch/i386/kernel/Makefile	Fri Mar 12 03:30:22 2004
+++ edited/arch/i386/kernel/Makefile	Sun Mar 14 11:23:01 2004
@@ -18,7 +18,8 @@
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_APM)		+= apm.o
-obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o trampoline.o
+obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
===== arch/i386/mach-voyager/voyager_smp.c 1.18 vs edited =====
--- 1.18/arch/i386/mach-voyager/voyager_smp.c	Mon Jan 19 00:32:52 2004
+++ edited/arch/i386/mach-voyager/voyager_smp.c	Sun Mar 14 11:23:02 2004
@@ -623,7 +623,9 @@
 		((virt_to_phys(page_table_copies)) & PAGE_MASK)
 		| _PAGE_RW | _PAGE_USER | _PAGE_PRESENT;
 #else
-	((unsigned long *)swapper_pg_dir)[0] = 0x102007;
+	((unsigned long *)swapper_pg_dir)[0] = 
+		(virt_to_phys(pg0) & PAGE_MASK)
+		| _PAGE_RW | _PAGE_USER | _PAGE_PRESENT;
 #endif
 
 	if(quad_boot) {


