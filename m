Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTDSSJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTDSSJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 14:09:29 -0400
Received: from mail1.ewetel.de ([212.6.122.16]:33525 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263423AbTDSSJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 14:09:27 -0400
Date: Sat, 19 Apr 2003 20:21:18 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5] report unknown NMI reasons only once
Message-ID: <Pine.LNX.4.44.0304192010020.1306-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi people!

On my machine (Athlon XP on an old ALi Magik1 motherboard), I get tons of
messages like:

Uhhuh. NMI received for unknown reason 2d on CPU 0.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?

There's nothing I can do about them (ACPI or APIC support in the kernel or
not does not make a difference, nor do any of the BIOS power management
settings). The machine runs fine, no problems in memtest86, and I've not
noticed a problem with a system in the three or four months that I'm
running this configuration.

Those NMIs happen only rarely when the machine is lightly loaded, but
under load, I get several of them per second. This quickly makes
/var/log/messages grow.

I don't think reporting any of those NMIs more than once provides
valuable information, so I've cooked up a patch which only reports each
unknown NMI reason once.

I don't know who the maintainer of arch/i386/kernel/traps.c is supposed
to be, so I'm sending this to the list and CC to Alan since he is not
unlikely to take small patches like this. ;)

Patch against 2.5.67-bk10. Compiles, boots and does what it's supposed to
do on my machine.

Comments, anyone?

--- linux-2.5.67-bk10/arch/i386/kernel/traps.c	Sat Apr 19 20:00:42 2003
+++ work/arch/i386/kernel/traps.c	Sat Apr 19 20:17:40 2003
@@ -5,6 +5,8 @@
  *
  *  Pentium III FXSR, SSE support
  *	Gareth Hughes <gareth@valinux.com>, May 2000
+ *  Limit unknown NMI reporting
+ *     Pascal Schmidt <der.eremit@email.de>, April 2003
  */
 
 /*
@@ -48,6 +50,8 @@
 #include <asm/pgalloc.h>
 #include <asm/arch_hooks.h>
 
+#include <asm/bitops.h>
+
 #include <linux/irq.h>
 #include <linux/module.h>
 
@@ -417,6 +421,9 @@ static void io_check_error(unsigned char
 	outb(reason, 0x61);
 }
 
+/* bit field for already reported unknown NMI reasons */
+static int unknown_nmi_reported[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
+
 static void unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
 {
 #ifdef CONFIG_MCA
@@ -427,10 +434,13 @@ static void unknown_nmi_error(unsigned c
 		return;
 	}
 #endif
-	printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
-		reason, smp_processor_id());
-	printk("Dazed and confused, but trying to continue\n");
-	printk("Do you have a strange power saving mode enabled?\n");
+	if ( !test_bit(reason, (void *)&unknown_nmi_reported) ) {
+		printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
+			reason, smp_processor_id());
+		printk("Dazed and confused, but trying to continue\n");
+		printk("Do you have a strange power saving mode enabled?\n");
+		__set_bit(reason, (void *)&unknown_nmi_reported);
+	}
 }
 
 static void default_do_nmi(struct pt_regs * regs)

-- 
Ciao,
Pascal

