Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263957AbRFMBHx>; Tue, 12 Jun 2001 21:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264124AbRFMBHo>; Tue, 12 Jun 2001 21:07:44 -0400
Received: from krynn.axis.se ([193.13.178.10]:18341 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S263957AbRFMBHf>;
	Tue, 12 Jun 2001 21:07:35 -0400
Date: Wed, 13 Jun 2001 03:07:21 +0200
Message-Id: <200106130107.DAA32493@ignucius.axis.se>
From: Hans-Peter Nilsson <hans-peter.nilsson@axis.com>
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: [PATCH] General race condition with init thread may prematurely free start_kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC replies to me, I'm not subscribed to lkml.)

I think I've found a bug, local to linux/init/main.c, related to
freeing init pages, which seems to be present in 2.4.5.

Executive summary: After start_kernel has created the init
thread, it needs to proceed to cpu_idle before init pages are
free:d, since it's __init-marked.  But if the init thread is
scheduled to run before the parent thread, and in turn its call
to do_basic_setup returns quickly, start_kernel will be
free_initmem:d before that thread has proceeded to cpu_idle.
Boom.  Patch at end.

Somewhat lengthier description and analysis: I found this out
the hard way when fixing free_initmem (and the linker script) in
Linux/CRIS.  In linux/init/main.c it looks as follows at a
conceptual level:

void __init start_kernel()
{
  foo_init();
  blah_init();
  ...
  kernel_thread (init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
  current->need_resched = 1;
  cpu_idle();
}

Correspondingly, the function init looks as follows:

static int init(void * unused)
{
	do_basic_setup();
	free_initmem();

        ... start up /bin/init or whatever ...
}

And do_basic_setup looks like this:

static void __init do_basic_setup(void)
{
    baz_init ();
    ... more *_init() calls ...

    ... mount root fs ...
}

If nothing in do_basic_setup causes rescheduling, it might
(depending on e.g. timing) return before the parent has
proceeded to call cpu_idle, from which it never returns.  If so,
free_initmem will be called, freeing among others start_kernel.
Later, when the parent thread is scheduled to run and returns
from the kernel_thread call, it will execute in unmapped memory.
Bad: will crash, perhaps depending on that memory being recycled
and modified.

Normally, mounting the root fs involves mechanical disks or
network activity or other stuff that causes I/O or takes time.
Then rescheduling will cause the parent thread to resume to
safety before do_basic_setup returns.  You're most likely to see
the race problem on platforms with a solid-state root fs.

Analysis sanity-checked with bjornw@axis.com.  Repeatable on an
"Axis Developer Board LX" (with patches to fix the linker script
and remove the #if 0:s from linux/arch/cris/mm/init.c; contact
me if you actually need to do this).

One solution is to break out the last piece of start_kernel to a
non-__init function as follows.  The patch is against 2.4.5.

2001-06-12  Hans-Peter Nilsson  <hp@axis.com>

	* linux/init/main.c (rest_init): New, broken out from start_kernel.

--- linux/init/main.c.original	Tue May 22 18:35:42 2001
+++ linux/init/main.c	Wed Jun 13 01:20:54 2001
@@ -502,6 +502,21 @@ static void __init smp_init(void)
 #endif
 
 /*
+ * We need to finalize in a non-__init function or else race conditions
+ * between the root thread and the init thread may cause start_kernel to
+ * be reaped by free_initmem before the root thread has proceeded to
+ * cpu_idle.
+ */
+
+static void rest_init(void)
+{
+	kernel_thread(init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+	unlock_kernel();
+	current->need_resched = 1;
+ 	cpu_idle();
+} 
+
+/*
  *	Activate the first processor.
  */
  
@@ -583,10 +598,7 @@ asmlinkage void __init start_kernel(void
 	 *	make syscalls (and thus be locked).
 	 */
 	smp_init();
-	kernel_thread(init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
-	unlock_kernel();
-	current->need_resched = 1;
- 	cpu_idle();
+	rest_init();
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD

brgds, H-P
