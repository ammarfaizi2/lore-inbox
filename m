Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbTEBMMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 08:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTEBMMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 08:12:21 -0400
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:23758 "EHLO
	d06lmsgate.uk.ibm.com") by vger.kernel.org with ESMTP
	id S262022AbTEBMMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 08:12:06 -0400
Date: Fri, 2 May 2003 14:23:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/3): various s390 fixes.
Message-ID: <20030502122339.GB6110@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various s390 bug fixes:
 - arch: Export empty_zero_page to be able to build binfmt_elf32 as module.
 - arch: Fix compat entries in the system call table.
 - arch: Fix call trace output and remove dead remote-debug code.
 - arch: Correct OUTPUT_ARCH for 64 bit compiles.
 - arch: Add __kernel_old_dev_t for 64 bit.
 - dasd: Don't continue on error in dasd_increase_state. Use hex_ascii view
         for the dasd debug area. Fix typo.
 - con3215: use set_current_state.
 - sclp: Fix race condition in sclp interrupt handler. Add module_init to
         get sclp initialized even if sclp is not the console.
 - cio: Fix wait_cons_dev. Add workaround for GFP_KERNEL allocation in interrupt.

diffstat:
 arch/s390/kernel/s390_ksyms.c  |    1 
 arch/s390/kernel/syscalls.S    |   10 ++++-----
 arch/s390/kernel/traps.c       |   31 ++++++++----------------------
 arch/s390/vmlinux.lds.S        |    2 -
 drivers/s390/block/dasd.c      |   18 ++++++++++-------
 drivers/s390/char/con3215.c    |    4 +--
 drivers/s390/char/sclp.c       |   42 ++++++++++++++++++++++++++---------------
 drivers/s390/cio/cio.c         |    7 ++----
 drivers/s390/cio/qdio.c        |    7 ++++--
 include/asm-s390/posix_types.h |    1 
 10 files changed, 65 insertions(+), 58 deletions(-)

diff -urN linux-2.5.68/arch/s390/kernel/s390_ksyms.c linux-2.5.68-s390/arch/s390/kernel/s390_ksyms.c
--- linux-2.5.68/arch/s390/kernel/s390_ksyms.c	Sun Apr 20 04:50:02 2003
+++ linux-2.5.68-s390/arch/s390/kernel/s390_ksyms.c	Fri May  2 14:06:43 2003
@@ -59,6 +59,7 @@
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(overflowuid);
 EXPORT_SYMBOL(overflowgid);
+EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_S390_SUPPORT
 /*
diff -urN linux-2.5.68/arch/s390/kernel/syscalls.S linux-2.5.68-s390/arch/s390/kernel/syscalls.S
--- linux-2.5.68/arch/s390/kernel/syscalls.S	Sun Apr 20 04:48:51 2003
+++ linux-2.5.68-s390/arch/s390/kernel/syscalls.S	Fri May  2 14:06:43 2003
@@ -83,9 +83,9 @@
 SYSCALL(sys_sigsuspend_glue,sys_sigsuspend_glue,sys32_sigsuspend_glue)
 SYSCALL(sys_sigpending,sys_sigpending,compat_sys_sigpending_wrapper)
 SYSCALL(sys_sethostname,sys_sethostname,sys32_sethostname_wrapper)
-SYSCALL(sys_setrlimit,sys_setrlimit,sys32_setrlimit_wrapper)	/* 75 */
-SYSCALL(sys_old_getrlimit,sys_getrlimit,sys32_old_getrlimit_wrapper)
-SYSCALL(sys_getrusage,sys_getrusage,sys32_getrusage_wrapper)
+SYSCALL(sys_setrlimit,sys_setrlimit,compat_sys_setrlimit_wrapper)	/* 75 */
+SYSCALL(sys_old_getrlimit,sys_getrlimit,compat_sys_old_getrlimit_wrapper)
+SYSCALL(sys_getrusage,sys_getrusage,compat_sys_getrusage_wrapper)
 SYSCALL(sys_gettimeofday,sys_gettimeofday,sys32_gettimeofday_wrapper)
 SYSCALL(sys_settimeofday,sys_settimeofday,sys32_settimeofday_wrapper)
 SYSCALL(sys_getgroups16,sys_ni_syscall,sys32_getgroups16_wrapper)	/* 80 old getgroups16 syscall */
@@ -122,7 +122,7 @@
 SYSCALL(sys_vhangup,sys_vhangup,sys_vhangup)
 NI_SYSCALL							/* old "idle" system call */
 NI_SYSCALL							/* vm86old for i386 */
-SYSCALL(sys_wait4,sys_wait4,sys32_wait4_wrapper)
+SYSCALL(sys_wait4,sys_wait4,compat_sys_wait4_wrapper)
 SYSCALL(sys_swapoff,sys_swapoff,sys32_swapoff_wrapper)		/* 115 */
 SYSCALL(sys_sysinfo,sys_sysinfo,sys32_sysinfo_wrapper)
 SYSCALL(sys_ipc,sys_ipc,sys32_ipc_wrapper)
@@ -199,7 +199,7 @@
 NI_SYSCALL							/* streams1 */
 NI_SYSCALL							/* streams2 */
 SYSCALL(sys_vfork_glue,sys_vfork_glue,sys_vfork_glue)		/* 190 */
-SYSCALL(sys_getrlimit,sys_getrlimit,sys32_getrlimit_wrapper)
+SYSCALL(sys_getrlimit,sys_getrlimit,compat_sys_getrlimit_wrapper)
 SYSCALL(sys_mmap2,sys_mmap2,sys32_mmap2_wrapper)
 SYSCALL(sys_truncate64,sys_ni_syscall,sys32_truncate64_wrapper)
 SYSCALL(sys_ftruncate64,sys_ni_syscall,sys32_ftruncate64_wrapper)
diff -urN linux-2.5.68/arch/s390/kernel/traps.c linux-2.5.68-s390/arch/s390/kernel/traps.c
--- linux-2.5.68/arch/s390/kernel/traps.c	Sun Apr 20 04:49:09 2003
+++ linux-2.5.68-s390/arch/s390/kernel/traps.c	Fri May  2 14:06:43 2003
@@ -282,7 +282,7 @@
                 const struct exception_table_entry *fixup;
                 fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
                 if (fixup)
-                        regs->psw.addr = fixup->fixup | ~PSW_ADDR_INSN;
+                        regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
                 else
                         die(str, regs, interruption_code);
         }
@@ -293,27 +293,14 @@
 	return (void *)((regs->psw.addr-S390_lowcore.pgm_ilc) & PSW_ADDR_INSN);
 }
 
-int do_debugger_trap(struct pt_regs *regs,int signal)
+static int do_debugger_trap(struct pt_regs *regs)
 {
-	if(regs->psw.mask&PSW_MASK_PSTATE)
-	{
-		if(current->ptrace & PT_PTRACED)
-			force_sig(signal,current);
-		else
-			return 1;
-	}
-	else
-	{
-#if CONFIG_REMOTE_DEBUG
-		if(gdb_stub_initialised)
-		{
-			gdb_stub_handle_exception(regs, signal);
-			return 0;
-		}
-#endif
-		return 1;
+	if ((regs->psw.mask & PSW_MASK_PSTATE) &&
+	    (current->ptrace & PT_PTRACED)) {
+		force_sig(SIGTRAP,current);
+		return 0;
 	}
-	return 0;
+	return 1;
 }
 
 #define DO_ERROR(signr, str, name) \
@@ -400,7 +387,7 @@
 		*((__u16 *)opcode)=*((__u16 *)location);
 	if (*((__u16 *)opcode)==S390_BREAKPOINT_U16)
         {
-		if(do_debugger_trap(regs,SIGTRAP))
+		if(do_debugger_trap(regs))
 			signal = SIGILL;
 	}
 #ifdef CONFIG_MATHEMU
@@ -659,7 +646,7 @@
 		per_info->lowcore.words.address=S390_lowcore.per_address;
 		per_info->lowcore.words.access_id=S390_lowcore.per_access_id;
 	}
-	if (do_debugger_trap(regs,SIGTRAP)) {
+	if (do_debugger_trap(regs)) {
 		/* I've seen this possibly a task structure being reused ? */
 		printk("Spurious per exception detected\n");
 		printk("switching off per tracing for this task.\n");
diff -urN linux-2.5.68/arch/s390/vmlinux.lds.S linux-2.5.68-s390/arch/s390/vmlinux.lds.S
--- linux-2.5.68/arch/s390/vmlinux.lds.S	Sun Apr 20 04:49:10 2003
+++ linux-2.5.68-s390/arch/s390/vmlinux.lds.S	Fri May  2 14:06:43 2003
@@ -12,7 +12,7 @@
 jiffies = jiffies_64 + 4;
 #else
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
-OUTPUT_ARCH(s390)
+OUTPUT_ARCH(s390:64-bit)
 ENTRY(_start)
 jiffies = jiffies_64;
 #endif
diff -urN linux-2.5.68/drivers/s390/block/dasd.c linux-2.5.68-s390/drivers/s390/block/dasd.c
--- linux-2.5.68/drivers/s390/block/dasd.c	Fri May  2 14:06:31 2003
+++ linux-2.5.68-s390/drivers/s390/block/dasd.c	Fri May  2 14:06:43 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.94 $
+ * $Revision: 1.97 $
  */
 
 #include <linux/config.h>
@@ -297,19 +297,23 @@
 	    device->target >= DASD_STATE_KNOWN)
 		rc = dasd_state_new_to_known(device);
 
-	if (device->state == DASD_STATE_KNOWN &&
+	if (!rc &&
+	    device->state == DASD_STATE_KNOWN &&
 	    device->target >= DASD_STATE_BASIC)
 		rc = dasd_state_known_to_basic(device);
 
-	if (device->state == DASD_STATE_BASIC &&
+	if (!rc &&
+	    device->state == DASD_STATE_BASIC &&
 	    device->target >= DASD_STATE_ACCEPT)
 		rc = dasd_state_basic_to_accept(device);
 
-	if (device->state == DASD_STATE_ACCEPT &&
+	if (!rc &&
+	    device->state == DASD_STATE_ACCEPT &&
 	    device->target >= DASD_STATE_READY)
 		rc = dasd_state_accept_to_ready(device);
 
-	if (device->state == DASD_STATE_READY &&
+	if (!rc &&
+	    device->state == DASD_STATE_READY &&
 	    device->target >= DASD_STATE_ONLINE)
 		rc = dasd_state_ready_to_online(device);
 
@@ -1727,7 +1731,7 @@
 dasd_release(struct inode *inp, struct file *filp)
 {
 	struct gendisk *disk = inp->i_bdev->bd_disk;
-	struct dasd_device *device = isk->private_data;
+	struct dasd_device *device = disk->private_data;
 
 	if (device->state < DASD_STATE_ACCEPT) {
 		DBF_DEV_EVENT(DBF_ERR, device, " %s",
@@ -2051,7 +2055,7 @@
 		rc = -ENOMEM;
 		goto failed;
 	}
-	debug_register_view(dasd_debug_area, &debug_sprintf_view);
+	debug_register_view(dasd_debug_area, &debug_hex_ascii_view);
 	debug_set_level(dasd_debug_area, DBF_ERR);
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
diff -urN linux-2.5.68/drivers/s390/char/con3215.c linux-2.5.68-s390/drivers/s390/char/con3215.c
--- linux-2.5.68/drivers/s390/char/con3215.c	Fri May  2 14:06:31 2003
+++ linux-2.5.68-s390/drivers/s390/char/con3215.c	Fri May  2 14:06:43 2003
@@ -697,12 +697,12 @@
 	    raw->queued_read != NULL) {
 		raw->flags |= RAW3215_CLOSING;
 		add_wait_queue(&raw->empty_wait, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(raw->lock, flags);
 		schedule();
 		spin_lock_irqsave(raw->lock, flags);
 		remove_wait_queue(&raw->empty_wait, &wait);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		raw->flags &= ~(RAW3215_ACTIVE | RAW3215_CLOSING);
 	}
 	spin_unlock_irqrestore(raw->lock, flags);
diff -urN linux-2.5.68/drivers/s390/char/sclp.c linux-2.5.68-s390/drivers/s390/char/sclp.c
--- linux-2.5.68/drivers/s390/char/sclp.c	Sun Apr 20 04:50:04 2003
+++ linux-2.5.68-s390/drivers/s390/char/sclp.c	Fri May  2 14:06:43 2003
@@ -18,7 +18,9 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
+#include <linux/init.h>
 #include <asm/s390_ext.h>
+#include <asm/processor.h>
 
 #include "sclp.h"
 
@@ -49,7 +51,7 @@
 /* Timer for init mask retries. */
 static struct timer_list retry_timer;
 
-static unsigned long sclp_status = 0;
+static volatile unsigned long sclp_status = 0;
 /* some status flags */
 #define SCLP_INIT		0
 #define SCLP_RUNNING		1
@@ -275,20 +277,24 @@
 	struct list_head *l;
 	struct sclp_req *req, *tmp;
 
+	spin_lock(&sclp_lock);
 	/*
 	 * Only process interrupt if sclp is initialized.
 	 * This avoids strange effects for a pending request
 	 * from before the last re-ipl.
 	 */
-	if (!test_bit(SCLP_INIT, &sclp_status))
+	if (!test_bit(SCLP_INIT, &sclp_status)) {
+		/* Now clear the running bit */
+		clear_bit(SCLP_RUNNING, &sclp_status);
+		spin_unlock(&sclp_lock);
 		return;
+	}
 	ext_int_param = S390_lowcore.ext_params;
 	finished_sccb = ext_int_param & EXT_INT_SCCB_MASK;
 	evbuf_pending = ext_int_param & (EXT_INT_EVBUF_PENDING |
 					 EXT_INT_STATECHANGE_PENDING);
 	irq_enter();
 	req = NULL;
-	spin_lock(&sclp_lock);
 	if (finished_sccb != 0U) {
 		list_for_each(l, &sclp_req_queue) {
 			tmp = list_entry(l, struct sclp_req, list);
@@ -299,9 +305,6 @@
 			}
 		}
 	}
-	/* Head queue a read sccb if an event buffer is pending */
-	if (evbuf_pending)
-		__sclp_unconditional_read();
 	spin_unlock(&sclp_lock);
 	/* Perform callback */
 	if (req != NULL) {
@@ -309,8 +312,13 @@
 		if (req->callback != NULL)
 			req->callback(req, req->callback_data);
 	}
+	spin_lock(&sclp_lock);
+	/* Head queue a read sccb if an event buffer is pending */
+	if (evbuf_pending)
+		__sclp_unconditional_read();
 	/* Now clear the running bit */
 	clear_bit(SCLP_RUNNING, &sclp_status);
+	spin_unlock(&sclp_lock);
 	/* and start next request on the queue */
 	sclp_start_request();
 	irq_exit();
@@ -344,8 +352,10 @@
 		      : "=m" (psw_mask) : "a" (&psw_mask) : "memory");
 
 	/* wait until ISR signals receipt of interrupt */
-	while (test_bit(SCLP_RUNNING, &sclp_status))
+	while (test_bit(SCLP_RUNNING, &sclp_status)) {
 		barrier();
+		cpu_relax();
+	}
 
 	/* disable external interruptions */
 	asm volatile ("SSM 0(%0)"
@@ -631,6 +641,14 @@
 		/* Already initialized. */
 		return 0;
 
+	spin_lock_init(&sclp_lock);
+	INIT_LIST_HEAD(&sclp_req_queue);
+
+	/* init event list */
+	INIT_LIST_HEAD(&sclp_reg_list);
+	list_add(&sclp_state_change_event.list, &sclp_reg_list);
+	list_add(&sclp_quiesce_event.list, &sclp_reg_list);
+
 	/*
 	 * request the 0x2401 external interrupt
 	 * The sclp driver is initialized early (before kmalloc works). We
@@ -640,14 +658,6 @@
 					      &ext_int_info_hwc) != 0)
 		return -EBUSY;
 
-	spin_lock_init(&sclp_lock);
-	INIT_LIST_HEAD(&sclp_req_queue);
-
-	/* init event list */
-	INIT_LIST_HEAD(&sclp_reg_list);
-	list_add(&sclp_state_change_event.list, &sclp_reg_list);
-	list_add(&sclp_quiesce_event.list, &sclp_reg_list);
-
 	/* enable service-signal external interruptions,
 	 * Control Register 0 bit 22 := 1
 	 * (besides PSW bit 7 must be set to 1 sometimes for external
@@ -762,6 +772,8 @@
 	return unprocessed;
 }
 
+module_init(sclp_init);
+
 EXPORT_SYMBOL(sclp_add_request);
 EXPORT_SYMBOL(sclp_sync_wait);
 EXPORT_SYMBOL(sclp_register);
diff -urN linux-2.5.68/drivers/s390/cio/cio.c linux-2.5.68-s390/drivers/s390/cio/cio.c
--- linux-2.5.68/drivers/s390/cio/cio.c	Sun Apr 20 04:51:13 2003
+++ linux-2.5.68-s390/drivers/s390/cio/cio.c	Fri May  2 14:06:43 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.97 $
+ *   $Revision: 1.98 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -146,7 +146,7 @@
 		/* Not status pending or not operational. */
 		return 1;
 	sch = ioinfo[tpi_info->irq];
-	if (sch)
+	if (!sch)
 		return 1;
 	irq_enter ();
 	spin_lock(&sch->lock);
@@ -658,8 +658,7 @@
 	 * before entering the spinlock we may already have
 	 * processed the interrupt on a different CPU...
 	 */
-	if (!console_subchannel_in_use ||
-	    console_subchannel.schib.scsw.actl == 0)
+	if (!console_subchannel_in_use)
 		return;
 
 	/* disable all but isc 7 (console device) */
diff -urN linux-2.5.68/drivers/s390/cio/qdio.c linux-2.5.68-s390/drivers/s390/cio/qdio.c
--- linux-2.5.68/drivers/s390/cio/qdio.c	Sun Apr 20 04:50:02 2003
+++ linux-2.5.68-s390/drivers/s390/cio/qdio.c	Fri May  2 14:06:43 2003
@@ -55,7 +55,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.48 $"
+#define VERSION_QDIO_C "$Revision: 1.49 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -1668,6 +1668,7 @@
 
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
+		/* FIXME: defer this past interrupt time */
 		qdio_establish_handle_irq(cdev, cstat, dstat);
 		break;
 
@@ -1763,7 +1764,8 @@
 		u8  ocnt;
 	} *ssqd_area;
 
-	ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	/* FIXME make this GFP_KERNEL */
+	ssqd_area = (void *)get_zeroed_page(GFP_ATOMIC | GFP_DMA);
 	if (!ssqd_area) {
 	        QDIO_PRINT_WARN("Could not get memory for chsc. Using all " \
 				"SIGAs for sch x%x.\n", sch);
@@ -2644,6 +2646,7 @@
 		return result;
 	}
 	
+	/* FIXME: don't wait forever if hardware is broken */
 	wait_event(cdev->private->wait_q,
 		   irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED ||
 		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
diff -urN linux-2.5.68/include/asm-s390/posix_types.h linux-2.5.68-s390/include/asm-s390/posix_types.h
--- linux-2.5.68/include/asm-s390/posix_types.h	Sun Apr 20 04:48:46 2003
+++ linux-2.5.68-s390/include/asm-s390/posix_types.h	Fri May  2 14:06:43 2003
@@ -65,6 +65,7 @@
 typedef __kernel_gid_t __kernel_old_gid_t;
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
+typedef unsigned short __kernel_old_dev_t;
 
 #endif /* __s390x__ */
 
