Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWFZQqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWFZQqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWFZQqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:46:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20679 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750805AbWFZQpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:45:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 3/4] [Suspend2] Suspend2 internals document.
Date: Tue, 27 Jun 2006 02:45:58 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164556.10591.27696.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164547.10591.32821.stgit@nigel.suspend2.net>
References: <20060626164547.10591.32821.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Documentation/power/internals.txt, describing how suspend2 works.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 Documentation/power/internals.txt |  362 +++++++++++++++++++++++++++++++++++++
 1 files changed, 362 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/internals.txt b/Documentation/power/internals.txt
new file mode 100644
index 0000000..424cab0
--- /dev/null
+++ b/Documentation/power/internals.txt
@@ -0,0 +1,362 @@
+		Software Suspend 2.2 Internal Documentation.
+				Version 1
+
+1.  Introduction.
+
+    Software Suspend 2.2 is an addition to the Linux Kernel, designed to
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
+    Inconsistencies in the image will result in inconsistent memory contents at
+    resume time, and thus in instability of the system and/or file system
+    corruption. This would appear to imply a maximum image size of one half of
+    the amount of RAM, but we have a solution... (again, below).
+
+    o In 2.6, we choose to play nicely with the other suspend-to-disk
+    implementations.
+
+3.  Detailed description of internals.
+
+    a. Quiescing activity.
+
+    Safely quiescing the system is achieved using two methods.
+
+    First, we note that the vast majority of processes don't need to run during
+    suspend. They can be 'frozen'. We therefore implement a refrigerator
+    routine, which processes enter and in which they remain until the cycle is
+    complete. Processes enter the refrigerator via try_to_freeze() invocations
+    at appropriate places.  A process cannot be frozen in any old place. It
+    must not be holding locks that will be needed for writing the image or
+    freezing other processes. For this reason, userspace processes generally
+    enter the refrigerator via the signal handling code, and kernel threads at
+    the place in their event loops where they drop locks and yield to other
+    processes or sleep.
+
+    The second part of our method for quisescing the system involves freezing
+    the filesystems. We use the standard freeze_bdev and thaw_bdev functions to
+    ensure that all of the user's data is synced to disk before we begin to
+    write the image.
+
+    Quiescing the system works most quickly and reliably when we add one more
+    element to the algorithm: separating the freezing of userspace processes
+    from the freezing of kernel space processes, and doing the filesystem freeze
+    in between. The filesystem freeze needs to be done while kernel threads such
+    as kjournald can still run.At the same time, though, everything will be less
+    racy and run more quickly if we stop userspace submitting more I/O work
+    while we're trying to quiesce.
+
+    Quiescing the system is therefore done in three steps:
+	- Freeze userspace
+	- Freeze filesystems
+	- Freeze kernel threads
+
+    If we need to free memory, we thaw kernel threads and filesystems, but not
+    userspace. We can then free caches without worrying about deadlocks due to
+    swap files being on frozen filesystems or such like.
+
+    b. Ensure enough memory & storage are available.
+
+    We have a number of constraints to meet to be able to successfully suspend
+    and resume.
+
+    First, the image will be written in two parts, described below. One of these
+    parts needs to have an atomic copy made, which of course implies a maximum
+    size of one half of the amount of system memory. The other part ('pageset')
+    is not atomically copied, and can therefore be as large or small as desired.
+
+    Second, we have constraints on the amount of storage available. In these
+    calculations, we may also consider any compression that will be done. The
+    cryptoapi module allows the user to configure an expected compression ratio.
+   
+    Third, the user can specify an arbitrary limit on the image size, in
+    megabytes. This limit is treated as a soft limit, so that we don't fail the
+    attempt to suspend if we cannot meet this constraint.
+
+    c. Allocate the required memory and storage space.
+
+    Having done the initial freeze, we determine whether the above constraints
+    are met, and seek to allocate the metadata for the image. If the constraints
+    are not met, or we fail to allocate the required space for the metadata, we
+    seek to free the amount of memory that we calculate is needed and try again.
+    We allow up to four iterations of this loop before aborting the cycle. If we
+    do fail, it should only be because of a bug in Suspend's calculations.
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
+    pages, the swapwriter module carefully ensures that the work of writing
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
+    Suspend2 contains an internal API which is designed to simplify the
+    implementation of new methods of transforming the image to be written and
+    writing the image itself. In early versions of Suspend2, compression support
+    was inlined in the image writing code, and the data structures and code for
+    managing swap were intertwined with the rest of the code. A number of people
+    had expressed interest in implementing image encryption, and alternative
+    methods of storing the image. This internal API makes that possible by
+    implementing 'modules'.
+
+    A module is a single file which encapsulates the functionality needed
+    to transform a pageset of data (encryption or compression, for example),
+    or to write the pageset to a device. The former type of module is called
+    a 'page-transformer', the later a 'writer'.
+
+    Modules are linked together in pipeline fashion. There may be zero or more
+    page transformers in a pipeline, and there is always exactly one writer.
+    The pipeline follows this pattern:
+
+		---------------------------------
+		|          Suspend2 Core        |
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
+    to the first module. This module performs whatever transformations it
+    implements on the incoming data, completely consuming the incoming data and
+    feeding output in a similar manner to the next module. A module may buffer
+    its output.
+
+    During reading, the pipeline works in the reverse direction. The core code
+    calls the first module with the address of a buffer which should be filled.
+    (Note that the buffer size is always PAGE_SIZE at this time). This module
+    will in turn request data from the next module and so on down until the
+    writer is made to read from the stored image.
+
+    Part of definition of the structure of a module thus looks like this:
+
+        int (*rw_init) (int rw, int stream_number);
+        int (*rw_cleanup) (int rw);
+        int (*write_chunk) (struct page *buffer_page);
+        int (*read_chunk) (struct page *buffer_page, int sync);
+
+    It should be noted that the _cleanup routine may be called before the
+    full stream of data has been read or written. While writing the image,
+    the user may (depending upon settings) choose to abort suspending, and
+    if we are in the midst of writing the last portion of the image, a portion
+    of the second pageset may be reread.
+
+    In addition to the above routines for writing the data, all modules have a
+    number of other routines:
+
+    TYPE indicates whether the module is a page transformer or a writer.
+    #define TRANSFORMER_MODULE 1
+    #define WRITER_MODULE 2
+
+    NAME is the name of the module, used in generic messages.
+
+    MODULE_LIST is used to link the module into the list of all modules.
+
+    MEMORY_NEEDED returns the number of pages of memory required by the module
+    to do its work.
+
+    STORAGE_NEEDED returns the number of pages in the suspend header required
+    to store the module's configuration data.
+
+    PRINT_DEBUG_INFO fills a buffer with information to be displayed about the
+    operation or settings of the module.
+
+    SAVE_CONFIG_INFO returns a buffer of PAGE_SIZE or smaller (the size is the
+    return code), containing the module's configuration info. This information
+    will be written in the image header and restored at resume time. Since this
+    buffer is allocated after the atomic copy of the kernel is made, you don't
+    need to worry about the buffer being freed.
+
+    LOAD_CONFIG_INFO gives the module a pointer to the the configuration info
+    which was saved during suspending. Once again, the module doesn't need to
+    worry about freeing the buffer. The kernel will be overwritten with the
+    original kernel, so no memory leak will occur.
+
+    OPS contains the operations specific to transformers and writers. These are
+    described below.
+
+    The complete definition of struct suspend_module_ops is:
+
+	struct suspend_module_ops {
+	        /* Functions common to all modules */
+	        int type;
+	        char *name;
+	        struct module *module;
+	        int disabled;
+	        struct list_head module_list;
+
+	        /* List of filters or writers */
+	        struct list_head list, type_list;
+
+	        /*
+	         * Requirements for memory and storage in
+	         * the image header..
+	         */
+	        unsigned long (*memory_needed) (void);
+	        unsigned long (*storage_needed) (void);
+
+	        /*
+	         * Debug info
+	         */
+	        int (*print_debug_info) (char *buffer, int size);
+	        int (*save_config_info) (char *buffer);
+	        void (*load_config_info) (char *buffer, int len);
+
+	        /*
+	         * Initialise & cleanup - general routines called
+	         * at the start and end of a cycle.
+	         */
+	        int (*initialise) (int starting_cycle);
+	        void (*cleanup) (int finishing_cycle);
+
+	        /*
+	         * Calls for allocating storage (writers only).
+	         *
+	         * Header space is allocated separately. Note that allocation
+	         * of space for the header might result in allocated space
+	         * being stolen from the main pool if there is no unallocated
+	         * space. We have to be able to allocate enough space for
+	         * the header. We can eat memory to ensure there is enough
+	         * for the main pool.
+	         */
+
+	        int (*storage_available) (void);
+	        int (*allocate_header_space) (int space_requested);
+	        int (*allocate_storage) (int space_requested);
+	        int (*storage_allocated) (void);
+	        int (*release_storage) (void);
+
+	        /*
+	         * Routines used in image I/O.
+	         */
+	        int (*rw_init) (int rw, int stream_number);
+	        int (*rw_cleanup) (int rw);
+	        int (*write_chunk) (struct page *buffer_page);
+	        int (*read_chunk) (struct page *buffer_page, int sync);
+
+	        /* Reset module if image exists but reading aborted */
+	        void (*noresume_reset) (void);
+
+	        /* Read and write the metadata */
+	        int (*write_header_init) (void);
+	        int (*write_header_cleanup) (void);
+
+	        int (*read_header_init) (void);
+	        int (*read_header_cleanup) (void);
+
+	        int (*rw_header_chunk) (int rw, char *buffer_start, int buffer_size);
+
+	        /* Attempt to parse an image location */
+	        int (*parse_sig_location) (char *buffer, int only_writer);
+
+	        /* Determine whether image exists that we can restore */
+	        int (*image_exists) (void);
+
+	        /* Mark the image as having tried to resume */
+	        void (*mark_resume_attempted) (void);
+
+	        /* Destroy image if one exists */
+	        int (*invalidate_image) (void);
+	};
+
+
+	Expected compression returns the expected ratio between the amount of
+	data sent to this module and the amount of data it passes to the next
+	module. The value is used by the core code to calculate the amount of
+	space required to write the image. If the ratio is not achieved, the
+	writer will complain when it runs out of space with data still to
+	write, and the core code will abort the suspend.
+
+	transformer_list links together page transformers, in the order in
+	which they register, which is in turn determined by order in the
+	Makefile.

--
Nigel Cunningham		nigel at suspend2 dot net
