Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUCVAba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUCVAb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:31:29 -0500
Received: from gprs212-229.eurotel.cz ([160.218.212.229]:28290 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261551AbUCVAad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:30:33 -0500
Date: Mon, 22 Mar 2004 01:29:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Cc: benh@kernel.crashing.org
Subject: Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040322002934.GA15017@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040318193703.4c02f7f5.akpm@osdl.org> <1079661410.15557.38.camel@calvin.wpcb.org.au> <20040318200513.287ebcf0.akpm@osdl.org> <1079664318.15559.41.camel@calvin.wpcb.org.au> <20040321220050.GA14433@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321220050.GA14433@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Andrew killed from Cc, he's probably not too interested in
swsusp-only issues. Benjamin added, to remind he what he wanted in
kernel ;-)

> [I'll have to look at new files, too...]

+struct rangechain {
+       struct range * first;
+       struct range * last;
+       int size; /* size of the range ie sum (max-min+1) */
+       int allocs;
+       int frees;
+       int debug;
+       int timesusedoptimisation;
+       char * name;
+       struct range * lastaccessed, *prevtolastaccessed, *prevtoprev;
+};
+

You need some more '_'s in there (like last_accessed), and do nut put
space between * and symbol.

+struct suspend_header {
+       __u32 version_code;

It can be u32 (unless this header is included from userland).

+#define MDELAY(a)      if (TEST_ACTION_STATE(SUSPEND_SLOW)) { mdelay(a); } else { do { } while (0); }

Ouch, this is not the way to do it. You need do...while around if. It
is useless inside {}s.

+#define beepOK \
+       if (TEST_ACTION_STATE(SUSPEND_BEEP)) { \
+               currentbeep += 200; \
+               kd_mksound(currentbeep,HZ/8); \
+               mdelay(150); \
+       } else { \
+               do { } while (0); \
+       }
+#define beepERR \
+       if (TEST_ACTION_STATE(SUSPEND_BEEP)) { \
+               kd_mksound(300,HZ/4); \
+               mdelay(300); \
+       } else { \
+               do { } while (0); \
+       }

Is this really usefull to someone? Again useless while(0)s.

+struct swsusp_proc_data {
+       char * filename;
+       int permissions;
+       int type;
+       union {
+               struct {
+                       unsigned long * bit_vector;
+                       int bit;
+               } bit;
+               struct {
+                       int * variable;
+                       int minimum;
+                       int maximum;
+               } integer;
+               struct {
+                       unsigned long * variable;
+                       unsigned long minimum;
+                       unsigned long maximum;
+               } ul;
+               struct {
+                       char * variable;
+                       int max_length;
+                       int (* write_proc) (void); /* Routine
triggered by write after new value stored */
+               } string;
+               struct {
+                       void * read_proc;
+                       void * write_proc;
+                       void * data;
+               } special;
+       } data;
+       struct list_head proc_data_list;
+};
+
+#define SWSUSP_PROC_DATA_CUSTOM                0
+#define SWSUSP_PROC_DATA_BIT           1
+#define SWSUSP_PROC_DATA_INTEGER       2
+#define SWSUSP_PROC_DATA_UL            3
+#define SWSUSP_PROC_DATA_STRING                4

Your own abstraction on top of /proc? I do not think we need any
runtime configurability.

+#ifdef CONFIG_SOFTWARE_SUSPEND_RELAXED_PROC
+#define PROC_WRITEONLY 0222
+#define PROC_READONLY 0444
+#define PROC_RW 0666
+#else
+#define PROC_WRITEONLY 0200
+#define PROC_READONLY 0400
+#define PROC_RW 0600
+#endif

..and we do certainly not want CONFIG_SECURITY_HOLE.

#define MDELAY and friends seems to be in _two_ different header
files.

+struct swsusp_plugin_ops gzip_compression_ops = {
+       .type                   = FILTER_PLUGIN,
+       .name                   = "Zlib Page Compressor",
+       .memory_needed          = gzip_memory_needed,
+       .print_debug_info       = gzip_print_debug_stats,
+       .save_config_info       = gzip_save_config_info,
+       .load_config_info       = gzip_load_config_info,
+       .write_init             = gzip_write_init,
+       .write_chunk            = gzip_write_chunk,
+       .write_cleanup          = gzip_write_cleanup,
+       .read_init              = gzip_read_init,
+       .read_chunk             = gzip_read_chunk,
+       .read_cleanup           = gzip_read_cleanup,
+       .ops = {
+               .filter = {
+                       .expected_compression =
gzip_get_expected_compression,
+               }
+       }

+/* gzip_save_config_info
+ *
+ * Description:        Save informaton needed when reloading the image at resume time.
                             ~~~~~~~~~~
				typo
+ * Arguments:  Buffer:         Pointer to a buffer of size PAGE_SIZE.
+ * Returns:    Number of bytes used for saving our data.
+ */

+static void gzip_load_config_info(char * buffer, int size)
+{
+       if (size != 2 * sizeof(unsigned long)) {
+               printk("Huh? Size of plugin data is not right. (%d
instead of %d).\n",
+                       size, 2 * sizeof(unsigned long));
+               return;
+       }

BUG_ON? Otherwise, what about returing failure back to original code?

+++ software-suspend-core-2.0/kernel/power/Internals    2004-01-30
17:22:58.000000000 +1300
@@ -0,0 +1,364 @@
+               Software Suspend 2.0 Internal Documentation.
+                               Version 1
+

Internal or not, documentation should go under Documentation, I
believe.

+    o We need to get as close as we can to an atomic copy of the
data.

We need to get "as close"? I hope it really _is_ atomic.

+    In 2.4, the dosexec thread (Win4Lin) is treated specially. It
does not
+    handle us even pretending to send it a signal. This is
worked-around by
+    us adjusting the can_schedule() macro in schedule.c to stop the
task from
+    being scheduled during suspend. Ugly, but it works. The 2.6
version of
+    Win4Lin has been made compatible.

Aha, so dosexec is some binary module, not userland program. Sorry for
my previous comment.

+    Writing the image requires memory, of course, and at this point we have
+    also not yet suspended the drivers. To avoid the possibility of remaining
+    activity corrupting the image, we allocate a special memory pool. Calls
+    to __alloc_pages and __free_pages_ok are then diverted to use our memory
+    pool. Pages in the memory pool are saved as part of pageset1 regardless of
+    whether or not they are used.

This is pretty ugly.

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

Ugly... We have not only to not-sync, but avoid any writeback, or any
reading altogether, right? And writes might be done from memory
managment paths..

+               struct list_head writer_list;
+       };
+
+       STORAGE_AVAILABLE is
diff -ruN post-version-specific/kernel/power/io.c software-suspend-core-2.0/kernel/power/io.c
--- post-version-specific/kernel/power/io.c     1970-01-01 12:00:00.000000000 +1200

Eh? Documentation seems to end in the middle of the line.

+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+       sh->param2 = swsusp_debug_state;
+#endif

Try to avoid #ifdefs... This one really is not neccessary.

+/* TODO: Handle page protection when saving and loading pages. */

Can you elaborate?

+/* __read_primary_suspend_image
+ *
+ * Description:        Test for the existence of an image and attempt to load it.
+ * Returns:    Int. Zero if image found and pageset1 successfully loaded.
+ *             Error if no image found or loaded.
+ */

If you are doing so nice comments already, perhaps you should use linuxdoc?

+               case -EINVAL:   /* non fatal error */
+                       software_suspend_state &= ~3;
+                       MDELAY(1000);
+                       return error;
+                       break;

While break after error?

+/*
+ * Copyright (c) 2000-2002 Marc Alexander Lehmann <pcg@goof.com>
+ *
+ * Redistribution and use in source and binary forms, with or without modifica-
+ * tion, are permitted provided that the following conditions are met:
+ *
+ *   1.  Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *
+ *   2.  Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *
+ *   3.  The name of the author may not be used to endorse or promote products
+ *       derived from this software without specific prior written permission.

lzf compression should go under /lib, not under kernel/power, and
probably should go in separately.

This looks like BSD with advertising clause. I do not think you are
allowed to link this with kernel. It does not follow kernel coding style.

+static unsigned long lzf_memory_needed(void)
+{
+       if (DISABLED)
+               return 0;
+
+       return PAGE_SIZE * 2 + (1<<HLOG)*sizeof(char *);
+}

Perhaps disabling of plugins should be done on other level, so that if
(DISABLED) is not needed at begining of each function?

+static __init int lzf_load(void)
+{
+       int result;
+
+       printk("Software Suspend LZF Compression Driver v1.0\n");
+       if (!(result = swsusp_register_plugin(&lzf_compression_ops))) {
+               swsusp_register_procfile(&expected_compression_proc_data);
+               swsusp_register_procfile(&disable_compression_proc_data);
+       }
+       return result;
+}
+
+__initcall(lzf_load);

Hmm, so yes, you add your own abstraction on the top of /proc. Ouch.
And what about module unload? [Anyway __initcall() should probably be
module_init()].

swsusp2 not only has its own /proc abstraction and plugin system, it
also has its own memory alocator :-((((.

+/*
+ * workspace_size
+ *
+ * Description:
+ * Returns the number of bytes of RAM needed for this
+ * code to do its work. (Used when calculating whether
+ * we have enough memory to be able to suspend & resume).
+ *
+ */
+static unsigned long nullwriter_memory_needed(void)

Is it workspace_size or memory_needed? (null example driver).

collision_cache... is that attempt to speed up suspending, that is
making it more complicated?

+char* origrangesname = "original addresses";
+char* destrangesname = "destination addresses";
+char* allocdrangesname = "allocated addresses";
+
+/* set_chain_names
+ *
+ * Description:        Set the chain names for a pagedir. (For debugging).
+ * Arguments:  struct pagedir: The pagedir on which we want to set the names.
+ */
+
+void set_chain_names(struct pagedir * p)
+{
+       p->origranges.name = origrangesname;
+       p->destranges.name = destrangesname;
+       p->allocdranges.name = allocdrangesname;
+}

Why not simply p->origranges.name = "original addresses"?

+       int alternative_order = 999;

Why not 666? :-).

+       /* Get a single grabbed page for swsusp's use */
+       /* We only look at pages of the desired order */
+       /* Code could be added to split a higher order) */

Missing (.

+#define MAX_ATTEMPTS 3
+extern int freeze_processes(int no_progress);
+
+static int attempt_to_freeze(void)

Why are you doing 3 attempts? I thought this should work...

+ * Versions:
+ * 1: /proc/sys/kernel/swsusp the only tuning interface
+ * 2: Initial version of this file
+ * 3: Removed KDB parameter.
+ *    Added checkpage parameter (for checking checksum of a page over time).

No changelogs at beginings of files, if possible... ... aha, that's
exported to userland? You are seriously overdesigning this.

+ * Another complicating factor is that freeing memory requires the processes
+ * to not be frozen, but at the end of freeing memory, they need to be frozen
+ * so that we can be sure we actually have eaten enough memory. This is why
+ * freezing and freeing are in the one file. The freezer is not called from
+ * the main logic, but indirectly, via the code for eating memory. The eat
+ * memory logic is iterative, first freezing processes and checking the stats,
+ * then (if necessary) unfreezing them and eating more memory until it looks
+ * like the criteria are met (at which point processes are frozen & stats
+ * checked again).

What if processes eat all the memory you freed just after unfreezing?
This could result in livelock...

+       do { } while (sync_buffers(NODEV, 1));
+       do { } while (fsync_dev(NODEV));

You can kill 'do { }'...

+/**
+ *     register_resume_notifier - Register function to be called at resume time
+ *     @nb: Info about notifier function to be called
+ *
+ *     Registers a function with the list of functions
+ *     to be called at resume time.
+ *
+ *     Currently always returns zero, as notifier_chain_register
+ *     always returns zero.
+ */

So you do know how to use linuxdoc, good. What is resume notifier good
for when we have driver model?

+++ software-suspend-core-2.0/kernel/power/range.c      2004-01-30 17:22:58.000000000 +1300
@@ -0,0 +1,845 @@
+/* pm_disk routines for manipulating ranges.
+ *
+ * (C) 2003, Nigel Cunningham.
+ *

pm_disk? And this needs GPL.

Ranges... nice trick to make it use slightly less memory, but it seems
pretty complex. You are using linklist of extents, anyway; why not
simplify it with linklist of pages?

+       if (!range) {
+               printk("Error! put_range called with NULL range.\n");
+               return;

BUG_ON? No, just kill the test, it will oops cleanly, anyway.

+       do { } while (!IS_ERR(ioinfo_cleanup_one()));

kill do { }.

+/*
+ *
+ */
+
+int parse_signature(char * header, int restore)

?

Why are you trying to parse signatures for pmdisk/swsusp1? 13
signatures is certainly impressive..

+               if (thisdevice == resume_device) {
+                       printnolog(SUSPEND_IO, SUSPEND_VERBOSE, 0, "Resume root device %x", thisdevice);
+                       RESUME_BDEV(i) = resume_block_device;
+                       continue;
+               }
+
+               if (thisdevice == header_device) {
+                       printnolog(SUSPEND_IO, SUSPEND_VERBOSE, 0, "Resume header device %x", thisdevice);
+                       RESUME_BDEV(i) = header_block_device;
+                       continue;
+               }

It uses multiple devices for suspend? Hm, I never managed to do
that...

+       while ((*thischar != ':') && ((thischar - commandline) < 250) && (*thischar))
+               thischar++;
+
+       if (*thischar == ':') {
+               colon = thischar;
+               *colon = 0;
+               thischar++;
+       }
+
+       while ((*thischar != '@') && ((thischar - commandline) < 250)
&& (*thischar))
+               thischar++;


strchr()?

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+/* Make disk drivers accept operations, again */
+void storage_unsuspend(void)
+{
+#ifdef CONFIG_SCSI
+       struct pm_dev *dev = NULL;
+
+       while ((dev = pm_find(PM_SCSI_DEV, dev)))
+               pm_send(dev, PM_RESUME, (void *) 0);
+
+#endif
+#ifdef CONFIG_BLK_DEV_IDE
+       ide_disk_unsuspend(0);
+#endif
+}
+
+void storage_suspend(void)
+{
+#ifdef CONFIG_SCSI
+       struct pm_dev *dev = NULL;
+
+       while ((dev = pm_find(PM_SCSI_DEV, dev)))
+               pm_send(dev, PM_SUSPEND, (void *) 3);
+
+#endif
+#ifdef CONFIG_BLK_DEV_IDE
+       do_suspend_sync();
+
+       ide_disk_suspend();
+#endif
+}
+#endif

This should not be needed in 2.6...

+#define RESUME_PHASE1 1 /* Called from interrupts disabled */
+#define RESUME_PHASE2 2 /* Called with interrupts enabled */
+#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
+
+void drivers_resume(int flags)
+{
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+       if(flags & RESUME_PHASE2) {
+#ifdef CONFIG_BLK_DEV_HD
+               do_reset_hd();                  /* Kill all controller
state */
+#endif
+       }
+       if (flags & RESUME_PHASE1) {
+#ifdef CONFIG_BLK_DEV_IDE
+               ide_disk_unsuspend(1);
+#endif
+#ifdef CONFIG_SCSI
+               {
+               struct pm_dev *dev = NULL;
+
+               while ((dev = pm_find(PM_SCSI_DEV, dev)))
+                       pm_send(dev, PM_RESUME, (void *) 0);
+               }
+#endif
+#ifdef CONFIG_BLK_DEV_MD
+               md_autostart_arrays();
+#endif
+       }

There were some problems with phases etc... I had to modify it, and it
became cleaner, too.

+int suspend_snprintf(char * buffer, int buffer_size, const char *fmt,
...)
+{

Ouch, own snprintf version?!

+       SNPRINTF("Please include the following information in bug reports:\n");
+       SNPRINTF("- SWSUSP core    : %s\n", swsusp_version);
+       SNPRINTF("- Kernel Version : %s\n", UTS_RELEASE);
+       SNPRINTF("- Version spec.  : %s\n", SWSUSP_VERSION_SPECIFIC_REVISION_STRING);
+       SNPRINTF("- Compiler vers. : %d.%d\n", __GNUC__,
__GNUC_MINOR__);

Could this be compressed into less lines/characters? Copying this by
hand is pretty tiring excersize.

+/* kstat_save
+ * Save the contents of the kstat array so that
+ * our labours are hidden from vmstat
+ */
+static int kstat_save(void)

What hack is this? You don't want load average to go up after resume?

+void start_kswsuspd(void * data)
+{
+       down(&kswsuspd_access);
+       init_completion(&work_complete);
+       work_data = data;
+       wake_up_interruptible(&swsusp_wait);
+       wait_for_completion(&work_complete);
+       up(&kswsuspd_access);
+}

swsusp1 gets away without new thread... As long as you don't use
sysrq-G, you are always called from process context. And that means
cleaner code....

+__setup("resume2=", resume_setup);
+__setup("swsusp_act=", swsusp_act_setup);
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+__setup("swsusp_dbg=", swsusp_dbg_setup);
+__setup("swsusp_lvl=", swsusp_lvl_setup);
+#endif
+__setup("noresume2", noresume_setup);

It should take over swsusp1 parameters. We do not want 3 different
mechanisms *in one running kernel*.

--- post-version-specific/kernel/power/ui.c     1970-01-01
12:00:00.000000000 +1200
+++ software-suspend-core-2.0/kernel/power/ui.c 2004-01-30
17:22:58.000000000 +1300
@@ -0,0 +1,1038 @@

...1000 lines of eye candies, with stuff like

+static void move_cursor_to(unsigned char * xy)
+{
+       char buf[10];
+
+       int len = suspend_snprintf(buf, 10, "\233%d;%dH", xy[1],
xy[0]);
+
+       cond_console_print(buf, len);
+}
+

Can we get rid of this?


+       if (TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+               prepare_status(1, 1, "--- ESCAPE PRESSED AGAIN :
TRYING HARDER TO ABORT ---");
+               show_state();
+               thaw_processes();

Will not this  corrupt data?

All in all, its ~12K lines of code (swsusp1 is ~2K). I guess its needs
to be way smaller to be suitable for merging.

								Pavel

-- When do you have a heart between your knees?  [Johanka's followup:
and *two* hearts?]
