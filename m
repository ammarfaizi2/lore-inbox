Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbUCMRQY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUCMRQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:16:24 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:24006 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263133AbUCMRQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:16:09 -0500
Subject: i386 very early memory detection cleanup patch breaks the build
From: James Bottomley <James.Bottomley@steeleye.com>
To: hpa@zytor.com, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Mar 2004 12:15:38 -0500
Message-Id: <1079198139.2512.19.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached should fix it again.

This tampering with the trampoline was extraneous to the actual patch. 
The rule should be that if you don't understand what something is doing,
don't try to fix it.

In this case CONFIG_X86_TRAMPOLINE is needed for the subarch's that
provide their own SMP code but still use the standard trampoline.  I
always thought the visws used the trampoline even in UP boot, but if it
doesn't, just take out the X86_VISWS dependency.

James

P.S.  I'm still compiling, I'll yell again if the patch breaks at
runtime too.

===== arch/i386/Kconfig 1.108 vs edited =====
--- 1.108/arch/i386/Kconfig	Fri Mar 12 03:33:00 2004
+++ edited/arch/i386/Kconfig	Sat Mar 13 10:55:36 2004
@@ -1332,6 +1332,11 @@
 	depends on !(X86_VISWS || X86_VOYAGER)
 	default y
 
+config X86_TRAMPOLINE
+	bool
+	depends on SMP || X86_VISWS
+	default y
+
 config PC
 	bool
 	depends on X86 && !EMBEDDED
===== arch/i386/defconfig 1.107 vs edited =====
--- 1.107/arch/i386/defconfig	Fri Mar 12 03:30:22 2004
+++ edited/arch/i386/defconfig	Sat Mar 13 10:55:37 2004
@@ -1212,4 +1212,5 @@
 CONFIG_X86_SMP=y
 CONFIG_X86_HT=y
 CONFIG_X86_BIOS_REBOOT=y
+CONFIG_X86_TRAMPOLINE=y
 CONFIG_PC=y
===== arch/i386/kernel/Makefile 1.56 vs edited =====
--- 1.56/arch/i386/kernel/Makefile	Fri Mar 12 03:30:22 2004
+++ edited/arch/i386/kernel/Makefile	Sat Mar 13 10:55:37 2004
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

