Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSGLWjo>; Fri, 12 Jul 2002 18:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318055AbSGLWjL>; Fri, 12 Jul 2002 18:39:11 -0400
Received: from holomorphy.com ([66.224.33.161]:36511 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318045AbSGLWiI>;
	Fri, 12 Jul 2002 18:38:08 -0400
Date: Fri, 12 Jul 2002 15:39:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org, hpa@zytor.com
Subject: NUMA-Q breakage 4/7 cpu_init() heisenbug
Message-ID: <20020712223956.GB25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, mochel@osdl.org, hpa@zytor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_init() (or something nearby) is broken and there is no clear way to
tell why. Adding printk's seems to make it go away. hpa seemed to have
a notion of what was going on around here.

Workaround below.


Cheers,
Bill



===== arch/i386/kernel/cpu/common.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/cpu/common.c	Fri May 10 09:06:30 2002
+++ edited/arch/i386/kernel/cpu/common.c	Thu Jul 11 22:09:41 2002
@@ -446,6 +446,8 @@
 	__asm__ __volatile__("lgdt %0": "=m" (gdt_descr));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 
+	printk(KERN_INFO "Loading GDT/IDT for CPU#%d\n", nr);
+
 	/*
 	 * Delete NT
 	 */
@@ -466,6 +468,8 @@
 	load_TR(nr);
 	load_LDT(&init_mm.context);
 
+	printk(KERN_INFO "Loaded per-cpu LDT/TSS for CPU#%d\n", nr);
+
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
 
@@ -483,4 +487,6 @@
 	clear_thread_flag(TIF_USEDFPU);
 	current->used_math = 0;
 	stts();
+
+	printk(KERN_INFO "Cleaned up FPU and debug regs for CPU#%d\n", nr);
 }
