Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWFZQqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWFZQqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFZQqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:46:23 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:21191 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750797AbWFZQp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:45:59 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 4/4] [Suspend2] User documentation
Date: Tue, 27 Jun 2006 02:46:01 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164600.10591.60266.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164547.10591.32821.stgit@nigel.suspend2.net>
References: <20060626164547.10591.32821.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation/power/suspend2.txt, containing information for users on
using Suspend2.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 Documentation/power/suspend2.txt |  673 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 673 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/suspend2.txt b/Documentation/power/suspend2.txt
new file mode 100644
index 0000000..54b18a9
--- /dev/null
+++ b/Documentation/power/suspend2.txt
@@ -0,0 +1,673 @@
+	--- Suspend2, version 2.2 ---
+
+1.  What is it?
+2.  Why would you want it?
+3.  What do you need to use it?
+4.  Why not just use the version already in the kernel?
+5.  How do you use it?
+6.  What do all those entries in /proc/suspend2 do?
+7.  How do you get support?
+8.  I think I've found a bug. What should I do?
+9.  When will XXX be supported?
+10  How does it work?
+11. Who wrote Suspend2?
+
+1. What is it?
+
+   Imagine you're sitting at your computer, working away. For some reason, you
+   need to turn off your computer for a while - perhaps it's time to go home
+   for the day. When you come back to your computer next, you're going to want
+   to carry on where you left off. Now imagine that you could push a button and
+   have your computer store the contents of its memory to disk and power down.
+   Then, when you next start up your computer, it loads that image back into
+   memory and you can carry on from where you were, just as if you'd never
+   turned the computer off. Far less time to start up, no reopening
+   applications and finding what directory you put that file in yesterday.
+   That's what Suspend2 does.
+
+   Suspend2 has a long heritage. It began life as work by Gabor Kuti, who,
+   with some help from Pavel Machek, got an early version going in 1999. The
+   project was then taken over by Florent Chabaud while still in alpha version
+   numbers. Nigel Cunningham came on the scene when Florent was unable to
+   continue, moving the project into betas, then 1.0, 2.0 and so on up to
+   the present 2.2 series. Pavel Machek's swsusp code, which was merged around
+   2.5.17 retains the original name, and was essentially a fork of the beta
+   code until Rafael Wysocki came on the scene in 2005 and began to improve it
+   further.
+
+2. Why would you want it?
+
+   Why wouldn't you want it?
+   
+   Being able to save the state of your system and quickly restore it improves
+   your productivity - you get a useful system in far less time than through
+   the normal boot process.
+   
+3. What do you need to use it?
+
+   a. Kernel Support.
+
+   i) The Suspend2 patch.
+   
+   Suspend2 is part of the Linux Kernel. This version is not part of Linus's
+   2.6 tree at the moment, so you will need to download the kernel source and
+   apply the latest patch. Having done that, enable the appropriate options in
+   make [menu|x]config (under General Setup), compile and install your kernel.
+   Suspend2 works with SMP, Highmem, preemption, x86-32, PPC and x86_64.
+
+   Suspend2 patches are available from http://suspend2.net.
+
+   ii) Compression and encryption support.
+
+   Compression and encryption support are implemented via the
+   cryptoapi. You will therefore want to select any Cryptoapi transforms that
+   you want to use on your image from the Cryptoapi menu while configuring
+   your kernel.
+
+   You can also tell Suspend to write it's image to an encrypted and/or
+   compressed filesystem/swap partition. In that case, you don't need to do
+   anything special for Suspend2 when it comes to kernel configuration.
+
+   iii) Configuring other options.
+
+   While you're configuring your kernel, try to configure as much as possible
+   to build as modules. We recommend this because there are a number of drivers
+   that are still in the process of implementing proper power management
+   support. In those cases, the best way to work around their current lack is
+   to build them as modules and remove the modules while suspending. You might
+   also bug the driver authors to get their support up to speed, or even help!
+
+   b. Storage.
+
+   i) Swap.
+
+   Suspend2 can store the suspend image in your swap partition, a swap file or
+   a combination thereof. Whichever combination you choose, you will probably
+   want to create enough swap space to store the largest image you could have,
+   plus the space you'd normally use for swap. A good rule of thumb would be
+   to calculate the amount of swap you'd want without using Suspend2, and then
+   add the amount of memory you have. This swapspace can be arranged in any way
+   you'd like. It can be in one partition or file, or spread over a number. The
+   only requirement is that they be active when you start a suspend cycle.
+   
+   There is one exception to this requirement. Suspend2 has the ability to turn
+   on one swap file or partition at the start of suspending and turn it back off
+   at the end. If you want to ensure you have enough memory to store a image
+   when your memory is fully used, you might want to make one swap partition or
+   file for 'normal' use, and another for Suspend2 to activate & deactivate
+   automatically. (Further details below).
+
+   ii) Normal files.
+
+   Suspend2 includes a 'filewriter'. The filewriter can store
+   your image in a simple file. Since Linux has the idea of everything being
+   a file, this is more powerful than it initially sounds. If, for example,
+   you were to set up a network block device file, you could suspend to a
+   network server. This has been tested and works to a point, but nbd itself
+   isn't stateless enough for our purposes.
+
+   Take extra care when setting up the filewriter. If you just type commands
+   without thinking and then try to suspend, you could cause irreversible
+   corruption on your filesystems! Make sure you have backups. Also, because
+   the filewriter is comparatively new, it's not as well tested as the
+   swapwriter. Be aware that there may be bugs that could cause damage to your
+   data even if you are careful! You have been warned!
+
+   Most people will only want to suspend to a local file. To achieve that, do
+   something along the lines of:
+
+   echo "Suspend2" > /suspend-file
+   dd if=/dev/zero bs=1M count=512 >> suspend-file
+
+   This will create a 512MB file called /suspend-file. To get Suspend2 to use
+   it:
+
+   echo /suspend-file > /proc/suspend2/filewriter_target
+
+   Then
+
+   cat /proc/suspend2/resume2
+
+   Put the results of this into your bootloader's configuration (see also step
+   C, below:
+
+   ---EXAMPLE-ONLY-DON'T-COPY-AND-PASTE---
+   # cat /proc/suspend2/resume2
+   file:/dev/hda2:0x1e001
+   
+   In this example, we would edit the append= line of our lilo.conf|menu.lst
+   so that it included:
+
+   resume2=file:/dev/hda2:0x1e001
+   ---EXAMPLE-ONLY-DON'T-COPY-AND-PASTE---
+ 
+   For those who are thinking 'Could I make the file sparse?', the answer is
+   'No!'. At the moment, there is no way for Suspend2 to fill in the holes in
+   a sparse file while suspending. In the longer term (post merge!), I'd like
+   to change things so that the file could be dynamically resized as needed.
+   Right now, however, that's not possible.
+
+   c. Bootloader configuration.
+   
+   Using Suspend2 also requires that you add an extra parameter to 
+   your lilo.conf or equivalent. Here's an example for a swap partition:
+
+   append="resume2=swap:/dev/hda1"
+
+   This would tell Suspend2 that /dev/hda1 is a swap partition you 
+   have. Suspend2 will use the swap signature of this partition as a
+   pointer to your data when you suspend. This means that (in this example)
+   /dev/hda1 doesn't need to be _the_ swap partition where all of your data
+   is actually stored. It just needs to be a swap partition that has a
+   valid signature.
+
+   You don't need to have a swap partition for this purpose. Suspend2
+   can also use a swap file, but usage is a little more complex. Having made
+   your swap file, turn it on and do 
+
+   cat /proc/suspend2/headerlocations
+
+   (this assumes you've already compiled your kernel with Suspend2
+   support and booted it). The results of the cat command will tell you
+   what you need to put in lilo.conf:
+
+   For swap partitions like /dev/hda1, simply use resume2=/dev/hda1.
+   For swapfile `swapfile`, use resume2=swap:/dev/hda2:0x242d@4096.
+
+   If the swapfile changes for any reason (it is moved to a different
+   location, it is deleted and recreated, or the filesystem is
+   defragmented) then you will have to check
+   /proc/suspend2/headerlocations for a new resume_block value.
+
+   Once you've compiled and installed the kernel, adjusted your lilo.conf
+   and rerun lilo, you should only need to reboot for the most basic part
+   of Suspend2 to be ready.
+
+   If you only compile in the swapwriter, or only compile in the filewriter,
+   you don't need to add the "swap:" part of the resume2= parameters above.
+   resume2=/dev/hda2:0x242d@4096 will work just as well.
+
+   d. The hibernate script.
+
+   Since the driver model in 2.6 kernels is still being developed, you may need
+   to do more, however. Users of Suspend2 usually start the process via a script
+   which prepares for the suspend, tells the kernel to do its stuff and then
+   restore things afterwards. This script might involve:
+
+   - Switching to a text console and back if X doesn't like the video card
+     status on resume.
+   - Un/reloading PCMCIA support since it doesn't play well with suspend.
+  
+   Note that you might not be able to unload some drivers if there are 
+   processes using them. You might have to kill off processes that hold
+   devices open. Hint: if your X server accesses an USB mouse, doing a
+   'chvt' to a text console releases the device and you can unload the
+   module.
+
+   Check out the latest script (available on suspend2.net).
+   
+4. Why not just use the version already in the kernel?
+
+   The version in the vanilla kernel has a number of drawbacks. Among these:
+	- it has a maximum image size of 1/2 total memory.
+	- it doesn't allocate storage until after it has snapshotted memory.
+	  This means that you can't be sure suspending will work until you
+	  see it start to write the image.
+	- it performs all of it's I/O synchronously.
+	- it does not allow you to press escape to cancel a cycle
+	- it does not allow you to automatically swapon a file when
+	  starting a cycle.
+	- it does not allow you to use multiple swap partitions.
+	- it does not allow you to use swapfiles.
+	- it does not allow you to use ordinary files.
+	- it just invalidates an image and continues to boot if you
+	  accidentally boot the wrong kernel after suspending.
+	- it doesn't support any sort of nice display while suspending
+	- it is moving toward requiring that you have an initrd/initramfs
+	  to ever have a hope of resuming.
+
+5. How do you use it?
+
+   Once your script is properly set up, you should just be able to start it
+   and everything should go like clockwork. Of course things aren't always
+   that easy out of the box.
+
+   Check out (in the kernel source tree) include/linux/suspend2.h for
+   settings you can use to get detailed information about what suspend is doing.
+   The kernel parameters suspend_act, suspend_dbg and suspend_lvl allow you to
+   set the action and debugging parameters prior to starting a suspend and/or
+   at the lilo prompt before resuming. There is also a nice little program that
+   should be available from suspend2.net which makes it easier to turn these
+   debugging settings on and off. Note that to get any debugging output, you
+   need to enable CONFIG_PM_DEBUG when compiling the kernel.
+
+   A neat feature of Suspend2 is that you can press Escape at any time
+   during suspending, and the process will be aborted.
+   
+   Due to the way suspend works, this means you'll have your system back and
+   perfectly usable almost instantly. The only exception is when it's at
+   the very end of writing the image. Then it will need to reload a small
+   (usually 4-50MBs, depending upon the image characteristics) portion first.
+
+   If you run into problems with resuming, adding the "noresume2" option to
+   the kernel command line will let you skip the resume step and recover your
+   system.
+
+6. What do all those entries in /proc/suspend2 do?
+
+   /proc/suspend2 is the directory which contains files you can use to
+   tune and configure Suspend2 to your liking. The exact contents of
+   the directory will depend upon the version of Suspend2 you're
+   running and the options you selected at compile time. In the following
+   descriptions, names in brackets refer to compile time options.
+   (Note that they're all dependant upon you having selected CONFIG_SUSPEND2
+   in the first place!)
+
+   Since the values of these settings can open potential security risks, they
+   are usually accessible only to the root user. You can, however, enable a
+   compile time option which makes all of these files world-accessible. This
+   should only be done if you trust everyone with shell access to this
+   computer!
+  
+   - debug_info:
+  
+   This file returns information about your configuration that may be helpful
+   in diagnosing problems with suspending.
+
+   - debug_sections (CONFIG_PM_DEBUG):
+
+   This value, together with the console log level, controls what debugging
+   information is displayed. The console log level determines the level of
+   detail, and this value determines what detail is displayed. This value is
+   a bit vector, and the meaning of the bits can be found in the kernel tree
+   in include/linux/suspend2.h. It can be overridden using the kernel's
+   command line option suspend_dbg.
+
+   - default_console_level (CONFIG_PM_DEBUG):
+
+   This determines the value of the console log level at the start of a
+   suspend cycle. If debugging is compiled in, the console log level can be
+   changed during a cycle by pressing the digit keys. Meanings are:
+
+   0: Nice display.
+   1: Nice display plus numerical progress.
+   2: Errors only.
+   3: Low level debugging info.
+   4: Medium level debugging info.
+   5: High level debugging info.
+   6: Verbose debugging info.
+
+   This value can be overridden using the kernel command line option 
+   suspend_lvl.
+
+   - disable_*
+
+   This option can be used to temporarily disable various parts of suspend.
+   Note that these flags can be set by restoring all_settings: If the saved
+   settings don't include any information about how a part of suspend should
+   be configured, that section will be disabled.
+
+   - do_resume:
+
+   When anything is written to this file suspend will attempt to read and
+   restore an image. If there is no image, it will return almost immediately.
+   If an image exists, the echo > will never return. Instead, the original
+   kernel context will be restored and the original echo > do_suspend will
+   return.
+
+   - do_suspend:
+
+   When anything is written to this file, the kernel side of Suspend2 will
+   begin to attempt to write an image to disk and power down. You'll normally
+   want to run the hibernate script instead, to get modules unloaded first.
+
+   - enable_escape:
+
+   Setting this to "1" will enable you abort a suspend by
+   pressing escape, "0" (default) disables this feature. Note that enabling
+   this option means that you cannot initiate a suspend and then walk away
+   from your computer, expecting it to be secure. With feature disabled,
+   you can validly have this expectation once Suspend begins to write the
+   image to disk. (Prior to this point, it is possible that Suspend might
+   about because of failure to freeze all processes or because constraints
+   on its ability to save the image are not met).
+
+   - expected_compression:
+
+   These values allow you to set an expected compression ratio, which Software
+   Suspend will use in calculating whether it meets constraints on the image
+   size. If this expected compression ratio is not attained, the suspend will
+   abort, so it is wise to allow some spare. You can see what compression
+   ratio is achieved in the logs after suspending.
+
+   - filewriter_target:
+
+   Read this value to get the current setting. Write to it to point Suspend
+   at a new storage location for the filewriter. See above for details of how
+   to set up the filewriter.
+
+   - headerlocations:
+
+   This option tells you the resume2= options to use for swap devices you
+   currently have activated. It is particularly useful when you only want to
+   use a swap file to store your image. See above for further details.
+
+   - image_exists:
+
+   Can be used in a script to determine whether a valid image exists at the
+   location currently pointed to by resume2=. Returns up to three lines.
+   The first is whether an image exists (-1 for unsure, otherwise 0 or 1).
+   If an image eixsts, additional lines will return the machine and version.
+   Echoing anything to this entry removes any current image.
+
+   - image_size_limit:
+
+   The maximum size of suspend image written to disk, measured in megabytes
+   (1024*1024).
+
+   - interface_version:
+
+   The value returned by this file can be used by scripts and configuration
+   tools to determine what entries should be looked for. The value is
+   incremented whenever an entry in /proc/suspend2 is obsoleted or 
+   added.
+
+   - last_result:
+
+   The result of the last suspend, as defined in
+   include/linux/suspend-debug.h with the values SUSPEND_ABORTED to
+   SUSPEND_KEPT_IMAGE. This is a bitmask.
+
+   - log_everything (CONFIG_PM_DEBUG):
+
+   Setting this option results in all messages printed being logged. Normally,
+   only a subset are logged, so as to not slow the process and not clutter the
+   logs. Useful for debugging. It can be toggled during a cycle by pressing
+   'L'.
+
+   - pause_between_steps (CONFIG_PM_DEBUG):
+
+   This option is used during debugging, to make Suspend2 pause between
+   each step of the process. It is ignored when the nice display is on.
+
+   - powerdown_method:
+
+   Used to select a method by which Suspend2 should powerdown after writing the
+   image. Currently:
+
+   0: Don't use ACPI to power off.
+   3: Attempt to enter Suspend-to-ram.
+   4: Attempt to enter ACPI S4 mode.
+   5: Attempt to power down via ACPI S5 mode.
+
+   Note that these options are highly dependant upon your hardware & software:
+
+   3: When succesful, your machine suspends-to-ram instead of powering off.
+      The advantage of using this mode is that it doesn't matter whether your
+      battery has enough charge to make it through to your next resume. If it
+      lasts, you will simply resume from suspend to ram (and the image on disk
+      will be discarded). If the battery runs out, you will resume from disk
+      instead. The disadvantage is that it takes longer than a normal
+      suspend-to-ram to enter the state, since the suspend-to-disk image needs
+      to be written first.
+   4/5: When successful, your machine will be off and comsume (almost) no power.
+      But it might still react to some external events like opening the lid or
+      trafic on  a network or usb device. For the bios, resume is then the same
+      as warm boot, similar to a situation where you used the command `reboot'
+      to reboot your machine. If your machine has problems on warm boot or if
+      you want to protect your machine with the bios password, this is probably
+      not the right choice. Mode 4 may be necessary on some machines where ACPI
+      wake up methods need to be run to properly reinitialise hardware after a
+      suspend-to-disk cycle.  
+   0: Switch the machine completely off. The only possible wakeup is the power
+      button. For the bios, resume is then the same as a cold boot, in
+      particular you would  have to provide your bios boot password if your
+      machine uses that feature for booting.
+
+   - progressbar_granularity_limit:
+
+   This option can be used to limit the granularity of the progress bar
+   displayed with a bootsplash screen. The value is the maximum number of
+   steps. That is, 10 will make the progress bar jump in 10% increments.
+
+   - reboot:
+
+   This option causes Suspend2 to reboot rather than powering down
+   at the end of saving an image. It can be toggled during a cycle by pressing
+   'R'.
+
+   - resume_commandline:
+
+   This entry can be read after resuming to see the commandline that was used
+   when resuming began. You might use this to set up two bootloader entries
+   that are the same apart from the fact that one includes a extra append=
+   argument "at_work=1". You could then grep resume_commandline in your
+   post-resume scripts and configure networking (for example) differently
+   depending upon whether you're at home or work. resume_commandline can be
+   set to arbitrary text if you wish to remove sensitive contents.
+
+   - swapfile:
+
+   This entry is used to specify the swapfile or partition that
+   Suspend2 will attempt to swapon/swapoff automatically. Thus, if
+   I normally use /dev/hda1 for swap, and want to use /dev/hda2 for specifically
+   for my suspend image, I would
+  
+   echo /dev/hda2 > /proc/suspend2/swapfile
+
+   /dev/hda2 would then be automatically swapon'd and swapoff'd. Note that the
+   swapon and swapoff occur while other processes are frozen (including kswapd)
+   so this swap file will not be used up when attempting to free memory. The
+   parition/file is also given the highest priority, so other swapfiles/partitions
+   will only be used to save the image when this one is filled.
+
+   The value of this file is used by headerlocations along with any currently
+   activated swapfiles/partitions.
+
+   - toggle_process_nofreeze
+
+   This entry can be used to toggle the NOFREEZE flag on a process, to allow it
+   to run during Suspending. It should be used with extreme caution. There are
+   strict limitations on what a process running during suspend can do. This is
+   really only intended for use by Suspend's helpers (userui in particular).
+
+   - userui_program
+
+   This entry is used to tell Suspend what userspace program to use for
+   providing a user interface while suspending. The program uses a netlink
+   socket to pass messages back and forward to the kernel, allowing all of the
+   functions formerly implemented in the kernel user interface components.
+
+   - version:
+  
+   The version of suspend you have compiled into the currently running kernel.
+
+7. How do you get support?
+
+   Glad you asked. Suspend2 is being actively maintained and supported
+   by Nigel (the guy doing most of the kernel coding at the moment), Bernard
+   (who maintains the hibernate script and userspace user interface components)
+   and its users.
+
+   Resources availble include HowTos, FAQs and a Wiki, all available via
+   suspend2.net.  You can find the mailing lists there.
+
+8. I think I've found a bug. What should I do?
+
+   By far and a way, the most common problems people have with suspend2
+   related to drivers not having adequate power management support. In this
+   case, it is not a bug with suspend2, but we can still help you. As we
+   mentioned above, such issues can usually be worked around by building the
+   functionality as modules and unloading them while suspending. Please visit
+   the Wiki for up-to-date lists of known issues and work arounds.
+
+   If this information doesn't help, try running:
+
+   hibernate --bug-report
+
+   ..and sending the output to the users mailing list.
+
+   Good information on how to provide us with useful information from an
+   oops is found in the file REPORTING-BUGS, in the top level directory
+   of the kernel tree. If you get an oops, please especially note the
+   information about running what is printed on the screen through ksymoops.
+   The raw information is useless.
+
+9. When will XXX be supported?
+
+   If there's a feature missing from Suspend2 that you'd like, feel free to
+   ask. We try to be obliging, within reason.
+
+   Patches are welcome. Please send to the list.
+
+10. How does it work?
+
+   Suspend2 does its work in a number of steps.
+
+   a. Freezing system activity.
+
+   The first main stage in suspending is to stop all other activity. This is
+   achieved in stages. Processes are considered in fours groups, which we will
+   describe in reverse order for clarity's sake: Threads with the PF_NOFREEZE
+   flag, kernel threads without this flag, userspace processes with the
+   PF_SYNCTHREAD flag and all other processes. The first set (PF_NOFREEZE) are
+   untouched by the refrigerator code. They are allowed to run during suspending
+   and resuming, and are used to support user interaction, storage access or the
+   like. Other kernel threads (those unneeded while suspending) are frozen last.
+   This leaves us with userspace processes that need to be frozen. When a
+   process enters one of the *_sync system calls, we set a PF_SYNCTHREAD flag on
+   that process for the duration of that call. Processes that have this flag are
+   frozen after processes without it, so that we can seek to ensure that dirty
+   data is synced to disk as quickly as possible in a situation where other
+   processes may be submitting writes at the same time. Freezing the processes
+   that are submitting data stops new I/O from being submitted. Syncthreads can
+   then cleanly finish their work. So the order is:
+
+   - Userspace processes without PF_SYNCTHREAD or PF_NOFREEZE;
+   - Userspace processes with PF_SYNCTHREAD (they won't have NOFREEZE);
+   - Kernel processes without PF_NOFREEZE.
+
+   b. Eating memory.
+
+   For a successful suspend, you need to have enough disk space to store the
+   image and enough memory for the various limitations of Suspend2's
+   algorithm. You can also specify a maximum image size. In order to attain
+   to those constraints, Suspend2 may 'eat' memory. If, after freezing
+   processes, the constraints aren't met, Suspend2 will thaw all the
+   other processes and begin to eat memory until its calculations indicate
+   the constraints are met. It will then freeze processes again and recheck
+   its calculations.
+
+   c. Allocation of storage.
+
+   Next, Suspend2 allocates the storage that will be used to save
+   the image.
+
+   The core of Suspend2 knows nothing about how or where pages are stored. We
+   therefore request the active writer (remember you might have compiled in
+   more than one!) to allocate enough storage for our expect image size. If
+   this request cannot be fulfilled, we eat more memory and try again. If it
+   is fulfiled, we seek to allocate additional storage, just in case our
+   expected compression ratio (if any) isn't achieved. This time, however, we
+   just continue if we can't allocate enough storage.
+
+   If these calls to our writer change the characteristics of the image such
+   that we haven't allocated enough memory, we also loop. (The writer may well
+   need to allocate space for its storage information).
+
+   d. Write the first part of the image.
+
+   Suspend2 stores the image in two sets of pages called 'pagesets'.
+   Pageset 2 contains pages on the active and inactive lists; essentially
+   the page cache. Pageset 1 contains all other pages, including the kernel.
+   We use two pagesets for one important reason: We need to make an atomic copy
+   of the kernel to ensure consistency of the image. Without a second pageset,
+   that would limit us to an image that was at most half the amount of memory
+   available. Using two pagesets allows us to store a full image. Since pageset
+   2 pages won't be needed in saving pageset 1, we first save pageset 2 pages.
+   We can then make our atomic copy of the remaining pages using both pageset 2
+   pages and any other pages that are free. While saving both pagesets, we are
+   careful not to corrupt the image. Among other things, we use lowlevel block
+   I/O routines that don't change the pagecache contents.
+
+   The next step, then, is writing pageset 2.
+
+   e. Suspending drivers and storing processor context.
+
+   Having written pageset2, Suspend2 calls the power management functions to
+   notify drivers of the suspend, and saves the processor state in preparation
+   for the atomic copy of memory we are about to make.
+
+   f. Atomic copy.
+
+   At this stage, everything else but the Suspend2 code is halted. Processes
+   are frozen or idling, drivers are quiesced and have stored (ideally and where
+   necessary) their configuration in memory we are about to atomically copy.
+   In our lowlevel architecture specific code, we have saved the CPU state.
+   We can therefore now do our atomic copy before resuming drivers etc.
+
+   g. Save the atomic copy (pageset 1).
+
+   Suspend can then write the atomic copy of the remaining pages. Since we
+   have copied the pages into other locations, we can continue to use the
+   normal block I/O routines without fear of corruption our image.
+
+   f. Save the suspend header.
+
+   Nearly there! We save our settings and other parameters needed for
+   reloading pageset 1 in a 'suspend header'. We also tell our writer to
+   serialise its data at this stage, so that it can reread the image at resume
+   time. Note that the writer can write this data in any format - in the case
+   of the swapwriter, for example, it splits header pages in 4092 byte blocks,
+   using the last four bytes to link pages of data together. This is completely
+   transparent to the core.
+
+   g. Set the image header.
+
+   Finally, we edit the header at our resume2= location. The signature is
+   changed by the writer to reflect the fact that an image exists, and to point
+   to the start of that data if necessary (swapwriter).
+
+   h. Power down.
+
+   Or reboot if we're debugging and the appropriate option is selected.
+
+   Whew!
+
+   Reloading the image.
+   --------------------
+
+   Reloading the image is essentially the reverse of all the above. We load
+   our copy of pageset 1, being careful to choose locations that aren't going
+   to be overwritten as we copy it back (We start very early in the boot
+   process, so there are no other processes to quiesce here). We then copy
+   pageset 1 back to its original location in memory and restore the process
+   context. We are now running with the original kernel. Next, we reload the
+   pageset 2 pages, free the memory and swap used by Suspend2, restore
+   the pageset header and restart processes. Sounds easy in comparison to
+   suspending, doesn't it!
+
+   There is of course more to Suspend2 than this, but this explanation
+   should be a good start. If there's interest, I'll write further
+   documentation on range pages and the low level I/O.
+
+11. Who wrote Suspend2?
+
+   (Answer based on the writings of Florent Chabaud, credits in files and
+   Nigel's limited knowledge; apologies to anyone missed out!)
+
+   The main developers of Suspend2 have been...
+
+   Gabor Kuti
+   Pavel Machek
+   Florent Chabaud
+   Bernard Blackham
+   Nigel Cunningham
+
+   They have been aided in their efforts by a host of hundreds, if not thousands
+   of testers and people who have submitted bug fixes & suggestions. Of special
+   note are the efforts of Michael Frank, who had his computers repetitively
+   suspend and resume for literally tens of thousands of cycles and developed
+   scripts to stress the system and test Suspend2 far beyond the point
+   most of us (Nigel included!) would consider testing. His efforts have
+   contributed as much to Suspend2 as any of the names above.

--
Nigel Cunningham		nigel at suspend2 dot net
