Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUAMTg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUAMTg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:36:56 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:6273 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265353AbUAMTfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:35:17 -0500
Date: Tue, 13 Jan 2004 14:18:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: m.andreolini@tiscali.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
Message-ID: <20040113131806.GA343@elf.ucw.cz>
References: <3FE5F1110001ED59@mail-4.tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FE5F1110001ED59@mail-4.tiscali.it>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I encountered a problem while resuming from a suspend-to-disk. I'm using
> the
> 2.6.1-rc2 kernel, running on an Athlon XP 2000.
> >From a bash shell, I type:

SiS900 driver needs to be fixed. Or perhaps... try following patch.

> echo 4 > /proc/acpi/sleep
> 
> and the system seems to suspend fine. When resuming, the bash seems to get
> killed and I get the following output from dmesg (running from another shell):
> 
> <snipped dmesg output>
> Stopping tasks: =====================|
> Freeing memory: ....................|
> hdc: start_power_step(step: 0)
> hdc: completing PM request, suspend
> hda: start_power_step(step: 0)
> hda: completing PM request, suspend
> resume= option should be used to set suspend device/critical section: Counting
> pages to copy[nosave c035b000] (pages needed: 5362+512=5874 free: 174839)
> Alloc pagedir
> [nosave c035b000]<4>Freeing prev allocated pagedir
> bad: scheduling while atomic!
> Call Trace:
>  [<c0119d16>] schedule+0x586/0x590
>  [<c0124f5c>] __mod_timer+0xfc/0x170
>  [<c0125ab3>] schedule_timeout+0x63/0xc0
>  [<c0125a40>] process_timeout+0x0/0x10
>  [<c01da44b>] pci_set_power_state+0xeb/0x190
>  [<ec947823>] sis900_resume+0x63/0x130 [sis900]
>  [<c01dc9a6>] pci_device_resume+0x26/0x30

%patch
Index: linux/Documentation/power/swsusp.txt
===================================================================
--- linux.orig/Documentation/power/swsusp.txt	2004-01-09 20:19:41.000000000 +0100
+++ linux/Documentation/power/swsusp.txt	2004-01-09 20:33:05.000000000 +0100
@@ -17,13 +17,30 @@
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by echo 4 > /proc/acpi/sleep.
 
-[Notice. Rest docs is pretty outdated (see date!) It should be safe to
-use swsusp on ext3/reiserfs these days.]
+Pavel's unreliable guide to swsusp mess
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
+
+There are currently two versions of swap suspend in the kernel, the old
+"Pavel's" version in kernel/power/swsusp.c and the new "Patrick's"
+version in kernel/power/pmdisk.c. They provide the same functionality;
+the old version looks ugly but was tested, while the new version looks
+nicer but did not receive so much testing. echo 4 > /proc/acpi/sleep
+calls the old version, echo disk > /sys/power/state calls the new one.
+
+[In the future, when the new version is stable enough, two things can
+happen:
+
+* the new version is moved into swsusp.c, and swsusp is renamed to swap
+  suspend (Pavel prefers this)
+
+* pmdisk is kept as is and swsusp.c is removed from the kernel]
+
 
 
 Article about goals and implementation of Software Suspend for Linux
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Author: Gábor Kuti
-Last revised: 2002-04-08
+Last revised: 2003-10-20 by Pavel Machek
 
 Idea and goals to achieve
 
@@ -36,84 +53,23 @@
 interrupt our programs so processes that are calculating something for a long
 time shouldn't need to be written interruptible.
 
-On desk machines the power saving function isn't as important as it is in
-laptops but we really may benefit from the second one. Nowadays the number of
-desk machines supporting suspend function in their APM is going up but there
-are (and there will still be for a long time) machines that don't even support
-APM of any kind. On the other hand it is reported that using APM's suspend
-some irqs (e.g. ATA disk irq) is lost and it is annoying for the user until
-the Linux kernel resets the device.
-
-So I started thinking about implementing Software Suspend which doesn't need
-any APM support and - since it uses pretty near only high-level routines - is
-supposed to be architecture independent code.
-
 Using the code
 
-The code is experimental right now - testers, extra eyes are welcome. To
-compile this support into the kernel, you need CONFIG_EXPERIMENTAL, 
-and then CONFIG_SOFTWARE_SUSPEND in menu General Setup to be  enabled. It
-cannot be used as a module and I don't think it will ever be needed.
-
-You have two ways to use this code. The first one is if you've compiled in
-sysrq support then you may press Sysrq-D to request suspend. The other way
-is with a patched SysVinit (my patch is against 2.76 and available at my
-home page). You might call 'swsusp' or 'shutdown -z <time>'. Next way is to
-echo 4 > /proc/acpi/sleep.
+You have two ways to use this code. The first one is is with a patched
+SysVinit (my patch is against 2.76 and available at my home page). You
+might call 'swsusp' or 'shutdown -z <time>'. Next way is to echo 4 >
+/proc/acpi/sleep.
 
 Either way it saves the state of the machine into active swaps and then
 reboots.  You must explicitly specify the swap partition to resume from with
 ``resume='' kernel option. If signature is found it loads and restores saved
 state. If the option ``noresume'' is specified as a boot parameter, it skips
-the resuming.  Warning! Look at section ``Things to implement'' to see what
-isn't yet implemented.  Also I strongly suggest you to list all active swaps
-in /etc/fstab. Firstly because you don't have to specify anything to resume
-and secondly if you have more than one swap area you can't decide which one
-has the 'root' signature. 
+the resuming.
 
 In the meantime while the system is suspended you should not touch any of the
 hardware!
 
 About the code
-Goals reached
-
-The code can be downloaded from
-http://falcon.sch.bme.hu/~seasons/linux/. It mainly works but there are still
-some of XXXs, TODOs, FIXMEs in the code which seem not to be too important. It
-should work all right except for the problems listed in ``Things to
-implement''. Notes about the code are really welcome.
-
-How the code works
-
-When suspending is triggered it immediately wakes up process bdflush. Bdflush
-checks whether we have anything in our run queue tq_bdflush. Since we queued up
-function do_software_suspend, it is called. Here we shrink everything including
-dcache, inodes, buffers and memory (here mainly processes are swapped out). We
-count how many pages we need to duplicate (we have to be atomical!) then we
-create an appropriate sized page directory. It will point to the original and
-the new (copied) address of the page. We get the free pages by
-__get_free_pages() but since it changes state we have to be able to track it
-later so it also flips in a bit in page's flags (a new Nosave flag). We
-duplicate pages and then mark them as used (so atomicity is ensured). After
-this we write out the image to swaps, do another sync and the machine may
-reboot. We also save registers to stack.
-
-By resuming an ``inverse'' method is executed. The image if exists is loaded,
-loadling is either triggered by ``resume='' kernel option.  We
-change our task to bdflush (it is needed because if we don't do this init does
-an oops when it is waken up later) and then pages are copied back to their
-original location. We restore registers, free previously allocated memory,
-activate memory context and task information. Here we should restore hardware
-state but even without this the machine is restored and processes are continued
-to work. I think hardware state should be restored by some list (using
-notify_chain) and probably by some userland program (run-parts?) for users'
-pleasure. Check out my patch at the same location for the sysvinit patch.
-
-WARNINGS!
-- It does not like pcmcia cards. And this is logical: pcmcia cards need
-  cardmgr to be initialized. they are not initialized during singleuser boot,
-  but "resumed" kernel does expect them to be initialized. That leads to
-  armagedon. You should eject any pcmcia cards before suspending.
 
 Things to implement
 - SMP support. I've done an SMP support but since I don't have access to a kind
@@ -122,34 +78,14 @@
   interrupts AFAIK..
 - We should only make a copy of data related to kernel segment, since any
   process data won't be changed.
-- Hardware state restoring.  Now there's support for notifying via the notify
-  chain, event handlers are welcome. Some devices may have microcodes loaded
-  into them. We should have event handlers for them as well.
-- We should support other architectures (There are really only some arch
-  related functions..)
-- We should also restore original state of swaps if the ``noresume'' kernel
-  option is specified.. Or do we need such a feature to save state for some
-  other time? Do we need some kind of ``several saved states''?  (Linux-HA
-  people?). There's been some discussion about checkpointing on linux-future.
 - Should make more sanity checks. Or are these enough?
 
 Not so important ideas for implementing
 
 - If a real time process is running then don't suspend the machine.
-- Support for power.conf file as in Solaris, autoshutdown, special
-  devicetypes support, maybe in sysctl.
-- Introduce timeout for SMP locking. But first locking ought to work :O
-- Pre-detect if we don't have enough swap space or free it instead of
-  calling panic.
 - Support for adding/removing hardware while suspended?
 - We should not free pages at the beginning so aggressively, most of them
   go there anyway..
-- If X is active while suspending then by resuming calling svgatextmode
-  corrupts the virtual console of X.. (Maybe this has been fixed AFAIK).
-
-Drivers we support
-- IDE disks are okay
-- vesafb
 
 Drivers that need support
 - pc_keyb -- perhaps we can wait for vojtech's input patches
Index: linux/Documentation/power/video.txt
===================================================================
--- linux.orig/Documentation/power/video.txt	2004-01-09 20:33:05.000000000 +0100
+++ linux/Documentation/power/video.txt	2004-01-09 20:33:05.000000000 +0100
@@ -0,0 +1,36 @@
+
+		Video issues with S3 resume
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		     2003, Pavel Machek
+
+During S3 resume, hardware needs to be reinitialized. For most
+devices, this is easy, and kernel driver knows how to do
+it. Unfortunately there's one exception: video card. Those are usually
+initialized by BIOS, and kernel does not have enough information to
+boot video card. (Kernel usually does not even contain video card
+driver -- vesafb and vgacon are widely used).
+
+This is not problem for swsusp, because during swsusp resume, BIOS is
+run normally so video card is normally initialized.
+
+There are three types of systems where video works after S3 resume:
+
+* systems where video state is preserved over S3. (HP Omnibook xe3)
+
+* systems that initialize video card into vga text mode and where BIOS
+  works well enough to be able to set video mode. Use
+  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
+
+* systems where it is possible to call video bios during S3
+  resume. Unfortunately, it is not correct to call video BIOS at that
+  point, but it happens to work on some machines. Use
+  acpi_sleep=s3_bios (Athlon64 desktop system)
+
+Now, if you pass acpi_sleep=something, and it does not work with your
+bios, you'll get hard crash during resume. Be carefull.
+
+You may have system where none of above works. At that point you
+either invent another ugly hack that works, or write proper driver for
+your video card (good luck getting docs :-(). Maybe suspending from X
+(proper X, knowing your hardware, not XF68_FBcon) might have better
+chance of working.
Index: linux/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux.orig/arch/i386/kernel/acpi/wakeup.S	2004-01-09 20:19:41.000000000 +0100
+++ linux/arch/i386/kernel/acpi/wakeup.S	2004-01-09 20:33:05.000000000 +0100
@@ -193,11 +193,6 @@
 	# and restore the stack ... but you need gdt for this to work
 	movl	saved_context_esp, %esp
 
-	movw	$0x0e00 + 'W', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + 'O', 0xb8018
-
 	movl	%cs:saved_magic, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_magic
@@ -205,9 +200,6 @@
 	# jump to place where we left off
 	movl	saved_eip,%eax
 	movw	$0x0e00 + 'x', 0xb8018
-	outl	%eax, $0x80
-	outl	%eax, $0x80
-	movw	$0x0e00 + '!', 0xb801a
 	jmp	*%eax
 
 bogus_magic:
Index: linux/arch/i386/kernel/cpu/mtrr/main.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mtrr/main.c	2004-01-09 20:19:41.000000000 +0100
+++ linux/arch/i386/kernel/cpu/mtrr/main.c	2004-01-09 20:33:05.000000000 +0100
@@ -588,6 +588,7 @@
 {
 	int i;
 
+#if 0
 	for (i = 0; i < num_var_ranges; i++) {
 		if (mtrr_state[i].lsize) 
 			set_mtrr(i,
@@ -596,6 +597,8 @@
 				 mtrr_state[i].ltype);
 	}
 	kfree(mtrr_state);
+#endif
+
 	return 0;
 }
 
Index: linux/arch/i386/kernel/time.c
===================================================================
--- linux.orig/arch/i386/kernel/time.c	2004-01-09 20:26:08.000000000 +0100
+++ linux/arch/i386/kernel/time.c	2004-01-11 12:12:48.000000000 +0100
@@ -307,7 +307,31 @@
 	return retval;
 }
 
+static long clock_cmos_diff;
+
+static int pit_suspend(struct sys_device *dev, u32 state)
+{
+	/*
+	 * Estimate time zone so that set_time can update the clock
+	 */
+	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff += get_seconds();
+	return 0;
+}
+
+static int pit_resume(struct sys_device *dev)
+{
+	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	write_seqlock_irq(&xtime_lock);
+	xtime.tv_sec = sec;
+	xtime.tv_nsec = 0; 
+	write_sequnlock_irq(&xtime_lock);
+	return 0;
+}
+
 static struct sysdev_class pit_sysclass = {
+	.resume = pit_resume,
+	.suspend = pit_suspend,
 	set_kset_name("pit"),
 };
 
Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c	2004-01-09 20:26:10.000000000 +0100
+++ linux/arch/x86_64/kernel/time.c	2004-01-09 20:33:05.000000000 +0100
@@ -22,7 +22,7 @@
 #include <linux/time.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/device.h>
+#include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <asm/pgtable.h>
 #include <asm/vsyscall.h>
@@ -75,7 +75,7 @@
  * timer interrupt has happened already, but vxtime.trigger wasn't updated yet.
  * This is not a problem, because jiffies hasn't updated either. They are bound
  * together by xtime_lock.
-         */
+ */
 
 static inline unsigned int do_gettimeoffset_tsc(void)
 {
@@ -642,7 +642,17 @@
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
 
@@ -651,8 +661,20 @@
 	outb_p(LATCH & 0xff, 0x40);	/* LSB */
 	outb_p(LATCH >> 8, 0x40);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
+
+	return 0;
 }
 
+static int pit_devicefs_init(void)
+{
+	int error = sysdev_class_register(&rtc_sysclass);
+	if (!error)
+		error = sys_device_register(&device_i8253);
+	return error;
+}
+
+late_initcall(pit_devicefs_init);
+
 int __init time_setup(char *str)
 {
 	report_lost_ticks = 1;
@@ -694,8 +716,8 @@
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 	} else {
-	pit_init();
-	cpu_khz = pit_calibrate_tsc();
+		pit_init();
+		cpu_khz = pit_calibrate_tsc();
 		timename = "PIT";
 	}
 
Index: linux/drivers/acpi/thermal.c
===================================================================
--- linux.orig/drivers/acpi/thermal.c	2004-01-09 20:19:41.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2004-01-09 20:33:05.000000000 +0100
@@ -223,8 +223,11 @@
 	tz->last_temperature = tz->temperature;
 
 	status = acpi_evaluate_integer(tz->handle, "_TMP", NULL, &tz->temperature);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		if (tz->temperature != tz->last_temperature)
+			printk(KERN_ERR "temperature damaged while processing\n");
 		return -ENODEV;
+	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n", tz->temperature));
 
@@ -456,6 +459,10 @@
 	if (!tz || !tz->trips.critical.flags.valid)
 		return_VALUE(-EINVAL);
 
+	if (KELVIN_TO_CELSIUS(tz->temperature) >= 200) {
+		printk(KERN_ALERT "Are you running CPU or nuclear power plant? ACPI claims CPU temp is %ld C. Ignoring.\n", KELVIN_TO_CELSIUS(tz->temperature));
+		return_VALUE(0);
+	}
 	if (tz->temperature >= tz->trips.critical.temperature) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
 		tz->trips.critical.flags.enabled = 1;
@@ -467,6 +474,7 @@
 	if (result)
 		return_VALUE(result);
 
+	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting down.\n", KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
Index: linux/drivers/input/power.c
===================================================================
--- linux.orig/drivers/input/power.c	2004-01-09 20:19:41.000000000 +0100
+++ linux/drivers/input/power.c	2004-01-09 20:33:05.000000000 +0100
@@ -72,6 +72,18 @@
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
Index: linux/drivers/scsi/libata-core.c
===================================================================
--- linux.orig/drivers/scsi/libata-core.c	2004-01-09 20:26:14.000000000 +0100
+++ linux/drivers/scsi/libata-core.c	2004-01-09 20:33:05.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
+#include <linux/suspend.h>
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "hosts.h"
@@ -2564,6 +2565,8 @@
 
         while (1) {
 		cond_resched();
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		timeout = ata_thread_iter(ap);
 
Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2004-01-09 20:19:41.000000000 +0100
+++ linux/include/linux/suspend.h	2004-01-09 20:33:05.000000000 +0100
@@ -24,7 +24,7 @@
 #define SWAP_FILENAME_MAXLENGTH	32
 
 struct suspend_header {
-	__u32 version_code;
+	u32 version_code;
 	unsigned long num_physpages;
 	char machine[8];
 	char version[20];
@@ -32,9 +32,6 @@
 	int page_size;
 	suspend_pagedir_t *suspend_pagedir;
 	unsigned int num_pbes;
-	struct swap_location {
-		char filename[SWAP_FILENAME_MAXLENGTH];
-	} swap_location[MAX_SWAPFILES];
 };
 
 #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
@@ -45,31 +42,43 @@
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
 
+/* kernel/power/swsusp.c */
+extern int software_suspend(void);
+
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
-#endif /* CONFIG_PM */
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-
-extern unsigned char software_suspend_enabled;
 
-extern void software_suspend(void);
 #else	/* CONFIG_SOFTWARE_SUSPEND */
-static inline void software_suspend(void)
+static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
+	return -EPERM;
 }
+#define software_resume()		do { } while(0)
 #endif	/* CONFIG_SOFTWARE_SUSPEND */
 
 
 #ifdef CONFIG_PM
 extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
 
 #else
 static inline void refrigerator(unsigned long flag)
 {
 
 }
+static inline int freeze_processes(void)
+{
+	return 0;
+}
+static inline void thaw_processes(void)
+{
+
+}
 #endif	/* CONFIG_PM */
 
 #endif /* _LINUX_SWSUSP_H */
Index: linux/kernel/power/process.c
===================================================================
--- linux.orig/kernel/power/process.c	2004-01-09 20:19:41.000000000 +0100
+++ linux/kernel/power/process.c	2004-01-09 20:33:05.000000000 +0100
@@ -49,10 +49,11 @@
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=");
 	current->flags &= ~PF_FREEZE;
-	if (flag)
-		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
-					   and that may lead to 100%CPU sucking because those threads
-					   just don't manage signals. */
+
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending(); /* We sent fake signal, clean it up */
+	spin_unlock_irq(&current->sighand->siglock);
+
 	current->flags |= PF_FROZEN;
 	while (current->flags & PF_FROZEN)
 		schedule();
Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-01-09 20:26:18.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-01-09 20:33:05.000000000 +0100
@@ -227,6 +227,7 @@
 static void read_swapfiles(void) /* This is called before saving image */
 {
 	int i, len;
+	char buff[sizeof(resume_file)], *sname;
 	
 	len=strlen(resume_file);
 	root_swap = 0xFFFF;
@@ -245,8 +246,11 @@
 					swapfile_used[i] = SWAPFILE_IGNORED;				  
 			} else {
 	  			/* we ignore all swap devices that are not the resume_file */
-				if (1) {
-// FIXME				if(resume_device == swap_info[i].swap_device) {
+				sname = d_path(swap_info[i].swap_file->f_dentry,
+					       swap_info[i].swap_file->f_vfsmnt,
+					       buff,
+					       sizeof(buff));
+				if (!strcmp(sname, resume_file)) {
 					swapfile_used[i] = SWAPFILE_SUSPEND;
 					root_swap = i;
 				} else {
@@ -283,8 +287,8 @@
  *    would happen on next reboot -- corrupting data.
  *
  *    Note: The buffer we allocate to use to write the suspend header is
- *    not freed; its not needed since system is going down anyway
- *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
+ *    not freed; its not needed since the system is going down anyway
+ *    (plus it causes an oops and I'm lazy^H^H^H^Htoo busy).
  */
 static int write_suspend_image(void)
 {
@@ -340,14 +344,14 @@
 	printk("H");
 	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
+	BUG_ON (sizeof(struct link) != PAGE_SIZE);
 	if (!(entry = get_swap_page()).val)
 		panic( "\nNot enough swapspace when writing header" );
 	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 		panic("\nNot enough swapspace for header on suspend device" );
 
 	cur = (void *) buffer;
-	if (fill_suspend_header(&cur->sh))
-		panic("\nOut of memory while writing header");
+	BUG_ON (fill_suspend_header(&cur->sh));
 		
 	cur->link.next = prev;
 
@@ -488,33 +492,6 @@
 	printk("|\n");
 }
 
-/* Make disk drivers accept operations, again */
-static void drivers_unsuspend(void)
-{
-	device_resume();
-}
-
-/* Called from process context */
-static int drivers_suspend(void)
-{
-	return device_suspend(4);
-}
-
-#define RESUME_PHASE1 1 /* Called from interrupts disabled */
-#define RESUME_PHASE2 2 /* Called with interrupts enabled */
-#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
-static void drivers_resume(int flags)
-{
-	if (flags & RESUME_PHASE1) {
-		device_resume();
-	}
-  	if (flags & RESUME_PHASE2) {
-#ifdef SUSPEND_CONSOLE
-		update_screen(fg_console);	/* Hmm, is this the problem? */
-#endif
-	}
-}
-
 static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
@@ -569,7 +546,7 @@
 
 static void suspend_save_image(void)
 {
-	drivers_unsuspend();
+	device_resume();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -615,6 +592,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
+	device_power_down(4);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
@@ -630,8 +608,10 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	drivers_resume(RESUME_ALL_PHASES);
+	device_resume();
+	update_screen(fg_console);	/* Hmm, is this the problem? */
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -672,7 +652,9 @@
 {
 	int is_problem;
 	read_swapfiles();
+	device_power_down(4);
 	is_problem = suspend_prepare_image();
+	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	if (!is_problem) {
 		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
@@ -694,11 +676,22 @@
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 }
 
-static void do_software_suspend(void)
+/*
+ * This is main interface to the outside world. It needs to be
+ * called from process context.
+ */
+int software_suspend(void)
 {
+	int res;
+	if (!software_suspend_enabled)
+		return -EAGAIN;
+
+	software_suspend_enabled = 0;
+	might_sleep();
+
 	if (arch_prepare_suspend()) {
 		printk("%sArchitecture failed to prepare\n", name_suspend);
-		return;
+		return -EPERM;
 	}		
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
@@ -716,7 +709,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if ((res = device_suspend(4))==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -728,24 +721,12 @@
 			 */
 			do_magic(0);
 		thaw_processes();
-	}
+	} else
+		res = -EBUSY;
 	software_suspend_enabled = 1;
 	MDELAY(1000);
 	pm_restore_console();
-}
-
-/*
- * This is main interface to the outside world. It needs to be
- * called from process context.
- */
-void software_suspend(void)
-{
-	if(!software_suspend_enabled)
-		return;
-
-	software_suspend_enabled = 0;
-	might_sleep();
-	do_software_suspend();
+	return res;
 }
 
 /* More restore stuff */
@@ -856,23 +837,23 @@
 
 static int sanity_check_failed(char *reason)
 {
-	printk(KERN_ERR "%s%s\n",name_resume,reason);
+	printk(KERN_ERR "%s%s\n", name_resume, reason);
 	return -EPERM;
 }
 
 static int sanity_check(struct suspend_header *sh)
 {
-	if(sh->version_code != LINUX_VERSION_CODE)
+	if (sh->version_code != LINUX_VERSION_CODE)
 		return sanity_check_failed("Incorrect kernel version");
-	if(sh->num_physpages != num_physpages)
+	if (sh->num_physpages != num_physpages)
 		return sanity_check_failed("Incorrect memory size");
-	if(strncmp(sh->machine, system_utsname.machine, 8))
+	if (strncmp(sh->machine, system_utsname.machine, 8))
 		return sanity_check_failed("Incorrect machine type");
-	if(strncmp(sh->version, system_utsname.version, 20))
+	if (strncmp(sh->version, system_utsname.version, 20))
 		return sanity_check_failed("Incorrect version");
-	if(sh->num_cpus != num_online_cpus())
+	if (sh->num_cpus != num_online_cpus())
 		return sanity_check_failed("Incorrect number of cpus");
-	if(sh->page_size != PAGE_SIZE)
+	if (sh->page_size != PAGE_SIZE)
 		return sanity_check_failed("Incorrect PAGE_SIZE");
 	return 0;
 }
@@ -915,7 +896,7 @@
 
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
+static int __init __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
 	swp_entry_t next;
 	int i, nr_pgdir_pages;
@@ -1091,6 +1072,7 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");
 
Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c	2004-01-09 20:26:18.000000000 +0100
+++ linux/kernel/sys.c	2004-01-09 20:33:05.000000000 +0100
@@ -472,13 +472,11 @@
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
-		if (!software_suspend_enabled) {
+		{
+			int ret = software_suspend();
 			unlock_kernel();
-			return -EAGAIN;
+			return ret;
 		}
-		software_suspend();
-		do_exit(0);
-		break;
 #endif
 
 	default:

%diffstat
 Documentation/power/swsusp.txt   |  104 +++++++++------------------------------
 Documentation/power/video.txt    |   36 +++++++++++++
 arch/i386/kernel/acpi/wakeup.S   |    8 ---
 arch/i386/kernel/cpu/mtrr/main.c |    3 +
 arch/i386/kernel/time.c          |   24 +++++++++
 arch/x86_64/kernel/time.c        |   32 ++++++++++--
 drivers/acpi/thermal.c           |   10 +++
 drivers/input/power.c            |   12 ++++
 drivers/scsi/libata-core.c       |    3 +
 include/linux/suspend.h          |   31 +++++++----
 kernel/power/process.c           |    9 +--
 kernel/power/swsusp.c            |  104 ++++++++++++++++-----------------------
 kernel/sys.c                     |    8 +--
 13 files changed, 210 insertions(+), 174 deletions(-)



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
