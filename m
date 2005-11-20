Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVKTPus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVKTPus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKTPus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:50:48 -0500
Received: from 58x158x20x104.ap58.ftth.ucom.ne.jp ([58.158.20.104]:3505 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751261AbVKTPur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:50:47 -0500
Subject: kdump's dump capture kernel fails (APICs & linux-2.6.15-rc1)
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, lace@valinux.co.jp,
       akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-b0j/IMNu+WATf8g87L58"
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A?= =?UTF-8?Q?=E7=A4=BE?=
Date: Mon, 21 Nov 2005 00:46:34 +0900
Message-Id: <1132501594.2432.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b0j/IMNu+WATf8g87L58
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

It seems there are still some problems with the initialization of the
APICs in the second kernel. As you can see from the serial line captures
below, early during the boot process the kernel is flooded with
"unexpected IRQ trap at vector ##" errors and fails to boot.

Some basic details about the machine:
 - Dual Xeon Hyper-Threading 2.4GHz=20
 - 1GB RAM

In this particular machine the problem could be solved by reintroducing
the APICs shutdown patch. The drawback with this approach is that
LAPIC/IOAPIC registers setup for the legacy PIC mode differs a lot
between mother boards and the somewhat hackish shutdown code fails to
set the APICs properly under certain configurations.

In "mkdump" we take a different method that solves these problems: save
the original state of the APICs (i.e. as configured by the BIOS) before
they are reconfigured by the kernel, and restore the APICs to that
original state before kexecing the second kernel.

I feel this is the safest (and most paranoid) solution. But, of course,
I concede that it would be preferable to avoid touching the APICs in the
reboot patch to the second kernel if possible. I hope we can get the
"moving apic init in init_IRQs" patches to work reliably.

The APICs save/restore approach was originally proposed by Jan
Kratochvil in the Fastboot mailing list:

http://lists.osdl.org/pipermail/fastboot/2005-May/001383.html

I have prepared "LAPIC/IO-APIC save/restore" patches against
"linux-2.6.15-rc1" (attached).

I would appreciate comments on this problematic regarding the APICs.

Regards,

Fernando




******** WITH ACPI ENABLED

# kexec -p linux-2.6.15-rc1-cptr/vmlinux --args-linux
--append=3D"root=3D/dev/sda1 init 1 irqpoll console=3DttyS0,38400
console=3Dtty0"
# SysRq : Trigger a crashdump
Linux version 2.6.15-rc1-cptr (fewy@nexus) (gcc version 4.0.3 20051023
(prerelease) (Debian 4.0.2-3)) #1 PREEMPT Thu Nov 17 11:19:24 JST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 000000000128a000 (usable)
 user: 000000000132a400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
found SMP MP-table at 000f5750
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10000000 (gap: 05000000:fb000000)
Built 1 zonelists
Kernel command line: root=3D/dev/sda1 init 1 irqpoll console=3DttyS0,38400
console=3Dtty0 memmap=3Dexactmap memmap=3D640K@0K memmap=3D2600K@16384K
memmap=3D62295K@19625K elfcorehdr=3D19624K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc124e000 soft=3Dc124d000
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 2405.933 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
unexpected IRQ trap at vector 89
unexpected IRQ trap at vector 29
unexpected IRQ trap at vector 89
unexpected IRQ trap at vector 19
.....................


******** WITH ACPI DISABLED

# kexec -p linux-2.6.15-rc1-cptr/vmlinux --args-linux
--append=3D"root=3D/dev/sda1 init 1 irqpoll console=3DttyS0,38400
console=3Dtty0"
# SysRq : Trigger a crashdump
Linux version 2.6.15-rc1-cptr (fewy@nexus) (gcc version 4.0.3 20051023
(prerelease) (Debian 4.0.2-3)) #1 Thu Nov 17 15:46:25 JST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 000000000123c000 (usable)
 user: 00000000012dc400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
found SMP MP-table at 000f5750
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 15:2 APIC version 17
Processor #6 15:2 APIC version 17
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
I/O APIC #4 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 10000000 (gap: 05000000:fb000000)
Built 1 zonelists
Kernel command line: root=3D/dev/sda1 init 1 irqpoll console=3DttyS0,38400
console=3Dtty0 memmap=3Dexactmap memmap=3D640K@0K memmap=3D2288K@16384K
memmap=3D62607K@19313K elfcorehdr=3D19312K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 2405.819 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
unexpected IRQ trap at vector 89
unexpected IRQ trap at vector 29
unexpected IRQ trap at vector 89
.....................

--=20
Fernando Luis V=C3=A1zquez Cao @ NTT Data Intellilink

--=-b0j/IMNu+WATf8g87L58
Content-Disposition: attachment; filename=linux-2.6.15-rc1-apics_restore-crash-i386.patch
Content-Type: text/x-patch; name=linux-2.6.15-rc1-apics_restore-crash-i386.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.15-rc1/arch/i386/kernel/crash.c linux-2.6.15-rc1-rstr/arch/i386/kernel/crash.c
--- linux-2.6.15-rc1/arch/i386/kernel/crash.c	2005-11-18 01:16:04.000000000 +0900
+++ linux-2.6.15-rc1-rstr/arch/i386/kernel/crash.c	2005-11-18 01:19:44.000000000 +0900
@@ -22,7 +22,8 @@
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
 #include <mach_ipi.h>
-
+#include <asm/apic.h>
+#include <asm/io_apic.h>
 
 note_buf_t crash_notes[NR_CPUS];
 /* This keeps a track of which one is crashing cpu. */
@@ -127,6 +128,39 @@ static void crash_save_self(struct pt_re
 	crash_save_this_cpu(&regs, cpu);
 }
 
+#ifdef CONFIG_X86_IO_APIC
+static void ioapic_kexec_restore_once(void)
+{
+	static int tried[NR_CPUS];
+	int cpu = smp_processor_id();
+
+	/* We may crash inside: ioapic_kexec_restore() */
+	if (tried[cpu])
+		return;
+	tried[cpu] = 1;
+
+	ioapic_kexec_restore();		/* errors ignored */
+}
+#endif
+
+#ifdef CONFIG_X86_LOCAL_APIC
+void lapic_kexec_restore_once(void)
+{
+	static int tried[NR_CPUS];
+	int cpu = smp_processor_id();
+
+	if (!cpu_has_apic)
+		return;
+
+	/* We may crash inside: lapic_kexec_restore() */
+	if (tried[cpu])
+		return;
+	tried[cpu] = 1;
+
+	lapic_kexec_restore(); /* errors ignored */
+}
+#endif
+
 #ifdef CONFIG_SMP
 static atomic_t waiting_for_crash_ipi;
 
@@ -147,6 +181,9 @@ static int crash_nmi_callback(struct pt_
 		regs = &fixed_regs;
 	}
 	crash_save_this_cpu(regs, cpu);
+#if defined(CONFIG_X86_LOCAL_APIC)
+	lapic_kexec_restore_once();
+#endif
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	halt();
@@ -210,5 +247,11 @@ void machine_crash_shutdown(struct pt_re
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
 	crashing_cpu = smp_processor_id();
 	nmi_shootdown_cpus();
+#ifdef CONFIG_X86_IO_APIC
+	ioapic_kexec_restore_once();
+#endif /* CONFIG_X86_IO_APIC */
+#ifdef CONFIG_X86_LOCAL_APIC
+	lapic_kexec_restore_once();
+#endif
 	crash_save_self(regs);
 }

--=-b0j/IMNu+WATf8g87L58
Content-Disposition: attachment; filename=linux-2.6.15-rc1-apics_restore-io_apic-i386.patch
Content-Type: text/x-patch; name=linux-2.6.15-rc1-apics_restore-io_apic-i386.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.15-rc1/arch/i386/kernel/io_apic.c linux-2.6.15-rc1-rstr/arch/i386/kernel/io_apic.c
--- linux-2.6.15-rc1/arch/i386/kernel/io_apic.c	2005-11-18 01:16:04.000000000 +0900
+++ linux-2.6.15-rc1-rstr/arch/i386/kernel/io_apic.c	2005-11-18 02:05:20.000000000 +0900
@@ -1622,6 +1622,74 @@ void /*__init*/ print_PIC(void)
 
 #endif  /*  0  */
 
+#ifdef CONFIG_KEXEC
+
+struct ioapic_kexec_state {
+	struct sys_device *sysdev;
+	union IO_APIC_reg_00 reg_00;
+	union IO_APIC_reg_01 reg_01;
+	union IO_APIC_reg_02 reg_02;
+	union IO_APIC_reg_03 reg_03;
+};
+static struct ioapic_kexec_state ioapic_kexec_state[MAX_IO_APICS];
+
+static int __init ioapic_kexec_register(struct sys_device * sysdev)
+{
+	unsigned int apic = sysdev->id;
+	struct ioapic_kexec_state *state = ioapic_kexec_state + apic;
+	unsigned long flags;
+
+	state->sysdev = sysdev;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	state->reg_00.raw = io_apic_read(apic, 0);
+	state->reg_01.raw = io_apic_read(apic, 1);
+	if (state->reg_01.bits.version >= 0x10)
+		state->reg_02.raw = io_apic_read(apic, 2);
+	if (state->reg_01.bits.version >= 0x20)
+		state->reg_03.raw = io_apic_read(apic, 3);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+
+	return sysdev->cls->suspend(sysdev, PMSG_FREEZE);
+}
+
+int ioapic_kexec_restore(void)
+{
+	int return_code = 0;
+	unsigned int apic;
+
+	for (apic = 0; apic < nr_ioapics; apic++ ) {
+		struct ioapic_kexec_state *state = ioapic_kexec_state + apic;
+		unsigned long flags;
+		int error;
+
+		if (!state->sysdev)
+			continue;
+		error = state->sysdev->cls->resume(state->sysdev);
+		if (error)
+			return_code = error;
+
+		spin_lock_irqsave(&ioapic_lock, flags);
+		io_apic_write(apic, 0, state->reg_00.raw);
+		io_apic_write(apic, 1, state->reg_01.raw);
+		if (state->reg_01.bits.version >= 0x10)
+			io_apic_write(apic, 2, state->reg_02.raw);
+		if (state->reg_01.bits.version >= 0x20)
+			io_apic_write(apic, 3, state->reg_03.raw);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
+	}
+	return return_code;
+}
+
+int ioapic_kdump_restore(void) {
+	spin_lock_init(&ioapic_lock); /* Force success taking the lock */
+	return ioapic_kexec_restore();
+}
+
+#endif /* CONFIG_KEXEC */
+
+static int __init ioapic_sysfs_register(int (*register_hook)(struct sys_device * sysdev));
+
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;
@@ -1688,6 +1756,13 @@ static void __init enable_IO_APIC(void)
 		printk(KERN_WARNING "ExtINT in hardware and MP table differ\n");
 	}
 
+#ifdef CONFIG_KEXEC
+	printk(KERN_DEBUG "IO-APIC: Saving the state for second kernel...");
+	if (ioapic_sysfs_register(ioapic_kexec_register))
+		printk(KERN_WARNING "IO-APIC: Failed to save the state, second kernel may crash!\n");
+	printk(" done\n");
+#endif /* CONFIG_KEXEC */
+
 	/*
 	 * Do not trust the IO-APIC being empty at bootup
 	 */
@@ -1704,38 +1779,7 @@ void disable_IO_APIC(void)
 	 */
 	clear_IO_APIC();
 
-	/*
-	 * If the i8259 is routed through an IOAPIC
-	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrupts can be delivered.
-	 */
-	if (ioapic_i8259.pin != -1) {
-		struct IO_APIC_route_entry entry;
-		unsigned long flags;
-
-		memset(&entry, 0, sizeof(entry));
-		entry.mask            = 0; /* Enabled */
-		entry.trigger         = 0; /* Edge */
-		entry.irr             = 0;
-		entry.polarity        = 0; /* High */
-		entry.delivery_status = 0;
-		entry.dest_mode       = 0; /* Physical */
-		entry.delivery_mode   = dest_ExtINT; /* ExtInt */
-		entry.vector          = 0;
-		entry.dest.physical.physical_dest = 0;
-
-
-		/*
-		 * Add it to the IO-APIC irq-routing table:
-		 */
-		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic_i8259.apic, 0x11+2*ioapic_i8259.pin,
-			*(((int *)&entry)+1));
-		io_apic_write(ioapic_i8259.apic, 0x10+2*ioapic_i8259.pin,
-			*(((int *)&entry)+0));
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-	}
-	disconnect_bsp_APIC(ioapic_i8259.pin != -1);
+	disconnect_bsp_APIC();
 }
 
 /*
@@ -2410,7 +2454,6 @@ struct sysfs_ioapic_data {
 	struct sys_device dev;
 	struct IO_APIC_route_entry entry[0];
 };
-static struct sysfs_ioapic_data * mp_ioapic_data[MAX_IO_APICS];
 
 static int ioapic_suspend(struct sys_device *dev, pm_message_t state)
 {
@@ -2463,31 +2506,29 @@ static struct sysdev_class ioapic_sysdev
 	.resume = ioapic_resume,
 };
 
-static int __init ioapic_init_sysfs(void)
+static int __init ioapic_sysfs_register(int (*register_hook)(struct sys_device * sysdev))
 {
 	struct sys_device * dev;
-	int i, size, error = 0;
-
-	error = sysdev_class_register(&ioapic_sysdev_class);
-	if (error)
-		return error;
+	int i, size, error;
 
 	for (i = 0; i < nr_ioapics; i++ ) {
+		struct sysfs_ioapic_data * mp_ioapic_data;
+
 		size = sizeof(struct sys_device) + nr_ioapic_registers[i] 
 			* sizeof(struct IO_APIC_route_entry);
-		mp_ioapic_data[i] = kmalloc(size, GFP_KERNEL);
-		if (!mp_ioapic_data[i]) {
+		mp_ioapic_data = kmalloc(size, GFP_KERNEL);
+		if (!mp_ioapic_data) {
 			printk(KERN_ERR "Can't suspend/resume IOAPIC %d\n", i);
 			continue;
 		}
-		memset(mp_ioapic_data[i], 0, size);
-		dev = &mp_ioapic_data[i]->dev;
+		memset(mp_ioapic_data, 0, size);
+		dev = &mp_ioapic_data->dev;
 		dev->id = i; 
 		dev->cls = &ioapic_sysdev_class;
-		error = sysdev_register(dev);
+		error = (*register_hook)(dev);
 		if (error) {
-			kfree(mp_ioapic_data[i]);
-			mp_ioapic_data[i] = NULL;
+			kfree(mp_ioapic_data);
+			mp_ioapic_data = NULL;
 			printk(KERN_ERR "Can't suspend/resume IOAPIC %d\n", i);
 			continue;
 		}
@@ -2496,6 +2537,17 @@ static int __init ioapic_init_sysfs(void
 	return 0;
 }
 
+static int __init ioapic_init_sysfs(void)
+{
+	int error;
+
+	error = sysdev_class_register(&ioapic_sysdev_class);
+	if (error)
+		return error;
+
+	return ioapic_sysfs_register(sysdev_register);
+}
+
 device_initcall(ioapic_init_sysfs);
 
 /* --------------------------------------------------------------------------
diff -urNp linux-2.6.15-rc1/include/asm-i386/io_apic.h linux-2.6.15-rc1-rstr/include/asm-i386/io_apic.h
--- linux-2.6.15-rc1/include/asm-i386/io_apic.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/include/asm-i386/io_apic.h	2005-11-18 02:03:08.000000000 +0900
@@ -209,5 +209,7 @@ extern int (*ioapic_renumber_irq)(int io
 #endif
 
 extern int assign_irq_vector(int irq);
+extern int ioapic_kexec_restore(void);
+extern int ioapic_kdump_restore(void);
 
 #endif

--=-b0j/IMNu+WATf8g87L58
Content-Disposition: attachment; filename=linux-2.6.15-rc1-apics_restore-io_apic-x86_64.patch
Content-Type: text/x-patch; name=linux-2.6.15-rc1-apics_restore-io_apic-x86_64.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.15-rc1/arch/x86_64/kernel/io_apic.c linux-2.6.15-rc1-rstr/arch/x86_64/kernel/io_apic.c
--- linux-2.6.15-rc1/arch/x86_64/kernel/io_apic.c	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/arch/x86_64/kernel/io_apic.c	2005-11-18 02:05:36.000000000 +0900
@@ -1120,6 +1120,74 @@ void __apicdebuginit print_PIC(void)
 
 #endif  /*  0  */
 
+#ifdef CONFIG_KEXEC
+
+struct ioapic_kexec_state {
+	struct sys_device *sysdev;
+	union IO_APIC_reg_00 reg_00;
+	union IO_APIC_reg_01 reg_01;
+	union IO_APIC_reg_02 reg_02;
+	union IO_APIC_reg_03 reg_03;
+};
+static struct ioapic_kexec_state ioapic_kexec_state[MAX_IO_APICS];
+
+static int __init ioapic_kexec_register(struct sys_device * sysdev)
+{
+	unsigned int apic = sysdev->id;
+	struct ioapic_kexec_state *state = ioapic_kexec_state + apic;
+	unsigned long flags;
+
+	state->sysdev = sysdev;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	state->reg_00.raw = io_apic_read(apic, 0);
+	state->reg_01.raw = io_apic_read(apic, 1);
+	if (state->reg_01.bits.version >= 0x10)
+		state->reg_02.raw = io_apic_read(apic, 2);
+	if (state->reg_01.bits.version >= 0x20)
+		state->reg_03.raw = io_apic_read(apic, 3);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+
+	return sysdev->cls->suspend(sysdev, PMSG_FREEZE);
+}
+
+int ioapic_kexec_restore(void)
+{
+	int return_code = 0;
+	unsigned int apic;
+
+	for (apic = 0; apic < nr_ioapics; apic++ ) {
+		struct ioapic_kexec_state *state = ioapic_kexec_state + apic;
+		unsigned long flags;
+		int error;
+
+		if (!state->sysdev)
+			continue;
+		error = state->sysdev->cls->resume(state->sysdev);
+		if (error)
+			return_code = error;
+
+		spin_lock_irqsave(&ioapic_lock, flags);
+		io_apic_write(apic, 0, state->reg_00.raw);
+		io_apic_write(apic, 1, state->reg_01.raw);
+		if (state->reg_01.bits.version >= 0x10)
+			io_apic_write(apic, 2, state->reg_02.raw);
+		if (state->reg_01.bits.version >= 0x20)
+			io_apic_write(apic, 3, state->reg_03.raw);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
+	}
+	return return_code;
+}
+
+int ioapic_kdump_restore(void) {
+	spin_lock_init(&ioapic_lock); /* Force success taking the lock */
+	return ioapic_kexec_restore();
+}
+
+#endif /* CONFIG_KEXEC */
+
+static int __init ioapic_sysfs_register(int (*register_hook)(struct sys_device * sysdev));
+
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;
@@ -1144,6 +1212,13 @@ static void __init enable_IO_APIC(void)
 		nr_ioapic_registers[i] = reg_01.bits.entries+1;
 	}
 
+#ifdef CONFIG_KEXEC
+	apic_printk(APIC_VERBOSE, KERN_DEBUG "IO-APIC: Saving the state for second kernel...");
+	if (ioapic_sysfs_register(ioapic_kexec_register))
+		printk(KERN_WARNING "IO-APIC: Failed to save the state, second kernel may crash!\n");
+	apic_printk(APIC_VERBOSE, " done\n");
+#endif /* CONFIG_KEXEC */
+
 	/*
 	 * Do not trust the IO-APIC being empty at bootup
 	 */
@@ -1161,38 +1236,7 @@ void disable_IO_APIC(void)
 	 */
 	clear_IO_APIC();
 
-	/*
-	 * If the i8259 is routed through an IOAPIC
-	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrupts can be delivered.
-	 */
-	pin = find_isa_irq_pin(0, mp_ExtINT);
-	if (pin != -1) {
-		struct IO_APIC_route_entry entry;
-		unsigned long flags;
-
-		memset(&entry, 0, sizeof(entry));
-		entry.mask            = 0; /* Enabled */
-		entry.trigger         = 0; /* Edge */
-		entry.irr             = 0;
-		entry.polarity        = 0; /* High */
-		entry.delivery_status = 0;
-		entry.dest_mode       = 0; /* Physical */
-		entry.delivery_mode   = 7; /* ExtInt */
-		entry.vector          = 0;
-		entry.dest.physical.physical_dest = 0;
-
-
-		/*
-		 * Add it to the IO-APIC irq-routing table:
-		 */
-		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-		io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-	}
-
-	disconnect_bsp_APIC(pin != -1);
+	disconnect_bsp_APIC();
 }
 
 /*
@@ -1769,7 +1813,6 @@ struct sysfs_ioapic_data {
 	struct sys_device dev;
 	struct IO_APIC_route_entry entry[0];
 };
-static struct sysfs_ioapic_data * mp_ioapic_data[MAX_IO_APICS];
 
 static int ioapic_suspend(struct sys_device *dev, pm_message_t state)
 {
@@ -1822,31 +1865,29 @@ static struct sysdev_class ioapic_sysdev
 	.resume = ioapic_resume,
 };
 
-static int __init ioapic_init_sysfs(void)
+static int __init ioapic_sysfs_register(int (*register_hook)(struct sys_device * sysdev))
 {
 	struct sys_device * dev;
-	int i, size, error = 0;
-
-	error = sysdev_class_register(&ioapic_sysdev_class);
-	if (error)
-		return error;
+	int i, size, error;
 
 	for (i = 0; i < nr_ioapics; i++ ) {
+		struct sysfs_ioapic_data * mp_ioapic_data;
+
 		size = sizeof(struct sys_device) + nr_ioapic_registers[i]
 			* sizeof(struct IO_APIC_route_entry);
-		mp_ioapic_data[i] = kmalloc(size, GFP_KERNEL);
-		if (!mp_ioapic_data[i]) {
+		mp_ioapic_data = kmalloc(size, GFP_KERNEL);
+		if (!mp_ioapic_data) {
 			printk(KERN_ERR "Can't suspend/resume IOAPIC %d\n", i);
 			continue;
 		}
-		memset(mp_ioapic_data[i], 0, size);
-		dev = &mp_ioapic_data[i]->dev;
+		memset(mp_ioapic_data, 0, size);
+		dev = &mp_ioapic_data->dev;
 		dev->id = i;
 		dev->cls = &ioapic_sysdev_class;
-		error = sysdev_register(dev);
+		error = (*register_hook)(dev);
 		if (error) {
-			kfree(mp_ioapic_data[i]);
-			mp_ioapic_data[i] = NULL;
+			kfree(mp_ioapic_data);
+			mp_ioapic_data = NULL;
 			printk(KERN_ERR "Can't suspend/resume IOAPIC %d\n", i);
 			continue;
 		}
@@ -1855,6 +1896,17 @@ static int __init ioapic_init_sysfs(void
 	return 0;
 }
 
+static int __init ioapic_init_sysfs(void)
+{
+	int error;
+
+	error = sysdev_class_register(&ioapic_sysdev_class);
+	if (error)
+		return error;
+
+	return ioapic_sysfs_register(sysdev_register);
+}
+
 device_initcall(ioapic_init_sysfs);
 
 /* --------------------------------------------------------------------------
diff -urNp linux-2.6.15-rc1/include/asm-x86_64/io_apic.h linux-2.6.15-rc1-rstr/include/asm-x86_64/io_apic.h
--- linux-2.6.15-rc1/include/asm-x86_64/io_apic.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/include/asm-x86_64/io_apic.h	2005-11-18 02:03:31.000000000 +0900
@@ -214,6 +214,8 @@ extern int sis_apic_bug; /* dummy */ 
 #endif
 
 extern int assign_irq_vector(int irq);
+extern int ioapic_kexec_restore(void);
+extern int ioapic_kdump_restore(void);
 
 void enable_NMI_through_LVT0 (void * dummy);
 

--=-b0j/IMNu+WATf8g87L58
Content-Disposition: attachment; filename=linux-2.6.15-rc1-apics_restore-lapic-i386.patch
Content-Type: text/x-patch; name=linux-2.6.15-rc1-apics_restore-lapic-i386.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.15-rc1/arch/i386/kernel/apic.c linux-2.6.15-rc1-rstr/arch/i386/kernel/apic.c
--- linux-2.6.15-rc1/arch/i386/kernel/apic.c	2005-11-18 01:16:04.000000000 +0900
+++ linux-2.6.15-rc1-rstr/arch/i386/kernel/apic.c	2005-11-18 01:19:44.000000000 +0900
@@ -211,7 +211,7 @@ void __init connect_bsp_APIC(void)
 	enable_apic_mode();
 }
 
-void disconnect_bsp_APIC(int virt_wire_setup)
+void disconnect_bsp_APIC(void)
 {
 	if (pic_mode) {
 		/*
@@ -225,42 +225,6 @@ void disconnect_bsp_APIC(int virt_wire_s
 		outb(0x70, 0x22);
 		outb(0x00, 0x23);
 	}
-	else {
-		/* Go back to Virtual Wire compatibility mode */
-		unsigned long value;
-
-		/* For the spurious interrupt use vector F, and enable it */
-		value = apic_read(APIC_SPIV);
-		value &= ~APIC_VECTOR_MASK;
-		value |= APIC_SPIV_APIC_ENABLED;
-		value |= 0xf;
-		apic_write_around(APIC_SPIV, value);
-
-		if (!virt_wire_setup) {
-			/* For LVT0 make it edge triggered, active high, external and enabled */
-			value = apic_read(APIC_LVT0);
-			value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
-				APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
-				APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
-			value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
-			value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
-			apic_write_around(APIC_LVT0, value);
-		}
-		else {
-			/* Disable LVT0 */
-			apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
-		}
-
-		/* For LVT1 make it edge triggered, active high, nmi and enabled */
-		value = apic_read(APIC_LVT1);
-		value &= ~(
-			APIC_MODE_MASK | APIC_SEND_PENDING |
-			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
-			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
-		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
-		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
-		apic_write_around(APIC_LVT1, value);
-	}
 }
 
 void disable_local_APIC(void)
@@ -576,9 +540,9 @@ void lapic_shutdown(void)
 	local_irq_enable();
 }
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) || defined(CONFIG_KEXEC)
 
-static struct {
+struct apic_pm_state {
 	int active;
 	/* r/w apic fields */
 	unsigned int apic_id;
@@ -594,41 +558,38 @@ static struct {
 	unsigned int apic_tmict;
 	unsigned int apic_tdcr;
 	unsigned int apic_thmr;
-} apic_pm_state;
+};
 
-static int lapic_suspend(struct sys_device *dev, pm_message_t state)
+static int lapic_suspend_state(struct apic_pm_state *state)
 {
-	unsigned long flags;
-
-	if (!apic_pm_state.active)
+	if (!state->active)
 		return 0;
 
-	apic_pm_state.apic_id = apic_read(APIC_ID);
-	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
-	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
-	apic_pm_state.apic_dfr = apic_read(APIC_DFR);
-	apic_pm_state.apic_spiv = apic_read(APIC_SPIV);
-	apic_pm_state.apic_lvtt = apic_read(APIC_LVTT);
-	apic_pm_state.apic_lvtpc = apic_read(APIC_LVTPC);
-	apic_pm_state.apic_lvt0 = apic_read(APIC_LVT0);
-	apic_pm_state.apic_lvt1 = apic_read(APIC_LVT1);
-	apic_pm_state.apic_lvterr = apic_read(APIC_LVTERR);
-	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
-	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
-	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
-	
-	local_irq_save(flags);
-	disable_local_APIC();
-	local_irq_restore(flags);
+	state->apic_id = apic_read(APIC_ID);
+	state->apic_taskpri = apic_read(APIC_TASKPRI);
+	state->apic_ldr = apic_read(APIC_LDR);
+	state->apic_dfr = apic_read(APIC_DFR);
+	state->apic_spiv = apic_read(APIC_SPIV);
+	state->apic_lvtt = apic_read(APIC_LVTT);
+	state->apic_lvtpc = apic_read(APIC_LVTPC);
+	state->apic_lvt0 = apic_read(APIC_LVT0);
+	state->apic_lvt1 = apic_read(APIC_LVT1);
+	state->apic_lvterr = apic_read(APIC_LVTERR);
+	state->apic_tmict = apic_read(APIC_TMICT);
+	state->apic_tdcr = apic_read(APIC_TDCR);
+	state->apic_thmr = apic_read(APIC_LVTTHMR);
+
 	return 0;
 }
 
-static int lapic_resume(struct sys_device *dev)
+static int lapic_resume_state(struct apic_pm_state *state)
 {
+#ifndef CONFIG_SMP
 	unsigned int l, h;
+#endif /* !CONFIG_SMP */
 	unsigned long flags;
 
-	if (!apic_pm_state.active)
+	if (!state->active)
 		return 0;
 
 	local_irq_save(flags);
@@ -638,34 +599,77 @@ static int lapic_resume(struct sys_devic
 	 *
 	 * FIXME! This will be wrong if we ever support suspend on
 	 * SMP! We'll need to do this as part of the CPU restore!
+	 * It may cause on SMP: do_general_protection()
 	 */
+#ifndef CONFIG_SMP
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
 	l |= MSR_IA32_APICBASE_ENABLE | mp_lapic_addr;
 	wrmsr(MSR_IA32_APICBASE, l, h);
+#endif /* !CONFIG_SMP */
 
 	apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
-	apic_write(APIC_ID, apic_pm_state.apic_id);
-	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
-	apic_write(APIC_LDR, apic_pm_state.apic_ldr);
-	apic_write(APIC_TASKPRI, apic_pm_state.apic_taskpri);
-	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
-	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
-	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
-	apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
-	apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
-	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
-	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
-	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
+	apic_write(APIC_ID, state->apic_id);
+	apic_write(APIC_DFR, state->apic_dfr);
+	apic_write(APIC_LDR, state->apic_ldr);
+	apic_write(APIC_TASKPRI, state->apic_taskpri);
+	apic_write(APIC_SPIV, state->apic_spiv);
+	apic_write(APIC_LVT0, state->apic_lvt0);
+	apic_write(APIC_LVT1, state->apic_lvt1);
+	apic_write(APIC_LVTTHMR, state->apic_thmr);
+	apic_write(APIC_LVTPC, state->apic_lvtpc);
+	apic_write(APIC_LVTT, state->apic_lvtt);
+	apic_write(APIC_TDCR, state->apic_tdcr);
+	apic_write(APIC_TMICT, state->apic_tmict);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
-	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
+	apic_write(APIC_LVTERR, state->apic_lvterr);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
 	local_irq_restore(flags);
 	return 0;
 }
 
+#endif /* defined(CONFIG_PM) || defined(CONFIG_KEXEC) */
+
+#ifdef CONFIG_KEXEC
+
+static struct apic_pm_state apic_pm_state_kexec;
+
+int lapic_kexec_restore(void)
+{
+	int error;
+
+	error = lapic_resume_state(&apic_pm_state_kexec);
+	disconnect_bsp_APIC();
+
+	return error;
+}
+
+#endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_PM
+
+static struct apic_pm_state apic_pm_state_sysdev;
+
+static int lapic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	unsigned long flags;
+	int error;
+
+	error = lapic_suspend_state(&apic_pm_state_sysdev);
+	local_irq_save(flags);
+	disable_local_APIC();
+	local_irq_restore(flags);
+
+	return error;
+}
+
+static int lapic_resume(struct sys_device *dev)
+{
+	return lapic_resume_state(&apic_pm_state_sysdev);
+}
+
 /*
  * This device has no shutdown method - fully functioning local APICs
  * are needed on every CPU up until machine_halt/restart/poweroff.
@@ -684,7 +688,7 @@ static struct sys_device device_lapic = 
 
 static void __devinit apic_pm_activate(void)
 {
-	apic_pm_state.active = 1;
+	apic_pm_state_sysdev.active = 1;
 }
 
 static int __init init_lapic_sysfs(void)
@@ -826,6 +830,15 @@ void __init init_apic_mappings(void)
 	printk(KERN_DEBUG "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
 	       apic_phys);
 
+#ifdef CONFIG_KEXEC
+	/* APIC reads require already executed set_fixmap_nocache() above. */
+	printk(KERN_DEBUG "LAPIC: Saving the state for second kernel...");
+	apic_pm_state_kexec.active = 1;
+	if (lapic_suspend_state(&apic_pm_state_kexec))
+		printk(KERN_WARNING "LAPIC: Failed to save the state, second kernel may crash!\n");
+	printk(" done\n");
+#endif /* CONFIG_KEXEC */
+
 	/*
 	 * Fetch the APIC ID of the BSP in case we have a
 	 * default configuration (or the MP table is broken).
diff -urNp linux-2.6.15-rc1/include/asm-i386/apic.h linux-2.6.15-rc1-rstr/include/asm-i386/apic.h
--- linux-2.6.15-rc1/include/asm-i386/apic.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/include/asm-i386/apic.h	2005-11-18 01:22:39.000000000 +0900
@@ -100,7 +100,7 @@ extern void (*wait_timer_tick)(void);
 extern int get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
-extern void disconnect_bsp_APIC (int virt_wire_setup);
+extern void disconnect_bsp_APIC (void);
 extern void disable_local_APIC (void);
 extern void lapic_shutdown (void);
 extern int verify_local_APIC (void);
@@ -121,6 +121,9 @@ extern void nmi_watchdog_tick (struct pt
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+#ifdef CONFIG_KEXEC
+extern int lapic_kexec_restore(void);
+#endif /* CONFIG_KEXEC */
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
@@ -134,6 +137,9 @@ extern int disable_timer_pin_1;
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
+#ifdef CONFIG_KEXEC
+static inline int lapic_kexec_restore(void) { return 0; }
+#endif /* CONFIG_KEXEC */
 
 #endif /* !CONFIG_X86_LOCAL_APIC */
 

--=-b0j/IMNu+WATf8g87L58
Content-Disposition: attachment; filename=linux-2.6.15-rc1-apics_restore-lapic-x86_64.patch
Content-Type: text/x-patch; name=linux-2.6.15-rc1-apics_restore-lapic-x86_64.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.15-rc1/arch/x86_64/kernel/apic.c linux-2.6.15-rc1-rstr/arch/x86_64/kernel/apic.c
--- linux-2.6.15-rc1/arch/x86_64/kernel/apic.c	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/arch/x86_64/kernel/apic.c	2005-11-18 01:25:31.000000000 +0900
@@ -129,7 +129,7 @@ void __init connect_bsp_APIC(void)
 	}
 }
 
-void disconnect_bsp_APIC(int virt_wire_setup)
+void disconnect_bsp_APIC(void)
 {
 	if (pic_mode) {
 		/*
@@ -142,42 +142,6 @@ void disconnect_bsp_APIC(int virt_wire_s
 		outb(0x70, 0x22);
 		outb(0x00, 0x23);
 	}
-	else {
-		/* Go back to Virtual Wire compatibility mode */
-		unsigned long value;
-
-		/* For the spurious interrupt use vector F, and enable it */
-		value = apic_read(APIC_SPIV);
-		value &= ~APIC_VECTOR_MASK;
-		value |= APIC_SPIV_APIC_ENABLED;
-		value |= 0xf;
-		apic_write_around(APIC_SPIV, value);
-
-		if (!virt_wire_setup) {
-			/* For LVT0 make it edge triggered, active high, external and enabled */
-			value = apic_read(APIC_LVT0);
-			value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
-				APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
-				APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
-			value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
-			value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
-			apic_write_around(APIC_LVT0, value);
-		}
-		else {
-			/* Disable LVT0 */
-			apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
-		}
-
-		/* For LVT1 make it edge triggered, active high, nmi and enabled */
-		value = apic_read(APIC_LVT1);
-		value &= ~(
-			APIC_MODE_MASK | APIC_SEND_PENDING |
-			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
-			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
-		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
-		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
-		apic_write_around(APIC_LVT1, value);
-	}
 }
 
 void disable_local_APIC(void)
@@ -442,9 +406,9 @@ void __cpuinit setup_local_APIC (void)
 	apic_pm_activate();
 }
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) || defined(CONFIG_KEXEC)
 
-static struct {
+struct apic_pm_state {
 	/* 'active' is true if the local APIC was enabled by us and
 	   not the BIOS; this signifies that we are also responsible
 	   for disabling it before entering apm/acpi suspend */
@@ -463,73 +427,115 @@ static struct {
 	unsigned int apic_tmict;
 	unsigned int apic_tdcr;
 	unsigned int apic_thmr;
-} apic_pm_state;
+};
 
-static int lapic_suspend(struct sys_device *dev, pm_message_t state)
+static int lapic_suspend_state(struct apic_pm_state *state)
 {
-	unsigned long flags;
-
-	if (!apic_pm_state.active)
+	if (!state->active)
 		return 0;
 
-	apic_pm_state.apic_id = apic_read(APIC_ID);
-	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
-	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
-	apic_pm_state.apic_dfr = apic_read(APIC_DFR);
-	apic_pm_state.apic_spiv = apic_read(APIC_SPIV);
-	apic_pm_state.apic_lvtt = apic_read(APIC_LVTT);
-	apic_pm_state.apic_lvtpc = apic_read(APIC_LVTPC);
-	apic_pm_state.apic_lvt0 = apic_read(APIC_LVT0);
-	apic_pm_state.apic_lvt1 = apic_read(APIC_LVT1);
-	apic_pm_state.apic_lvterr = apic_read(APIC_LVTERR);
-	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
-	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
-	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
-	local_save_flags(flags);
-	local_irq_disable();
-	disable_local_APIC();
-	local_irq_restore(flags);
+	state->apic_id = apic_read(APIC_ID);
+	state->apic_taskpri = apic_read(APIC_TASKPRI);
+	state->apic_ldr = apic_read(APIC_LDR);
+	state->apic_dfr = apic_read(APIC_DFR);
+	state->apic_spiv = apic_read(APIC_SPIV);
+	state->apic_lvtt = apic_read(APIC_LVTT);
+	state->apic_lvtpc = apic_read(APIC_LVTPC);
+	state->apic_lvt0 = apic_read(APIC_LVT0);
+	state->apic_lvt1 = apic_read(APIC_LVT1);
+	state->apic_lvterr = apic_read(APIC_LVTERR);
+	state->apic_tmict = apic_read(APIC_TMICT);
+	state->apic_tdcr = apic_read(APIC_TDCR);
+	state->apic_thmr = apic_read(APIC_LVTTHMR);
+
 	return 0;
 }
 
-static int lapic_resume(struct sys_device *dev)
+static int lapic_resume_state(struct apic_pm_state *state)
 {
+#ifndef CONFIG_SMP
 	unsigned int l, h;
+#endif /* !CONFIG_SMP */
 	unsigned long flags;
 
-	if (!apic_pm_state.active)
+	if (!state->active)
 		return 0;
 
 	/* XXX: Pavel needs this for S3 resume, but can't explain why */
 	set_fixmap_nocache(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);
 
 	local_irq_save(flags);
+	/* It may cause on SMP: do_general_protection() */
+#ifndef CONFIG_SMP
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
 	l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 	wrmsr(MSR_IA32_APICBASE, l, h);
+#endif /* !CONFIG_SMP */
 	apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
-	apic_write(APIC_ID, apic_pm_state.apic_id);
-	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
-	apic_write(APIC_LDR, apic_pm_state.apic_ldr);
-	apic_write(APIC_TASKPRI, apic_pm_state.apic_taskpri);
-	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
-	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
-	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
-	apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
-	apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
-	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
-	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
-	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
+	apic_write(APIC_ID, state->apic_id);
+	apic_write(APIC_DFR, state->apic_dfr);
+	apic_write(APIC_LDR, state->apic_ldr);
+	apic_write(APIC_TASKPRI, state->apic_taskpri);
+	apic_write(APIC_SPIV, state->apic_spiv);
+	apic_write(APIC_LVT0, state->apic_lvt0);
+	apic_write(APIC_LVT1, state->apic_lvt1);
+	apic_write(APIC_LVTTHMR, state->apic_thmr);
+	apic_write(APIC_LVTPC, state->apic_lvtpc);
+	apic_write(APIC_LVTT, state->apic_lvtt);
+	apic_write(APIC_TDCR, state->apic_tdcr);
+	apic_write(APIC_TMICT, state->apic_tmict);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
-	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
+	apic_write(APIC_LVTERR, state->apic_lvterr);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
 	local_irq_restore(flags);
+
 	return 0;
 }
 
+#endif /* defined(CONFIG_PM) || defined(CONFIG_KEXEC) */
+
+#ifdef CONFIG_KEXEC
+
+static struct apic_pm_state apic_pm_state_kexec;
+
+int lapic_kexec_restore(void)
+{
+	int error;
+
+	error = lapic_resume_state(&apic_pm_state_kexec);
+	disconnect_bsp_APIC();
+
+	return error;
+}
+
+#endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_PM
+
+static struct apic_pm_state apic_pm_state_sysdev;
+
+static int lapic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	unsigned long flags;
+	int error;
+
+	error = lapic_suspend_state(&apic_pm_state_sysdev);
+	local_save_flags(flags);
+	local_irq_disable();
+	disable_local_APIC();
+	local_irq_restore(flags);
+
+	return error;
+}
+
+static int lapic_resume(struct sys_device *dev)
+{
+	return lapic_resume_state(&apic_pm_state_sysdev);
+}
+
 static struct sysdev_class lapic_sysclass = {
 	set_kset_name("lapic"),
 	.resume		= lapic_resume,
@@ -543,7 +549,7 @@ static struct sys_device device_lapic = 
 
 static void __cpuinit apic_pm_activate(void)
 {
-	apic_pm_state.active = 1;
+	apic_pm_state_sysdev.active = 1;
 }
 
 static int __init init_lapic_sysfs(void)
@@ -617,6 +623,15 @@ void __init init_apic_mappings(void)
 	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
 	apic_printk(APIC_VERBOSE,"mapped APIC to %16lx (%16lx)\n", APIC_BASE, apic_phys);
 
+#ifdef CONFIG_KEXEC
+	/* APIC reads require already executed set_fixmap_nocache() above. */
+	printk(KERN_DEBUG "LAPIC: Saving the state for second kernel...");
+	apic_pm_state_kexec.active = 1;
+	if (lapic_suspend_state(&apic_pm_state_kexec))
+		printk(KERN_WARNING "LAPIC: Failed to save the state, second kernel may crash!\n");
+	printk(" done\n");
+#endif /* CONFIG_KEXEC */
+
 	/*
 	 * Fetch the APIC ID of the BSP in case we have a
 	 * default configuration (or the MP table is broken).
diff -urNp linux-2.6.15-rc1/include/asm-x86_64/apic.h linux-2.6.15-rc1-rstr/include/asm-x86_64/apic.h
--- linux-2.6.15-rc1/include/asm-x86_64/apic.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/include/asm-x86_64/apic.h	2005-11-18 01:28:05.000000000 +0900
@@ -77,7 +77,7 @@ static inline void ack_APIC_irq(void)
 extern int get_maxlvt (void);
 extern void clear_local_APIC (void);
 extern void connect_bsp_APIC (void);
-extern void disconnect_bsp_APIC (int virt_wire_setup);
+extern void disconnect_bsp_APIC (void);
 extern void disable_local_APIC (void);
 extern int verify_local_APIC (void);
 extern void cache_APIC_registers (void);
@@ -98,6 +98,9 @@ extern int APIC_init_uniprocessor (void)
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
+#ifdef CONFIG_KEXEC
+extern int lapic_kexec_restore(void);
+#endif /* CONFIG_KEXEC */
 
 extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
@@ -111,7 +114,11 @@ extern unsigned int nmi_watchdog;
 
 extern int disable_timer_pin_1;
 
-#endif /* CONFIG_X86_LOCAL_APIC */
+#else /* !CONFIG_X86_LOCAL_APIC */
+#ifdef CONFIG_KEXEC
+static inline int lapic_kexec_restore(void) { return 0; }
+#endif /* CONFIG_KEXEC */
+#endif /* !CONFIG_X86_LOCAL_APIC */
 
 extern unsigned boot_cpu_id;
 

--=-b0j/IMNu+WATf8g87L58
Content-Disposition: attachment; filename=linux-2.6.15-rc1-apics_restore-reboot-i386.patch
Content-Type: text/x-patch; name=linux-2.6.15-rc1-apics_restore-reboot-i386.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.15-rc1/arch/i386/kernel/reboot.c linux-2.6.15-rc1-rstr/arch/i386/kernel/reboot.c
--- linux-2.6.15-rc1/arch/i386/kernel/reboot.c	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/arch/i386/kernel/reboot.c	2005-11-18 01:31:42.000000000 +0900
@@ -304,11 +304,19 @@ void machine_shutdown(void)
 	smp_send_stop();
 #endif /* CONFIG_SMP */
 
-	lapic_shutdown();
-
 #ifdef CONFIG_X86_IO_APIC
+#ifndef CONFIG_KEXEC
 	disable_IO_APIC();
-#endif
+#else /* CONFIG_KEXEC */
+	ioapic_kexec_restore(); /* errors ignored */
+#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_X86_IO_APIC */
+
+#ifndef CONFIG_KEXEC
+	lapic_shutdown();
+#else /* CONFIG_KEXEC */
+	lapic_kexec_restore();  /* errors ignored */
+#endif /* CONFIG_KEXEC */
 }
 
 void machine_emergency_restart(void)

--=-b0j/IMNu+WATf8g87L58
Content-Disposition: attachment; filename=linux-2.6.15-rc1-apics_restore-reboot-x86_64.patch
Content-Type: text/x-patch; name=linux-2.6.15-rc1-apics_restore-reboot-x86_64.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.15-rc1/arch/x86_64/kernel/reboot.c linux-2.6.15-rc1-rstr/arch/x86_64/kernel/reboot.c
--- linux-2.6.15-rc1/arch/x86_64/kernel/reboot.c	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc1-rstr/arch/x86_64/kernel/reboot.c	2005-11-18 01:52:23.000000000 +0900
@@ -100,11 +100,19 @@ void machine_shutdown(void)
 
 	local_irq_disable();
 
+#ifndef CONFIG_KEXEC
+	disable_IO_APIC();
+#else /* CONFIG_KEXEC */
+	ioapic_kexec_restore();	/* errors ignored */
+#endif /* CONFIG_KEXEC */
+
 #ifndef CONFIG_SMP
+#ifndef CONFIG_KEXEC
 	disable_local_APIC();
-#endif
-
-	disable_IO_APIC();
+#else /* CONFIG_KEXEC */
+	lapic_kexec_restore();	/* errors ignored */
+#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_SMP */
 
 	local_irq_enable();
 }

--=-b0j/IMNu+WATf8g87L58--

