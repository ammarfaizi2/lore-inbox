Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270799AbTGVLh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbTGVLh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:37:56 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:24261 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270799AbTGVLhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:37:04 -0400
Date: Tue, 22 Jul 2003 13:51:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: FYI: my current swsusp bigdiff
Message-ID: <20030722115114.GA9272@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here it is. This is FYI, not to be applied.
								Pavel
%patch
Index: linux/drivers/input/serio/i8042.c
===================================================================
--- linux.orig/drivers/input/serio/i8042.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/input/serio/i8042.c	2003-07-20 14:34:40.000000000 +0200
@@ -432,18 +432,15 @@
  * desired.
  */
 	
-static int __init i8042_controller_init(void)
+int i8042_controller_init(void)
 {
-
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
  * before doing anything else.
  */
 
 	i8042_flush();
-
 	if (i8042_reset) {
-
 		unsigned char param;
 
 		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
Index: linux/drivers/input/keyboard/atkbd.c
===================================================================
--- linux.orig/drivers/input/keyboard/atkbd.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/input/keyboard/atkbd.c	2003-07-20 14:34:47.000000000 +0200
@@ -27,7 +27,7 @@
 
 static int atkbd_set = 2;
 #if defined(__i386__) || defined (__x86_64__)
-static int atkbd_reset;
+static int atkbd_reset = 1;
 #else
 static int atkbd_reset = 1;
 #endif
@@ -387,7 +387,7 @@
  * atkbd_probe() probes for an AT keyboard on a serio port.
  */
 
-static int atkbd_probe(struct atkbd *atkbd)
+int atkbd_probe(struct atkbd *atkbd)
 {
 	unsigned char param[2];
 
@@ -476,6 +476,9 @@
 	kfree(atkbd);
 }
 
+struct atkbd *myat;
+
+
 /*
  * atkbd_connect() is called when the serio module finds and interface
  * that isn't handled yet by an appropriate device driver. We check if
@@ -495,6 +498,7 @@
 	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
 		return;
 
+	myat = atkbd;
 	memset(atkbd, 0, sizeof(struct atkbd));
 
 	if ((serio->type & SERIO_TYPE) == SERIO_8042 && serio->write)
@@ -523,15 +527,12 @@
 	}
 
 	if (atkbd->write) {
-
 		if (atkbd_probe(atkbd)) {
 			serio_close(serio);
 			kfree(atkbd);
 			return;
 		}
-		
 		atkbd->set = atkbd_set_3(atkbd);
-
 	} else {
 		atkbd->set = 2;
 		atkbd->id = 0xab00;
Index: linux/include/linux/serio.h
===================================================================
--- linux.orig/include/linux/serio.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/serio.h	2003-07-20 14:34:55.000000000 +0200
@@ -18,10 +18,7 @@
 
 #include <linux/list.h>
 
-struct serio;
-
 struct serio {
-
 	void *private;
 	void *driver;
 	char *name;
@@ -45,7 +42,6 @@
 };
 
 struct serio_dev {
-
 	void *private;
 	char *name;
 
Index: linux/drivers/input/power.c
===================================================================
--- linux.orig/drivers/input/power.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/input/power.c	2003-07-20 14:35:05.000000000 +0200
@@ -45,9 +45,7 @@
 static int suspend_button_pushed = 0;
 static void suspend_button_task_handler(void *data)
 {
-        //extern void pm_do_suspend(void);
         udelay(200); /* debounce */
-        //pm_do_suspend();
         suspend_button_pushed = 0;
 }
 
@@ -67,8 +65,6 @@
 			case KEY_SUSPEND:
 				printk("Powering down entire device\n");
 
-				//pm_send_all(PM_SUSPEND, dev);
-
 				if (!suspend_button_pushed) {
                 			suspend_button_pushed = 1;
                         		schedule_work(&suspend_button_task);
@@ -76,6 +72,18 @@
 				break;
 			case KEY_POWER:
 				/* Hum power down the machine. */
+				{
+					char *argv[2] = {NULL, NULL};
+					char *envp[3] = {NULL, NULL, NULL};
+
+					argv[0] = "/sbin/poweroff";
+
+					/* minimal command environment */
+					envp[0] = "HOME=/";
+					envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	
+					call_usermodehelper(argv[0], argv, envp, 0);
+				}
 				break;
 			default:	
 				return;
Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2003-07-22 12:53:27.000000000 +0200
@@ -50,6 +50,18 @@
 	/* enable interrupts once again */
 	ACPI_ENABLE_IRQS();
 
+//	i8042_controller_init();
+	{
+		extern struct atkbd *myat;
+		atkbd_probe(myat);
+	}
+
+//	i8042_controller_init();
+	{
+		extern struct atkbd *myat;
+		atkbd_probe(myat);
+	}
+
 	/* restore device context */
 	device_resume(RESUME_RESTORE_STATE);
 
@@ -69,10 +81,6 @@
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
@@ -197,7 +205,7 @@
 		break;
 	}
 	local_irq_restore(flags);
-	printk(KERN_CRIT "Back to C!\n");
+	printk(KERN_DEBUG "Back to C!\n");
 
 	return status;
 }
@@ -226,6 +234,7 @@
 	if (state == ACPI_STATE_S4 && !acpi_gbl_FACS->S4bios_f)
 		return AE_ERROR;
 
+	prepare_suspend_console();
 	/*
 	 * TBD: S1 can be done without device_suspend.  Make a CONFIG_XX
 	 * to handle however when S1 failed without device_suspend.
@@ -270,6 +279,7 @@
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 	thaw_processes();
+	restore_console();
 
 	return status;
 }
Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/x86_64/kernel/time.c	2003-07-20 14:35:15.000000000 +0200
@@ -22,7 +22,7 @@
 #include <linux/time.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/device.h>
+#include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <asm/pgtable.h>
 #include <asm/vsyscall.h>
@@ -72,7 +72,7 @@
  * timer interrupt has happened already, but vxtime.trigger wasn't updated yet.
  * This is not a problem, because jiffies hasn't updated either. They are bound
  * together by xtime_lock.
-         */
+ */
 
 static inline unsigned int do_gettimeoffset_tsc(void)
 {
@@ -549,7 +549,17 @@
 	return 0;
 }
 
-void __init pit_init(void)
+static struct sysdev_class rtc_sysclass = {
+	set_kset_name("rtc"),
+};
+
+/* XXX this driverfs stuff should probably go elsewhere later -john */
+static struct sys_device device_i8253 = {
+	.id		= 0,
+	.cls	= &rtc_sysclass,
+};
+
+int __init pit_init(void)
 {
 	unsigned long flags;
 
@@ -558,6 +568,11 @@
 	outb_p(LATCH & 0xff, 0x40);	/* LSB */
 	outb_p(LATCH >> 8, 0x40);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
+
+	int error = sysdev_class_register(&rtc_sysclass);
+	if (!error)
+		error = sys_device_register(&device_i8253);
+	return error;
 }
 
 int __init time_setup(char *str)
@@ -601,8 +616,8 @@
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 	} else {
-	pit_init();
-	cpu_khz = pit_calibrate_tsc();
+		pit_init();
+		cpu_khz = pit_calibrate_tsc();
 		timename = "PIT";
 	}
 
Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/Makefile	2003-07-17 22:22:58.000000000 +0200
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
Index: linux/arch/i386/kernel/suspend_asm.S
===================================================================
--- linux.orig/arch/i386/kernel/suspend_asm.S	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/suspend_asm.S	2003-07-20 15:02:12.000000000 +0200
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
Index: linux/arch/i386/kernel/sysenter.c
===================================================================
--- linux.orig/arch/i386/kernel/sysenter.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/sysenter.c	2003-07-17 22:22:58.000000000 +0200
@@ -31,8 +31,6 @@
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp1, 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
-
-	printk("Enabling SEP on CPU %d\n", cpu);
 	put_cpu();	
 }
 
Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/Kconfig	2003-07-17 22:22:58.000000000 +0200
@@ -58,8 +58,8 @@
 	default y
 
 config ACPI_SLEEP
-	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
+	bool "Sleep States (EXPERIMENTAL)"
+	depends on X86 && ACPI && !ACPI_HT_ONLY && EXPERIMENTAL
 	---help---
 	  This option adds support for ACPI suspend states. 
 
Index: linux/drivers/base/power.c
===================================================================
--- linux.orig/drivers/base/power.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/base/power.c	2003-07-17 22:22:58.000000000 +0200
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
Index: linux/drivers/pcmcia/yenta_socket.c
===================================================================
--- linux.orig/drivers/pcmcia/yenta_socket.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/pcmcia/yenta_socket.c	2003-07-17 22:22:58.000000000 +0200
@@ -899,7 +899,10 @@
 
 static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
 {
-	return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
+	/* FIXME: We should really let devices to act on *all* levels :-(.
+	   If you put something else than SUSPEND_SAVE_STATE,
+	   pcmcia_socket_dev_suspend() will simply do nothing due to its check. */
+	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
 }
 
 
Index: linux/include/linux/reboot.h
===================================================================
--- linux.orig/include/linux/reboot.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/reboot.h	2003-07-17 22:22:58.000000000 +0200
@@ -21,7 +21,7 @@
  * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
- * SW_SUSPEND  Suspend system using Software Suspend if compiled in
+ * SW_SUSPEND  Suspend system using software suspend if compiled in.
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/suspend.h	2003-07-22 12:54:08.000000000 +0200
@@ -55,10 +55,6 @@
 
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
-extern void refrigerator(unsigned long);
-
-extern int freeze_processes(void);
-extern void thaw_processes(void);
 
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
@@ -76,15 +72,23 @@
 extern void do_suspend_lowlevel_s4bios(int resume);
 
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
 
+extern int prepare_suspend_console(void);
+extern void restore_console(void);
+
 #endif /* _LINUX_SWSUSP_H */
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/Makefile	2003-07-17 22:22:58.000000000 +0200
@@ -17,7 +17,7 @@
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_PM) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ -5,7 +5,7 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
  *
  * I'd like to thank the following people for their work:
  * 
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
@@ -139,39 +139,45 @@
 
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
  * Refrigerator and related stuff
  */
 
-#define INTERESTING(p) \
-			/* We don't want to touch kernel_threads..*/ \
-			if (p->flags & PF_IOTHREAD) \
-				continue; \
-			if (p == current) \
-				continue; \
-			if (p->state == TASK_ZOMBIE) \
-				continue;
+/* 0 = Ignore this process when freezing/thawing, 1 = freeze/thaw this process */
+static inline int interesting_process(struct task_struct *p)
+{
+	if (p->flags & PF_IOTHREAD)
+		return 0;
+	if (p == current)
+		return 0;
+	if ((p->state == TASK_ZOMBIE) || (p->state == TASK_DEAD))
+		return 0;
+
+	return 1;
+}
+
+#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
@@ -212,9 +218,12 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			INTERESTING(p);
+			if (!interesting_process(p))
+				continue;
 			if (p->flags & PF_FROZEN)
 				continue;
+			if (p->state == TASK_STOPPED)
+				continue;
 
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
@@ -245,19 +254,56 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
-		else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
+ 		if (!interesting_process(p))
+			continue;
+ 		if (p->flags & PF_FROZEN) {
+ 			p->flags &= ~PF_FROZEN;
+ 			wake_up_process(p);
+ 		} else
+ 			PRINTK(KERN_INFO " Strange, %s not frozen\n", p->comm );
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	schedule();
 	printk( " done\n" );
 	MDELAY(500);
 }
 
+int prepare_suspend_console(void)
+{
+	orig_loglevel = console_loglevel;
+	console_loglevel = new_loglevel;
+
+#ifdef CONFIG_VT
+	orig_fgconsole = fg_console;
+#ifdef SUSPEND_CONSOLE
+	if(vc_allocate(SUSPEND_CONSOLE))
+	  /* we can't have a free VC for now. Too bad,
+	   * we don't want to mess the screen for now. */
+		return 1;
+
+	set_console (SUSPEND_CONSOLE);
+	if (vt_waitactive(SUSPEND_CONSOLE)) {
+		printk(KERN_ERR "Bummer. Can't switch VCs.\n");
+		return 1;
+	}
+	orig_kmsg = kmsg_redirect;
+	kmsg_redirect = SUSPEND_CONSOLE;
+#endif
+#endif
+	return 0;
+}
+
+void restore_console(void)
+{
+	console_loglevel = orig_loglevel;
+#ifdef SUSPEND_CONSOLE
+	set_console (orig_fgconsole);
+#endif
+	return;
+}
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * Saving part...
  */
@@ -283,17 +329,6 @@
 	return 0;
 }
 
-/*
- * This is our sync function. With this solution we probably won't sleep
- * but that should not be a problem since tasks are stopped..
- */
-
-static inline void do_suspend_sync(void)
-{
-	blk_run_queues();
-#warning This might be broken. We need to somehow wait for data to reach the disk
-}
-
 /* We memorize in swapfile_used what swap devices are used for suspension */
 #define SWAPFILE_UNUSED    0
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
@@ -561,7 +596,6 @@
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
-		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -569,39 +603,6 @@
 	return pagedir;
 }
 
-static int prepare_suspend_console(void)
-{
-	orig_loglevel = console_loglevel;
-	console_loglevel = new_loglevel;
-
-#ifdef CONFIG_VT
-	orig_fgconsole = fg_console;
-#ifdef SUSPEND_CONSOLE
-	if(vc_allocate(SUSPEND_CONSOLE))
-	  /* we can't have a free VC for now. Too bad,
-	   * we don't want to mess the screen for now. */
-		return 1;
-
-	set_console (SUSPEND_CONSOLE);
-	if(vt_waitactive(SUSPEND_CONSOLE)) {
-		PRINTK("Bummer. Can't switch VCs.");
-		return 1;
-	}
-	orig_kmsg = kmsg_redirect;
-	kmsg_redirect = SUSPEND_CONSOLE;
-#endif
-#endif
-	return 0;
-}
-
-static void restore_console(void)
-{
-	console_loglevel = orig_loglevel;
-#ifdef SUSPEND_CONSOLE
-	set_console (orig_fgconsole);
-#endif
-	return;
-}
 
 static int prepare_suspend_processes(void)
 {
@@ -852,7 +853,6 @@
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 static void do_software_suspend(void)
@@ -861,20 +861,13 @@
 	if (prepare_suspend_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
-
 		/* At this point, all user processes and "dangerous"
                    kernel threads are stopped. Free some memory, as we
                    need half of memory free. */
-
 		free_some_memory();
 		
-		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
-		 *
-		 * We sync here -- so you have consistent filesystem state when things go wrong.
-		 * -- so that noone writes to disk after we do atomic copy of data.
-		 */
-		PRINTK("Syncing disks before copy\n");
-		do_suspend_sync();
+		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway. */
+		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
 		if(drivers_suspend()==0)
@@ -888,12 +881,11 @@
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
@@ -906,7 +898,7 @@
 		return;
 
 	software_suspend_enabled = 0;
-	BUG_ON(in_interrupt());
+	BUG_ON(in_atomic());
 	do_software_suspend();
 }
 
@@ -1279,4 +1271,5 @@
 
 EXPORT_SYMBOL(software_suspend);
 EXPORT_SYMBOL(software_suspend_enabled);
+#endif
 EXPORT_SYMBOL(refrigerator);
Index: linux/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux.orig/arch/i386/kernel/acpi/wakeup.S	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/acpi/wakeup.S	2003-07-22 13:26:01.000000000 +0200
@@ -43,6 +43,11 @@
 
 	testl	$1, video_flags - wakeup_code
 	jz	1f
+	/* It is miracle that this works:
+	   * PCI may or may not be initialized at this point
+	   * I'm told we should pass device ID to video bios
+	   However it works on some real machines...
+	 */
 	lcall   $0xc000,$3
 	movw	%cs, %ax
 	movw	%ax, %ds					# Bios might have played with that
Index: linux/drivers/net/8139too.c
===================================================================
--- linux.orig/drivers/net/8139too.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/net/8139too.c	2003-07-22 13:26:13.000000000 +0200
@@ -109,6 +109,7 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/completion.h>
+#include <linux/suspend.h>
 #include <linux/crc32.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -565,6 +566,7 @@
 	void *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
+        u32 pci_state[16];
 	struct net_device_stats stats;
 	unsigned char *rx_ring;
 	unsigned int cur_rx;	/* Index into the Rx buffer of next Rx pkt. */
@@ -1597,6 +1599,8 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
@@ -2566,6 +2570,9 @@
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
 
+	pci_save_state (pdev, tp->pci_state);
+	pci_set_power_state (pdev, 3);
+
 	spin_unlock_irqrestore (&tp->lock, flags);
 	return 0;
 }
@@ -2574,11 +2581,15 @@
 static int rtl8139_resume (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
+	struct rtl8139_private *tp = dev->priv;
 
 	if (!netif_running (dev))
 		return 0;
-	netif_device_attach (dev);
+	pci_set_power_state (pdev, 0);
+	pci_restore_state (pdev, tp->pci_state);
+	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
+	netif_device_attach (dev);
 	return 0;
 }
 
Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/drivers/pci/pci-driver.c	2003-07-22 13:26:26.000000000 +0200
@@ -179,11 +179,9 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 
 	if (pci_dev->driver) {
-		/* We may not call PCI drivers resume at
-		   RESUME_POWER_ON because interrupts are not yet
-		   working at that point. Calling resume at
-		   RESUME_RESTORE_STATE seems like solution. */
-		if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
+	        if (level == RESUME_POWER_ON && pci_dev->driver->power_on)
+			pci_dev->driver->power_on(pci_dev);
+		else if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
 			pci_dev->driver->resume(pci_dev);
 	}
 	return 0;
Index: linux/include/linux/pci.h
===================================================================
--- linux.orig/include/linux/pci.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/pci.h	2003-07-22 13:26:52.000000000 +0200
@@ -512,6 +512,7 @@
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*power_on) (struct pci_dev *dev);	                /* Device power on */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 

%diffstat
 arch/i386/kernel/Makefile      |    3 
 arch/i386/kernel/acpi/wakeup.S |    5 +
 arch/i386/kernel/suspend_asm.S |    3 
 arch/i386/kernel/sysenter.c    |    2 
 arch/x86_64/kernel/time.c      |   25 +++++-
 drivers/acpi/Kconfig           |    4 -
 drivers/acpi/sleep/main.c      |   20 +++--
 drivers/base/power.c           |    6 -
 drivers/input/keyboard/atkbd.c |   11 +-
 drivers/input/power.c          |   16 +++-
 drivers/input/serio/i8042.c    |    5 -
 drivers/net/8139too.c          |   13 +++
 drivers/pci/pci-driver.c       |    8 --
 drivers/pcmcia/yenta_socket.c  |    5 +
 include/linux/pci.h            |    1 
 include/linux/reboot.h         |    2 
 include/linux/serio.h          |    4 -
 include/linux/suspend.h        |   18 ++--
 kernel/Makefile                |    2 
 kernel/suspend.c               |  155 +++++++++++++++++++----------------------
 20 files changed, 172 insertions(+), 136 deletions(-)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
