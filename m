Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316752AbSEUWb2>; Tue, 21 May 2002 18:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSEUWb1>; Tue, 21 May 2002 18:31:27 -0400
Received: from [195.39.17.254] ([195.39.17.254]:19098 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316752AbSEUWbD>;
	Tue, 21 May 2002 18:31:03 -0400
Date: Wed, 22 May 2002 00:28:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020521222858.GA14737@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's suspend-to-{RAM,disk} combined patch for
2.5.17. Suspend-to-disk is pretty stable and was tested in
2.4-ac. Suspend-to-RAM is little more experimental, but works for me,
and is certainly better than disk-eating version currently in kernel.

Major parts are: process stopper, S3 specific code, S4 specific
code. What can I do to make this applied?

									Pavel

--- clean/Documentation/driver-model.txt	Sun Mar 10 20:06:28 2002
+++ linux-swsusp/Documentation/driver-model.txt	Fri May  3 00:08:35 2002
@@ -52,7 +52,8 @@
 Each bus layer should implement the callbacks for these drivers. It then
 forwards the calls on to the device-specific callbacks. This means that
 device-specific drivers must still implement callbacks for each operation.
-But, they are not called from the top level driver layer.
+But, they are not called from the top level driver layer. [So for example
+PCI devices will not call device_register but pci_device_register.]
 
 This does add another layer of indirection for calling one of these functions,
 but there are benefits that are believed to outweigh this slowdown.
@@ -60,7 +61,7 @@
 First, it prevents device-specific drivers from having to know about the
 global device layer. This speeds up integration time incredibly. It also
 allows drivers to be more portable across kernel versions. Note that the
-former was intentional, the latter is an added bonus.
+former was intentional, the latter is an added bonus. 
 
 Second, this added indirection allows the bus to perform any additional logic
 necessary for its child devices. A bus layer may add additional information to
@@ -225,7 +226,6 @@
 	It also allows the platform driver (e.g. ACPI) to a driver without the driver
 	having to have explicit knowledge of (atrocities like) ACPI.
 
-
 current_state:
 	Current power state of the device. For PCI and other modern devices, this is
 	0-3, though it's not necessarily limited to those values.
@@ -251,18 +251,24 @@
 }
 
 probe:
-	Check for device existence and associate driver with it.
+	Check for device existence and associate driver with it. In case of device 
+	insertion, *all* drivers are called. Struct device has parent and bus_id 
+	valid at this point. probe() may only be called from process context. Returns
+	0 if it handles that device, -ESRCH if this driver does not know how to handle
+	this device, valid error otherwise.
 
 remove:
 	Dissociate driver with device. Releases device so that it could be used by
 	another driver. Also, if it is a hotplug device (hotplug PCI, Cardbus), an
-	ejection event could take place here.
+	ejection event could take place here. remove() can be called from interrupt 
+	context. [Fixme: Is that good?] Returns 0 on success. [Can we recover from
+	failed remove or should I define that remove() never fails?]
 
 suspend:
-	Perform one step of the device suspend process.
+	Perform one step of the device suspend process. Returns 0 on success.
 
 resume:
-	Perform one step of the device resume process.
+	Perform one step of the device resume process. Returns 0 on success.
 
 The probe() and remove() callbacks are intended to be much simpler than the
 current PCI correspondents.
@@ -275,7 +281,7 @@
 
 Some device initialisation was done in probe(). This should not be the case
 anymore. All initialisation should take place in the open() call for the
-device.
+device. [FIXME: How do you "open" uhci?]
 
 Breaking initialisation code out must also be done for the resume() callback,
 as most devices will have to be completely reinitialised when coming back from
@@ -324,6 +330,7 @@
 
 enum{
 	SUSPEND_NOTIFY,
+	SUSPEND_DISABLE,
 	SUSPEND_SAVE_STATE,
 	SUSPEND_POWER_DOWN,
 };
@@ -331,6 +338,7 @@
 enum {
 	RESUME_POWER_ON,
 	RESUME_RESTORE_STATE,
+	RESUME_ENABLE,
 };
 
 
@@ -352,9 +360,9 @@
 Instead, the walking of the device tree has been moved to userspace. When a
 user requests the system to suspend, it will walk the device tree, as exported
 via driverfs, and tell each device to go to sleep. It will do this multiple
-times based on what the system policy is.
-
-[ FIXME: URL pointer to the corresponding utility is missing here! ]
+times based on what the system policy is. [Not possible. Take ACPI enabled 
+system, with battery critically low. In such state, you want to suspend-to-disk,
+*fast*. User maybe is not even running powerd (think system startup)!]
 
 Device resume should happen in the same manner when the system awakens.
 
@@ -366,22 +374,25 @@
 cannot resume the hardware from the requested level, or it feels that it is
 too important to be put to sleep, it should return an error from this function.
 
-It does not have to stop I/O requests or actually save state at this point.
+It does not have to stop I/O requests or actually save state at this point. Called
+from process context.
 
 SUSPEND_DISABLE:
 
 The driver should stop taking I/O requests at this stage. Because the save
 state stage happens afterwards, the driver may not want to physically disable
-the device; only mark itself unavailable if possible.
+the device; only mark itself unavailable if possible. Called from process 
+context.
 
 SUSPEND_SAVE_STATE:
 
 The driver should allocate memory and save any device state that is relevant
-for the state it is going to enter.
+for the state it is going to enter. Called from process context.
 
 SUSPEND_POWER_DOWN:
 
-The driver should place the device in the power state requested.
+The driver should place the device in the power state requested. May be called
+from interrupt context.
 
 
 For resume, the stages are defined as follows:
@@ -389,25 +400,27 @@
 RESUME_POWER_ON:
 
 Devices should be powered on and reinitialised to some known working state.
+Called from process context.
 
 RESUME_RESTORE_STATE:
 
 The driver should restore device state to its pre-suspend state and free any
-memory allocated for its saved state.
+memory allocated for its saved state. Called from process context.
 
 RESUME_ENABLE:
 
-The device should start taking I/O requests again.
+The device should start taking I/O requests again. Called from process context.
 
 
 Each driver does not have to implement each stage. But, it if it does
-implemente a stage, it should do what is described above. It should not assume
+implement a stage, it should do what is described above. It should not assume
 that it performed any stage previously, or that it will perform any stage
-later.
+later. [Really? It makes sense to support SAVE_STATE only after DISABLE].
 
 It is quite possible that a driver can fail during the suspend process, for
 whatever reason. In this event, the calling process must gracefully recover
-and restore everything to their states before the suspend transition began.
+and restore everything to their states before the suspend transition began. 
+[Suspend may not fail, think battery low.]
 
 If a driver knows that it cannot suspend or resume properly, it should fail
 during the notify stage. Properly implemented power management schemes should
--- clean/Documentation/swsusp.txt	Sat Jan  5 21:39:47 2002
+++ linux-swsusp/Documentation/swsusp.txt	Fri May  3 00:08:35 2002
@@ -0,0 +1,159 @@
+From kernel/suspend.c:
+
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
+
+You need to append resume=/dev/your_swap_partition to kernel command
+line. Then you suspend by echo 4 > /proc/acpi/sleep.
+
+[Notice. Rest docs is pretty outdated (see date!) It should be safe to
+use swsusp on ext3/reiserfs these days.]
+
+
+Article about goals and implementation of Software Suspend for Linux
+Author: G‚ábor Kuti
+Last revised: 2002-04-08
+
+Idea and goals to achieve
+
+Nowadays it is common in several laptops that they have a suspend button. It
+saves the state of the machine to a filesystem or to a partition and switches
+to standby mode. Later resuming the machine the saved state is loaded back to
+ram and the machine can continue its work. It has two real benefits. First we
+save ourselves the time machine goes down and later boots up, energy costs
+real high when running from batteries. The other gain is that we don't have to
+interrupt our programs so processes that are calculating something for a long
+time shouldn't need to be written interruptible.
+
+On desk machines the power saving function isn't as important as it is in
+laptops but we really may benefit from the second one. Nowadays the number of
+desk machines supporting suspend function in their APM is going up but there
+are (and there will still be for a long time) machines that don't even support
+APM of any kind. On the other hand it is reported that using APM's suspend
+some irqs (e.g. ATA disk irq) is lost and it is annoying for the user until
+the Linux kernel resets the device.
+
+So I started thinking about implementing Software Suspend which doesn't need
+any APM support and - since it uses pretty near only high-level routines - is
+supposed to be architecture independent code.
+
+Using the code
+
+The code is experimental right now - testers, extra eyes are welcome. To
+compile this support into the kernel, you need CONFIG_EXPERIMENTAL, 
+and then CONFIG_SOFTWARE_SUSPEND in menu General Setup to be  enabled. It
+cannot be used as a module and I don't think it will ever be needed.
+
+You have two ways to use this code. The first one is if you've compiled in
+sysrq support then you may press Sysrq-D to request suspend. The other way
+is with a patched SysVinit (my patch is against 2.76 and available at my
+home page). You might call 'swsusp' or 'shutdown -z <time>'. Next way is to
+echo 4 > /proc/acpi/sleep.
+
+Either way it saves the state of the machine into active swaps and then
+reboots. You must explicitly specify the swap partition to resume from with ``resume=''
+kernel option. If signature is found it loads and restores saved state. If the
+option ``noresume'' is specified as a boot parameter, it skips the resuming.
+Warning! Look at section ``Things to implement'' to see what isn't yet
+implemented.  Also I strongly suggest you to list all active swaps in
+/etc/fstab. Firstly because you don't have to specify anything to resume and
+secondly if you have more than one swap area you can't decide which one has the
+'root' signature. 
+
+In the meantime while the system is suspended you should not touch any of the
+hardware!
+
+About the code
+Goals reached
+
+The code can be downloaded from
+http://falcon.sch.bme.hu/~seasons/linux/. It mainly works but there are still
+some of XXXs, TODOs, FIXMEs in the code which seem not to be too important. It
+should work all right except for the problems listed in ``Things to
+implement''. Notes about the code are really welcome.
+
+How the code works
+
+When suspending is triggered it immediately wakes up process bdflush. Bdflush
+checks whether we have anything in our run queue tq_bdflush. Since we queued up
+function do_software_suspend, it is called. Here we shrink everything including
+dcache, inodes, buffers and memory (here mainly processes are swapped out). We
+count how many pages we need to duplicate (we have to be atomical!) then we
+create an appropiate sized page directory. It will point to the original and
+the new (copied) address of the page. We get the free pages by
+__get_free_pages() but since it changes state we have to be able to track it
+later so it also flips in a bit in page's flags (a new Nosave flag). We
+duplicate pages and then mark them as used (so atomicity is ensured). After
+this we write out the image to swaps, do another sync and the machine may
+reboot. We also save registers to stack.
+
+By resuming an ``inverse'' method is executed. The image if exists is loaded,
+loadling is either triggered by ``resume='' kernel option.  We
+change our task to bdflush (it is needed because if we don't do this init does
+an oops when it is waken up later) and then pages are copied back to their
+original location. We restore registers, free previously allocated memory,
+activate memory context and task information. Here we should restore hardware
+state but even without this the machine is restored and processes are continued
+to work. I think hardware state should be restored by some list (using
+notify_chain) and probably by some userland program (run-parts?) for users'
+pleasure. Check out my patch at the same location for the sysvinit patch.
+
+WARNINGS!
+- It does not like pcmcia cards. And this is logical: pcmcia cards need cardmgr to be
+  initialized. they are not initialized during singleuser boot, but "resumed" kernel does
+  expect them to be initialized. That leads to armagedon. You should eject any pcmcia cards
+  before suspending.
+
+Things to implement
+- SMP support. I've done an SMP support but since I don't have access to a kind
+  of this one I cannot test it. Please SMP people test it.  .. Tested it,
+  doesn't work. Had no time to figure out why. There is some mess with
+  interrupts AFAIK..
+- We should only make a copy of data related to kernel segment, since any
+  process data won't be changed.
+- By copying pages back to their original position, copy_page caused General
+  Protection Fault. Why?
+- Hardware state restoring.  Now there's support for notifying via the notify
+  chain, event handlers are welcome. Some devices may have microcodes loaded
+  into them. We should have event handlers for them aswell.
+- We should support other architectures (There are really only some arch
+  related functions..)
+- We should also restore original state of swaps if the ``noresume'' kernel
+  option is specified.. Or do we need such a feature to save state for some
+  other time? Do we need some kind of ``several saved states''?  (Linux-HA
+  people?). There's been some discussion about checkpointing on linux-future.
+- Should make more sanity checks. Or are these enough?
+
+Not so important ideas for implementing
+
+- If a real time process is running then don't suspend the machine.
+- Is there any sense in compressing the outwritten pages?
+- Support for power.conf file as in Solaris, autoshutdown, special
+  devicetypes support, maybe in sysctl.
+- Introduce timeout for SMP locking. But first locking ought to work :O
+- Pre-detect if we don't have enough swap space or free it instead of
+  calling panic.
+- Support for adding/removing hardware while suspended?
+- We should not free pages at the beginning so aggressively, most of them
+  go there anyway..
+- If X is active while suspending then by resuming calling svgatextmode
+  corrupts the virtual console of X.. (Maybe this has been fixed AFAIK).
+
+Any other idea you might have tell me!
+
+Contacting the author
+If you have any question or any patch that solves the above or detected
+problems please contact me at seasons@falcon.sch.bme.hu. I might delay
+answering, sorry about that.
+
--- clean/MAINTAINERS	Tue May 21 23:21:35 2002
+++ linux-swsusp/MAINTAINERS	Tue May 21 23:33:30 2002
@@ -1446,6 +1446,14 @@
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
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/arch/i386/Config.help linux-swsusp/arch/i386/Config.help
--- clean/arch/i386/Config.help	Thu May  2 21:12:02 2002
+++ linux-swsusp/arch/i386/Config.help	Fri May  3 00:08:35 2002
@@ -940,3 +940,28 @@
 CONFIG_DEBUG_OBSOLETE
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
+
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
--- clean/arch/i386/boot/video.S	Thu Jul  5 20:28:16 2001
+++ linux-swsusp/arch/i386/boot/video.S	Sun May 19 16:23:15 2002
@@ -438,6 +438,7 @@
 
 # Setting of user mode (AX=mode ID) => CF=success
 mode_set:
+	movw	%ax, %fs:(0x01fa)		# Store mode for use in acpi_wakeup.S
 	movw	%ax, %bx
 	cmpb	$0xff, %ah
 	jz	setalias
--- clean/arch/i386/config.in	Mon May 13 23:26:57 2002
+++ linux-swsusp/arch/i386/config.in	Wed May  8 23:40:20 2002
@@ -396,6 +396,9 @@
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   dep_bool 'Software Suspend' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
+fi
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
--- clean/arch/i386/defconfig	Sun May 19 18:52:01 2002
+++ linux-swsusp/arch/i386/defconfig	Sun May 19 19:03:14 2002
@@ -119,6 +119,7 @@
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 # CONFIG_APM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
 
 #
 # Memory Technology Devices (MTD)
--- clean/arch/i386/kernel/acpi.c	Mon May 13 23:26:57 2002
+++ linux-swsusp/arch/i386/kernel/acpi.c	Sun May 19 17:31:33 2002
@@ -44,6 +44,8 @@
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 #include <asm/tlbflush.h>
+#define ACPI_C
+#include <asm/suspend.h>
 
 
 #define PREFIX			"ACPI: "
@@ -621,6 +623,34 @@
 {
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
+}
+
+/*
+ * (KG): Since we affect stack here, we make this function as flat and easy
+ * as possible in order to not provoke gcc to use local variables on the stack.
+ * Note that on resume, all (expect nosave) variables will have the state from
+ * the time of writing (suspend_save_image) and the registers (including the
+ * stack pointer, but excluding the instruction pointer) will be loaded with 
+ * the values saved at save_processor_context() time.
+ */
+void do_suspend_magic(int resume)
+{
+	/* DANGER WILL ROBINSON!
+	 *
+	 * If this function is too difficult for gcc to optimize, it will crash and burn!
+	 * see above.
+	 *
+	 * DO NOT TOUCH.
+	 */
+	if (!resume) {
+		save_processor_context();
+		acpi_save_register_state((unsigned long)&&acpi_sleep_done);
+		acpi_enter_sleep_state(3);
+		return;
+	}
+acpi_sleep_done:
+	restore_processor_context();
+	printk("CPU context restored...\n");
 }
 
 #endif /*CONFIG_ACPI_SLEEP*/
--- clean/arch/i386/kernel/acpi_wakeup.S	Thu May  2 21:12:03 2002
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	Sun May 19 17:33:32 2002
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 
+# Do we need to deal with A20?
 
 ALIGN
 wakeup_start:
@@ -10,8 +11,16 @@
 	wakeup_code_start = .
 	.code16
 
+ 	movw	$0xb800, %ax
+	movw	%ax,%fs
+	movw	$0x0e00 + 'L', %fs:(0x10)
 	cli
 	cld
+	  
+# setup video mode
+#	movw	$0x4117, %bx		# 0x4000 for linear framebuffer
+#	movw	$0x4f02, %ax
+#	int	$0x10
 
 	# setup data segment
 	movw	%cs, %ax
@@ -20,6 +29,14 @@
 	movw	%ax, %ds
 	movw	%ax, %ss
 	mov	$(wakeup_stack - wakeup_data), %sp		# Private stack is needed for ASUS board
+	movw	$0x0e00 + 'S', %fs:(0x12)	
+
+	movl	real_magic - wakeup_data, %eax
+	cmpl	$0x12345678, %eax
+	jne	bogus_real_magic
+
+	mov	video_mode - wakeup_data, %ax
+	call	mode_set
 
 	# set up page table
 	movl	(real_save_cr3 - wakeup_data), %eax
@@ -28,40 +45,114 @@
 	# make sure %cr4 is set correctly (features, etc)
 	movl	(real_save_cr4 - wakeup_data), %eax
 	movl	%eax, %cr4
+	movw	$0xb800, %ax
+	movw	%ax,%fs
+	movw	$0x0e00 + 'i', %fs:(0x12)
 
 	# need a gdt
 	lgdt	real_save_gdt - wakeup_data
 
-	movl	%cr0, %eax
-	orl     $0x80000001, %eax
+	movl	(real_save_cr0 - wakeup_data), %eax
 	movl	%eax, %cr0
+	movw	$0x0e00 + 'n', %fs:(0x14)
+
+	movl	real_magic - wakeup_data, %eax
+	cmpl	$0x12345678, %eax
+	jne	bogus_real_magic
 
 	ljmpl	$__KERNEL_CS,$wakeup_pmode_return
 
+bogus_real_magic:
+	movw	$0x0e00 + 'B', %fs:(0x12)
+	jmp bogus_real_magic
+
+/* This code uses an extended set of video mode numbers. These include:
+ * Aliases for standard modes
+ *	NORMAL_VGA (-1)
+ *	EXTENDED_VGA (-2)
+ *	ASK_VGA (-3)
+ * Video modes numbered by menu position -- NOT RECOMMENDED because of lack
+ * of compatibility when extending the table. These are between 0x00 and 0xff.
+ */
+#define VIDEO_FIRST_MENU 0x0000
+
+/* Standard BIOS video modes (BIOS number + 0x0100) */
+#define VIDEO_FIRST_BIOS 0x0100
+
+/* VESA BIOS video modes (VESA number + 0x0200) */
+#define VIDEO_FIRST_VESA 0x0200
+
+/* Video7 special modes (BIOS number + 0x0900) */
+#define VIDEO_FIRST_V7 0x0900
+
+# Setting of user mode (AX=mode ID) => CF=success
+mode_set:
+	movw	%ax, %bx
+#if 0
+	cmpb	$0xff, %ah
+	jz	setalias
+
+	testb	$VIDEO_RECALC>>8, %ah
+	jnz	_setrec
+
+	cmpb	$VIDEO_FIRST_RESOLUTION>>8, %ah
+	jnc	setres
+	
+	cmpb	$VIDEO_FIRST_SPECIAL>>8, %ah
+	jz	setspc
+
+	cmpb	$VIDEO_FIRST_V7>>8, %ah
+	jz	setv7
+#endif
+	
+	cmpb	$VIDEO_FIRST_VESA>>8, %ah
+	jnc	check_vesa
+#if 0	
+	orb	%ah, %ah
+	jz	setmenu
+#endif
+	
+	decb	%ah
+#	jz	setbios				  Add bios modes later
+
+setbad:	clc
+	ret
+
+check_vesa:
+	subb	$VIDEO_FIRST_VESA>>8, %bh
+	orw	$0x4000, %bx			# Use linear frame buffer
+	movw	$0x4f02, %ax			# VESA BIOS mode set call
+	int	$0x10
+	cmpw	$0x004f, %ax			# AL=4f if implemented
+	jnz	_setbad				# AH=0 if OK
+
+	stc
+	ret
+
+_setbad: jmp setbad
+
 	.code32
 	ALIGN
 
-.org	0x100
+.org	0x300
 wakeup_data:
 		.word 0
 real_save_gdt:	.word 0
 		.long 0
+real_save_cr0:	.long 0
 real_save_cr3:	.long 0
 real_save_cr4:	.long 0
+real_magic:	.long 0
+video_mode:	.long 0
 
-.org	0x300
+.org	0x500
 wakeup_stack:
 wakeup_end:
 
 wakeup_pmode_return:
-	# restore data segment
 	movl	$__KERNEL_DS, %eax
-	movw	%ax, %ds
-	movw	%ax, %es
-
-	# and restore the stack
-	movw	%ax, %ss
-	movl	saved_esp, %esp
+	movl	%eax, %ds
+	movw	$0x0e00 + 'u', %ds:(0xb8016)
 
 	# restore other segment registers
 	xorl	%eax, %eax
@@ -72,6 +163,30 @@
 	lgdt	saved_gdt
 	lidt	saved_idt
 	lldt	saved_ldt
+	ljmp	$(__KERNEL_CS),$1f
+1:
+	movl	%cr3, %eax
+	movl	%eax, %cr3
+	wbinvd
+
+	# and restore the stack ... but you need gdt for this to work
+	movl	$__KERNEL_DS, %eax
+	movw	%ax, %ss
+	movw	%ax, %ds
+	movw	%ax, %es
+	movw	%ax, %fs
+	movw	%ax, %gs
+	movl	saved_esp, %esp
+
+	movw	$0x0e00 + 'W', %ds:(0xb8018)
+	movl	$(1024*1024*3), %ecx
+	movl	$0, %esi
+	rep	lodsb
+	movw	$0x0e00 + 'O', %ds:(0xb8018)
+
+	movl	%cs:saved_magic2, %eax
+	cmpl	$0x12345678, %eax
+	jne	bogus_magic
 
 	# restore the other general registers
 	movl	saved_ebx, %ebx
@@ -81,8 +196,21 @@
 
 	# jump to place where we left off
 	movl	saved_eip,%eax
+	movw	$0x0e00 + 'x', %ds:(0xb8018)
+	pushl	%eax
+	popl	%eax
+	movw	$0x0e00 + '!', %ds:(0xb801a)
 	jmp	*%eax
 
+bogus_magic:
+	movw	$0x0e00 + 'B', %ds:(0xb8018)
+	jmp bogus_magic
+
+bogus_magic2:
+	movw	$0x0e00 + '2', %ds:(0xb8018)
+	jmp bogus_magic2
+		
+
 ##
 # acpi_copy_wakeup_routine
 #
@@ -113,23 +241,22 @@
 	movl    %edx, real_save_cr3 - wakeup_start (%eax)
 	movl    %cr4, %edx
 	movl    %edx, real_save_cr4 - wakeup_start (%eax)
+	movl	%cr0, %edx
+	movl	%edx, real_save_cr0 - wakeup_start (%eax)
 	sgdt    real_save_gdt - wakeup_start (%eax)
 
+	movl	saved_videomode, %edx
+	movl	%edx, video_mode - wakeup_start (%eax)
+	movl	$0x12345678, real_magic - wakeup_start (%eax)
+	movl	$0x12345678, saved_magic2
+
 	# restore the regs we used
 	popl	%edi
 	popl	%esi
 	ret
 
-
 .data
 ALIGN
-# saved registers
-saved_gdt:	.long	0,0
-saved_idt:	.long	0,0
-saved_ldt:	.long	0
-saved_tss:	.long	0
-saved_cr0:	.long	0
-
 ENTRY(saved_ebp)	.long	0
 ENTRY(saved_esi)	.long	0
 ENTRY(saved_edi)	.long	0
@@ -137,3 +264,16 @@
 
 ENTRY(saved_eip)	.long	0
 ENTRY(saved_esp)	.long	0
+
+ENTRY(saved_magic)	.long	0
+ENTRY(saved_magic2)	.long	0	
+ENTRY(saved_videomode)	.long	0
+
+ALIGN
+# saved registers
+saved_gdt:	.long	0,0
+saved_idt:	.long	0,0
+saved_ldt:	.long	0
+saved_tss:	.long	0
+saved_cr0:	.long	0
+
--- clean/arch/i386/kernel/apm.c	Thu May  2 21:12:03 2002
+++ linux-swsusp/arch/i386/kernel/apm.c	Fri May  3 00:08:35 2002
@@ -1667,6 +1667,7 @@
 	daemonize();
 
 	strcpy(current->comm, "kapmd");
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	if (apm_info.connection_version == 0) {
--- clean/arch/i386/kernel/i8259.c	Thu May  2 21:12:03 2002
+++ linux-swsusp/arch/i386/kernel/i8259.c	Fri May  3 00:08:35 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -237,7 +238,19 @@
 	}
 }
 
-void __init init_8259A(int auto_eoi)
+static struct device device_i8259A = {
+	name:	       	"i8259A",
+	bus_id:		"0020",
+};
+
+static void __init init_8259A_devicefs(void)
+{
+	register_sys_device(&device_i8259A);
+}
+
+__initcall(init_8259A_devicefs);
+
+void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
--- clean/arch/i386/kernel/setup.c	Sun May 19 18:52:01 2002
+++ linux-swsusp/arch/i386/kernel/setup.c	Sun May 19 19:03:14 2002
@@ -168,6 +168,8 @@
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
 
+extern unsigned long saved_videomode;
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -182,6 +184,7 @@
 #define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
 #define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
 #define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
+#define VIDEO_MODE (*(unsigned short *) (PARAM+0x1FA))
 #define ORIG_ROOT_DEV (*(unsigned short *) (PARAM+0x1FC))
 #define AUX_DEVICE_INFO (*(unsigned char *) (PARAM+0x1FF))
 #define LOADER_TYPE (*(unsigned char *) (PARAM+0x210))
@@ -681,6 +684,8 @@
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	apm_info.bios = APM_BIOS_INFO;
+	saved_videomode = VIDEO_MODE;
+	printk("Video mode to be used for restore is %lx\n", saved_videomode);
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
 		machine_id = SYS_DESC_TABLE.table[0];
--- clean/arch/i386/kernel/signal.c	Mon May 13 23:27:07 2002
+++ linux-swsusp/arch/i386/kernel/signal.c	Mon May 13 23:02:53 2002
@@ -21,6 +21,7 @@
 #include <linux/tty.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -594,6 +595,11 @@
 	if ((regs->xcs & 3) != 3)
 		return 1;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(0);
+		goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -701,6 +707,7 @@
 		return 1;
 	}
 
+ no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/arch/i386/kernel/time.c linux-swsusp/arch/i386/kernel/time.c
--- clean/arch/i386/kernel/time.c	Sun Mar 10 20:06:31 2002
+++ linux-swsusp/arch/i386/kernel/time.c	Fri May  3 00:08:35 2002
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -635,6 +636,17 @@
 bad_ctc:
 	return 0;
 }
+
+static struct device device_i8253;
+
+static void time_init_driverfs(void)
+{
+	strcpy(device_i8253.name, "i8253");
+	strcpy(device_i8253.bus_id, "0040");
+	register_sys_device(&device_i8253);
+}
+
+__initcall(time_init_driverfs);
 
 void __init time_init(void)
 {
--- clean/arch/i386/vmlinux.lds	Sun May 19 18:52:01 2002
+++ linux-swsusp/arch/i386/vmlinux.lds	Sun May 19 19:03:14 2002
@@ -66,6 +66,12 @@
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
--- clean/drivers/acpi/acpi_system.c	Thu Apr 18 22:45:30 2002
+++ linux-swsusp/drivers/acpi/acpi_system.c	Sun May 19 17:25:33 2002
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/sysrq.h>
 #include <linux/pm.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
 #include "acpi_bus.h"
@@ -128,6 +129,12 @@
 	/* restore device context */
 	device_resume(RESUME_RESTORE_STATE);
 #endif
+
+	if (dmi_broken & BROKEN_INIT_AFTER_S1) {
+		printk("Broken toshiba laptop -> kicking interrupts\n");
+		init_8259A(0);
+	}
+
 	return AE_OK;
 }
 
@@ -254,23 +261,21 @@
 	switch (state)
 	{
 	case ACPI_STATE_S1:
-		/* do nothing */
+		barrier();
+		status = acpi_enter_sleep_state(state);
 		break;
 
 	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
-		acpi_save_register_state((unsigned long)&&acpi_sleep_done);
+		do_suspend_magic(0);
 		break;
 	}
 
-	barrier();
-	status = acpi_enter_sleep_state(state);
-
-acpi_sleep_done:
-
+	printk("acpi_restore_register_state...");
 	acpi_restore_register_state();
 	restore_flags(flags);
 
+	printk("acpi returning...");
 	return status;
 }
 
@@ -290,6 +295,8 @@
 	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
 		return AE_ERROR;
 
+	freeze_processes();
+
 	/* do we have a wakeup address for S2 and S3? */
 	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3) {
 		if (!acpi_wakeup_address)
@@ -315,7 +322,9 @@
 	 * no matter what.
 	 */
 	acpi_system_restore_state(state);
+	printk("acpi_leave_sleep_state...");
 	acpi_leave_sleep_state(state);
+	printk("ook\n");
 
 	/* make sure interrupts are enabled */
 	ACPI_ENABLE_IRQS();
@@ -323,6 +332,8 @@
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) 0);
 
+	thaw_processes();
+
 	return status;
 }
 
@@ -700,8 +773,17 @@
 	
 	if (!system->states[state])
 		return_VALUE(-ENODEV);
+
 	
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	if (state == 4) {
+		/* We are working from process context, that's why we may call it directly. */ 
+		do_software_suspend();
+		return_VALUE(count);
+	}
+#endif
 	status = acpi_suspend(state);
+
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);
 	
@@ -1180,6 +1262,10 @@
 		}
 	}
 	printk(")\n");
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	printk(KERN_INFO "Software suspend => we can do S4.");
+	system->states[4] = 1;
+#endif
 
 #ifdef CONFIG_PM
 	/* Install the soft-off (S5) handler. */
--- clean/drivers/block/floppy.c	Tue May 21 23:21:37 2002
+++ linux-swsusp/drivers/block/floppy.c	Tue May 21 23:33:32 2002
@@ -173,6 +173,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -4178,11 +4179,15 @@
 
 static int have_no_fdc= -ENODEV;
 
+static struct device device_floppy;
 
 int __init floppy_init(void)
 {
 	int i,unit,drive;
 
+	strcpy(device_floppy.name, "floppy");
+	strcpy(device_floppy.bus_id, "03?0");
+	register_sys_device(&device_floppy);
 
 	raw_cmd = NULL;
 
--- clean/drivers/block/ll_rw_blk.c	Tue May 21 23:21:37 2002
+++ linux-swsusp/drivers/block/ll_rw_blk.c	Tue May 21 23:33:32 2002
@@ -1418,7 +1419,9 @@
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
 	req->waiting = NULL;
 	req->bio = req->biotail = bio;
-	req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
+	if (bio->bi_bdev)
+		req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
+	else	req->rq_dev = NODEV;
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
--- clean/drivers/block/loop.c	Mon May 13 22:30:12 2002
+++ linux-swsusp/drivers/block/loop.c	Mon May  6 11:39:11 2002
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
@@ -534,6 +534,7 @@
 	daemonize();
 
 	sprintf(current->comm, "loop%d", lo->lo_number);
+	current->flags |= PF_IOTHREAD;
 
 	spin_lock_irq(&current->sigmask_lock);
 	sigfillset(&current->blocked);
--- clean/drivers/char/sysrq.c	Thu Mar 21 11:35:58 2002
+++ linux-swsusp/drivers/char/sysrq.c	Fri May  3 00:08:35 2002
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
--- clean/drivers/ide/ide-disk.c	Sun May 19 18:52:03 2002
+++ linux-swsusp/drivers/ide/ide-disk.c	Sun May 19 19:03:17 2002
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/suspend.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -561,6 +562,8 @@
 	/* I hope that every freeze operations from the upper levels have
 	 * already been done...
 	 */
+
+	BUG_ON(in_interrupt());
 
 	if (level != SUSPEND_SAVE_STATE)
 		return 0;
--- clean/drivers/pci/power.c	Tue May 21 23:21:39 2002
+++ linux-swsusp/drivers/pci/power.c	Tue May 21 23:33:33 2002
@@ -110,7 +110,7 @@
 	return error;
 }
 
-static int pci_pm_suspend(u32 state)
+int pci_pm_suspend(u32 state)
 {
 	struct list_head *list;
 	struct pci_bus *bus;
@@ -123,7 +123,7 @@
 	return 0;
 }
 
-static int pci_pm_resume(void)
+int pci_pm_resume(void)
 {
 	struct list_head *list;
 	struct pci_bus *bus;
--- clean/drivers/usb/storage/usb.c	Sun May 19 18:52:05 2002
+++ linux-swsusp/drivers/usb/storage/usb.c	Sun May 19 19:03:20 2002
@@ -323,6 +323,7 @@
 	/* avoid getting signals */
 	spin_lock_irq(&current->sigmask_lock);
 	flush_signals(current);
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sigmask_lock);
--- clean/fs/buffer.c	Tue May 21 23:21:40 2002
+++ linux-swsusp/fs/buffer.c	Tue May 21 23:33:34 2002
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/mempool.h>
 #include <linux/hash.h>
+#include <linux/suspend.h>
 #include <asm/bitops.h>
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
@@ -122,6 +123,8 @@
 	smp_mb__after_clear_bit();
 	wake_up_buffer(bh);
 }
+
+DECLARE_TASK_QUEUE(tq_bdflush);
 
 /*
  * Block until a buffer comes unlocked.  This doesn't stop it
--- clean/fs/jbd/journal.c	Tue May 21 23:21:41 2002
+++ linux-swsusp/fs/jbd/journal.c	Tue May 21 23:35:33 2002
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
@@ -225,6 +226,7 @@
 			journal->j_commit_interval / HZ);
 	list_add(&journal->j_all_journals, &all_journals);
 
+	current->flags |= PF_KERNTHREAD;
 	/* And now, wait forever for commit wakeup events. */
 	while (1) {
 		if (journal->j_flags & JFS_UNMOUNT)
@@ -245,7 +247,15 @@
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
 
--- clean/fs/reiserfs/journal.c	Tue May 21 23:21:42 2002
+++ linux-swsusp/fs/reiserfs/journal.c	Tue May 21 23:33:36 2002
@@ -57,6 +57,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/suspend.h> 
 
 /* the number of mounted filesystems.  This is used to decide when to
 ** start and kill the commit thread
@@ -1886,6 +1887,7 @@
   spin_unlock_irq(&current->sigmask_lock);
 
   sprintf(current->comm, "kreiserfsd") ;
+  current->flags |= PF_KERNTHREAD;
   lock_kernel() ;
   while(1) {
 
@@ -1899,7 +1901,12 @@
       break ;
     }
     wake_up(&reiserfs_commit_thread_done) ;
-    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
+#ifdef CONFIG_SOFTWARE_SUSPEND
+    if (current->flags & PF_FREEZE) {
+	    refrigerator(PF_IOTHREAD);
+    } else
+#endif
+	    interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
   }
   unlock_kernel() ;
   wake_up(&reiserfs_commit_thread_done) ;
--- clean/include/asm-generic/bitops.h	Tue Nov 28 02:47:38 2000
+++ linux-swsusp/include/asm-generic/bitops.h	Fri May  3 00:08:35 2002
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
--- clean/include/asm-i386/bitops.h	Thu Apr 25 12:51:49 2002
+++ linux-swsusp/include/asm-i386/bitops.h	Fri May  3 00:21:33 2002
@@ -414,6 +414,12 @@
 	return word;
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /*
--- clean/include/asm-i386/suspend.h	Tue Feb  5 23:17:28 2002
+++ linux-swsusp/include/asm-i386/suspend.h	Wed May 22 00:02:18 2002
@@ -0,0 +1,304 @@
+#ifndef __ASM_I386_SUSPEND_H
+#define __ASM_I386_SUSPEND_H
+#endif
+
+/*
+ * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+ * Based on code
+ * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+ */
+#if defined(SUSPEND_C) || defined(ACPI_C)
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
+static void fix_processor_context(void)
+{
+	int nr = smp_processor_id();
+	struct tss_struct * t = &init_tss[nr];
+
+	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+        gdt_table[__TSS(nr)].b &= 0xfffffdff;
+
+	load_TR(nr);		/* This does ltr */
+
+	load_LDT(&current->mm->context);	/* This does lldt */
+
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
+static void
+do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
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
+	asm volatile ("ltr (%0)"  :: "m" (saved_context.tr));
+#endif
+
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
+#endif
+#ifdef SUSPEND_C
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
+
--- clean/include/linux/bitops.h	Mon Nov  5 21:42:13 2001
+++ linux-swsusp/include/linux/bitops.h	Fri May  3 00:21:33 2002
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
--- clean/include/linux/init.h	Thu Mar 21 11:36:09 2002
+++ linux-swsusp/include/linux/init.h	Fri May  3 00:21:33 2002
@@ -169,6 +169,9 @@
 
 #endif
 
+/* Data marked not to be saved by software_suspend() */
+#define __nosavedata __attribute__ ((__section__ (".data.nosave")))
+
 #ifdef CONFIG_HOTPLUG
 #define __devinit
 #define __devinitdata
--- clean/include/linux/page-flags.h	Tue May 21 23:21:44 2002
+++ linux-swsusp/include/linux/page-flags.h	Tue May 21 23:35:57 2002
@@ -64,6 +64,7 @@
 
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
+#define PG_nosave		15	/* Used for system suspend/resume */
 
 /*
  * Global page accounting.  One instance per CPU.
@@ -206,6 +207,12 @@
 			dec_page_state(nr_writeback);			\
 		ret;							\
 	})
+
+#define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
+#define SetPageNosave(page)	set_bit(PG_nosave, &(page)->flags)
+#define TestSetPageNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
+#define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
+#define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
--- clean/include/linux/reboot.h	Fri Feb  9 23:46:13 2001
+++ linux-swsusp/include/linux/reboot.h	Fri May  3 00:21:36 2002
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
 
--- clean/include/linux/sched.h	Sun May 19 18:52:06 2002
+++ linux-swsusp/include/linux/sched.h	Tue May 21 23:37:55 2002
@@ -388,6 +388,11 @@
 #define PF_FLUSHER	0x00004000	/* responsible for disk writeback */
 #define PF_RADIX_TREE	0x00008000	/* debug: performing radix tree alloc */
 
+#define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
+#define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
+#define PF_KERNTHREAD	0x00040000	/* this thread is a kernel thread that cannot be sent signals to */
+#define PF_FROZEN	0x00080000	/* frozen for system suspend */
+
 /*
  * Ptrace flags
  */
--- clean/include/linux/suspend.h	Tue Feb  5 23:17:31 2002
+++ linux-swsusp/include/linux/suspend.h	Wed May 22 00:02:21 2002
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
--- clean/include/linux/tqueue.h	Wed Apr 24 23:06:46 2002
+++ linux-swsusp/include/linux/tqueue.h	Tue May 21 23:37:55 2002
@@ -66,7 +66,7 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
-extern task_queue tq_timer, tq_immediate, tq_disk;
+extern task_queue tq_timer, tq_immediate, tq_disk, tq_bdflush;
 
 /*
  * To implement your own list of active bottom halfs, use the following
--- clean/init/do_mounts.c	Mon May 13 23:26:59 2002
+++ linux-swsusp/init/do_mounts.c	Wed May  8 23:40:24 2002
@@ -10,6 +10,7 @@
 #include <linux/fd.h>
 #include <linux/tty.h>
 #include <linux/init.h>
+#include <linux/suspend.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -825,6 +826,11 @@
 #endif
 
 	create_dev("/dev/root", ROOT_DEV, NULL);
+
+	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
+	   log corrupting stuff */
+	software_resume();
+
 	if (mount_initrd) {
 		if (initrd_load() && !kdev_same(ROOT_DEV, mk_kdev(RAMDISK_MAJOR, 0))) {
 			handle_initrd();
--- clean/kernel/Makefile	Thu Apr 18 22:46:18 2002
+++ linux-swsusp/kernel/Makefile	Fri May  3 00:08:35 2002
@@ -10,7 +10,7 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o 
+		printk.o platform.o suspend.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
@@ -21,6 +21,7 @@
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
+obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
--- clean/kernel/context.c	Tue Mar  5 21:52:50 2002
+++ linux-swsusp/kernel/context.c	Fri May  3 00:08:35 2002
@@ -72,6 +72,7 @@
 
 	daemonize();
 	strcpy(curtask->comm, "keventd");
+	current->flags |= PF_IOTHREAD;
 	keventd_running = 1;
 	keventd_task = curtask;
 
--- clean/kernel/signal.c	Mon May 13 23:27:11 2002
+++ linux-swsusp/kernel/signal.c	Mon May 13 23:03:21 2002
@@ -493,7 +493,7 @@
  * No need to set need_resched since signal event passing
  * goes through ->blocked
  */
-static inline void signal_wake_up(struct task_struct *t)
+inline void signal_wake_up(struct task_struct *t)
 {
 	set_tsk_thread_flag(t,TIF_SIGPENDING);
 
--- clean/kernel/softirq.c	Thu Jan 31 23:42:30 2002
+++ linux-swsusp/kernel/softirq.c	Fri May  3 00:08:35 2002
@@ -365,6 +365,7 @@
 
 	daemonize();
 	set_user_nice(current, 19);
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
--- clean/kernel/suspend.c	Sun Nov 11 20:26:28 2001
+++ linux-swsusp/kernel/suspend.c	Tue May 21 23:49:20 2002
@@ -0,0 +1,1327 @@
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
+#include <linux/device.h>
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
+extern int is_head_of_free_region(struct page *);
+
+/* Locks */
+spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
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
+#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
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
+int freeze_processes(void)
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
+void thaw_processes(void)
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
+//	sync_dev(0); FIXME
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
+	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
+				if(root_swap == 0xFFFF) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else
+					swapfile_used[i] = SWAPFILE_IGNORED;				  
+			} else {
+	  			/* we ignore all swap devices that are not the resume_file */
+				if (1) {
+// FIXME				if(resume_device == swap_info[i].swap_device) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else {
+#if 0
+					PRINTS( "device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
+#endif
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
+//			PRINTS( "device %s locked\n", swap_info[i].swap_file->d_name.name );
+			swap_info[i].flags ^= 0xFF; /* we make the device unusable. A new call to
+						       lock_swapdevices can unlock the devices. */
+		}
+	swap_list_unlock();
+}
+
+kdev_t suspend_device;
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
+			get_swaphandle_info(entry, &dummy1, &suspend_device);
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
+		if(!TestClearPageNosave(page))
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
+		SetPageNosave(page++);
+		
+	while(nr_copy_pages--) {
+		p->address = get_free_page(GFP_ATOMIC);
+		if(!p->address) {
+			panic("oom");
+			free_suspend_pagedir((unsigned long) pagedir);
+			return NULL;
+		}
+		SetPageNosave(virt_to_page(p->address));
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
+	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
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
+	device_resume(RESUME_ENABLE);
+	device_resume(RESUME_RESTORE_STATE);
+}
+
+/* Called from process context */
+static int drivers_suspend(void)
+{
+	device_suspend(4, SUSPEND_NOTIFY);
+	device_suspend(4, SUSPEND_SAVE_STATE);
+	device_suspend(4, SUSPEND_DISABLE);
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
+	device_resume(RESUME_ENABLE);
+	device_resume(RESUME_RESTORE_STATE);
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
+	suspend_device = NODEV;					/* We do not want any writes, thanx */
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
+	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
+		machine_restart(NULL);
+	else
+#endif
+		machine_power_off();
+
+	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
+	machine_halt();
+	while (1);
+	/* NOTREACHED */
+}
+
+/* forward decl */
+void do_software_suspend(void);
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
+	suspend_device = NODEV;
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
+void do_software_suspend(void)
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
+			drivers_suspend();
+			if(drivers_suspend()==0)
+				do_magic(0);			/* This function returns after machine woken up from resume */
+			PRINTR("Restarting processes...\n");
+			thaw_processes();
+		}
+	}
+	software_suspend_enabled = 1;
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
+static int bdev_read_page(kdev_t dev, long pos, void *buf)
+{
+	struct buffer_head *bh;
+	struct block_device *bdev;
+
+	if (pos%PAGE_SIZE) panic("Sorry, dave, I can't let you do that!\n");
+	bdev = bdget(kdev_t_to_nr(dev));
+	blkdev_get(bdev, FMODE_READ, O_RDONLY, BDEV_RAW);
+	if (!bdev) {
+		printk("No block device for %s\n", __bdevname(dev));
+		BUG();
+	}
+	set_blocksize(bdev, PAGE_SIZE);
+	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
+	if (!bh || (!bh->b_data)) {
+		return -1;
+	}
+	memcpy(buf, bh->b_data, PAGE_SIZE);	/* FIXME: may need kmap() */
+	BUG_ON(!buffer_uptodate(bh));
+	brelse(bh);
+	blkdev_put(bdev, BDEV_RAW);
+	return 0;
+} 
+
+extern kdev_t __init name_to_kdev_t(char *line);
+
+static int resume_try_to_read(const char * specialfile, int noresume)
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
+
+#define READTO(pos, ptr) \
+	if (bdev_read_page(resume_device, pos, ptr)) { error = -EIO; goto resume_read_error; }
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
+	if(resume_try_to_read(resume_file, 0))
+		goto read_failure;
+	do_magic(1);
+	panic("This never returns");
+
+read_failure:
+	console_loglevel = orig_loglevel;
+	return;
+}
+
+static int __init resume_setup(char *str)
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
+		printk(KERN_WARNING "noresume option lacks a resume= option\n");
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
--- clean/kernel/sys.c	Sun May 19 18:52:06 2002
+++ linux-swsusp/kernel/sys.c	Sun May 19 19:03:22 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/utsname.h>
@@ -346,6 +347,16 @@
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
--- clean/mm/page_alloc.c	Mon May 13 23:26:59 2002
+++ linux-swsusp/mm/page_alloc.c	Wed May  8 23:40:24 2002
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/compiler.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
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
--- clean/mm/page_io.c	Tue May 21 23:21:45 2002
+++ linux-swsusp/mm/page_io.c	Tue May 21 23:33:38 2002
@@ -86,11 +86,15 @@
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
--- clean/mm/pdflush.c	Tue May 21 23:21:45 2002
+++ linux-swsusp/mm/pdflush.c	Tue May 21 23:33:38 2002
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 
 /*
@@ -96,7 +97,7 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sigmask_lock);
 
-	current->flags |= PF_FLUSHER;
+	current->flags |= PF_FLUSHER | PF_KERNTHREAD;
 	my_work->fn = NULL;
 	my_work->who = current;
 
@@ -107,15 +108,21 @@
 	for ( ; ; ) {
 		struct pdflush_work *pdf;
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+		run_task_queue(&tq_bdflush);
+#endif
 		list_add(&my_work->list, &pdflush_list);
 		my_work->when_i_went_to_sleep = jiffies;
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&pdflush_lock);
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		schedule();
 
 		preempt_enable();
-		(*my_work->fn)(my_work->arg0);
+		if (my_work->fn)
+			(*my_work->fn)(my_work->arg0);
 		preempt_disable();
 
 		/*
@@ -146,6 +153,7 @@
 			pdf->when_i_went_to_sleep = jiffies;	/* Limit exit rate */
 			break;					/* exeunt */
 		}
+		my_work->fn = NULL;
 	}
 	nr_pdflush_threads--;
 //	printk("pdflush %d [%d] ends\n", nr_pdflush_threads, current->pid);
--- clean/mm/vmscan.c	Tue May 21 23:21:45 2002
+++ linux-swsusp/mm/vmscan.c	Tue May 21 23:33:38 2002
@@ -23,6 +23,7 @@
 #include <linux/file.h>
 #include <linux/writeback.h>
 #include <linux/compiler.h>
+#include <linux/suspend.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -781,18 +782,22 @@
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC;
+	tsk->flags |= PF_MEMALLOC | PF_KERNTHREAD;
 
 	/*
 	 * Kswapd main loop.
 	 */
 	for (;;) {
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		__set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&kswapd_wait, &wait);
 
 		mb();
-		if (kswapd_can_sleep())
+		if (kswapd_can_sleep()) {
 			schedule();
+		}
+		
 
 		__set_current_state(TASK_RUNNING);
 		remove_wait_queue(&kswapd_wait, &wait);

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
