Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWE0WbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWE0WbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWE0WbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:31:09 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:18307 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S964964AbWE0WbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:31:08 -0400
Message-ID: <4478D319.2030707@interia.pl>
Date: Sun, 28 May 2006 00:30:49 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Longhaul - call suspend(PMSG_FREEZE) before and resume()
 after
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-EMID: c2ccaacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this to Dave Jones, but:
> This really should also get posted to linux-kernel, though I don't
> think people are going to be particularly enthusiastic about exposing
> these innards to modules.
So I'm posting this patch here too. I'm not subscribed to this list.
If You wish email me.
Minor change: preempt_disabled() goto_sleep_pci() and wakeup_pci() 
causes "sheduling while atomic". So in this patch below it isn't
preempt_disabled(). But I think that this should be protected
in some way. 

How it works:
1. Call suspend(PMSG_FREEZE) for each block device.
2. Call suspend(PMSG_FREEZE) for each PCI device.
3. Change CPU frequency.
4. Call resume() for each PCI device.
5. Call resume() for each block device.

Result: No more broken DMA transfers caused by frequency change.

diff -uprN -X linux-2.6.16.18-vanilla/Documentation/dontdiff linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/Kconfig linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/Kconfig
--- linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/Kconfig	2006-05-27 15:50:00.000000000 +0200
+++ linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/Kconfig	2006-05-27 15:53:13.000000000 +0200
@@ -203,7 +203,6 @@ config X86_LONGRUN
 config X86_LONGHAUL
 	tristate "VIA Cyrix III Longhaul"
 	select CPU_FREQ_TABLE
-	depends on BROKEN
 	help
 	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
diff -uprN -X linux-2.6.16.18-vanilla/Documentation/dontdiff linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/longhaul.c linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-2.6.16.18-vanilla/arch/i386/kernel/cpu/cpufreq/longhaul.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.18/arch/i386/kernel/cpu/cpufreq/longhaul.c	2006-05-27 15:53:13.000000000 +0200
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
@@ -115,16 +120,144 @@ static int longhaul_get_cpu_mult(void)
 }
 
 
-static void do_powersaver(union msr_longhaul *longhaul,
-			unsigned int clock_ratio_index)
+extern struct subsystem block_subsys;
+extern struct semaphore block_subsys_sem;
+
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
+				printk("Longhaul: %.32s (%.32s) -> suspend(PMSG_FREEZE)\n", &disk->disk_name[0], &disk->driverfs_dev->bus_id[0]);
+				bus->suspend(disk->driverfs_dev, pmsg_freeze); 
+			} else if (bus->resume && !freeze) {
+				printk("Longhaul: %.32s (%.32s) -> resume()\n", &disk->disk_name[0], &disk->driverfs_dev->bus_id[0]);
+				bus->resume(disk->driverfs_dev); 
+			}
+		}
+	}
+}
+
+
+/* This is copy from pci.c and pci-driver.c
+ */
+
+static void goto_sleep_pci(void)
+{
+	struct pci_dev *dev;
+	struct pci_driver *drv;
+	u16 pci_command;
+
+	/*
+	 * Get current pci bus master state for all devices
+	 * and clear bus master bit
+	 */
+
+	dev = NULL;
+	do {
+		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
+		if (dev != NULL) {
+			drv = dev->driver;
+			if (drv && drv->suspend)
+				drv->suspend(dev, pmsg_freeze);
+			else
+	    			pci_save_state(dev);
+			pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+			if (pci_command & PCI_COMMAND_MASTER) {
+				pci_command &= ~PCI_COMMAND_MASTER;
+				pci_write_config_word(dev, PCI_COMMAND, pci_command);
+			}
+			/* pcibios_disable_device omited because
+			   USB devices don't respond after resume
+			   on EPIA M10000 */
+		}
+	} while (dev != NULL);
+}
+
+
+static void wakeup_pci(void)
 {
 	struct pci_dev *dev;
+	struct pci_driver *drv;
+
+	/* Restore pci bus master state for all devices */
+
+	dev = NULL;
+	do {
+		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
+		if (dev != NULL) {
+			drv = dev->driver;
+			if (drv && drv->resume)
+				drv->resume(dev);
+			else
+				/* restore the PCI config space */
+				pci_restore_state(dev);
+	    		/* if the device was busmaster before the suspend, make it busmaster again */
+			if (dev->is_busmaster)
+				pci_set_master(dev);
+			/* if the device was enabled before suspend, reenable */
+			if (dev->is_enabled)
+				pci_enable_device(dev);
+		}
+	} while (dev != NULL);
+}
+
+
+static void do_longhaul1(int reserved, unsigned int clock_ratio_index)
+{
 	unsigned long flags;
 	unsigned int tmp_mask;
+	union msr_bcr2 bcr2;
+
+        down(&block_subsys_sem);
+	block_freeze_resume(1);
+	goto_sleep_pci();
+	preempt_disable();
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
+	local_irq_restore(flags);
+	preempt_enable();
+	wakeup_pci();
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
 	int version;
-	int i;
-	u16 pci_cmd;
-	u16 cmd_state[64];
 
 	switch (cpu_model) {
 	case CPU_EZRA_T:
@@ -137,61 +270,44 @@ static void do_powersaver(union msr_long
 		return;
 	}
 
+        down(&block_subsys_sem);
+	block_freeze_resume(1);
+	goto_sleep_pci();
+	preempt_disable();
+	local_irq_save(flags);
+
+	local_irq_disable();
+	pic2_mask=inb(0xA1);
+	pic1_mask=inb(0x21);	/* works on C3. save mask. */
+	outb(0xFF,0xA1);	/* Overkill */
+	outb(0xFE,0x21);	/* TMR0 only */
+
 	rdmsrl(MSR_VIA_LONGHAUL, longhaul->val);
 	longhaul->bits.SoftBusRatio = clock_ratio_index & 0xf;
 	longhaul->bits.SoftBusRatio4 = (clock_ratio_index & 0x10) >> 4;
 	longhaul->bits.EnableSoftBusRatio = 1;
 	longhaul->bits.RevisionKey = 0;
 
-	preempt_disable();
-	local_irq_save(flags);
-
-	/*
-	 * get current pci bus master state for all devices
-	 * and clear bus master bit
-	 */
-	dev = NULL;
-	i = 0;
-	do {
-		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
-		if (dev != NULL) {
-			pci_read_config_word(dev, PCI_COMMAND, &pci_cmd);
-			cmd_state[i++] = pci_cmd;
-			pci_cmd &= ~PCI_COMMAND_MASTER;
-			pci_write_config_word(dev, PCI_COMMAND, pci_cmd);
-		}
-	} while (dev != NULL);
-
-	tmp_mask=inb(0x21);	/* works on C3. save mask. */
-	outb(0xFE,0x21);	/* TMR0 only */
-	outb(0xFF,0x80);	/* delay */
-
-	safe_halt();
+	safe_halt();		/* Sync */
 	wrmsrl(MSR_VIA_LONGHAUL, longhaul->val);
 	halt();
 
 	local_irq_disable();
 
-	outb(tmp_mask,0x21);	/* restore mask */
-
-	/* restore pci bus master state for all devices */
-	dev = NULL;
-	i = 0;
-	do {
-		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
-		if (dev != NULL) {
-			pci_cmd = cmd_state[i++];
-			pci_write_config_byte(dev, PCI_COMMAND, pci_cmd);
-		}
-	} while (dev != NULL);
-	local_irq_restore(flags);
-	preempt_enable();
-
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
+	preempt_enable();
+	wakeup_pci();
+	block_freeze_resume(0);
+        up(&block_subsys_sem);
 }
 
 /**
@@ -206,7 +322,6 @@ static void longhaul_setstate(unsigned i
 	int speed, mult;
 	struct cpufreq_freqs freqs;
 	union msr_longhaul longhaul;
-	union msr_bcr2 bcr2;
 	static unsigned int old_ratio=-1;
 
 	if (old_ratio == clock_ratio_index)
@@ -241,20 +356,7 @@ static void longhaul_setstate(unsigned i
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
--- linux-2.6.16.18-vanilla/block/genhd.c	2006-05-27 15:50:01.000000000 +0200
+++ linux-2.6.16.18/block/genhd.c	2006-05-27 15:53:13.000000000 +0200
@@ -16,9 +16,9 @@
 #include <linux/kobj_map.h>
 #include <linux/buffer_head.h>
 
-static struct subsystem block_subsys;
+struct subsystem block_subsys;
 
-static DECLARE_MUTEX(block_subsys_sem);
+DECLARE_MUTEX(block_subsys_sem);
 
 /*
  * Can be deleted altogether. Later.
@@ -511,8 +511,10 @@ static struct kset_uevent_ops block_ueve
 };
 
 /* declare block_subsys. */
-static decl_subsys(block, &ktype_block, &block_uevent_ops);
+decl_subsys(block, &ktype_block, &block_uevent_ops);
 
+EXPORT_SYMBOL(block_subsys);
+EXPORT_SYMBOL(block_subsys_sem);
 
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs




----------------------------------------------------------------------
Tysiace zdjec swietnych samochodow! >>> http://link.interia.pl/f1944

