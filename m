Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265460AbTLHR3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbTLHR3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:29:21 -0500
Received: from intra.cyclades.com ([64.186.161.6]:42727 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265460AbTLHR3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:29:11 -0500
Date: Mon, 8 Dec 2003 15:15:48 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Peter Bergmann <bergmann.peter@gmx.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <nfedera@esesix.at>, <andrea@suse.de>,
       <riel@redhat.com>
Subject: Configurable OOM killer Re: old oom-vm for 2.4.32 (was oom killer
 in 2.4.23)
In-Reply-To: <16204.1070665738@www29.gmx.net>
Message-ID: <Pine.LNX.4.44.0312081512510.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Dec 2003, Peter Bergmann wrote:

> > > If anyone  is interested:
> > > Norbert Federa sent me this link for a "quick&dirty" patch he made 
> > > for 2.4.23-vanilla which rolls back the complete 2.4.22 vm including the
> > > old oom-killer  - without guarantee but it does work very well for me
> > ...
> > 
> > I suppose the oom killer is the only reason for you using .22 VM correct?
> > 
> > Or do you have any other reason for this?
> 
> No, you're right. The oom killer is the _only_reason. 
> I did not succeed in integrating the disabled oom_kill.c in 2.4.23.
> The only solution for me is applying Norbert's .22vm patch.

Hi,

The following patch makes OOM killer configurable (its the same as the 
other patches posted except its around CONFIG_OOM_KILLER).

I hope the Configure.help entry is clear enough.

Peter, can you please try this.

Comments are appreciated.


diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.24.orig/Documentation/Configure.help linux-2.4.24/Documentation/Configure.help
--- linux-2.4.24.orig/Documentation/Configure.help	2003-12-08 14:18:51.000000000 +0000
+++ linux-2.4.24/Documentation/Configure.help	2003-12-08 16:57:30.000000000 +0000
@@ -412,6 +412,20 @@
   Otherwise low memory pages are used as bounce buffers causing a
   degrade in performance.
 
+OOM killer support
+CONFIG_OOM_KILLER
+   This option selects the kernel behaviour during total out of memory
+   condition. 
+
+   The default behaviour is to, as soon as no freeable memory and no swap
+   space are available, kill the task which tries to allocate memory. 
+   The default behaviour is very reliable.
+
+   If you select this option, as soon as no freeable memory is available, 
+   the kernel will try to select the "best" task to be killed.
+
+   If unsure, say N.
+
 Normal floppy disk support
 CONFIG_BLK_DEV_FD
   If you want to use the floppy disk drive(s) of your PC under Linux,
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.24.orig/arch/i386/config.in linux-2.4.24/arch/i386/config.in
--- linux-2.4.24.orig/arch/i386/config.in	2003-12-08 14:15:26.000000000 +0000
+++ linux-2.4.24/arch/i386/config.in	2003-12-08 16:27:43.000000000 +0000
@@ -328,6 +328,7 @@
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+bool 'Select task to kill on out of memory condition' CONFIG_OOM_KILLER
 
 bool 'Power Management support' CONFIG_PM
 
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.24.orig/include/linux/sched.h linux-2.4.24/include/linux/sched.h
--- linux-2.4.24.orig/include/linux/sched.h	2003-12-08 14:16:11.000000000 +0000
+++ linux-2.4.24/include/linux/sched.h	2003-12-08 17:01:56.000000000 +0000
@@ -429,6 +429,7 @@
 #define PF_DUMPCORE	0x00000200	/* dumped core */
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
+#define PF_MEMDIE      0x00001000       /* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
 #define PF_FSTRANS	0x00008000	/* inside a filesystem transaction */
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.24.orig/mm/oom_kill.c linux-2.4.24/mm/oom_kill.c
--- linux-2.4.24.orig/mm/oom_kill.c	2003-12-08 14:18:51.000000000 +0000
+++ linux-2.4.24/mm/oom_kill.c	2003-12-08 15:49:56.000000000 +0000
@@ -21,8 +21,6 @@
 #include <linux/swapctl.h>
 #include <linux/timex.h>
 
-#if 0		/* Nothing in this file is used */
-
 /* #define DEBUG */
 
 /**
@@ -153,6 +151,7 @@
 	 * exit() and clear out its resources quickly...
 	 */
 	p->counter = 5 * HZ;
+	p->flags |= PF_MEMALLOC | PF_MEMDIE;
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
@@ -271,5 +270,3 @@
 out_unlock:
 	spin_unlock(&oom_lock);
 }
-
-#endif	/* Unused file */
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.24.orig/mm/page_alloc.c linux-2.4.24/mm/page_alloc.c
--- linux-2.4.24.orig/mm/page_alloc.c	2003-12-08 14:18:51.000000000 +0000
+++ linux-2.4.24/mm/page_alloc.c	2003-12-08 15:49:35.000000000 +0000
@@ -378,7 +378,8 @@
 
 	/* here we're in the low on memory slow path */
 
-	if (current->flags & PF_MEMALLOC && !in_interrupt()) {
+	if (((current->flags & PF_MEMALLOC) && !in_interrupt()) || 
+			(current->flags & (PF_MEMALLOC | PF_MEMDIE))) {
 		zone = zonelist->zones;
 		for (;;) {
 			zone_t *z = *(zone++);
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.24.orig/mm/vmscan.c linux-2.4.24/mm/vmscan.c
--- linux-2.4.24.orig/mm/vmscan.c	2003-12-08 14:18:51.000000000 +0000
+++ linux-2.4.24/mm/vmscan.c	2003-12-08 15:54:49.000000000 +0000
@@ -649,6 +649,9 @@
 				failed_swapout = !swap_out(classzone);
 		} while (--tries);
 
+#ifdef	CONFIG_OOM_KILLER
+	out_of_memory();
+#else
 	if (likely(current->pid != 1))
 		break;
 	if (!check_classzone_need_balance(classzone))
@@ -656,6 +659,7 @@
 
 	__set_current_state(TASK_RUNNING);
 	yield();
+#endif
 	}
 
 	return 0;

