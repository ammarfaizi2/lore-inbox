Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271011AbTGQU6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271019AbTGQU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:58:53 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:62353 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S271011AbTGQU6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:58:42 -0400
Date: Thu, 17 Jul 2003 23:12:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Make CONFIG_ACPI_SLEEP independend on CONFIG_SOFTWARE_SUSPEND
Message-ID: <20030717211258.GA10221@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This separates CONFIG_ACPI_SLEEP and CONFIG_SOFTWARE_SUSPEND. That
should end the user confusion. It also updates obsolete docs, and
makes code less noisy. Please apply,
								Pavel
--- clean/arch/i386/Kconfig	2003-07-14 22:12:12.000000000 +0200
+++ linux/arch/i386/Kconfig	2003-07-15 17:16:26.000000000 +0200
@@ -829,24 +829,19 @@
 	  (patch for sysvinit needed). 
 
 	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+	  booting the, pass 'resume=/dev/swappartition' and kernel will 
 	  detect the saved image, restore the memory from
 	  it and then it continues to run as before you've suspended.
 	  If you don't want the previous state to continue use the 'noresume'
 	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
+	  you must re-mkswap your swap partitions. It does not work with swap
+	  files.
 
 	  Right now you may boot without resuming and then later resume but
 	  in meantime you cannot use those swap partitions/files which were
 	  involved in suspending. Also in this case there is a risk that buffers
 	  on disk won't match with saved ones.
 
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
 	  For more information take a look at Documentation/swsusp.txt.
 
 source "drivers/acpi/Kconfig"
--- clean/arch/i386/kernel/Makefile	2003-07-06 20:06:50.000000000 +0200
+++ linux/arch/i386/kernel/Makefile	2003-07-15 17:25:32.000000000 +0200
@@ -24,7 +24,8 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_PM)		+= suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT)	+= summit.o
 obj-$(CONFIG_EDD)             	+= edd.o
--- clean/arch/i386/kernel/suspend_asm.S	2003-05-27 13:42:29.000000000 +0200
+++ linux/arch/i386/kernel/suspend_asm.S	2003-07-15 17:25:55.000000000 +0200
@@ -32,6 +32,7 @@
 saved_context_eflags:
 	.long	0
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 	.text
 
 ENTRY(do_magic)
@@ -117,4 +118,4 @@
 loop2:
        .quad 0
        .previous
-	
\ No newline at end of file
+#endif
\ No newline at end of file
--- clean/arch/i386/kernel/sysenter.c	2003-05-27 13:42:29.000000000 +0200
+++ linux/arch/i386/kernel/sysenter.c	2003-07-11 23:01:54.000000000 +0200
@@ -31,8 +31,6 @@
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp1, 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
-
-	printk("Enabling SEP on CPU %d\n", cpu);
 	put_cpu();	
 }
 
--- clean/drivers/acpi/Kconfig	2003-06-24 12:27:45.000000000 +0200
+++ linux/drivers/acpi/Kconfig	2003-07-15 17:08:40.000000000 +0200
@@ -58,8 +58,8 @@
 	default y
 
 config ACPI_SLEEP
-	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
+	bool "Sleep States (EXPERIMENTAL)"
+	depends on X86 && ACPI && !ACPI_HT_ONLY && EXPERIMENTAL
 	---help---
 	  This option adds support for ACPI suspend states. 
 
--- clean/drivers/acpi/sleep/main.c	2003-07-11 21:38:35.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2003-07-11 23:45:36.000000000 +0200
@@ -69,10 +75,6 @@
  * First, we call to the device driver layer to save device state.
  * Once we have that, we save whatevery processor and kernel state we
  * need to memory.
- * If we're entering S4, we then write the memory image to disk.
- *
- * Only then is it safe for us to power down devices, since we may need
- * the disks and upstream buses to write to.
  */
 acpi_status
 acpi_system_save_state(
@@ -197,7 +199,7 @@
 		break;
 	}
 	local_irq_restore(flags);
-	printk(KERN_CRIT "Back to C!\n");
+	printk(KERN_DEBUG "Back to C!\n");
 
 	return status;
 }
--- clean/drivers/base/power.c	2003-06-15 22:42:36.000000000 +0200
+++ linux/drivers/base/power.c	2003-07-11 22:43:21.000000000 +0200
@@ -52,8 +52,6 @@
 	struct device * dev;
 	int error = 0;
 
-	printk(KERN_EMERG "Suspending devices\n");
-
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
 		if (dev->driver && dev->driver->suspend) {
@@ -114,8 +112,6 @@
 		}
 	}
 	up_write(&devices_subsys.rwsem);
-
-	printk(KERN_EMERG "Devices Resumed\n");
 }
 
 /**
@@ -125,8 +121,6 @@
 {
 	struct device * dev;
 	
-	printk(KERN_EMERG "Shutting down devices\n");
-
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
 		pr_debug("shutting down %s: ",dev->name);
--- clean/drivers/pcmcia/yenta_socket.c	2003-07-14 22:12:19.000000000 +0200
+++ linux/drivers/pcmcia/yenta_socket.c	2003-07-14 22:18:32.000000000 +0200
@@ -899,7 +899,10 @@
 
 static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
 {
-	return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
+	/* FIXME: We should really let devices to act on *all* levels :-(.
+	   If you put something else than SUSPEND_SAVE_STATE,
+	   pcmcia_socket_dev_suspend() will simply do nothing due to its check. */
+	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
 }
 
 
--- clean/include/linux/reboot.h	2003-06-15 22:43:36.000000000 +0200
+++ linux/include/linux/reboot.h	2003-07-09 01:34:18.000000000 +0200
@@ -21,7 +21,7 @@
  * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
- * SW_SUSPEND  Suspend system using Software Suspend if compiled in
+ * SW_SUSPEND  Suspend system using software suspend if compiled in.
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
--- clean/include/linux/suspend.h	2003-03-06 23:26:14.000000000 +0100
+++ linux/include/linux/suspend.h	2003-07-15 17:18:03.000000000 +0200
@@ -55,10 +55,6 @@
 
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
-extern void refrigerator(unsigned long);
-
-extern int freeze_processes(void);
-extern void thaw_processes(void);
 
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
@@ -75,16 +71,26 @@
 extern void do_suspend_lowlevel(int resume);
 extern void do_suspend_lowlevel_s4bios(int resume);
 
+#ifndef CONFIG_PM
+#error Bad config
+#endif
+
 #else
-static inline void software_suspend(void)
-{
-}
+static inline void software_suspend(void) { }
 #define software_resume()		do { } while(0)
 #define register_suspend_notifier(a)	do { } while(0)
 #define unregister_suspend_notifier(a)	do { } while(0)
+#endif
+
+#ifdef CONFIG_PM
+extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+#else
 #define refrigerator(a)			do { BUG(); } while(0)
 #define freeze_processes()		do { panic("You need CONFIG_SOFTWARE_SUSPEND to do sleeps."); } while(0)
 #define thaw_processes()		do { } while(0)
 #endif
 
+
 #endif /* _LINUX_SWSUSP_H */
--- clean/kernel/Makefile	2003-05-27 13:44:02.000000000 +0200
+++ linux/kernel/Makefile	2003-07-15 17:17:04.000000000 +0200
@@ -17,7 +17,7 @@
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_PM) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
--- clean/kernel/suspend.c	2003-07-11 21:38:49.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-16 12:36:17.000000000 +0200
@@ -65,6 +65,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 extern long sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
@@ -78,7 +79,6 @@
 #undef SUSPEND_CONSOLE
 #endif
 
-#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
@@ -139,25 +139,25 @@
 
 static const char name_suspend[] = "Suspend Machine: ";
 static const char name_resume[] = "Resume Machine: ";
+#endif
 
 /*
  * Debug
  */
-#define	DEBUG_DEFAULT
-#undef	DEBUG_PROCESS
+#undef	DEBUG_DEFAULT
 #undef	DEBUG_SLOW
-#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
+#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
-# define PRINTK(f, a...)       printk(f, ## a)
+# define PRINTK(f, a...)	printk(f, ## a)
 #else
-# define PRINTK(f, a...)
+# define PRINTK(f, a...)	do {} while (0)
 #endif
 
 #ifdef DEBUG_SLOW
 #define MDELAY(a) mdelay(a)
 #else
-#define MDELAY(a)
+#define MDELAY(a) do {} while (0)
 #endif
 
 /*
@@ -173,6 +173,8 @@
 			if (p->state == TASK_ZOMBIE) \
 				continue;
 
+#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
+
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
 {
@@ -247,17 +249,20 @@
 	do_each_thread(g, p) {
 		INTERESTING(p);
 		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
+		if (p->flags & PF_FROZEN)
+			p->flags &= ~PF_FROZEN;
 		else
 			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
 		wake_up_process(p);
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	schedule();
 	printk( " done\n" );
 	MDELAY(500);
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * Saving part...
  */
@@ -561,7 +566,6 @@
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
-		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -583,8 +587,8 @@
 		return 1;
 
 	set_console (SUSPEND_CONSOLE);
-	if(vt_waitactive(SUSPEND_CONSOLE)) {
-		PRINTK("Bummer. Can't switch VCs.");
+	if (vt_waitactive(SUSPEND_CONSOLE)) {
+		printk(KERN_ERR "Bummer. Can't switch VCs.\n");
 		return 1;
 	}
 	orig_kmsg = kmsg_redirect;
@@ -852,7 +856,6 @@
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 static void do_software_suspend(void)
@@ -888,12 +891,11 @@
 			 * using normal kernel mechanism.
 			 */
 			do_magic(0);
-		PRINTK("Restarting processes...\n");
 		thaw_processes();
 	}
 	software_suspend_enabled = 1;
 	MDELAY(1000);
-	restore_console ();
+	restore_console();
 }
 
 /*
@@ -906,7 +908,7 @@
 		return;
 
 	software_suspend_enabled = 0;
-	BUG_ON(in_interrupt());
+	BUG_ON(in_atomic());
 	do_software_suspend();
 }
 
@@ -1279,4 +1281,5 @@
 
 EXPORT_SYMBOL(software_suspend);
 EXPORT_SYMBOL(software_suspend_enabled);
+#endif
 EXPORT_SYMBOL(refrigerator);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
