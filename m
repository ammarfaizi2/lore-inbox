Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSEDOFD>; Sat, 4 May 2002 10:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSEDOFC>; Sat, 4 May 2002 10:05:02 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:49618 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313016AbSEDOFA>;
	Sat, 4 May 2002 10:05:00 -0400
Date: Sat, 4 May 2002 16:04:58 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205041404.QAA02175@harpo.it.uu.se>
To: marcelo@conectiva.com.br
Subject: [PATCH] fix 2.4.19-pre8 UP APIC breakage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

2.4.19-pre8 gets a linker error if CONFIG_X86_UP_APIC=y and
CONFIG_X86_UP_IOAPIC=n:

init/main.o: In function `smp_init':
init/main.o(.text.init+0x59e): undefined reference to `skip_ioapic_setup'
arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x3272): undefined reference to `skip_ioapic_setup'

The patch below fixes this. Please apply.

/Mikael

--- linux-2.4.19-pre8/arch/i386/kernel/dmi_scan.c.~1~	Sat May  4 14:45:18 2002
+++ linux-2.4.19-pre8/arch/i386/kernel/dmi_scan.c	Sat May  4 15:33:26 2002
@@ -418,7 +418,7 @@
 	printk(KERN_INFO " *** If you see IRQ problems, in paticular SCSI resets and hangs at boot\n");
 	printk(KERN_INFO " *** contact your hardware vendor and ask about updates.\n");
 	printk(KERN_INFO " *** Building an SMP kernel may evade the bug some of the time.\n");
-#ifdef CONFIG_X86_UP_APIC
+#ifdef CONFIG_X86_IO_APIC
 	skip_ioapic_setup = 0;
 #endif
 	return 0;
--- linux-2.4.19-pre8/init/main.c.~1~	Sat May  4 15:25:27 2002
+++ linux-2.4.19-pre8/init/main.c	Sat May  4 15:33:32 2002
@@ -293,11 +293,9 @@
 #ifndef CONFIG_SMP
 
 #ifdef CONFIG_X86_LOCAL_APIC
-extern int skip_ioapic_setup;
 static void __init smp_init(void)
 {
-	if (!skip_ioapic_setup)
-		APIC_init_uniprocessor();
+	APIC_init_uniprocessor();
 }
 #else
 #define smp_init()	do { } while (0)
