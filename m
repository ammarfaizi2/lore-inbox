Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSDYKeB>; Thu, 25 Apr 2002 06:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSDYKeA>; Thu, 25 Apr 2002 06:34:00 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:36306 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S313057AbSDYKd7>;
	Thu, 25 Apr 2002 06:33:59 -0400
Message-Id: <3.0.6.32.20020425123738.0090d120@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 25 Apr 2002 12:37:38 +0200
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: [PATCH] and OOPS :-( kernel threads and filehandles 2.4.19pre1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got the following patch which tries to coordinate most of the 
kernel threads.

This patch tries to make a base for cleanup of the various kernel_threads -
I try to use daemonize() in every thread - but in turn I throw away 
some settings of current->pgrp=1, multiple calls of exit_files and so on.


But I've got a problem: This kernel oopses (see end of mail).

This patch goes through the kernel - loop.c, mtdblock.c, cpqfcTSworker.c,
usb/storage/usb.c, buffer.c, intrep.c, kmod.c, sched.c.
Please give me some feedback - if this is approved (even if only in parts), 
I'll give it to the proper maintainers.


Thanks you very much for every help!


Regards,

Phil



diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/drivers/block/loop.c linux/drivers/block/loop.c
--- linux-2.4.19pre1/drivers/block/loop.c       Fri Dec 21 18:41:53 2001
+++ linux/drivers/block/loop.c  Thu Apr 25 12:30:33 2002
@@ -561,7 +561,6 @@
        struct buffer_head *bh;

        daemonize();
-       exit_files(current);

        sprintf(current->comm, "loop%d", lo->lo_number);

diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/drivers/mtd/mtdblock.c linux/drivers/mtd/mtdblock.c
--- linux-2.4.19pre1/drivers/mtd/mtdblock.c     Thu Oct 25 22:58:35 2001
+++ linux/drivers/mtd/mtdblock.c        Thu Apr 25 13:00:58 2002
@@ -472,20 +472,16 @@
        struct task_struct *tsk = current;
        DECLARE_WAITQUEUE(wait, tsk);

-       tsk->session = 1;
-       tsk->pgrp = 1;
+       daemonize();
        /* we might get involved when memory gets low, so use PF_MEMALLOC */
        tsk->flags |= PF_MEMALLOC;
        strcpy(tsk->comm, "mtdblockd");
-       tsk->tty = NULL;
        spin_lock_irq(&tsk->sigmask_lock);
        sigfillset(&tsk->blocked);
        recalc_sigpending(tsk);
        spin_unlock_irq(&tsk->sigmask_lock);
        exit_mm(tsk);
-       exit_files(tsk);
        exit_sighand(tsk);
-       exit_fs(tsk);

        while (!leaving) {
                add_wait_queue(&thr_wq, &wait);
diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/drivers/scsi/cpqfcTSworker.c linux/drivers/scsi/cpqfcTSworker.c
--- linux-2.4.19pre1/drivers/scsi/cpqfcTSworker.c       Thu Oct 25 22:53:50 2001
+++ linux/drivers/scsi/cpqfcTSworker.c  Thu Apr 25 13:01:53 2002
@@ -175,24 +175,15 @@
         */
   exit_mm(current);

-  current->session = 1;
-  current->pgrp = 1;
-
   /* Become as one with the init task */
+  daemonize();
+

-  exit_fs(current);    /* current->fs->count--; */
-  fs = init_task.fs;
   // Some kernels compiled for SMP, while actually running
   // on a uniproc machine, will return NULL for this call
-  if( !fs)
+  if( !current->fs)
   {
     printk(" cpqfcTS FATAL: fs is NULL! Is this an SMP kernel on uniproc machine?\n ");
-  }
-
-  else
-  {
-    current->fs = fs;
-    atomic_inc(&fs->count);
   }

   siginitsetinv(&current->blocked, SHUTDOWN_SIGS);
diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/drivers/usb/storage/usb.c linux/drivers/usb/storage/usb.c
--- linux-2.4.19pre1/drivers/usb/storage/usb.c  Mon Feb 25 20:38:07 2002
+++ linux/drivers/usb/storage/usb.c     Thu Apr 25 12:31:00 2002
@@ -314,9 +314,6 @@
         * This thread doesn't need any user-level access,
         * so get rid of all our resources..
         */
-       exit_files(current);
-       current->files = init_task.files;
-       atomic_inc(&current->files->count);
        daemonize();

        /* avoid getting signals */
diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/fs/buffer.c linux/fs/buffer.c
--- linux-2.4.19pre1/fs/buffer.c        Mon Feb 25 20:38:08 2002
+++ linux/fs/buffer.c   Thu Apr 25 12:55:27 2002
@@ -2934,8 +2934,7 @@
         *      display semi-sane things. Not real crucial though...
         */

-       tsk->session = 1;
-       tsk->pgrp = 1;
+       daemonize();
        strcpy(tsk->comm, "bdflush");

        /* avoid getting signals */
@@ -2969,8 +2968,7 @@
        struct task_struct * tsk = current;
        int interval;

-       tsk->session = 1;
-       tsk->pgrp = 1;
+       daemonize();
        strcpy(tsk->comm, "kupdated");

        /* sigstop and sigcont will stop and wakeup kupdate */
diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/fs/jffs/intrep.c linux/fs/jffs/intrep.c
--- linux-2.4.19pre1/fs/jffs/intrep.c   Fri Oct  5 00:13:18 2001
+++ linux/fs/jffs/intrep.c      Thu Apr 25 13:02:27 2002
@@ -3346,9 +3346,8 @@

        lock_kernel();
        exit_mm(c->gc_task);
+        daemonize();

-       current->session = 1;
-       current->pgrp = 1;
        init_completion(&c->gc_thread_comp); /* barrier */
        spin_lock_irq(&current->sigmask_lock);
        siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/kernel/kmod.c linux/kernel/kmod.c
--- linux-2.4.19pre1/kernel/kmod.c      Wed Jul 18 03:23:50 2001
+++ linux/kernel/kmod.c Thu Apr 25 13:03:59 2002
@@ -91,6 +91,7 @@

        curtask->session = 1;
        curtask->pgrp = 1;
+/* PhilM: would damonize() be correct here ?? */

        use_init_fs_context();

diff -urN -x *.o -x .* -x Makefile -x System.map -x *.h -x *.S -x *.s linux-2.4.19pre1/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19pre1/kernel/sched.c     Fri Dec 21 18:42:04 2001
+++ linux/kernel/sched.c        Thu Apr 25 12:55:13 2002
@@ -1291,10 +1291,8 @@
        exit_fs(current);       /* current->fs->count--; */
        fs = init_task.fs;
        current->fs = fs;
-       atomic_inc(&fs->count);
+       atomic_inc(&fs->count);
        exit_files(current);
-       current->files = init_task.files;
-       atomic_inc(&current->files->count);
 }

 extern unsigned long wait_init_idle;



ksymoops 2.4.2 on i686 2.4.19pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19pre1/ (default)
     -m /boot/System.map (specified)

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000008
<4>c012427b
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[exec_usermodehelper+699/928]    Not tainted
<4>EFLAGS: 00010246
<4>eax: 00000000   ebx: 00000000   ecx: c7264000   edx: 00000000
<4>esi: c11f5e60   edi: c7663e40   ebp: c7663e40   esp: c7265fb4
<4>ds: 0018   es: 0018   ss: 0018
<4>Process keventd (pid: 115, stackpage=c7265000)
<4>Stack: c7925e10 c7b7df74 c7925e10 c7b7c000 c7b31e64 c11f5e60 c11f5e60 c11f5e60
<4>       c11f5e60 c7264000 c01245d6 c027a600 c7925e68 c6ea90c0 00004111 c01057b4
<4>       c7925e10 00000078 c7b7dfa4
<4>Call Trace: [____call_usermodehelper+46/64] [kernel_thread+40/56]
<4>Code: 3b 58 08 7d 30 ba 06 00 00 00 8b 40 14 83 3c 98 00 74 12 89
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   3b 58 08                  cmp    0x8(%eax),%ebx
Code;  00000002 Before first symbol
   3:   7d 30                     jge    35 <_EIP+0x35> 00000034 Before first symbol
Code;  00000004 Before first symbol
   5:   ba 06 00 00 00            mov    $0x6,%edx
Code;  0000000a Before first symbol
   a:   8b 40 14                  mov    0x14(%eax),%eax
Code;  0000000c Before first symbol
   d:   83 3c 98 00               cmpl   $0x0,(%eax,%ebx,4)
Code;  00000010 Before first symbol
  11:   74 12                     je     25 <_EIP+0x25> 00000024 Before first symbol
Code;  00000012 Before first symbol
  13:   89 00                     mov    %eax,(%eax)




