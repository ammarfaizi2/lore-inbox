Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWCBFDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWCBFDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 00:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWCBFDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 00:03:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:38352 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750866AbWCBFDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 00:03:12 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386 II
Date: Thu, 2 Mar 2006 06:02:59 +0100
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200602281905_MC3-1-B97E-7FDC@compuserve.com> <p73psl6zbwf.fsf@verdi.suse.de> <20060301025219.2034924c.akpm@osdl.org>
In-Reply-To: <20060301025219.2034924c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020603.00210.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 11:52, Andrew Morton wrote:

> Well..  the patch had a flagrant won't-compile if CONFIG_X86_IO_APIC=y, so
> I'd consider it a bit green.

I did my own version of it then. Tested it a bit in various configurations
and it works for me.

I would consider it a 2.6.16 candidate because it fixes an important bug.


Port the x86-64 ATI timer fix over to i386

ATI chipsets tend to generate double timer interrupts for the local
APIC timer when both the 8254 and the IO-APIC timer pins are enabled.
This is because they route it to both and the result is anded
together and the CPU ends up processing it twice.

This patch changes check_timer to disable the 8254 routing
for interruopt 0.

I think it would be safe on all chipsets actually (i tested it on 
a couple and it worked everywhere) and Windows seems to do 
it in a similar way, but to be conservative this patch only
enables this mode on ATI (and adds options to enable/disable too) 

Ported over from a similar x86-64 change.

I reused the ACPI earlyquirk infrastructure for the ATI bridge check, but
tweaked it a bit to work even without ACPI.

Inspired by a patch from Chuck Ebbert, but redone.

Cc:  Chuck Ebbert <76306.1226@compuserve.com>
Cc: len.brown@intel.com

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile
+++ linux/arch/i386/kernel/Makefile
@@ -11,7 +11,7 @@ obj-y	:= process.o semaphore.o signal.o 
 
 obj-y				+= cpu/
 obj-y				+= timers/
-obj-$(CONFIG_ACPI)		+= acpi/
+obj-y				+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
 obj-$(CONFIG_X86_MSR)		+= msr.o
Index: linux/arch/i386/kernel/acpi/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/acpi/Makefile
+++ linux/arch/i386/kernel/acpi/Makefile
@@ -1,4 +1,4 @@
-obj-y				:= boot.o
+obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_X86_IO_APIC)	+= earlyquirk.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup.o
 
Index: linux/arch/i386/kernel/acpi/earlyquirk.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/earlyquirk.c
+++ linux/arch/i386/kernel/acpi/earlyquirk.c
@@ -7,14 +7,22 @@
 #include <linux/pci.h>
 #include <asm/pci-direct.h>
 #include <asm/acpi.h>
+#include <asm/apic.h>
 
 static int __init check_bridge(int vendor, int device)
 {
+#ifdef CONFIG_ACPI
 	/* According to Nvidia all timer overrides are bogus. Just ignore
 	   them all. */
 	if (vendor == PCI_VENDOR_ID_NVIDIA) {
 		acpi_skip_timer_override = 1;
 	}
+#endif
+	if (vendor == PCI_VENDOR_ID_ATI && timer_over_8254 == 1) {
+		timer_over_8254 = 0;
+		printk(KERN_INFO
+	"ATI board detected. Disabling timer routing over 8254.\n");
+	}    
 	return 0;
 }
 
Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -51,6 +51,8 @@ static struct { int pin, apic; } ioapic_
 
 static DEFINE_SPINLOCK(ioapic_lock);
 
+int timer_over_8254 __initdata = 1;
+
 /*
  *	Is the SiS APIC rmw bug present ?
  *	-1 = don't know, 0 = no, 1 = yes
@@ -2267,7 +2269,8 @@ static inline void check_timer(void)
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
 	init_8259A(1);
 	timer_ack = 1;
-	enable_8259A_irq(0);
+	if (timer_over_8254 > 0)	
+		enable_8259A_irq(0);
 
 	pin1  = find_isa_irq_pin(0, mp_INT);
 	apic1 = find_isa_irq_apic(0, mp_INT);
@@ -2392,6 +2395,20 @@ void __init setup_IO_APIC(void)
 		print_IO_APIC();
 }
 
+static int __init setup_disable_8254_timer(char *s)
+{
+	timer_over_8254 = -1;
+	return 1;
+}
+static int __init setup_enable_8254_timer(char *s)
+{
+	timer_over_8254 = 2;
+	return 1;
+}
+
+__setup("disable_8254_timer", setup_disable_8254_timer);
+__setup("enable_8254_timer", setup_enable_8254_timer);
+
 /*
  *	Called after all the initialization is done. If we didnt find any
  *	APIC bugs then we can allow the modify fast path
Index: linux/include/asm-i386/apic.h
===================================================================
--- linux.orig/include/asm-i386/apic.h
+++ linux/include/asm-i386/apic.h
@@ -137,6 +137,8 @@ void switch_APIC_timer_to_ipi(void *cpum
 void switch_ipi_to_APIC_timer(void *cpumask);
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
+extern int timer_over_8254;
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 
Index: linux/Documentation/i386/boot-options.txt
===================================================================
--- /dev/null
+++ linux/Documentation/i386/boot-options.txt
@@ -0,0 +1,8 @@
+
+Some i386 specific boot options
+
+   disable_8254_timer / enable_8254_timer
+                 Enable interrupt 0 timer routing over the 8254 in addition to 
+		 over the IO-APIC. The kernel tries to set a sensible default.
+
+
Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -1111,9 +1111,6 @@ int __init acpi_boot_table_init(void)
 		disable_acpi();
 		return error;
 	}
-#ifdef __i386__
-	check_acpi_pci();
-#endif
 
 	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
 
Index: linux/arch/i386/kernel/setup.c
===================================================================
--- linux.orig/arch/i386/kernel/setup.c
+++ linux/arch/i386/kernel/setup.c
@@ -1599,6 +1599,10 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled)
 		efi_map_memmap();
 
+#ifdef CONFIG_X86_IO_APIC
+	check_acpi_pci();	/* Checks more than just ACPI actually */	
+#endif
+
 #ifdef CONFIG_ACPI
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
