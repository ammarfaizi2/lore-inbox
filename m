Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSJ0NjI>; Sun, 27 Oct 2002 08:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSJ0NjI>; Sun, 27 Oct 2002 08:39:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:44204 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262391AbSJ0NjG>;
	Sun, 27 Oct 2002 08:39:06 -0500
Date: Sun, 27 Oct 2002 13:45:16 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] fix broken machine check bits in 2.5.44-ac4
Message-ID: <20021027134516.GA17803@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should do the trick for CONFIG_X86_MCE=n

diff -u linux-2.5/arch/i386/kernel/cpu/Makefile linux-2.5/arch/i386/kernel/cpu/Makefile
--- linux-2.5/arch/i386/kernel/cpu/Makefile	2002-10-25 18:02:31.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/Makefile	2002-10-27 12:24:39.000000000 -0100
@@ -13,7 +13,7 @@
 obj-y	+=	nexgen.o
 obj-y	+=	umc.o
 
-obj-y	+=	mcheck/
+obj-$(CONFIG_X86_MCE)	+=	mcheck/
 
 obj-$(CONFIG_MTRR)	+= 	mtrr/
 obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/
diff -u linux-2.5/arch/i386/kernel/cpu/common.c linux-2.5/arch/i386/kernel/cpu/common.c
--- linux-2.5/arch/i386/kernel/cpu/common.c	2002-10-25 18:02:31.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/common.c	2002-10-27 12:24:39.000000000 -0100
@@ -354,7 +354,9 @@
 	       boot_cpu_data.x86_capability[3]);
 
 	/* Init Machine Check Exception if available. */
+#ifdef CONFIG_X86_MCE
 	mcheck_init(c);
+#endif
 }
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
diff -u linux-2.5/arch/i386/kernel/cpu/mcheck/mce.c linux-2.5/arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.5/arch/i386/kernel/cpu/mcheck/mce.c	2002-10-25 18:02:32.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/mce.c	2002-10-27 12:24:39.000000000 -0100
@@ -13,8 +13,6 @@
 
 #include "mce.h"
 
-#ifdef CONFIG_X86_MCE
-
 int mce_disabled __initdata = 0;
 
 /* Handle unconfigured int18 (should never happen) */
@@ -79,6 +77,0 @@
-
-#else
-asmlinkage void do_machine_check(struct pt_regs * regs, long error_code) {}
-asmlinkage void smp_thermal_interrupt(struct pt_regs regs) {}
-void __init mcheck_init(struct cpuinfo_x86 *c) {}
-#endif
diff -u linux-2.5/arch/i386/kernel/traps.c linux-2.5/arch/i386/kernel/traps.c
--- linux-2.5/arch/i386/kernel/traps.c	2002-10-25 18:02:31.000000000 -0100
+++ linux-2.5/arch/i386/kernel/traps.c	2002-10-27 12:24:39.000000000 -0100
@@ -916,7 +916,9 @@
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
+#ifdef CONFIG_X86_MCE
 	set_trap_gate(18,&machine_check);
+#endif
 	set_trap_gate(19,&simd_coprocessor_error);
 
 	set_system_gate(SYSCALL_VECTOR,&system_call);
--- bk-linus/arch/i386/kernel/entry.S	2002-10-20 20:21:21.000000000 -0100
+++ linux-2.5/arch/i386/kernel/entry.S	2002-10-27 12:24:39.000000000 -0100
@@ -471,10 +471,12 @@ ENTRY(page_fault)
 	pushl $do_page_fault
 	jmp error_code
 
+#ifdef CONFIG_X86_MCE
 ENTRY(machine_check)
 	pushl $0
 	pushl $do_machine_check
 	jmp error_code
+#endif
 
 ENTRY(spurious_interrupt_bug)
 	pushl $0

-- 
| Dave Jones.        http://www.codemonkey.org.uk
