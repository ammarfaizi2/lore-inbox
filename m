Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbULTWrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbULTWrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbULTWrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:47:31 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:31890 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261676AbULTWgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:36:38 -0500
Date: Mon, 20 Dec 2004 13:44:43 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041220214443.GC13972@us.ibm.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120003010.GG1594@elf.ucw.cz>
X-Operating-System: Linux 2.6.10-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 01:30:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> >   This patch using pagemap for PageSet2 bitmap, It increase suspend
> >   speed, In my PowerPC suspend only need 5 secs, cool. 
> > 
> >   Test passed in my ppc and x86 laptop.
> > 
> >   ppc swsusp patch for 2.6.9
> >    http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
> >   Have fun.
> 
> BTW here's my curent bigdiff. It already has some rather nice
> swsusp speedups. Please try it on your machine; if it works for you,
> try to send your patches relative to this one. I hope to merge these
> changes during 2.6.11.
> 
> 								Pavel
> 
> 
> --- clean/Documentation/pm.txt	2001-12-19 22:38:12.000000000 +0100
> +++ linux/Documentation/pm.txt	2004-10-26 12:44:23.000000000 +0200
> @@ -36,8 +36,8 @@
>    apmd:   http://worldvisions.ca/~apenwarr/apmd/
>    acpid:  http://acpid.sf.net/
>  
> -Driver Interface
> -----------------
> +Driver Interface -- OBSOLETE, DO NOT USE!
> +----------------*************************
>  If you are writing a new driver or maintaining an old driver, it
>  should include power management support.  Without power management
>  support, a single driver may prevent a system with power management
> @@ -91,54 +91,6 @@
>  void pm_unregister_all(pm_callback cback);
>  
>  /*
> - * Device idle/use detection
> - *
> - * In general, drivers for all devices should call "pm_access"
> - * before accessing the hardware (ie. before reading or modifying
> - * a hardware register).  Request or packet-driven drivers should
> - * additionally call "pm_dev_idle" when a device is not being used.
> - *
> - * Examples:
> - * 1) A keyboard driver would call pm_access whenever a key is pressed
> - * 2) A network driver would call pm_access before submitting
> - *    a packet for transmit or receive and pm_dev_idle when its
> - *    transfer and receive queues are empty.
> - * 3) A VGA driver would call pm_access before it accesses any
> - *    of the video controller registers
> - *
> - * Ultimately, the PM policy manager uses the access and idle
> - * information to decide when to suspend individual devices
> - * or when to suspend the entire system
> - */
> -
> -/*
> - * Description: Update device access time and wake up device, if necessary
> - *
> - * Parameters:
> - *   dev - PM device previously returned from pm_register
> - *
> - * Details: If called from an interrupt handler pm_access updates
> - *          access time but should never need to wake up the device
> - *          (if device is generating interrupts, it should be awake
> - *          already)  This is important as we can not wake up
> - *          devices from an interrupt handler.
> - */
> -void pm_access(struct pm_dev *dev);
> -
> -/*
> - * Description: Identify device as currently being idle
> - *
> - * Parameters:
> - *   dev - PM device previously returned from pm_register
> - *
> - * Details: A call to pm_dev_idle might signal to the policy manager
> - *          to put a device to sleep.  If a new device request arrives
> - *          between the call to pm_dev_idle and the pm_callback
> - *          callback, the driver should fail the pm_callback request.
> - */
> -void pm_dev_idle(struct pm_dev *dev);
> -
> -/*
>   * Power management request callback
>   *
>   * Parameters:
> @@ -262,8 +214,8 @@
>  
>  ACPI Development mailing list: acpi-devel@lists.sourceforge.net
>  
> -System Interface
> -----------------
> +System Interface -- OBSOLETE, DO NOT USE!
> +----------------*************************
>  If you are providing new power management support to Linux (ie.
>  adding support for something like APM or ACPI), you should
>  communicate with drivers through the existing generic power
> --- clean/Documentation/power/devices.txt	2004-11-03 01:23:03.000000000 +0100
> +++ linux/Documentation/power/devices.txt	2004-11-03 02:16:40.000000000 +0100
> @@ -141,3 +141,82 @@
>  The driver core will not call any extra functions when binding the
>  device to the driver. 
>  
> +pm_message_t meaning
> +
> +pm_message_t has two fields. event ("major"), and flags.  If driver
> +does not know event code, it aborts the request, returning error. Some
> +drivers may need to deal with special cases based on the actual type
> +of suspend operation being done at the system level. This is why
> +there are flags.
> +
> +Event codes are:
> +
> +ON -- no need to do anything except special cases like broken
> +HW.
> +
> +FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
> +scratch. That probably means stop accepting upstream requests, the
> +actual policy of what to do with them beeing specific to a given
> +driver. It's acceptable for a network driver to just drop packets
> +while a block driver is expected to block the queue so no request is
> +lost. (Use IDE as an example on how to do that). FREEZE requires no
> +power state change, and it's expected for drivers to be able to
> +quickly transition back to operating state.
> +
> +SUSPEND -- like FREEZE, but also put hardware into low-power state. If
> +there's need to distinguish several levels of sleep, additional flag
> +is probably best way to do that.
> +
> +All events are: 
> +
> +#Prepare for suspend -- userland is still running but we are going to
> +#enter suspend state. This gives drivers chance to load firmware from
> +#disk and store it in memory, or do other activities taht require
> +#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
> +#are forbiden once the suspend dance is started.. event = ON, flags =
> +#PREPARE_TO_SUSPEND
> +
> +Apm standby -- prepare for APM event. Quiesce devices to make life
> +easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
> +
> +Apm suspend -- same as APM_STANDBY, but it we should probably avoid
> +spinning down disks. event = FREEZE, flags = APM_SUSPEND
> +
> +System halt, reboot -- quiesce devices to make life easier for BIOS. event
> += FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
> +
> +System shutdown -- at least disks need to be spun down, or data may be
> +lost. Quiesce devices, just to make life easier for BIOS. event =
> +FREEZE, flags = SYSTEM_SHUTDOWN
> +
> +Kexec    -- turn off DMAs and put hardware into some state where new
> +kernel can take over. event = FREEZE, flags = KEXEC
> +
> +Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
> +may need to be enabled on some devices. This actually has at least 3
> +subtypes, system can reboot, enter S4 and enter S5 at the end of
> +swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
> +SYSTEM_SHUTDOWN, SYSTEM_S4
> +
> +Suspend to ram  -- put devices into low power state. event = SUSPEND,
> +flags = SUSPEND_TO_RAM
> +
> +Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
> +devices into low power mode, but you must be able to reinitialize
> +device from scratch in resume method. This has two flavors, its done
> +once on suspending kernel, once on resuming kernel. event = FREEZE,
> +flags = DURING_SUSPEND or DURING_RESUME
> +
> +Device detach requested from /sys -- deinitialize device; proably same as
> +SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
> += FREEZE, flags = DEV_DETACH.
> +
> +#These are not really events sent:
> +#
> +#System fully on -- device is working normally; this is probably never
> +#passed to suspend() method... event = ON, flags = 0
> +#
> +#Ready after resume -- userland is now running, again. Time to free any
> +#memory you ate during prepare to suspend... event = ON, flags =
> +#READY_AFTER_RESUME
> +#
> --- clean/Documentation/power/swsusp.txt	2004-10-01 00:29:56.000000000 +0200
> +++ linux/Documentation/power/swsusp.txt	2004-11-14 23:36:46.000000000 +0100
> @@ -15,10 +15,21 @@
>   * If you change kernel command line between suspend and resume...
>   *			        ...prepare for nasty fsck or worse.
>   *
> - * (*) pm interface support is needed to make it safe.
> + * If you change your hardware while system is suspended...
> + *			        ...well, it was not good idea.
> + *
> + * (*) suspend/resume support is needed to make it safe.
>  
>  You need to append resume=/dev/your_swap_partition to kernel command
> -line. Then you suspend by echo 4 > /proc/acpi/sleep.
> +line. Then you suspend by 
> +
> +echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> +
> +. If you feel ACPI works pretty well on your system, you might try
> +
> +echo platform > /sys/power/disk; echo disk > /sys/power/state
> +
> +
>  
>  Article about goals and implementation of Software Suspend for Linux
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -32,42 +43,24 @@
>  to standby mode. Later resuming the machine the saved state is loaded back to
>  ram and the machine can continue its work. It has two real benefits. First we
>  save ourselves the time machine goes down and later boots up, energy costs
> -real high when running from batteries. The other gain is that we don't have to
> +are real high when running from batteries. The other gain is that we don't have to
>  interrupt our programs so processes that are calculating something for a long
>  time shouldn't need to be written interruptible.
>  
> -Using the code
> -
> -You have two ways to use this code. The first one is is with a patched
> -SysVinit (my patch is against 2.76 and available at my home page). You
> -might call 'swsusp' or 'shutdown -z <time>'. Next way is to echo 4 >
> -/proc/acpi/sleep.
> -
> -Either way it saves the state of the machine into active swaps and then
> -reboots.  You must explicitly specify the swap partition to resume from with
> +swsusp saves the state of the machine into active swaps and then reboots or
> +powerdowns.  You must explicitly specify the swap partition to resume from with
>  ``resume='' kernel option. If signature is found it loads and restores saved
>  state. If the option ``noresume'' is specified as a boot parameter, it skips
>  the resuming.
>  
> -In the meantime while the system is suspended you should not touch any of the
> -hardware!
> -
> -About the code
> -
> -Things to implement
> -- We should only make a copy of data related to kernel segment, since any
> -  process data won't be changed.
> -- Should make more sanity checks. Or are these enough?
> -
> -Not so important ideas for implementing
> +In the meantime while the system is suspended you should not add/remove any
> +of the hardware, write to the filesystems, etc.
>  
> -- If a real time process is running then don't suspend the machine.
> -- Support for adding/removing hardware while suspended?
> -- We should not free pages at the beginning so aggressively, most of them
> -  go there anyway..
> +Sleep states summary
> +====================
>  
> -Sleep states summary (thanx, Ducrot)
> -====================================
> +There are three different interfaces you can use, /proc/acpi should
> +work like this:
>  
>  In a really perfect world:
>  echo 1 > /proc/acpi/sleep       # for standby
> @@ -79,7 +72,6 @@
>  and perhaps
>  echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
>  
> -
>  Frequently Asked Questions
>  ==========================
>  
> @@ -123,27 +115,13 @@
>  
>  Q: Does linux support ACPI S4?
>  
> -A: No.
> -
> -When swsusp was created, ACPI was not too widespread, so we tried to
> -avoid using ACPI-specific stuff. ACPI also is/was notoriously
> -buggy. These days swsusp works on APM-only i386 machines and even
> -without any power managment at all. Some versions also work on PPC.
> -
> -That means that machine does not enter S4 on suspend-to-disk, but
> -simply enters S5. That has few advantages, you can for example boot
> -windows on next boot, and return to your Linux session later. You
> -could even have few different Linuxes on your box (not sharing any
> -partitions), and switch between them.
> -
> -It also has disadvantages. On HP nx5000, if you unplug power cord
> -while machine is suspended-to-disk, Linux will fail to notice that.
> +A: Yes. That's what echo platform > /sys/power/disk does.
>  
>  Q: My machine doesn't work with ACPI. How can I use swsusp than ?
>  
>  A: Do a reboot() syscall with right parameters. Warning: glibc gets in
>  its way, so check with strace:
> -
> + 
>  reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)
>  
>  (Thanks to Peter Osterlund:)
> @@ -162,6 +140,8 @@
>      return 0;
>  }
>  
> +Also /sys/ interface should be still present.
> +
>  Q: What is 'suspend2'?
>  
>  A: suspend2 is 'Software Suspend 2', a forked implementation of
> @@ -175,17 +155,22 @@
>  website, and not to the Linux Kernel Mailing List. We are working
>  toward merging suspend2 into the mainline kernel.
>  
> -Q: Kernel thread must voluntarily freeze itself (call 'refrigerator'). But
> -I found some kernel threads don't do it, and they don't freeze, and
> +Q: A kernel thread must voluntarily freeze itself (call 'refrigerator').
> +I found some kernel threads that don't do it, and they don't freeze
>  so the system can't sleep. Is this a known behavior?
>  
> -A: All such kernel threads need to be fixed, one by one. Select place
> -where it is safe to be frozen (no kernel semaphores should be held at
> -that point and it must be safe to sleep there), and add:
> +A: All such kernel threads need to be fixed, one by one. Select the
> +place where the thread is safe to be frozen (no kernel semaphores
> +should be held at that point and it must be safe to sleep there), and
> +add:
>  
>              if (current->flags & PF_FREEZE)
>                      refrigerator(PF_FREEZE);
>  
> +If the thread is needed for writing the image to storage, you should
> +instead set the PF_NOFREEZE process flag when creating the thread.
> +
> +
>  Q: What is the difference between between "platform", "shutdown" and
>  "firmware" in /sys/power/disk?
>  
> @@ -201,3 +186,42 @@
>  
>  "platform" is actually right thing to do, but "shutdown" is most
>  reliable.
> +
> +Q: I do not understand why you have such strong objections to idea of
> +selective suspend.
> +
> +A: Do selective suspend during runtime power managment, that's okay. But
> +its useless for suspend-to-disk. (And I do not see how you could use
> +it for suspend-to-ram, I hope you do not want that).
> +
> +Lets see, so you suggest to
> +
> +* SUSPEND all but swap device and parents
> +* Snapshot
> +* Write image to disk
> +* SUSPEND swap device and parents
> +* Powerdown
> +
> +Oh no, that does not work, if swap device or its parents uses DMA,
> +you've corrupted data. You'd have to do
> +
> +* SUSPEND all but swap device and parents
> +* FREEZE swap device and parents
> +* Snapshot
> +* UNFREEZE swap device and parents
> +* Write
> +* SUSPEND swap device and parents
> +
> +Which means that you still need that FREEZE state, and you get more
> +complicated code. (And I have not yet introduce details like system
> +devices).
> +
> +Q: There don't seem to be any generally useful behavioral
> +distinctions between SUSPEND and FREEZE.
> +
> +A: Doing SUSPEND when you are asked to do FREEZE is always correct,
> +but it may be unneccessarily slow. If you want USB to stay simple,
> +slowness may not matter to you. It can always be fixed later.
> +
> +For devices like disk it does matter, you do not want to spindown for
> +FREEZE.
> --- clean/Documentation/power/video.txt	2004-08-15 19:14:52.000000000 +0200
> +++ linux/Documentation/power/video.txt	2004-10-29 11:56:46.000000000 +0200
> @@ -17,15 +17,18 @@
>  
>  * systems where video state is preserved over S3. (Athlon HP Omnibook xe3s)
>  
> -* systems that initialize video card into vga text mode and where BIOS
> -  works well enough to be able to set video mode. Use
> -  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
> -
>  * systems where it is possible to call video bios during S3
>    resume. Unfortunately, it is not correct to call video BIOS at that
>    point, but it happens to work on some machines. Use
>    acpi_sleep=s3_bios (Athlon64 desktop system)
>  
> +* systems that initialize video card into vga text mode and where BIOS
> +  works well enough to be able to set video mode. Use
> +  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
> +
> +* on some systems s3_bios kicks video into text mode, and
> +  acpi_sleep=s3_bios,s3_mode is needed (Toshiba Satellite P10-554)
> +
>  * radeon systems, where X can soft-boot your video card. You'll need
>    patched X, and plain text console (no vesafb or radeonfb), see
>    http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)
> --- clean/Documentation/sparse.txt	2004-10-16 23:48:08.000000000 +0200
> +++ linux/Documentation/sparse.txt	2004-10-24 22:44:47.000000000 +0200
> @@ -0,0 +1,72 @@
> +Copyright 2004 Linus Torvalds
> +Copyright 2004 Pavel Machek <pavel@suse.cz>
> +
> +Using sparse for typechecking
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +"__bitwise" is a type attribute, so you have to do something like this:
> +
> +        typedef int __bitwise pm_request_t;
> +
> +        enum pm_request {
> +                PM_SUSPEND = (__force pm_request_t) 1,
> +                PM_RESUME = (__force pm_request_t) 2
> +        };
> +
> +which makes PM_SUSPEND and PM_RESUME "bitwise" integers (the "__force" is
> +there because sparse will complain about casting to/from a bitwise type,
> +but in this case we really _do_ want to force the conversion). And because
> +the enum values are all the same type, now "enum pm_request" will be that
> +type too.
> +
> +And with gcc, all the __bitwise/__force stuff goes away, and it all ends
> +up looking just like integers to gcc.
> +
> +Quite frankly, you don't need the enum there. The above all really just
> +boils down to one special "int __bitwise" type.
> +
> +So the simpler way is to just do
> +
> +        typedef int __bitwise pm_request_t;
> +
> +        #define PM_SUSPEND ((__force pm_request_t) 1)
> +        #define PM_RESUME ((__force pm_request_t) 2)
> +
> +and you now have all the infrastructure needed for strict typechecking.
> +
> +One small note: the constant integer "0" is special. You can use a
> +constant zero as a bitwise integer type without sparse ever complaining.
> +This is because "bitwise" (as the name implies) was designed for making
> +sure that bitwise types don't get mixed up (little-endian vs big-endian
> +vs cpu-endian vs whatever), and there the constant "0" really _is_
> +special.
> +
> +Modify top-level Makefile to say
> +
> +CHECK           = sparse -Wbitwise
> +
> +or you don't get any checking at all.
> +
> +
> +Where to get sparse
> +~~~~~~~~~~~~~~~~~~~
> +
> +With BK, you can just get it from
> +
> +        bk://sparse.bkbits.net/sparse
> +
> +and DaveJ has tar-balls at
> +
> +	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
> +
> +
> +Once you have it, just do
> +
> +        make
> +        make install
> +
> +as your regular user, and it will install sparse in your ~/bin directory.
> +After that, doing a kernel make with "make C=1" will run sparse on all the
> +C files that get recompiled, or with "make C=2" will run sparse on the
> +files whether they need to be recompiled or not (ie the latter is fast way
> +to check the whole tree if you have already built it).
> --- clean/Makefile	2004-10-19 14:16:26.000000000 +0200
> +++ linux/Makefile	2004-10-29 11:56:48.000000000 +0200
> @@ -325,7 +325,7 @@
>  DEPMOD		= /sbin/depmod
>  KALLSYMS	= scripts/kallsyms
>  PERL		= perl
> -CHECK		= sparse
> +CHECK		= sparse -Wbitwise
>  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__
>  MODFLAGS	= -DMODULE
>  CFLAGS_MODULE   = $(MODFLAGS)
> --- clean/arch/arm/mach-sa1100/pm.c	2004-10-19 14:16:27.000000000 +0200
> +++ linux/arch/arm/mach-sa1100/pm.c	2004-10-26 00:27:12.000000000 +0200
> @@ -57,7 +57,7 @@
>  };
>  
>  
> -static int sa11x0_pm_enter(u32 state)
> +static int sa11x0_pm_enter(suspend_state_t state)
>  {
>  	unsigned long gpio, sleep_save[SLEEP_SAVE_SIZE];
>  	struct timespec delta, rtc;
> @@ -153,7 +153,7 @@
>  /*
>   * Called after processes are frozen, but before we shut down devices.
>   */
> -static int sa11x0_pm_prepare(u32 state)
> +static int sa11x0_pm_prepare(suspend_state_t state)
>  {
>  	return 0;
>  }
> @@ -161,7 +161,7 @@
>  /*
>   * Called after devices are re-setup, but before processes are thawed.
>   */
> -static int sa11x0_pm_finish(u32 state)
> +static int sa11x0_pm_finish(suspend_state_t state)
>  {
>  	return 0;
>  }
> --- clean/arch/i386/kernel/apm.c	2004-10-01 00:29:59.000000000 +0200
> +++ linux/arch/i386/kernel/apm.c	2004-11-14 23:36:46.000000000 +0100
> @@ -1201,8 +1201,8 @@
>  		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
>  	}
>  
> -	device_suspend(3);
> -	device_power_down(3);
> +	device_suspend(PMSG_SUSPEND);
> +	device_power_down(PMSG_SUSPEND);
>  
>  	/* serialize with the timer interrupt */
>  	write_seqlock_irq(&xtime_lock);
> @@ -1255,7 +1255,7 @@
>  {
>  	int	err;
>  
> -	device_power_down(3);
> +	device_power_down(PMSG_SUSPEND);
>  	/* serialize with the timer interrupt */
>  	write_seqlock_irq(&xtime_lock);
>  	/* If needed, notify drivers here */
> --- clean/arch/i386/kernel/signal.c	2004-10-01 00:29:59.000000000 +0200
> +++ linux/arch/i386/kernel/signal.c	2004-10-29 11:56:46.000000000 +0200
> @@ -587,7 +587,8 @@
>  
>  	if (current->flags & PF_FREEZE) {
>  		refrigerator(0);
> -		goto no_signal;
> +		if (!signal_pending(current))
> +			goto no_signal;
>  	}
>  
>  	if (!oldset)
> --- clean/arch/i386/mm/fault.c	2004-10-19 14:16:27.000000000 +0200
> +++ linux/arch/i386/mm/fault.c	2004-10-29 11:56:48.000000000 +0200
> @@ -21,6 +21,7 @@
>  #include <linux/vt_kern.h>		/* For unblank_screen() */
>  #include <linux/highmem.h>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> @@ -451,6 +452,7 @@
>  	asm("movl %%cr3,%0":"=r" (page));
>  	page = ((unsigned long *) __va(page))[address >> 22];
>  	printk(KERN_ALERT "*pde = %08lx\n", page);
> +	mdelay(10000);
>  	/*
>  	 * We must not directly access the pte in the highpte
>  	 * case, the page table might be allocated in highmem.
> --- clean/arch/i386/power/cpu.c	2004-10-01 00:29:59.000000000 +0200
> +++ linux/arch/i386/power/cpu.c	2004-10-29 11:56:46.000000000 +0200
> @@ -148,6 +148,6 @@
>  	__restore_processor_state(&saved_context);
>  }
>  
> -
> +/* Needed by apm.c */
>  EXPORT_SYMBOL(save_processor_state);
>  EXPORT_SYMBOL(restore_processor_state);
> --- clean/drivers/acpi/sleep/main.c	2004-10-01 00:30:09.000000000 +0200
> +++ linux/drivers/acpi/sleep/main.c	2004-11-04 00:18:36.000000000 +0100
> @@ -42,7 +42,7 @@
>   *	wakeup code to the waking vector. 
>   */
>  
> -static int acpi_pm_prepare(u32 pm_state)
> +static int acpi_pm_prepare(suspend_state_t pm_state)
>  {
>  	u32 acpi_state = acpi_suspend_states[pm_state];
>  
> @@ -74,7 +74,7 @@
>   *	It's unfortunate, but it works. Please fix if you're feeling frisky.
>   */
>  
> -static int acpi_pm_enter(u32 pm_state)
> +static int acpi_pm_enter(suspend_state_t pm_state)
>  {
>  	acpi_status status = AE_OK;
>  	unsigned long flags = 0;
> @@ -136,7 +136,7 @@
>   *	failed). 
>   */
>  
> -static int acpi_pm_finish(u32 pm_state)
> +static int acpi_pm_finish(suspend_state_t pm_state)
>  {
>  	u32 acpi_state = acpi_suspend_states[pm_state];
>  
> @@ -156,7 +156,7 @@
>  
>  int acpi_suspend(u32 acpi_state)
>  {
> -	u32 states[] = {
> +	suspend_state_t states[] = {
>  		[1]	= PM_SUSPEND_STANDBY,
>  		[3]	= PM_SUSPEND_MEM,
>  		[4]	= PM_SUSPEND_DISK,
> --- clean/drivers/base/platform.c	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/platform.c	2004-11-04 00:31:33.000000000 +0100
> @@ -238,7 +238,7 @@
>  	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
>  }
>  
> -static int platform_suspend(struct device * dev, u32 state)
> +static int platform_suspend(struct device * dev, pm_message_t state)
>  {
>  	int ret = 0;
>  
> --- clean/drivers/base/power/power.h	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/power/power.h	2004-11-14 23:36:46.000000000 +0100
> @@ -66,14 +66,14 @@
>  /*
>   * suspend.c
>   */
> -extern int suspend_device(struct device *, u32);
> +extern int suspend_device(struct device *, pm_message_t);
>  
>  
>  /*
>   * runtime.c
>   */
>  
> -extern int dpm_runtime_suspend(struct device *, u32);
> +extern int dpm_runtime_suspend(struct device *, pm_message_t);
>  extern void dpm_runtime_resume(struct device *);
>  
>  #else /* CONFIG_PM */
> @@ -88,7 +88,7 @@
>  
>  }
>  
> -static inline int dpm_runtime_suspend(struct device * dev, u32 state)
> +static inline int dpm_runtime_suspend(struct device * dev, pm_message_t state)
>  {
>  	return 0;
>  }
> --- clean/drivers/base/power/resume.c	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/power/resume.c	2004-11-14 23:36:46.000000000 +0100
> @@ -36,7 +36,7 @@
>  		struct device * dev = to_device(entry);
>  		list_del_init(entry);
>  
> -		if (!dev->power.prev_state)
> +		if (dev->power.prev_state == PMSG_ON)
>  			resume_device(dev);
>  
>  		list_add_tail(entry, &dpm_active);
> --- clean/drivers/base/power/runtime.c	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/power/runtime.c	2004-11-14 23:36:46.000000000 +0100
> @@ -13,10 +13,10 @@
>  static void runtime_resume(struct device * dev)
>  {
>  	dev_dbg(dev, "resuming\n");
> -	if (!dev->power.power_state)
> +	if (dev->power.power_state == PMSG_ON)
>  		return;
>  	if (!resume_device(dev))
> -		dev->power.power_state = 0;
> +		dev->power.power_state = PMSG_ON;
>  }
>  
>  
> @@ -44,7 +44,7 @@
>   *	@state:	State to enter.
>   */
>  
> -int dpm_runtime_suspend(struct device * dev, u32 state)
> +int dpm_runtime_suspend(struct device * dev, pm_message_t state)
>  {
>  	int error = 0;
>  
> @@ -52,7 +52,7 @@
>  	if (dev->power.power_state == state)
>  		goto Done;
>  
> -	if (dev->power.power_state)
> +	if (dev->power.power_state != PMSG_ON)
>  		runtime_resume(dev);
>  
>  	if (!(error = suspend_device(dev, state)))
> @@ -73,7 +73,7 @@
>   *	always be able to tell, but we need accurate information to
>   *	work reliably.
>   */
> -void dpm_set_power_state(struct device * dev, u32 state)
> +void dpm_set_power_state(struct device * dev, pm_message_t state)
>  {
>  	down(&dpm_sem);
>  	dev->power.power_state = state;
> --- clean/drivers/base/power/shutdown.c	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/power/shutdown.c	2004-11-14 23:36:46.000000000 +0100
> @@ -29,7 +29,8 @@
>  			dev->driver->shutdown(dev);
>  		return 0;
>  	}
> -	return dpm_runtime_suspend(dev, dev->detach_state);
> +	/* FIXME */
> +	return dpm_runtime_suspend(dev, PMSG_FREEZE);
>  }
>  
>  
> --- clean/drivers/base/power/suspend.c	2004-08-15 19:14:55.000000000 +0200
> +++ linux/drivers/base/power/suspend.c	2004-11-14 23:36:46.000000000 +0100
> @@ -11,7 +11,7 @@
>  #include <linux/device.h>
>  #include "power.h"
>  
> -extern int sysdev_suspend(u32 state);
> +extern int sysdev_suspend(pm_message_t state);
>  
>  /*
>   * The entries in the dpm_active list are in a depth first order, simply
> @@ -35,7 +35,7 @@
>   *	@state:	Power state device is entering.
>   */
>  
> -int suspend_device(struct device * dev, u32 state)
> +int suspend_device(struct device * dev, pm_message_t state)
>  {
>  	int error = 0;
>  
> @@ -43,7 +43,7 @@
>  
>  	dev->power.prev_state = dev->power.power_state;
>  
> -	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
> +	if (dev->bus && dev->bus->suspend && (dev->power.power_state == PMSG_ON))
>  		error = dev->bus->suspend(dev, state);
>  
>  	return error;
> @@ -70,7 +70,7 @@
>   *
>   */
>  
> -int device_suspend(u32 state)
> +int device_suspend(pm_message_t state)
>  {
>  	int error = 0;
>  
> @@ -112,7 +112,7 @@
>   *	done, power down system devices.
>   */
>  
> -int device_power_down(u32 state)
> +int device_power_down(pm_message_t state)
>  {
>  	int error = 0;
>  	struct device * dev;
> --- clean/drivers/char/vt.c	2004-10-01 00:30:12.000000000 +0200
> +++ linux/drivers/char/vt.c	2004-10-26 00:14:17.000000000 +0200
> @@ -2186,8 +2186,6 @@
>  	if (!printable || test_and_set_bit(0, &printing))
>  		return;
>  
> -	pm_access(pm_con);
> -
>  	if (kmsg_redirect && vc_cons_allocated(kmsg_redirect - 1))
>  		currcons = kmsg_redirect - 1;
>  
> @@ -2387,7 +2385,6 @@
>  {
>  	int	retval;
>  
> -	pm_access(pm_con);
>  	retval = do_con_write(tty, from_user, buf, count);
>  	con_flush_chars(tty);
>  
> @@ -2398,7 +2395,6 @@
>  {
>  	if (in_interrupt())
>  		return;	/* n_r3964 calls put_char() from interrupt context */
> -	pm_access(pm_con);
>  	do_con_write(tty, 0, &ch, 1);
>  }
>  
> @@ -2467,8 +2463,6 @@
>  	if (in_interrupt())	/* from flush_to_ldisc */
>  		return;
>  
> -	pm_access(pm_con);
> -	
>  	/* if we race with con_close(), vt may be null */
>  	acquire_console_sem();
>  	vt = tty->driver_data;
> --- clean/drivers/ide/ide-disk.c	2004-10-01 00:30:12.000000000 +0200
> +++ linux/drivers/ide/ide-disk.c	2004-10-29 11:56:48.000000000 +0200
> @@ -1419,9 +1419,12 @@
>  {
>  	switch (rq->pm->pm_step) {
>  	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
> -		if (rq->pm->pm_state == 4)
> +#if 0
> +		/* FIXME!! */
> +		if (system_state == SYSTEM_SNAPSHOT)
>  			rq->pm->pm_step = ide_pm_state_completed;
>  		else
> +#endif
>  			rq->pm->pm_step = idedisk_pm_standby;
>  		break;
>  	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
> @@ -1702,7 +1705,6 @@
>  		return;
>  	}
>  
> -	printk("Shutdown: %s\n", drive->name);
>  	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
>  }
>  
> --- clean/drivers/ide/ide.c	2004-10-01 00:30:12.000000000 +0200
> +++ linux/drivers/ide/ide.c	2004-11-04 00:32:27.000000000 +0100
> @@ -1499,7 +1499,7 @@
>  	return 1;
>  }
>  
> -static int generic_ide_suspend(struct device *dev, u32 state)
> +static int generic_ide_suspend(struct device *dev, pm_message_t state)
>  {
>  	ide_drive_t *drive = dev->driver_data;
>  	struct request rq;
> --- clean/drivers/ieee1394/ieee1394_core.c	2004-06-22 12:36:07.000000000 +0200
> +++ linux/drivers/ieee1394/ieee1394_core.c	2004-10-29 11:56:46.000000000 +0200
> @@ -1039,6 +1039,11 @@
>  			continue;
>  		}
>  
> +		if (current->flags & PF_FREEZE) {
> +			refrigerator(0);
> +			continue;
> +		}
> +
>  		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
>  			packet = (struct hpsb_packet *)skb->data;
>  
> --- clean/drivers/input/input.c	2004-08-15 19:14:56.000000000 +0200
> +++ linux/drivers/input/input.c	2004-10-25 23:54:57.000000000 +0200
> @@ -67,9 +67,6 @@
>  {
>  	struct input_handle *handle;
>  
> -	if (dev->pm_dev)
> -		pm_access(dev->pm_dev);
> -
>  	if (type > EV_MAX || !test_bit(type, dev->evbit))
>  		return;
>  
> @@ -230,8 +227,6 @@
>  
>  int input_open_device(struct input_handle *handle)
>  {
> -	if (handle->dev->pm_dev)
> -		pm_access(handle->dev->pm_dev);
>  	handle->open++;
>  	if (handle->dev->open)
>  		return handle->dev->open(handle->dev);
> @@ -249,8 +244,6 @@
>  void input_close_device(struct input_handle *handle)
>  {
>  	input_release_device(handle);
> -	if (handle->dev->pm_dev)
> -		pm_dev_idle(handle->dev->pm_dev);
>  	if (handle->dev->close)
>  		handle->dev->close(handle->dev);
>  	handle->open--;
> --- clean/drivers/pci/pci-driver.c	2004-10-01 00:30:16.000000000 +0200
> +++ linux/drivers/pci/pci-driver.c	2004-11-04 00:26:44.000000000 +0100
> @@ -295,7 +295,7 @@
>  	return 0;
>  }
>  
> -static int pci_device_suspend(struct device * dev, u32 state)
> +static int pci_device_suspend(struct device * dev, pm_message_t state)
>  {
>  	struct pci_dev * pci_dev = to_pci_dev(dev);
>  	struct pci_driver * drv = pci_dev->driver;
> --- clean/drivers/pci/pci.c	2004-10-01 00:30:16.000000000 +0200
> +++ linux/drivers/pci/pci.c	2004-11-14 23:36:46.000000000 +0100
> @@ -229,7 +229,7 @@
>  /**
>   * pci_set_power_state - Set the power state of a PCI device
>   * @dev: PCI device to be suspended
> - * @state: Power state we're entering
> + * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
>   *
>   * Transition a device to a new power state, using the Power Management 
>   * Capabilities in the device's config space.
> @@ -242,7 +242,7 @@
>   */
>  
>  int
> -pci_set_power_state(struct pci_dev *dev, int state)
> +pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {
>  	int pm;
>  	u16 pmcsr;
> @@ -300,6 +300,30 @@
>  }
>  
>  /**
> + * pci_choose_state - Choose the power state of a PCI device
> + * @dev: PCI device to be suspended
> + * @state: target sleep state for the whole system
> + *
> + * Returns PCI power state suitable for given device and given system
> + * message.
> + */
> +
> +pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
> +{
> +	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> +		return PCI_D0;
> +
> +	switch (state) {
> +	case 0:	return PCI_D0;
> +	case 2: return PCI_D2;
> +	case 3: return PCI_D3hot;
> +	default: BUG();
> +	}
> +}
> +
> +EXPORT_SYMBOL(pci_choose_state);
> +
> +/**
>   * pci_save_state - save the PCI configuration space of a device before suspending
>   * @dev: - PCI device that we're dealing with
>   * @buffer: - buffer to hold config space context
> @@ -365,7 +389,7 @@
>  {
>  	int err;
>  
> -	pci_set_power_state(dev, 0);
> +	pci_set_power_state(dev, PCI_D0);
>  	if ((err = pcibios_enable_device(dev, bars)) < 0)
>  		return err;
>  	return 0;
> @@ -422,7 +446,7 @@
>   * 0 if operation is successful.
>   * 
>   */
> -int pci_enable_wake(struct pci_dev *dev, u32 state, int enable)
> +int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
>  {
>  	int pm;
>  	u16 value;
> --- clean/drivers/usb/core/hcd-pci.c	2004-10-01 00:30:19.000000000 +0200
> +++ linux/drivers/usb/core/hcd-pci.c	2004-11-14 23:36:46.000000000 +0100
> @@ -355,8 +355,8 @@
>  	hcd->state = USB_STATE_RESUMING;
>  
>  	if (has_pci_pm)
> -		pci_set_power_state (dev, 0);
> -	dev->dev.power.power_state = 0;
> +		pci_set_power_state (dev, PCI_D0);
> +	dev->dev.power.power_state = PMSG_ON;
>  	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
>  				hcd->description, hcd);
>  	if (retval < 0) {
> --- clean/drivers/usb/host/ohci-hub.c	2004-10-19 14:16:28.000000000 +0200
> +++ linux/drivers/usb/host/ohci-hub.c	2004-11-14 23:36:46.000000000 +0100
> @@ -76,7 +76,7 @@
>  	struct usb_device	*root = hcd_to_bus (&ohci->hcd)->root_hub;
>  	int			status = 0;
>  
> -	if (root->dev.power.power_state != 0)
> +	if (root->dev.power.power_state != PMSG_ON)
>  		return 0;
>  	if (time_before (jiffies, ohci->next_statechange))
>  		return -EAGAIN;
> --- clean/include/asm-i386/suspend.h	2004-08-15 19:15:04.000000000 +0200
> +++ linux/include/asm-i386/suspend.h	2004-10-29 11:56:46.000000000 +0200
> @@ -9,6 +9,9 @@
>  static inline int
>  arch_prepare_suspend(void)
>  {
> +	/* If you want to make non-PSE machine work, turn off paging
> +           in do_magic. swsusp_pg_dir should have identity mapping, so
> +           it could work...  */
>  	if (!cpu_has_pse)
>  		return -EPERM;
>  	return 0;
> --- clean/include/linux/device.h	2004-10-01 00:30:29.000000000 +0200
> +++ linux/include/linux/device.h	2004-11-04 00:25:52.000000000 +0100
> @@ -61,7 +61,7 @@
>  	int		(*match)(struct device * dev, struct device_driver * drv);
>  	int		(*hotplug) (struct device *dev, char **envp, 
>  				    int num_envp, char *buffer, int buffer_size);
> -	int		(*suspend)(struct device * dev, u32 state);
> +	int		(*suspend)(struct device * dev, pm_message_t state);
>  	int		(*resume)(struct device * dev);
>  };
>  
> --- clean/include/linux/page-flags.h	2004-10-01 00:30:30.000000000 +0200
> +++ linux/include/linux/page-flags.h	2004-10-19 16:38:18.000000000 +0200
> @@ -74,7 +74,7 @@
>  #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
>  #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
>  #define PG_reclaim		18	/* To be reclaimed asap */
> -
> +#define PG_nosave_free		19	/* Page is free and should not be written */
>  
>  /*
>   * Global page accounting.  One instance per CPU.  Only unsigned longs are
> @@ -277,6 +277,10 @@
>  #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
>  #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
>  
> +#define PageNosaveFree(page)	test_bit(PG_nosave_free, &(page)->flags)
> +#define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
> +#define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
> +
>  #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
>  #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
>  #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
> --- clean/include/linux/pci.h	2004-10-01 00:30:30.000000000 +0200
> +++ linux/include/linux/pci.h	2004-11-14 23:36:46.000000000 +0100
> @@ -480,6 +480,14 @@
>  #define DEVICE_COUNT_COMPATIBLE	4
>  #define DEVICE_COUNT_RESOURCE	12
>  
> +typedef int __bitwise pci_power_t;
> +
> +#define PCI_D0	((pci_power_t __force) 0)
> +#define PCI_D1	((pci_power_t __force) 1)
> +#define PCI_D2	((pci_power_t __force) 2)
> +#define PCI_D3hot	((pci_power_t __force) 3)
> +#define PCI_D3cold	((pci_power_t __force) 4)
> +
>  /*
>   * The pci_dev structure is used to describe PCI devices.
>   */
> @@ -508,7 +516,7 @@
>  					   this if your device has broken DMA
>  					   or supports 64-bit transfers.  */
>  
> -	u32             current_state;  /* Current operating state. In ACPI-speak,
> +	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
>  					   this is D0-D3, D0 being fully functional,
>  					   and D3 being off. */
>  
> @@ -645,7 +653,7 @@
>  	struct pci_dynids dynids;
>  };
>  
> -#define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
> +#define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
>  
>  /**
>   * PCI_DEVICE - macro used to describe a specific pci device
> @@ -781,8 +789,8 @@
>  /* Power management related routines */
>  int pci_save_state(struct pci_dev *dev, u32 *buffer);
>  int pci_restore_state(struct pci_dev *dev, u32 *buffer);
> -int pci_set_power_state(struct pci_dev *dev, int state);
> -int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
> +int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
> +int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
>  
>  /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
>  void pci_bus_assign_resources(struct pci_bus *bus);
> --- clean/include/linux/pm.h	2004-10-01 00:30:30.000000000 +0200
> +++ linux/include/linux/pm.h	2004-11-14 23:36:46.000000000 +0100
> @@ -28,44 +28,28 @@
>  #include <asm/atomic.h>
>  
>  /*
> - * Power management requests
> + * Power management requests... these are passed to pm_send_all() and friends.
> + *
> + * these functions are old and deprecated, see below.
>   */
> -enum
> -{
> -	PM_SUSPEND, /* enter D1-D3 */
> -	PM_RESUME,  /* enter D0 */
> -
> -	PM_SAVE_STATE,  /* save device's state */
> +typedef int __bitwise pm_request_t;
>  
> -	/* enable wake-on */
> -	PM_SET_WAKEUP,
> -
> -	/* bus resource management */
> -	PM_GET_RESOURCES,
> -	PM_SET_RESOURCES,
> -
> -	/* base station management */
> -	PM_EJECT,
> -	PM_LOCK,
> -};
> +#define PM_SUSPEND	((__force pm_request_t) 1)	/* enter D1-D3 */
> +#define PM_RESUME	((__force pm_request_t) 2)	/* enter D0 */
>  
> -typedef int pm_request_t;
>  
>  /*
> - * Device types
> + * Device types... these are passed to pm_register
>   */
> -enum
> -{
> -	PM_UNKNOWN_DEV = 0, /* generic */
> -	PM_SYS_DEV,	    /* system device (fan, KB controller, ...) */
> -	PM_PCI_DEV,	    /* PCI device */
> -	PM_USB_DEV,	    /* USB device */
> -	PM_SCSI_DEV,	    /* SCSI device */
> -	PM_ISA_DEV,	    /* ISA device */
> -	PM_MTD_DEV,	    /* Memory Technology Device */
> -};
> +typedef int __bitwise pm_dev_t;
>  
> -typedef int pm_dev_t;
> +#define PM_UNKNOWN_DEV	((__force pm_request_t) 0)	/* generic */
> +#define PM_SYS_DEV	((__force pm_request_t) 1)	/* system device (fan, KB controller, ...) */
> +#define PM_PCI_DEV	((__force pm_request_t) 2)	/* PCI device */
> +#define PM_USB_DEV	((__force pm_request_t) 3)	/* USB device */
> +#define PM_SCSI_DEV	((__force pm_request_t) 4)	/* SCSI device */
> +#define PM_ISA_DEV	((__force pm_request_t) 5)	/* ISA device */
> +#define	PM_MTD_DEV	((__force pm_request_t) 6)	/* Memory Technology Device */
>  
>  /*
>   * System device hardware ID (PnP) values
> @@ -119,37 +103,27 @@
>  /*
>   * Register a device with power management
>   */
> -struct pm_dev *pm_register(pm_dev_t type,
> -			   unsigned long id,
> -			   pm_callback callback);
> +struct pm_dev __deprecated *pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
>  
>  /*
>   * Unregister a device with power management
>   */
> -void pm_unregister(struct pm_dev *dev);
> +void __deprecated pm_unregister(struct pm_dev *dev);
>  
>  /*
>   * Unregister all devices with matching callback
>   */
> -void pm_unregister_all(pm_callback callback);
> +void __deprecated pm_unregister_all(pm_callback callback);
>  
>  /*
>   * Send a request to a single device
>   */
> -int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
> +int __deprecated pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
>  
>  /*
>   * Send a request to all devices
>   */
> -int pm_send_all(pm_request_t rqst, void *data);
> -
> -/*
> - * Find a device
> - */
> -struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from);
> -
> -static inline void pm_access(struct pm_dev *dev) {}
> -static inline void pm_dev_idle(struct pm_dev *dev) {}
> +int __deprecated pm_send_all(pm_request_t rqst, void *data);
>  
>  #else /* CONFIG_PM */
>  
> @@ -176,16 +150,10 @@
>  	return 0;
>  }
>  
> -static inline struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from)
> -{
> -	return 0;
> -}
> -
> -static inline void pm_access(struct pm_dev *dev) {}
> -static inline void pm_dev_idle(struct pm_dev *dev) {}
> -
>  #endif /* CONFIG_PM */
>  
> +/* Functions above this comment are list-based old-style power
> + * managment. Please avoid using them.  */
>  
>  /*
>   * Callbacks for platform drivers to implement.
> @@ -193,34 +161,32 @@
>  extern void (*pm_idle)(void);
>  extern void (*pm_power_off)(void);
>  
> -enum {
> -	PM_SUSPEND_ON = 0,
> -	PM_SUSPEND_STANDBY = 1,
> -	/* NOTE: PM_SUSPEND_MEM == PCI_D3hot */
> -	PM_SUSPEND_MEM = 3,
> -	PM_SUSPEND_DISK = 4,
> -	PM_SUSPEND_MAX = 5,
> -};
> -
> -enum {
> -	PM_DISK_FIRMWARE = 1,
> -	PM_DISK_PLATFORM,
> -	PM_DISK_SHUTDOWN,
> -	PM_DISK_REBOOT,
> -	PM_DISK_MAX,
> -};
> +typedef int __bitwise suspend_state_t;
>  
> +#define PM_SUSPEND_ON		((__force suspend_state_t) 0)
> +#define PM_SUSPEND_STANDBY	((__force suspend_state_t) 1)
> +#define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
> +#define PM_SUSPEND_DISK		((__force suspend_state_t) 4)
> +#define PM_SUSPEND_MAX		((__force suspend_state_t) 5)
> +
> +typedef int __bitwise suspend_disk_method_t;
> +
> +#define	PM_DISK_FIRMWARE	((__force suspend_disk_method_t) 1)
> +#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
> +#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
> +#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
> +#define	PM_DISK_MAX		((__force suspend_disk_method_t) 5)
>  
>  struct pm_ops {
> -	u32	pm_disk_mode;
> -	int (*prepare)(u32 state);
> -	int (*enter)(u32 state);
> -	int (*finish)(u32 state);
> +	suspend_disk_method_t pm_disk_mode;
> +	int (*prepare)(suspend_state_t state);
> +	int (*enter)(suspend_state_t state);
> +	int (*finish)(suspend_state_t state);
>  };
>  
>  extern void pm_set_ops(struct pm_ops *);
>  
> -extern int pm_suspend(u32 state);
> +extern int pm_suspend(suspend_state_t state);
>  
>  
>  /*
> @@ -229,10 +195,34 @@
>  
>  struct device;
>  
> +typedef u32 __bitwise pm_message_t;
> +
> +/*
> + * There are 4 important states driver can be in:
> + * ON     -- driver is working
> + * FREEZE -- stop operations and apply whatever policy is applicable to a suspended driver
> + *           of that class, freeze queues for block like IDE does, drop packets for
> + *           ethernet, etc... stop DMA engine too etc... so a consistent image can be
> + *           saved; but do not power any hardware down.
> + * SUSPEND - like FREEZE, but hardware is doing as much powersaving as possible. Roughly
> + *           pci D3.
> + *
> + * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3 (SUSPEND).
> + * We'll need to fix the drivers. So yes, putting 3 to all diferent defines is intentional,
> + * and will go away as soon as drivers are fixed. Also note that typedef is neccessary,
> + * we'll probably want to switch to
> + *   typedef struct pm_message_t { int event; int flags; } pm_message_t
> + * or something similar soon.
> + */
> +
> +#define PMSG_FREEZE	((__force pm_message_t) 3)
> +#define PMSG_SUSPEND	((__force pm_message_t) 3)
> +#define PMSG_ON		((__force pm_message_t) 0)
> +
>  struct dev_pm_info {
> -	u32			power_state;
> +	pm_message_t			power_state;
>  #ifdef	CONFIG_PM
> -	u32			prev_state;
> +	pm_message_t			prev_state;
>  	u8			* saved_state;
>  	atomic_t		pm_users;
>  	struct device		* pm_parent;
> @@ -242,8 +232,8 @@
>  
>  extern void device_pm_set_parent(struct device * dev, struct device * parent);
>  
> -extern int device_suspend(u32 state);
> -extern int device_power_down(u32 state);
> +extern int device_suspend(pm_message_t state);
> +extern int device_power_down(pm_message_t state);
>  extern void device_power_up(void);
>  extern void device_resume(void);
>  
> --- clean/include/linux/suspend.h	2004-10-01 00:30:31.000000000 +0200
> +++ linux/include/linux/suspend.h	2004-10-29 11:56:46.000000000 +0200
> @@ -31,6 +31,7 @@
>  
>  /* mm/page_alloc.c */
>  extern void drain_local_pages(void);
> +extern void mark_free_pages(struct zone *zone);
>  
>  /* kernel/power/swsusp.c */
>  extern int software_suspend(void);
> @@ -54,6 +55,8 @@
>  
>  #else
>  static inline void refrigerator(unsigned long flag) {}
> +static inline int freeze_processes(void) { BUG(); }
> +static inline void thaw_processes(void) {}
>  #endif	/* CONFIG_PM */
>  
>  #ifdef CONFIG_SMP
> --- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
> +++ linux/kernel/power/disk.c	2004-11-16 13:14:09.000000000 +0100
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2003 Patrick Mochel
>   * Copyright (c) 2003 Open Source Development Lab
> + * Copyright (c) 2004 Pavel Machek <pavel@suse.cz>
>   *
>   * This file is released under the GPLv2.
>   *
> @@ -15,10 +16,11 @@
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
> +#include <linux/device.h>
>  #include "power.h"
>  
>  
> -extern u32 pm_disk_mode;
> +extern suspend_disk_method_t pm_disk_mode;
>  extern struct pm_ops * pm_ops;
>  
>  extern int swsusp_suspend(void);
> @@ -41,7 +43,7 @@
>   *	there ain't no turning back.
>   */
>  
> -static int power_down(u32 mode)
> +static void power_down(suspend_disk_method_t mode)
>  {
>  	unsigned long flags;
>  	int error = 0;
> @@ -49,7 +51,7 @@
>  	local_irq_save(flags);
>  	switch(mode) {
>  	case PM_DISK_PLATFORM:
> -		device_power_down(PM_SUSPEND_DISK);
> + 		device_power_down(PMSG_SUSPEND);
>  		error = pm_ops->enter(PM_SUSPEND_DISK);
>  		break;
>  	case PM_DISK_SHUTDOWN:
> @@ -67,7 +69,6 @@
>  	   after resume. */
>  	printk(KERN_CRIT "Please power me down manually\n");
>  	while(1);
> -	return 0;
>  }
>  
>  
> @@ -85,13 +86,26 @@
>  
>  static void free_some_memory(void)
>  {
> -	printk("Freeing memory: ");
> -	while (shrink_all_memory(10000))
> -		printk(".");
> -	printk("|\n");
> +	int i;
> +	for (i=0; i<5; i++) {
> +		int i = 0, tmp;
> +		long pages = 0;
> +		char *p = "-\\|/";
> +
> +		printk("Freeing memory...  ");
> +		while ((tmp = shrink_all_memory(10000))) {
> +			pages += tmp;
> +			printk("\b%c", p[i]);
> +			i++;
> +			if (i > 3)
> +				i = 0;
> +		}
> +		printk("\bdone (%li pages freed)\n", pages);
> +		current->state = TASK_INTERRUPTIBLE;
> +		schedule_timeout(HZ/5);

This should be msleep_interruptible() [I do not see any wait-queue events around
this code].

-Nish
