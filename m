Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbUKXNto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbUKXNto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUKXNr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:47:26 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5782 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262671AbUKXNMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:12:02 -0500
Subject: Suspend 2 merge: 42/51: Suspend.c
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101299659.5805.367.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:01:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the heart of the core :> (No, that's not a typo).

- Device suspend/resume calls
- Power down
- Highest level routine
- all_settings proc entry handling


diff -ruN 832-suspend-old/kernel/power/suspend.c 832-suspend-new/kernel/power/suspend.c
--- 832-suspend-old/kernel/power/suspend.c	1970-01-01 10:00:00.000000000 +1000
+++ 832-suspend-new/kernel/power/suspend.c	2004-11-21 20:00:10.000000000 +1100
@@ -0,0 +1,2019 @@
+/*
+ * kernel/power/suspend2.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file is to realize architecture-independent
+ * machine suspend feature using pretty near only high-level routines
+ *
+ * We'd like to thank the following people for their work:
+ * 
+ * Pavel Machek <pavel@ucw.cz>:
+ * Modifications, defectiveness pointing, being with Gabor at the very beginning,
+ * suspend to swap space, stop all tasks. Port to 2.4.18-ac and 2.5.17.
+ *
+ * Steve Doddi <dirk@loth.demon.co.uk>: 
+ * Support the possibility of hardware state restoring.
+ *
+ * Raph <grey.havens@earthling.net>:
+ * Support for preserving states of network devices and virtual console
+ * (including X and svgatextmode)
+ *
+ * Kurt Garloff <garloff@suse.de>:
+ * Straightened the critical function in order to prevent compilers from
+ * playing tricks with local variables.
+ *
+ * Andreas Mohr <a.mohr@mailto.de>
+ *
+ * Alex Badea <vampire@go.ro>:
+ * Fixed runaway init
+ *
+ * Jeff Snyder <je4d@pobox.com>
+ * ACPI patch
+ *
+ * Nathan Friess <natmanz@shaw.ca>
+ * Some patches.
+ *
+ * Michael Frank <mhf@linuxmail.org>
+ * Extensive testing and help with improving stability.
+ *
+ * Variable definitions which are needed if PM is enabled but 
+ * SOFTWARE_SUSPEND is disabled are found near the top of process.c.
+ */
+
+#define SUSPEND_MAIN_C
+//#define DEBUG_DEVICE_TREE
+
+#include <linux/suspend.h>
+#include <linux/reboot.h>
+#include <linux/module.h>
+#include <linux/console.h>
+#include <linux/version.h>
+#include <linux/device.h>
+#include <linux/highmem.h>
+#include <asm/uaccess.h>
+
+#include "suspend.h"
+#include "block_io.h"
+#include "plugins.h"
+#include "proc.h"
+#include "pageflags.h"
+
+#ifdef  CONFIG_X86
+#include <asm/i387.h> /* for kernel_fpu_end */
+#endif
+
+static unsigned long suspend_powerdown_method = 5; /* S5 = off */
+static int suspend_acpi_state_used = 0;
+
+static u32 pm_disk_mode_save;
+struct partial_device_tree * suspend_device_tree;
+EXPORT_SYMBOL(suspend_device_tree);
+
+#ifdef CONFIG_SMP
+static void ensure_on_processor_zero(void)
+{
+	set_cpus_allowed(current, cpumask_of_cpu(0));
+	BUG_ON(smp_processor_id() != 0);
+}
+#else
+#define ensure_on_processor_zero() do { } while(0)
+#endif
+
+#ifdef CONFIG_ACPI
+extern u32 acpi_leave_sleep_state (u8 sleep_state);
+#endif
+
+#ifdef DEBUG_DEVICE_TREE
+#include "../../drivers/base/power/power.h"
+#include <linux/device.h>
+
+void display_device_tree(struct partial_device_tree * tree, char * header)
+{
+	struct device * dev;
+
+	if (header)
+		printk(header);
+	printk(" === Tree %p ===\n\n", tree);
+
+	printk(" -- Active\n");
+	list_for_each_entry(dev, &tree->dpm_active, power.entry) {
+		printk("   %p->%p", dev, dev->parent);
+		printk(" %s\n", dev->kobj.k_name ? dev->kobj.k_name : "<null>");
+	}
+	printk("\n -- DPM Off\n");
+	list_for_each_entry(dev, &tree->dpm_off, power.entry) {
+		printk("   %p->%p", dev, dev->parent);
+		printk(" %s\n", dev->kobj.k_name ? dev->kobj.k_name : "<null>");
+	}
+	
+	printk("\n -- DPM Off IRQ\n");
+	list_for_each_entry(dev, &tree->dpm_off_irq, power.entry) {
+		printk("   %p->%p", dev, dev->parent);
+		printk(" %s\n", dev->kobj.k_name ? dev->kobj.k_name : "<null>");
+	}
+	printk("\n--- Done ---\n");
+}
+#else
+#define display_device_tree(tree, header) do { } while(0)
+#endif
+
+/*	suspend_drivers_resume
+ *	@stage - One of...
+ */
+
+enum {
+	SUSPEND_DRIVERS_USED_DEVICES_IRQS_DISABLED,
+	SUSPEND_DRIVERS_USED_DEVICES_IRQS_ENABLED,
+	SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED,
+	SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED,
+	SUSPEND_DRIVERS_PRE_POWERDOWN,
+};
+
+void suspend_drivers_resume(int stage)
+{
+	switch (stage) {
+		case SUSPEND_DRIVERS_USED_DEVICES_IRQS_DISABLED:
+			BUG_ON(!irqs_disabled());
+			if (!TEST_ACTION_STATE(SUSPEND_DISABLE_SYSDEV_SUPPORT))
+				sysdev_resume();
+			dpm_power_up_tree(suspend_device_tree);
+			break;
+
+		case SUSPEND_DRIVERS_USED_DEVICES_IRQS_ENABLED:
+			BUG_ON(irqs_disabled());
+			display_device_tree(suspend_device_tree,
+				"suspend_drivers_resume stage 1.");
+			device_resume_tree(suspend_device_tree);
+			display_device_tree(suspend_device_tree,
+				"Post resume tree call.");
+			break;
+
+		case SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED:
+			BUG_ON(!irqs_disabled());
+			display_device_tree(&default_device_tree,
+				"suspend_drivers_resume stage 2.\n");
+			dpm_power_up_tree(&default_device_tree);
+			break;
+
+		case SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED:
+			BUG_ON(irqs_disabled());
+			device_resume_tree(&default_device_tree);
+			display_device_tree(&default_device_tree,
+				"Post power up.\n");
+#ifdef CONFIG_ACPI
+			if (suspend_acpi_state_used)
+				acpi_leave_sleep_state(suspend_acpi_state_used);
+#endif
+			display_device_tree(&default_device_tree,
+				"suspend_drivers_resume stage 3.\n");
+			device_resume_tree(&default_device_tree);
+			display_device_tree(&default_device_tree,
+				"Post resume default device tree.\n");
+#ifdef CONFIG_ACPI
+			if (suspend_acpi_state_used &&
+				pm_ops && pm_ops->finish)
+				pm_ops->finish(suspend_acpi_state_used);
+#endif
+			break;
+	}
+}
+
+/*	suspend_drivers_suspend
+ *	@stage - one of:
+ *		1: Power down drivers not used in writing the image
+ *		2: Quiesce drivers used in writing the image
+ *		   (prior to making atomic copy)
+ *		3: Power down drivers used in writing the image and
+ *		   enter the suspend mode if configured to do so.
+ *
+ */
+static int suspend_drivers_suspend(int stage)
+{
+	int result = 0;
+
+	switch (stage) {
+		case SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED:
+			BUG_ON(!irqs_disabled());
+			if (!result)
+				result = device_power_down_tree(
+					PM_SUSPEND_DISK, &default_device_tree);
+			display_device_tree(&default_device_tree,
+				"Post suspend power down device tree.\n");
+			break;
+
+		case SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED:
+			BUG_ON(irqs_disabled());
+			display_device_tree(&default_device_tree,
+				"suspend_drivers_suspend stage 1.\n");
+			result = device_suspend_tree(
+					PM_SUSPEND_DISK, &default_device_tree);
+			break;
+
+		case SUSPEND_DRIVERS_USED_DEVICES_IRQS_DISABLED:
+			BUG_ON(!irqs_disabled());
+			result = device_power_down_tree(PM_SUSPEND_DISK, suspend_device_tree);
+			if (!TEST_ACTION_STATE(SUSPEND_DISABLE_SYSDEV_SUPPORT))
+				sysdev_suspend(PM_SUSPEND_DISK);
+			break;
+
+		case SUSPEND_DRIVERS_USED_DEVICES_IRQS_ENABLED:
+			BUG_ON(irqs_disabled());
+			display_device_tree(suspend_device_tree,
+				"suspend_drivers_suspend stage 2.\n");
+			result = device_suspend_tree(
+					PM_SUSPEND_DISK, suspend_device_tree);
+			display_device_tree(suspend_device_tree,
+				"Post suspend device tree.\n");
+			break;
+
+		case SUSPEND_DRIVERS_PRE_POWERDOWN: /* Power down system */
+			BUG_ON(irqs_disabled());
+			display_device_tree(suspend_device_tree,
+				"suspend_drivers_suspend stage 3.\n");
+
+			result = device_suspend_tree(
+				PM_SUSPEND_DISK, suspend_device_tree);
+			break;
+	}
+	return result;
+}
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+void show_pcp_lists(void)
+{
+	int cpu, temperature;
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		printk("%s per-cpu:", zone->name);
+
+		if (!zone->present_pages) {
+			printk(" empty\n");
+			continue;
+		} else
+			printk("\n");
+
+		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+			struct per_cpu_pageset *pageset;
+
+			if (!cpu_possible(cpu))
+				continue;
+
+			pageset = zone->pageset + cpu;
+
+			for (temperature = 0; temperature < 2; temperature++)
+				printk("cpu %d %s: low %d, high %d, batch %d, count %d.\n",
+					cpu,
+					temperature ? "cold" : "hot",
+					pageset->pcp[temperature].low,
+					pageset->pcp[temperature].high,
+					pageset->pcp[temperature].batch,
+					pageset->pcp[temperature].count);
+		}
+	}
+}
+#else
+#define show_pcp_lists() do { } while(0)
+#endif
+
+/* -------------------------------------------------------------------------- */
+
+static int suspend_version_specific_initialise(void)
+{
+	struct class * class;
+	struct class_device * class_dev;
+
+	suspend_save_avenrun();
+
+	PRINTFREEMEM("after draining local pages");
+	suspend_store_free_mem(SUSPEND_FREE_DRAIN_PCP, 0);
+
+	if (TEST_DEBUG_STATE(SUSPEND_FREEZER))
+		show_pcp_lists();
+
+	if (pm_ops) {
+		pm_disk_mode_save = pm_ops->pm_disk_mode;
+		pm_ops->pm_disk_mode = PM_DISK_PLATFORM;
+	}
+			
+	BUG_ON(suspend_device_tree);
+	suspend_device_tree = device_create_tree();
+	if (IS_ERR(suspend_device_tree)) {
+		suspend_device_tree = NULL;
+		return -ENOMEM;
+	}
+
+	/* Now check for graphics class devices, so we can keep the display on while suspending */
+	class = class_find("graphics");
+	if (class) {
+		list_for_each_entry(class_dev, &class->children, node)
+			device_switch_trees(class_dev->dev, suspend_device_tree);
+		class_put(class);
+	}
+	return 0;
+}
+
+static void suspend_version_specific_cleanup(void)
+{
+	suspend_restore_avenrun();
+
+	if (pm_ops) pm_ops->pm_disk_mode = pm_disk_mode_save;
+			
+	if (suspend_device_tree) {
+		device_merge_tree(suspend_device_tree, &default_device_tree);
+		device_destroy_tree(suspend_device_tree);
+		display_device_tree(&default_device_tree,
+			" ==== POST DEVICE MERGE TREE ====\n");
+		suspend_device_tree = NULL;
+	}
+}
+/* Variables to be preserved over suspend */
+int pageset1_sizelow = 0, pageset2_sizelow = 0;
+
+unsigned long orig_mem_free = 0;
+
+extern void do_suspend2_lowlevel(int resume);
+extern unsigned long header_storage_for_plugins(void);
+extern int suspend_initialise_plugin_lists(void);
+extern void suspend_relinquish_console(void);
+extern volatile int suspend_io_time[2][2];
+void empty_suspend_memory_pool(void);
+int read_primary_suspend_image(void);
+extern void display_nosave_pages(void);
+extern int num_writers;
+
+extern void suspend_console_proc_init(void);
+extern void suspend_console_proc_exit(void);
+extern int suspend2_prepare_console(void);
+extern void suspend2_cleanup_console(void);
+
+unsigned long * in_use_map = NULL;
+unsigned long * pageset2_map = NULL;
+unsigned long * checksum_map = NULL;
+#ifdef CONFIG_DEBUG_PAGEALLOC
+unsigned long * unmap_map = NULL;
+#endif
+
+char * debug_info_buffer;
+
+int image_size_limit = 0;
+int max_async_ios = 128;
+
+/* Pagedir.c */
+extern void copy_pageset1(void);
+extern int allocate_local_pageflags(unsigned long ** pagemap, int setnosave);
+extern void free_pagedir(struct pagedir * p);
+extern int free_local_pageflags(unsigned long ** pagemap);
+
+/* Prepare_image.c */
+
+extern int prepare_image(void);
+
+unsigned long forced_ps1_size = 0, forced_ps2_size = 0;
+
+/* proc.c */
+extern int suspend_cleanup_proc(void);
+
+extern int suspend2_register_core(struct suspend2_core_ops * ops_pointer);
+extern void suspend2_unregister_core(void);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+
+int suspend_free_mem_values[MAX_FREEMEM_SLOTS][2];
+/* These should match the enumerated type in suspend.h */
+static char * suspend_free_mem_descns[MAX_FREEMEM_SLOTS] = {
+	"Start/End      ", /* 0 */
+	"Console Allocn ",
+	"Drain pcp      ",
+	"InUse map      ",
+	"PS2 map        ",
+	"Checksum map   ", /* 5 */
+	"Reload pages   ",
+	"Init plugins   ",
+	"Memory pool    ",
+	"Freezer        ",
+	"Eat Memory     ", /* 10 */
+	"Syncing        ",
+	"Grabbed Memory ",
+	"Range Pages    ",
+	"Extra PD1 pages",
+	"Writer storage ", /* 15 */
+	"Header storage ",
+	"Checksum pages ",
+	"KStat data     ",
+	"Debug Info     ",
+	"Remove Image   ", /* 20 */
+	"I/O            ",
+	"I/O info       ",
+	"Start one      ",
+};
+
+/* store_free_mem
+ */
+
+
+void suspend_store_free_mem(int slot, int side)
+{
+	static int last_free_mem;
+	int this_free_mem = real_nr_free_pages() + suspend_amount_grabbed +
+			suspend_memory_pool_level(0);
+	int i;
+
+	BUG_ON(slot >= MAX_FREEMEM_SLOTS);
+
+	suspend_message(SUSPEND_MEMORY, SUSPEND_HIGH, 0,
+			"Last free mem was %d. Is now %d. ",
+			last_free_mem, this_free_mem);
+
+	if (slot == 0) {
+		if (!side)
+			for (i = 1; i < MAX_FREEMEM_SLOTS; i++) {
+				suspend_free_mem_values[i][0] = 0;
+				suspend_free_mem_values[i][1] = 0;
+			}
+		suspend_free_mem_values[slot][side] = this_free_mem;
+	} else
+		suspend_free_mem_values[slot][side] += this_free_mem - last_free_mem;
+	last_free_mem = this_free_mem;
+	suspend_message(SUSPEND_MEMORY, SUSPEND_HIGH, 0,
+		"%s value %d now %d.\n",
+		suspend_free_mem_descns[slot],
+		side,
+		suspend_free_mem_values[slot][side]);
+}
+
+/*
+ * display_free_mem
+ */
+static void display_free_mem(void)
+{
+	int i;
+
+
+	if (!TEST_DEBUG_STATE(SUSPEND_MEMORY))
+		return;
+	
+	suspend_message(SUSPEND_MEMORY, SUSPEND_HIGH, 0,
+		"Start:       %7d    End: %7d.\n",
+		suspend_free_mem_values[0][0],
+		suspend_free_mem_values[0][1]);
+	
+	for (i = 1; i < MAX_FREEMEM_SLOTS; i++)
+		if (suspend_free_mem_values[i][0] + suspend_free_mem_values[i][1])
+			suspend_message(SUSPEND_MEMORY, SUSPEND_HIGH, 0,
+				"%s %7d         %7d.\n",
+				suspend_free_mem_descns[i],
+				suspend_free_mem_values[i][0],
+				suspend_free_mem_values[i][1]);
+}
+#endif
+
+/*
+ * save_image
+ * Result code (int): Zero on success, non zero on failure.
+ * Functionality    : High level routine which performs the steps necessary
+ *                    to prepare and save the image after preparatory steps
+ *                    have been taken.
+ * Key Assumptions  : Processes frozen, sufficient memory available, drivers
+ *                    suspended.
+ * Called from      : do_suspend2_suspend_2
+ */
+extern struct pageset_sizes_result recalculate_stats(void);
+extern int write_pageset(struct pagedir * pagedir, int whichtowrite);
+extern int write_image_header(void);
+extern int read_secondary_pagedir(int overwrittenpagesonly);
+
+static int save_image(void)
+{
+	int temp_result;
+
+	if (RAM_TO_SUSPEND > max_mapnr) {
+		prepare_status(1, 1,
+			"Couldn't get enough free pages, on %ld pages short",
+			 RAM_TO_SUSPEND - max_mapnr);
+		goto abort_saving;
+	}
+	
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+		" - Final values: %d and %d.\n",
+		pageset1_size, 
+		pageset2_size);
+
+	/* Suspend devices we're not going to use in writing the image */
+	if (active_writer && active_writer->dpm_set_devices)
+		active_writer->dpm_set_devices();
+	suspend_drivers_suspend(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED);
+	local_irq_disable();
+	suspend_drivers_suspend(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED);
+	local_irq_enable();
+
+	check_shift_keys(1, "About to write pagedir2.");
+
+	temp_result = write_pageset(&pagedir2, 2);
+	
+	check_shift_keys(1, "About to copy pageset 1.");
+
+	if (temp_result == -1 || TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto abort_saving;
+
+	prepare_status(1, 0, "Doing atomic copy...");
+	
+	do_suspend2_lowlevel(0);
+
+	return 0;
+abort_saving:
+	suspend_drivers_resume(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED);
+	local_irq_disable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED);
+	local_irq_enable();
+
+	return -1;		
+}
+
+int save_image_part1(void)
+{
+	int temp_result;
+	
+	suspend_map_atomic_copy_pages();
+
+	suspend_checksum_calculate_checksums();
+	
+	BUG_ON(!irqs_disabled());
+
+	if (!TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
+		copy_pageset1();
+
+	/*
+	 *  ----   FROM HERE ON, NEED TO REREAD PAGESET2 IF ABORTING!!! -----
+	 *  
+	 */
+	
+	suspend_unmap_atomic_copy_pages();
+
+	/* 
+	 * Other processors have waited for me to make the atomic copy of the 
+	 * kernel
+	 */
+
+	smp_continue();
+	
+#ifdef CONFIG_X86
+	kernel_fpu_end();
+#endif
+
+#ifdef CONFIG_PREEMPT
+	preempt_enable_no_resched();
+#endif
+
+	suspend_drivers_resume(SUSPEND_DRIVERS_USED_DEVICES_IRQS_DISABLED);
+	
+	local_irq_enable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_USED_DEVICES_IRQS_ENABLED);
+
+	update_status(pageset2_size, pageset1_size + pageset2_size, NULL);
+	
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	check_shift_keys(1, "About to write pageset1.");
+
+	/*
+	 * End of critical section.
+	 */
+	
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			"-- Writing pageset1\n");
+
+	temp_result = write_pageset(&pagedir1, 1);
+
+	if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED)) {
+		/* We didn't overwrite any memory, so no reread needs to be done. */
+		return -1;
+	}
+
+	if (temp_result == -1 || TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	check_shift_keys(1, "About to write header.");
+
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	temp_result = write_image_header();
+
+	if (temp_result || (TEST_RESULT_STATE(SUSPEND_ABORTED)))
+		goto abort_reloading_pagedir_two;
+
+	check_shift_keys(1, "About to power down or reboot.");
+
+	return 0;
+
+abort_reloading_pagedir_two:
+	temp_result = read_secondary_pagedir(1);
+
+	/* If that failed, we're sunk. Panic! */
+	if (temp_result)
+		panic("Attempt to reload pagedir 2 while aborting "
+				"a suspend failed.");
+
+	return -1;		
+
+}
+
+static void suspend_power_off(void)
+{
+	sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+			LINUX_REBOOT_CMD_POWER_OFF, NULL);
+
+	prepare_status(1, 0, "Probably not capable for powerdown.");
+	while (1)
+		cpu_relax();
+	/* NOTREACHED */
+}
+
+static void suspend_enter_acpi_state(u32 state)
+{
+	suspend_acpi_state_used = state;
+
+	if (pm_ops && pm_ops->prepare) {
+		if (!pm_ops->prepare(state)) {
+			if (pm_ops && pm_ops->enter)
+				pm_ops->enter(state);
+			else 
+				printk("Failed to enter state.\n");
+		} else
+			printk("Prepare ops failed.\n");
+	} else
+		printk("No prepare ops.\n");
+}
+
+/*
+ * suspend_power_down
+ * Functionality   : Powers down or reboots the computer once the image
+ *                   has been written to disk.
+ * Key Assumptions : Able to reboot/power down via code called or that
+ *                   the warning emitted if the calls fail will be visible
+ *                   to the user (ie printk resumes devices).
+ * Called From     : do_suspend2_suspend_2
+ */
+
+extern asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd,
+	       void * arg);
+extern void apm_power_off(void);
+
+void suspend_power_down(void)
+{
+	if (TEST_ACTION_STATE(SUSPEND_REBOOT)) {
+		prepare_status(1, 0, "Ready to reboot.");
+		sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+				LINUX_REBOOT_CMD_RESTART, NULL);
+	}
+
+	suspend_drivers_suspend(SUSPEND_DRIVERS_PRE_POWERDOWN);
+
+	if (suspend_powerdown_method == 3) {
+		prepare_status(1, 0, "Seeking to suspend-to-ram.");
+		suspend_enter_acpi_state(PM_SUSPEND_MEM);
+		prepare_status(1, 0, "Entering S3 failed. Using normal powerdown.");
+	} else if (suspend_powerdown_method == 4) {
+		prepare_status(1, 0, "Seeking to enter ACPI suspend-to-disk state.");
+		suspend_enter_acpi_state(PM_SUSPEND_DISK);
+		prepare_status(1, 0, "Entering S4 failed. Using normal powerdown.");
+	} else
+		prepare_status(1, 0, "Powering down.");
+	
+	/* 
+	 * FIXME: At resume, we'll still think we used S4 if we tried it.
+	 * Does it matter?
+	 */
+	suspend_acpi_state_used = 0;
+	suspend_power_off();
+}
+
+/*
+ * do_suspend2_resume_1
+ * Functionality   : Preparatory steps for copying the original kernel back.
+ * Called From     : do_suspend2_lowlevel
+ */
+
+static void do_suspend2_resume_1(void)
+{
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			name_suspend "About to copy pageset1 back...\n");
+
+	if (active_writer && active_writer->dpm_set_devices)
+		active_writer->dpm_set_devices();
+	
+	suspend_drivers_suspend(SUSPEND_DRIVERS_USED_DEVICES_IRQS_ENABLED);
+	suspend_drivers_suspend(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED);
+	local_irq_disable(); /* irqs might have been re-enabled on us */
+	suspend_drivers_suspend(SUSPEND_DRIVERS_USED_DEVICES_IRQS_DISABLED);
+	local_irq_disable();
+	suspend_drivers_suspend(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED);
+	local_irq_enable();
+
+	suspend_map_atomic_copy_pages();
+
+	/* Get other cpus ready to restore their original contexts */
+	smp_suspend();
+
+	local_irq_disable();
+
+#ifdef CONFIG_PREEMPT
+	preempt_disable();
+#endif
+
+	barrier();
+	mb();
+
+	MDELAY(2000);
+}
+
+/*
+ * do_suspend2_resume_2
+ * Functionality   : Steps taken after copying back the original kernel at
+ *                   resume.
+ * Key Assumptions : Will be able to read back secondary pagedir (if 
+ *                   applicable).
+ * Called From     : do_suspend2_lowlevel
+ */
+
+static void do_suspend2_resume_2(void)
+{
+	set_suspend_state(SUSPEND_NOW_RESUMING);
+	set_suspend_state(SUSPEND_PAGESET2_NOT_LOADED);
+
+	suspend_unmap_atomic_copy_pages();
+
+#ifdef CONFIG_PREEMPT
+	preempt_enable();
+#endif
+
+	local_irq_disable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_USED_DEVICES_IRQS_DISABLED);
+	local_irq_enable();
+
+	suspend_drivers_resume(SUSPEND_DRIVERS_USED_DEVICES_IRQS_ENABLED);
+
+	suspend_post_restore_redraw();
+
+	check_shift_keys(1, "About to reload secondary pagedir.");
+
+	read_secondary_pagedir(0);
+	clear_suspend_state(SUSPEND_PAGESET2_NOT_LOADED);
+	
+	suspend_checksum_print_differences();
+
+	prepare_status(0, 0, "Cleaning up...");
+
+	clear_suspend_state(SUSPEND_USE_MEMORY_POOL);
+	
+	local_irq_disable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED);
+	local_irq_enable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED);
+}
+
+/*
+ * do_suspend2_suspend_1
+ * Functionality   : Steps taken prior to saving CPU state and the image
+ *                   itself.
+ * Called From     : do_suspend2_lowlevel
+ */
+
+static void do_suspend2_suspend_1(void)
+{
+	/* Save other cpu contexts */
+	smp_suspend();
+
+	suspend_drivers_suspend(SUSPEND_DRIVERS_USED_DEVICES_IRQS_ENABLED);
+
+	mb();
+	barrier();
+
+#ifdef CONFIG_PREEMPT
+	preempt_disable();
+#endif
+	local_irq_disable();
+	suspend_drivers_suspend(SUSPEND_DRIVERS_USED_DEVICES_IRQS_DISABLED);
+}
+
+/*
+ * do_suspend2_suspend_2
+ * Functionality   : Steps taken after saving CPU state to save the
+ *                   image and powerdown/reboot or recover on failure.
+ * Key Assumptions : save_image returns zero on success; otherwise we need to
+ *                   clean up and exit. The state on exiting this routine 
+ *                   should be essentially the same as if we have suspended,
+ *                   resumed and reached the end of do_suspend2_resume_2.
+ * Called From     : do_suspend2_lowlevel
+ */
+static void do_suspend2_suspend_2(void)
+{
+	if (!save_image_part1())
+		suspend_power_down();
+
+	if (!TEST_RESULT_STATE(SUSPEND_ABORT_REQUESTED) &&
+	    !TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED) &&
+	    suspend_powerdown_method != 3)
+		printk(KERN_EMERG name_suspend
+			"Suspend failed, trying to recover...\n");
+	MDELAY(1000);
+
+	local_irq_disable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_DISABLED);
+	local_irq_enable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_UNUSED_DEVICES_IRQS_ENABLED);
+
+	barrier();
+	mb();
+}
+
+static inline void lru_check_page(struct page * page)
+{
+	if (!PageLRU(page))
+		printk("Page %p/%p in inactivelist but not marked LRU.\n",
+			page, page_address(page));
+}
+
+/* get_debug_info
+ * Functionality:	Store debug info in a buffer.
+ * Called from:		suspend_try_suspend.
+ */
+
+#define SNPRINTF(a...) 	len += suspend_snprintf(debug_info_buffer + len, \
+		PAGE_SIZE - len - 1, ## a)
+
+static int get_suspend_debug_info(void)
+{
+	int len = 0;
+	if (!debug_info_buffer) {
+		debug_info_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+		if (!debug_info_buffer) {
+			printk("Error! Unable to allocate buffer for"
+					"software suspend debug info.\n");
+			return 0;
+		}
+	}
+
+	SNPRINTF("Please include the following information in bug reports:\n");
+	SNPRINTF("- SUSPEND core   : %s\n", SUSPEND_CORE_VERSION);
+	SNPRINTF("- Kernel Version : %s\n", UTS_RELEASE);
+	SNPRINTF("- Compiler vers. : %d.%d\n", __GNUC__, __GNUC_MINOR__);
+#ifdef CONFIG_MODULES
+	SNPRINTF("- Modules loaded : ");
+	{
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+		struct module *this_mod;
+		extern struct module *module_list;
+		this_mod = module_list;
+		while (this_mod) {
+			if (this_mod->name)
+				SNPRINTF("%s ", this_mod->name);
+			this_mod = this_mod->next;
+		}
+#else
+		extern int print_module_list_to_buffer(char * buffer, int size);
+		len+= print_module_list_to_buffer(debug_info_buffer + len,
+				PAGE_SIZE - len - 1);
+#endif
+	}
+	SNPRINTF("\n");
+#else
+	SNPRINTF("- No module support.\n");
+#endif
+	SNPRINTF("- Attempt number : %d\n", nr_suspends);
+	if (num_range_pages)
+		SNPRINTF("- Pageset sizes  : %d (%d low) and %d (%d low).\n",
+			pagedir1.lastpageset_size, 
+			pageset1_sizelow,
+			pagedir2.lastpageset_size, 
+			pageset2_sizelow);
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+	SNPRINTF("- Parameters     : %ld %ld %ld %d %d %d %ld\n",
+			suspend_result,
+			suspend_action,
+			suspend_debug_state,
+			suspend_default_console_level,
+			image_size_limit,
+			max_async_ios,
+			suspend_powerdown_method);
+#else
+	SNPRINTF("- Parameters     : %ld %ld %d %d %ld\n",
+			suspend_result,
+			suspend_action,
+			image_size_limit,
+			max_async_ios,
+			suspend_powerdown_method);
+#endif
+	if (num_range_pages)
+		SNPRINTF("- Calculations   : Image size: %lu. "
+			"Ram to suspend: %ld.\n",
+			STORAGE_NEEDED(1), RAM_TO_SUSPEND);
+	SNPRINTF("- Limits         : %lu pages RAM. Initial boot: %lu.\n",
+		max_mapnr, orig_mem_free);
+	SNPRINTF("- Overall expected compression percentage: %d.\n",
+			100 - expected_compression_ratio());
+	len+= print_plugin_debug_info(debug_info_buffer + len, 
+			PAGE_SIZE - len - 1);
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+	SNPRINTF("- Debugging compiled in.\n");
+#endif
+#ifdef CONFIG_PREEMPT
+	SNPRINTF("- Preemptive kernel.\n");
+#endif
+#ifdef CONFIG_SMP
+	SNPRINTF("- SMP kernel.\n");
+#endif
+#ifdef CONFIG_HIGHMEM
+	SNPRINTF("- Highmem Support.\n");
+#endif
+	if (num_range_pages)
+		SNPRINTF("- Max ranges used: %d ranges in %d pages.\n",
+			max_ranges_used, num_range_pages);
+	if (suspend_io_time[0][1]) {
+		SNPRINTF("- I/O speed: Write %d MB/s",
+			(MB((unsigned long) suspend_io_time[0][0]) * HZ /
+			 suspend_io_time[0][1]));
+		if (suspend_io_time[1][1])
+			SNPRINTF(", Read %d MB/s",
+				(MB((unsigned long) suspend_io_time[1][0]) * HZ /
+				 suspend_io_time[1][1]));
+		SNPRINTF(".\n");
+	}
+	else if (num_range_pages)
+		SNPRINTF("- Suspend cancelled. No I/O speed stats.\n");
+
+	return len;
+}
+
+extern int PageInPagedir(struct pagedir * p, struct page * page);
+static unsigned long display_metadata_page;
+
+static char * state_string[3] = { "Source", "Destination", "Dest/Allocd" };
+
+void __display_metadata_state(int pagedir, int state)
+{
+	int i;
+
+	if (!state)
+		return;
+
+	printk("[ Pagedir %d:", pagedir);
+	for (i=0; i < 3; i++)
+		if (state & (1 << i))
+			printk("%s ", state_string[i]);
+	printk("]");
+}
+
+void display_metadata_state(struct page * page)
+{
+	__display_metadata_state(1, PageInPagedir(&pagedir1, page));
+	__display_metadata_state(2, PageInPagedir(&pagedir2, page));
+	if (PageNosave(page))
+		printk("[ NoSave ]");
+	if (PageReserved(page))
+		printk("[ Reserved ]");
+	if (PageHighMem(page))
+		printk("[ Highmem ]");
+}
+
+void proc_display_metadata_state(void)
+{
+	printk("Page number %lu. Struct page at %p, virt address %p:",
+			display_metadata_page,
+			mem_map + display_metadata_page,
+			page_address(mem_map + display_metadata_page));
+	display_metadata_state(mem_map + display_metadata_page);
+	printk("\n");
+}
+
+/*
+ * debuginfo_read_proc
+ * Functionality   : Displays information that may be helpful in debugging
+ *                   software suspend.
+ */
+int debuginfo_read_proc(char * page, char ** start, off_t off, int count,
+		int *eof, void *data)
+{
+	int info_len, copy_len;
+
+	initialise_suspend_plugins();
+	info_len = get_suspend_debug_info();
+	cleanup_suspend_plugins();
+
+	copy_len = min(info_len - (int) off, count);
+	if (copy_len < 0)
+		copy_len = 0;
+
+	if (copy_len) {
+		memcpy(page, debug_info_buffer + off, copy_len);
+		*start = page;
+	} 
+
+	if (copy_len + off == info_len)
+		*eof = 1;
+
+	free_pages((unsigned long) debug_info_buffer, 0);
+	debug_info_buffer = NULL;
+	return copy_len;
+}
+
+static int get_suspend_debug_info(void);
+
+static int allocate_bitmaps(void)
+{
+	suspend_message(SUSPEND_MEMORY, SUSPEND_VERBOSE, 1,
+			"Allocating in_use_map\n");
+	if (allocate_local_pageflags(&in_use_map, 1))
+		return 1;
+	
+	suspend_store_free_mem(SUSPEND_FREE_IN_USE_MAP, 0);
+	PRINTFREEMEM("after allocating in_use_map");
+	
+	if (allocate_local_pageflags(&pageset2_map, 1))
+		return 1;
+
+	suspend_store_free_mem(SUSPEND_FREE_PS2_MAP, 0);
+	PRINTFREEMEM("after allocating pageset2 map");
+	
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	if (allocate_local_pageflags(&unmap_map, 1))
+		return 1;
+
+	suspend_store_free_mem(SUSPEND_FREE_UNMAP_MAP, 0);
+	PRINTFREEMEM("after allocating unmap map");
+#endif	
+	
+	suspend_store_free_mem(4, 0);
+	
+	return 0;
+}
+
+static void free_metadata(void)
+{
+	put_rangepages_list();
+
+	free_ranges();
+	suspend_store_free_mem(SUSPEND_FREE_RANGE_PAGES, 1);
+	PRINTFREEMEM("after freeing ranges");
+
+	free_local_pageflags(&pageset2_map);
+	PRINTFREEMEM("after freeing pageset2 map");
+	suspend_store_free_mem(SUSPEND_FREE_PS2_MAP, 1);
+
+	free_local_pageflags(&in_use_map);
+	PRINTFREEMEM("after freeing inuse map");
+	suspend_store_free_mem(SUSPEND_FREE_IN_USE_MAP, 1);
+}
+
+/*
+ * software_suspend_pending
+ * Functionality   : First level of code for software suspend invocations.
+ *                   Stores and restores load averages (to avoid a spike),
+ *                   allocates bitmaps, freezes processes and eats memory
+ *                   as required before suspending drivers and invoking
+ *                   the 'low level' code to save the state to disk.
+ *                   By the time we return from do_suspend2_lowlevel, we
+ *                   have either failed to save the image or successfully
+ *                   suspended and reloaded the image. The difference can
+ *                   be discerned by checking SUSPEND_ABORTED.
+ * Called From     : 
+ */
+
+extern void free_pageset_size_bloat(void);
+
+void do_activate(void)
+{
+	int i;
+
+        /* Suspend always runs on processor 0 */ 
+	ensure_on_processor_zero();
+
+	display_nosave_pages();
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE
+	if (TEST_RESULT_STATE(SUSPEND_KEPT_IMAGE)) {
+		if (TEST_ACTION_STATE(SUSPEND_KEEP_IMAGE)) {
+			printk("Image already stored:"
+				" powering down immediately.");
+			suspend_power_down();
+			return;	/* It might now, but just in case we're using S3*/
+		} else {
+			printk("Invalidating previous image.\n");
+			active_writer->ops.writer.invalidate_image();
+		}
+	}
+#endif
+
+	printk(name_suspend "Initiating a software suspend cycle.\n");
+	set_suspend_state(SUSPEND_RUNNING);
+
+	max_ranges_used = 0;
+	nr_suspends++;
+	clear_suspend_state(SUSPEND_NOW_RESUMING);
+	
+	suspend_io_time[0][0] = suspend_io_time[0][1] = suspend_io_time[1][0] =
+		suspend_io_time[1][1] = 0;
+
+	PRINTFREEMEM("at start of do_activate");
+	suspend_store_free_mem(SUSPEND_FREE_BASE, 0);
+
+	suspend2_prepare_console();
+
+	free_metadata();	/* We might have kept it */
+
+	if (suspend_version_specific_initialise())
+		goto out;
+
+	if (allocate_bitmaps())
+		goto out;
+	
+	PRINTFREEMEM("after allocating bitmaps");
+
+	display_nosave_pages();
+
+	set_chain_names(&pagedir1);
+	set_chain_names(&pagedir2);
+
+	if (initialise_suspend_plugins())
+		goto out;
+
+	PRINTFREEMEM("after initialising plugins");
+	suspend_store_free_mem(SUSPEND_FREE_INIT_PLUGINS, 0);
+
+	/* Free up memory if necessary */
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_VERBOSE, 1,
+			"Preparing image.\n");
+	if (prepare_image() || TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto out;
+
+	PRINTFREEMEM("after preparing image");
+
+	if (TEST_ACTION_STATE(SUSPEND_FREEZER_TEST))
+		goto out;
+
+	display_nosave_pages();
+
+	if (!TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+		prepare_status(1, 0, "Starting to save the image..");
+		save_image();
+	}
+	
+out:
+	free_pageset_size_bloat();
+
+	PRINTFREEMEM("at 'out'");
+
+	i = get_suspend_debug_info();
+
+	suspend_store_free_mem(SUSPEND_FREE_DEBUG_INFO, 0);
+
+	clear_suspend_state(SUSPEND_USE_MEMORY_POOL);
+
+	free_pagedir(&pagedir2);
+	PRINTFREEMEM("after freeing pagedir 1");
+	free_pagedir(&pagedir1);
+	PRINTFREEMEM("after freeing pagedir 2");
+	
+#ifdef CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE
+	if (TEST_ACTION_STATE(SUSPEND_KEEP_IMAGE) &&
+	    !TEST_ACTION_STATE(SUSPEND_ABORTED)) {
+		suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			name_suspend "Not invalidating the image due "
+			"to Keep Image being enabled.\n");
+		SET_RESULT_STATE(SUSPEND_KEPT_IMAGE);
+	} else
+#endif
+		active_writer->ops.writer.invalidate_image();
+
+	empty_suspend_memory_pool();
+	PRINTFREEMEM("after freeing memory pool");
+	suspend_store_free_mem(SUSPEND_FREE_MEM_POOL, 1);
+
+	if (!TEST_ACTION_STATE(SUSPEND_KEEP_METADATA))
+		free_metadata();
+
+#ifdef CONFIG_DEBUG_PAGE_ALLOC
+	free_local_pageflags(&unmap_map);
+	PRINTFREEMEM("after freeing unmap map");
+	suspend_store_free_mem(SUSPEND_UNMAP_MAP, 1);
+#endif
+
+	if (debug_info_buffer) {
+		/* Printk can only handle 1023 bytes, including
+		 * its level mangling. */
+		for (i = 0; i < 3; i++)
+			printk("%s", debug_info_buffer + (1023 * i));
+		free_pages((unsigned long) debug_info_buffer, 0);
+		debug_info_buffer = NULL;
+	}
+
+	PRINTFREEMEM("after freeing debug info buffer");
+	suspend_store_free_mem(SUSPEND_FREE_DEBUG_INFO, 1);
+	
+	cleanup_suspend_plugins();
+
+	PRINTFREEMEM("after cleaning up suspend plugins");
+	suspend_store_free_mem(SUSPEND_FREE_INIT_PLUGINS, 1);
+	
+	suspend_version_specific_cleanup();
+
+	display_nosave_pages();
+
+	thaw_processes(FREEZER_ALL_THREADS);
+
+	PRINTFREEMEM("after thawing processes");
+	suspend_store_free_mem(SUSPEND_FREE_FREEZER, 1);
+
+	suspend_store_free_mem(SUSPEND_FREE_BASE, 1);
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+	display_free_mem();
+#endif
+
+	clear_suspend_state(SUSPEND_RUNNING);
+	PRINTFREEMEM("at end of do_activate");
+#ifdef CONFIG_PREEMPT
+#endif
+	suspend2_cleanup_console();
+
+}
+
+int attempt_to_parse_resume_device(void)
+{
+	struct list_head *writer;
+	struct suspend_plugin_ops * this_writer;
+	int result = 0;
+	mm_segment_t oldfs;
+
+	oldfs = get_fs(); set_fs(KERNEL_DS);
+
+	active_writer = NULL;
+	clear_suspend_state(SUSPEND_RESUME_DEVICE_OK);
+	set_suspend_state(SUSPEND_DISABLED);
+
+	if (!num_writers) {
+		printk(name_suspend "No writers have been registered.\n");
+		goto out;
+	}
+	
+	if (!resume2_file[0]) {
+		result = -EINVAL;
+		goto out;
+	}
+
+	list_for_each(writer, &suspend_writers) {
+		this_writer = list_entry(writer, struct suspend_plugin_ops,
+				ops.writer.writer_list);
+
+		/* 
+		 * Not sure why you'd want to disable a writer, but
+		 * we should honour the flag if we're providing it
+		 */
+		if (this_writer->disabled) {
+			printk(name_suspend
+					"Writer '%s' is disabled. Ignoring it.\n",
+					this_writer->name);
+			continue;
+		}
+
+		result = this_writer->ops.writer.parse_image_location(
+				resume2_file, (num_writers == 1));
+
+		switch (result) {
+			case -EINVAL:
+				/* 
+				 * For this writer, but not a valid 
+				 * configuration
+				 */
+
+				printk(name_suspend
+					"Not able to successfully parse this "
+					"resume device. Suspending disabled.\n");
+				goto out;
+
+			case 0:
+				/*
+				 * For this writer and valid.
+				 */
+
+				active_writer = this_writer;
+
+				/* We may not have any filters compiled in */
+
+				set_suspend_state(SUSPEND_RESUME_DEVICE_OK);
+				clear_suspend_state(SUSPEND_DISABLED);
+				printk(name_suspend "Suspending enabled.\n");
+				goto out;
+
+			case 1:
+				/*
+				 * Not for this writer. Try the next one.
+				 */
+
+				break;
+		}
+	}
+	printk(name_suspend "No matching writer found. Suspending disabled.\n");
+	result = -EINVAL;
+out:
+	clear_suspend_state(SUSPEND_RUNNING);
+	set_fs(oldfs);
+	return result;
+}
+
+/* 
+ * 
+ */
+
+static void __suspend2_verify_checksums(void)
+{
+	if (checksum_plugin)
+		checksum_plugin->ops.checksum.check_checksums();
+}
+
+#define ALL_SETTINGS_VERSION 2
+
+/*
+ * suspend_write_compat_proc.
+ *
+ * This entry allows all of the settings to be set at once. 
+ * It was originally for compatibility with pre- /proc/suspend
+ * versions, but has been retained because it makes saving and
+ * restoring the configuration simpler.
+ */
+static int suspend_write_compat_proc(struct file *file, const char * buffer,
+		unsigned long count, void * data)
+{
+	char * buf1 = (char *) get_zeroed_page(GFP_ATOMIC), *curbuf, *lastbuf;
+	char * buf2 = (char *) get_zeroed_page(GFP_ATOMIC); 
+	int i, file_offset = 0, used_size = 0, reparse_resume_device = 0;
+	unsigned long nextval;
+	struct suspend_plugin_ops * plugin;
+	struct plugin_header * plugin_header = NULL;
+
+	if ((!buf1) || (!buf2))
+		return -ENOMEM;
+
+	while (file_offset < count) {
+		int length = count - file_offset;
+		if (length > (PAGE_SIZE - used_size))
+			length = PAGE_SIZE - used_size;
+
+		if (copy_from_user(buf1 + used_size, buffer + file_offset, length))
+			return -EFAULT;
+
+		curbuf = buf1;
+
+		if (!file_offset) {
+			/* Integers first */
+			for (i = 0; i < 8; i++) {
+				if (!*curbuf)
+					break;
+				lastbuf = curbuf;
+				nextval = simple_strtoul(curbuf, &curbuf, 0);
+				if (curbuf == lastbuf)
+					break;
+				switch (i) {
+					case 0:
+						if (nextval != ALL_SETTINGS_VERSION) {
+							printk("Error loading saved settings. This data is for version %ld, but kernel module uses format %d.\n",
+									nextval, ALL_SETTINGS_VERSION);
+							goto out;
+						}
+					case 1:
+						suspend_result = nextval;
+						break;
+					case 2:
+						suspend_action = nextval;
+						break;
+					case 3:
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+						suspend_debug_state = nextval;
+#endif
+						break;
+					case 4:
+						suspend_default_console_level = nextval;
+#ifndef CONFIG_SOFTWARE_SUSPEND_DEBUG
+						if (suspend_default_console_level > 1)
+							suspend_default_console_level = 1;
+#endif
+						break;
+					case 5:
+						image_size_limit = nextval;
+						break;
+					case 6:
+						max_async_ios = nextval;
+						if (max_async_ios > MAX_READAHEAD)
+							max_async_ios = MAX_READAHEAD;
+						if (max_async_ios < 1)
+							max_async_ios = 1;
+						break;
+					case 7:
+#ifdef CONFIG_ACPI
+						suspend_powerdown_method = nextval;
+						if (suspend_powerdown_method < 3)
+							suspend_powerdown_method = 3;
+						if (suspend_powerdown_method > 5)
+#endif
+							suspend_powerdown_method = 5;
+						break;
+				}
+
+				curbuf++;
+				while (*curbuf == ' ')
+					curbuf++;
+			}
+
+			if (count <= (curbuf - buf1))
+				goto out;
+			else {
+				list_for_each_entry(plugin, &suspend_plugins, plugin_list)
+					plugin->disabled = 1;
+			}
+		}
+
+		if (((unsigned long) curbuf  & ~PAGE_MASK) + sizeof(plugin_header) > PAGE_SIZE)
+			goto shift_buffer;
+		
+		/* Plugins */
+		plugin_header = (struct plugin_header *) curbuf;
+
+		if (((unsigned long) curbuf & ~PAGE_MASK) + sizeof(plugin_header) + plugin_header->data_length  > PAGE_SIZE)
+			goto shift_buffer;
+		
+		if (plugin_header->magic != 0xADEDC0DE) {
+			printk("Bad plugin data magic.\n");
+			break;
+		}
+
+		plugin = find_plugin_given_name(plugin_header->name);
+
+		if (plugin) {	/* May validly have config saved for a plugin not now loaded */
+			if ((plugin->type == WRITER_PLUGIN) &&
+			    ((!active_writer && plugin->disabled && !plugin_header->disabled) ||
+			     (active_writer == plugin && plugin_header->disabled)))
+				reparse_resume_device = 1;
+			plugin->disabled = plugin_header->disabled;
+			if (plugin_header->data_length)
+				plugin->load_config_info(curbuf + sizeof(struct plugin_header), 
+						plugin_header->data_length);
+		} else
+			printk("Data for plugin %s not used because not currently loaded.\n", plugin_header->name);
+
+		curbuf += sizeof(struct plugin_header) + plugin_header->data_length;
+
+shift_buffer:
+		if (!(curbuf - buf1))
+			break;
+
+		file_offset += curbuf - buf1;
+		
+		used_size = PAGE_SIZE + buf1 - curbuf;
+		memcpy(buf2, curbuf, used_size);
+		memcpy(buf1, buf2, used_size);
+	}
+out:
+	free_pages((unsigned long) buf1, 0);
+	free_pages((unsigned long) buf2, 0);
+	
+	if (reparse_resume_device) {
+		printk("Active writer disabled or no active writer and one or more just enabled. Reparsing resume device.\n");
+		attempt_to_parse_resume_device();
+	}
+	
+	return count;
+}
+
+/*
+ * suspend_read_compat_proc.
+ *
+ * Like it's _write_ sibling, this entry allows all of the settings
+ * to be read at once.
+ * It too was originally for compatibility with pre- /proc/suspend
+ * versions, but has been retained because it makes saving and
+ * restoring the configuration simpler.
+ */
+static int suspend_read_compat_proc(char * page, char ** start, off_t off, int count,
+		int *eof, void *data)
+{
+	struct suspend_plugin_ops * this_plugin;
+	char * buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	int index = 1, file_pos = 0, page_offset = 0, len;
+	int copy_len = 0;
+	struct plugin_header plugin_header;
+
+	if (!buffer) {
+		printk("Failed to allocate a buffer for getting "
+				"plugin configuration info.\n");
+		return -ENOMEM;
+	}
+		
+	plugin_header.magic = 0xADEDC0DE;
+
+	len = sprintf(buffer, "%d %ld %ld %ld %d %d %d %ld\n",
+			ALL_SETTINGS_VERSION,
+			suspend_result,
+			suspend_action,
+			suspend_debug_state,
+			suspend_default_console_level,
+			image_size_limit,
+			max_async_ios,
+			suspend_powerdown_method);
+
+	if (len >= off) {
+		copy_len = (len < off + count) ? len - off : count - off;
+		memcpy(page, buffer + off, copy_len);
+		page_offset+= copy_len;
+	}
+
+	file_pos += len;
+
+	/* 
+	 * We have to know which data goes with which plugin, so we at
+	 * least write a length of zero for a plugin. Note that we are
+	 * also assuming every plugin's config data takes <= PAGE_SIZE.
+	 */
+
+	/* For each plugin (in registration order) */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+
+		/* Get the data from the plugin */
+		if (this_plugin->save_config_info) {
+			plugin_header.data_length = this_plugin->save_config_info(buffer);
+		} else
+			plugin_header.data_length = 0;
+
+		if (file_pos > (off + count)) {
+			file_pos += sizeof(struct plugin_header) + plugin_header.data_length;
+			continue;
+		}
+
+		len = 0;
+		if ((file_pos + sizeof(struct plugin_header) >= off) &&
+		    (file_pos < (off + count))) {
+
+			/* Save the details of the plugin */
+			memcpy(plugin_header.name, this_plugin->name, 
+					SUSPEND_MAX_PLUGIN_NAME_LENGTH);
+			plugin_header.disabled = this_plugin->disabled;
+			plugin_header.type = this_plugin->type;
+			plugin_header.index = index++;
+			
+			copy_len = sizeof(struct plugin_header);
+
+			if (copy_len + page_offset > count)
+				copy_len = count - page_offset;
+
+			memcpy(page + page_offset,
+				 ((char *) &plugin_header) + off + page_offset - file_pos,
+				 copy_len);	 
+
+			page_offset += copy_len;
+		}
+
+		file_pos += sizeof(struct plugin_header);
+
+		if (plugin_header.data_length && (file_pos >= off) && (file_pos < (off + count))) {
+			copy_len = plugin_header.data_length;
+
+			if (copy_len + page_offset > count + off)
+				copy_len = count - page_offset;
+			
+			memcpy(page + page_offset,
+				 buffer,
+				 copy_len);	 
+
+			page_offset += copy_len;
+
+		}
+
+		file_pos += plugin_header.data_length;
+		
+	}
+	free_pages((unsigned long) buffer, 0);
+	if (page_offset < count)
+		*eof = 1;
+	return page_offset;
+}
+
+extern int initialise_suspend_plugins(void);
+extern void cleanup_suspend_plugins(void);
+static char suspend_core_version[] = SUSPEND_CORE_VERSION;
+
+static int resume2_write_proc(void)
+{
+	mm_segment_t	oldfs;
+
+	oldfs = get_fs(); set_fs(KERNEL_DS);
+	initialise_suspend_plugins();
+	attempt_to_parse_resume_device();
+	cleanup_suspend_plugins();
+	set_fs(oldfs);
+	return 0;
+}
+
+/*
+ * Core proc entries that aren't built in.
+ *
+ * This array contains entries that are automatically registered at
+ * boot. Plugins and the console code register their own entries separately.
+ */
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "all_settings",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .data = {
+		  .special = {
+	  		 .read_proc	= suspend_read_compat_proc,
+			 .write_proc	= suspend_write_compat_proc,
+		  }
+	  }
+	},
+
+	{ .filename			= "debug_info",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .data = {
+		  .special = {
+			  .read_proc	= debuginfo_read_proc,
+		  }
+	  }
+	},
+	
+	{ .filename			= "disable_sysdev_suspend",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_DISABLE_SYSDEV_SUPPORT,
+		  }
+	  }
+	},
+
+	{ .filename			= "freeze_timers",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_FREEZE_TIMERS,
+		  }
+	  }
+	},
+
+	{ .filename			= "image_size_limit",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &image_size_limit,
+			  .minimum	= -2,
+			  .maximum	= 32767,
+		  }
+	  }
+	},
+
+	{ .filename			= "last_result",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	=  &suspend_result,
+		  }
+	  }
+	},
+	
+	{ .filename			= "reboot",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_REBOOT,
+		  }
+	  }
+	},
+	  
+	{ .filename			= "resume2",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		  .string = {
+			  .variable	= resume2_file,
+			  .max_length	= 255,
+		  }
+	  },
+	  .write_proc	= resume2_write_proc,
+	},
+
+
+	{ .filename			= "version",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		  .string = {
+			  .variable	= suspend_core_version,
+		  }
+	  }
+	},
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+	{ .filename			= "freezer_test",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_FREEZER_TEST,
+		  }
+	  }
+	},
+
+	{ .filename			= "keep_metadata",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_KEEP_METADATA,
+		  }
+	  }
+	},
+
+	{ .filename			= "test_filter_speed",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_TEST_FILTER_SPEED,
+		  }
+	  }
+	},
+
+	{ .filename			= "slow",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_SLOW,
+		  }
+	  }
+	},
+	
+	{ .filename			= "display_metadata_page",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &display_metadata_page,
+		  }
+	  }
+	},
+#endif
+	  
+	{ .filename			= "forced_pageset1_size",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &forced_ps1_size,
+		  }
+	  }
+	},
+
+	{ .filename			= "forced_pageset2_size",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &forced_ps2_size,
+		  }
+	  }
+	},
+
+#if defined(CONFIG_ACPI)
+	{ .filename			= "powerdown_method",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &suspend_powerdown_method,
+			  .minimum	= 3,
+			  .maximum	= 5,
+		  }
+	  }
+	},
+#endif
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE
+	{ .filename			= "keep_image",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_KEEP_IMAGE,
+		  }
+	  }
+	},
+#endif
+};
+
+extern int debuginfo_read_proc(char * page, char ** start, off_t off, int count,
+		int *eof, void *data);
+
+/*
+ * Called from init kernel_thread.
+ * We check if we have an image and if so we try to resume.
+ * We also start ksuspendd if configuration looks right.
+ */
+
+extern int freeze_processes(int no_progress);
+
+static int do_resume(void)
+{
+	int ret = 0;
+	int read_image_result = 0;
+
+	/* Suspend always runs on processor 0 */
+	ensure_on_processor_zero();
+
+	if (sizeof(swp_entry_t) != sizeof(long)) {
+		printk(KERN_WARNING name_suspend
+			"The size of swp_entry_t != size of long. "
+			"Please report this!\n");
+		return ret;
+	}
+	
+	set_suspend_state(SUSPEND_RUNNING);
+
+	if (!resume2_file[0])
+		printk(KERN_WARNING name_suspend
+			"You need to use a resume2= command line parameter to "
+			"tell Software Suspend 2 where to look for an image.\n");
+
+	if (!(test_suspend_state(SUSPEND_RESUME_DEVICE_OK)))
+		attempt_to_parse_resume_device();
+
+	if (!(test_suspend_state(SUSPEND_RESUME_DEVICE_OK))) {
+		/* 
+		 * Without a usable storage device we can do nothing - 
+		 * even if noresume is given
+		 */
+
+		if (!num_writers)
+			printk(KERN_ALERT name_suspend
+				"No writers have been registered.\n");
+		else
+			printk(KERN_ALERT name_suspend
+				"Missing or invalid storage location "
+				"(resume2= parameter). Please correct and "
+				"rerun lilo (or equivalent) before "
+				"suspending.\n");
+		clear_suspend_state(SUSPEND_RUNNING);
+		return ret;
+	}
+
+	/* We enable the possibility of machine suspend */
+	orig_mem_free = real_nr_free_pages();
+
+	suspend_task = current->pid;
+
+	read_image_result = read_primary_suspend_image(); /* non fatal error ignored */
+
+	if (test_suspend_state(SUSPEND_NORESUME_SPECIFIED))
+		printk(KERN_WARNING name_suspend "Resuming disabled as requested.\n");
+
+	if (read_image_result) {
+		suspend_task = 0;
+		clear_suspend_state(SUSPEND_RUNNING);
+		return ret;
+	}
+
+	/* 
+	 * Ensure our suspend device tree is configured (2.6) as
+	 * at suspend time
+	 */
+	
+	suspend_version_specific_initialise();
+
+	freeze_processes(1);
+
+	prepare_status(0, 0,
+		"Copying original kernel back (no status - sensitive!)...");
+	
+	do_suspend2_lowlevel(1);
+	BUG();
+
+	return ret;
+}
+
+extern int suspend_plugin_keypress(unsigned int keycode);
+extern void request_abort_suspend(void);
+extern void schedule_suspend_message(int message_number);
+
+int suspend_keypress(unsigned int keycode)
+{
+	/* These keys work even if no output is enabled.
+	 * (To get this far, we must be suspending or resuming).
+	 */
+	switch (keycode) {
+		case 27:
+			/* Abort suspend */
+			if (TEST_ACTION_STATE(SUSPEND_CAN_CANCEL))
+				request_abort_suspend();
+			break;
+		case 114:
+			/* Otherwise, if R pressed, toggle rebooting */
+			suspend_action ^= (1 << SUSPEND_REBOOT);
+			schedule_suspend_message(2);
+			break;
+		default:
+			return suspend_plugin_keypress(keycode);
+	}
+	return 1;
+}
+
+extern void suspend_early_boot_message_plugins(void);
+extern void cleanup_finished_suspend_io(void);
+
+struct suspend2_core_ops core_ops = {
+	.do_suspend = do_activate,
+	.do_resume = do_resume,
+	.resume1 = do_suspend2_resume_1, 
+	.resume2 = do_suspend2_resume_2, 
+	.suspend1 = do_suspend2_suspend_1, 
+	.suspend2 = do_suspend2_suspend_2, 
+	.free_pool_pages = free_suspend_pool_pages,
+	.get_pool_pages = get_suspend_pool_pages,
+	.get_grabbed_pages = get_grabbed_pages,
+	.cleanup_finished_io = cleanup_finished_suspend_io,
+	.suspend_message = __suspend_message,
+	.update_status = update_status,
+	.prepare_status = prepare_status,
+	.schedule_message = schedule_suspend_message,
+	.early_boot_plugins = suspend_early_boot_message_plugins,
+	.keypress = suspend_keypress,
+	.verify_checksums = __suspend2_verify_checksums,
+};
+
+static struct proc_dir_entry *compat_parent;
+extern void suspend_memory_pool_init(void);
+
+static __init int core_load(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	if (suspend2_register_core(&core_ops))
+		return -EBUSY;
+
+	printk("Software Suspend Core.\n");
+	for (i=0; i< numfiles; i++)
+		suspend_register_procfile(&proc_params[i]);
+
+	suspend_console_proc_init();
+
+	suspend_memory_pool_init();
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	return 0;
+#else
+	return (!!compat_parent);
+#endif
+}
+
+#ifdef MODULE
+static __exit void core_unload(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend Core unloading.\n");
+	suspend_console_proc_exit();
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&proc_params[i]);
+
+	suspend2_unregister_core();
+}
+
+module_init(core_load);
+module_exit(core_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 core");
+#else
+late_initcall(core_load);
+#endif
+EXPORT_SYMBOL(checksum_map);
+EXPORT_SYMBOL(attempt_to_parse_resume_device);


