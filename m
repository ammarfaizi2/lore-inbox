Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWE1Omu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWE1Omu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 10:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWE1Omu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 10:42:50 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:35666 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750773AbWE1Omt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 10:42:49 -0400
Message-ID: <4479B6DB.1000703@interia.pl>
Date: Sun, 28 May 2006 16:42:35 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] Longhaul - call suspend(PMSG_FREEZE) before and resume()
 after
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-EMID: ab722acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is simplier patch using PCI bus master disabling code by Dave Jones.
Still using block subsystem, but this time it isn't exported to modules.

1. Call suspend(PMSG_FREEZE) for each block device.
2. Change frequency - notice that in this patch at least we give a chance to BCR2 MSR CPU's.
3. Call resume() for each block device.

Tested on Epia M10000. 22MB/s while changing from 997MHz to 532MHz at 1s interval.

EXPERIMENTAL - Please!
(HZ_100 || HZ_250) - because VIA CPU's with BCR2 MSR need >=1ms to sync PLL.
!SMP - original code and patch aren't SMP compatible.
!X86_UP_APIC - original code and patch aren't APIC compatible.


diff -uprN -X linux-2.6.16.18-vanilla/Documentation/dontdiff linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/Kconfig linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/Kconfig
--- linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/Kconfig	2006-05-28 15:04:34.000000000 +0200
+++ linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/Kconfig	2006-05-28 15:36:54.000000000 +0200
@@ -201,14 +201,17 @@ config X86_LONGRUN
 	  If in doubt, say N.
 
 config X86_LONGHAUL
-	tristate "VIA Cyrix III Longhaul"
+	bool "VIA Cyrix III Longhaul (EXPERIMENTAL)"
+	default n
 	select CPU_FREQ_TABLE
-	depends on BROKEN
+	depends on EXPERIMENTAL && !SMP && !X86_UP_APIC
+	depends on (HZ_100 || HZ_250) && (PREEMPT_NONE || PREEMPT_VOLUNTARY)
 	help
 	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
 	  processors.
 
+	  BIG FAT DISCLAIMER: Work in progress code. Possibly *dangerous*
 	  For details, take a look at <file:Documentation/cpu-freq/>.
 
 	  If in doubt, say N.
diff -uprN -X linux-2.6.16.18-vanilla/Documentation/dontdiff linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/longhaul.c linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/longhaul.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/longhaul.c	2006-05-28 15:57:58.000000000 +0200
@@ -30,6 +30,11 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
+#include <linux/kobject.h>
+#include <linux/sysdev.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>
 
 #include <asm/msr.h>
 #include <asm/timex.h>
@@ -115,36 +120,40 @@ static int longhaul_get_cpu_mult(void)
 }
 
 
-static void do_powersaver(union msr_longhaul *longhaul,
-			unsigned int clock_ratio_index)
-{
-	struct pci_dev *dev;
-	unsigned long flags;
-	unsigned int tmp_mask;
-	int version;
-	int i;
-	u16 pci_cmd;
-	u16 cmd_state[64];
+extern struct subsystem block_subsys;
+extern struct semaphore block_subsys_sem;
 
-	switch (cpu_model) {
-	case CPU_EZRA_T:
-		version = 3;
-		break;
-	case CPU_NEHEMIAH:
-		version = 0xf;
-		break;
-	default:
-		return;
+static struct pm_message pmsg_freeze = { .event = PM_EVENT_FREEZE, };
+
+void block_freeze_resume(int freeze)
+{
+	struct gendisk *disk;
+	struct list_head *p;
+	struct bus_type *bus;
+
+	list_for_each(p, &block_subsys.kset.list) {
+		disk = list_entry(p, struct gendisk, kobj.entry);
+		if (disk->driverfs_dev && disk->driverfs_dev->bus) {
+			bus = disk->driverfs_dev->bus;
+			if (bus->suspend && freeze) {
+				printk(KERN_INFO PFX "%.32s (%.32s) -> suspend(PMSG_FREEZE)\n", &disk->disk_name[0], &disk->driverfs_dev->bus_id[0]);
+				bus->suspend(disk->driverfs_dev, pmsg_freeze); 
+			} else if (bus->resume && !freeze) {
+				printk(KERN_INFO PFX "%.32s (%.32s) -> resume()\n", &disk->disk_name[0], &disk->driverfs_dev->bus_id[0]);
+				bus->resume(disk->driverfs_dev); 
+			}
+		}
 	}
+}
 
-	rdmsrl(MSR_VIA_LONGHAUL, longhaul->val);
-	longhaul->bits.SoftBusRatio = clock_ratio_index & 0xf;
-	longhaul->bits.SoftBusRatio4 = (clock_ratio_index & 0x10) >> 4;
-	longhaul->bits.EnableSoftBusRatio = 1;
-	longhaul->bits.RevisionKey = 0;
 
-	preempt_disable();
-	local_irq_save(flags);
+static u16 cmd_state[64];
+
+static void clear_bus_master(void)
+{
+	struct pci_dev *dev;
+	u16 pci_cmd;
+	int i;
 
 	/*
 	 * get current pci bus master state for all devices
@@ -161,18 +170,14 @@ static void do_powersaver(union msr_long
 			pci_write_config_word(dev, PCI_COMMAND, pci_cmd);
 		}
 	} while (dev != NULL);
+}
 
-	tmp_mask=inb(0x21);	/* works on C3. save mask. */
-	outb(0xFE,0x21);	/* TMR0 only */
-	outb(0xFF,0x80);	/* delay */
-
-	safe_halt();
-	wrmsrl(MSR_VIA_LONGHAUL, longhaul->val);
-	halt();
-
-	local_irq_disable();
 
-	outb(tmp_mask,0x21);	/* restore mask */
+static void restore_bus_master(void)
+{
+	struct pci_dev *dev;
+	u16 pci_cmd;
+	int i;
 
 	/* restore pci bus master state for all devices */
 	dev = NULL;
@@ -184,14 +189,106 @@ static void do_powersaver(union msr_long
 			pci_write_config_byte(dev, PCI_COMMAND, pci_cmd);
 		}
 	} while (dev != NULL);
+}
+
+
+static void do_longhaul1(int reserved, unsigned int clock_ratio_index)
+{
+	unsigned long flags;
+	unsigned int tmp_mask;
+	union msr_bcr2 bcr2;
+
+        down(&block_subsys_sem);
+	block_freeze_resume(1);
+	preempt_disable();
+	clear_bus_master();
+	local_irq_save(flags);
+
+	local_irq_disable();
+
+	tmp_mask=inb(0x21);	/* works on C3. save mask. */
+	outb(0xFE, 0x21);	/* TMR0 only */
+
+	rdmsrl(MSR_VIA_BCR2, bcr2.val);
+	/* Enable software clock multiplier */
+	bcr2.bits.ESOFTBF = 1;
+	bcr2.bits.CLOCKMUL = clock_ratio_index;
+	safe_halt();		/* Sync */
+	wrmsrl(MSR_VIA_BCR2, bcr2.val);	/* Change */
+	halt();
+
+	/* Disable software clock multiplier */
+	local_irq_disable();
+	rdmsrl(MSR_VIA_BCR2, bcr2.val);
+	bcr2.bits.ESOFTBF = 0;
+	wrmsrl(MSR_VIA_BCR2, bcr2.val);
+	local_irq_enable();
+
+	outb(tmp_mask, 0x21);	/* restore mask */
 	local_irq_restore(flags);
+	restore_bus_master();
 	preempt_enable();
+	block_freeze_resume(0);
+        up(&block_subsys_sem);
+}
+
+
+static void do_powersaver(union msr_longhaul *longhaul,
+			unsigned int clock_ratio_index)
+{
+	unsigned long flags;
+	unsigned int pic1_mask, pic2_mask;
+	int version;
+
+	switch (cpu_model) {
+	case CPU_EZRA_T:
+		version = 3;
+		break;
+	case CPU_NEHEMIAH:
+		version = 0xf;
+		break;
+	default:
+		return;
+	}
+
+        down(&block_subsys_sem);
+	block_freeze_resume(1);
+	preempt_disable();
+	clear_bus_master();
+	local_irq_save(flags);
+
+	local_irq_disable();
+	pic2_mask=inb(0xA1);
+	pic1_mask=inb(0x21);	/* works on C3. save mask. */
+	outb(0xFF,0xA1);	/* Overkill */
+	outb(0xFE,0x21);	/* TMR0 only */
+
+	rdmsrl(MSR_VIA_LONGHAUL, longhaul->val);
+	longhaul->bits.SoftBusRatio = clock_ratio_index & 0xf;
+	longhaul->bits.SoftBusRatio4 = (clock_ratio_index & 0x10) >> 4;
+	longhaul->bits.EnableSoftBusRatio = 1;
+	longhaul->bits.RevisionKey = 0;
+
+	safe_halt();		/* Sync */
+	wrmsrl(MSR_VIA_LONGHAUL, longhaul->val);
+	halt();
+
+	local_irq_disable();
 
 	/* disable bus ratio bit */
 	rdmsrl(MSR_VIA_LONGHAUL, longhaul->val);
 	longhaul->bits.EnableSoftBusRatio = 0;
 	longhaul->bits.RevisionKey = version;
 	wrmsrl(MSR_VIA_LONGHAUL, longhaul->val);
+
+	outb(pic2_mask,0xA1);
+	outb(pic1_mask,0x21);	/* restore mask */
+
+	local_irq_restore(flags);
+	restore_bus_master();
+	preempt_enable();
+	block_freeze_resume(0);
+        up(&block_subsys_sem);
 }
 
 /**
@@ -206,7 +303,6 @@ static void longhaul_setstate(unsigned i
 	int speed, mult;
 	struct cpufreq_freqs freqs;
 	union msr_longhaul longhaul;
-	union msr_bcr2 bcr2;
 	static unsigned int old_ratio=-1;
 
 	if (old_ratio == clock_ratio_index)
@@ -241,20 +337,7 @@ static void longhaul_setstate(unsigned i
 	 */
 	case TYPE_LONGHAUL_V1:
 	case TYPE_LONGHAUL_V2:
-		rdmsrl (MSR_VIA_BCR2, bcr2.val);
-		/* Enable software clock multiplier */
-		bcr2.bits.ESOFTBF = 1;
-		bcr2.bits.CLOCKMUL = clock_ratio_index;
-		local_irq_disable();
-		wrmsrl (MSR_VIA_BCR2, bcr2.val);
-		safe_halt();
-
-		/* Disable software clock multiplier */
-		rdmsrl (MSR_VIA_BCR2, bcr2.val);
-		bcr2.bits.ESOFTBF = 0;
-		local_irq_disable();
-		wrmsrl (MSR_VIA_BCR2, bcr2.val);
-		local_irq_enable();
+		do_longhaul1(0, clock_ratio_index);
 		break;
 
 	/*
diff -uprN -X linux-2.6.16.18-vanilla/Documentation/dontdiff linux-2.6.16.18-vanilla/block/genhd.c linux-2.6.16.18/block/genhd.c
--- linux-2.6.16.18-vanilla/block/genhd.c	2006-05-28 15:04:34.000000000 +0200
+++ linux-2.6.16.18/block/genhd.c	2006-05-28 15:34:31.000000000 +0200
@@ -16,9 +16,9 @@
 #include <linux/kobj_map.h>
 #include <linux/buffer_head.h>
 
-static struct subsystem block_subsys;
+struct subsystem block_subsys;
 
-static DECLARE_MUTEX(block_subsys_sem);
+DECLARE_MUTEX(block_subsys_sem);
 
 /*
  * Can be deleted altogether. Later.
@@ -511,8 +511,7 @@ static struct kset_uevent_ops block_ueve
 };
 
 /* declare block_subsys. */
-static decl_subsys(block, &ktype_block, &block_uevent_ops);
-
+decl_subsys(block, &ktype_block, &block_uevent_ops);
 
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs


----------------------------------------------------------------------
Poznaj Stefana! Zmien komunikator! >>> http://link.interia.pl/f1924

