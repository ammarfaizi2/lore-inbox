Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSDEACC>; Thu, 4 Apr 2002 19:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSDEABs>; Thu, 4 Apr 2002 19:01:48 -0500
Received: from [195.39.17.254] ([195.39.17.254]:41097 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312314AbSDEABF>;
	Thu, 4 Apr 2002 19:01:05 -0500
Date: Fri, 5 Apr 2002 01:59:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp ported to 2.4.19-pre5-ac2
Message-ID: <20020404235915.GA7657@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Not much tested (its 2am here) -- it compiles and it should work. I
killed pcnet32 pieces because it seemed too difficult to resolve.

								Pavel
Only in linux-ac: .config
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/CREDITS linux-ac/CREDITS
--- linux-ac.clean/CREDITS	Fri Apr  5 01:22:22 2002
+++ linux-ac/CREDITS	Fri Apr  5 01:25:50 2002
@@ -501,6 +501,14 @@
 S: Fremont, California 94539
 S: USA
 
+N: Florent Chabaud
+E: florent.chabaud@polytechnique.org
+D: software suspend
+S: SGDN/DCSSI
+S: 58, Bd Latour-Maubourg
+S: 75700 Paris 07 SP
+S: France
+
 N: Gordon Chaffee
 E: chaffee@cs.berkeley.edu
 W: http://bmrc.berkeley.edu/people/chaffee/
@@ -1696,6 +1704,11 @@
 S: D-91080 Uttenreuth
 S: Germany
 
+N: Gabor Kuti
+E: seasons@falcon.sch.bme.hu
+E: seasons@makosteszta.sote.hu
+D: Author and Maintainer for Software Suspend
+
 N: Jaroslav Kysela
 E: perex@suse.cz
 W: http://www.perex.cz
@@ -1868,7 +1881,8 @@
 E: pavel@ucw.cz
 E: pavel@suse.cz
 D: Softcursor for vga, hypertech cdrom support, vcsa bugfix, nbd
-D: sun4/330 port, capabilities for elf, speedup for rm on ext2, USB
+D: sun4/330 port, capabilities for elf, speedup for rm on ext2, USB,
+D: x86-64 port, software suspend
 S: Volkova 1131
 S: 198 00 Praha 9
 S: Czech Republic
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/Documentation/Configure.help linux-ac/Documentation/Configure.help
--- linux-ac.clean/Documentation/Configure.help	Fri Apr  5 01:55:04 2002
+++ linux-ac/Documentation/Configure.help	Fri Apr  5 01:25:50 2002
@@ -112,6 +112,31 @@
   like MGA monitors that you are very unlikely to see on today's
   systems.
 
+Software Suspend
+CONFIG_SOFTWARE_SUSPEND
+  Enable the possibilty of suspendig machine. It doesn't need APM.
+  You may suspend your machine by either pressing Sysrq-d or with
+  'swsusp' or 'shutdown -z <time>' (patch for sysvinit needed). It
+  creates an image which is saved in your active swaps. By the next
+  booting the kernel detects the saved image, restores the memory from
+  it and then it continues to run as before you've suspended.
+  If you don't want the previous state to continue use the 'noresume'
+  kernel option. However note that your partitions will be fsck'd and
+  you must re-mkswap your swap partitions/files.
+
+  Right now you may boot without resuming and then later resume but
+  in meantime you cannot use those swap partitions/files which were
+  involved in suspending. Also in this case there is a risk that buffers
+  on disk won't match with saved ones.
+
+  SMP is supported ``as-is''. There's a code for it but doesn't work.
+  There have been problems reported relating SCSI.
+  
+  This option is about getting stable. However there is still some
+  absence of features.
+
+  For more information take a look at Documentation/swsusp.txt.
+
 Symmetric Multi-Processing support
 CONFIG_SMP
   This enables support for systems with more than one CPU. If you have
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/MAINTAINERS linux-ac/MAINTAINERS
--- linux-ac.clean/MAINTAINERS	Fri Apr  5 01:55:04 2002
+++ linux-ac/MAINTAINERS	Fri Apr  5 01:25:50 2002
@@ -1467,6 +1467,14 @@
 L:	linux-raid@vger.kernel.org
 S:	Maintained
 
+SOFTWARE SUSPEND:
+P:	Gabor Kuti
+M:	seasons@falcon.sch.bme.hu
+M:	seasons@makosteszta.sote.hu
+L:	http://lister.fornax.hu/mailman/listinfo/swsusp
+W:	http://falcon.sch.bme.hu/~seasons/linux
+S:	Maintained
+
 SONIC NETWORK DRIVER
 P:	Thomas Bogendoerfer
 M:	tsbogend@alpha.franken.de
Only in linux-ac/arch/i386/boot: bbootsect
Only in linux-ac/arch/i386/boot: bsetup
Only in linux-ac/arch/i386/boot: bzImage
Only in linux-ac/arch/i386/boot/compressed: bvmlinux
Only in linux-ac/arch/i386/boot/compressed: bvmlinux.out
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/arch/i386/config.in linux-ac/arch/i386/config.in
--- linux-ac.clean/arch/i386/config.in	Fri Apr  5 01:55:05 2002
+++ linux-ac/arch/i386/config.in	Fri Apr  5 01:25:50 2002
@@ -418,6 +418,9 @@
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   dep_bool 'Software Suspend' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
+fi
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/arch/i386/defconfig linux-ac/arch/i386/defconfig
--- linux-ac.clean/arch/i386/defconfig	Fri Apr  5 01:55:05 2002
+++ linux-ac/arch/i386/defconfig	Fri Apr  5 01:25:50 2002
@@ -110,6 +110,7 @@
 # CONFIG_IKCONFIG is not set
 CONFIG_PM=y
 # CONFIG_APM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
 
 #
 # Memory Technology Devices (MTD)
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/arch/i386/kernel/apm.c linux-ac/arch/i386/kernel/apm.c
--- linux-ac.clean/arch/i386/kernel/apm.c	Fri Apr  5 01:22:22 2002
+++ linux-ac/arch/i386/kernel/apm.c	Fri Apr  5 01:25:50 2002
@@ -1659,6 +1659,7 @@
 	daemonize();
 
 	strcpy(current->comm, "kapmd");
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	if (apm_info.connection_version == 0) {
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/arch/i386/kernel/process.c linux-ac/arch/i386/kernel/process.c
--- linux-ac.clean/arch/i386/kernel/process.c	Fri Apr  5 01:55:05 2002
+++ linux-ac/arch/i386/kernel/process.c	Fri Apr  5 01:25:50 2002
@@ -738,6 +738,20 @@
 	}
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/*
+ * We reload there esp0, LDT, page table pointer only. Other processor
+ * registers including segment ones are restored before calling this function
+ */
+void activate_task(struct task_struct *tsk_p)
+{
+	struct thread_struct *tsk = &tsk_p->thread;
+	struct tss_struct *tss = init_tss + smp_processor_id();
+
+	tss->esp0 = tsk->esp0;
+}
+#endif
+
 asmlinkage int sys_fork(struct pt_regs regs)
 {
 	return do_fork(SIGCHLD, regs.esp, &regs, 0);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/arch/i386/kernel/signal.c linux-ac/arch/i386/kernel/signal.c
--- linux-ac.clean/arch/i386/kernel/signal.c	Fri Apr  5 01:22:22 2002
+++ linux-ac/arch/i386/kernel/signal.c	Fri Apr  5 01:25:50 2002
@@ -20,6 +20,7 @@
 #include <linux/stddef.h>
 #include <linux/tty.h>
 #include <linux/personality.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -595,6 +596,11 @@
 	if ((regs->xcs & 3) != 3)
 		return 1;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(0);
+		goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -702,6 +708,7 @@
 		return 1;
 	}
 
+ no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/arch/i386/vmlinux.lds linux-ac/arch/i386/vmlinux.lds
--- linux-ac.clean/arch/i386/vmlinux.lds	Thu Feb 28 11:18:05 2002
+++ linux-ac/arch/i386/vmlinux.lds	Fri Apr  5 01:25:50 2002
@@ -53,6 +53,12 @@
   __init_end = .;
 
   . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
+  . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
 
   . = ALIGN(32);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/acpi/ospm/system/sm.c linux-ac/drivers/acpi/ospm/system/sm.c
--- linux-ac.clean/drivers/acpi/ospm/system/sm.c	Wed Oct 24 23:06:22 2001
+++ linux-ac/drivers/acpi/ospm/system/sm.c	Fri Apr  5 01:25:50 2002
@@ -146,7 +146,9 @@
 			system->states[i] = TRUE;
 		}
 	}
-
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	system->states[4] = TRUE;;
+#endif
 	status = sm_osl_add_device(system);
 	if (ACPI_FAILURE(status)) {
 		goto end;
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/acpi/ospm/system/sm_osl.c linux-ac/drivers/acpi/ospm/system/sm_osl.c
--- linux-ac.clean/drivers/acpi/ospm/system/sm_osl.c	Tue Dec 25 22:39:20 2001
+++ linux-ac/drivers/acpi/ospm/system/sm_osl.c	Fri Apr  5 01:25:50 2002
@@ -140,7 +140,10 @@
 	if (system->states[value] != TRUE)
 		return -EINVAL;
 	
-	sm_osl_suspend(value);
+	if (value != ACPI_S4)
+		sm_osl_suspend(value);
+	else
+		software_suspend();
 	
 	return (count);
 }
@@ -685,6 +688,9 @@
 	 */
 	if (state == ACPI_S2 || state == ACPI_S3) {
 #ifdef DONT_USE_UNTIL_LOWLEVEL_CODE_EXISTS
+		/* That && trick is *not going to work*. Read gcc
+		   specs. That explicitely says: jumping from other
+		   function is *not allowed*. */ 
 		wakeup_address = acpi_save_state_mem((unsigned long)&&acpi_sleep_done);
 
 		if (!wakeup_address) goto acpi_sleep_done;
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/block/ll_rw_blk.c linux-ac/drivers/block/ll_rw_blk.c
--- linux-ac.clean/drivers/block/ll_rw_blk.c	Fri Apr  5 01:55:06 2002
+++ linux-ac/drivers/block/ll_rw_blk.c	Fri Apr  5 01:25:50 2002
@@ -1017,6 +1017,9 @@
  * particular, no other flags, are changed by generic_make_request or
  * any lower level drivers.
  * */
+
+kdev_t suspend_device;
+
 void generic_make_request (int rw, struct buffer_head * bh)
 {
 	int major = MAJOR(bh->b_rdev);
@@ -1025,6 +1028,8 @@
 
 	if (!bh->b_end_io)
 		BUG();
+	if (suspend_device && (bh->b_rdev != suspend_device))
+		panic("Attempted to corrupt disk.");
 
 	/* Test device size, when known. */
 	if (blk_size[major])
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/block/loop.c linux-ac/drivers/block/loop.c
--- linux-ac.clean/drivers/block/loop.c	Fri Apr  5 01:55:06 2002
+++ linux-ac/drivers/block/loop.c	Fri Apr  5 01:25:50 2002
@@ -71,11 +71,11 @@
 #include <linux/smp_lock.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/loop.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 
-#include <linux/loop.h>		
-
 #define MAJOR_NR LOOP_MAJOR
 
 static int max_loop = 8;
@@ -578,7 +578,7 @@
 	atomic_inc(&lo->lo_pending);
 	spin_unlock_irq(&lo->lo_lock);
 
-	current->flags |= PF_NOIO;
+	current->flags |= PF_NOIO | PF_IOTHREAD;
 
 	/*
 	 * up sem, we are running
Only in linux-ac/drivers/char: consolemap_deftbl.c
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/char/sysrq.c linux-ac/drivers/char/sysrq.c
--- linux-ac.clean/drivers/char/sysrq.c	Fri Apr  5 01:22:25 2002
+++ linux-ac/drivers/char/sysrq.c	Fri Apr  5 01:25:50 2002
@@ -27,6 +27,7 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 #include <linux/spinlock.h>
 
@@ -317,6 +318,22 @@
 	action_msg:	"Kill All Tasks",
 };
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static void sysrq_handle_swsusp(int key, struct pt_regs *pt_regs,
+		struct kbd_struct *kbd, struct tty_struct *tty) {
+        if(!software_suspend_enabled) {
+		printk("Software Suspend is not possible now\n");
+		return;
+	}
+	software_suspend();
+}
+static struct sysrq_key_op sysrq_swsusp_op = {
+	handler:	sysrq_handle_swsusp,
+	help_msg:	"suspenD",
+	action_msg:	"Software suspend\n",
+};
+#endif
+
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
 
 
@@ -339,7 +356,11 @@
 		 and will never arive */
 /* b */	&sysrq_reboot_op,
 /* c */	NULL,
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/* d */	&sysrq_swsusp_op,
+#else
 /* d */	NULL,
+#endif
 /* e */	&sysrq_term_op,
 /* f */	NULL,
 /* g */	NULL,
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/ide/hd.c linux-ac/drivers/ide/hd.c
--- linux-ac.clean/drivers/ide/hd.c	Mon Oct 15 22:27:42 2001
+++ linux-ac/drivers/ide/hd.c	Fri Apr  5 01:25:50 2002
@@ -346,6 +346,13 @@
 		hd_request();
 }
 
+void do_reset_hd(void)
+{
+	DEVICE_INTR = NULL;
+	reset = 1;
+	reset_hd();
+}
+
 /*
  * Ok, don't know what to do with the unexpected interrupts: on some machines
  * doing a reset and a retry seems to result in an eternal loop. Right now I
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/ide/ide-disk.c linux-ac/drivers/ide/ide-disk.c
--- linux-ac.clean/drivers/ide/ide-disk.c	Fri Apr  5 01:55:07 2002
+++ linux-ac/drivers/ide/ide-disk.c	Fri Apr  5 01:29:53 2002
@@ -49,6 +49,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/suspend.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -67,6 +68,8 @@
 #  undef __TASKFILE__IO
 #endif /* CONFIG_IDE_TASKFILE_IO */
 
+static int driver_blocked;
+
 /*
  * lba_capacity_is_ok() performs a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
@@ -523,6 +526,8 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	if (driver_blocked)
+		panic("Request while ide driver is blocked?");
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);
 
@@ -1513,6 +1518,74 @@
 	ide_register_module(&idedisk_module);
 	MOD_DEC_USE_COUNT;
 	return 0;
+}
+
+void panic_box(void)
+{
+	panic("Attempted to corrupt something: ide operation was pending accross suspend/resume.\n");
+}
+
+int ide_disks_busy(void)
+{
+	int i;
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+		if (!hwgroup) continue;
+		if ((hwgroup->handler) && (hwgroup->handler != panic_box))
+			return 1;
+	}
+	return 0;
+}
+
+void ide_disk_suspend(void)
+{
+	int i;
+	printk("ide_disk_suspend()\n");
+	while (ide_disks_busy()) {
+		printk("*");
+		schedule();
+	}
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+
+		if (!hwgroup) continue;
+		hwgroup->handler_save = hwgroup->handler;
+		hwgroup->handler = panic_box;
+	}
+	driver_blocked = 1;
+	if (ide_disks_busy())
+		panic("How did you get that request through?!");
+}
+
+/* unsuspend and resume should be equal in the ideal world */
+
+void ide_disk_unsuspend(void)
+{
+	int i;
+	printk("ide_disk_unsuspend()\n");
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+
+		if (!hwgroup) continue;
+		hwgroup->handler = hwgroup->handler_save;
+		hwgroup->handler_save = NULL;
+	}
+	driver_blocked = 0;
+}
+
+void ide_disk_resume(void)
+{
+	int i;
+	printk("ide_disk_resume()\n");
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+
+		if (!hwgroup) continue;
+		if (hwgroup->handler != panic_box)
+			panic("Handler was not set to panic?");
+		hwgroup->handler_save = NULL;
+	}
+	driver_blocked = 0;
 }
 
 module_init(idedisk_init);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/net/eepro100.c linux-ac/drivers/net/eepro100.c
--- linux-ac.clean/drivers/net/eepro100.c	Fri Apr  5 01:55:07 2002
+++ linux-ac/drivers/net/eepro100.c	Fri Apr  5 01:25:50 2002
@@ -524,10 +524,8 @@
 static int eepro100_init_one(struct pci_dev *pdev,
 		const struct pci_device_id *ent);
 static void eepro100_remove_one (struct pci_dev *pdev);
-#ifdef CONFIG_PM
 static int eepro100_suspend (struct pci_dev *pdev, u32 state);
 static int eepro100_resume (struct pci_dev *pdev);
-#endif
 
 static int do_eeprom_cmd(long ioaddr, int cmd, int cmd_len);
 static int mdio_read(long ioaddr, int phy_id, int location);
Only in linux-ac/drivers/net/hamradio/soundmodem: gentbl
Only in linux-ac/drivers/net/hamradio/soundmodem: sm_tbl_afsk1200.h
Only in linux-ac/drivers/net/hamradio/soundmodem: sm_tbl_afsk2400_7.h
Only in linux-ac/drivers/net/hamradio/soundmodem: sm_tbl_afsk2400_8.h
Only in linux-ac/drivers/net/hamradio/soundmodem: sm_tbl_afsk2666.h
Only in linux-ac/drivers/net/hamradio/soundmodem: sm_tbl_fsk9600.h
Only in linux-ac/drivers/net/hamradio/soundmodem: sm_tbl_hapn4800.h
Only in linux-ac/drivers/net/hamradio/soundmodem: sm_tbl_psk4800.h
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/net/pcnet32.c linux-ac/drivers/net/pcnet32.c
--- linux-ac.clean/drivers/net/pcnet32.c	Fri Apr  5 01:55:07 2002
+++ linux-ac/drivers/net/pcnet32.c	Fri Apr  5 01:25:50 2002
@@ -1174,19 +1174,12 @@
 		    if (err_status & 0x04000000) lp->stats.tx_aborted_errors++;
 		    if (err_status & 0x08000000) lp->stats.tx_carrier_errors++;
 		    if (err_status & 0x10000000) lp->stats.tx_window_errors++;
-#ifndef DO_DXSUFLO
 		    if (err_status & 0x40000000) {
 			lp->stats.tx_fifo_errors++;
-			/* Ackk!  On FIFO errors the Tx unit is turned off! */
-			/* Remove this verbosity later! */
-			printk(KERN_ERR "%s: Tx FIFO error! CSR0=%4.4x\n",
-			       dev->name, csr0);
-			must_restart = 1;
-		    }
-#else
-		    if (err_status & 0x40000000) {
-			lp->stats.tx_fifo_errors++;
-			if (! lp->dxsuflo) {  /* If controller doesn't recover ... */
+#ifdef DO_DXSUFLO
+			if (! lp->dxsuflo) 
+#endif
+			{  /* If controller doesn't recover ... */
 			    /* Ackk!  On FIFO errors the Tx unit is turned off! */
 			    /* Remove this verbosity later! */
 			    printk(KERN_ERR "%s: Tx FIFO error! CSR0=%4.4x\n",
@@ -1194,7 +1187,6 @@
 			    must_restart = 1;
 			}
 		    }
-#endif
 		} else {
 		    if (status & 0x1800)
 			lp->stats.collisions++;
@@ -1721,12 +1713,13 @@
     }
 }
 
+
 module_init(pcnet32_init_module);
 module_exit(pcnet32_cleanup_module);
 
 /*
  * Local variables:
- *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -m486 -c pcnet32.c"
+ *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/include/linux -Wall -Wstrict-prototypes -O2 -m486 -c pcnet32.c"
  *  c-indent-level: 4
  *  tab-width: 8
  * End:
Only in linux-ac/drivers/pci: classlist.h
Only in linux-ac/drivers/pci: devlist.h
Only in linux-ac/drivers/pci: gen-devlist
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/pci/pci.c linux-ac/drivers/pci/pci.c
--- linux-ac.clean/drivers/pci/pci.c	Fri Apr  5 01:55:08 2002
+++ linux-ac/drivers/pci/pci.c	Fri Apr  5 01:25:50 2002
@@ -1629,7 +1629,7 @@
 	return error;
 }
 
-static int pci_pm_suspend(u32 state)
+int pci_pm_suspend(u32 state)
 {
 	struct list_head *list;
 	struct pci_bus *bus;
@@ -1642,7 +1642,7 @@
 	return 0;
 }
 
-static int pci_pm_resume(void)
+int pci_pm_resume(void)
 {
 	struct list_head *list;
 	struct pci_bus *bus;
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/drivers/usb/storage/usb.c linux-ac/drivers/usb/storage/usb.c
--- linux-ac.clean/drivers/usb/storage/usb.c	Fri Apr  5 01:22:29 2002
+++ linux-ac/drivers/usb/storage/usb.c	Fri Apr  5 01:25:50 2002
@@ -316,6 +316,7 @@
 	 */
 	exit_files(current);
 	current->files = init_task.files;
+	current->flags |= PF_IOTHREAD;
 	atomic_inc(&current->files->count);
 	daemonize();
 	reparent_to_init();
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/fs/buffer.c linux-ac/fs/buffer.c
--- linux-ac.clean/fs/buffer.c	Fri Apr  5 01:55:09 2002
+++ linux-ac/fs/buffer.c	Fri Apr  5 01:26:47 2002
@@ -48,6 +48,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/mm_inline.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -130,6 +131,8 @@
 		wake_up(&bh->b_wait);
 }
 
+DECLARE_TASK_QUEUE(tq_bdflush);
+
 /*
  * Rewrote the wait-routines to use the "new" wait-queue functionality,
  * and getting rid of the cli-sti pairs. The wait-queue routines still
@@ -2942,6 +2945,9 @@
 
 	for (;;) {
 		CHECK_EMERGENCY_SYNC
+#ifdef CONFIG_SOFTWARE_SUSPEND
+		run_task_queue(&tq_bdflush);
+#endif
 
 		spin_lock(&lru_list_lock);
 		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
@@ -2974,11 +2980,13 @@
 	spin_unlock_irq(&tsk->sigmask_lock);
 
 	complete((struct completion *)startup);
-
+	current->flags |= PF_KERNTHREAD;
 	for (;;) {
 
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		if (interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(interval);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/fs/jbd/journal.c linux-ac/fs/jbd/journal.c
--- linux-ac.clean/fs/jbd/journal.c	Fri Apr  5 01:55:10 2002
+++ linux-ac/fs/jbd/journal.c	Fri Apr  5 01:25:50 2002
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 
@@ -227,6 +228,7 @@
 			journal->j_commit_interval / HZ);
 	list_add(&journal->j_all_journals, &all_journals);
 
+	current->flags |= PF_KERNTHREAD;
 	/* And now, wait forever for commit wakeup events. */
 	while (1) {
 		if (journal->j_flags & JFS_UNMOUNT)
@@ -247,7 +249,15 @@
 		}
 
 		wake_up(&journal->j_wait_done_commit);
-		interruptible_sleep_on(&journal->j_wait_commit);
+		if (current->flags & PF_FREEZE) { /* The simpler the better. Flushing journal isn't a
+						     good idea, because that depends on threads that
+						     may be already stopped. */
+			jbd_debug(1, "Now suspending kjournald\n");
+			refrigerator(PF_IOTHREAD);
+			jbd_debug(1, "Resuming kjournald\n");						
+		} else		/* we assume on resume that commits are already there,
+				   so we don't sleep */
+			interruptible_sleep_on(&journal->j_wait_commit);
 
 		jbd_debug(1, "kjournald wakes\n");
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/fs/reiserfs/journal.c linux-ac/fs/reiserfs/journal.c
--- linux-ac.clean/fs/reiserfs/journal.c	Fri Apr  5 01:55:10 2002
+++ linux-ac/fs/reiserfs/journal.c	Fri Apr  5 01:25:50 2002
@@ -58,6 +58,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/suspend.h> 
 
 /* the number of mounted filesystems.  This is used to decide when to
 ** start and kill the commit thread
@@ -1872,6 +1873,7 @@
   spin_unlock_irq(&current->sigmask_lock);
 
   sprintf(current->comm, "kreiserfsd") ;
+  current->flags |= PF_KERNTHREAD;
   lock_kernel() ;
   while(1) {
 
@@ -1885,7 +1887,14 @@
       break ;
     }
     wake_up(&reiserfs_commit_thread_done) ;
-    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
+#ifdef CONFIG_SOFTWARE_SUSPEND
+    if (current->flags & PF_FREEZE) {
+	    printk("Now suspending kreiserfsd\n");
+	    refrigerator(PF_IOTHREAD);
+	    printk("Resuming kreiserfsd\n");
+    } else
+#endif
+	    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
   }
   unlock_kernel() ;
   wake_up(&reiserfs_commit_thread_done) ;
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/asm-generic/bitops.h linux-ac/include/asm-generic/bitops.h
--- linux-ac.clean/include/asm-generic/bitops.h	Tue Nov 28 02:47:38 2000
+++ linux-ac/include/asm-generic/bitops.h	Fri Apr  5 01:25:50 2002
@@ -51,6 +51,12 @@
 	return ((mask & *addr) != 0);
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /*
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/asm-i386/bitops.h linux-ac/include/asm-i386/bitops.h
--- linux-ac.clean/include/asm-i386/bitops.h	Fri Apr  5 01:55:10 2002
+++ linux-ac/include/asm-i386/bitops.h	Fri Apr  5 01:33:19 2002
@@ -413,6 +413,12 @@
 	return word;
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /**
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/asm-i386/suspend.h linux-ac/include/asm-i386/suspend.h
--- linux-ac.clean/include/asm-i386/suspend.h	Sun Nov 11 20:26:37 2001
+++ linux-ac/include/asm-i386/suspend.h	Fri Apr  5 01:33:42 2002
@@ -0,0 +1,313 @@
+#ifndef __ASM_I386_SWSUSP_H
+#define __ASM_I386_SWSUSP_H
+#endif /* __ASM_I386_SWSUSP_H */
+
+/*
+ * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+ * Based on code
+ * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+ */
+
+#ifdef SUSPEND_C
+
+#include <asm/desc.h>
+#include <asm/i387.h>
+
+static inline void
+arch_prepare_suspend(void)
+{
+	if (!cpu_has_pse)
+		panic("pse required");
+}
+
+
+/* image of the saved processor state */
+struct saved_context {
+	u32 eax, ebx, ecx, edx;
+	u32 esp, ebp, esi, edi;
+	u16 es, fs, gs, ss;
+	u32 cr0, cr2, cr3, cr4;
+	u16 gdt_pad;
+	u16 gdt_limit;
+	u32 gdt_base;
+	u16 idt_pad;
+	u16 idt_limit;
+	u32 idt_base;
+	u16 ldt;
+	u16 tss;
+	u32 tr;
+	u32 safety;
+	u32 return_address;
+	u32 eflags;
+} __attribute__((packed));
+
+static struct saved_context saved_context;
+
+#define loaddebug(thread,register) \
+               __asm__("movl %0,%%db" #register  \
+                       : /* no output */ \
+                       :"r" ((thread)->debugreg[register]))
+
+ 
+/*
+ * save_processor_context
+ * 
+ * Save the state of the processor before we go to sleep.
+ *
+ * return_stack is the value of the stack pointer (%esp) as the caller sees it.
+ * A good way could not be found to obtain it from here (don't want to make _too_
+ * many assumptions about the layout of the stack this far down.) Also, the 
+ * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
+ * buggy - it returns the value of the stack at the proper location, not the 
+ * location, like it should (as of gcc 2.91.66)
+ * 
+ * Note that the context and timing of this function is pretty critical.
+ * With a minimal amount of things going on in the caller and in here, gcc
+ * does a good job of being just a dumb compiler.  Watch the assembly output
+ * if anything changes, though, and make sure everything is going in the right
+ * place. 
+ */
+static inline void save_processor_context (void)
+{
+	kernel_fpu_begin();
+
+	/*
+	 * descriptor tables
+	 */
+	asm volatile ("sgdt (%0)" : "=m" (saved_context.gdt_limit));
+	asm volatile ("sidt (%0)" : "=m" (saved_context.idt_limit));
+	asm volatile ("sldt (%0)" : "=m" (saved_context.ldt));
+	asm volatile ("str (%0)"  : "=m" (saved_context.tr));
+
+	/*
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%esp, (%0)" : "=m" (saved_context.esp));
+	asm volatile ("movl %%eax, (%0)" : "=m" (saved_context.eax));
+	asm volatile ("movl %%ebx, (%0)" : "=m" (saved_context.ebx));
+	asm volatile ("movl %%ecx, (%0)" : "=m" (saved_context.ecx));
+	asm volatile ("movl %%edx, (%0)" : "=m" (saved_context.edx));
+	asm volatile ("movl %%ebp, (%0)" : "=m" (saved_context.ebp));
+	asm volatile ("movl %%esi, (%0)" : "=m" (saved_context.esi));
+	asm volatile ("movl %%edi, (%0)" : "=m" (saved_context.edi));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %%es, %0" : "=r" (saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=r" (saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=r" (saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=r" (saved_context.ss));
+
+	/*
+	 * control registers 
+	 */
+	asm volatile ("movl %%cr0, %0" : "=r" (saved_context.cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl (%0)" : "=m" (saved_context.eflags));
+}
+
+void fix_processor_context(void)
+{
+	int nr = smp_processor_id();
+	struct tss_struct * t = &init_tss[nr];
+
+	printk("Tss desc..."); mdelay(1000);
+	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+        gdt_table[__TSS(nr)].b &= 0xfffffdff;
+
+	printk("Tr..."); mdelay(1000);
+	load_TR(nr);		/* This does ltr */
+
+	printk("LDT..."); mdelay(1000);
+	load_LDT(current->active_mm);	/* This does lldt */
+
+	printk("Debug..."); mdelay(1000);
+	/*
+	 * Now maybe reload the debug registers
+	 */
+	if (current->thread.debugreg[7]){
+                loaddebug(&current->thread, 0);
+                loaddebug(&current->thread, 1);
+                loaddebug(&current->thread, 2);
+                loaddebug(&current->thread, 3);
+                /* no 4 and 5 */
+                loaddebug(&current->thread, 6);
+                loaddebug(&current->thread, 7);
+	}
+
+}
+
+void
+do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+	printk("FPU..."); mdelay(1000);
+        kernel_fpu_end();
+}
+
+/*
+ * restore_processor_context
+ * 
+ * Restore the processor context as it was before we went to sleep
+ * - descriptor tables
+ * - control registers
+ * - segment registers
+ * - flags
+ * 
+ * Note that it is critical that this function is declared inline.  
+ * It was separated out from restore_state to make that function
+ * a little clearer, but it needs to be inlined because we won't have a
+ * stack when we get here (so we can't push a return address).
+ */
+static inline void restore_processor_context (void)
+{
+	/*
+	 * first restore %ds, so we can access our data properly
+	 */
+	asm volatile (".align 4");
+	asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
+
+
+	/*
+	 * control registers
+	 */
+	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
+	
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
+	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
+	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
+	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
+
+	/*
+	 * the other general registers
+	 *
+	 * note that even though gcc has constructs to specify memory 
+	 * input into certain registers, it will try to be too smart
+	 * and save them at the beginning of the function.  This is esp.
+	 * bad since we don't have a stack set up when we enter, and we 
+	 * want to preserve the values on exit. So, we set them manually.
+	 */
+	asm volatile ("movl %0, %%esp" :: "m" (saved_context.esp));
+	asm volatile ("movl %0, %%ebp" :: "m" (saved_context.ebp));
+	asm volatile ("movl %0, %%eax" :: "m" (saved_context.eax));
+	asm volatile ("movl %0, %%ebx" :: "m" (saved_context.ebx));
+	asm volatile ("movl %0, %%ecx" :: "m" (saved_context.ecx));
+	asm volatile ("movl %0, %%edx" :: "m" (saved_context.edx));
+	asm volatile ("movl %0, %%esi" :: "m" (saved_context.esi));
+	asm volatile ("movl %0, %%edi" :: "m" (saved_context.edi));
+
+	/*
+	 * now restore the descriptor tables to their proper values
+	 */
+	asm volatile ("lgdt (%0)" :: "m" (saved_context.gdt_limit));
+	asm volatile ("lidt (%0)" :: "m" (saved_context.idt_limit));
+	asm volatile ("lldt (%0)" :: "m" (saved_context.ldt));
+
+#if 0
+	printk("Reloading old TR..."); mdelay(1000);
+
+	asm volatile ("ltr (%0)"  :: "m" (saved_context.tr));
+#endif
+
+	printk("Calling fix_processor_context..."); mdelay(1000);
+	fix_processor_context();
+
+	/*
+	 * the flags
+	 */
+	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
+
+	do_fpu_end();
+}
+
+
+#if 1
+/* Local variables for do_magic */
+static int loop __nosavedata = 0;
+static int loop2 __nosavedata = 0;
+
+/*
+ * (KG): Since we affect stack here, we make this function as flat and easy
+ * as possible in order to not provoke gcc to use local variables on the stack.
+ * Note that on resume, all (expect nosave) variables will have the state from
+ * the time of writing (suspend_save_image) and the registers (including the
+ * stack pointer, but excluding the instruction pointer) will be loaded with 
+ * the values saved at save_processor_context() time.
+ */
+static void do_magic(int resume)
+{
+	/* DANGER WILL ROBINSON!
+	 *
+	 * If this function is too difficult for gcc to optimize, it will crash and burn!
+	 * see above.
+	 *
+	 * DO NOT TOUCH.
+	 */
+
+	if (!resume) {
+		do_magic_suspend_1();
+		save_processor_context();	/* We need to capture registers and memory at "same time" */
+		do_magic_suspend_2();		/* If everything goes okay, this function does not return */
+		return;
+	}
+
+	/* We want to run from swapper_pg_dir, since swapper_pg_dir is stored in constant
+	 * place in memory 
+	 */
+
+        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+
+/*
+ * Final function for resuming: after copying the pages to their original
+ * position, it restores the register state.
+ */
+
+	do_magic_resume_1();
+
+	/* Critical section here: noone should touch memory from now */
+	/* This works, because nr_copy_pages, pagedir_nosave, loop and loop2 are nosavedata */
+	for (loop=0; loop < nr_copy_pages; loop++) {
+		/* You may not call something (like copy_page) here:
+		   We may absolutely not use stack at this point */
+		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
+			*(((char *)((pagedir_nosave+loop)->orig_address))+loop2) =
+				*(((char *)((pagedir_nosave+loop)->address))+loop2);
+			__flush_tlb();
+		}
+	}
+/* FIXME: What about page tables? Writing data pages may toggle
+   accessed/dirty bits in our page tables. That should be no problems
+   with 4MB page tables. That's why we require have_pse. */
+
+/* Danger: previous loop probably destroyed our current stack. Better hope it did not use
+   any stack space, itself.
+
+   When this function is entered at resume time, we move stack to _old_ place.
+   This is means that this function must use no stack and no local variables in registers.
+*/
+	restore_processor_context();
+/* Ahah, we now run with our old stack, and with registers copied from suspend time */
+
+	do_magic_resume_2();
+}
+#endif
+#endif 
Only in linux-ac/include: config
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/bitops.h linux-ac/include/linux/bitops.h
--- linux-ac.clean/include/linux/bitops.h	Mon Nov  5 21:42:13 2001
+++ linux-ac/include/linux/bitops.h	Fri Apr  5 01:33:19 2002
@@ -1,6 +1,6 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
-
+#include <asm/bitops.h>
 
 /*
  * ffs: find first bit set. This is defined the same way as
@@ -35,6 +35,47 @@
 		r += 1;
 	}
 	return r;
+}
+
+/*
+ * fls: find last bit set.
+ */
+
+extern __inline__ int generic_fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+extern __inline__ int get_bitmask_order(unsigned int count)
+{
+	int order;
+	
+	order = fls(count);
+	return order;	/* We could be slightly more clever with -1 here... */
 }
 
 /*
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/ide.h linux-ac/include/linux/ide.h
--- linux-ac.clean/include/linux/ide.h	Fri Apr  5 01:55:10 2002
+++ linux-ac/include/linux/ide.h	Fri Apr  5 01:40:00 2002
@@ -624,6 +624,7 @@
 
 typedef struct hwgroup_s {
 	ide_handler_t		*handler;/* irq handler, if active */
+	ide_handler_t		*handler_save;/* for suspend */
 	volatile int		busy;	/* BOOL: protects all fields below */
 	int			sleeping; /* BOOL: wake us up on timer expiry */
 	ide_drive_t		*drive;	/* current drive */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/init.h linux-ac/include/linux/init.h
--- linux-ac.clean/include/linux/init.h	Tue Dec 25 22:39:30 2001
+++ linux-ac/include/linux/init.h	Fri Apr  5 01:33:19 2002
@@ -111,6 +111,9 @@
  */
 #define module_exit(x)	__exitcall(x);
 
+/* Data marked not to be saved by software_suspend() */
+#define __nosavedata __attribute__ ((__section__ (".data.nosave")))
+
 #else	/* MODULE */
 
 #define __init
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/mm.h linux-ac/include/linux/mm.h
--- linux-ac.clean/include/linux/mm.h	Fri Apr  5 01:55:10 2002
+++ linux-ac/include/linux/mm.h	Fri Apr  5 01:33:19 2002
@@ -303,6 +303,7 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
+#define PG_nosave		29
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
@@ -363,6 +364,12 @@
 #define SetPageReserved(page)		set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)		clear_bit(PG_reserved, &(page)->flags)
 #define __SetPageReserved(page)		__set_bit(PG_reserved, &(page)->flags)
+
+#define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
+#define PageSetNosave(page)	set_bit(PG_nosave, &(page)->flags)
+#define PageTestandSetNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
+#define PageClearNosave(page)		clear_bit(PG_nosave, &(page)->flags)
+#define PageTestandClearNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
 #define PageLRU(pp) \
 	(PageActive(pp) | PageInactiveDirty(pp) | PageInactiveClean(pp))
Only in linux-ac/include/linux: modules
Only in linux-ac/include/linux: modversions.h
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/reboot.h linux-ac/include/linux/reboot.h
--- linux-ac.clean/include/linux/reboot.h	Fri Feb  9 23:46:13 2001
+++ linux-ac/include/linux/reboot.h	Fri Apr  5 01:25:52 2002
@@ -20,6 +20,7 @@
  * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
+ * SW_SUSPEND  Suspend system using Software Suspend if compiled in
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
@@ -28,6 +29,7 @@
 #define	LINUX_REBOOT_CMD_CAD_OFF	0x00000000
 #define	LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
 #define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
+#define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2
 
 
 #ifdef __KERNEL__
@@ -45,6 +47,13 @@
 extern void machine_restart(char *cmd);
 extern void machine_halt(void);
 extern void machine_power_off(void);
+
+/*
+ * Architecture-independent suspend facility
+ */
+
+extern void software_suspend(void);
+extern unsigned char software_suspend_enabled;
 
 #endif
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/sched.h linux-ac/include/linux/sched.h
--- linux-ac.clean/include/linux/sched.h	Fri Apr  5 01:55:10 2002
+++ linux-ac/include/linux/sched.h	Fri Apr  5 01:33:19 2002
@@ -427,6 +427,10 @@
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
+#define PF_FROZEN	0x00008000	/* frozen for system suspend */
+#define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
+#define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
+#define PF_KERNTHREAD	0x00040000	/* this thread is a kernel thread that cannot be sent signals to */
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/suspend.h linux-ac/include/linux/suspend.h
--- linux-ac.clean/include/linux/suspend.h	Sun Nov 11 20:26:35 2001
+++ linux-ac/include/linux/suspend.h	Fri Apr  5 01:33:42 2002
@@ -0,0 +1,65 @@
+#ifndef _LINUX_SWSUSP_H
+#define _LINUX_SWSUSP_H
+
+#include <asm/suspend.h>
+#include <linux/swap.h>
+#include <linux/notifier.h>
+#include <linux/config.h>
+
+extern unsigned char software_suspend_enabled;
+
+#define NORESUME	 1
+#define RESUME_SPECIFIED 2
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/* page backup entry */
+typedef struct pbe {
+	unsigned long address;		/* address of the copy */
+	unsigned long orig_address;	/* original address of page */
+	swp_entry_t swap_address;	
+	swp_entry_t dummy;		/* we need scratch space at 
+					 * end of page (see link, diskpage)
+					 */
+} suspend_pagedir_t;
+
+#define SWAP_FILENAME_MAXLENGTH	32
+
+struct suspend_header {
+	__u32 version_code;
+	unsigned long num_physpages;
+	char machine[8];
+	char version[20];
+	int num_cpus;
+	int page_size;
+	unsigned long suspend_pagedir;
+	unsigned int num_pbes;
+	struct swap_location {
+		char filename[SWAP_FILENAME_MAXLENGTH];
+	} swap_location[MAX_SWAPFILES];
+};
+
+#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+   
+extern struct tq_struct suspend_tq;
+
+/* mm/vmscan.c */
+extern int shrink_mem(void);
+
+/* kernel/suspend.c */
+extern void software_suspend(void);
+extern void software_resume(void);
+extern int resume_setup(char *str);
+
+extern int register_suspend_notifier(struct notifier_block *);
+extern int unregister_suspend_notifier(struct notifier_block *);
+extern void refrigerator(unsigned long);
+
+#else
+#define software_suspend()		do { } while(0)
+#define software_resume()		do { } while(0)
+#define register_suspend_notifier(a)	do { } while(0)
+#define unregister_suspend_notifier(a)	do { } while(0)
+#define refrigerator(a)			do { BUG(); } while(0)
+#endif
+
+#endif /* _LINUX_SWSUSP_H */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/include/linux/tqueue.h linux-ac/include/linux/tqueue.h
--- linux-ac.clean/include/linux/tqueue.h	Mon Nov  5 21:42:13 2001
+++ linux-ac/include/linux/tqueue.h	Fri Apr  5 01:33:19 2002
@@ -66,7 +66,7 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
-extern task_queue tq_timer, tq_immediate, tq_disk;
+extern task_queue tq_timer, tq_immediate, tq_disk, tq_bdflush;
 
 /*
  * To implement your own list of active bottom halfs, use the following
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/init/main.c linux-ac/init/main.c
--- linux-ac.clean/init/main.c	Fri Apr  5 01:55:10 2002
+++ linux-ac/init/main.c	Fri Apr  5 01:25:52 2002
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -520,6 +521,10 @@
 #ifdef CONFIG_TC
 	tc_init();
 #endif
+
+	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
+	   log corrupting stuff */
+	software_resume();
 
 	/* Networking initialization needs a process context */ 
 	sock_init();
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/kernel/Makefile linux-ac/kernel/Makefile
--- linux-ac.clean/kernel/Makefile	Fri Apr  5 01:55:10 2002
+++ linux-ac/kernel/Makefile	Fri Apr  5 01:27:28 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o suspend.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
@@ -19,6 +19,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 
 ifneq ($(CONFIG_IA64),y)
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/kernel/context.c linux-ac/kernel/context.c
--- linux-ac.clean/kernel/context.c	Thu Oct 11 20:17:22 2001
+++ linux-ac/kernel/context.c	Fri Apr  5 01:25:52 2002
@@ -72,6 +72,7 @@
 
 	daemonize();
 	strcpy(curtask->comm, "keventd");
+	current->flags |= PF_IOTHREAD;
 	keventd_running = 1;
 	keventd_task = curtask;
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/kernel/signal.c linux-ac/kernel/signal.c
--- linux-ac.clean/kernel/signal.c	Fri Apr  5 01:55:10 2002
+++ linux-ac/kernel/signal.c	Fri Apr  5 01:25:52 2002
@@ -492,7 +492,7 @@
  * No need to set need_resched since signal event passing
  * goes through ->blocked
  */
-static inline void signal_wake_up(struct task_struct *t)
+inline void signal_wake_up(struct task_struct *t)
 {
 	t->sigpending = 1;
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/kernel/softirq.c linux-ac/kernel/softirq.c
--- linux-ac.clean/kernel/softirq.c	Fri Apr  5 01:55:10 2002
+++ linux-ac/kernel/softirq.c	Fri Apr  5 01:27:42 2002
@@ -365,6 +365,7 @@
 
 	daemonize();
 	set_user_nice(current, 19);
+ 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/kernel/suspend.c linux-ac/kernel/suspend.c
--- linux-ac.clean/kernel/suspend.c	Sun Nov 11 20:26:28 2001
+++ linux-ac/kernel/suspend.c	Fri Apr  5 01:37:34 2002
@@ -0,0 +1,1374 @@
+/*
+ * linux/kernel/swsusp.c
+ *
+ * This file is to realize architecture-independent
+ * machine suspend feature using pretty near only high-level routines
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ *
+ * I'd like to thank the following people for their work:
+ * 
+ * Pavel Machek <pavel@ucw.cz>:
+ * Modifications, defectiveness pointing, being with me at the very beginning,
+ * suspend to swap space, stop all tasks.
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
+ * More state savers are welcome. Especially for the scsi layer...
+ *
+ * For TODOs,FIXMEs also look in Documentation/swsusp.txt
+ *
+ * BIG FAT WARNING *********************************************************
+ *
+ * If you have unsupported (*) devices using DMA...
+ *				...say goodbye to your data.
+ *
+ * If you touch anything on disk between suspend and resume...
+ *				...kiss your data goodbye.
+ *
+ * If your disk driver does not support suspend... (IDE does)
+ *				...you'd better find out how to get along
+ *				   without your data.
+ *
+ * (*) pm interface support is needed to make it safe.
+ */
+
+/*
+ * TODO:
+ *
+ * - we should launch a kernel_thread to process suspend request, cleaning up
+ * bdflush from this task. (check apm.c for something similar).
+ */
+
+/* FIXME: try to poison to memory */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/swapctl.h>
+#include <linux/suspend.h>
+#include <linux/smp_lock.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/locks.h>
+#include <linux/vt_kern.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/kbd_kern.h>
+#include <linux/keyboard.h>
+#include <linux/spinlock.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/blk.h>
+#include <linux/swap.h>
+#include <linux/pm.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+
+unsigned char software_suspend_enabled = 0;
+
+/* #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1) */
+/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
+   we probably do not take enough locks for switching consoles, etc,
+   so bad things might happen.
+*/
+#ifndef CONFIG_VT
+#undef SUSPEND_CONSOLE
+#endif
+
+#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
+#define ADDRESS(x) ((unsigned long) phys_to_virt(((x) << PAGE_SHIFT)))
+
+extern void wakeup_bdflush(void);
+extern int C_A_D;
+
+/* References to section boundaries */
+extern char _text, _etext, _edata, __bss_start, _end;
+extern char __nosave_begin, __nosave_end;
+
+extern int console_loglevel;
+extern kdev_t suspend_device;
+extern int is_head_of_free_region(struct page *);
+
+/* Locks */
+spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
+
+/* Debug data */
+static int __nosavedata resume_dev = 0;
+
+/* Variables to be preserved over suspend */
+static int new_loglevel = 7;
+static int orig_loglevel = 0;
+static int orig_fgconsole;
+static int pagedir_order_check;
+static int nr_copy_pages_check;
+
+static int resume_status = 0;
+static char resume_file[256] = "";			/* For resume= kernel option */
+static kdev_t resume_device;
+/* Local variables that should not be affected by save */
+static unsigned int nr_copy_pages __nosavedata = 0;
+
+static int pm_suspend_state = 0;
+
+/* Suspend pagedir is allocated before final copy, therefore it
+   must be freed after resume 
+
+   Warning: this is evil. There are actually two pagedirs at time of
+   resume. One is "pagedir_save", which is empty frame allocated at
+   time of suspend, that must be freed. Second is "pagedir_nosave", 
+   allocated at time of resume, that travells through memory not to
+   collide with anything.
+ */
+static suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
+static unsigned long pagedir_save;
+static int pagedir_order __nosavedata = 0;
+
+struct link {
+	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
+	swp_entry_t next;
+};
+
+union diskpage {
+	union swap_header swh;
+	struct link link;
+	struct suspend_header sh;
+};
+
+/*
+ * XXX: We try to keep some more pages free so that I/O operations succeed
+ * without paging. Might this be more?
+ *
+ * [If this is not enough, might it corrupt our data silently?]
+ */
+#define PAGES_FOR_IO	512
+
+static const char *name_suspend = "Suspend Machine: ";
+static const char *name_resume = "Resume Machine: ";
+
+/*
+ * Debug
+ */
+#define	DEBUG_DEFAULT	1
+#undef	DEBUG_PROCESS
+#undef	DEBUG_SLOW
+
+#ifdef DEBUG_DEFAULT
+#define PRINTD(func, f, a...)	\
+	do { \
+		printk("%s", func); \
+		printk(f, ## a); \
+	} while(0)
+#define PRINTS(f, a...)	PRINTD(name_suspend, f, ## a)
+#define PRINTR(f, a...)	PRINTD(name_resume, f, ## a)
+#define PRINTK(f, a...)	printk(f, ## a)
+#else
+#define PRINTD(func, f, a...)
+#define PRINTS(f, a...)
+#define PRINTR(f, a...)
+#define PRINTK(f, a...)
+#endif
+#ifdef DEBUG_SLOW
+#define MDELAY(a) mdelay(a)
+#else
+#define MDELAY(a)
+#endif
+
+/*
+ * Refrigerator and related stuff
+ */
+
+#define INTERESTING(p) \
+			/* We don't want to touch kernel_threads..*/ \
+			if (p->flags & PF_IOTHREAD) \
+				continue; \
+			if (p == current) \
+				continue; \
+			if (p->state == TASK_ZOMBIE) \
+				continue;
+
+/* Refrigerator is place where frozen processes are stored :-). */
+void refrigerator(unsigned long flag)
+{
+	/* You need correct to work with real-time processes.
+	   OTOH, this way one process may see (via /proc/) some other
+	   process in stopped state (and thereby discovered we were
+	   suspended. We probably do not care. 
+	 */
+	long save;
+	save = current->state;
+	current->state = TASK_STOPPED;
+//	PRINTK("%s entered refrigerator\n", current->comm);
+	printk(":");
+	current->flags &= ~PF_FREEZE;
+	if (flag)
+		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
+					   and that may lead to 100%CPU sucking because those threads
+					   just don't manage signals. */
+	current->flags |= PF_FROZEN;
+	while (current->flags & PF_FROZEN)
+		schedule();
+//	PRINTK("%s left refrigerator\n", current->comm);
+	printk(":");
+	current->state = save;
+}
+
+/* 0 = success, else # of processes that we failed to stop */
+static int freeze_processes(void)
+{
+	int todo, start_time;
+	struct task_struct *p;
+	
+	PRINTS( "Waiting for tasks to stop... " );
+	
+	start_time = jiffies;
+	do {
+		todo = 0;
+		read_lock(&tasklist_lock);
+		for_each_task(p) {
+			unsigned long flags;
+			INTERESTING(p);
+			if (p->flags & PF_FROZEN)
+				continue;
+
+			/* FIXME: smp problem here: we may not access other process' flags
+			   without locking */
+			p->flags |= PF_FREEZE;
+			spin_lock_irqsave(&p->sigmask_lock, flags);
+			signal_wake_up(p);
+			spin_unlock_irqrestore(&p->sigmask_lock, flags);
+			todo++;
+		}
+		read_unlock(&tasklist_lock);
+		sys_sched_yield();
+		schedule();
+		if (time_after(jiffies, start_time + TIMEOUT)) {
+			PRINTK( "\n" );
+			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			return todo;
+		}
+	} while(todo);
+	
+	PRINTK( " ok\n" );
+	return 0;
+}
+
+static void thaw_processes(void)
+{
+	struct task_struct *p;
+
+	PRINTR( "Restarting tasks..." );
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		INTERESTING(p);
+		
+		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
+		else
+			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+		wake_up_process(p);
+	}
+	read_unlock(&tasklist_lock);
+	PRINTK( " done\n" );
+	MDELAY(500);
+}
+
+/*
+ * Saving part...
+ */
+
+static __inline__ int fill_suspend_header(struct suspend_header *sh)
+{
+	memset((char *)sh, 0, sizeof(*sh));
+
+	sh->version_code = LINUX_VERSION_CODE;
+	sh->num_physpages = num_physpages;
+	strncpy(sh->machine, system_utsname.machine, 8);
+	strncpy(sh->version, system_utsname.version, 20);
+	sh->num_cpus = smp_num_cpus;
+	sh->page_size = PAGE_SIZE;
+	sh->suspend_pagedir = (unsigned long)pagedir_nosave;
+	if (pagedir_save != pagedir_nosave)
+		panic("Must not happen");
+	sh->num_pbes = nr_copy_pages;
+	/* TODO: needed? mounted fs' last mounted date comparison
+	 * [so they haven't been mounted since last suspend.
+	 * Maybe it isn't.] [we'd need to do this for _all_ fs-es]
+	 */
+	return 0;
+}
+
+/*
+ * This is our sync function. With this solution we probably won't sleep
+ * but that should not be a problem since tasks are stopped..
+ */
+
+static void do_suspend_sync(void)
+{
+	sync_dev(0);
+	while (1) {
+		run_task_queue(&tq_disk);
+		if (!TQ_ACTIVE(tq_disk))
+			break;
+		printk(KERN_ERR "Hm, tq_disk is not empty after run_task_queue\n");
+	}
+}
+
+/* We memorize in swapfile_used what swap devices are used for suspension */
+#define SWAPFILE_UNUSED    0
+#define SWAPFILE_SUSPEND   1	/* This is the suspending device */
+#define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */
+
+static unsigned short swapfile_used[MAX_SWAPFILES];
+static unsigned short root_swap;
+#define MARK_SWAP_SUSPEND 0
+#define MARK_SWAP_RESUME 2
+
+static void mark_swapfiles(swp_entry_t prev, int mode)
+{
+	swp_entry_t entry;
+	union diskpage *cur;
+	
+	cur = (union diskpage *)get_free_page(GFP_ATOMIC);
+	if (!cur)
+		panic("Out of memory in mark_swapfiles");
+	/* XXX: this is dirty hack to get first page of swap file */
+	entry = SWP_ENTRY(root_swap, 0);
+	lock_page(virt_to_page((unsigned long)cur));
+	rw_swap_page_nolock(READ, entry, (char *) cur);
+
+	if (mode == MARK_SWAP_RESUME) {
+	  	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
+		else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
+		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
+		      	name_resume, cur->swh.magic.magic);
+	} else {
+	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
+		  	memcpy(cur->swh.magic.magic,"SUSP1R....",10);
+		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
+			memcpy(cur->swh.magic.magic,"SUSP2R....",10);
+		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
+		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
+		/* link.next lies *no more* in last 4 bytes of magic */
+	}
+	lock_page(virt_to_page((unsigned long)cur));
+	rw_swap_page_nolock(WRITE, entry, (char *)cur);
+	
+	free_page((unsigned long)cur);
+}
+
+static void read_swapfiles(void) /* This is called before saving image */
+{
+	int i, len;
+	
+	len=strlen(resume_file);
+	root_swap = 0xFFFF;
+	
+	swap_list_lock();
+	for(i=0; i<MAX_SWAPFILES; i++) {
+		if (swap_info[i].flags == 0) {
+			swapfile_used[i]=SWAPFILE_UNUSED;
+		} else {
+			if(!len) {
+	    			PRINTS(KERN_WARNING "resume= option should be used to set suspend device" );
+				if(root_swap == 0xFFFF) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else
+					swapfile_used[i] = SWAPFILE_IGNORED;				  
+			} else {
+	  			/* we ignore all swap devices that are not the resume_file */
+				if(resume_device == swap_info[i].swap_device) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else {
+					PRINTS( "device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
+				  	swapfile_used[i] = SWAPFILE_IGNORED;
+				}
+			}
+		}
+	}
+	swap_list_unlock();
+}
+
+static void lock_swapdevices(void) /* This is called after saving image so modification
+				      will be lost after resume... and that's what we want. */
+{
+	int i;
+
+	swap_list_lock();
+	for(i = 0; i< MAX_SWAPFILES; i++)
+		if(swapfile_used[i] == SWAPFILE_IGNORED) {
+			PRINTS( "device %s locked\n", swap_info[i].swap_file->d_name.name );
+			swap_info[i].flags ^= 0xFF; /* we make the device unusable. A new call to
+						       lock_swapdevices can unlock the devices. */
+		}
+	swap_list_unlock();
+}
+
+static int write_suspend_image(void)
+{
+	int i;
+	swp_entry_t entry, prev = { 0 };
+	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
+	union diskpage *cur,  *buffer = (union diskpage *)get_free_page(GFP_ATOMIC);
+	unsigned long address;
+
+	PRINTS( "Writing data to swap (%d pages): ", nr_copy_pages );
+	for (i=0; i<nr_copy_pages; i++) {
+		if (!(i%100))
+			PRINTK( "." );
+		if (!(entry = get_swap_page()).val)
+			panic("\nNot enough swapspace when writing data" );
+		
+		if(swapfile_used[SWP_TYPE(entry)] != SWAPFILE_SUSPEND)
+			panic("\nPage %d: not enough swapspace on suspend device", i );
+	    
+		address = (pagedir_nosave+i)->address;
+		lock_page(virt_to_page(address));
+		{
+			long dummy1, dummy2;
+			get_swaphandle_info(entry, &dummy1, &suspend_device, &dummy2);
+		}
+		rw_swap_page_nolock(WRITE, entry, (char *) address);
+		(pagedir_nosave+i)->swap_address = entry;
+	}
+	PRINTK(" done\n");
+	PRINTS( "Writing pagedir (%d pages): ", nr_pgdir_pages);
+	for (i=0; i<nr_pgdir_pages; i++) {
+		cur = (union diskpage *)((char *) pagedir_nosave)+i;
+		if ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE))
+			panic("Something is of wrong size");
+		PRINTK( "." );
+		if (!(entry = get_swap_page()).val) {
+			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
+			panic("Don't know how to recover");
+			free_page((unsigned long) buffer);
+			return -ENOSPC;
+		}
+
+		if(swapfile_used[SWP_TYPE(entry)] != SWAPFILE_SUSPEND)
+		  panic("\nNot enough swapspace for pagedir on suspend device" );
+
+		if (sizeof(swp_entry_t) != sizeof(long))
+			panic("I need swp_entry_t to be sizeof long, otherwise next assignment could damage pagedir");
+		if (PAGE_SIZE % sizeof(struct pbe))
+			panic("I need PAGE_SIZE to be integer multiple of struct pbe, otherwise next assignment could damage pagedir");
+		cur->link.next = prev;				
+		lock_page(virt_to_page((unsigned long)cur));
+		rw_swap_page_nolock(WRITE, entry, (char *) cur);
+		prev = entry;
+	}
+	PRINTK(", header");
+	if (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t))
+		panic("sizeof(struct suspend_header) too big: %d",
+				sizeof(struct suspend_header));
+	if (sizeof(union diskpage) != PAGE_SIZE)
+		panic("union diskpage has bad size");
+	if (!(entry = get_swap_page()).val)
+		panic( "\nNot enough swapspace when writing header" );
+	if(swapfile_used[SWP_TYPE(entry)] != SWAPFILE_SUSPEND)
+	  panic("\nNot enough swapspace for header on suspend device" );
+
+	cur = (void *) buffer;
+	if(fill_suspend_header(&cur->sh))
+		panic("\nOut of memory while writing header");
+		
+	cur->link.next = prev;
+
+	lock_page(virt_to_page((unsigned long)cur));
+	rw_swap_page_nolock(WRITE, entry, (char *) cur);
+	prev = entry;
+
+	PRINTK( ", signature" );
+#if 0
+	if (SWP_TYPE(entry) != 0)
+		panic("Need just one swapfile");
+#endif
+	mark_swapfiles(prev, MARK_SWAP_SUSPEND);
+	PRINTK( ", done\n" );
+
+	MDELAY(1000);
+	free_page((unsigned long) buffer);
+	return 0;
+}
+
+/* if pagedir_p != NULL it also copies the counted pages */
+static int count_and_copy_data_pages(struct pbe *pagedir_p)
+{
+	int chunk_size;
+	int nr_copy_pages = 0;
+	int loop;
+	
+	if (max_mapnr != num_physpages)
+		panic("mapnr is not expected");
+	for(loop = 0; loop < max_mapnr; loop++) {
+		if(PageHighMem(mem_map+loop))
+			panic("No highmem for me, sorry.");
+		if(!PageReserved(mem_map+loop)) {
+			if(PageNosave(mem_map+loop))
+				continue;
+
+			if((chunk_size=is_head_of_free_region(mem_map+loop))!=0) {
+				loop += chunk_size - 1;
+				continue;
+			}
+		} else if(PageReserved(mem_map+loop)) {
+			if(PageNosave(mem_map+loop))
+				panic("What?");
+
+			/*
+			 * Just copy whole code segment. Hopefully it is not that big.
+			 */
+			if (ADDRESS(loop) >= (unsigned long)
+				&__nosave_begin && ADDRESS(loop) < 
+				(unsigned long)&__nosave_end) {
+				printk("[nosave]");
+				continue;
+			}
+			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
+			   critical bios data? */
+		} else panic("No third thing should be possible");
+
+		nr_copy_pages++;
+		if(pagedir_p) {
+			pagedir_p->orig_address = ADDRESS(loop);
+			copy_page(pagedir_p->address, pagedir_p->orig_address);
+			pagedir_p++;
+		}
+	}
+	return nr_copy_pages;
+}
+
+static void free_suspend_pagedir(unsigned long this_pagedir)
+{
+	struct page *page = mem_map;
+	int i;
+	unsigned long this_pagedir_end = this_pagedir +
+		(PAGE_SIZE << pagedir_order);
+
+	for(i=0; i < num_physpages; i++, page++) {
+		if(!PageTestandClearNosave(page))
+			continue;
+
+		if(ADDRESS(i) >= this_pagedir && ADDRESS(i) < this_pagedir_end)
+			continue; /* old pagedir gets freed in one */
+		
+		free_page(ADDRESS(i));
+	}
+	free_pages(this_pagedir, pagedir_order);
+}
+
+static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
+{
+	int i;
+	suspend_pagedir_t *pagedir;
+	struct pbe *p;
+	struct page *page;
+
+	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	if(!pagedir)
+		return NULL;
+
+	page = virt_to_page(pagedir);
+	for(i=0; i < 1<<pagedir_order; i++)
+		PageSetNosave(page++);
+		
+	while(nr_copy_pages--) {
+		p->address = get_free_page(GFP_ATOMIC);
+		if(!p->address) {
+			panic("oom");
+			free_suspend_pagedir((unsigned long) pagedir);
+			return NULL;
+		}
+		PageSetNosave(virt_to_page(p->address));
+		p->orig_address = 0;
+		p++;
+	}
+	return pagedir;
+}
+
+static int prepare_suspend_console(void)
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
+	if(vt_waitactive(SUSPEND_CONSOLE)) {
+		PRINTS("Bummer. Can't switch VCs.");
+		return 1;
+	}
+#endif
+#endif
+	return 0;
+}
+
+static void restore_console(void)
+{
+	console_loglevel = orig_loglevel;
+#ifdef SUSPEND_CONSOLE
+	set_console (orig_fgconsole);
+#endif
+	return;
+}
+
+static int prepare_suspend_processes(void)
+{
+	PRINTS( "Stopping processes\n" );
+	MDELAY(1000);
+	if (freeze_processes()) {
+		PRINTS( "Not all processes stopped!\n" );
+//		panic("Some processes survived?\n");
+		thaw_processes();
+		return 1;
+	}
+	do_suspend_sync();
+	return 0;
+}
+
+/*
+ *	Free as much memory as possible
+ */
+
+static void **eaten_memory;
+
+static void eat_memory(void)
+{
+	int i = 0;
+	void **c= eaten_memory, *m;
+
+	printk("Eating pages ");
+	while ((m = (void *) get_free_page(GFP_HIGHUSER))) {
+		memset(m, 0, PAGE_SIZE);
+		eaten_memory = m;
+		if (!(i%100))
+			printk( ".(%d)", i ); 
+		*eaten_memory = c;
+		c = eaten_memory;
+		i++; 
+#if 1
+	/* 40000 == 160MB */
+	/* 10000 for 64MB */
+	/* 2500 for  16MB */
+		if (i > 40000)
+			break;
+#endif
+	}
+	printk("(%dK)\n", i*4);
+}
+
+static void free_memory(void)
+{
+	int i = 0;
+	void **c = eaten_memory, *f;
+	
+	printk( "Freeing pages " );
+	while (c) {
+		if (!(i%5000))
+		printk( "." ); 
+		f = *c;
+		c = *c;
+		if (f) { free_page( (long) f ); i++; }
+	}
+	printk( "(%dK)\n", i*4 );
+	eaten_memory = NULL;
+}
+
+/*
+ * Try to free as much memory as possible, but do not OOM-kill anyone
+ *
+ * Notice: all userland should be stopped at this point, or livelock is possible.
+ */
+static void free_some_memory(void)
+{
+#if 1
+	PRINTS("Freeing memory: ");
+	while (try_to_free_pages(GFP_KSWAPD))
+		printk(".");
+	printk("\n");
+#else
+	printk("Using memeat\n");
+	eat_memory();
+	free_memory();
+#endif
+}
+
+/* Make disk drivers accept operations, again */
+static void drivers_unsuspend(void)
+{
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_disk_unsuspend();
+#endif
+}
+
+/* Called from process context */
+static int drivers_suspend(void)
+{
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_disk_suspend();
+#else
+#error Are you sure your disk driver supports suspend?
+#endif
+	if(!pm_suspend_state) {
+		if(pm_send_all(PM_SUSPEND,(void *)3)) {
+			printk(KERN_WARNING "Problem while sending suspend event\n");
+			return(1);
+		}
+		pm_suspend_state=1;
+	} else
+		printk(KERN_WARNING "PM suspend state already raised\n");
+	  
+	return(0);
+}
+
+#define RESUME_PHASE1 1 /* Called from interrupts disabled */
+#define RESUME_PHASE2 2 /* Called with interrupts enabled */
+#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
+static void drivers_resume(int flags)
+{
+  	if(flags & RESUME_PHASE2) {
+#ifdef CONFIG_BLK_DEV_HD
+		do_reset_hd();			/* Kill all controller state */
+#endif
+	}
+  	if(flags & RESUME_PHASE1) {
+#ifdef CONFIG_BLK_DEV_IDE
+		ide_disk_resume();
+#endif
+	}
+  	if(flags & RESUME_PHASE2) {
+		if(pm_suspend_state) {
+			if(pm_send_all(PM_RESUME,(void *)0))
+				printk(KERN_WARNING "Problem while sending resume event\n");
+			pm_suspend_state=0;
+		} else
+			printk(KERN_WARNING "PM suspend state wasn't raised\n");
+
+#ifdef SUSPEND_CONSOLE
+		update_screen(fg_console);	/* Hmm, is this the problem? */
+#endif
+	}
+}
+
+static int suspend_save_image(void)
+{
+	struct sysinfo i;
+	unsigned int nr_needed_pages = 0;
+
+	pagedir_nosave = NULL;
+	PRINTS( "/critical section: Counting pages to copy" );
+	nr_copy_pages = count_and_copy_data_pages(NULL);
+	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
+	
+	PRINTK(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
+	if(nr_free_pages() < nr_needed_pages) {
+		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
+		       name_suspend, nr_needed_pages-nr_free_pages());
+		spin_unlock_irq(&suspend_pagedir_lock);
+		return 1;
+	}
+	si_swapinfo(&i);	/* FIXME: si_swapinfo(&i) returns all swap devices information.
+				   We should only consider resume_device. */
+	if (i.freeswap < nr_needed_pages)  {
+		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
+		       name_suspend, nr_needed_pages-i.freeswap);
+		spin_unlock_irq(&suspend_pagedir_lock);
+		return 1;
+	}
+
+	PRINTK( "Alloc pagedir\n" ); 
+	pagedir_save = pagedir_nosave = create_suspend_pagedir(nr_copy_pages);
+	if(!pagedir_nosave) {
+		/* Shouldn't happen */
+		printk(KERN_CRIT "%sCouldn't allocate enough pages\n",name_suspend);
+		panic("Really should not happen");
+		spin_unlock_irq(&suspend_pagedir_lock);
+		return 1;
+	}
+	nr_copy_pages_check = nr_copy_pages;
+	pagedir_order_check = pagedir_order;
+
+	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
+		panic("Count and copy returned another count than when counting?\n");
+
+	/*
+	 * End of critical section. From now on, we can write to memory,
+	 * but we should not touch disk. This specially means we must _not_
+	 * touch swap space! Except we must write out our image of course.
+	 *
+	 * Following line enforces not writing to disk until we choose.
+	 */
+	suspend_device = -1;					/* We do not want any writes, thanx */
+	drivers_unsuspend();
+	spin_unlock_irq(&suspend_pagedir_lock);
+	PRINTS( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+
+	lock_swapdevices();
+	write_suspend_image();
+	lock_swapdevices();	/* This will unlock ignored swap devices since writing is finished */
+
+	/* Image is saved, call sync & restart machine */
+	PRINTS( "Syncing disks\n" );
+	/* It is important _NOT_ to umount filesystems at this point. We want
+	 * them synced (in case something goes wrong) but we DO not want to mark
+	 * filesystem clean: it is not. (And it does not matter, if we resume
+	 * correctly, we'll mark system clean, anyway.)
+	 */
+#if 0
+	do_suspend_sync();
+/* Is this really so bright idea? We might corrupt FS here! */
+#endif
+	return 0;
+}
+
+void suspend_power_down(void)
+{
+	C_A_D = 0;
+	printk(KERN_EMERG "%sTrying to power down.\n", name_suspend);
+#ifdef CONFIG_VT
+	printk(KERN_EMERG "shift_state: %04x\n", shift_state);
+	mdelay(1000);
+	if ((shift_state & (1 << KG_CTRL)))
+		machine_power_off();
+	else
+#endif
+		machine_restart(NULL);
+
+
+	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
+	machine_halt();
+	while (1);
+	/* NOTREACHED */
+}
+
+static void restore_task(void)
+{
+	MDELAY(1000);
+#if 0
+	/* Should not be neccessary -- we saved whole CPU context */
+	PRINTR( "Activating task\n" );
+	activate_mm(current->mm,current->mm);
+	activate_task(current);
+#endif
+}
+
+/* forward decl */
+static void do_software_suspend(void);
+
+/*
+ * Magic happens here
+ */
+
+static void do_magic_resume_1(void)
+{
+	barrier();
+	mb();
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
+
+	printk( "Waiting for DMAs to settle down...\n");
+	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
+			   Do it with disabled interrupts for best effect. That way, if some
+			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
+}
+
+static void do_magic_resume_2(void)
+{
+	if (nr_copy_pages_check != nr_copy_pages)
+		panic("nr_copy_pages changed?!");
+	if (pagedir_order_check != pagedir_order)
+		panic("pagedir_order changed?!");
+
+	PRINTR( "Freeing prev allocated pagedir\n" );
+	free_suspend_pagedir(pagedir_save);
+	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
+	drivers_resume(RESUME_ALL_PHASES);
+	spin_unlock_irq(&suspend_pagedir_lock);
+
+	PRINTK( "Fixing swap signatures... " );
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	PRINTK( "ok\n" );
+
+#if 0
+	restore_task ();	/* Should not be neccessary! */
+#endif
+#ifdef SUSPEND_CONSOLE
+	update_screen(fg_console);	/* Hmm, is this the problem? */
+#endif
+	suspend_tq.routine = (void *)do_software_suspend;
+}
+
+static void do_magic_suspend_1(void)
+{
+	mb();
+	barrier();
+	spin_lock_irq(&suspend_pagedir_lock);
+}
+
+static void do_magic_suspend_2(void)
+{
+	read_swapfiles();
+	if (!suspend_save_image()) {
+#if 1
+		suspend_power_down ();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+#endif
+	}
+
+	suspend_device = 0;
+	printk(KERN_WARNING "%sSuspend failed, trying to recover...\n", name_suspend);
+	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
+
+	barrier();
+	mb();
+	drivers_resume(RESUME_PHASE2);
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
+	mdelay(1000);
+
+	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	drivers_resume(RESUME_PHASE1);
+	spin_unlock_irq(&suspend_pagedir_lock);
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	suspend_tq.routine = (void *)do_software_suspend;
+	printk(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
+}
+
+#define SUSPEND_C
+#include <asm/suspend.h>
+
+/*
+ * This function is triggered using process bdflush. We try to swap out as
+ * much as we can then make a copy of the occupied pages in memory so we can
+ * make a copy of kernel state atomically, the I/O needed by saving won't
+ * bother us anymore.
+ */
+static void do_software_suspend(void)
+{
+	arch_prepare_suspend();
+	if (!prepare_suspend_console()) {
+		if (!prepare_suspend_processes()) {
+			free_some_memory();
+
+			/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
+			 *
+			 * We sync here -- so you have consistent filesystem state when things go wrong.
+			 * -- so that noone writes to disk after we do atomic copy of data.
+			 */
+			PRINTS( "Syncing disks before copy\n" );
+			do_suspend_sync();
+#if 0
+			schedule_timeout(1*HZ);	/* Is this needed to get data properly to disk? */
+#endif
+			drivers_suspend();
+			if(drivers_suspend()==0)
+				do_magic(0);			/* This function returns after machine woken up from resume */
+			PRINTR("Restarting processes...\n");
+			thaw_processes();
+		}
+	}
+	software_suspend_enabled = 1;
+	PRINTR( "Done resume from %x\n", resume_dev );
+	MDELAY(1000);
+	restore_console ();
+}
+
+struct tq_struct suspend_tq =
+	{ routine: (void *)(void *)do_software_suspend, 
+	  data: 0 };
+
+/*
+ * This is the trigger function, we must queue ourself since we
+ * can be called from interrupt && bdflush context is needed
+ */
+void software_suspend(void)
+{
+	if(!software_suspend_enabled)
+		return;
+
+	software_suspend_enabled = 0;
+	queue_task(&suspend_tq, &tq_bdflush);
+	wakeup_bdflush();
+}
+
+/* More restore stuff */
+
+/* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
+static void copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
+{
+	int i;
+	char *topointer=(char *)to, *frompointer=(char *)from;
+
+	for(i=0; i < 1 << pagedir_order; i++) {
+		copy_page(topointer, frompointer);
+		topointer += PAGE_SIZE;
+		frompointer += PAGE_SIZE;
+	}
+}
+
+#define does_collide(addr)	\
+		does_collide_order(pagedir_nosave, addr, 0)
+
+/*
+ * Returns true if given address/order collides with any orig_address 
+ */
+static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
+		int order)
+{
+	int i;
+	unsigned long addre = addr + (PAGE_SIZE<<order);
+	
+	for(i=0; i < nr_copy_pages; i++)
+		if((pagedir+i)->orig_address >= addr &&
+			(pagedir+i)->orig_address < addre)
+			return 1;
+
+	return 0;
+}
+
+/*
+ * We check here that pagedir & pages it points to won't collide with pages
+ * where we're going to restore from the loaded pages later
+ */
+
+static int check_pagedir(void)
+{
+	int i;
+
+	for(i=0; i < nr_copy_pages; i++) {
+		unsigned long addr;
+
+		do {
+			addr = get_free_page(GFP_ATOMIC);
+			if(!addr)
+				return -ENOMEM;
+		} while (does_collide(addr));
+
+		(pagedir_nosave+i)->address = addr;
+	}
+	return 0;
+}
+
+static int relocate_pagedir(void)
+{
+	/* This is deep magic
+	   We have to avoid recursion (not to overflow kernel stack), and that's why
+	   code looks pretty cryptic
+	*/
+	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
+	void **eaten_memory = NULL;
+	void **c = eaten_memory, *m, *f;
+
+
+	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
+		printk("not neccessary\n");
+		return 0;
+	}
+
+	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
+		memset(m, 0, PAGE_SIZE);
+		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
+			break;
+		eaten_memory = m;
+		printk( "." ); 
+		*eaten_memory = c;
+		c = eaten_memory;
+	}
+
+	if (!m)
+		return -ENOMEM;
+
+	pagedir_nosave = new_pagedir = m;
+	copy_pagedir(new_pagedir, old_pagedir);
+
+	c = eaten_memory;
+	while(c) {
+		printk(":");
+		f = *c;
+		c = *c;
+		if (f)
+			free_pages((unsigned long)f, pagedir_order);
+	}
+	printk("okay\n");
+	return 0;
+}
+
+/*
+ * Sanity check if this image makes sense with this kernel/swap context
+ * I really don't think that it's foolproof but more than nothing..
+ */
+
+static int sanity_check_failed(char *reason)
+{
+	printk(KERN_ERR "%s%s\n",name_resume,reason);
+	return -EPERM;
+}
+
+static int sanity_check(struct suspend_header *sh)
+{
+	if(sh->version_code != LINUX_VERSION_CODE)
+		return sanity_check_failed("Incorrect kernel version");
+	if(sh->num_physpages != num_physpages)
+		return sanity_check_failed("Incorrect memory size");
+	if(strncmp(sh->machine, system_utsname.machine, 8))
+		return sanity_check_failed("Incorrect machine type");
+	if(strncmp(sh->version, system_utsname.version, 20))
+		return sanity_check_failed("Incorrect version");
+	if(sh->num_cpus != smp_num_cpus)
+		return sanity_check_failed("Incorrect number of cpus");
+	if(sh->page_size != PAGE_SIZE)
+		return sanity_check_failed("Incorrect PAGE_SIZE");
+	return 0;
+}
+
+int bdev_read(kdev_t dev, long pos, void *buf, long count)
+{
+	struct buffer_head *bh;
+	if ((pos%PAGE_SIZE) || (count != PAGE_SIZE)) panic("Sorry, dave, I can't let you do that!\n");
+	bh = bread(dev, pos/PAGE_SIZE, PAGE_SIZE);
+	if (!bh || (!bh->b_data)) {
+		return -1;
+	}
+	memcpy(buf, bh->b_data, PAGE_SIZE);
+	brelse(bh);			/* FIXME: maybe bforget should be here */
+	return 0;
+} 
+
+/* Checked up-to HERE */
+
+int resume_try_to_read(const char * specialfile)
+{
+	union diskpage *cur;
+	swp_entry_t next;
+	int i, nr_pgdir_pages, error;
+	int blksize = 0;
+
+	resume_device = name_to_kdev_t(specialfile);
+	cur = (void *) get_free_page(GFP_ATOMIC);
+	if (!cur) {
+		printk( "%sNot enough memory?\n", name_resume );
+		error = -ENOMEM;
+		goto resume_read_error;
+	}
+
+	printk("Resuming from device %x\n", resume_device);
+	resume_dev = resume_device;
+
+	if (!blksize_size[MAJOR(resume_device)]) {
+		printk("Blocksize not known?\n");
+	} else blksize = blksize_size[MAJOR(resume_device)][MINOR(resume_device)];
+	if (!blksize) {
+		printk("Blocksize not set?\n");
+		blksize = 0;
+	}
+	set_blocksize(resume_device, PAGE_SIZE);
+
+#define READTO(pos, ptr) \
+	if (bdev_read(resume_device, pos, ptr, PAGE_SIZE)) { error = -EIO; goto resume_read_error; }
+#define PREPARENEXT \
+	{	next = cur->link.next; \
+		next.val = SWP_OFFSET(next) * PAGE_SIZE; \
+        }
+
+	error = -EIO;
+	READTO(0, cur);
+
+	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)) ||
+	    (!memcmp("SWAPSPACE2",cur->swh.magic.magic,10))) {
+		printk(KERN_ERR "%sThis is normal swap space\n", name_resume );
+		error = -EINVAL;
+		goto resume_read_error;
+	}
+
+	PREPARENEXT; /* We have to read next position before we overwrite it */
+
+	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+		memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
+	else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
+	else {
+		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
+			name_resume, cur->swh.magic.magic);
+	}
+	printk( "%sSignature found, resuming\n", name_resume );
+	MDELAY(1000);
+
+	READTO(next.val, cur);
+
+	error = -EPERM;
+	if (sanity_check(&cur->sh))
+		goto resume_read_error;
+
+	/* Probably this is the same machine */	
+
+	PREPARENEXT;
+
+	pagedir_save = cur->sh.suspend_pagedir;
+	nr_copy_pages = cur->sh.num_pbes;
+	nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
+	pagedir_order = get_bitmask_order(nr_pgdir_pages);
+
+	error = -ENOMEM;
+	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	if(!pagedir_nosave)
+		goto resume_read_error;
+
+	PRINTR( "%sReading pagedir, ", name_resume );
+
+	/* We get pages in reverse order of saving! */
+	error=-EIO;
+	for (i=nr_pgdir_pages-1; i>=0; i--) {
+		if (!next.val)
+			panic( "Preliminary end of suspended data?" );
+		cur = (union diskpage *)((char *) pagedir_nosave)+i;
+		READTO(next.val, cur);
+		PREPARENEXT;
+	}
+	if (next.val)
+		panic( "Suspended data too long?" );
+
+	printk("Relocating pagedir");
+	if((error=relocate_pagedir())!=0)
+		goto resume_read_error;
+	if((error=check_pagedir())!=0)
+		goto resume_read_error;
+
+	PRINTK( "image data (%d pages): ", nr_copy_pages );
+	error = -EIO;
+	for(i=0; i < nr_copy_pages; i++) {
+		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
+		if (!(i%100))
+			PRINTK( "." );
+		next.val = SWP_OFFSET (swap_address) * PAGE_SIZE;
+		/* You do not need to check for overlaps...
+		   ... check_pagedir already did this work */
+		READTO(next.val, (char *)((pagedir_nosave+i)->address));
+	}
+	PRINTK( " done\n" );
+	error = 0;
+
+resume_read_error:
+	switch (error) {
+		case 0:
+			PRINTR("Reading resume file was successful\n");
+			break;
+		case -EINVAL:
+			break;
+		case -EIO:
+			printk( "%sI/O error\n", name_resume);
+			panic("Wanted to resume but it did not work\n");
+			break;
+		case -ENOENT:
+			printk( "%s%s: No such file or directory\n", name_resume, specialfile);
+			panic("Wanted to resume but it did not work\n");
+			break;
+		default:
+			printk( "%sError %d resuming\n", name_resume, error );
+			panic("Wanted to resume but it did not work\n");
+	}
+	set_blocksize(resume_device, blksize);	/* Needed! In case its is normal swap space */
+	MDELAY(1000);
+	return error;
+}
+
+/*
+ * Called from init kernel_thread.
+ * We check if we have an image and if so we try to resume
+ */
+
+void software_resume(void)
+{
+#ifdef CONFIG_SMP
+	printk(KERN_WARNING "Software Suspend has a malfunctioning SMP support. Disabled :(\n");
+#else
+	/* We enable the possibility of machine suspend */
+	software_suspend_enabled = 1;
+#endif
+	if(!resume_status)
+		return;
+
+	printk( "%s", name_resume );
+	if(resume_status == NORESUME) {
+		/* FIXME: Signature should be restored here */
+		printk( "disabled\n" );
+		return;
+	}
+	MDELAY(1000);
+
+	orig_loglevel = console_loglevel;
+	console_loglevel = new_loglevel;
+
+	if(!resume_file[0] && resume_status == RESUME_SPECIFIED) {
+		printk( "nowhere to resume from\n" );
+		return;
+	}
+
+	printk( "resuming from %s\n", resume_file);
+	if(resume_try_to_read(resume_file))
+		goto read_failure;
+	do_magic(1);
+	panic("This never returns");
+
+read_failure:
+	console_loglevel = orig_loglevel;
+	return;
+}
+
+
+int resume_setup(char *str)
+{
+	if(resume_status)
+		return 1;
+
+	strncpy( resume_file, str, 255 );
+	resume_status = RESUME_SPECIFIED;
+
+	return 1;
+}
+
+static int __init software_noresume(char *str)
+{
+	if(!resume_status)
+	  printk(KERN_WARNING "noresume option has overridden a resume= option\n");
+	resume_status = NORESUME;
+	
+	return 1;
+}
+
+__setup("noresume", software_noresume);
+__setup("resume=", resume_setup);
+
+EXPORT_SYMBOL(software_suspend);
+EXPORT_SYMBOL(software_suspend_enabled);
+EXPORT_SYMBOL(refrigerator);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/kernel/sys.c linux-ac/kernel/sys.c
--- linux-ac.clean/kernel/sys.c	Fri Apr  5 01:55:10 2002
+++ linux-ac/kernel/sys.c	Fri Apr  5 01:25:52 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/utsname.h>
@@ -322,6 +323,16 @@
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);
 		break;
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	case LINUX_REBOOT_CMD_SW_SUSPEND:
+		if(!software_suspend_enabled)
+			return -EAGAIN;
+		
+		software_suspend();
+		do_exit(0);
+		break;
+#endif
 
 	default:
 		unlock_kernel();
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/mm/page_alloc.c linux-ac/mm/page_alloc.c
--- linux-ac.clean/mm/page_alloc.c	Fri Apr  5 01:55:11 2002
+++ linux-ac/mm/page_alloc.c	Fri Apr  5 01:27:53 2002
@@ -23,6 +23,7 @@
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/mm_inline.h>
+#include <linux/suspend.h>
 
 int nr_swap_pages;
 int nr_active_pages;
@@ -246,6 +247,46 @@
 
 	return NULL;
 }
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+int is_head_of_free_region(struct page *p)
+{
+	pg_data_t *pgdat = pgdat_list;
+	unsigned type;
+	unsigned long flags;
+
+	for (type=0;type < MAX_NR_ZONES; type++) {
+		zone_t *zone = pgdat->node_zones + type;
+		int order = MAX_ORDER - 1;
+		free_area_t *area;
+		struct list_head *head, *curr;
+		spin_lock_irqsave(&zone->lock, flags);	/* Should not matter as we need quiescent system for suspend anyway, but... */
+
+		do {
+			area = zone->free_area + order;
+			head = &area->free_list;
+			curr = head;
+
+			for(;;) {
+				if(!curr) {
+//					printk("FIXME: this should not happen but it does!!!");
+					break;
+				}
+				if(p != memlist_entry(curr, struct page, list)) {
+					curr = memlist_next(curr);
+					if (curr == head)
+						break;
+					continue;
+				}
+				return 1 << order;
+			}
+		} while(order--);
+		spin_unlock_irqrestore(&zone->lock, flags);
+
+	}
+	return 0;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/mm/page_io.c linux-ac/mm/page_io.c
--- linux-ac.clean/mm/page_io.c	Wed Dec  5 23:46:07 2001
+++ linux-ac/mm/page_io.c	Fri Apr  5 01:25:52 2002
@@ -87,11 +87,15 @@
  *  - it's marked as being swap-cache
  *  - it's associated with the swap inode
  */
+extern long suspend_device;
 void rw_swap_page(int rw, struct page *page)
 {
 	swp_entry_t entry;
 
 	entry.val = page->index;
+
+	if (suspend_device)
+		panic("I refuse to corrupt memory/swap.");
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak linux-ac.clean/mm/vmscan.c linux-ac/mm/vmscan.c
--- linux-ac.clean/mm/vmscan.c	Fri Apr  5 01:55:11 2002
+++ linux-ac/mm/vmscan.c	Fri Apr  5 01:28:40 2002
@@ -25,6 +25,7 @@
 #include <linux/file.h>
 #include <linux/compiler.h>
 #include <linux/mm_inline.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 
@@ -672,13 +673,16 @@
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC;
+	tsk->flags |= PF_MEMALLOC | PF_KERNTHREAD;
 
 	/*
 	 * Kswapd main loop.
 	 */
 	for (;;) {
 		static long recalc = 0;
+
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		/*
 		 * We try to rebalance the VM either when we have a
Only in linux-ac/scripts: mkdep
Only in linux-ac/scripts: split-include

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
