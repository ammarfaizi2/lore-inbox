Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290271AbSAXG1j>; Thu, 24 Jan 2002 01:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290270AbSAXG1a>; Thu, 24 Jan 2002 01:27:30 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:32997 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S290271AbSAXG1T>; Thu, 24 Jan 2002 01:27:19 -0500
Message-ID: <3C4FA975.22A91160@didntduck.org>
Date: Thu, 24 Jan 2002 01:28:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] small apic timer cleanup
Content-Type: multipart/mixed;
 boundary="------------0E5A2F711C42F853B6CF0CA0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0E5A2F711C42F853B6CF0CA0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This small patch removes the special case macro for the apic timer entry
stub, as it unnecessary to pass in the pointer to the pt_regs struct. 
Tested on a UP Athlon XP.

-- 

						Brian Gerst
--------------0E5A2F711C42F853B6CF0CA0
Content-Type: text/plain; charset=us-ascii;
 name="apictimer-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apictimer-1"

diff -urN linux-2.5.3-pre3/arch/i386/kernel/apic.c linux/arch/i386/kernel/apic.c
--- linux-2.5.3-pre3/arch/i386/kernel/apic.c	Mon Jan 14 21:57:05 2002
+++ linux/arch/i386/kernel/apic.c	Wed Jan 23 10:12:36 2002
@@ -1014,7 +1014,7 @@
  */
 unsigned int apic_timer_irqs [NR_CPUS];
 
-void smp_apic_timer_interrupt(struct pt_regs * regs)
+void smp_apic_timer_interrupt(struct pt_regs regs)
 {
 	int cpu = smp_processor_id();
 
@@ -1034,7 +1034,7 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter(cpu, 0);
-	smp_local_timer_interrupt(regs);
+	smp_local_timer_interrupt(&regs);
 	irq_exit(cpu, 0);
 
 	if (softirq_pending(cpu))
diff -urN linux-2.5.3-pre3/arch/i386/kernel/i8259.c linux/arch/i386/kernel/i8259.c
--- linux-2.5.3-pre3/arch/i386/kernel/i8259.c	Tue Jan 22 00:31:00 2002
+++ linux/arch/i386/kernel/i8259.c	Wed Jan 23 10:12:53 2002
@@ -93,7 +93,7 @@
  * a much simpler SMP time architecture:
  */
 #ifdef CONFIG_X86_LOCAL_APIC
-BUILD_SMP_TIMER_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+BUILD_SMP_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_SMP_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_SMP_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
 #endif
diff -urN linux-2.5.3-pre3/include/asm-i386/hw_irq.h linux/include/asm-i386/hw_irq.h
--- linux-2.5.3-pre3/include/asm-i386/hw_irq.h	Tue Jan 22 00:31:04 2002
+++ linux/include/asm-i386/hw_irq.h	Wed Jan 23 10:13:24 2002
@@ -137,22 +137,6 @@
 	"call "SYMBOL_NAME_STR(smp_##x)"\n\t" \
 	"jmp ret_from_intr\n");
 
-#define BUILD_SMP_TIMER_INTERRUPT(x,v) XBUILD_SMP_TIMER_INTERRUPT(x,v)
-#define XBUILD_SMP_TIMER_INTERRUPT(x,v) \
-asmlinkage void x(struct pt_regs * regs); \
-asmlinkage void call_##x(void); \
-__asm__( \
-"\n"__ALIGN_STR"\n" \
-SYMBOL_NAME_STR(x) ":\n\t" \
-	"pushl $"#v"-256\n\t" \
-	SAVE_ALL \
-	"movl %esp,%eax\n\t" \
-	"pushl %eax\n\t" \
-	SYMBOL_NAME_STR(call_##x)":\n\t" \
-	"call "SYMBOL_NAME_STR(smp_##x)"\n\t" \
-	"addl $4,%esp\n\t" \
-	"jmp ret_from_intr\n");
-
 #define BUILD_COMMON_IRQ() \
 asmlinkage void call_do_IRQ(void); \
 __asm__( \

--------------0E5A2F711C42F853B6CF0CA0--

