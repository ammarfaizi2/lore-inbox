Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbSLEWVP>; Thu, 5 Dec 2002 17:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbSLEWVP>; Thu, 5 Dec 2002 17:21:15 -0500
Received: from holomorphy.com ([66.224.33.161]:38796 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267539AbSLEWVB>;
	Thu, 5 Dec 2002 17:21:01 -0500
Date: Thu, 05 Dec 2002 14:28:20 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, davej@suse.de
Subject: [vm86] [1/2] call release_x86_irqs() in release_thread()
Message-ID: <0212051428.zaFdjcIa~c7dpasbvdjcrc9dZbEdSaVb3769@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fix, originally from Stas Sergeev has been acked by Manfred and
has been lingering around the -dj tree for a while.


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/process.c linux-2.5/arch/i386/kernel/process.c
--- bk-linus/arch/i386/kernel/process.c	2002-11-21 02:09:30.000000000 +0000
+++ linux-2.5/arch/i386/kernel/process.c	2002-11-21 17:55:02.000000000 +0000
@@ -44,6 +44,7 @@
 #include <asm/ldt.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
+#include <asm/irq.h>
 #include <asm/desc.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
@@ -269,6 +270,8 @@ void release_thread(struct task_struct *
 			BUG();
 		}
 	}
+
+	release_x86_irqs(dead_task);
 }
 
 /*
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/asm-i386/irq.h linux-2.5/include/asm-i386/irq.h
--- bk-linus/include/asm-i386/irq.h	2002-11-21 02:21:50.000000000 +0000
+++ linux-2.5/include/asm-i386/irq.h	2002-11-21 18:03:23.000000000 +0000
@@ -23,6 +23,7 @@ static __inline__ int irq_cannonicalize(
 extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
+extern void release_x86_irqs(struct task_struct *);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
