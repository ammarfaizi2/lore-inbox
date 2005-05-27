Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVE0HFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVE0HFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVE0HFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:05:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:54407 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261914AbVE0G6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:58:52 -0400
Subject: [PATCH] EXPERIMENTAL: global suspend cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 27 May 2005 16:57:34 +1000
Message-Id: <1117177055.9076.191.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

(This is not to be merged upstream or anywhere else yet)

This patch applies on top of my previous ones. It moves all of the
PowerMac PM code away from drivers/macintosh/via-pmu.c to a new
arch/ppc/platforms/pmac_pm.c file, and "merges" the code for supporting
suspend to RAM and suspend to disk in a more consistent way. It also
fixes issues with suspend to disk. Currently, the refrigerator is still
used for suspend to RAM _and_ suspend to disk, I may consider keeping it
if it gets fast & reliable enough in 2.6.13 as it does work around
issues with misbehaved userland processes vs. kernel driver races,
though i'd rather have the kernel fixed :)

Note to linux-pm citizens: This merges the pmac PM code into the "core"
PM infrastructure. In order to do that properly, I had to add a
significant amount of callbacks to pm_ops, in fact, I need basically a
hook between every step for various reasons. There is also some
significant discrepancy between the hooks used by "generic" stuffs and
the ones used by swsusp. The later doesn't call all the normal hooks in
all cases but then has it's own support functions
(arch_prepare_suspend(), save/restore_cpu_state()) that are not in
pm_ops... this is rather a mess, though I got it all together for pmac.

Please comment on those changes.

I also fixed what I think is a possible bug in device_suspend() if it
fails, it can leave some stuffs in the dpm_irq_off list forever.

I've also had to remove the sysdev I used for the interrupt controllers.
I have an ordering problems here. I absolutely need the interrupt
controller suspend code to be run after cpufreq and the resume one
before cpufreq, which is simply not possible right now with a sysdev
(unless I hook on the cpu class itself suspend/resume routines but
that's ugly). cpufreq is a driver of class cpu, which is first
registered, and thus is always the first in the list.

For now, the PIC suspend/resume code is back into arch specific realm.

I'm still having some problems with the refrigerator. It tends to
regulary fail to freeze pmud for some reason I haven't yet explained. I
need to add more debugging to it. But I may not bother if Nigel's new
implementation gets in 2.6.13.

I did some tests of both suspend to ram and to disk on an old tipb model
and it appears to work fine, but I haven't stressed it nor tested on any
other machine yet.

Note that with this patch, you can use echo "mem" /sys/power/state to
trigger suspend-to-RAM. The old ioctl on /dev/pmu still works, and will
trigger suspend-to-RAM on machiens where it's supported and will
fallback to suspend-to-disk when not.

Index: linux-work/arch/ppc/platforms/Makefile
===================================================================
--- linux-work.orig/arch/ppc/platforms/Makefile	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/arch/ppc/platforms/Makefile	2005-05-27 16:07:24.000000000 +1000
@@ -10,8 +10,9 @@
 obj-$(CONFIG_PCI)		+= apus_pci.o
 endif
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
-					pmac_feature.o pmac_pci.o pmac_sleep.o \
-					pmac_low_i2c.o pmac_cache.o
+				   pmac_feature.o pmac_pci.o pmac_sleep.o \
+				   pmac_low_i2c.o pmac_cache.o pmac_pm.o
+
 obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o \
 					chrp_pegasos_eth.o
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
Index: linux-work/arch/ppc/platforms/pmac_pm.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc/platforms/pmac_pm.c	2005-05-27 16:07:24.000000000 +1000
@@ -0,0 +1,782 @@
+/*
+ * PowerMac Power Management core
+ *
+ * Copyright (C) 2005 Benjamin Herrenschmidt, IBM Corp.
+ *
+ * Bits from drivers/macintosh/via-pmu.c
+ *
+ * Copyright (C) 1998 Paul Mackerras and Fabio Riccardi.
+ * Copyright (C) 2001-2002 Benjamin Herrenschmidt
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/pm.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/sysdev.h>
+#include <linux/suspend.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/syscalls.h>
+#include <linux/reboot.h>
+
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/irq.h>
+#include <asm/pmac_feature.h>
+#include <asm/mmu_context.h>
+#include <asm/cputable.h>
+#include <asm/time.h>
+#include <asm/sections.h>
+#include <asm/system.h>
+#include <asm/open_pic.h>
+
+#ifdef CONFIG_PM_DEBUG
+#define DBG(fmt...) printk(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+/* debugging */
+int __fake_sleep;
+
+/* lid wakeup control (fixme) */
+int pmac_option_lid_wakeup __pmacdata;
+EXPORT_SYMBOL_GPL(pmac_option_lid_wakeup);
+
+/* main callback for suspend to RAM */
+static int (*pmac_pm_low_suspend)(void) __pmacdata;
+
+/* assembly stuff */
+extern void low_sleep_handler(void);
+/* pmac_pic stuff */
+extern void pmacpic_suspend(void);
+extern void pmacpic_resume(void);
+
+
+/*************************************************************************
+ *
+ * Here is the "old style" PowerMac PM notifiers. They are still used by a
+ * couple of drivers that haven't yet been fitted in the device model.
+ * They will ultimately be deprecated.
+ *
+ *************************************************************************/
+
+static LIST_HEAD(sleep_notifiers);
+
+int __pmac pmu_register_sleep_notifier(struct pmu_sleep_notifier *n)
+{
+	struct list_head *list;
+	struct pmu_sleep_notifier *notifier;
+
+	for (list = sleep_notifiers.next; list != &sleep_notifiers;
+	     list = list->next) {
+		notifier = list_entry(list, struct pmu_sleep_notifier, list);
+		if (n->priority > notifier->priority)
+			break;
+	}
+	__list_add(&n->list, list->prev, list);
+	return 0;
+}
+EXPORT_SYMBOL(pmu_register_sleep_notifier);
+
+int __pmac pmu_unregister_sleep_notifier(struct pmu_sleep_notifier* n)
+{
+	if (n->list.next == 0)
+		return -ENOENT;
+	list_del(&n->list);
+	n->list.next = NULL;
+	return 0;
+}
+EXPORT_SYMBOL(pmu_unregister_sleep_notifier);
+
+/* Sleep is broadcast last-to-first */
+static int __pmac broadcast_sleep(int when, int fallback)
+{
+	int ret = PBOOK_SLEEP_OK;
+	struct list_head *list;
+	struct pmu_sleep_notifier *notifier;
+
+	for (list = sleep_notifiers.prev; list != &sleep_notifiers;
+	     list = list->prev) {
+		notifier = list_entry(list, struct pmu_sleep_notifier, list);
+		ret = notifier->notifier_call(notifier, when);
+		if (ret != PBOOK_SLEEP_OK) {
+			DBG("sleep %d rejected by %p (%p)\n",
+			    when, notifier, notifier->notifier_call);
+			for (; list != &sleep_notifiers; list = list->next) {
+				notifier = list_entry(list,
+					      struct pmu_sleep_notifier, list);
+				notifier->notifier_call(notifier, fallback);
+			}
+			return ret;
+		}
+	}
+	return ret;
+}
+
+/* Wake is broadcast first-to-last */
+static int __pmac broadcast_wake(void)
+{
+	int ret = PBOOK_SLEEP_OK;
+	struct list_head *list;
+	struct pmu_sleep_notifier *notifier;
+
+	for (list = sleep_notifiers.next; list != &sleep_notifiers;
+	     list = list->next) {
+		notifier = list_entry(list, struct pmu_sleep_notifier, list);
+		notifier->notifier_call(notifier, PBOOK_WAKE);
+	}
+	return ret;
+}
+
+/**************************************************************************
+ *
+ * Here, we have code to save/restore PCI config space. Most of that code
+ * should be removed once we are confident with the generic code, including
+ * with P2P bridges
+ *
+ **************************************************************************/
+
+static struct pci_save {
+	u16	command;
+	u16	cache_lat;
+	u16	intr;
+	u32	bars[6];
+	u32	rom_address;
+} *pbook_pci_saves __pmacdata;
+static int pbook_npci_saves __pmacdata;
+
+static void __pmac pbook_alloc_pci_save(void)
+{
+	int npci;
+	struct pci_dev *pd = NULL;
+
+	npci = 0;
+	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+		++npci;
+	}
+	if (npci == 0)
+		return;
+	pbook_pci_saves = (struct pci_save *)
+		kmalloc(npci * sizeof(struct pci_save), GFP_KERNEL);
+	pbook_npci_saves = npci;
+}
+
+static void __pmac pbook_free_pci_save(void)
+{
+	if (pbook_pci_saves == NULL)
+		return;
+	kfree(pbook_pci_saves);
+	pbook_pci_saves = NULL;
+	pbook_npci_saves = 0;
+}
+
+static void __pmac pbook_pci_save(void)
+{
+	struct pci_save *ps = pbook_pci_saves;
+	struct pci_dev *pd = NULL;
+	int npci = pbook_npci_saves;
+	int i;
+
+	if (ps == NULL)
+		return;
+
+	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+		if (npci-- == 0)
+			return;
+		switch (pd->hdr_type) {
+		case PCI_HEADER_TYPE_NORMAL:
+			pci_read_config_word(pd, PCI_COMMAND, &ps->command);
+			pci_read_config_word(pd, PCI_CACHE_LINE_SIZE,
+					     &ps->cache_lat);
+			pci_read_config_word(pd, PCI_INTERRUPT_LINE,
+					     &ps->intr);
+			pci_read_config_dword(pd, PCI_ROM_ADDRESS,
+					      &ps->rom_address);
+			for (i=0; i<6; i++)
+				pci_read_config_dword(pd,
+						      PCI_BASE_ADDRESS_0+i*4,
+						      &ps->bars[i]);
+			break;
+		case PCI_HEADER_TYPE_BRIDGE:
+			pci_read_config_word(pd, PCI_COMMAND, &ps->command);
+			pci_read_config_word(pd, PCI_CACHE_LINE_SIZE,
+					     &ps->cache_lat);
+			pci_read_config_dword(pd, PCI_ROM_ADDRESS1,
+					      &ps->rom_address);
+			pci_read_config_dword(pd, PCI_BASE_ADDRESS_0,
+					      &ps->bars[0]);
+			pci_read_config_dword(pd, PCI_BASE_ADDRESS_1,
+					      &ps->bars[1]);
+			break;
+		case PCI_HEADER_TYPE_CARDBUS:
+			pci_read_config_word(pd, PCI_COMMAND, &ps->command);
+			pci_read_config_word(pd, PCI_CACHE_LINE_SIZE,
+					     &ps->cache_lat);
+			pci_read_config_word(pd, PCI_INTERRUPT_LINE,
+					     &ps->intr);
+			pci_read_config_dword(pd, PCI_BASE_ADDRESS_0,
+					      &ps->bars[0]);
+			break;
+		}			
+		++ps;
+	}
+}
+
+/* For this to work, we must take care of a few things: If gmac was enabled
+ * during boot, it will be in the pci dev list. If it's disabled at this point
+ * (and it will probably be), then you can't access it's config space.
+ */
+static void __pmac pbook_pci_restore(void)
+{
+	u16 cmd;
+	struct pci_save *ps = pbook_pci_saves - 1;
+	struct pci_dev *pd = NULL;
+	int npci = pbook_npci_saves;
+	int i;
+
+	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+		if (npci-- == 0)
+			return;
+		ps++;
+		if (ps->command == 0)
+			continue;
+		pci_read_config_word(pd, PCI_COMMAND, &cmd);
+		if ((ps->command & ~cmd) == 0)
+			continue;
+		switch (pd->hdr_type) {
+		case PCI_HEADER_TYPE_NORMAL:
+			for (i = 0; i < 6; ++i)
+				pci_write_config_dword(pd,
+						       PCI_BASE_ADDRESS_0+i*4,
+						       ps->bars[i]);
+			pci_write_config_dword(pd, PCI_ROM_ADDRESS,
+					       ps->rom_address);
+			pci_write_config_word(pd, PCI_CACHE_LINE_SIZE,
+					      ps->cache_lat);
+			pci_write_config_word(pd, PCI_INTERRUPT_LINE,
+					      ps->intr);
+			pci_write_config_word(pd, PCI_COMMAND, ps->command);
+			break;
+		case PCI_HEADER_TYPE_BRIDGE:
+			pci_write_config_dword(pd, PCI_BASE_ADDRESS_0,
+					       ps->bars[0]);
+			pci_write_config_dword(pd, PCI_BASE_ADDRESS_1,
+					       ps->bars[1]);
+			pci_write_config_dword(pd, PCI_ROM_ADDRESS,
+					       ps->rom_address);
+			pci_write_config_word(pd, PCI_CACHE_LINE_SIZE,
+					      ps->cache_lat);
+			pci_write_config_word(pd, PCI_COMMAND, ps->command);
+			break;
+		case PCI_HEADER_TYPE_CARDBUS:
+			pci_write_config_dword(pd, PCI_BASE_ADDRESS_0, 
+					       ps->bars[0]);
+			pci_write_config_word(pd, PCI_CACHE_LINE_SIZE,
+					      ps->cache_lat);
+			pci_write_config_word(pd, PCI_INTERRUPT_LINE,
+					      ps->intr);
+			pci_write_config_word(pd, PCI_COMMAND, ps->command);
+			break;
+		}
+	}
+}
+
+/*************************************************************************
+ *
+ * Here are the per-machine family low level sleep routines and the
+ * par-machine family initialization routines.
+ *
+ *************************************************************************/
+
+
+#define PB3400_MEM_CTRL		0xf8000000
+#define PB3400_MEM_CTRL_SLEEP	0x70
+
+static void __iomem *mem_ctrl_3400 __pmacdata;
+
+static int __pmac pmac_pm_sleep_3400(void)
+{
+	int i, x;
+	unsigned int hid0;
+	unsigned long p;
+	struct adb_request sleep_req;
+	unsigned int __iomem *mem_ctrl_sleep;
+
+	mem_ctrl_sleep = mem_ctrl_3400 + PB3400_MEM_CTRL_SLEEP;
+
+	/* Set the memory controller to keep the memory refreshed
+	   while we're asleep */
+	for (i = 0x403f; i >= 0x4000; --i) {
+		out_be32(mem_ctrl_sleep, i);
+		do {
+			x = (in_be32(mem_ctrl_sleep) >> 16) & 0x3ff;
+		} while (x == 0);
+		if (x >= 0x100)
+			break;
+	}
+
+	/* Ask the PMU to put us to sleep */
+	pmu_request(&sleep_req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
+	while (!sleep_req.complete)
+		mb();
+
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
+
+	/* displacement-flush the L2 cache - necessary? */
+	for (p = KERNELBASE; p < KERNELBASE + 0x100000; p += 0x1000)
+		i = *(volatile int *)p;
+
+	/* Put the CPU into sleep mode */
+	asm volatile("mfspr %0,1008" : "=r" (hid0) :);
+	hid0 = (hid0 & ~(HID0_NAP | HID0_DOZE)) | HID0_SLEEP;
+	asm volatile("mtspr 1008,%0" : : "r" (hid0));
+	_nmask_and_or_msr(0, MSR_POW | MSR_EE);
+	udelay(10);
+
+	/* OK, we're awake again, start restoring things */
+	out_be32(mem_ctrl_sleep, 0x3f);
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
+	pbook_pci_restore();
+	pmu_unlock();
+
+	mdelay(10);
+
+	return 0;
+}
+
+static void __pmac pmac_pm_init_3400(void)
+{
+	/* first map in the memory controller registers */
+	mem_ctrl_3400 = ioremap(PB3400_MEM_CTRL, 0x100);
+	if (mem_ctrl_3400 == NULL) {
+		printk(KERN_ERR "pmac_pm_init_3400: ioremap failed\n");
+		return;
+	}
+
+	pmac_pm_low_suspend = pmac_pm_sleep_3400;
+}
+
+#define	GRACKLE_PM	(1<<7)
+#define GRACKLE_DOZE	(1<<5)
+#define	GRACKLE_NAP	(1<<4)
+#define	GRACKLE_SLEEP	(1<<3)
+
+static struct pci_dev *grackle __pmacdata;
+
+static int __pmac pmac_pm_sleep_grackle(void)
+{
+	unsigned long save_l2cr;
+	unsigned short pmcr1;
+	struct adb_request req;
+
+	/* Turn off various things. Darwin does some retry tests here... */
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0,
+		    PMU_POW0_OFF | PMU_POW0_HARD_DRIVE);
+	pmu_wait_complete(&req);
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
+		    PMU_POW_OFF | PMU_POW_BACKLIGHT |
+		    PMU_POW_IRLED | PMU_POW_MEDIABAY);
+	pmu_wait_complete(&req);
+
+	/* For 750, save backside cache setting and disable it */
+	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
+
+	if (!__fake_sleep) {
+		/* Ask the PMU to put us to sleep */
+		pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
+		pmu_wait_complete(&req);
+	}
+
+	/* The VIA is supposed not to be restored correctly*/
+	pmu_save_via_state();
+
+	/* We shut down some HW */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
+
+	pci_read_config_word(grackle, 0x70, &pmcr1);
+	/* Apparently, MacOS uses NAP mode for Grackle ??? */
+	pmcr1 &= ~(GRACKLE_DOZE|GRACKLE_SLEEP); 
+	pmcr1 |= GRACKLE_PM|GRACKLE_NAP;
+	pci_write_config_word(grackle, 0x70, pmcr1);
+
+	/* Call low-level ASM sleep handler */
+	if (__fake_sleep)
+		mdelay(5000);
+	else
+		low_sleep_handler();
+
+	/* We're awake again, stop grackle PM */
+	pci_read_config_word(grackle, 0x70, &pmcr1);
+	pmcr1 &= ~(GRACKLE_PM|GRACKLE_DOZE|GRACKLE_SLEEP|GRACKLE_NAP); 
+	pci_write_config_word(grackle, 0x70, pmcr1);
+
+	/* Make sure the PMU is idle */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
+	pmu_restore_via_state();
+	
+	/* Restore L2 cache */
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
+ 		_set_L2CR(save_l2cr);
+	
+	/* Power things up */
+	pmu_unlock();
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0,
+			PMU_POW0_ON | PMU_POW0_HARD_DRIVE);
+	pmu_wait_complete(&req);
+	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
+		    PMU_POW_ON | PMU_POW_BACKLIGHT | PMU_POW_CHARGER |
+		    PMU_POW_IRLED | PMU_POW_MEDIABAY);
+	pmu_wait_complete(&req);
+
+	return 0;
+}
+
+static void __pmac pmac_pm_init_grackle(void)
+{
+	grackle = pci_find_slot(0, 0);
+	if (!grackle)
+		return;
+
+	pmac_pm_low_suspend = pmac_pm_sleep_grackle;
+}
+
+
+static int __pmac pmac_pm_sleep_core99(void)
+{
+	unsigned long save_l2cr;
+	unsigned long save_l3cr;
+	struct adb_request req;
+	
+	/* Tell PMU what events will wake us up */
+	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_CLR_WAKEUP_EVENTS,
+		0xff, 0xff);
+	pmu_wait_complete(&req);
+	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_SET_WAKEUP_EVENTS,
+		0, PMU_PWR_WAKEUP_KEY |
+		(pmac_option_lid_wakeup ? PMU_PWR_WAKEUP_LID_OPEN : 0));
+	pmu_wait_complete(&req);
+
+	/* Save the state of the L2 and L3 caches */
+	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
+	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
+
+	if (!__fake_sleep) {
+		/* Ask the PMU to put us to sleep */
+		pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
+		pmu_wait_complete(&req);
+	}
+
+	/* The VIA is supposed not to be restored correctly*/
+	pmu_save_via_state();
+
+	/* Shut down various ASICs. There's a chance that we can no longer
+	 * talk to the PMU after this, so I moved it to _after_ sending the
+	 * sleep command to it. Still need to be checked.
+	 */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
+
+	/* Call low-level ASM sleep handler */
+	if (__fake_sleep)
+		mdelay(5000);
+	else
+		low_sleep_handler();
+
+	/* Restore Apple core ASICs state */
+	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
+
+	/* Restore VIA */
+	pmu_restore_via_state();
+
+	/* Restore video */
+	pmac_call_early_video_resume();
+
+	/* Restore L2 cache */
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
+ 		_set_L2CR(save_l2cr);
+	/* Restore L3 cache */
+	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
+ 		_set_L3CR(save_l3cr);
+	
+	/* Tell PMU we are ready */
+	pmu_unlock();
+	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
+	pmu_wait_complete(&req);
+
+	return 0;
+}
+
+static void __pmac pmac_pm_init_core99(void)
+{
+	pmac_pm_low_suspend = pmac_pm_sleep_core99;
+}
+
+
+
+/*************************************************************************
+ *
+ * Here are the callbacks interfacing with the common code.
+ *
+ *************************************************************************/
+
+static inline void wakeup_decrementer(void)
+{
+	set_dec(tb_ticks_per_jiffy);
+	/* No currently-supported powerbook has a 601,
+	 * so use get_tbl, not native
+	 */
+	last_jiffy_stamp(0) = tb_last_stamp = get_tbl();
+}
+
+static int __pmac pmac_pm_pre_freeze(suspend_state_t state)
+{
+	int ret;
+
+	DBG("%s(%d)\n", __FUNCTION__, state);
+
+	/* Check if suspend to RAM is possible */
+	if (state == PM_SUSPEND_MEM) {
+		if (pmac_pm_low_suspend == NULL)
+			return -EINVAL;
+		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
+			return -EINVAL;
+		if (num_online_cpus() > 1 || cpu_is_offline(0))
+			return -EAGAIN;
+	}
+
+	DBG("Notify (1) old style drivers...\n");
+
+	/* Notify old-style device drivers & userland */
+	ret = broadcast_sleep(PBOOK_SLEEP_REQUEST, PBOOK_SLEEP_REJECT);
+	if (ret != PBOOK_SLEEP_OK) {
+		printk(KERN_ERR "Sleep rejected by drivers\n");
+		return -EBUSY;
+	}
+
+	/* Sync the disks. */
+
+	/* XXX It would be nice to have some way to ensure that
+	 * nobody is dirtying any new buffers while we wait. That
+	 * could be achieved using the refrigerator for processes
+	 * that swsusp uses
+	 */
+	DBG("Sync disks...\n");
+	sys_sync();
+
+	//	return (state == PM_SUSPEND_DISK);
+	return 1;
+}
+
+static int __pmac pmac_pm_prepare(suspend_state_t state)
+{
+	int ret;
+
+	DBG("%s(%d)\n", __FUNCTION__, state);
+
+
+	/* Sleep can fail now. May not be very robust but useful for
+	 * debugging
+	 */
+	DBG("Notify (2) old style drivers...\n");
+	ret = broadcast_sleep(PBOOK_SLEEP_NOW, PBOOK_WAKE);
+	if (ret != PBOOK_SLEEP_OK) {
+		printk(KERN_ERR "Driver sleep failed\n");
+		return -EBUSY;
+	}
+
+	/* Allocate room for PCI save */
+	DBG("Alloc PCI stuffs...\n");
+	pbook_alloc_pci_save();
+
+	return 0;
+}
+
+static int __pmac pmac_pm_prepare_irqs(suspend_state_t state)
+{
+	DBG("%s(%d)\n", __FUNCTION__, state);
+
+	/* That state only applies to suspend to RAM */
+	if (state != PM_SUSPEND_MEM)
+		return 0;
+
+	/* Stop interrupts on openpic */
+	if (pmu_get_model() == PMU_KEYLARGO_BASED)
+		openpic_set_priority(0xf);
+
+	/* Stop preemption */
+	preempt_disable();
+
+	/* Disable clock spreading on some machines */
+	pmac_tweak_clock_spreading(0);
+
+	/* Make sure the decrementer won't interrupt us */
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+	/* Make sure any pending DEC interrupt occurring while we did
+	 * the above didn't re-enable the DEC */
+	mb();
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+
+	/* We disable interrupts now and not in the generic code so
+	 * that we entre pmac_pm_finish_irqs() with interrupts still
+	 * off and can properly wakeup decrementer before enabling them.
+	 */
+	local_irq_disable();
+
+	return 0;
+}
+
+static void __pmac pmac_pm_pre_suspend(void)
+{
+	DBG("%s\n", __FUNCTION__);
+
+	/* Save the state of PCI config space for some slots */
+	pbook_pci_save();
+
+	/* Suspend openpic */
+	if (pmu_get_model() == PMU_KEYLARGO_BASED)
+		openpic_suspend();
+	else
+		pmacpic_suspend();
+
+	/* Giveup the lazy FPU & vec so we don't have to back them
+	 * up from the low level code
+	 */
+	enable_kernel_fp();
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif /* CONFIG_ALTIVEC */
+}
+
+static void __pmac pmac_pm_post_suspend(void)
+{
+	DBG("%s\n", __FUNCTION__);
+
+	/* Restore the state of PCI config space for some slots */
+	pbook_pci_restore();
+
+	/* Resume openpic */
+	if (pmu_get_model() == PMU_KEYLARGO_BASED)
+		openpic_resume();
+	else
+		pmacpic_resume();
+
+	/* Restore userland MMU context */
+	set_context(current->active_mm->context, current->active_mm->pgd);
+}
+
+static int __pmac pmac_pm_enter(suspend_state_t state)
+{
+	int rc = 0;
+
+	DBG("%s(%d)\n", __FUNCTION__, state);
+
+	if (state == PM_SUSPEND_MEM) {
+		pmac_pm_pre_suspend();
+		rc = pmac_pm_low_suspend();
+		pmac_pm_post_suspend();
+		
+	} else if (state == PM_SUSPEND_DISK) {
+		device_shutdown();
+		machine_restart(NULL);
+	} else
+		rc = -EINVAL;
+	return rc;
+}
+
+static void __pmac pmac_pm_finish_irqs(suspend_state_t state)
+{
+	DBG("%s(%d)\n", __FUNCTION__, state);
+
+	/* That state only applies to suspend to RAM */
+	if (state != PM_SUSPEND_MEM)
+		return;
+
+	/* Restart jiffies & scheduling */
+	wakeup_decrementer();
+
+	/* Start interrupts on openpic */
+	if (pmu_get_model() == PMU_KEYLARGO_BASED)
+		openpic_set_priority(0);
+
+	/* Re-enable local CPU interrupts */
+	local_irq_enable();
+	mdelay(10);
+	preempt_enable();
+
+	/* Re-enable clock spreading on some machines */
+	pmac_tweak_clock_spreading(1);
+}
+
+static void __pmac pmac_pm_finish(suspend_state_t state)
+{
+	DBG("%s(%d)\n", __FUNCTION__, state);
+
+	/* Free PCI save block */
+	pbook_free_pci_save();
+
+}
+
+static void __pmac pmac_pm_post_freeze(suspend_state_t state)
+{
+	DBG("%s(%d)\n", __FUNCTION__, state);
+
+	/* Broadcase old style wakeup */
+	broadcast_wake();
+}
+
+static struct pm_ops pmac_pm_ops  __pmacdata = {
+	.pm_disk_mode	= PM_DISK_PLATFORM,
+	.pre_freeze	= pmac_pm_pre_freeze,
+	.prepare	= pmac_pm_prepare,
+	.prepare_irqs	= pmac_pm_prepare_irqs,
+	.enter		= pmac_pm_enter,
+	.finish_irqs	= pmac_pm_finish_irqs,
+	.finish		= pmac_pm_finish,
+	.post_freeze	= pmac_pm_post_freeze,
+};
+
+static int pmac_pm_init(void)
+{
+	if (_machine != _MACH_Pmac)
+		return 0;
+
+	switch (pmu_get_model()) {
+	case PMU_OHARE_BASED:
+		pmac_pm_init_3400();
+		break;
+	case PMU_HEATHROW_BASED:
+	case PMU_PADDINGTON_BASED:
+		pmac_pm_init_grackle();
+		break;
+	case PMU_KEYLARGO_BASED:
+		pmac_pm_init_core99();
+		break;
+	}
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	ppc_md.save_processor_state = pmac_pm_pre_suspend;
+	ppc_md.restore_processor_state = pmac_pm_post_suspend;
+#endif
+
+	pm_set_ops(&pmac_pm_ops);
+
+	return 0;
+}
+
+late_initcall(pmac_pm_init);
Index: linux-work/arch/ppc/platforms/pmac_setup.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_setup.c	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_setup.c	2005-05-27 16:07:24.000000000 +1000
@@ -423,68 +423,6 @@
 #endif
 }
 
-static int initializing = 1;
-/* TODO: Merge the suspend-to-ram with the common code !!!
- * currently, this is a stub implementation for suspend-to-disk
- * only
- */
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-
-static int pmac_pm_prepare(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	return 0;
-}
-
-static int pmac_pm_enter(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	/* Giveup the lazy FPU & vec so we don't have to back them
-	 * up from the low level code
-	 */
-	enable_kernel_fp();
-
-#ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
-		enable_kernel_altivec();
-#endif /* CONFIG_ALTIVEC */
-
-	return 0;
-}
-
-static int pmac_pm_finish(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
-
-	return 0;
-}
-
-static struct pm_ops pmac_pm_ops = {
-	.pm_disk_mode	= PM_DISK_SHUTDOWN,
-	.prepare	= pmac_pm_prepare,
-	.enter		= pmac_pm_enter,
-	.finish		= pmac_pm_finish,
-};
-
-#endif /* CONFIG_SOFTWARE_SUSPEND */
-
-static int pmac_late_init(void)
-{
-	initializing = 0;
-#ifdef CONFIG_SOFTWARE_SUSPEND
-	pm_set_ops(&pmac_pm_ops);
-#endif /* CONFIG_SOFTWARE_SUSPEND */
-	return 0;
-}
-
-late_initcall(pmac_late_init);
-
 /* can't be __init - can be called whenever a disk is first accessed */
 void __pmac
 note_bootable_part(dev_t dev, int part, int goodness)
@@ -492,7 +430,7 @@
 	static int found_boot = 0;
 	char *p;
 
-	if (!initializing)
+	if (system_state != SYSTEM_BOOTING)
 		return;
 	if ((goodness <= current_root_goodness) &&
 	    ROOT_DEV != DEFAULT_ROOT_DEVICE)
Index: linux-work/drivers/base/power/suspend.c
===================================================================
--- linux-work.orig/drivers/base/power/suspend.c	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/drivers/base/power/suspend.c	2005-05-27 16:07:24.000000000 +1000
@@ -100,8 +100,19 @@
 		put_device(dev);
 	}
 	up(&dpm_list_sem);
-	if (error)
+	if (error) {
+		/* we failed... before resuming, bring back devices from
+		 * dpm_off_irq list back to main dpm_off list, we do want
+		 * to call resume() on them, in case they partially suspended
+		 * despite returning -EAGAIN
+		 */
+		while (!list_empty(&dpm_off_irq)) {
+			struct list_head * entry = dpm_off_irq.next;
+			list_del(entry);
+			list_add(entry, &dpm_off);
+		}
 		dpm_resume();
+	}
 	up(&dpm_sem);
 	return error;
 }
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu.c	2005-05-27 16:42:57.000000000 +1000
@@ -14,10 +14,7 @@
  * THIS DRIVER IS BECOMING A TOTAL MESS !
  *  - Cleanup atomically disabling reply to PMU events after
  *    a sleep or a freq. switch
- *  - Move sleep code out of here to pmac_pm, merge into new
- *    common PM infrastructure
  *  - Move backlight code out as well
- *  - Save/Restore PCI space properly
  *
  */
 #include <stdarg.h>
@@ -45,8 +42,6 @@
 #include <linux/device.h>
 #include <linux/sysdev.h>
 #include <linux/suspend.h>
-#include <linux/syscalls.h>
-#include <linux/cpu.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -54,11 +49,11 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/irq.h>
-#include <asm/pmac_feature.h>
 #include <asm/uaccess.h>
-#include <asm/mmu_context.h>
 #include <asm/cputable.h>
 #include <asm/time.h>
+#include <asm/pmac_feature.h>
+
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
@@ -70,7 +65,6 @@
 /* Some compile options */
 #undef SUSPEND_USES_PMU
 #define DEBUG_SLEEP
-#undef HACKED_PCI_SAVE
 
 /* Misc minor number allocated for /dev/pmu */
 #define PMU_MINOR		154
@@ -155,12 +149,12 @@
 static u8 pmu_intr_mask;
 static int pmu_version;
 static int drop_interrupts;
-#ifdef CONFIG_PMAC_PBOOK
-static int option_lid_wakeup = 1;
-static int sleep_in_progress;
-#endif /* CONFIG_PMAC_PBOOK */
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
+static int pmu_sys_suspended = 0;
+
+/* from pmac_pm ... */
+extern int pmac_option_lid_wakeup;
 
 static struct proc_dir_entry *proc_pmu_root;
 static struct proc_dir_entry *proc_pmu_info;
@@ -168,7 +162,6 @@
 static struct proc_dir_entry *proc_pmu_options;
 static int option_server_mode;
 
-#ifdef CONFIG_PMAC_PBOOK
 int pmu_battery_count;
 int pmu_cur_battery;
 unsigned int pmu_power_flags;
@@ -176,14 +169,11 @@
 static int query_batt_timer = BATTERY_POLLING_COUNT;
 static struct adb_request batt_req;
 static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
-#endif /* CONFIG_PMAC_PBOOK */
 
 #if defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT)
 extern int disable_kernel_backlight;
 #endif /* defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT) */
 
-int __fake_sleep;
-int asleep;
 struct notifier_block *sleep_notifier_list;
 
 #ifdef CONFIG_ADB
@@ -210,11 +200,9 @@
 static int pmu_set_backlight_level(int level, void* data);
 static int pmu_set_backlight_enable(int on, int level, void* data);
 #endif /* CONFIG_PMAC_BACKLIGHT */
-#ifdef CONFIG_PMAC_PBOOK
 static void pmu_pass_intr(unsigned char *data, int len);
 static int proc_get_batt(char *page, char **start, off_t off,
 			int count, int *eof, void *data);
-#endif /* CONFIG_PMAC_PBOOK */
 static int proc_read_options(char *page, char **start, off_t off,
 			int count, int *eof, void *data);
 static int proc_write_options(struct file *file, const char __user *buffer,
@@ -232,10 +220,6 @@
 };
 #endif /* CONFIG_ADB */
 
-extern void low_sleep_handler(void);
-extern void enable_kernel_altivec(void);
-extern void enable_kernel_fp(void);
-
 #ifdef DEBUG_SLEEP
 int pmu_polled_request(struct adb_request *req);
 int pmu_wink(struct adb_request *req);
@@ -407,9 +391,7 @@
 
 	bright_req_1.complete = 1;
 	bright_req_2.complete = 1;
-#ifdef CONFIG_PMAC_PBOOK
 	batt_req.complete = 1;
-#endif
 
 #ifdef CONFIG_PPC32
 	if (pmu_kind == PMU_KEYLARGO_BASED)
@@ -468,7 +450,6 @@
 	register_backlight_controller(&pmu_backlight_controller, NULL, "pmu");
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-#ifdef CONFIG_PMAC_PBOOK
   	if (machine_is_compatible("AAPL,3400/2400") ||
   		machine_is_compatible("AAPL,3500")) {
 		int mb = pmac_call_feature(PMAC_FTR_GET_MB_INFO,
@@ -496,11 +477,9 @@
 				pmu_batteries[1].flags |= PMU_BATT_TYPE_SMART;
 		}
 	}
-#endif /* CONFIG_PMAC_PBOOK */
 	/* Create /proc/pmu */
 	proc_pmu_root = proc_mkdir("pmu", NULL);
 	if (proc_pmu_root) {
-#ifdef CONFIG_PMAC_PBOOK
 		int i;
 
 		for (i=0; i<pmu_battery_count; i++) {
@@ -509,7 +488,6 @@
 			proc_pmu_batt[i] = create_proc_read_entry(title, 0, proc_pmu_root,
 						proc_get_batt, (void *)i);
 		}
-#endif /* CONFIG_PMAC_PBOOK */
 
 		proc_pmu_info = create_proc_read_entry("info", 0, proc_pmu_root,
 					proc_get_info, NULL);
@@ -595,17 +573,6 @@
 	return pmu_kind;
 }
 
-#ifndef CONFIG_PPC64
-static inline void wakeup_decrementer(void)
-{
-	set_dec(tb_ticks_per_jiffy);
-	/* No currently-supported powerbook has a 601,
-	 * so use get_tbl, not native
-	 */
-	last_jiffy_stamp(0) = tb_last_stamp = get_tbl();
-}
-#endif
-
 static void pmu_set_server_mode(int server_mode)
 {
 	struct adb_request req;
@@ -629,7 +596,6 @@
 	pmu_wait_complete(&req);
 }
 
-#ifdef CONFIG_PMAC_PBOOK
 
 /* This new version of the code for 2400/3400/3500 powerbooks
  * is inspired from the implementation in gkrellm-pmu
@@ -803,6 +769,8 @@
 static void __pmac
 query_battery_state(void)
 {
+	if (pmu_sys_suspended)
+		return;
 	if (test_and_set_bit(0, &async_req_locks))
 		return;
 	if (pmu_kind == PMU_OHARE_BASED)
@@ -813,8 +781,6 @@
 			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
 }
 
-#endif /* CONFIG_PMAC_PBOOK */
-
 static int __pmac
 proc_get_info(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
@@ -823,11 +789,9 @@
 
 	p += sprintf(p, "PMU driver version     : %d\n", PMU_DRIVER_VERSION);
 	p += sprintf(p, "PMU firmware version   : %02x\n", pmu_version);
-#ifdef CONFIG_PMAC_PBOOK
 	p += sprintf(p, "AC Power               : %d\n",
 		((pmu_power_flags & PMU_PWR_AC_PRESENT) != 0));
 	p += sprintf(p, "Battery count          : %d\n", pmu_battery_count);
-#endif /* CONFIG_PMAC_PBOOK */
 
 	return p - page;
 }
@@ -859,7 +823,6 @@
 	return p - page;
 }
 
-#ifdef CONFIG_PMAC_PBOOK
 static int __pmac
 proc_get_batt(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
@@ -883,7 +846,6 @@
 
 	return p - page;
 }
-#endif /* CONFIG_PMAC_PBOOK */
 
 static int __pmac
 proc_read_options(char *page, char **start, off_t off,
@@ -891,11 +853,9 @@
 {
 	char *p = page;
 
-#ifdef CONFIG_PMAC_PBOOK
 	if (pmu_kind == PMU_KEYLARGO_BASED &&
 	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
-		p += sprintf(p, "lid_wakeup=%d\n", option_lid_wakeup);
-#endif /* CONFIG_PMAC_PBOOK */
+		p += sprintf(p, "lid_wakeup=%d\n", pmac_option_lid_wakeup);
 	if (pmu_kind == PMU_KEYLARGO_BASED)
 		p += sprintf(p, "server_mode=%d\n", option_server_mode);
 
@@ -932,12 +892,10 @@
 	*(val++) = 0;
 	while(*val == ' ')
 		val++;
-#ifdef CONFIG_PMAC_PBOOK
 	if (pmu_kind == PMU_KEYLARGO_BASED &&
 	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		if (!strcmp(label, "lid_wakeup"))
-			option_lid_wakeup = ((*val) == '1');
-#endif /* CONFIG_PMAC_PBOOK */
+			pmac_option_lid_wakeup = ((*val) == '1');
 	if (pmu_kind == PMU_KEYLARGO_BASED && !strcmp(label, "server_mode")) {
 		int new_value;
 		new_value = ((*val) == '1');
@@ -1344,7 +1302,6 @@
 	unsigned char ints, pirq;
 	int i = 0;
 
-	asleep = 0;
 	if (drop_interrupts || len < 1) {
 		adb_int_pending = 0;
 		pmu_irq_stats[8]++;
@@ -1432,7 +1389,6 @@
 	}
 	/* Tick interrupt */
 	else if ((1 << pirq) & PMU_INT_TICK) {
-#ifdef CONFIG_PMAC_PBOOK
 		/* Environement or tick interrupt, query batteries */
 		if (pmu_battery_count) {
 			if ((--query_batt_timer) == 0) {
@@ -1447,7 +1403,6 @@
 		pmu_pass_intr(data, len);
 	} else {
 	       pmu_pass_intr(data, len);
-#endif /* CONFIG_PMAC_PBOOK */
 	}
 	goto next;
 }
@@ -1692,6 +1647,8 @@
 	
 	if (vias == NULL)
 		return -ENODEV;
+	if (pmu_sys_suspended)
+		return -EIO;
 
 	if (on) {
 		pmu_request(&req, NULL, 2, PMU_BACKLIGHT_BRIGHT,
@@ -1719,6 +1676,8 @@
 {
 	if (vias == NULL)
 		return -ENODEV;
+	if (pmu_sys_suspended)
+		return -EIO;
 
 	if (test_and_set_bit(1, &async_req_locks))
 		return -EAGAIN;
@@ -2062,201 +2021,9 @@
 	return -1;
 }
 
-#ifdef CONFIG_PMAC_PBOOK
-
-static LIST_HEAD(sleep_notifiers);
-
-int
-pmu_register_sleep_notifier(struct pmu_sleep_notifier *n)
-{
-	struct list_head *list;
-	struct pmu_sleep_notifier *notifier;
-
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
-		if (n->priority > notifier->priority)
-			break;
-	}
-	__list_add(&n->list, list->prev, list);
-	return 0;
-}
-
-int
-pmu_unregister_sleep_notifier(struct pmu_sleep_notifier* n)
-{
-	if (n->list.next == 0)
-		return -ENOENT;
-	list_del(&n->list);
-	n->list.next = NULL;
-	return 0;
-}
-
-/* Sleep is broadcast last-to-first */
-static int __pmac
-broadcast_sleep(int when, int fallback)
-{
-	int ret = PBOOK_SLEEP_OK;
-	struct list_head *list;
-	struct pmu_sleep_notifier *notifier;
-
-	for (list = sleep_notifiers.prev; list != &sleep_notifiers;
-	     list = list->prev) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
-		ret = notifier->notifier_call(notifier, when);
-		if (ret != PBOOK_SLEEP_OK) {
-			printk(KERN_DEBUG "sleep %d rejected by %p (%p)\n",
-			       when, notifier, notifier->notifier_call);
-			for (; list != &sleep_notifiers; list = list->next) {
-				notifier = list_entry(list, struct pmu_sleep_notifier, list);
-				notifier->notifier_call(notifier, fallback);
-			}
-			return ret;
-		}
-	}
-	return ret;
-}
-
-/* Wake is broadcast first-to-last */
-static int __pmac
-broadcast_wake(void)
-{
-	int ret = PBOOK_SLEEP_OK;
-	struct list_head *list;
-	struct pmu_sleep_notifier *notifier;
-
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
-		notifier->notifier_call(notifier, PBOOK_WAKE);
-	}
-	return ret;
-}
-
-/*
- * This struct is used to store config register values for
- * PCI devices which may get powered off when we sleep.
- */
-static struct pci_save {
-#ifndef HACKED_PCI_SAVE
-	u16	command;
-	u16	cache_lat;
-	u16	intr;
-	u32	rom_address;
-#else
-	u32	config[16];
-#endif	
-} *pbook_pci_saves;
-static int pbook_npci_saves;
-
-static void __pmac
-pbook_alloc_pci_save(void)
-{
-	int npci;
-	struct pci_dev *pd = NULL;
-
-	npci = 0;
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-		++npci;
-	}
-	if (npci == 0)
-		return;
-	pbook_pci_saves = (struct pci_save *)
-		kmalloc(npci * sizeof(struct pci_save), GFP_KERNEL);
-	pbook_npci_saves = npci;
-}
-
-static void __pmac
-pbook_free_pci_save(void)
-{
-	if (pbook_pci_saves == NULL)
-		return;
-	kfree(pbook_pci_saves);
-	pbook_pci_saves = NULL;
-	pbook_npci_saves = 0;
-}
 
-static void __pmac
-pbook_pci_save(void)
-{
-	struct pci_save *ps = pbook_pci_saves;
-	struct pci_dev *pd = NULL;
-	int npci = pbook_npci_saves;
-	
-	if (ps == NULL)
-		return;
-
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-		if (npci-- == 0)
-			return;
-#ifndef HACKED_PCI_SAVE
-		pci_read_config_word(pd, PCI_COMMAND, &ps->command);
-		pci_read_config_word(pd, PCI_CACHE_LINE_SIZE, &ps->cache_lat);
-		pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
-		pci_read_config_dword(pd, PCI_ROM_ADDRESS, &ps->rom_address);
-#else
-		int i;
-		for (i=1;i<16;i++)
-			pci_read_config_dword(pd, i<<4, &ps->config[i]);
-#endif
-		++ps;
-	}
-}
-
-/* For this to work, we must take care of a few things: If gmac was enabled
- * during boot, it will be in the pci dev list. If it's disabled at this point
- * (and it will probably be), then you can't access it's config space.
- */
-static void __pmac
-pbook_pci_restore(void)
-{
-	u16 cmd;
-	struct pci_save *ps = pbook_pci_saves - 1;
-	struct pci_dev *pd = NULL;
-	int npci = pbook_npci_saves;
-	int j;
-
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-#ifdef HACKED_PCI_SAVE
-		int i;
-		if (npci-- == 0)
-			return;
-		ps++;
-		for (i=2;i<16;i++)
-			pci_write_config_dword(pd, i<<4, ps->config[i]);
-		pci_write_config_dword(pd, 4, ps->config[1]);
-#else
-		if (npci-- == 0)
-			return;
-		ps++;
-		if (ps->command == 0)
-			continue;
-		pci_read_config_word(pd, PCI_COMMAND, &cmd);
-		if ((ps->command & ~cmd) == 0)
-			continue;
-		switch (pd->hdr_type) {
-		case PCI_HEADER_TYPE_NORMAL:
-			for (j = 0; j < 6; ++j)
-				pci_write_config_dword(pd,
-					PCI_BASE_ADDRESS_0 + j*4,
-					pd->resource[j].start);
-			pci_write_config_dword(pd, PCI_ROM_ADDRESS,
-				ps->rom_address);
-			pci_write_config_word(pd, PCI_CACHE_LINE_SIZE,
-				ps->cache_lat);
-			pci_write_config_word(pd, PCI_INTERRUPT_LINE,
-				ps->intr);
-			pci_write_config_word(pd, PCI_COMMAND, ps->command);
-			break;
-		}
-#endif	
-	}
-}
-
-#ifdef DEBUG_SLEEP
 /* N.B. This doesn't work on the 3400 */
-void  __pmac
-pmu_blink(int n)
+void  __pmac pmu_blink(int n)
 {
 	struct adb_request req;
 
@@ -2288,7 +2055,6 @@
 	}
 	mdelay(50);
 }
-#endif
 
 /*
  * Put the powerbook to sleep.
@@ -2296,8 +2062,7 @@
  
 static u32 save_via[8] __pmacdata;
 
-static void __pmac
-save_via_state(void)
+void __pmac pmu_save_via_state(void)
 {
 	save_via[0] = in_8(&via[ANH]);
 	save_via[1] = in_8(&via[DIRA]);
@@ -2308,8 +2073,7 @@
 	save_via[6] = in_8(&via[T1CL]);
 	save_via[7] = in_8(&via[T1CH]);
 }
-static void __pmac
-restore_via_state(void)
+void __pmac pmu_restore_via_state(void)
 {
 	out_8(&via[ANH], save_via[0]);
 	out_8(&via[DIRA], save_via[1]);
@@ -2324,390 +2088,6 @@
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
 
-static int __pmac
-pmac_suspend_devices(void)
-{
-	int ret;
-
-	pm_prepare_console();
-	
-	/* Notify old-style device drivers & userland */
-	ret = broadcast_sleep(PBOOK_SLEEP_REQUEST, PBOOK_SLEEP_REJECT);
-	if (ret != PBOOK_SLEEP_OK) {
-		printk(KERN_ERR "Sleep rejected by drivers\n");
-		return -EBUSY;
-	}
-
-	/* Sync the disks. */
-	/* XXX It would be nice to have some way to ensure that
-	 * nobody is dirtying any new buffers while we wait. That
-	 * could be achieved using the refrigerator for processes
-	 * that swsusp uses
-	 */
-	sys_sync();
-
-	/* Sleep can fail now. May not be very robust but useful for debugging */
-	ret = broadcast_sleep(PBOOK_SLEEP_NOW, PBOOK_WAKE);
-	if (ret != PBOOK_SLEEP_OK) {
-		printk(KERN_ERR "Driver sleep failed\n");
-		return -EBUSY;
-	}
-
-	/* Send suspend call to devices, hold the device core's dpm_sem */
-	ret = device_suspend(PMSG_SUSPEND);
-	if (ret) {
-		broadcast_wake();
-		printk(KERN_ERR "Driver sleep failed\n");
-		return -EBUSY;
-	}
-
-	/* Disable clock spreading on some machines */
-	pmac_tweak_clock_spreading(0);
-
-	/* Stop preemption */
-	preempt_disable();
-
-	/* Make sure the decrementer won't interrupt us */
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	/* Make sure any pending DEC interrupt occurring while we did
-	 * the above didn't re-enable the DEC */
-	mb();
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-
-	/* We can now disable MSR_EE. This code of course works properly only
-	 * on UP machines... For SMP, if we ever implement sleep, we'll have to
-	 * stop the "other" CPUs way before we do all that stuff.
-	 */
-	local_irq_disable();
-
-	/* Broadcast power down irq
-	 * This isn't that useful in most cases (only directly wired devices can
-	 * use this but still... This will take care of sysdev's as well, so
-	 * we exit from here with local irqs disabled and PIC off.
-	 */
-	ret = device_power_down(PMSG_SUSPEND);
-	if (ret) {
-		wakeup_decrementer();
-		local_irq_enable();
-		preempt_enable();
-		device_resume();
-		broadcast_wake();
-		printk(KERN_ERR "Driver powerdown failed\n");
-		return -EBUSY;
-	}
-
-	/* Wait for completion of async backlight requests */
-	while (!bright_req_1.complete || !bright_req_2.complete ||
-			!batt_req.complete)
-		pmu_poll();
-
-	/* Giveup the lazy FPU & vec so we don't have to back them
-	 * up from the low level code
-	 */
-	enable_kernel_fp();
-
-#ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		enable_kernel_altivec();
-#endif /* CONFIG_ALTIVEC */
-
-	return 0;
-}
-
-static int __pmac
-pmac_wakeup_devices(void)
-{
-	mdelay(100);
-
-	/* Power back up system devices (including the PIC) */
-	device_power_up();
-
-	/* Force a poll of ADB interrupts */
-	adb_int_pending = 1;
-	via_pmu_interrupt(0, NULL, NULL);
-
-	/* Restart jiffies & scheduling */
-	wakeup_decrementer();
-
-	/* Re-enable local CPU interrupts */
-	local_irq_enable();
-	mdelay(10);
-	preempt_enable();
-
-	/* Re-enable clock spreading on some machines */
-	pmac_tweak_clock_spreading(1);
-
-	/* Resume devices */
-	device_resume();
-
-	/* Notify old style drivers */
-	broadcast_wake();
-
-	pm_restore_console();
-
-	return 0;
-}
-
-#define	GRACKLE_PM	(1<<7)
-#define GRACKLE_DOZE	(1<<5)
-#define	GRACKLE_NAP	(1<<4)
-#define	GRACKLE_SLEEP	(1<<3)
-
-int __pmac
-powerbook_sleep_grackle(void)
-{
-	unsigned long save_l2cr;
-	unsigned short pmcr1;
-	struct adb_request req;
-	int ret;
-	struct pci_dev *grackle;
-
-	grackle = pci_find_slot(0, 0);
-	if (!grackle)
-		return -ENODEV;
-
-	ret = pmac_suspend_devices();
-	if (ret) {
-		printk(KERN_ERR "Sleep rejected by devices\n");
-		return ret;
-	}
-	
-	/* Turn off various things. Darwin does some retry tests here... */
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0, PMU_POW0_OFF|PMU_POW0_HARD_DRIVE);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
-		PMU_POW_OFF|PMU_POW_BACKLIGHT|PMU_POW_IRLED|PMU_POW_MEDIABAY);
-	pmu_wait_complete(&req);
-
-	/* For 750, save backside cache setting and disable it */
-	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-
-	if (!__fake_sleep) {
-		/* Ask the PMU to put us to sleep */
-		pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
-		pmu_wait_complete(&req);
-	}
-
-	/* The VIA is supposed not to be restored correctly*/
-	save_via_state();
-	/* We shut down some HW */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
-
-	pci_read_config_word(grackle, 0x70, &pmcr1);
-	/* Apparently, MacOS uses NAP mode for Grackle ??? */
-	pmcr1 &= ~(GRACKLE_DOZE|GRACKLE_SLEEP); 
-	pmcr1 |= GRACKLE_PM|GRACKLE_NAP;
-	pci_write_config_word(grackle, 0x70, pmcr1);
-
-	/* Call low-level ASM sleep handler */
-	if (__fake_sleep)
-		mdelay(5000);
-	else
-		low_sleep_handler();
-
-	/* We're awake again, stop grackle PM */
-	pci_read_config_word(grackle, 0x70, &pmcr1);
-	pmcr1 &= ~(GRACKLE_PM|GRACKLE_DOZE|GRACKLE_SLEEP|GRACKLE_NAP); 
-	pci_write_config_word(grackle, 0x70, pmcr1);
-
-	/* Make sure the PMU is idle */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
-	restore_via_state();
-	
-	/* Restore L2 cache */
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
- 		_set_L2CR(save_l2cr);
-	
-	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
-
-	/* Power things up */
-	pmu_unlock();
-	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL0,
-			PMU_POW0_ON|PMU_POW0_HARD_DRIVE);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
-			PMU_POW_ON|PMU_POW_BACKLIGHT|PMU_POW_CHARGER|PMU_POW_IRLED|PMU_POW_MEDIABAY);
-	pmu_wait_complete(&req);
-
-	pmac_wakeup_devices();
-
-	return 0;
-}
-
-static int __pmac
-powerbook_sleep_Core99(void)
-{
-	unsigned long save_l2cr;
-	unsigned long save_l3cr;
-	struct adb_request req;
-	int ret;
-	
-	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0) {
-		printk(KERN_ERR "Sleep mode not supported on this machine\n");
-		return -ENOSYS;
-	}
-
-	if (num_online_cpus() > 1 || cpu_is_offline(0))
-		return -EAGAIN;
-
-	ret = pmac_suspend_devices();
-	if (ret) {
-		printk(KERN_ERR "Sleep rejected by devices\n");
-		return ret;
-	}
-
-	/* Stop environment and ADB interrupts */
-	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
-	pmu_wait_complete(&req);
-
-	/* Tell PMU what events will wake us up */
-	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_CLR_WAKEUP_EVENTS,
-		0xff, 0xff);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_SET_WAKEUP_EVENTS,
-		0, PMU_PWR_WAKEUP_KEY |
-		(option_lid_wakeup ? PMU_PWR_WAKEUP_LID_OPEN : 0));
-	pmu_wait_complete(&req);
-
-	/* Save the state of the L2 and L3 caches */
-	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
-	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
-
-	if (!__fake_sleep) {
-		/* Ask the PMU to put us to sleep */
-		pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
-		pmu_wait_complete(&req);
-	}
-
-	/* The VIA is supposed not to be restored correctly*/
-	save_via_state();
-
-	/* Shut down various ASICs. There's a chance that we can no longer
-	 * talk to the PMU after this, so I moved it to _after_ sending the
-	 * sleep command to it. Still need to be checked.
-	 */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 1);
-
-	/* Call low-level ASM sleep handler */
-	if (__fake_sleep)
-		mdelay(5000);
-	else
-		low_sleep_handler();
-
-	/* Restore Apple core ASICs state */
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE, NULL, 0, 0);
-
-	/* Restore VIA */
-	restore_via_state();
-
-	/* Restore video */
-	pmac_call_early_video_resume();
-
-	/* Restore L2 cache */
-	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
- 		_set_L2CR(save_l2cr);
-	/* Restore L3 cache */
-	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
- 		_set_L3CR(save_l3cr);
-	
-	/* Restore userland MMU context */
-	set_context(current->active_mm->context, current->active_mm->pgd);
-
-	/* Tell PMU we are ready */
-	pmu_unlock();
-	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
-	pmu_wait_complete(&req);
-	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
-	pmu_wait_complete(&req);
-
-	pmac_wakeup_devices();
-
-	return 0;
-}
-
-#define PB3400_MEM_CTRL		0xf8000000
-#define PB3400_MEM_CTRL_SLEEP	0x70
-
-static int __pmac
-powerbook_sleep_3400(void)
-{
-	int ret, i, x;
-	unsigned int hid0;
-	unsigned long p;
-	struct adb_request sleep_req;
-	void __iomem *mem_ctrl;
-	unsigned int __iomem *mem_ctrl_sleep;
-
-	/* first map in the memory controller registers */
-	mem_ctrl = ioremap(PB3400_MEM_CTRL, 0x100);
-	if (mem_ctrl == NULL) {
-		printk("powerbook_sleep_3400: ioremap failed\n");
-		return -ENOMEM;
-	}
-	mem_ctrl_sleep = mem_ctrl + PB3400_MEM_CTRL_SLEEP;
-
-	/* Allocate room for PCI save */
-	pbook_alloc_pci_save();
-
-	ret = pmac_suspend_devices();
-	if (ret) {
-		pbook_free_pci_save();
-		printk(KERN_ERR "Sleep rejected by devices\n");
-		return ret;
-	}
-
-	/* Save the state of PCI config space for some slots */
-	pbook_pci_save();
-
-	/* Set the memory controller to keep the memory refreshed
-	   while we're asleep */
-	for (i = 0x403f; i >= 0x4000; --i) {
-		out_be32(mem_ctrl_sleep, i);
-		do {
-			x = (in_be32(mem_ctrl_sleep) >> 16) & 0x3ff;
-		} while (x == 0);
-		if (x >= 0x100)
-			break;
-	}
-
-	/* Ask the PMU to put us to sleep */
-	pmu_request(&sleep_req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
-	while (!sleep_req.complete)
-		mb();
-
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,1);
-
-	/* displacement-flush the L2 cache - necessary? */
-	for (p = KERNELBASE; p < KERNELBASE + 0x100000; p += 0x1000)
-		i = *(volatile int *)p;
-	asleep = 1;
-
-	/* Put the CPU into sleep mode */
-	asm volatile("mfspr %0,1008" : "=r" (hid0) :);
-	hid0 = (hid0 & ~(HID0_NAP | HID0_DOZE)) | HID0_SLEEP;
-	asm volatile("mtspr 1008,%0" : : "r" (hid0));
-	_nmask_and_or_msr(0, MSR_POW | MSR_EE);
-	udelay(10);
-
-	/* OK, we're awake again, start restoring things */
-	out_be32(mem_ctrl_sleep, 0x3f);
-	pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,0);
-	pbook_pci_restore();
-	pmu_unlock();
-
-	/* wait for the PMU interrupt sequence to complete */
-	while (asleep)
-		mb();
-
-	pmac_wakeup_devices();
-	pbook_free_pci_save();
-	iounmap(mem_ctrl);
-
-	return 0;
-}
 
 /*
  * Support for /dev/pmu device
@@ -2896,24 +2276,10 @@
 	case PMU_IOC_SLEEP:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		if (sleep_in_progress)
-			return -EBUSY;
-		sleep_in_progress = 1;
-		switch (pmu_kind) {
-		case PMU_OHARE_BASED:
-			error = powerbook_sleep_3400();
-			break;
-		case PMU_HEATHROW_BASED:
-		case PMU_PADDINGTON_BASED:
-			error = powerbook_sleep_grackle();
-			break;
-		case PMU_KEYLARGO_BASED:
-			error = powerbook_sleep_Core99();
-			break;
-		default:
-			error = -ENOSYS;
-		}
-		sleep_in_progress = 0;
+		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
+			error = pm_suspend(PM_SUSPEND_MEM);		
+		else
+			error = pm_suspend(PM_SUSPEND_DISK);		
 		return error;
 	case PMU_IOC_CAN_SLEEP:
 		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
@@ -2926,8 +2292,6 @@
 	 * the fbdev
 	 */
 	case PMU_IOC_GET_BACKLIGHT:
-		if (sleep_in_progress)
-			return -EBUSY;
 		error = get_backlight_level();
 		if (error < 0)
 			return error;
@@ -2935,8 +2299,6 @@
 	case PMU_IOC_SET_BACKLIGHT:
 	{
 		__u32 value;
-		if (sleep_in_progress)
-			return -EBUSY;
 		error = get_user(value, argp);
 		if (!error)
 			error = set_backlight_level(value);
@@ -2983,7 +2345,6 @@
 	if (misc_register(&pmu_device) < 0)
 		printk(KERN_ERR "via-pmu: cannot register misc device.\n");
 }
-#endif /* CONFIG_PMAC_PBOOK */
 
 #ifdef DEBUG_SLEEP
 static inline void  __pmac
@@ -3065,17 +2426,29 @@
 
 #ifdef CONFIG_PM
 
-static int pmu_sys_suspended = 0;
-
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
-	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
+	struct adb_request req;
+
+	if (pmu_sys_suspended)
 		return 0;
 
+	/* Stop environment interrupts */
+	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
+	pmu_wait_complete(&req);
+
 	/* Suspend PMU event interrupts */
 	pmu_suspend();
 
+	/* Mark driver suspended */
 	pmu_sys_suspended = 1;
+
+	/* Wait for completion of async backlight requests */
+	while (!bright_req_1.complete || !bright_req_2.complete ||
+			!batt_req.complete)
+		pmu_poll();
+	
+
 	return 0;
 }
 
@@ -3086,6 +2459,10 @@
 	if (!pmu_sys_suspended)
 		return 0;
 
+	/* Restart environment interrupts */ 
+	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
+	pmu_wait_complete(&req);
+
 	/* Tell PMU we are ready */
 	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
 	pmu_wait_complete(&req);
@@ -3093,6 +2470,7 @@
 	/* Resume PMU event interrupts */
 	pmu_resume();
 
+	/* Mark driver ready for async requests */
 	pmu_sys_suspended = 0;
 
 	return 0;
@@ -3151,12 +2529,8 @@
 EXPORT_SYMBOL(pmu_i2c_stdsub_write);
 EXPORT_SYMBOL(pmu_i2c_simple_read);
 EXPORT_SYMBOL(pmu_i2c_simple_write);
-#ifdef CONFIG_PMAC_PBOOK
-EXPORT_SYMBOL(pmu_register_sleep_notifier);
-EXPORT_SYMBOL(pmu_unregister_sleep_notifier);
 EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
 EXPORT_SYMBOL(pmu_batteries);
 EXPORT_SYMBOL(pmu_power_flags);
-#endif /* CONFIG_PMAC_PBOOK */
 
Index: linux-work/include/asm-ppc/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc/machdep.h	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/include/asm-ppc/machdep.h	2005-05-27 16:07:24.000000000 +1000
@@ -110,6 +110,12 @@
 	 */
 	long (*feature_call)(unsigned int feature, ...);
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	int (*arch_prepare_suspend)(void);
+	void (*save_processor_state)(void);
+	void (*restore_processor_state)(void);
+#endif /* CONFIG_SOFTWARE_SUSPEND */
+
 #ifdef CONFIG_SMP
 	/* functions for dealing with other cpus */
 	struct smp_ops_t *smp_ops;
Index: linux-work/include/asm-ppc/suspend.h
===================================================================
--- linux-work.orig/include/asm-ppc/suspend.h	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/include/asm-ppc/suspend.h	2005-05-27 16:07:24.000000000 +1000
@@ -1,12 +1,44 @@
+#ifndef __PPC_SUSPEND_H
+#define __PPC_SUSPEND_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <asm/machdep.h>
+
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
 static inline int arch_prepare_suspend(void)
 {
+	if (ppc_md.arch_prepare_suspend)
+		return ppc_md.arch_prepare_suspend();
 	return 0;
 }
 
 static inline void save_processor_state(void)
 {
+	if (ppc_md.save_processor_state)
+		return ppc_md.save_processor_state();
 }
 
 static inline void restore_processor_state(void)
 {
+	if (ppc_md.restore_processor_state)
+		return ppc_md.restore_processor_state();
 }
+#else
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
+static inline void save_processor_state(void)
+{
+}
+
+static inline void restore_processor_state(void)
+{
+}
+#endif
+
+
+#endif /* __PPC_SUSPEND_H */
Index: linux-work/include/linux/pm.h
===================================================================
--- linux-work.orig/include/linux/pm.h	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/include/linux/pm.h	2005-05-27 16:07:24.000000000 +1000
@@ -169,9 +169,38 @@
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
+	
+	/* Call before process freezing. If returns 0, then no freeze
+	 * should be done, if 1, freeze, negative -> error
+	 */
+	int (*pre_freeze)(suspend_state_t state);
+
+	/* called before devices are suspended */
 	int (*prepare)(suspend_state_t state);
+
+	/* called just before irqs are off and device second pass
+	 * and sysdevs are suspended. This function can on some archs
+	 * shut irqs off, in which case, they'll still be off when
+	 * finish_irqs() is called.
+	 */
+	int (*prepare_irqs)(suspend_state_t state);
+
+	/* called for entering the actual suspend state. Exits with
+	 * machine worken up and interrupts off
+	 */
 	int (*enter)(suspend_state_t state);
-	int (*finish)(suspend_state_t state);
+
+	/* called after sysdevs and "irq off" devices have been
+	 * worken up, irqs have just been restored to whatever state
+	 * prepare_irqs() left them in.
+	 */
+	void (*finish_irqs)(suspend_state_t state);
+
+	/* called after all devices are woken up, processes still frozen */
+	void (*finish)(suspend_state_t state);
+
+	/* called after unfreezing userland */
+	void (*post_freeze)(suspend_state_t state);
 };
 
 extern void pm_set_ops(struct pm_ops *);
Index: linux-work/include/linux/pmu.h
===================================================================
--- linux-work.orig/include/linux/pmu.h	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/include/linux/pmu.h	2005-05-27 16:07:24.000000000 +1000
@@ -151,6 +151,9 @@
 extern void pmu_suspend(void);
 extern void pmu_resume(void);
 
+extern void pmu_save_via_state(void);
+extern void pmu_restore_via_state(void);
+
 extern void pmu_enable_irled(int on);
 
 extern void pmu_restart(void);
Index: linux-work/kernel/power/main.c
===================================================================
--- linux-work.orig/kernel/power/main.c	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/kernel/power/main.c	2005-05-27 16:09:28.000000000 +1000
@@ -23,6 +23,7 @@
 
 struct pm_ops * pm_ops = NULL;
 suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
+static int pm_process_frozen;
 
 /**
  *	pm_set_ops - Set the global power method table. 
@@ -49,32 +50,53 @@
 static int suspend_prepare(suspend_state_t state)
 {
 	int error = 0;
+	int freeze = 1;
 
 	if (!pm_ops || !pm_ops->enter)
 		return -EPERM;
 
 	pm_prepare_console();
 
-	if (freeze_processes()) {
+	if (pm_ops->pre_freeze)
+		freeze = pm_ops->pre_freeze(state);
+	if (freeze < 0)
+		goto Console;
+
+	if (freeze && freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
+	pm_process_frozen = freeze;
 
 	if (pm_ops->prepare) {
+		pr_debug("preparing arch...\n");
 		if ((error = pm_ops->prepare(state)))
 			goto Thaw;
 	}
 
+	pr_debug("suspending devices...\n");
 	if ((error = device_suspend(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Finish;
 	}
+
+	if (pm_ops->prepare_irqs) {
+		pr_debug("preparing arch irqs...\n");
+		if ((error = pm_ops->prepare_irqs(state)))
+			goto Finish;
+	}
+
 	return 0;
  Finish:
 	if (pm_ops->finish)
 		pm_ops->finish(state);
  Thaw:
-	thaw_processes();
+	if (freeze)
+		thaw_processes();
+
+	if (pm_ops->post_freeze)
+		pm_ops->post_freeze(state);
+ Console:
 	pm_restore_console();
 	return error;
 }
@@ -109,10 +131,18 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (!pm_ops)
+		return;
+
+	if (pm_ops->finish_irqs)
+		pm_ops->finish_irqs(state);
 	device_resume();
-	if (pm_ops && pm_ops->finish)
+	if (pm_ops->finish)
 		pm_ops->finish(state);
-	thaw_processes();
+	if (pm_process_frozen)
+		thaw_processes();
+	if (pm_ops->post_freeze)
+		pm_ops->post_freeze(state);
 	pm_restore_console();
 }
 
Index: linux-work/arch/ppc/platforms/pmac_pic.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_pic.c	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_pic.c	2005-05-27 16:07:24.000000000 +1000
@@ -619,7 +619,7 @@
 	return viaint;
 }
 
-static int pmacpic_suspend(struct sys_device *sysdev, u32 state)
+void __pmac pmacpic_suspend(void)
 {
 	int viaint = pmacpic_find_viaint();
 
@@ -636,11 +636,9 @@
 	/* make sure mask gets to controller before we return to caller */
 	mb();
         (void)in_le32(&pmac_irq_hw[0]->enable);
-
-        return 0;
 }
 
-static int pmacpic_resume(struct sys_device *sysdev)
+void __pmac pmacpic_resume(void)
 {
 	int i;
 
@@ -651,12 +649,11 @@
 	for (i = 0; i < max_real_irqs; ++i)
 		if (test_bit(i, sleep_save_mask))
 			pmac_unmask_irq(i);
-
-	return 0;
 }
 
 #endif /* CONFIG_PM */
 
+#if 0
 static struct sysdev_class pmacpic_sysclass = {
 	set_kset_name("pmac_pic"),
 };
@@ -686,4 +683,4 @@
 }
 
 subsys_initcall(init_pmacpic_sysfs);
-
+#endif
Index: linux-work/arch/ppc/syslib/open_pic.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/open_pic.c	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/arch/ppc/syslib/open_pic.c	2005-05-27 16:07:24.000000000 +1000
@@ -948,11 +948,7 @@
 	save_irq_src_vp[irq - open_pic_irq_offset] |= OPENPIC_MASK;
 }
 
-/* WARNING: Can be called directly by the cpufreq code with NULL parameter,
- * we need something better to deal with that... Maybe switch to S1 for
- * cpufreq changes
- */
-int openpic_suspend(struct sys_device *sysdev, u32 state)
+void openpic_suspend(void)
 {
 	int	i;
 	unsigned long flags;
@@ -961,11 +957,9 @@
 
 	if (openpic_suspend_count++ > 0) {
 		spin_unlock_irqrestore(&openpic_setup_lock, flags);
-		return 0;
+		return;
 	}
 
- 	openpic_set_priority(0xf);
-
 	open_pic.enable = openpic_cached_enable_irq;
 	open_pic.disable = openpic_cached_disable_irq;
 
@@ -975,6 +969,8 @@
 				   OPENPIC_CURRENT_TASK_PRIORITY_MASK, 0xf);
 	}
 
+ 	openpic_set_priority(0xf);
+
 	for (i=0; i<OPENPIC_NUM_IPI; i++)
 		save_ipi_vp[i] = openpic_read(&OpenPIC->Global.IPI_Vector_Priority(i));
 	for (i=0; i<NumSources; i++) {
@@ -985,15 +981,13 @@
 	}
 
 	spin_unlock_irqrestore(&openpic_setup_lock, flags);
-
-	return 0;
 }
 
 /* WARNING: Can be called directly by the cpufreq code with NULL parameter,
  * we need something better to deal with that... Maybe switch to S1 for
  * cpufreq changes
  */
-int openpic_resume(struct sys_device *sysdev)
+void openpic_resume(void)
 {
 	int		i;
 	unsigned long	flags;
@@ -1005,9 +999,11 @@
 
 	if ((--openpic_suspend_count) > 0) {
 		spin_unlock_irqrestore(&openpic_setup_lock, flags);
-		return 0;
+		return;
 	}
 
+ 	openpic_set_priority(0xf);
+
 	/* OpenPIC sometimes seem to need some time to be fully back up... */
 	do {
 		openpic_set_spurious(OPENPIC_VEC_SPURIOUS);
@@ -1030,22 +1026,19 @@
 		} while (openpic_readfield(&ISR[i]->Vector_Priority, vppmask)
 			 != (save_irq_src_vp[i] & vppmask));
 	}
-	for (i=0; i<NumProcessors; i++)
-		openpic_write(&OpenPIC->Processor[i].Current_Task_Priority,
-			      save_cpu_task_pri[i]);
-
 	open_pic.enable = openpic_enable_irq;
 	open_pic.disable = openpic_disable_irq;
 
- 	openpic_set_priority(0);
+	for (i=0; i<NumProcessors; i++)
+		openpic_write(&OpenPIC->Processor[i].Current_Task_Priority,
+			      save_cpu_task_pri[i]);
 
 	spin_unlock_irqrestore(&openpic_setup_lock, flags);
-
-	return 0;
 }
 
 #endif /* CONFIG_PM */
 
+#if 0
 static struct sysdev_class openpic_sysclass = {
 	set_kset_name("openpic"),
 };
@@ -1089,3 +1082,4 @@
 
 subsys_initcall(init_openpic_sysfs);
 
+#endif
Index: linux-work/include/asm-ppc/open_pic.h
===================================================================
--- linux-work.orig/include/asm-ppc/open_pic.h	2005-05-27 16:06:59.000000000 +1000
+++ linux-work/include/asm-ppc/open_pic.h	2005-05-27 16:08:12.000000000 +1000
@@ -64,6 +64,9 @@
 extern void openpic_set_priority(u_int pri);
 extern u_int openpic_get_priority(void);
 
+extern void openpic_suspend(void);
+extern void openpic_resume(void);
+
 extern inline int openpic_to_irq(int irq)
 {
 	/* IRQ 0 usually means 'disabled'.. don't mess with it


