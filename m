Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272599AbTHKNos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272664AbTHKNne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:34 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:28299 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272604AbTHKNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:56 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable APIC on reboot.
Message-Id: <E19mCuO-0003dI-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forward port of a patch from Felix [surname mangled by MTA] <fxkuehl@gmx.de>

Original mail:-

when I reboot my laptop the BIOS complains about a keyboard controller
failure and timer interrupts not working. On the BIOS password screen
the keyboard doesn't work. If I disable the BIOS password the system
hangs a bit later on the POST screen. I tried all reboot methods via the
kernel command line without success. I saw this problem with Debian
Woody's precompiled 2.4.18 kernel, self compiled Debian 2.4.20 sources
and Linux 2.4.21-rc1+ACPI patch. This problem only occurs if
CONFIG_X86_LOCAL_APIC is enabled. With CONFIG_X86_LOCAL_APIC disabled it
reboots just fine.

My guess is that it's a BIOS bug as I've never had this problem on other
machines before. I found a workaround: disable the local APIC before
rebooting. I don't really know how it works. Just calling
disable_local_APIC wasn't enough, so I copied a bit more code from
apic_pm_suspend (arch/i386/kernel/apic.c:465) to machine_restart
(arch/i386/kernel/process.c:369). I'm pretty sure that this is not the
proper way to do it but it works here. A patch against 2.4.21-rc1 can be
found at the end of this email.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/reboot.c linux-2.5/arch/i386/kernel/reboot.c
--- bk-linus/arch/i386/kernel/reboot.c	2003-05-13 11:51:12.000000000 +0100
+++ linux-2.5/arch/i386/kernel/reboot.c	2003-07-16 02:54:29.000000000 +0100
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include <asm/apic.h>
 #include "mach_reboot.h"
 
 /*
@@ -250,6 +251,19 @@ void machine_restart(char * __unused)
 	 */
 	smp_send_stop();
 	disable_IO_APIC();
+#else
+#ifdef CONFIG_X86_LOCAL_APIC
+	{
+	unsigned int l, h;
+
+	local_irq_disable();
+	disable_local_APIC();
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	l &= ~MSR_IA32_APICBASE_ENABLE;
+	wrmsr(MSR_IA32_APICBASE, l, h);
+	local_irq_enable();
+}
+#endif
 #endif
 
 	if(!reboot_thru_bios) {
