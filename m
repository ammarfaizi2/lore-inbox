Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbUKXNwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUKXNwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUKXNup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:50:45 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:35479 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262703AbUKXNaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:30:21 -0500
Subject: Suspend 2 merge: 33/51: More documentation.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101297714.5805.320.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:59 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More documentation for suspend. The internals.txt file is still to be
completed (and a bit out of date, too!).

diff -ruN 821-docs-old/Documentation/power/internals.txt 821-docs-new/Documentation/power/internals.txt
--- 821-docs-old/Documentation/power/internals.txt	1970-01-01 10:00:00.000000000 +1000
+++ 821-docs-new/Documentation/power/internals.txt	2004-11-04 16:27:41.000000000 +1100
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
diff -ruN 821-docs-old/Documentation/power/todo.txt 821-docs-new/Documentation/power/todo.txt
--- 821-docs-old/Documentation/power/todo.txt	1970-01-01 10:00:00.000000000 +1000
+++ 821-docs-new/Documentation/power/todo.txt	2004-11-04 16:27:41.000000000 +1100
@@ -0,0 +1,19 @@
+Suspend2 todo list
+
+20041021
+  2.1 known issues:
+  ----------------
+- NFS support missing
+- Encryption support missing
+- DRI support for 2.4 & 2.6
+- USB support under 2.4 and 2.6
+- Incomplete support in other drivers
+- No support for discontig memory
+- Currently requires PSE extension (/proc/cpuinfo)
+- Highmem >4GB not supported
+
+20040107
+- Further cleaning up.
+
+20031216
+- Include progress-bar-granularity in all_settings.


