Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTIJAcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTIJAcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:32:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:33517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265110AbTIJAcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:32:09 -0400
Date: Tue, 9 Sep 2003 17:38:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: linux-kernel@vger.kernel.org
Subject: Power Management Update
Message-ID: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the next round of power management updates. BK users can get the 
changesets listed below from 

	bk://kernel.bkbits.net:/home/mochel/linux-2.5-power

A patch against 2.6.0-test5 can be found at 

	http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm1.diff.bz2

The patches for each individual changeset can be found in that directory. 

The changesets there, and listed below, are cumulative, meaning they 
include all of the patches I posted last week. The highlights from this 
release are the following: 

- Fixed suspend-to-disk support with preempt and SMP enabled. 

Suspend-to-disk will work on a UP system with SMP enabled, though it will 
definitely not on an SMP system. This is on the TODO list, albeit at low 
priority. 

- Several small bug fixes. 

- swsusp has been forked into two workable trees. 

The code base of swsusp itself has been reverted to its state around
2.6.0-test3. A suspend-to-disk implementation called 'pmdisk' has been
created in kernel/power/pmdisk.c that offers (for now) identical 
functionality, and an almost identical code base. That will change in the 
near future, as I submit more cleanups to it. 

The pmdisk implementation is accessible via the sysfs interface:

	echo -n disk > /sys/power/state

While swsusp is accessible via the /proc/acpi/sleep interface. It is 
possible to tie swsusp into the sysfs interface, and will entertain 
patches to do such a thing. 

Note the new config menu options for pmdisk when building the kernel. 


There is still a lot to do, including fixing the random crashes that some
people are experiencing. I appreciate the testing people have done, and
will appreciate any feedback concerning the patches or the functionality
the patches implement.

Enjoy.

Thanks,


	Pat



This will update the following files:

 arch/i386/kernel/suspend.c     |  141 ----
 arch/i386/kernel/suspend_asm.S |   94 ---
 arch/i386/Kconfig              |   44 -
 arch/i386/Makefile             |    1 
 arch/i386/kernel/Makefile      |    2 
 arch/i386/power/Makefile       |    3 
 arch/i386/power/cpu.c          |  141 ++++
 arch/i386/power/pmdisk.S       |   94 +++
 arch/i386/power/swsusp.S       |  126 +++-
 drivers/acpi/sleep/main.c      |   53 +
 drivers/acpi/sleep/proc.c      |   73 ++
 drivers/acpi/sleep/sleep.h     |    3 
 drivers/base/core.c            |   33 -
 drivers/base/power/main.c      |   13 
 drivers/base/power/power.h     |    3 
 drivers/base/power/resume.c    |   21 
 drivers/base/power/suspend.c   |   10 
 include/asm-i386/suspend.h     |    7 
 include/linux/suspend.h        |   15 
 kernel/power/Kconfig           |   92 +++
 kernel/power/Makefile          |    5 
 kernel/power/console.c         |    2 
 kernel/power/disk.c            |  427 +++++++++++++--
 kernel/power/main.c            |  459 +++-------------
 kernel/power/pmdisk.c          | 1162 +++++++++++++++++++++++++++++++++++++----
 kernel/power/power.h           |   41 -
 kernel/power/swsusp.c          | 1095 ++++++++++++++++++++++----------------
 kernel/sched.c                 |    4 
 kernel/sys.c                   |    9 
 29 files changed, 2804 insertions(+), 1369 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (03/09/09 1.1217.3.32)
   [swsusp] Fix software_suspend() inline return value when SOFTWARE_SUSPEND=n.

<mochel@osdl.org> (03/09/09 1.1217.3.31)
   [power] Revert swsusp to 2.6.0-test3 state.
   
   - From Pavel (mostly, though with some fixups).
   - Note that I would never publically admit to putting such code into the 
     kernel. 
   - Someone ought to really review this patch some day. 

<mochel@osdl.org> (03/09/09 1.1217.3.30)
   [power] Make pmdisk compile when CONFIG_SOFTWARE_SUSPEND=n.

<mochel@osdl.org> (03/09/09 1.1217.3.29)
   [power] Make pmdisk compilable and usable.
   
   - Fork arch/i386/power/swsusp.S into arch/i386/power/pmdisk.S
   - Change name of all externally visible swsusp_* functions to pmdisk_*
   - Make pm_suspend_disk() call pmdisk_ functions.
   - Make sure pmdisk.o is compiled if the config option is set.
   - Add CONFIG_PM_DISK_PARTITION option, which allows user to compile in 
     default resume partition.
   - Add pmdisk= setup option, which allows user to override or disable default
     resume partition.
   - Change name of global names in pmdisk that conflict with those in swsusp.

<mochel@osdl.org> (03/09/09 1.1217.3.27)
   [power] Move PM options into kernel/power/Kconfig.
   
   - Add option for CONFIG_PM_DISK (suspend-to-disk functionality).
   
   - Other arch's should include this, instead of defining their own options. 
     Will fixup any problems with that..

<mochel@osdl.org> (03/09/09 1.1217.3.26)
   [power] Fork swsusp. 
   
   The cloned implementation is in kernel/power/pmdisk.c.

<mochel@osdl.org> (03/09/08 1.1217.3.24)
   [power] Fix swsusp with preempt and clean up.
   
   In order to snapshot memory, interrupts must be disabled. However, in order
   to write the saved image to disk, interrupts must be re-enabled and devices
   resumed. Previously, both actions were called from swsusp_arch_suspend().
   
   This patch separates those two actions has only the snapshotting routine 
   called from swsusp_arch_suspend(). swsusp now handles it's own disabling of
   interrupts only for the time required. This is now handled from swsusp_save()
   and swsusp_write() now handles writing the image only (called with interrupts
   enabled).
   
   swsusp_save_image() was renamed to swsusp_suspend() (and the old incarnation
   deleted since it was simply a wrapper).

<mochel@osdl.org> (03/09/08 1.1217.3.23)
   [swsusp] Make sure we call restore_processor_state() when suspending.
   
   - Added unconditionally to exit path of swsusp_arch_suspend(). This is done
     to call kernel_fpu_end() to reset the preempt count on suspend.
   
   - Note that we must preserve %eax across that call.

<mochel@osdl.org> (03/09/08 1.1217.3.22)
   [power] Add support for refrigerator to the migration_thread.
   
   - The PM code currently must signal each kernel thread when suspending, and
     each thread must call refrigerator() to stop itself. This patch adds 
     support for this to migration_thread, which allows suspend states to work
     on an SMP-enabled kernel (though not necessarily an SMP machine).
   
   - Note I do not know why the process freezing code was designed in such a 
     way. One would think we could do it without having to call each thread
     individually, and fix up the threads that need special work individually..

<mochel@osdl.org> (03/09/08 1.1217.3.21)
   [power] Make sure we restore interrupts if device_power_down() fails.

<mochel@osdl.org> (03/09/08 1.1217.3.20)
   [power] Simplify error handling in pm_suspend_prepare().

<mochel@osdl.org> (03/09/04 1.1153.114.3)
   [power] Whitespace fixes.
   
   From the -test4-mm5 tree.

<mochel@osdl.org> (03/08/30 1.1153.76.10)
   [acpi] Replace /proc/acpi/sleep
   
   - Bad to remove proc file now, even though it's nearly useless. Reinstated
     in the name of compatibility. 
   
   - Restored original semantics - if software_suspend() is enabled, then just
     call that (and never go into low-power state). Otherwise, call acpi_suspend().
   
   - acpi_suspend() is simply a wrapper for pm_suspend(), passing down the right
     argument. This is so we don't have to do everything manually anymore.
   
   - Fixed long-standing bug by checking for "4b" in string written in to 
     determine if we want to enter S4bios.

<mochel@osdl.org> (03/08/30 1.1153.76.9)
   [swsusp] Restore software_suspend() call.
   
   - Allows 'backdoor' interface to swsusp, as requested by Pavel. 
   
   - Simply a wrapper to pm_suspend(), though guaranteeing that swsusp is used,
     and system is shutdown (and put into low-power state).
   
   - Call in sys_reboot() changed back to call to software_suspend().

<mochel@osdl.org> (03/08/30 1.1153.76.8)
   [swsusp] Use BIO interface when reading from swap. 
   
   - bios are the preferred method for doing this type of stuff in 2.6. The 
     __bread() uses bio's in the end anyway. 
   
   - bios make it really easy to implement write functionality, so we are able
     to reset the swap signature immediately after checking it during resume.
     So, if something happens while resuming, we will still have valid swap to 
     use. 
   
   - Thanks to Jens for some help in getting it working several months ago.

<mochel@osdl.org> (03/08/29 1.1153.76.7)
   [swsusp] Minor cleanups in read_suspend_image()
   
   - Make resume_bdev global to file, so we don't have to pass it around (we 
     always use the same one, so it shouldn't make a difference).
   
   - Allocate cur in read_suspend_image(), since it's the only function that
     uses it. 
   
   - Check all errors and make sure we free cur if any happen.
   
   - Make sure to return errors from the functions called, not our own. 
   
   - Free the pagedir if we hit an error after we allocate it. 

<mochel@osdl.org> (03/08/27 1.1153.76.6)
   [acpi] Move register save closer to call to enter sleep state.
   
   - By moving acpi_{save,restore}_state_mem() into acpi_pm_enter(), implying
     after interrupts have been disabled and nothing else is running on the 
     system, S3 is able to resume properly.

<mochel@osdl.org> (03/08/27 1.1153.76.5)
   [power] Make sure devices get added to the PM lists before bus_add_device().
   
   - Prevents ordering issues when drivers add more devices ->probe(). 

<mochel@osdl.org> (03/08/26 1.1153.76.4)
   [power] Separate suspend-to-disk from other suspend sequences.
   
   - Put in kernel/power/disk.c
   - Make compilation depend on CONFIG_SOFTWARE_SUSPEND (should probably be 
     renamed to CONFIG_PM_STD or some such).

<mochel@osdl.org> (03/08/25 1.1153.76.3)
   [power] Fix handling of pm_users.
   
   - Actually decrement on device_pm_release()
   - Call from device_pm_remove().

<mochel@osdl.org> (03/08/25 1.1153.76.1)
   [power] Fix device suspend handling
   
   - Handle -EAGAIN in device_suspend() properly: keep going, with error reset
     to 0. 
   
   - Call dpm_resume() if we got a real error, instead of device_resume(), which
     would deadlock.

<mochel@osdl.org> (03/08/22 1.1153.60.8)
   [power] swsusp Cleanups
   
   - do_magic()
     - Rename to swsusp_arch_suspend().
     - Move declaration to swsusp.c
   
   - arch_prepare_suspend()
     - Return an int
     - Fix x86 version to return -EFAULT if cpu does not have pse, instead of 
       calling panic().
     - Call from swsusp_save().
   
   - do_magic_suspend_1()
     - Move body to pm_suspend_disk()
     - Remove.
   
   - do_magic_suspend_2()
     - Rename to swsusp_suspend()
     - Move IRQ fiddling to suspend_save_image(), since that's the only call 
       that needs it. 
     - Return an int.
   
   - do_magic_resume_1()
     - Move body to pm_resume().
     - Remove
   
   - do_magic_resume_2()
     - Rename to swsusp_resume(). 
     - Return an int. 
   
   - swsusp general
     - Remove unnecessary includes.
     - Remove suspend_pagedir_lock, since it was only used to disable IRQs.
     - Change swsusp_{suspend,resume} return an int, so pm_suspend_disk() knows
       if anything failed. 
   
    

<mochel@osdl.org> (03/08/22 1.1153.60.7)
   [power] Move i386-specific swsusp code to arch/i386/power/

<mochel@osdl.org> (03/08/22 1.1153.60.6)
   [power] Fix up sysfs state handling.

<mochel@osdl.org> (03/08/22 1.1153.60.5)
   [power] Make sure console level is high when suspending.

<mochel@osdl.org> (03/08/22 1.1153.62.1)
   [power] Fix sysfs state reporting.



