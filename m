Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSEGLna>; Tue, 7 May 2002 07:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSEGLna>; Tue, 7 May 2002 07:43:30 -0400
Received: from kim.it.uu.se ([130.238.12.178]:50175 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S315415AbSEGLn1>;
	Tue, 7 May 2002 07:43:27 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15575.48583.90366.619941@kim.it.uu.se>
Date: Tue, 7 May 2002 13:43:03 +0200
To: Ben Castricum <root@cia.c64.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8 doesn't compile (missing skip_ioapic_setup)
In-Reply-To: <Pine.LNX.4.21.0205071902260.3449-100000@spike.i-lan.nl>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Castricum writes:
 > Having a go at 2.4.19-pre8 gives me this error:
 > ...
 > init/main.o: In function `smp_init':
 > init/main.o(.text.init+0x59e): undefined reference to `skip_ioapic_setup'
 > arch/i386/kernel/kernel.o: In function `broken_pirq':
 > arch/i386/kernel/kernel.o(.text.init+0x3096): undefined reference to
 > `skip_ioapic_setup'
 > make: *** [vmlinux] Error 1
 > 
 > 
 > Not using local io-apic makes the problem (and the feature) go away. This
 > is on a uni-processor system with SMP disabled. Full .config at

Apply the patch below.

/Mikael

--- linux-2.4.19-pre8/arch/i386/kernel/dmi_scan.c.~1~	Sat May  4 15:35:10 2002
+++ linux-2.4.19-pre8/arch/i386/kernel/dmi_scan.c	Sat May  4 17:51:32 2002
@@ -418,7 +418,7 @@
 	printk(KERN_INFO " *** If you see IRQ problems, in paticular SCSI resets and hangs at boot\n");
 	printk(KERN_INFO " *** contact your hardware vendor and ask about updates.\n");
 	printk(KERN_INFO " *** Building an SMP kernel may evade the bug some of the time.\n");
-#ifdef CONFIG_X86_UP_APIC
+#ifdef CONFIG_X86_IO_APIC
 	skip_ioapic_setup = 0;
 #endif
 	return 0;
--- linux-2.4.19-pre8/init/main.c.~1~	Sat May  4 15:35:18 2002
+++ linux-2.4.19-pre8/init/main.c	Sat May  4 17:51:32 2002
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
