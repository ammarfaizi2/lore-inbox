Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313780AbSDPTnu>; Tue, 16 Apr 2002 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313756AbSDPTnt>; Tue, 16 Apr 2002 15:43:49 -0400
Received: from imladris.infradead.org ([194.205.184.45]:47877 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313780AbSDPTns>; Tue, 16 Apr 2002 15:43:48 -0400
Date: Tue, 16 Apr 2002 20:43:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] skip_ioapic_setup
Message-ID: <20020416204346.A11615@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva> <20020416112037.GA9185@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 01:20:37PM +0200, Philipp Matthias Hahn wrote:
> 
> skip_ioapic_setup is defined in arch/i386/io_apic.c, which is
> conditionally compiled only, if CONFIG_X86_IO_APIC is defined. which is
> only defined for SMP or when CONFIG_X86_UP_IOAPIC is set.
> 
> init/main.c:332 and arch/i386/kernel/dmi_scan.c:357 do both use it and
> don't depend on CONFIG_X86_IO_APIC themselves.

This patch should fix it:

diff -uNr -Xdontdiff linux-2.4.19-pre7/arch/i386/kernel/dmi_scan.c linux/arch/i386/kernel/dmi_scan.c
--- linux-2.4.19-pre7/arch/i386/kernel/dmi_scan.c	Tue Apr 16 20:49:06 2002
+++ linux/arch/i386/kernel/dmi_scan.c	Tue Apr 16 20:56:03 2002
@@ -362,7 +362,7 @@
 	printk(KERN_INFO " *** If you see IRQ problems, in paticular SCSI resets and hangs at boot\n");
 	printk(KERN_INFO " *** contact your hardware vendor and ask about updates.\n");
 	printk(KERN_INFO " *** Building an SMP kernel may evade the bug some of the time.\n");
-#ifdef CONFIG_X86_UP_APIC
+#ifdef CONFIG_X86_UP_IOAPIC
 	skip_ioapic_setup = 0;
 #endif
 	return 0;
diff -uNr -Xdontdiff linux-2.4.19-pre7/init/main.c linux/init/main.c
--- linux-2.4.19-pre7/init/main.c	Tue Apr 16 20:47:46 2002
+++ linux/init/main.c	Tue Apr 16 20:59:56 2002
@@ -296,8 +296,7 @@
 extern int skip_ioapic_setup;
 static void __init smp_init(void)
 {
-	if (!skip_ioapic_setup)
-		APIC_init_uniprocessor();
+	APIC_init_uniprocessor();
 }
 #else
 #define smp_init()	do { } while (0)
