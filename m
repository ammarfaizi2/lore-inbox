Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUJOKD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUJOKD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUJOKD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:03:28 -0400
Received: from 70-33-118-80.kaptech.net ([80.118.33.70]:33210 "EHLO
	master.lab.meiosys.com") by vger.kernel.org with ESMTP
	id S267563AbUJOKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:03:22 -0400
Date: Fri, 15 Oct 2004 12:03:30 +0200
From: Gregory Kurz <gkurz@meiosys.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: fork() BUG invalidates file descriptors
Message-Id: <20041015120330.7b186668.gkurz@meiosys.com>
Organization: Meiosys Technology
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that under specific circumstances...

[1] fork() BUG invalidates file descriptors !

[2] Take a process P1 that spawns a thread T (aka. a clone with CLONE_FILES).
If P1 forks another process P2 (aka. not a clone) while T is blocked in a open()
that should return file descriptor FD, then FD will be unusable in P2.
This leads to strange behaviors in the context of P2: close(FD) returns EBADF,
while dup2(a_valid_fd, FD) returns EBUSY and of course FD is never returned
again by any syscall...

[3] open fork clone copy_files

[4] Linux version 2.6.8-1.521 (bhcompile@tweety.build.redhat.com) (gcc version
3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Mon Aug 16 09:01:18 EDT 2004
This bug also shows up in 2.4.27

[5] NA

[6] Just build and run the following program:

#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <asm/page.h>

#define FIFO "/tmp/bug_fifo"
#define FD   0

/*
 * This program is meant to show that calling fork() while a clone spawned
 * with CLONE_FILES is blocked in open() makes a fd number unusable in the
 * child.
 *
 *
 *     Parent               Clone                Child
 *        |
 *   clone(CLONE_FILES)------>|
 *        |                   |
 *        |                close(0)    (a)
 *        |                   |
 *        |                   |
 *        |                open(FIFO)  (b)
 *        |                   :
 *       fork() --------------:------------------->|
 *        |                   :                    |
 *        |                   :                  open()      (c)
 *        |                   :                  close(0)    (d)
 *        |                   :                  dup2(1, 0)  (e)
 *
 * a) when close(0) returns, 0 is necessarly the next fd to be open
 * b) we choose a fifo so that we block in sys_open()
 * c) open() should return 0 but will *probably* return 3
 * d) close(0) should return 0 but will return EBADF
 * e) dup2(1, 0) should return 0 but will return EBUSY
 * => fd 0 is unusable in child forever. Strange behavior isn't it ?
 */

int thread(void)
{
    close(FD); /* so that open() should reserve fd 0 */
    open(FIFO, O_RDONLY);
    return 0;
}

int main(int argc, char **argv)
{
    mkfifo(FIFO, 0600);
    
    clone((void*) &thread, (void*) calloc(1, PAGE_SIZE) + PAGE_SIZE,
          CLONE_FILES|SIGCHLD, 0);
    
    sleep(1); /* so that clone has time to get blocked in sys_open() */
    
    if (fork() == 0) {
        int ret;
        ret = open(FIFO, O_WRONLY); /* should return 0 */
        printf("open()=%d (%s)\n",
               ret, ret == -1 ? strerror(errno) : "Success");
        ret = close(FD);
        printf("close(%d)=%d (%s)\n",
               FD, ret, ret == -1 ? strerror(errno) : "Success");
        ret = dup2(1, FD);
        printf("dup2(1, %d)=%d (%s)\n",
               FD, ret, ret == -1 ? strerror(errno) : "Success");
        return 0;
    }
    
    wait(0);
    wait(0);
    return 0;
}

[7] In fact, environment isn't relevant since this bug can be easily spotted by
reading kernel/fork.c and fd/open.c. When entering sys_open(), a fd is set
in the open_fds field of the files_struct by get_unused_fd(). But
infortunately, this fd isn't cleared in copy_files() in the case the
corresponding struct file is null (meaning an open is being performed by a
clone). And therefore, the newly created process will remain with a bogus
open_fds set.

[8] a patch for linux-2.6.8.1 that works also for linux-2.4.27.

--- linux-2.6.8.1/kernel/fork.c.orig	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1/kernel/fork.c	2004-10-15 11:45:01.000000000 +0200
@@ -731,6 +731,8 @@
 		struct file *f = *old_fds++;
 		if (f)
 			get_file(f);
+		else
+			FD_CLR(open_files - i, newf->open_fds);
 		*new_fds++ = f;
 	}
 	spin_unlock(&oldf->file_lock);

[9] Hope that helps. Have a good day every body.

-- 
Gregory Kurz						gkurz@meiosys.com
Software Engineer @ Meiosys, SA				http://www.meiosys.com
