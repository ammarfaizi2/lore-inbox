Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268425AbTBNNF2>; Fri, 14 Feb 2003 08:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTBNNEW>; Fri, 14 Feb 2003 08:04:22 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:25870 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268409AbTBNMxP>;
	Fri, 14 Feb 2003 07:53:15 -0500
Date: Fri, 14 Feb 2003 15:58:28 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: core (9/13)
Message-ID: <20030214125828.GI8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fKov5AqTsvseSZ0Z"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fKov5AqTsvseSZ0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This patch contains core support for visws subarch.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--fKov5AqTsvseSZ0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-core

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/kernel/setup.c linux-2.5.60/arch/i386/kernel/setup.c
--- linux-2.5.60.vanilla/arch/i386/kernel/setup.c	Thu Feb 13 20:29:06 2003
+++ linux-2.5.60/arch/i386/kernel/setup.c	Thu Feb 13 20:42:02 2003
@@ -92,7 +92,6 @@
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 extern int blk_nohighio;
-void __init visws_get_board_type_and_rev(void);
 
 unsigned long saved_videomode;
 
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/mach-visws/Makefile linux-2.5.60/arch/i386/mach-visws/Makefile
--- linux-2.5.60.vanilla/arch/i386/mach-visws/Makefile	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/mach-visws/Makefile	Thu Feb 13 20:42:02 2003
@@ -4,8 +4,7 @@
 
 EXTRA_CFLAGS	+= -I../kernel
 
-obj-y				:= setup.o traps.o
+obj-y				:= setup.o traps.o reboot.o
 
-obj-$(CONFIG_PCI)		+= pci-visws.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/mach-visws/mpparse.c linux-2.5.60/arch/i386/mach-visws/mpparse.c
--- linux-2.5.60.vanilla/arch/i386/mach-visws/mpparse.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/mach-visws/mpparse.c	Thu Feb 13 20:42:02 2003
@@ -1,17 +1,15 @@
-#include <linux/mm.h>
-#include <linux/irq.h>
-#include <linux/init.h>
-#include <linux/delay.h>
+
 #include <linux/config.h>
-#include <linux/bootmem.h>
-#include <linux/smp_lock.h>
-#include <linux/kernel_stat.h>
-#include <linux/mc146818rtc.h>
+#include <linux/init.h>
+#include <linux/smp.h>
 
 #include <asm/smp.h>
-#include <asm/mtrr.h>
+#include <asm/apic.h>
 #include <asm/mpspec.h>
-#include <asm/pgalloc.h>
+#include <asm/io.h>
+
+#include "cobalt.h"
+#include "mach_apic.h"
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -43,25 +41,84 @@
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_physical_apicid = -1U;
 unsigned int boot_cpu_logical_apicid = -1U;
+
 /* Internal processor count */
 static unsigned int num_processors;
 
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
+u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS - 1] = BAD_APICID };
+
 /*
  * The Visual Workstation is Intel MP compliant in the hardware
  * sense, but it doesn't have a BIOS(-configuration table).
  * No problem for Linux.
  */
+
+void __init MP_processor_info (struct mpc_config_processor *m)
+{
+ 	int ver, logical_apicid;
+ 	
+	if (!(m->mpc_cpuflag & CPU_ENABLED))
+		return;
+
+	logical_apicid = m->mpc_apicid;
+	printk(KERN_INFO "%sCPU #%d %ld:%ld APIC version %d\n",
+		m->mpc_cpuflag & CPU_BOOTPROCESSOR ? "Bootup " : "",
+		m->mpc_apicid,
+		(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+		(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+		m->mpc_apicver);
+
+	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
+		boot_cpu_physical_apicid = m->mpc_apicid;
+		boot_cpu_logical_apicid = logical_apicid;
+	}
+
+	num_processors++;
+
+	if (m->mpc_apicid > MAX_APICS) {
+		printk(KERN_ERR "Processor #%d INVALID. (Max ID: %d).\n",
+			m->mpc_apicid, MAX_APICS);
+		--num_processors;
+		return;
+	}
+	ver = m->mpc_apicver;
+
+	phys_cpu_present_map |= apicid_to_cpu_present(m->mpc_apicid);
+	/*
+	 * Validate version
+	 */
+	if (ver == 0x0) {
+		printk(KERN_ERR "BIOS bug, APIC version is 0 for CPU#%d! "
+			"fixing up to 0x10. (tell your hw vendor)\n",
+			m->mpc_apicid);
+		ver = 0x10;
+	}
+	apic_version[m->mpc_apicid] = ver;
+	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
+}
+
 void __init find_smp_config(void)
 {
-	smp_found_config = 1;
+	struct mpc_config_processor *mp = phys_to_virt(CO_CPU_TAB_PHYS);
+	unsigned short ncpus = readw(phys_to_virt(CO_CPU_NUM_PHYS));
+
+	if (ncpus > CO_CPU_MAX) {
+		printk(KERN_WARNING "find_visws_smp: got cpu count of %d at %p\n",
+			ncpus, mp);
 
-	phys_cpu_present_map |= 2; /* or in id 1 */
-	apic_version[1] |= 0x10; /* integrated APIC */
-	apic_version[0] |= 0x10;
+		ncpus = CO_CPU_MAX;
+	}
+
+	smp_found_config = 1;
+	while (ncpus--)
+		MP_processor_info(mp++);
 
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 }
 
+void __init get_smp_config (void)
+{
+}
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/mach-visws/reboot.c linux-2.5.60/arch/i386/mach-visws/reboot.c
--- linux-2.5.60.vanilla/arch/i386/mach-visws/reboot.c	Thu Jan  1 03:00:00 1970
+++ linux-2.5.60/arch/i386/mach-visws/reboot.c	Thu Feb 13 20:42:02 2003
@@ -0,0 +1,48 @@
+
+#include <linux/smp.h>
+#include <linux/delay.h>
+#include <linux/platform.h>
+
+#include <asm/io.h>
+#include "piix4.h"
+
+void (*pm_power_off)(void);
+
+int reboot_thru_bios;
+int reboot_smp;
+
+void machine_restart(char * __unused)
+{
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+
+	/*
+	 * Visual Workstations restart after this
+	 * register is poked on the PIIX4
+	 */
+	outb(PIIX4_RESET_VAL, PIIX4_RESET_PORT);
+}
+
+void machine_power_off(void)
+{
+	unsigned short pm_status;
+	extern unsigned int pci_bus0;
+
+	while ((pm_status = inw(PMSTS_PORT)) & 0x100)
+		outw(pm_status, PMSTS_PORT);
+
+	outw(PM_SUSPEND_ENABLE, PMCNTRL_PORT);
+
+	mdelay(10);
+
+#define PCI_CONF1_ADDRESS(bus, devfn, reg) \
+	(0x80000000 | (bus << 16) | (devfn << 8) | (reg & ~3))
+
+	outl(PCI_CONF1_ADDRESS(pci_bus0, SPECIAL_DEV, SPECIAL_REG), 0xCF8);
+	outl(PIIX_SPECIAL_STOP, 0xCFC);
+}
+
+void machine_halt(void)
+{
+}
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/mach-visws/setup.c linux-2.5.60/arch/i386/mach-visws/setup.c
--- linux-2.5.60.vanilla/arch/i386/mach-visws/setup.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/mach-visws/setup.c	Thu Feb 13 20:42:02 2003
@@ -9,67 +9,26 @@
 #include <linux/interrupt.h>
 
 #include <asm/fixmap.h>
-#include <asm/cobalt.h>
 #include <asm/arch_hooks.h>
 #include <asm/io.h>
+#include "cobalt.h"
+#include "piix4.h"
 
 char visws_board_type = -1;
 char visws_board_rev = -1;
 
-#define	PIIX_PM_START		0x0F80
-
-#define	SIO_GPIO_START		0x0FC0
-
-#define	SIO_PM_START		0x0FC8
-
-#define	PMBASE			PIIX_PM_START
-#define	GPIREG0			(PMBASE+0x30)
-#define	GPIREG(x)		(GPIREG0+((x)/8))
-#define	PIIX_GPI_BD_ID1		18
-#define	PIIX_GPI_BD_REG		GPIREG(PIIX_GPI_BD_ID1)
-
-#define	PIIX_GPI_BD_SHIFT	(PIIX_GPI_BD_ID1 % 8)
-
-#define	SIO_INDEX	0x2e
-#define	SIO_DATA	0x2f
-
-#define	SIO_DEV_SEL	0x7
-#define	SIO_DEV_ENB	0x30
-#define	SIO_DEV_MSB	0x60
-#define	SIO_DEV_LSB	0x61
-
-#define	SIO_GP_DEV	0x7
-
-#define	SIO_GP_BASE	SIO_GPIO_START
-#define	SIO_GP_MSB	(SIO_GP_BASE>>8)
-#define	SIO_GP_LSB	(SIO_GP_BASE&0xff)
-
-#define	SIO_GP_DATA1	(SIO_GP_BASE+0)
-
-#define	SIO_PM_DEV	0x8
-
-#define	SIO_PM_BASE	SIO_PM_START
-#define	SIO_PM_MSB	(SIO_PM_BASE>>8)
-#define	SIO_PM_LSB	(SIO_PM_BASE&0xff)
-#define	SIO_PM_INDEX	(SIO_PM_BASE+0)
-#define	SIO_PM_DATA	(SIO_PM_BASE+1)
-
-#define	SIO_PM_FER2	0x1
-
-#define	SIO_PM_GP_EN	0x80
-
 void __init visws_get_board_type_and_rev(void)
 {
 	int raw;
 
 	visws_board_type = (char)(inb_p(PIIX_GPI_BD_REG) & PIIX_GPI_BD_REG)
 							 >> PIIX_GPI_BD_SHIFT;
-/*
- * Get Board rev.
- * First, we have to initialize the 307 part to allow us access
- * to the GPIO registers.  Let's map them at 0x0fc0 which is right
- * after the PIIX4 PM section.
- */
+	/*
+	 * Get Board rev.
+	 * First, we have to initialize the 307 part to allow us access
+	 * to the GPIO registers.  Let's map them at 0x0fc0 which is right
+	 * after the PIIX4 PM section.
+	 */
 	outb_p(SIO_DEV_SEL, SIO_INDEX);
 	outb_p(SIO_GP_DEV, SIO_DATA);	/* Talk to GPIO regs. */
 
@@ -82,11 +41,11 @@
 	outb_p(SIO_DEV_ENB, SIO_INDEX);
 	outb_p(1, SIO_DATA);		/* Enable GPIO registers. */
 
-/*
- * Now, we have to map the power management section to write
- * a bit which enables access to the GPIO registers.
- * What lunatic came up with this shit?
- */
+	/*
+	 * Now, we have to map the power management section to write
+	 * a bit which enables access to the GPIO registers.
+	 * What lunatic came up with this shit?
+	 */
 	outb_p(SIO_DEV_SEL, SIO_INDEX);
 	outb_p(SIO_PM_DEV, SIO_DATA);	/* Talk to GPIO regs. */
 
@@ -99,18 +58,18 @@
 	outb_p(SIO_DEV_ENB, SIO_INDEX);
 	outb_p(1, SIO_DATA);		/* Enable PM registers. */
 
-/*
- * Now, write the PM register which enables the GPIO registers.
- */
+	/*
+	 * Now, write the PM register which enables the GPIO registers.
+	 */
 	outb_p(SIO_PM_FER2, SIO_PM_INDEX);
 	outb_p(SIO_PM_GP_EN, SIO_PM_DATA);
 
-/*
- * Now, initialize the GPIO registers.
- * We want them all to be inputs which is the
- * power on default, so let's leave them alone.
- * So, let's just read the board rev!
- */
+	/*
+	 * Now, initialize the GPIO registers.
+	 * We want them all to be inputs which is the
+	 * power on default, so let's leave them alone.
+	 * So, let's just read the board rev!
+	 */
 	raw = inb_p(SIO_GP_DATA1);
 	raw &= 0x7f;	/* 7 bits of valid board revision ID. */
 
@@ -128,10 +87,10 @@
 			visws_board_rev = raw;
 		}
 
-	printk(KERN_INFO "Silicon Graphics %s (rev %d)\n",
-	       visws_board_type == VISWS_320 ? "320" :
+	printk(KERN_INFO "Silicon Graphics Visual Workstation %s (rev %d) detected\n",
+	       (visws_board_type == VISWS_320 ? "320" :
 	       (visws_board_type == VISWS_540 ? "540" :
-		"unknown"), visws_board_rev);
+		"unknown")), visws_board_rev);
 }
 
 void __init pre_intr_init_hook(void)
@@ -150,11 +109,16 @@
 {
 	visws_get_board_type_and_rev();
 }
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+
+static struct irqaction irq0 = {
+	.handler =	timer_interrupt,
+	.flags =	SA_INTERRUPT,
+	.name =		"timer",
+};
 
 void __init time_init_hook(void)
 {
-	printk("Starting Cobalt Timer system clock\n");
+	printk(KERN_INFO "Starting Cobalt Timer system clock\n");
 
 	/* Set the countdown value */
 	co_cpu_write(CO_CPU_TIMEVAL, CO_TIME_HZ/HZ);
@@ -166,5 +130,5 @@
 	co_cpu_write(CO_CPU_CTRL, co_cpu_read(CO_CPU_CTRL) & ~CO_CTRL_TIMEMASK);
 
 	/* Wire cpu IDT entry to s/w handler (and Cobalt APIC to IDT) */
-	setup_irq(CO_IRQ_TIMER, &irq0);
+	setup_irq(0, &irq0);
 }
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/mach-visws/traps.c linux-2.5.60/arch/i386/mach-visws/traps.c
--- linux-2.5.60.vanilla/arch/i386/mach-visws/traps.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/mach-visws/traps.c	Thu Feb 13 20:42:02 2003
@@ -3,132 +3,68 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/ptrace.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/highmem.h>
 #include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
 
-#include <asm/system.h>
-#include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/atomic.h>
-#include <asm/debugreg.h>
-#include <asm/desc.h>
-#include <asm/i387.h>
-
-#include <asm/smp.h>
 #include <asm/pgalloc.h>
 #include <asm/arch_hooks.h>
+#include <asm/apic.h>
+#include "cobalt.h"
+#include "lithium.h"
 
-#ifdef CONFIG_X86_VISWS_APIC
-#include <asm/fixmap.h>
-#include <asm/cobalt.h>
-#include <asm/lithium.h>
-#endif
-
-#ifdef CONFIG_X86_VISWS_APIC
-
-/*
- * On Rev 005 motherboards legacy device interrupt lines are wired directly
- * to Lithium from the 307.  But the PROM leaves the interrupt type of each
- * 307 logical device set appropriate for the 8259.  Later we'll actually use
- * the 8259, but for now we have to flip the interrupt types to
- * level triggered, active lo as required by Lithium.
- */
-
-#define	REG	0x2e	/* The register to read/write */
-#define	DEV	0x07	/* Register: Logical device select */
-#define	VAL	0x2f	/* The value to read/write */
 
-static void
-superio_outb(int dev, int reg, int val)
-{
-	outb(DEV, REG);
-	outb(dev, VAL);
-	outb(reg, REG);
-	outb(val, VAL);
-}
+#define A01234 (LI_INTA_0 | LI_INTA_1 | LI_INTA_2 | LI_INTA_3 | LI_INTA_4)
+#define BCD (LI_INTB | LI_INTC | LI_INTD)
+#define ALLDEVS (A01234 | BCD)
 
-static int __attribute__ ((unused))
-superio_inb(int dev, int reg)
+static __init void lithium_init(void)
 {
-	outb(DEV, REG);
-	outb(dev, VAL);
-	outb(reg, REG);
-	return inb(VAL);
-}
-
-#define	FLOP	3	/* floppy logical device */
-#define	PPORT	4	/* parallel logical device */
-#define	UART5	5	/* uart2 logical device (not wired up) */
-#define	UART6	6	/* uart1 logical device (THIS is the serial port!) */
-#define	IDEST	0x70	/* int. destination (which 307 IRQ line) reg. */
-#define	ITYPE	0x71	/* interrupt type register */
-
-/* interrupt type bits */
-#define	LEVEL	0x01	/* bit 0, 0 == edge triggered */
-#define	ACTHI	0x02	/* bit 1, 0 == active lo */
+	set_fixmap(FIX_LI_PCIA, LI_PCI_A_PHYS);
+	set_fixmap(FIX_LI_PCIB, LI_PCI_B_PHYS);
 
-static __init void
-superio_init(void)
-{
-	if (visws_board_type == VISWS_320 && visws_board_rev == 5) {
-		superio_outb(UART6, IDEST, 0);	/* 0 means no intr propagated */
-		printk("SGI 320 rev 5: disabling 307 uart1 interrupt\n");
+	if ((li_pcia_read16(PCI_VENDOR_ID) != PCI_VENDOR_ID_SGI) ||
+	    (li_pcia_read16(PCI_DEVICE_ID) != PCI_VENDOR_ID_SGI_LITHIUM)) {
+		printk(KERN_EMERG "Lithium hostbridge %c not found\n", 'A');
+		panic("This machine is not SGI Visual Workstation 320/540");
 	}
-}
 
-static __init void
-lithium_init(void)
-{
-	set_fixmap(FIX_LI_PCIA, LI_PCI_A_PHYS);
-	printk("Lithium PCI Bridge A, Bus Number: %d\n",
-				li_pcia_read16(LI_PCI_BUSNUM) & 0xff);
-	set_fixmap(FIX_LI_PCIB, LI_PCI_B_PHYS);
-	printk("Lithium PCI Bridge B (PIIX4), Bus Number: %d\n",
-				li_pcib_read16(LI_PCI_BUSNUM) & 0xff);
+	if ((li_pcib_read16(PCI_VENDOR_ID) != PCI_VENDOR_ID_SGI) ||
+	    (li_pcib_read16(PCI_DEVICE_ID) != PCI_VENDOR_ID_SGI_LITHIUM)) {
+		printk(KERN_EMERG "Lithium hostbridge %c not found\n", 'B');
+		panic("This machine is not SGI Visual Workstation 320/540");
+	}
 
-	/* XXX blindly enables all interrupts */
-	li_pcia_write16(LI_PCI_INTEN, 0xffff);
-	li_pcib_write16(LI_PCI_INTEN, 0xffff);
+	li_pcia_write16(LI_PCI_INTEN, ALLDEVS);
+	li_pcib_write16(LI_PCI_INTEN, ALLDEVS);
 }
 
-static __init void
-cobalt_init(void)
+static __init void cobalt_init(void)
 {
 	/*
 	 * On normal SMP PC this is used only with SMP, but we have to
 	 * use it and set it up here to start the Cobalt clock
 	 */
 	set_fixmap(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);
-	printk("Local APIC ID %lx\n", apic_read(APIC_ID));
-	printk("Local APIC Version %lx\n", apic_read(APIC_LVR));
+	setup_local_APIC();
+	printk(KERN_INFO "Local APIC Version %#lx, ID %#lx\n",
+		apic_read(APIC_LVR), apic_read(APIC_ID));
 
 	set_fixmap(FIX_CO_CPU, CO_CPU_PHYS);
-	printk("Cobalt Revision %lx\n", co_cpu_read(CO_CPU_REV));
-
 	set_fixmap(FIX_CO_APIC, CO_APIC_PHYS);
-	printk("Cobalt APIC ID %lx\n", co_apic_read(CO_APIC_ID));
+	printk(KERN_INFO "Cobalt Revision %#lx, APIC ID %#lx\n",
+		co_cpu_read(CO_CPU_REV), co_apic_read(CO_APIC_ID));
 
 	/* Enable Cobalt APIC being careful to NOT change the ID! */
-	co_apic_write(CO_APIC_ID, co_apic_read(CO_APIC_ID)|CO_APIC_ENABLE);
+	co_apic_write(CO_APIC_ID, co_apic_read(CO_APIC_ID) | CO_APIC_ENABLE);
 
-	printk("Cobalt APIC enabled: ID reg %lx\n", co_apic_read(CO_APIC_ID));
+	printk(KERN_INFO "Cobalt APIC enabled: ID reg %#lx\n",
+		co_apic_read(CO_APIC_ID));
 }
-#endif
 
-void __init trap_init_hook()
+void __init trap_init_hook(void)
 {
-#ifdef CONFIG_X86_VISWS_APIC
-	superio_init();
 	lithium_init();
 	cobalt_init();
-#endif
 }
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/mach-visws/visws_apic.c linux-2.5.60/arch/i386/mach-visws/visws_apic.c
--- linux-2.5.60.vanilla/arch/i386/mach-visws/visws_apic.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/mach-visws/visws_apic.c	Thu Feb 13 20:42:02 2003
@@ -1,5 +1,5 @@
 /*
- *	linux/arch/i386/kernel/visws_apic.c
+ *	linux/arch/i386/mach_visws/visws_apic.c
  *
  *	Copyright (C) 1999 Bent Hagemark, Ingo Molnar
  *
@@ -10,234 +10,180 @@
  *  hardware in the system uses this controller directly.  Legacy devices
  *  are connected to the PIIX4 which in turn has its 8259(s) connected to
  *  a of the Cobalt APIC entry.
+ *
+ *  09/02/2000 - Updated for 2.4 by jbarnes@sgi.com
+ *
+ *  25/11/2002 - Updated for 2.5 by Andrey Panin <pazke@orbita1.ru>
  */
 
-#include <linux/ptrace.h>
-#include <linux/errno.h>
+#include <linux/config.h>
 #include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/smp.h>
+#include <linux/irq.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 
-#include <asm/system.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/bitops.h>
-#include <asm/smp.h>
-#include <asm/pgtable.h>
-#include <asm/delay.h>
-#include <asm/desc.h>
-
-#include <asm/cobalt.h>
-
-#include <linux/irq.h>
-
-/*
- * This is the PIIX4-based 8259 that is wired up indirectly to Cobalt
- * -- not the manner expected by the normal 8259 code in irq.c.
- *
- * there is a 'master' physical interrupt source that gets sent to
- * the CPU. But in the chipset there are various 'virtual' interrupts
- * waiting to be handled. We represent this to Linux through a 'master'
- * interrupt controller type, and through a special virtual interrupt-
- * controller. Device drivers only see the virtual interrupt sources.
- */
-
-#define	CO_IRQ_BASE	0x20	/* This is the 0x20 in init_IRQ()! */
-
-static void startup_piix4_master_irq(unsigned int irq);
-static void shutdown_piix4_master_irq(unsigned int irq);
-static void do_piix4_master_IRQ(unsigned int irq, struct pt_regs * regs);
-#define enable_piix4_master_irq startup_piix4_master_irq
-#define disable_piix4_master_irq shutdown_piix4_master_irq
+#include <asm/apic.h>
+#include <asm/i8259.h>
 
-static struct hw_interrupt_type piix4_master_irq_type = {
-	"PIIX4-master",
-	startup_piix4_master_irq,
-	shutdown_piix4_master_irq,
-	do_piix4_master_IRQ,
-	enable_piix4_master_irq,
-	disable_piix4_master_irq
-};
-
-static void enable_piix4_virtual_irq(unsigned int irq);
-static void disable_piix4_virtual_irq(unsigned int irq);
-#define startup_piix4_virtual_irq enable_piix4_virtual_irq
-#define shutdown_piix4_virtual_irq disable_piix4_virtual_irq
-
-static struct hw_interrupt_type piix4_virtual_irq_type = {
-	"PIIX4-virtual",
-	startup_piix4_virtual_irq,
-	shutdown_piix4_virtual_irq,
-	0, /* no handler, it's never called physically */
-	enable_piix4_virtual_irq,
-	disable_piix4_virtual_irq
-};
-
-/*
- * This is the SGI Cobalt (IO-)APIC:
- */
+#include "cobalt.h"
+#include "irq_vectors.h"
 
-static void do_cobalt_IRQ(unsigned int irq, struct pt_regs * regs);
-static void enable_cobalt_irq(unsigned int irq);
-static void disable_cobalt_irq(unsigned int irq);
-static void startup_cobalt_irq(unsigned int irq);
-#define shutdown_cobalt_irq disable_cobalt_irq
 
-static spinlock_t irq_controller_lock = SPIN_LOCK_UNLOCKED;
+int irq_vector[NR_IRQS] = { FIRST_EXTERNAL_VECTOR, 0 };
 
-static struct hw_interrupt_type cobalt_irq_type = {
-	"Cobalt-APIC",
-	startup_cobalt_irq,
-	shutdown_cobalt_irq,
-	do_cobalt_IRQ,
-	enable_cobalt_irq,
-	disable_cobalt_irq
-};
 
+static spinlock_t cobalt_lock = SPIN_LOCK_UNLOCKED;
 
 /*
- * Not an __init, needed by the reboot code
+ * Set the given Cobalt APIC Redirection Table entry to point
+ * to the given IDT vector/index.
  */
-void disable_IO_APIC(void)
+static inline void co_apic_set(int entry, int irq)
 {
-	/* Nop on Cobalt */
-} 
+	co_apic_write(CO_APIC_LO(entry), CO_APIC_LEVEL | irq_vector[irq]);
+	co_apic_write(CO_APIC_HI(entry), 0);
+}
 
 /*
  * Cobalt (IO)-APIC functions to handle PCI devices.
  */
-
-static void disable_cobalt_irq(unsigned int irq)
+static inline int co_apic_ide0_hack(void)
 {
-	/* XXX undo the APIC entry here? */
+	extern char visws_board_type;
+	extern char visws_board_rev;
 
-	/*
-	 * definitely, we do not want to have IRQ storms from
-	 * unused devices --mingo
-	 */
+	if (visws_board_type == VISWS_320 && visws_board_rev == 5)
+		return 5;
+	return CO_APIC_IDE0;
 }
 
-static void enable_cobalt_irq(unsigned int irq)
+static int is_co_apic(unsigned int irq)
 {
+	if (IS_CO_APIC(irq))
+		return CO_APIC(irq);
+
+	switch (irq) {
+		case 0: return CO_APIC_CPU;
+		case CO_IRQ_IDE0: return co_apic_ide0_hack();
+		case CO_IRQ_IDE1: return CO_APIC_IDE1;
+		default: return -1;
+	}
 }
 
+
 /*
- * Set the given Cobalt APIC Redirection Table entry to point
- * to the given IDT vector/index.
+ * This is the SGI Cobalt (IO-)APIC:
  */
-static void co_apic_set(int entry, int idtvec)
+
+static void enable_cobalt_irq(unsigned int irq)
 {
-	co_apic_write(CO_APIC_LO(entry), CO_APIC_LEVEL | (CO_IRQ_BASE+idtvec));
-	co_apic_write(CO_APIC_HI(entry), 0);
+	co_apic_set(is_co_apic(irq), irq);
+}
 
-	printk("Cobalt APIC Entry %d IDT Vector %d\n", entry, idtvec);
+static void disable_cobalt_irq(unsigned int irq)
+{
+	int entry = is_co_apic(irq);
+
+	co_apic_write(CO_APIC_LO(entry), CO_APIC_MASK);
+	co_apic_read(CO_APIC_LO(entry));
 }
 
 /*
  * "irq" really just serves to identify the device.  Here is where we
  * map this to the Cobalt APIC entry where it's physically wired.
- * This is called via request_irq -> setup_x86_irq -> irq_desc->startup()
+ * This is called via request_irq -> setup_irq -> irq_desc->startup()
  */
-static void startup_cobalt_irq(unsigned int irq)
+static unsigned int startup_cobalt_irq(unsigned int irq)
 {
-	/*
-	 * These "irq"'s are wired to the same Cobalt APIC entries
-	 * for all (known) motherboard types/revs
-	 */
-	switch (irq) {
-	case CO_IRQ_TIMER:	co_apic_set(CO_APIC_CPU, CO_IRQ_TIMER);
-				return;
+	unsigned long flags;
 
-	case CO_IRQ_ENET:	co_apic_set(CO_APIC_ENET, CO_IRQ_ENET);
-				return;
+	spin_lock_irqsave(&cobalt_lock, flags);
+	if ((irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS | IRQ_WAITING)))
+		irq_desc[irq].status &= ~(IRQ_DISABLED | IRQ_INPROGRESS | IRQ_WAITING);
+	enable_cobalt_irq(irq);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
+	return 0;
+}
 
-	case CO_IRQ_SERIAL:	return; /* XXX move to piix4-8259 "virtual" */
+static void ack_cobalt_irq(unsigned int irq)
+{
+	unsigned long flags;
 
-	case CO_IRQ_8259:	co_apic_set(CO_APIC_8259, CO_IRQ_8259);
-				return;
-
-	case CO_IRQ_IDE:
-		switch (visws_board_type) {
-		case VISWS_320:
-			switch (visws_board_rev) {
-			case 5:
-				co_apic_set(CO_APIC_0_5_IDE0, CO_IRQ_IDE);
-				co_apic_set(CO_APIC_0_5_IDE1, CO_IRQ_IDE);
-					return;
-			case 6:
-				co_apic_set(CO_APIC_0_6_IDE0, CO_IRQ_IDE);
-				co_apic_set(CO_APIC_0_6_IDE1, CO_IRQ_IDE);
-					return;
-			}
-		case VISWS_540:
-			switch (visws_board_rev) {
-			case 2:
-				co_apic_set(CO_APIC_1_2_IDE0, CO_IRQ_IDE);
-					return;
-			}
-		}
-		break;
-	default:
-		panic("huh?");
-	}
+	spin_lock_irqsave(&cobalt_lock, flags);
+	disable_cobalt_irq(irq);
+	apic_write(APIC_EOI, APIC_EIO_ACK);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
 
+static void end_cobalt_irq(unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cobalt_lock, flags);
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		enable_cobalt_irq(irq);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
+}
+
+static struct hw_interrupt_type cobalt_irq_type = {
+	.typename =	"Cobalt-APIC",
+	.startup =	startup_cobalt_irq,
+	.shutdown =	disable_cobalt_irq,
+	.enable =	enable_cobalt_irq,
+	.disable =	disable_cobalt_irq,
+	.ack =		ack_cobalt_irq,
+	.end =		end_cobalt_irq,
+};
+
+
 /*
- * This is the handle() op in do_IRQ()
+ * This is the PIIX4-based 8259 that is wired up indirectly to Cobalt
+ * -- not the manner expected by the code in i8259.c.
+ *
+ * there is a 'master' physical interrupt source that gets sent to
+ * the CPU. But in the chipset there are various 'virtual' interrupts
+ * waiting to be handled. We represent this to Linux through a 'master'
+ * interrupt controller type, and through a special virtual interrupt-
+ * controller. Device drivers only see the virtual interrupt sources.
  */
-static void do_cobalt_IRQ(unsigned int irq, struct pt_regs * regs)
+static unsigned int startup_piix4_master_irq(unsigned int irq)
 {
-	struct irqaction * action;
-	irq_desc_t *desc = irq_desc + irq;
+	init_8259A(0);
 
-	spin_lock(&irq_controller_lock);
-	{
-		unsigned int status;
-		/* XXX APIC EOI? */
-		status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-		action = NULL;
-		if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-			action = desc->action;
-			status |= IRQ_INPROGRESS;
-		}
-		desc->status = status;
-	}
-	spin_unlock(&irq_controller_lock);
+	return startup_cobalt_irq(irq);
+}
 
-	/* Exit early if we had no action or it was disabled */
-	if (!action)
-		return;
-
-	handle_IRQ_event(irq, regs, action);
-
-	(void)co_cpu_read(CO_CPU_REV); /* Sync driver ack to its h/w */
-	apic_write(APIC_EOI, APIC_EIO_ACK); /* Send EOI to Cobalt APIC */
-
-	spin_lock(&irq_controller_lock);
-	{
-		unsigned int status = desc->status & ~IRQ_INPROGRESS;
-		desc->status = status;
-		if (!(status & IRQ_DISABLED))
-			enable_cobalt_irq(irq);
-	}
-	spin_unlock(&irq_controller_lock);
+static void end_piix4_master_irq(unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cobalt_lock, flags);
+	enable_cobalt_irq(irq);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
 
+static struct hw_interrupt_type piix4_master_irq_type = {
+	.typename =	"PIIX4-master",
+	.startup =	startup_piix4_master_irq,
+	.ack =		ack_cobalt_irq,
+	.end =		end_piix4_master_irq,
+};
+
+
+static struct hw_interrupt_type piix4_virtual_irq_type = {
+	.typename =	"PIIX4-virtual",
+	.startup =	startup_8259A_irq,
+	.shutdown =	disable_8259A_irq,
+	.enable =	enable_8259A_irq,
+	.disable =	disable_8259A_irq,
+};
+
+
 /*
- * PIIX4-8259 master/virtual functions to handle:
- *
- *	floppy
- *	parallel
- *	serial
- *	audio (?)
+ * PIIX4-8259 master/virtual functions to handle interrupt requests
+ * from legacy devices: floppy, parallel, serial, rtc.
  *
  * None of these get Cobalt APIC entries, neither do they have IDT
  * entries. These interrupts are purely virtual and distributed from
@@ -250,161 +196,112 @@
  * enable_irq gets the right irq. This 'master' irq is never directly
  * manipulated by any driver.
  */
-
-static void startup_piix4_master_irq(unsigned int irq)
+static void piix4_master_intr(int irq, void *dev_id, struct pt_regs * regs)
 {
-	/* ICW1 */
-	outb(0x11, 0x20);
-	outb(0x11, 0xa0);
+	int realirq;
+	irq_desc_t *desc;
+	unsigned long flags;
 
-	/* ICW2 */
-	outb(0x08, 0x21);
-	outb(0x70, 0xa1);
+	spin_lock_irqsave(&i8259A_lock, flags);
 
-	/* ICW3 */
-	outb(0x04, 0x21);
-	outb(0x02, 0xa1);
-
-	/* ICW4 */
-	outb(0x01, 0x21);
-	outb(0x01, 0xa1);
-
-	/* OCW1 - disable all interrupts in both 8259's */
-	outb(0xff, 0x21);
-	outb(0xff, 0xa1);
-
-	startup_cobalt_irq(irq);
-}
+	/* Find out what's interrupting in the PIIX4 master 8259 */
+	outb(0x0c, 0x20);		/* OCW3 Poll command */
+	realirq = inb(0x20);
 
-static void shutdown_piix4_master_irq(unsigned int irq)
-{
 	/*
-	 * [we skip the 8259 magic here, not strictly necessary]
+	 * Bit 7 == 0 means invalid/spurious
 	 */
+	if (unlikely(!(realirq & 0x80)))
+		goto out_unlock;
 
-	shutdown_cobalt_irq(irq);
-}
-
-static void do_piix4_master_IRQ(unsigned int irq, struct pt_regs * regs)
-{
-	int realirq, mask;
+	realirq &= 7;
 
-	/* Find out what's interrupting in the PIIX4 8259 */
+	if (unlikely(realirq == 2)) {
+		outb(0x0c, 0xa0);
+		realirq = inb(0xa0);
 
-	spin_lock(&irq_controller_lock);
-	outb(0x0c, 0x20);		/* OCW3 Poll command */
-	realirq = inb(0x20);
+		if (unlikely(!(realirq & 0x80)))
+			goto out_unlock;
 
-	if (!(realirq & 0x80)) {
-		/*
-		 * Bit 7 == 0 means invalid/spurious
-		 */
-		goto out_unlock;
+		realirq = (realirq & 7) + 8;
 	}
-	realirq &= 0x7f;
 
-	/*
-	 * mask and ack the 8259
-	 */
-	mask = inb(0x21);
-	if ((mask >> realirq) & 0x01)
-		/*
-		 * This IRQ is masked... ignore
-		 */
-		goto out_unlock;
+	/* mask and ack interrupt */
+	cached_irq_mask |= 1 << realirq;
+	if (unlikely(realirq > 7)) {
+		inb(0xa1);
+		outb(cached_A1, 0xa1);
+		outb(0x60 + (realirq & 7), 0xa0);
+		outb(0x60 + 2, 0x20);
+	} else {
+		inb(0x21);
+		outb(cached_21, 0x21);
+		outb(0x60 + realirq, 0x20);
+	}
 
-	outb(mask | (1<<realirq), 0x21);
-	/*
-	 * OCW2 - non-specific EOI
-	 */
-	outb(0x20, 0x20);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 
-	spin_unlock(&irq_controller_lock);
+	desc = irq_desc + realirq;
 
 	/*
 	 * handle this 'virtual interrupt' as a Cobalt one now.
 	 */
-	kstat_cpu(smp_processor_id()).irqs[irq]++;
-	do_cobalt_IRQ(realirq, regs);
+	kstat_cpu(smp_processor_id()).irqs[realirq]++;
 
-	spin_lock(&irq_controller_lock);
-	{
-		irq_desc_t *desc = irq_desc + realirq;
+	if (likely(desc->action != NULL))
+		handle_IRQ_event(realirq, regs, desc->action);
+
+	if (!(desc->status & IRQ_DISABLED))
+		enable_8259A_irq(realirq);
 
-		if (!(desc->status & IRQ_DISABLED))
-			enable_piix4_virtual_irq(realirq);
-	}
-	spin_unlock(&irq_controller_lock);
 	return;
 
 out_unlock:
-	spin_unlock(&irq_controller_lock);
+	spin_unlock_irqrestore(&i8259A_lock, flags);
 	return;
 }
 
-static void enable_piix4_virtual_irq(unsigned int irq)
-{
-	/*
-	 * assumes this irq is one of the legacy devices
-	 */
-
-	unsigned int mask = inb(0x21);
- 	mask &= ~(1 << irq);
-	outb(mask, 0x21);
-	enable_cobalt_irq(irq);
-}
-
-/*
- * assumes this irq is one of the legacy devices
- */
-static void disable_piix4_virtual_irq(unsigned int irq)
-{
-	unsigned int mask;
-
-	disable_cobalt_irq(irq);
+static struct irqaction master_action = {
+	.handler =	piix4_master_intr,
+	.name =		"PIIX4-8259",
+};
 
-	mask = inb(0x21);
- 	mask &= ~(1 << irq);
-	outb(mask, 0x21);
-}
+static struct irqaction cascade_action = {
+	.handler = 	no_action,
+	.name =		"cascade",
+};
 
-static struct irqaction master_action =
-		{ no_action, 0, 0, "PIIX4-8259", NULL, NULL };
 
 void init_VISWS_APIC_irqs(void)
 {
 	int i;
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < CO_IRQ_APIC0 + CO_APIC_LAST + 1; i++) {
 		irq_desc[i].status = IRQ_DISABLED;
 		irq_desc[i].action = 0;
 		irq_desc[i].depth = 1;
 
-		/*
-		 * Cobalt IRQs are mapped to standard ISA
-		 * interrupt vectors:
-		 */
-		switch (i) {
-			/*
-			 * Only CO_IRQ_8259 will be raised
-			 * externally.
-			 */
-		case CO_IRQ_8259:
+		if (i == 0) {
+			irq_desc[i].handler = &cobalt_irq_type;
+		}
+		else if (i == CO_IRQ_IDE0) {
+			irq_desc[i].handler = &cobalt_irq_type;
+		}
+		else if (i == CO_IRQ_IDE1) {
+			irq_desc[i].handler = &cobalt_irq_type;
+		}
+		else if (i == CO_IRQ_8259) {
 			irq_desc[i].handler = &piix4_master_irq_type;
-			break;
-		case CO_IRQ_FLOPPY:
-		case CO_IRQ_PARLL:
+		}
+		else if (i < CO_IRQ_APIC0) {
 			irq_desc[i].handler = &piix4_virtual_irq_type;
-			break;
-		default:
+		}
+		else if (IS_CO_APIC(i)) {
 			irq_desc[i].handler = &cobalt_irq_type;
-			break;
 		}
+		irq_vector[i] = i + FIRST_EXTERNAL_VECTOR;
 	}
 
-	/*
-	 * The master interrupt is always present:
-	 */
-	setup_x86_irq(CO_IRQ_8259, &master_action);
+	setup_irq(CO_IRQ_8259, &master_action);
+	setup_irq(2, &cascade_action);
 }
-
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/mach-visws/irq_vectors.h linux-2.5.60/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.5.60.vanilla/include/asm-i386/mach-visws/irq_vectors.h	Thu Feb 13 20:31:38 2003
+++ linux-2.5.60/include/asm-i386/mach-visws/irq_vectors.h	Thu Feb 13 20:58:11 2003
@@ -47,18 +47,8 @@
 #define TIMER_IRQ 0
 
 /*
- * 16 8259A IRQ's, 208 potential APIC interrupt sources.
- * Right now the APIC is mostly only used for SMP.
- * 256 vectors is an architectural limit. (we can have
- * more than 256 devices theoretically, but they will
- * have to use shared interrupts)
- * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
+ * 
  */
-#ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
-#else
-#define NR_IRQS 16
-#endif
 
 #endif /* _ASM_IRQ_VECTORS_H */
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/mach-visws/setup_arch_post.h linux-2.5.60/include/asm-i386/mach-visws/setup_arch_post.h
--- linux-2.5.60.vanilla/include/asm-i386/mach-visws/setup_arch_post.h	Thu Feb 13 20:31:38 2003
+++ linux-2.5.60/include/asm-i386/mach-visws/setup_arch_post.h	Thu Feb 13 20:42:02 2003
@@ -3,35 +3,47 @@
  * This is included late in kernel/setup.c so that it can make use of all of
  * the static functions. */
 
+#define MB (1024 * 1024)
+
+unsigned long sgivwfb_mem_phys;
+unsigned long sgivwfb_mem_size;
+
+long long mem_size __initdata = 0;
+
 static inline char * __init machine_specific_memory_setup(void)
 {
-	char *who;
+	long long gfx_mem_size = 8 * MB;
 
+	mem_size = ALT_MEM_K;
 
-	who = "BIOS-e820";
+	if (!mem_size) {
+		printk(KERN_WARNING "Bootloader didn't set memory size, upgrade it !\n");
+		mem_size = 128 * MB;
+	}
 
 	/*
-	 * Try to copy the BIOS-supplied E820-map.
-	 *
-	 * Otherwise fake a memory map; one section from 0k->640k,
-	 * the next section from 1mb->appropriate_mem_k
+	 * this hardcodes the graphics memory to 8 MB
+	 * it really should be sized dynamically (or at least
+	 * set as a boot param)
 	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
-		unsigned long mem_size;
-
-		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
-			who = "BIOS-88";
-		} else {
-			mem_size = ALT_MEM_K;
-			who = "BIOS-e801";
-		}
-
-		e820.nr_map = 0;
-		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
-  	}
-	return who;
+	if (!sgivwfb_mem_size) {
+		printk(KERN_WARNING "Defaulting to 8 MB framebuffer size\n");
+		sgivwfb_mem_size = 8 * MB;
+	}
+
+	/*
+	 * Trim to nearest MB
+	 */
+	sgivwfb_mem_size &= ~((1 << 20) - 1);
+	sgivwfb_mem_phys = mem_size - gfx_mem_size;
+
+	add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+	add_memory_region(HIGH_MEMORY, mem_size - sgivwfb_mem_size - HIGH_MEMORY, E820_RAM);
+	add_memory_region(sgivwfb_mem_phys, sgivwfb_mem_size, E820_RESERVED);
+
+	return "PROM";
+
+	/* Remove gcc warnings */
+	(void) sanitize_e820_map(NULL, NULL);
+	(void) copy_e820_map(NULL, 0);
 }
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/mach-visws/do_timer.h linux-2.5.60/include/asm-i386/mach-visws/do_timer.h
--- linux-2.5.60.vanilla/include/asm-i386/mach-visws/do_timer.h	Thu Feb 13 20:31:38 2003
+++ linux-2.5.60/include/asm-i386/mach-visws/do_timer.h	Thu Feb 13 20:42:02 2003
@@ -1,7 +1,7 @@
 /* defines for inline arch setup functions */
 
 #include <asm/fixmap.h>
-#include <asm/cobalt.h>
+#include "cobalt.h"
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {

--fKov5AqTsvseSZ0Z--
