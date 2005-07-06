Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVGFDC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVGFDC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVGFC6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:58:05 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:6553 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262057AbVGFCTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:25 -0400
Subject: [PATCH] [20/48] Suspend2 2.1.9.8 for 2.6.12: 520-version-specific-x86_64.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164413992@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 550-documentation.patch-old/Documentation/kernel-parameters.txt 550-documentation.patch-new/Documentation/kernel-parameters.txt
--- 550-documentation.patch-old/Documentation/kernel-parameters.txt	2005-06-20 11:46:40.000000000 +1000
+++ 550-documentation.patch-new/Documentation/kernel-parameters.txt	2005-07-04 23:14:19.000000000 +1000
@@ -910,6 +910,8 @@ running once the system is up.
 
 	noresume	[SWSUSP] Disables resume and restore original swap space.
  
+	noresume2	[SWSUSP2] Disables resuming and restores original swap signature.
+ 
 	no-scroll	[VGA] Disables scrollback.
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
@@ -1146,7 +1148,12 @@ running once the system is up.
 
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
-	resume=		[SWSUSP] Specify the partition device for software suspension
+	resume=		[SWSUSP] Specify the partition device for software suspension.
+
+	resume2=	[SWSUSP2] Specify the storage device for software suspend.
+			Format: <writer>:<writer-parameters>.
+			See Documentation/power/swsusp2.txt for details of the formats
+			for available image writers.
 
 	rhash_entries=	[KNL,NET]
 			Set number of hash buckets for route cache
diff -ruNp 550-documentation.patch-old/Documentation/power/internals.txt 550-documentation.patch-new/Documentation/power/internals.txt
--- 550-documentation.patch-old/Documentation/power/internals.txt	1970-01-01 10:00:00.000000000 +1000
+++ 550-documentation.patch-new/Documentation/power/internals.txt	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,364 @@
+		Software Suspend 2.0 Internal Documentation.
+				Version 1
+
+1.  Introduction.
+
+    Software Suspend 2.0 is an addition to the Linux Kernel, designed to
+    allow the user to quickly shutdown and quickly boot a computer, without
+    needing to close documents or programs. It is equivalent to the
+    hibernate facility in some laptops. This implementation, however,
+    requires no special BIOS or hardware support.
+
+    The code in these files is based upon the original implementation
+    prepared by Gabor Kuti and additional work by Pavel Machek and a
+    host of others. This code has been substantially reworked by Nigel
+    Cunningham, again with the help and testing of many others, not the
+    least of whom is Michael Frank, At its heart, however, the operation is
+    essentially the same as Gabor's version.
+
+2.  Overview of operation.
+
+    The basic sequence of operations is as follows:
+
+	a. Quiesce all other activity.
+	b. Ensure enough memory and storage space are available, and attempt
+	   to free memory/storage if necessary.
+	c. Allocate the required memory and storage space.
+	d. Write the image.
+	e. Power down.
+
+    There are a number of complicating factors which mean that things are
+    not as simple as the above would imply, however...
+
+    o The activity of each process must be stopped at a point where it will
+    not be holding locks necessary for saving the image, or unexpectedly
+    restart operations due to something like a timeout and thereby make
+    our image inconsistent.
+
+    o It is desirous that we sync outstanding I/O to disk before calculating
+    image statistics. This reduces corruption if one should suspend but
+    then not resume, and also makes later parts of the operation safer (see
+    below).
+
+    o We need to get as close as we can to an atomic copy of the data.
+    Inconsistencies in the image will result inconsistent memory contents at
+    resume time, and thus in instability of the system and/or file system
+    corruption. This would appear to imply a maximum image size of one half of
+    the amount of RAM, but we have a solution... (again, below).
+
+    o In 2.6, we must play nicely with the other suspend-to-disk
+    implementations.
+
+3.  Detailed description of internals.
+
+    a. Quiescing activity.
+
+    Safely quiescing the system is achieved in a number of steps. First, we
+    wait for existing activity to complete, while holding new activity until
+    post-resume. Second, we sync unwritten buffers. Third, we send a
+    'pseudo-signal' to all processes that have not yet entered the
+    'refrigerator' but should be frozen, causing them to be refrigerated.
+
+    Waiting for existing activity to complete is achieved by using hooks at
+    the beginning and end of critical paths in the kernel code. When a process
+    enters a section where it cannot be safely refrigerated, the process flag
+    PF_FRIDGE_WAIT is set from the SWSUSP_ACTIVITY_STARTING macro. In the same
+    routine, at completion of the critical region, a SWSUSP_ACTIVITY_END macro
+    resets the flag. The _STARTING and _ENDING macros also atomically adjust
+    the global counter swsusp_num_active. While the counter is non-zero, 
+    Software Suspend's freezer will wait.
+
+    These macros serve two other additional purposes. Local variables are used
+    to ensure that processes can safely pass through multiple  _STARTING and
+    _ENDING macros, and checks are made to ensure that the freezer is not
+    waiting for activity to finish. If a process wants to start on a critical
+    path when Suspend is waiting for activity to finish, it will be held at the
+    start of the critical path and refrigerated earlier than would normally be
+    the case. It will be allowed to continue operation after the Suspend cycle
+    is finished or aborted.
+
+    A process in a critical path may also have a section where it releases
+    locks and can be safely stopped until post-resume. For these cases, the
+    SWSUSP_ACTIVITY_PAUSING and _RESTARTING macros may be used. They function
+    in a similar manner to the _STARTING and _ENDING macros.
+
+    Finally, we remember that some threads may be necessary for syncing data to
+    storage. These threads have PF_SYNCTHREAD set, and may use the special macro
+    SWSUSP_ACTIVITY_SYNCTHREAD_PAUSING to indicate that Suspend can safely
+    continue, while not themselves entering the refrigerator.
+
+    Once activity is stopped, Suspend will initiate a fsync of all devices.
+    This aims to increase the integrity of the disk state, just in case
+    something should go wrong.
+
+    During the initial stage, Suspend indicates its desire that processes be
+    stopped by setting the FREEZE_NEW_ACTIVITY bit of swsusp_state.  Once the
+    sync is complete, SYNCTHREAD processes no longer need to run. The
+    FREEZE_UNREFRIGERATED bit is now set, causing them to be refrigerated as
+    well, should they attempt to start new activity. (There should be nothing
+    for them to do, but just-in-case).
+
+    Suspend can now put remaining processes in the refrigerator without fear
+    of deadlocking or leaving dirty data unsynced. The refrigerator is a
+    procedure where processes wait until the cycle is complete. While in there,
+    we can be sure that they will not perform activity that will make our
+    image inconsistent. Processes enter the refrigerator either by being
+    caught at one of the previously mentioned hooks, or by receiving a 'pseudo-
+    signal' from Suspend at this stage. I call it a pseudo signal because
+    signal_wake_up is called for the process when it actually hasn't been
+    signalled. A special hook in the signal handler then calls the refrigerator.
+    The refrigerator, in turn, recalculates the signal pending status to
+    ensure no ill effects result.
+
+    Not all processes are refrigerated. The Suspend thread itself, of course,
+    is one such thread. Others are flagged by setting PF_NOFREEZE, usually
+    because they are needed during suspend.
+
+    In 2.4, the dosexec thread (Win4Lin) is treated specially. It does not
+    handle us even pretending to send it a signal. This is worked-around by
+    us adjusting the can_schedule() macro in schedule.c to stop the task from
+    being scheduled during suspend. Ugly, but it works. The 2.6 version of
+    Win4Lin has been made compatible.
+
+    b. Ensure enough memory & storage are available.
+    c. Allocate the required memory and storage space.
+
+    These steps are merged together in the prepare_image function, found in
+    prepare_image.c. The functions are merged because of the cyclical nature
+    of the problem of calculating how much memory and storage is needed. Since
+    the data structures containing the information about the image must
+    themselves take memory and use storage, the amount of memory and storage
+    required changes as we prepare the image. Since the changes are not large,
+    only one or two iterations will be required to achieve a solution.
+
+    d. Write the image.
+
+    We previously mentioned the need to create an atomic copy of the data, and
+    the half-of-memory limitation that is implied in this. This limitation is
+    circumvented by dividing the memory to be saved into two parts, called
+    pagesets.
+
+    Pageset2 contains the page cache - the pages on the active and inactive
+    lists. These pages are saved first and reloaded last. While saving these
+    pages, the swapwriter plugin carefully ensures that the work of writing
+    the pages doesn't make the image inconsistent. Pages added to the LRU
+    lists are immediately shot down, and careful accounting for available
+    memory aids debugging. No atomic copy of these pages needs to be made.
+
+    Writing the image requires memory, of course, and at this point we have
+    also not yet suspended the drivers. To avoid the possibility of remaining
+    activity corrupting the image, we allocate a special memory pool. Calls
+    to __alloc_pages and __free_pages_ok are then diverted to use our memory
+    pool. Pages in the memory pool are saved as part of pageset1 regardless of
+    whether or not they are used.
+
+    Once pageset2 has been saved, we suspend the drivers and save the CPU
+    context before making an atomic copy of pageset1, resuming the drivers
+    and saving the atomic copy. After saving the two pagesets, we just need to
+    save our metadata before powering down.
+
+    Having saved pageset2 pages, we can safely overwrite their contents with
+    the atomic copy of pageset1. This is how we manage to overcome the half of
+    memory limitation. Pageset2 is normally far larger than pageset1, and
+    pageset1 is normally much smaller than half of the memory, with the result
+    that pageset2 pages can be safely overwritten with the atomic copy of
+    pageset1. This is where we need to be careful about syncing, however.
+    Pageset2 will probably contain filesystem meta data. If this is overwritten
+    with pageset1 and then a sync occurs, the filesystem will be corrupted -
+    at least until resume time and another sync of the restored data. Since
+    there is a possibility that the user might not resume or (may it never be!)
+    that suspend might oops, we do our utmost to avoid syncing filesystems after
+    copying pageset1.
+
+    e. Power down.
+
+    Powering down uses standard kernel routines. Prior to this, however, we
+    suspend drivers again, ensuring that write caches are flushed.
+
+4.  The method of writing the image.
+
+    Software Suspend 2.0rc3 and later contain an internal API which is
+    designed to simplify the implementation of new methods of transforming
+    the image to be written and writing the image itself. Prior to rc3,
+    compression support was inlined in the image writing code, and the data
+    structures and code for managing swap were intertwined with the rest of
+    the code. A number of people had expressed interest in implementing
+    image encryption, and alternative methods of storing the image. This
+    internal API makes that possible by implementing 'plugins'.
+
+    A plugin is a single file which encapsulates the functionality needed
+    to transform a pageset of data (encryption or compression, for example),
+    or to write the pageset to a device. The former type of plugin is called
+    a 'page-transformer', the later a 'writer'.
+
+    Plugins are linked together in pipeline fashion. There may be zero or more
+    page transformers in a pipeline, and there is always exactly one writer.
+    The pipeline follows this pattern:
+
+		---------------------------------
+		|     Software Suspend Core     |
+		---------------------------------
+				|
+				|
+		---------------------------------
+		|	Page transformer 1	|
+		---------------------------------
+				|
+				|
+		---------------------------------
+		|	Page transformer 2	|
+		---------------------------------
+				|
+				|
+		---------------------------------
+		|            Writer		|
+		---------------------------------
+
+    During the writing of an image, the core code feeds pages one at a time
+    to the first plugin. This plugin performs whatever transformations it
+    implements on the incoming data, completely consuming the incoming data and
+    feeding output in a similar manner to the next plugin. A plugin may buffer
+    its output.
+
+    During reading, the pipeline works in the reverse direction. The core code
+    calls the first plugin with the address of a buffer which should be filled.
+    (Note that the buffer size is always PAGE_SIZE at this time). This plugin
+    will in turn request data from the next plugin and so on down until the
+    writer is made to read from the stored image.
+
+    Part of definition of the structure of a plugin thus looks like this:
+
+	/* Writing the image proper */
+	int (*write_init) (int stream_number);
+	int (*write_chunk) (char * buffer_start);
+	int (*write_cleanup) (void);
+
+	/* Reading the image proper */
+	int (*read_init) (int stream_number);
+	int (*read_chunk) (char * buffer_start, int sync);
+	int (*read_cleanup) (void);
+
+    It should be noted that the _cleanup routines may be called before the
+    full stream of data has been read or written. While writing the image,
+    the user may (depending upon settings) choose to abort suspending, and
+    if we are in the midst of writing the last portion of the image, a portion
+    of the second pageset may be reread.
+
+    In addition to the above routines for writing the data, all plugins have a
+    number of other routines:
+
+    TYPE indicates whether the plugin is a page transformer or a writer.
+    #define TRANSFORMER_PLUGIN 1
+    #define WRITER_PLUGIN 2
+
+    NAME is the name of the plugin, used in generic messages.
+
+    PLUGIN_LIST is used to link the plugin into the list of all plugins.
+
+    MEMORY_NEEDED returns the number of pages of memory required by the plugin
+    to do its work.
+
+    STORAGE_NEEDED returns the number of pages in the suspend header required
+    to store the plugin's configuration data.
+
+    PRINT_DEBUG_INFO fills a buffer with information to be displayed about the
+    operation or settings of the plugin.
+
+    SAVE_CONFIG_INFO returns a buffer of PAGE_SIZE or smaller (the size is the
+    return code), containing the plugin's configuration info. This information
+    will be written in the image header and restored at resume time. Since this
+    buffer is allocated after the atomic copy of the kernel is made, you don't
+    need to worry about the buffer being freed.
+
+    LOAD_CONFIG_INFO gives the plugin a pointer to the the configuration info
+    which was saved during suspending. Once again, the plugin doesn't need to
+    worry about freeing the buffer. The kernel will be overwritten with the
+    original kernel, so no memory leak will occur.
+
+    OPS contains the operations specific to transformers and writers. These are
+    described below.
+
+    The complete definition of struct swsusp_plugin_ops is:
+
+	struct swsusp_plugin_ops {
+		/* Functions common to transformers and writers */
+		int type;
+		char * name;
+		struct list_head plugin_list;
+		unsigned long (*memory_needed) (void);
+		unsigned long (*storage_needed) (void);
+		int (*print_debug_info) (char * buffer, int size);
+		int (*save_config_info) (char * buffer);
+		void (*load_config_info) (char * buffer, int len);
+	
+		/* Writing the image proper */
+		int (*write_init) (int stream_number);
+		int (*write_chunk) (char * buffer_start);
+		int (*write_cleanup) (void);
+
+		/* Reading the image proper */
+		int (*read_init) (int stream_number);
+		int (*read_chunk) (char * buffer_start, int sync);
+		int (*read_cleanup) (void);
+
+		union {
+			struct swsusp_transformer_ops transformer;
+			struct swsusp_writer_ops writer;
+		} ops;
+	};
+
+
+	The operations specific to transformers are few in number:
+
+	struct swsusp_transformer_ops {
+		int (*expected_compression) (void);
+		struct list_head transformer_list;
+	};
+
+	Expected compression returns the expected ratio between the amount of
+	data sent to this plugin and the amount of data it passes to the next
+	plugin. The value is used by the core code to calculate the amount of
+	space required to write the image. If the ratio is not achieved, the
+	writer will complain when it runs out of space with data still to
+	write, and the core code will abort the suspend.
+
+	transformer_list links together page transformers, in the order in
+	which they register, which is in turn determined by order in the
+	Makefile.
+	
+	There are many more operations specific to a writer:
+
+	struct swsusp_writer_ops {
+
+		long (*storage_available) (void);
+	
+		unsigned long (*storage_allocated) (void);
+		
+		int (*release_storage) (void);
+
+		long (*allocate_header_space) (unsigned long space_requested);
+		int (*allocate_storage) (unsigned long space_requested);
+
+		int (*write_header_init) (void);
+		int (*write_header_chunk) (char * buffer_start, int buffer_size);
+		int (*write_header_cleanup) (void);
+
+		int (*read_header_init) (void);
+		int (*read_header_chunk) (char * buffer_start, int buffer_size);
+		int (*read_header_cleanup) (void);
+
+		int (*prepare_save) (void);
+		int (*post_load) (void);
+
+		int (*parse_image_location) (char * buffer);
+
+		int (*image_exists) (void);
+
+		int (*invalidate_image) (void);
+
+		int (*wait_on_io) (int flush_all);
+
+		struct list_head writer_list;
+	};
+
+	STORAGE_AVAILABLE is 
diff -ruNp 550-documentation.patch-old/Documentation/power/suspend2.txt 550-documentation.patch-new/Documentation/power/suspend2.txt
--- 550-documentation.patch-old/Documentation/power/suspend2.txt	1970-01-01 10:00:00.000000000 +1000
+++ 550-documentation.patch-new/Documentation/power/suspend2.txt	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,631 @@
+	--- Suspend2, version 2.1.9 ---
+
+1.  What is it?
+2.  Why would you want it?
+3.  What do you need to use it?
+4.  How do you use it?
+5.  What do all those entries in /proc/software_suspend do?
+6.  How do you get support?
+7.  I think I've found a bug. What should I do?
+8.  When will XXX be supported?
+9.  How does it work?
+10. Who wrote Suspend2?
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
+   Suspend2 works with SMP, Highmem, preemption, x86-32, PPC and mac.
+   x86-64 support is coming.
+
+   Suspend2 patches are available from http://suspend2.net.
+
+   ii) Compression and encryption support.
+
+   As of 2.1.9.2, compression and encryption support are implemented via the
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
+   As of 2.1.8.5, Suspend2 includes a 'filewriter'. The filewriter can store
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
+   echo Suspend2 > /suspend-file
+   dd if=/dev/zero bs=1M count=512 >> suspend-file
+
+   This will create a 512MB file called /suspend-file. To get Suspend2 to use
+   it:
+
+   echo /suspend-file > /proc/software_suspend/filewriter_target
+
+   Then
+
+   cat /proc/software_suspend/resume2
+
+   Put the results of this into your bootloader's configuration (see also step
+   C, below:
+
+   ---EXAMPLE-ONLY-DON'T-COPY-AND-PASTE---
+   # cat /proc/software_suspend/resume2
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
+   cat /proc/software_suspend/header_locations
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
+   /proc/software_suspend/header_locations for a new resume_block value.
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
+4. How do you use it?
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
+5. What do all those entries in /proc/software_suspend do?
+
+   /proc/software_suspend is the directory which contains files you can use to
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
+   - all_settings:
+
+   This file provides a convenient way to save and restore all of the other
+   settings in one hit. The contents include binary data, so you'll want to
+   redirect the output to a file:
+
+   cat /proc/software_suspend/all_settings > /etc/hibernate/all_settings.conf
+
+   cat /etc/hibernate/all_settings.conf > /proc/software_suspend/all_settings
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
+   - header_locations:
+
+   This option tells you the resume2= options to use for swap devices you
+   currently have activated. It is particularly useful when you only want to
+   use a swap file to store your image. See above for further details.
+
+   - image_exists:
+
+   Can be used in a script to determine whether a valid image exists at the
+   location currently pointed to by resume2=.  Echoing anything to this entry
+   removes any current image.
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
+   incremented whenever an entry in /proc/software_suspend is obsoleted or 
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
+   3: Attempt to enter Suspend-to-ram.
+   4: Attempt to enter ACPI S4 mode.
+   5: Normal power down.
+
+   Note that these options are highly dependant upon your hardware & software.
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
+   echo /dev/hda2 > /proc/software_suspend/swapfile
+
+   /dev/hda2 would then be automatically swapon'd and swapoff'd. Note that the
+   swapon and swapoff occur while other processes are frozen (including kswapd)
+   so this swap file will not be used up when attempting to free memory. The
+   parition/file is also given the highest priority, so other swapfiles/partitions
+   will only be used to save the image when this one is filled.
+
+   The value of this file is used by header_locations along with any currently
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
+6. How do you get support?
+
+   Glad you asked. Suspend2 is being actively maintained and supported
+   by Nigel (the guy doing most of the kernel coding at the moment), Bernard
+   (who maintains the hibernate script and userspace user interface components)
+   and its users.
+
+   Resources availble include HowTos, FAQs and a Wiki, all available via
+   suspend2.net.  You can find the mailing lists there.
+
+7. I think I've found a bug. What should I do?
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
+8. When will XXX be supported?
+
+   Suspend2 currently lacks support for x86-64. It is work in progress, but
+   hasn't been made a great priority because debugging is difficult (Nigel
+   doesn't have access to the hardware). 64GB Highmem and discontig-mem are
+   also not supported at the moment.
+
+   Patches for the other items (and anything that's been missed) are welcome. 
+   Please send to the list.
+
+9. How does it work?
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
+10. Who wrote Suspend2?
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
diff -ruNp 550-documentation.patch-old/Documentation/power/todo.txt 550-documentation.patch-new/Documentation/power/todo.txt
--- 550-documentation.patch-old/Documentation/power/todo.txt	1970-01-01 10:00:00.000000000 +1000
+++ 550-documentation.patch-new/Documentation/power/todo.txt	2005-07-05 23:44:36.000000000 +1000
@@ -0,0 +1,12 @@
+Suspend2 todo list
+
+20050705
+  2.1.9.8 known issues:
+  ----------------
+- NFS support missing
+- DRI support for 2.4 & 2.6
+- USB support under 2.4 and 2.6
+- Incomplete support in other drivers
+- No support for discontig memory
+- Currently requires PSE extension (/proc/cpuinfo)
+- Highmem >4GB not supported

