Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265447AbSJaXB3>; Thu, 31 Oct 2002 18:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265445AbSJaXB2>; Thu, 31 Oct 2002 18:01:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16090 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265447AbSJaXBU>;
	Thu, 31 Oct 2002 18:01:20 -0500
Date: Thu, 31 Oct 2002 15:07:58 -0800
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG] open file descriptors remain after threaded exit() in 2.5.44
Message-ID: <20021031150758.A27452@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In linux 2.5.44, there seems to be a race between process exit and pthread
creation that can leave an open file descriptor that has no task
associated with it.

two test programs are included at the end of this mail.  Run the first program
on a SMP system with at least two processors.  The system I'm using has
8 pentium 4 processors and 16 gigabytes of memory.  After the
first program exits, run the second test program to demonstrate that 
there is still state remaining from the first program. 

To run the tests, you must first create a file that will be used
to place record locks.  You can edit the program sources to put that
file wherever you like.

The first test program begins by opening that file and using fcntl(F_SETLK) to
put a write lock on the file. The main thread then creates 8 child threads and
then exits immediately.  Each child thread sleeps for 60 seconds.
But, when the parent thread exits, the child threads are forced
to exit also.

The second program tries to get a lock on that same
file.  Since the first program has exited, its lock on that file should
nolonger be present, and the second program should successfully get its lock.
But instead, the second program fails.  A ps -eaf shows there are no threads
from the first process still present.

If you modify the first program so that the main thread sleeps 30 seconds
before exiting, then this problem is no longer seen.  The main thread exiting
still forces the child threads to exit.  But those child threads seem to
now be in a state where the forced exit doesn't expose this apparent race.

Here are the test programs

-------------threaded test program. Run this first---------------------------
------------ compile with -lpthread -lm flags --------------------------

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <pthread.h>
#include <getopt.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/fcntl.h>
#include <sys/time.h>
#include <sys/utsname.h>

void *worker_thread(void *arg) 
{
	sleep(60);
}


static pthread_attr_t thread_attr;
#define NTHREADS 8

main()
{
	int i;
	int fd;
	struct flock lock;

	fd = open("/home/dmo/PTH/l", O_RDWR);
	if (fd == -1) {
		perror("open failed");
		exit(0);
	}
	lock.l_whence = SEEK_SET;
	lock.l_type = F_WRLCK;
	lock.l_start = 0;
	lock.l_len = 1;

	if (fcntl(fd, F_SETLK, &lock) == -1) {
		perror("F_SETLK failed\n");
		exit(0);
	}

	pthread_attr_init(&thread_attr);
	pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_DETACHED);

	for (i = 0; i < NTHREADS; i++) {
		pthread_t worker_tid;

		if (pthread_create(&worker_tid, &thread_attr, worker_thread,
					(void *)NULL) != 0) {
			perror("thread create failed");
			exit(1);
		}
	}
	/*sleep(30);*/
}

---------------------- The second test program ------------------------------
---------------------- This tests for the failure of the first --------------


#include <unistd.h>
#include <fcntl.h>

main()
{
	int fd;
	struct flock lock;

	fd = open("/home/dmo/PTH/l", O_RDWR);
	if (fd == -1) {
		perror("open failed");
		exit(0);
	}
	lock.l_whence = SEEK_SET;
	lock.l_type = F_WRLCK;
	lock.l_start = 0;
	lock.l_len = 1;

	if (fcntl(fd, F_SETLK, &lock) == -1) {
		perror("F_SETLK failed\n");
		exit(0);
	}
	printf("lock succeeded\n");
	/*sleep(30);*/
}
