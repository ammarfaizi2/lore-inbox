Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUKWRgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUKWRgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUKWRfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:35:31 -0500
Received: from pop.gmx.net ([213.165.64.20]:23506 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261369AbUKWQg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:36:58 -0500
Date: Tue, 23 Nov 2004 17:36:57 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: torvalds@osdl.org, akpm@osdl.org
Cc: michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [PATCH 2.6.10-rc2] RLIMIT_MEMLOCK accounting of shmctl() SHM_LOCK is broken
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <5143.1101227817@www28.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrew,

The accounting of shmctl() SHM_LOCK memory locks against the
user structure is broken.  The problem is that the check
of the size of the to-be-locked region is based on 
the size of the segment as specified when it was created
by shmget() (this size is *not* rounded up to a page 
boundary).  This size is then rounded down (>> PAGE_SHIFT)
to PAGE_SIZE during the check in 
mm/mlock.c::user_shm_lock().

The consequence is that one can lock an unlimited 
number of System V shared memory segments as long as they
are each less than PAGE_SIZE bytes.  

The program below can be used to demonstrate the problem.  
For example, running it with the following command line:

$ ./shm_lock_many 2000 1000

creates and locks 1000 segments of 2000 bytes each, 
even while RLIMIT_MEMLOCK is set to the default of 32kiB.

The simple patch at the end of this message is my 
attempt at a fix (it removes the problem when I test),
but maybe there is something better.

Cheers,

Michael


=====================

/* shm_lock_many.c */

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define errExit(msg)            { perror(msg); exit(EXIT_FAILURE); }

int
main(int argc, char *argv[])
{
    int shmid, segSize, numSegs, j;

    if (argc < 3 || strcmp(argv[1], "--help") == 0) {
        fprintf(stderr, "Usage: %s segment-size num-segments\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    segSize = atoi(argv[1]);
    numSegs = atoi(argv[2]);

    for (j = 0; j < numSegs; j++) {
        shmid = shmget(IPC_PRIVATE, segSize, S_IRUSR | S_IWUSR);
        if (shmid == -1) errExit("shmget");
        printf("%d: %d\n", j, shmid);
        if (shmctl(shmid, SHM_LOCK, NULL) == -1) errExit("shmctl");
    }

    exit(EXIT_SUCCESS);
} /* main */

=======================


--- linux-2.6.10-rc2/mm/mlock.c	2004-11-23 16:47:38.368147856 +0100
+++ linux-2.6.10-rc2-mlf/mm/mlock.c	2004-11-23 17:06:10.853024448 +0100
@@ -211,7 +211,7 @@
 	int allowed = 0;
 
 	spin_lock(&shmlock_user_lock);
-	locked = size >> PAGE_SHIFT;
+	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
 	if (locked + user->locked_shm > lock_limit && !capable(CAP_IPC_LOCK))

-- 
NEU +++ DSL Komplett von GMX +++ http://www.gmx.net/de/go/dsl
GMX DSL-Netzanschluss + Tarif zum supergünstigen Komplett-Preis!
