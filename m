Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313491AbSDQKhQ>; Wed, 17 Apr 2002 06:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313501AbSDQKhP>; Wed, 17 Apr 2002 06:37:15 -0400
Received: from kim.it.uu.se ([130.238.12.178]:11512 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S313491AbSDQKhL>;
	Wed, 17 Apr 2002 06:37:11 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15549.20558.197268.638473@kim.it.uu.se>
Date: Wed, 17 Apr 2002 12:37:01 +0200
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot compile 2.4.19-pre7 with APIC without IOAPIC
In-Reply-To: <Pine.LNX.4.44.0204162016010.2155-100000@marabou.research.att.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin writes:
 > Hello!
 > 
 > I'm getting this error when compiling 2.4.19-pre7:
 > 
 > init/main.o: In function `smp_init':
 > init/main.o(.text.init+0x5e1): undefined reference to `skip_ioapic_setup'
 > arch/i386/kernel/kernel.o: In function `broken_pirq':
 > arch/i386/kernel/kernel.o(.text.init+0x3427): undefined reference to 
 > `skip_ioapic_setup'
 > 
 > Processor is AMD K7, SMP is disabled, APIC is enabled, IOAPIC is disabled.
 > 
 > It turns out that skip_ioapic_setup is defined in 
 > arch/i386/kernel/io_apic.c, which is only compiled when CONFIG_X86_IO_APIC 
 > is defined, but it's used in init/main.c if SMP is disabled and APIC is 
 > enabled.

Known problem. Apply the patch below.

/Mikael

--- linux-2.4.19-pre7/arch/i386/kernel/dmi_scan.c.~1~	Tue Apr 16 23:33:53 2002
+++ linux-2.4.19-pre7/arch/i386/kernel/dmi_scan.c	Tue Apr 16 23:34:15 2002
@@ -362,7 +362,7 @@
 	printk(KERN_INFO " *** If you see IRQ problems, in paticular SCSI resets and hangs at boot\n");
 	printk(KERN_INFO " *** contact your hardware vendor and ask about updates.\n");
 	printk(KERN_INFO " *** Building an SMP kernel may evade the bug some of the time.\n");
-#ifdef CONFIG_X86_UP_APIC
+#ifdef CONFIG_X86_IO_APIC
 	skip_ioapic_setup = 0;
 #endif
 	return 0;
--- linux-2.4.19-pre7/init/main.c.~1~	Tue Apr 16 23:33:56 2002
+++ linux-2.4.19-pre7/init/main.c	Tue Apr 16 23:34:54 2002
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
