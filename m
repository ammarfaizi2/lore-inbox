Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVGFDQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVGFDQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVGFDP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:15:28 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:8089 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262065AbVGFCT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:26 -0400
Subject: [PATCH] [29/48] Suspend2 2.1.9.8 for 2.6.12: 606-all-settings.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:42 +1000
Message-Id: <11206164424113@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 607-atomic-copy.patch-old/kernel/power/suspend2_core/atomic_copy.c 607-atomic-copy.patch-new/kernel/power/suspend2_core/atomic_copy.c
--- 607-atomic-copy.patch-old/kernel/power/suspend2_core/atomic_copy.c	1970-01-01 10:00:00.000000000 +1000
+++ 607-atomic-copy.patch-new/kernel/power/suspend2_core/atomic_copy.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,465 @@
+/*
+ * SMP support:
+ * CPU enters this routine during suspend. All other CPUs enter
+ * __smp_suspend_lowlevel. The one through
+ * which the suspend is initiated (which, for simplicity, is always CPU 0)
+ * sends the others here using an IPI during do_suspend2_suspend_1. They
+ * remain here until after the atomic copy of the kernel is made, to ensure
+ * that they don't mess with memory in the meantime (even just idling will
+ * do that). Once the atomic copy is made, they are free to carry on idling.
+ * Note that we must let them go, because if we're using compression, the
+ * vfree calls in the compressors will result in IPIs being called and hanging
+ * because the CPUs are still here.
+ *
+ * At resume time, we do a similar thing. CPU 0 sends the others in here using
+ * an IPI. It then copies the original kernel back, restores its own processor
+ * context and flushes local tlbs before freeing the others to do the same.
+ * They can then go back to idling while CPU 0 reloads pageset 2, cleans up
+ * and unfreezes the processes.
+ *
+ * (Remember that freezing and thawing processes also uses IPIs, as may
+ * decompressing the data. Again, therefore, we cannot leave the other processors
+ * in here).
+ * 
+ * At the moment, we do nothing about APICs, even though the code is there.
+ */
+
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <asm/setup.h>
+#include <asm/suspend2.h>
+#include <asm/param.h>
+#include "suspend2_common.h"
+#include "io.h"
+#include "power_off.h"
+#include "version.h"
+#include "driver_model.h"
+#include "ui.h"
+#include "plugins.h"
+#include "atomic_copy.h"
+#include "suspend.h"
+#include "smp.h"
+
+volatile static int state1 __nosavedata = 0;
+volatile static int state2 __nosavedata = 0;
+volatile static int state3 __nosavedata = 0;
+volatile static int io_speed_save[2][2] __nosavedata;
+
+static dyn_pageflags_t __nosavedata origmap;
+static dyn_pageflags_t __nosavedata copymap;
+static int __nosavedata origoffset;
+static int __nosavedata copyoffset;
+
+__nosavedata char resume_commandline[COMMAND_LINE_SIZE];
+
+static atomic_t atomic_copy_hold;
+
+/**
+ * suspend2_resume_1
+ * Functionality   : Preparatory steps for copying the original kernel back.
+ * Called From     : do_suspend2_lowlevel
+ **/
+
+static void suspend2_resume_1(void)
+{
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			name_suspend "About to copy pageset1 back...\n");
+
+	suspend_drivers_suspend(SUSPEND_DRIVERS_IRQS_ENABLED);
+	local_irq_disable(); /* irqs might have been re-enabled on us */
+
+	suspend_drivers_suspend(SUSPEND_DRIVERS_IRQS_DISABLED);
+	local_irq_enable();
+
+	suspend2_map_atomic_copy_pages();
+
+	/* Get other cpus ready to restore their original contexts */
+	smp_suspend();
+
+	local_irq_disable();
+
+	preempt_disable();
+
+	barrier();
+	mb();
+}
+
+/*
+ * suspend2_resume_2
+ * Functionality   : Steps taken after copying back the original kernel at
+ *                   resume.
+ * Key Assumptions : Will be able to read back secondary pagedir (if 
+ *                   applicable).
+ * Called From     : do_suspend2_lowlevel
+ */
+
+static void suspend2_resume_2(void)
+{
+	set_suspend_state(SUSPEND_NOW_RESUMING);
+	set_suspend_state(SUSPEND_PAGESET2_NOT_LOADED);
+
+	suspend2_unmap_atomic_copy_pages();
+
+	preempt_enable();
+
+	local_irq_disable();
+	suspend_drivers_resume(SUSPEND_DRIVERS_IRQS_DISABLED);
+	local_irq_enable();
+
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_USE_3DNOW)
+	preempt_enable();
+#endif
+
+	suspend_drivers_resume(SUSPEND_DRIVERS_IRQS_ENABLED);
+
+	userui_redraw();
+
+	check_shift_keys(1, "About to reload secondary pagedir.");
+
+	read_pageset2(0);
+	clear_suspend_state(SUSPEND_PAGESET2_NOT_LOADED);
+	
+	suspend2_prepare_status(0, 0, "Cleaning up...");
+}
+
+
+/*
+ * suspend2_suspend_1
+ * Functionality   : Steps taken prior to saving CPU state and the image
+ *                   itself.
+ * Called From     : do_suspend2_lowlevel
+ */
+
+static void suspend2_suspend_1(void)
+{
+	/* Save other cpu contexts */
+	smp_suspend();
+
+	suspend_drivers_suspend(SUSPEND_DRIVERS_IRQS_ENABLED);
+
+	mb();
+	barrier();
+
+	preempt_disable();
+	local_irq_disable();
+
+	suspend_drivers_suspend(SUSPEND_DRIVERS_IRQS_DISABLED);
+}
+
+/*
+ * suspend2_suspend_2
+ * Functionality   : Steps taken after saving CPU state to save the
+ *                   image and powerdown/reboot or recover on failure.
+ * Key Assumptions : save_image returns zero on success; otherwise we need to
+ *                   clean up and exit. The state on exiting this routine 
+ *                   should be essentially the same as if we have suspended,
+ *                   resumed and reached the end of suspend2_resume_2.
+ * Called From     : do_suspend2_lowlevel
+ */
+extern void suspend_power_down(void);
+
+static void suspend2_suspend_2(void)
+{
+	if (!save_image_part1()) {
+		suspend_power_down();
+
+		if (suspend2_powerdown_method == 3) {
+			int temp_result;
+
+			temp_result = read_pageset2(1);
+
+			/* If that failed, we're sunk. Panic! */
+			if (temp_result)
+				panic("Attempt to reload pagedir 2 failed. Try rebooting.");
+		}
+	}
+
+	if (!TEST_RESULT_STATE(SUSPEND_ABORT_REQUESTED) &&
+	    !TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED) &&
+	    suspend2_powerdown_method != 3)
+		printk(KERN_EMERG name_suspend
+			"Suspend failed, trying to recover...\n");
+	barrier();
+	mb();
+}
+
+/*
+ * suspend2_copyback_low
+ */
+
+void suspend2_copyback_low(void)
+{
+	unsigned long * origpage;
+	unsigned long * copypage;
+	int loop;
+
+	origmap = pageset1_map;
+	copymap = pageset1_copy_map;
+
+	origoffset = __get_next_bit_on(origmap, -1);
+	copyoffset = __get_next_bit_on(copymap, -1);
+	
+	while ((origoffset < max_mapnr) && (!PageHighMem(pfn_to_page(origoffset)))) {
+		origpage = (unsigned long *) __va(origoffset << PAGE_SHIFT);
+		copypage = (unsigned long *) __va(copyoffset << PAGE_SHIFT);
+		
+		loop = (PAGE_SIZE / sizeof(unsigned long)) - 1;
+		
+		while (loop >= 0) {
+			*(origpage + loop) = *(copypage + loop);
+			loop--;
+		}
+		
+		origoffset = __get_next_bit_on(origmap, origoffset);
+		copyoffset = __get_next_bit_on(copymap, copyoffset);
+	}
+}
+
+/*
+ * suspend2_copyback_high
+ */
+void suspend2_copyback_high(void)
+{
+	unsigned long * origpage;
+	unsigned long * copypage;
+
+	while (origoffset < max_mapnr) {
+		origpage = (unsigned long *) kmap_atomic(pfn_to_page(origoffset), KM_USER1);
+		copypage = (unsigned long *) (lowmem_page_address(pfn_to_page(copyoffset)));
+
+		memcpy(origpage, copypage, PAGE_SIZE);
+
+		kunmap_atomic(origpage, KM_USER1);
+		
+		origoffset = __get_next_bit_on(origmap, origoffset);
+		copyoffset = __get_next_bit_on(copymap, copyoffset);
+	}
+}
+
+void do_suspend2_lowlevel(int resume)
+{
+	int loop;
+
+	if (!resume) {
+
+		suspend2_pre_copy();
+
+		suspend2_suspend_1();
+
+		suspend2_save_processor_context();	/* We need to capture registers and memory at "same time" */
+
+		suspend2_suspend_2();		/* If everything goes okay, this function does not return */
+		return;
+	}
+	
+	state1 = suspend_action;
+	state2 = suspend_debug_state;
+	state3 = console_loglevel;
+	for (loop = 0; loop < 4; loop++)
+		io_speed_save[loop/2][loop%2] = 
+			suspend_io_time[loop/2][loop%2];
+
+	memcpy(resume_commandline, saved_command_line, COMMAND_LINE_SIZE);
+
+	suspend2_pre_copyback();
+
+/*
+ * Final function for resuming: after copying the pages to their original
+ * position, it restores the register state.
+ *
+ * What about page tables? Writing data pages may toggle
+ * accessed/dirty bits in our page tables. That should be no problems
+ * with 4MB page tables. That's why we require have_pse.  
+ *
+ * Critical section here: noone should touch saved memory after
+ * do_suspend2_resume_1.
+ *
+ * If we're running with DEBUG_PAGEALLOC, the boot and resume kernels both have
+ * all the pages we need mapped into kernel space, so we don't need to change
+ * page protections while doing the copy-back.
+ */
+
+	suspend2_resume_1();
+
+	suspend2_copyback_low(); /* 0 = use logical addresses */
+	
+	suspend2_restore_processor_context();
+	suspend2_flush_caches();
+
+	BUG_ON(!irqs_disabled());
+	
+	/* Now we are running with our old stack, and with registers copied
+	 * from suspend time. Let's copy back those remaining Highmem pages. */
+
+	suspend2_copyback_high();
+
+	BUG_ON(!irqs_disabled());
+
+	suspend2_flush_caches();
+
+	suspend2_post_copyback();
+
+	suspend_action = state1;
+	suspend_debug_state = state2;
+	console_loglevel = state3;
+
+	for (loop = 0; loop < 4; loop++)
+		suspend_io_time[loop/2][loop%2] =
+			io_speed_save[loop/2][loop%2];
+
+	suspend2_resume_2();
+}
+
+/* suspend_copy_pageset1
+ *
+ * Description:	Make the atomic copy of pageset1. We can't use copy_page (as we
+ * 		once did) because we can't be sure what side effects it has. On
+ * 		my old Duron, with 3DNOW, kernel_fpu_begin increments preempt
+ * 		count, making our preempt count at resume time 4 instead of 3.
+ * 		
+ * 		We don't want to call kmap_atomic unconditionally because it has
+ * 		the side effect of incrementing the preempt count, which will
+ * 		leave it one too high post resume (the page containing the
+ * 		preempt count will be copied after its incremented. This is
+ * 		essentially the same problem.
+ */
+
+void suspend2_copy_pageset1(void)
+{
+	int i, source_index = -1, dest_index = -1;
+
+	for (i = 0; i < pageset1_size; i++) {
+		unsigned long * origvirt, *copyvirt;
+		struct page * origpage;
+		int loop = (PAGE_SIZE / sizeof(unsigned long)) - 1;
+
+		source_index = __get_next_bit_on(pageset1_map, source_index);
+		dest_index = __get_next_bit_on(pageset1_copy_map, dest_index);
+
+		origpage = pfn_to_page(source_index);
+		
+		copyvirt = (unsigned long *) page_address(pfn_to_page(dest_index));
+
+	       	if (PageHighMem(origpage))
+			origvirt = kmap_atomic(origpage, KM_USER1);
+		else
+			origvirt = page_address(origpage);
+
+		while (loop >= 0) {
+			*(copyvirt + loop) = *(origvirt + loop);
+			loop--;
+		}
+		
+
+		if (PageHighMem(origpage))
+			kunmap_atomic(origvirt, KM_USER1);
+	}
+}
+
+/*
+ * suspend2_map_atomic_copy_pages
+ *
+ * When DEBUG_PAGEALLOC is enabled, we need to map the pages before
+ * an atomic copy.
+ */
+#ifdef CONFIG_DEBUG_PAGEALLOC
+void suspend2_map_atomic_copy_pages(void)
+{
+	int i = 0, source_index = -1, dest_index = -1;
+
+	for (i = 0; i < pageset1_size; i++) {
+		int orig_was_mapped = 1, copy_was_mapped = 1;
+		struct page * origpage, * copypage;
+
+		source_index = __get_next_bit_on(pageset1_map, source_index);
+		dest_index = __get_next_bit_on(pageset1_copy_map, dest_index);
+
+		origpage = pfn_to_page(source_index);
+		copypage = pfn_to_page(dest_index);
+		
+	       	if (!PageHighMem(origpage)) {
+			orig_was_mapped = suspend_map_kernel_page(origpage, 1);
+			if ((!orig_was_mapped) &&
+			    (!test_suspend_state(SUSPEND_NOW_RESUMING)))
+				SetPageUnmap(origpage);
+		}
+
+		copy_was_mapped = suspend_map_kernel_page(copypage, 1);
+		if ((!copy_was_mapped) &&
+		    (!test_suspend_state(SUSPEND_NOW_RESUMING)))
+			SetPageUnmap(copypage);
+	}
+}
+
+/*
+ * suspend2_unmap_atomic_copy_pages
+ *
+ * We also need to unmap pages when DEBUG_PAGEALLOC is enabled.
+ */
+void suspend2_unmap_atomic_copy_pages(void)
+{
+	int i;
+	for (i = 0; i < max_mapnr; i++) {
+		struct page * page = pfn_to_page(i);
+		if (PageUnmap(page))
+			suspend_map_kernel_page(page, 0);
+	}
+}
+#endif
+
+int __suspend_atomic_restore(void *data)
+{
+	while atomic_read(&atomic_copy_hold)
+		schedule();
+
+	/* Suspend always runs on processor 0 */
+	ensure_on_processor_zero();
+
+	suspend2_prepare_status(0, 0, "Freezing processes");
+	
+	freeze_processes(1);
+	
+	suspend2_prepare_status(0, 0,
+		"Copying original kernel back");
+	
+	do_suspend2_lowlevel(1);
+
+	BUG();
+	
+	return 0;
+}
+
+
+void suspend_atomic_restore(void)
+{
+	LIST_HEAD(non_conflicting_pages);
+	unsigned long next;
+	struct page * this_page, * next_page;
+	
+	/* Allocate all memory available, then free only those pages
+	 * that don't conflict. This ensures that the stack for our
+	 * copy-back thread is non-conflicting */
+	while ((next = suspend2_get_nonconflicting_page())) {
+		struct page * page = virt_to_page(next);
+		list_add(&page->lru, &non_conflicting_pages);
+	}
+
+	list_for_each_entry_safe(this_page, next_page, &non_conflicting_pages, lru)
+		__free_pages(this_page, 0);
+
+	atomic_set(&atomic_copy_hold, 1);
+
+	/* Now start the new thread */
+	BUG_ON((kernel_thread(__suspend_atomic_restore, 0,
+			CLONE_KERNEL) < 0));
+
+	suspend2_release_conflicting_pages();
+	
+	atomic_set(&atomic_copy_hold, 0);
+	
+	while(1) {
+		try_to_freeze();
+		schedule();
+	}
+}
diff -ruNp 607-atomic-copy.patch-old/kernel/power/suspend2_core/atomic_copy.h 607-atomic-copy.patch-new/kernel/power/suspend2_core/atomic_copy.h
--- 607-atomic-copy.patch-old/kernel/power/suspend2_core/atomic_copy.h	1970-01-01 10:00:00.000000000 +1000
+++ 607-atomic-copy.patch-new/kernel/power/suspend2_core/atomic_copy.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,3 @@
+extern inline void move_stack_to_nonconflicing_area(void);
+extern int save_image_part1(void);
+extern void suspend_atomic_restore(void);

