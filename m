Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSDCSLH>; Wed, 3 Apr 2002 13:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSDCSK6>; Wed, 3 Apr 2002 13:10:58 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22468 "EHLO
	e21.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S312316AbSDCSKk>; Wed, 3 Apr 2002 13:10:40 -0500
Message-ID: <3CAB4597.70602@us.ibm.com>
Date: Wed, 03 Apr 2002 10:10:31 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] BKL reduction in do_exit
In-Reply-To: <Pine.LNX.4.33.0204030945310.3571-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070502080609010101090502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070502080609010101090502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> I'd prefer to have the BKL just moved into the functions that need it, and
> removed altogether from do_exit().

I like the push-it-down approach better too.  Patch attached.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------070502080609010101090502
Content-Type: text/plain;
 name="do_exit-bkl_reduction-2.5.7.patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="do_exit-bkl_reduction-2.5.7.patch.2"

--- linux-2.5.7-clean/drivers/char/tty_io.c	Thu Mar  7 18:18:54 2002
+++ linux/drivers/char/tty_io.c	Wed Apr  3 10:03:27 2002
@@ -569,6 +569,8 @@
 	struct task_struct *p;
 	int tty_pgrp = -1;
 
+	lock_kernel();
+
 	if (tty) {
 		tty_pgrp = tty->pgrp;
 		if (on_exit && tty->driver.type != TTY_DRIVER_TYPE_PTY)
@@ -578,6 +580,7 @@
 			kill_pg(current->tty_old_pgrp, SIGHUP, on_exit);
 			kill_pg(current->tty_old_pgrp, SIGCONT, on_exit);
 		}
+		unlock_kernel();	
 		return;
 	}
 	if (tty_pgrp > 0) {
@@ -595,6 +598,7 @@
 	  	if (p->session == current->session)
 			p->tty = NULL;
 	read_unlock(&tasklist_lock);
+	unlock_kernel();
 }
 
 void stop_tty(struct tty_struct *tty)
--- linux-2.5.7-clean/ipc/sem.c	Thu Mar  7 18:18:25 2002
+++ linux/ipc/sem.c	Wed Apr  3 10:07:28 2002
@@ -995,6 +995,8 @@
 	struct sem_array *sma;
 	int nsems, i;
 
+	lock_kernel();
+
 	/* If the current process was sleeping for a semaphore,
 	 * remove it from the queue.
 	 */
@@ -1051,6 +1053,8 @@
 		sem_unlock(semid);
 	}
 	current->semundo = NULL;
+
+	unlock_kernel();
 }
 
 #ifdef CONFIG_PROC_FS
--- linux-2.5.7-clean/kernel/exit.c	Tue Apr  2 10:43:28 2002
+++ linux/kernel/exit.c	Wed Apr  3 10:06:19 2002
@@ -498,7 +498,6 @@
 #endif
 	__exit_mm(tsk);
 
-	lock_kernel();
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);

--------------070502080609010101090502--

