Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUCNCJE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbUCNCJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:09:03 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:53209 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261478AbUCNCI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:08:59 -0500
Subject: Re: i386 very early memory detection cleanup patch breaks the build
From: James Bottomley <James.Bottomley@steeleye.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40538B39.90803@zytor.com>
References: <1079198139.2512.19.camel@mulgrave>
		<40538091.9050707@zytor.com> <1079215809.2513.39.camel@mulgrave> 
	<40538B39.90803@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Mar 2004 21:05:20 -0500
Message-Id: <1079229921.2074.65.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I found it, it was a swapper_pg_dir replacement assumption that
breaks if pg0 isn't in the known location.  Voyager still does odd
tricks with this because it also has a 486 SMP configuration (which I've
yet to test still boots...).

The attached patch fixes everything for me (do we agree on the
trampoline thing as the final form?)

James

===== arch/i386/Kconfig 1.108 vs edited =====
--- 1.108/arch/i386/Kconfig	Fri Mar 12 03:33:00 2004
+++ edited/arch/i386/Kconfig	Sat Mar 13 19:52:50 2004
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
+++ edited/arch/i386/defconfig	Sat Mar 13 14:14:02 2004
@@ -1212,4 +1212,5 @@
 CONFIG_X86_SMP=y
 CONFIG_X86_HT=y
 CONFIG_X86_BIOS_REBOOT=y
+CONFIG_X86_TRAMPOLINE=y
 CONFIG_PC=y
===== arch/i386/kernel/Makefile 1.56 vs edited =====
--- 1.56/arch/i386/kernel/Makefile	Fri Mar 12 03:30:22 2004
+++ edited/arch/i386/kernel/Makefile	Sat Mar 13 14:14:02 2004
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
+++ edited/arch/i386/mach-voyager/voyager_smp.c	Sat Mar 13 19:50:47 2004
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

