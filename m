Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131601AbQLVLjZ>; Fri, 22 Dec 2000 06:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbQLVLjQ>; Fri, 22 Dec 2000 06:39:16 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:16525 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131601AbQLVLjD>; Fri, 22 Dec 2000 06:39:03 -0500
Message-ID: <3A43375C.40765043@uow.edu.au>
Date: Fri, 22 Dec 2000 22:13:32 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: berndj@prism.co.za
CC: linux-kernel@vger.kernel.org
Subject: Re: possible pty DoS
In-Reply-To: <20001220150556.A29985@prism.co.za>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This 2.4 bug must be fixed.


berndj@prism.co.za wrote:
> 
> This snippet can prevent progress of any other processes that tries to do
> a write to a pty:
> 
> ============
>         #include <sys/fcntl.h>
>         #include <unistd.h>
> 
>         int main()
>         {
>                 int ptm;
>                 ptm = open("/dev/ptmx", O_WRONLY);
>                 while (1)
>                         write(ptm, "hello, world!\n", 14);
>         }
> ============
> 

Your program fills up the pty write buffer and then blocks.
This is fair enough.  But it blocks while holding the /dev/ptmx
inode semaphore, so _all_ other users of /dev/ptmx are blocked.
Your xterms get stuck, telnet and ssh are dead.  It's time to
find the car keys.

In 2.2, we have a per-tty semaphore.  No problems.  This
patch basically restores the 2.2 implementation and it
passes basic sanity testing.

But it's not my area.  Is there really a _need_ to take the inode
semaphore while we're writing to the pty instance?  I hope
not, because I took that out.

Perhaps it would be logical to clone the /dev/ptmx inode
in some manner when it's opened?

Anyone?



--- linux-2.4.0-test13-pre4/include/linux/tty.h	Tue Dec 12 19:24:23 2000
+++ linux-akpm/include/linux/tty.h	Fri Dec 22 21:44:47 2000
@@ -305,6 +305,7 @@
 	unsigned long canon_head;
 	unsigned int canon_column;
 	struct semaphore atomic_read;
+	struct semaphore atomic_write;
 	spinlock_t read_lock;
 };
 
--- linux-2.4.0-test13-pre4/drivers/char/tty_io.c	Tue Dec 12 19:24:17 2000
+++ linux-akpm/drivers/char/tty_io.c	Fri Dec 22 21:48:22 2000
@@ -699,9 +699,8 @@
 	size_t count)
 {
 	ssize_t ret = 0, written = 0;
-	struct inode *inode = file->f_dentry->d_inode;
 	
-	if (down_interruptible(&inode->i_sem)) {
+	if (down_interruptible(&tty->atomic_write)) {
 		return -ERESTARTSYS;
 	}
 	if ( test_bit(TTY_NO_WRITE_SPLIT, &tty->flags) ) {
@@ -734,7 +733,7 @@
 		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
 		ret = written;
 	}
-	up(&inode->i_sem);
+	up(&tty->atomic_write);
 	return ret;
 }
 
@@ -1972,6 +1971,7 @@
 	tty->tq_hangup.routine = do_tty_hangup;
 	tty->tq_hangup.data = tty;
 	sema_init(&tty->atomic_read, 1);
+	sema_init(&tty->atomic_write, 1);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
 }

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
