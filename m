Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbTBMK0U>; Thu, 13 Feb 2003 05:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268016AbTBMK0U>; Thu, 13 Feb 2003 05:26:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:50903 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268017AbTBMK0M>; Thu, 13 Feb 2003 05:26:12 -0500
Date: Thu, 13 Feb 2003 16:10:14 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
Message-ID: <20030213161014.A14361@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Martin Bligh came up with a simple way to fix the kernel
to enable kexec boot from any CPU. 

Rather than picking up boot cpu information from the MP 
tables (which belong to the previous boot in the case of 
kexec), it just sets it to the cpu its starting on.
(See the changes in arch/i386/kernel/smpboot.c)

This simplifies the the kexec-hwfixes patch, since we
no longer need to move to the boot cpu before stopping
other processors. Which removes a lot of the unconditional
patching of reboot.c and makes it less invasive, thanks to 
Martin. Also, at panic time, cpu migration is something 
that is best avoided.

It would be good if someone could test this out (on SMP)
and confirm it works fine (I tried it on a 4way).

Eric, Do these changes look OK to you ? Did you have
something similar in mind, when you were talking about
enabling the kexec'd kernel to not care about which cpu
it was running on ?

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kexec-hwfixes.patch"

diff -ur -X ../../dontdiff linux-2.5.59-kexec/arch/i386/kernel/apic.c linux-2.5.59-kexecfixes/arch/i386/kernel/apic.c
--- linux-2.5.59-kexec/arch/i386/kernel/apic.c	Fri Jan 17 07:53:00 2003
+++ linux-2.5.59-kexecfixes/arch/i386/kernel/apic.c	Thu Feb 13 10:14:44 2003
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/reboot.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -155,6 +156,36 @@
 		outb(0x70, 0x22);
 		outb(0x00, 0x23);
 	}
+	else {
+		/* Go back to Virtual Wire compatibility mode */
+		unsigned long value;
+
+		/* For the spurious interrupt use vector F, and enable it */
+		value = apic_read(APIC_SPIV);
+		value &= ~APIC_VECTOR_MASK; 
+		value |= APIC_SPIV_APIC_ENABLED;
+		value |= 0xf;
+		apic_write_around(APIC_SPIV, value);
+
+		/* For LVT0 make it edge triggered, active high, external and enabled */
+		value = apic_read(APIC_LVT0);
+		value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING | 
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR | 
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXINT);
+		apic_write_around(APIC_LVT0, value);
+		
+		/* For LVT1 make it edge triggered, active high, nmi and enabled */
+		value = apic_read(APIC_LVT1);
+		value &= ~(
+			APIC_MODE_MASK | APIC_SEND_PENDING | 
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR | 
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
+		apic_write_around(APIC_LVT1, value);
+	}
 }
 
 void disable_local_APIC(void)
@@ -1116,6 +1147,26 @@
 	irq_exit();
 }
 
+void stop_apics(void)
+{
+	/* By resetting the APIC's we disable the nmi watchdog */
+#if CONFIG_SMP
+	/*
+	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
+	 * other OSs see a clean IRQ state.
+	 */
+	smp_send_stop();
+#else
+	disable_local_APIC();
+#endif
+#if defined(CONFIG_X86_IO_APIC)
+	if (smp_found_config) {
+		disable_IO_APIC();
+	}
+#endif
+	disconnect_bsp_APIC();
+}
+
 /*
  * This initializes the IO-APIC and APIC hardware if this is
  * a UP kernel.
diff -ur -X ../../dontdiff linux-2.5.59-kexec/arch/i386/kernel/i8259.c linux-2.5.59-kexecfixes/arch/i386/kernel/i8259.c
--- linux-2.5.59-kexec/arch/i386/kernel/i8259.c	Fri Jan 17 07:52:43 2003
+++ linux-2.5.59-kexecfixes/arch/i386/kernel/i8259.c	Thu Feb 13 10:14:44 2003
@@ -246,10 +246,21 @@
 	return 0;
 }
 
+static void i8259A_shutdown(struct device *dev)
+{   
+	/* Put the i8259A into a quiescent state that
+	 * the kernel initialization code can get it
+	 * out of.
+	 */
+	outb(0xff, 0x21);	/* mask all of 8259A-1 */
+	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
+}
+
 static struct device_driver i8259A_driver = {
 	.name		= "pic",
 	.bus		= &system_bus_type,
 	.resume		= i8259A_resume,
+	.shutdown	= i8259A_shutdown,
 };
 
 static struct sys_device device_i8259A = {
diff -ur -X ../../dontdiff linux-2.5.59-kexec/arch/i386/kernel/io_apic.c linux-2.5.59-kexecfixes/arch/i386/kernel/io_apic.c
--- linux-2.5.59-kexec/arch/i386/kernel/io_apic.c	Fri Jan 17 07:52:00 2003
+++ linux-2.5.59-kexecfixes/arch/i386/kernel/io_apic.c	Thu Feb 13 10:14:44 2003
@@ -1121,8 +1121,6 @@
 	 * Clear the IO-APIC before rebooting:
 	 */
 	clear_IO_APIC();
-
-	disconnect_bsp_APIC();
 }
 
 /*
diff -ur -X ../../dontdiff linux-2.5.59-kexec/arch/i386/kernel/machine_kexec.c linux-2.5.59-kexecfixes/arch/i386/kernel/machine_kexec.c
--- linux-2.5.59-kexec/arch/i386/kernel/machine_kexec.c	Thu Feb 13 10:38:46 2003
+++ linux-2.5.59-kexecfixes/arch/i386/kernel/machine_kexec.c	Thu Feb 13 10:14:44 2003
@@ -82,6 +82,8 @@
 	/* switch to an mm where the reboot_code_buffer is identity mapped */
 	switch_mm(current->active_mm, &init_mm, current, smp_processor_id());
 
+	stop_apics();
+
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 	reboot_code_buffer = page_to_pfn(image->reboot_code_pages) << PAGE_SHIFT;
diff -ur -X ../../dontdiff linux-2.5.59-kexec/arch/i386/kernel/reboot.c linux-2.5.59-kexecfixes/arch/i386/kernel/reboot.c
--- linux-2.5.59-kexec/arch/i386/kernel/reboot.c	Fri Jan 17 07:51:49 2003
+++ linux-2.5.59-kexecfixes/arch/i386/kernel/reboot.c	Thu Feb 13 10:19:57 2003
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include <asm/apic.h>
 
 /*
  * Power off function, if any
@@ -252,13 +253,12 @@
 		for (;;)
 		__asm__ __volatile__ ("hlt");
 	}
+#endif
 	/*
 	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
 	 * other OSs see a clean IRQ state.
 	 */
-	smp_send_stop();
-	disable_IO_APIC();
-#endif
+	stop_apics();
 
 	if(!reboot_thru_bios) {
 		/* rebooting needs to touch the page at absolute addr 0 */
@@ -282,10 +282,12 @@
 
 void machine_halt(void)
 {
+	stop_apics();
 }
 
 void machine_power_off(void)
 {
+	stop_apics();
 	if (pm_power_off)
 		pm_power_off();
 }
diff -ur -X ../../dontdiff linux-2.5.59-kexec/arch/i386/kernel/smpboot.c linux-2.5.59-kexecfixes/arch/i386/kernel/smpboot.c
--- linux-2.5.59-kexec/arch/i386/kernel/smpboot.c	Fri Jan 17 07:52:09 2003
+++ linux-2.5.59-kexecfixes/arch/i386/kernel/smpboot.c	Thu Feb 13 10:14:44 2003
@@ -967,6 +967,7 @@
 	printk("CPU%d: ", 0);
 	print_cpu_info(&cpu_data[0]);
 
+	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 
 	current_thread_info()->cpu = 0;
@@ -1026,8 +1027,6 @@
 	setup_local_APIC();
 	map_cpu_to_logical_apicid();
 
-	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
-		BUG();
 
 	setup_portio_remap();
 
diff -ur -X ../../dontdiff linux-2.5.59-kexec/include/asm-i386/apic.h linux-2.5.59-kexecfixes/include/asm-i386/apic.h
--- linux-2.5.59-kexec/include/asm-i386/apic.h	Fri Jan 17 07:52:56 2003
+++ linux-2.5.59-kexecfixes/include/asm-i386/apic.h	Thu Feb 13 10:14:44 2003
@@ -96,6 +96,9 @@
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+extern void stop_apics(void);
+#else
+static inline void stop_apics(void) { }
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #endif /* __ASM_APIC_H */
diff -ur -X ../../dontdiff linux-2.5.59-kexec/include/asm-i386/apicdef.h linux-2.5.59-kexecfixes/include/asm-i386/apicdef.h
--- linux-2.5.59-kexec/include/asm-i386/apicdef.h	Fri Jan 17 07:52:15 2003
+++ linux-2.5.59-kexecfixes/include/asm-i386/apicdef.h	Thu Feb 13 10:14:44 2003
@@ -93,6 +93,7 @@
 #define			APIC_LVT_REMOTE_IRR		(1<<14)
 #define			APIC_INPUT_POLARITY		(1<<13)
 #define			APIC_SEND_PENDING		(1<<12)
+#define			APIC_MODE_MASK			0x700
 #define			GET_APIC_DELIVERY_MODE(x)	(((x)>>8)&0x7)
 #define			SET_APIC_DELIVERY_MODE(x,y)	(((x)&~0x700)|((y)<<8))
 #define				APIC_MODE_FIXED		0x0

--fdj2RfSjLxBAspz7--
