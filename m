Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270996AbRHOBiK>; Tue, 14 Aug 2001 21:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270994AbRHOBiB>; Tue, 14 Aug 2001 21:38:01 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:43527 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S270995AbRHOBhp>; Tue, 14 Aug 2001 21:37:45 -0400
Message-ID: <3B79D26E.CD912961@delusion.de>
Date: Wed, 15 Aug 2001 03:37:50 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac5
In-Reply-To: <20010814221556.A7704@lightning.swansea.linux.org.uk> <3B79B43D.B9350226@delusion.de> <3B79C3A9.52562F71@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Interesting that kpnpbiosd has a ppid of zero, whereas keventd, which
> is started a few statements later has a ppid of one.  hmmm..

[...]

> I bet this ancient reparent-kernel-thread-to-init patch fixes it.  It always
> does.

It does indeed. Nice work, Andrew - works like a charm. Formerly the kpnpbios
thread never exited, which is why the problem never showed, now it exits ok.
I've rediffed your patch against 2.4.8-ac5, because I was getting rejects -
in case Alan wants to apply it to his tree.

Regards,
Udo.

--- linux-vanilla/kernel/sched.c        Wed Aug 15 03:19:24 2001
+++ linux-2.4.8-ac/kernel/sched.c       Wed Aug 15 03:06:31 2001
@@ -35,6 +35,7 @@
 extern void timer_bh(void);
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
+extern struct task_struct *child_reaper;
 
 /*
  * scheduler variables
@@ -1227,32 +1228,53 @@
 /*
  *     Put all the gunge required to become a kernel thread without
  *     attached user resources in one place where it belongs.
+ *
+ *     Kernel 2.4.4-pre3, akpm: reparent the caller
+ *     to init and set the exit signal to SIGCHLD so the thread
+ *     will be properly reaped if it exits.
  */
 
 void daemonize(void)
 {
        struct fs_struct *fs;
-
+       struct task_struct *this_task = current;
 
        /*
         * If we were started as result of loading a module, close all of the
         * user space pages.  We don't need them, and if we didn't close them
         * they would be locked into memory.
         */
-       exit_mm(current);
+       exit_mm(this_task);
 
-       current->session = 1;
-       current->pgrp = 1;
+       this_task->session = 1;
+       this_task->pgrp = 1;
 
        /* Become as one with the init task */

-       exit_fs(current);       /* current->fs->count--; */
+       exit_fs(this_task);             /* this_task->fs->count--; */
        fs = init_task.fs;
-       current->fs = fs;
+       this_task->fs = fs;
        atomic_inc(&fs->count);
-       exit_files(current);
-       current->files = init_task.files;
-       atomic_inc(&current->files->count);
+       exit_files(this_task);          /* this_task->files->count-- */
+       this_task->files = init_task.files;
+       atomic_inc(&this_task->files->count);
+
+       write_lock_irq(&tasklist_lock);
+
+       /* Reparent to init */
+       REMOVE_LINKS(this_task);
+       this_task->p_pptr = child_reaper;
+       this_task->p_opptr = child_reaper;
+       SET_LINKS(this_task);
+
+       /* Set the exit signal to SIGCHLD so we signal init on exit */
+       if (this_task->exit_signal != 0) {
+               printk(KERN_ERR "task %s' exit_signal %d in daemonize()\n",
+                       this_task->comm, this_task->exit_signal);
+       }
+       this_task->exit_signal = SIGCHLD;
+
+       write_unlock_irq(&tasklist_lock);
 }
 
 void __init init_idle(void)
