Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUCUWCn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUCUWCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:02:43 -0500
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:20609 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261351AbUCUWCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:02:33 -0500
Date: Sun, 21 Mar 2004 23:00:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>
Subject: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040321220050.GA14433@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040318193703.4c02f7f5.akpm@osdl.org> <1079661410.15557.38.camel@calvin.wpcb.org.au> <20040318200513.287ebcf0.akpm@osdl.org> <1079664318.15559.41.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079664318.15559.41.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > But as the next guy up in the tree, you do get to say what you'll take
> > >  and what you won't :>
> > 
> > Yeah, but I have to see it first!
> 
> :> Ok. I'll start with a framework and flesh it out.

Now I have _proof_ that eye-candy is harmfull. What is see on screen is:

                 S U S P E N D    T O    D I S K

                                                              N
umber of free pages a[                              ]h! (285723 != 285754)
 (Press SPACE to continue)

The message I saw on screen is not in dmesg?! Don't tell me its /proc
configurable; it should not be there in the first place.

@@ -27,6 +27,9 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+#include <linux/suspend-common.h>
+#endif

 #include <asm/processor.h>
 #include <asm/system.h>

You should modify header files so that they can be always included.

 {
        if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
                ClearPageReserved(page);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+               ClearPageNosave(page);
+#endif
                set_bit(PG_highmem, &page->flags);
                set_page_count(page, 1);
                __free_page(page);
                totalhigh_pages++;
-       } else
+       } else {
                SetPageReserved(page);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+               SetPageNosave(page);
+#endif
+       }

Make it so that {Set,Clear}PageNosave macros are NOP w/o software
suspend, then kill the ifdef.

I picked up signal.c changes into my tree -- they look more correct
than what I have here.

--- clean.2.5/arch/ppc/kernel/signal.c  2004-02-05 01:53:57.000000000 +0100
+++ linux-mm/arch/ppc/kernel/signal.c   2004-03-21 20:21:41.000000000 +0100
...
        unsigned long frame, newsp;
        int signr, ret;

+       if (current->flags & PF_FREEZE) {
+               refrigerator(PF_FREEZE);
+               return 0;
+       }
+
        if (!oldset)
                oldset = &current->blocked;


But you probably need to check if signal_pending() here...

+++ linux-mm/drivers/acpi/sleep/proc.c  2004-03-21 20:21:41.000000000 +0100
@@ -1,7 +1,9 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
+#include <linux/sched.h>
 #include <linux/bcd.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>

 #include <acpi/acpi_bus.h>
...
@@ -61,6 +66,7 @@
        if (copy_from_user(str, buffer, count))
                return -EFAULT;

+
        /* Check for S4 bios request */
        if (!strcmp(str,"4b")) {
                error = acpi_suspend(4);

Try not to include blank lines. Also do not add includes. If your
ACTIVITY_XXX macros depend on sched.h / init.h, include them from
suspend.h.

Was it really neccessary to rename IOTHREAD to NOFREEZE? This way you
are changing all the users. OTOH you could submit patch to rename all
*now* and swsusp1 will continue working.

-       sync_inodes_sb(sb, 0);
-       DQUOT_SYNC(sb);
-       lock_super(sb);
-       if (sb->s_dirt && sb->s_op->write_super)
-               sb->s_op->write_super(sb);
-       unlock_super(sb);
-       if (sb->s_op->sync_fs)
-               sb->s_op->sync_fs(sb, 1);
-       sync_blockdev(sb->s_bdev);
-       sync_inodes_sb(sb, 1);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+       /* A safety net. During suspend, we might overwrite
+        * memory containing filesystem info. We don't then
+        * want to sync it to disk. */
+       if (likely(!(swsusp_state & FREEZE_UNREFRIGERATED)))
+#endif
+       {
+               sync_inodes_sb(sb, 0);

Can't you at least reverse the condition and put return there so that
you don't need to reindent the block? Also perhaps this should be
BUG_ON()? Noone should ever fall into safety net. Same in do_sync.

+++ linux-mm/include/asm-i386/mtrr.h    2004-03-21 20:21:42.000000000
+0100
@@ -106,4 +106,8 @@

 #endif

+/* Save and restore functions for Software Suspend */
+extern int *mtrr_suspend(void);
+extern void mtrr_resume(int *ptr);
+
 #endif  /*  _LINUX_MTRR_H  */

This should be done through driver model.

+++ linux-mm/kernel/module.c    2004-03-21 20:21:42.000000000 +0100
@@ -1870,6 +1870,33 @@
        return NULL;
 }

+#define MODLIST_SIZE 4096
+
+void print_module_list(void)
+{
+       static char modlist[MODLIST_SIZE];
+       struct module *mod;
+       int pos = 0;
+
+       list_for_each_entry(mod, &modules, list)
+               if (mod->name)
+                       pos += snprintf(modlist+pos,
MODLIST_SIZE-pos-1,
+                                       "%s ", mod->name);
+       printk("%s\n",modlist);
+}
+
+int print_module_list_to_buffer(char * buffer, int size)
+{
+       struct module *mod;
+       int pos = 0;
+
+       list_for_each_entry(mod, &modules, list)
+               if (mod->name)
+                       pos += snprintf(buffer+pos, size-pos-1,
+                                       "%s ", mod->name);
+       return pos;
+}
+

This is only for debugging, right? If we have to have this one, could
you at least make one use the other?

+#if 0
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+extern void ide_suspend(void);
+extern void ide_unsuspend(void);
+#endif
+#endif

Kill #if 0-ed code from there, also no LINUX_VERSION_CODE tests in
version for merging, please.

+static int processesfrozen = 0;

Missing "_" there...

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+       if (unlikely((swsusp_state & FREEZE_NEW_ACTIVITY) &&
+                    strcmp(current->comm, "dosexec") &&
+                    ((!(current->flags & PF_SYNCTHREAD)) ||
+                     (swsusp_state & FREEZE_UNREFRIGERATED))))
+#else

Uff, testing for name of userland program? That's quite an ugly hack,
even if you only need it for 2.4...

+       struct task_struct FOR_EACH_THREAD_TASK_STRUCTS;
...
+       suspend_relinquish_console();
+
+       suspend_task = 0;
+       swsusp_state = 0;
+       STORAGE_UNSUSPEND
+
+       /*
+        * Pause the other processors so we can safely
+        * change threads' flags
+        */
+

I'd call this macro abuse. Is it because 2.4 compatibility?

        if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
                if (unlikely(in_atomic())) {
-                       printk(KERN_ERR "bad: scheduling while
atomic!\n");
-                       dump_stack();
+                       if (likely(!(software_suspend_state &
SOFTWARE_SUSPEND_RUNNING))) {
+                               printk(KERN_ERR "bad: scheduling while
atomic!\n");
+                               dump_stack();
+                       }
                }
        }

Were you lazy or is there some reason why scheduling while atomic is
not bad for swsusp2?

@@ -484,6 +490,10 @@
  * Really, prep_compound_page() should be called from
__rmqueue_bulk().  But
  * we cheat by calling it from here, in the order > 0 path.  Saves a
branch
  * or two.
+ *
+ * While suspending, we don't use the pcp structure. It mucks up our
+ * accounting for all the pages and necessitates calling
drain_local_pages
+ * multiple times.
  */

 static struct page *buffered_rmqueue(struct zone *zone, int order,
int cold)

I believe I worked around this one by drain_local_pages(), which is
much less intrusive.

+/*
+ * Remove a single page from a list, if possible.
+ * This is split out so that Software Suspend can use it
+ * to shoot down cache pages added while suspending/resuming.
+ *
+ * Returns:
+ * 0: No page to work on (not an error).
+ * 1: Exited via free_it.
+ * 2: Exited via activate_locked.
+ * 3: Exited via keep.
  */
-static int
-shrink_list(struct list_head *page_list, unsigned int gfp_mask,
-               int *max_scan, int *nr_mapped)
+
+int __free_single_cache_page(struct page * page, unsigned int
gfp_mask)
 {
+       int may_enter_fs, referenced, ret=3;

Why do you need this one? It looks intrusive. If its really
neccessary (or it cleans up code), this one should be sent
separately.

[I'll have to look at new files, too...]
								Pavel
-- 
When do you have a heart between your knees?  [Johanka's followup:
and *two* hearts?]
