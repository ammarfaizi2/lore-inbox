Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSKYUEp>; Mon, 25 Nov 2002 15:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSKYUEp>; Mon, 25 Nov 2002 15:04:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265633AbSKYUEn>;
	Mon, 25 Nov 2002 15:04:43 -0500
Subject: Re: [BUG] open file descriptors remain after threaded exit() in
	2.5.44
From: Mark Wong <markw@osdl.org>
To: Dave Olien <dmo@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021031150758.A27452@acpi.pdx.osdl.net>
References: <20021031150758.A27452@acpi.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1038255325.27470.3.camel@IBM-B.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Nov 2002 12:15:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

I've verified the problem still exists for SAP DB on 2.5.49 and your
test case still fails.  Then I installed NGPT 2.0.4 and found that I
still cannot start, stop and start SAP DB, but your test case now
passes.

Does that offer any clues?

Mark

On Thu, 2002-10-31 at 15:07, Dave Olien wrote:
> In linux 2.5.44, there seems to be a race between process exit and pthread
> creation that can leave an open file descriptor that has no task
> associated with it.
> 
> two test programs are included at the end of this mail.  Run the first program
> on a SMP system with at least two processors.  The system I'm using has
> 8 pentium 4 processors and 16 gigabytes of memory.  After the
> first program exits, run the second test program to demonstrate that 
> there is still state remaining from the first program. 
> 
> To run the tests, you must first create a file that will be used
> to place record locks.  You can edit the program sources to put that
> file wherever you like.
> 
> The first test program begins by opening that file and using fcntl(F_SETLK) to
> put a write lock on the file. The main thread then creates 8 child threads and
> then exits immediately.  Each child thread sleeps for 60 seconds.
> But, when the parent thread exits, the child threads are forced
> to exit also.
> 
> The second program tries to get a lock on that same
> file.  Since the first program has exited, its lock on that file should
> nolonger be present, and the second program should successfully get its lock.
> But instead, the second program fails.  A ps -eaf shows there are no threads
> from the first process still present.
> 
> If you modify the first program so that the main thread sleeps 30 seconds
> before exiting, then this problem is no longer seen.  The main thread exiting
> still forces the child threads to exit.  But those child threads seem to
> now be in a state where the forced exit doesn't expose this apparent race.
> 
> Here are the test programs
> 
> -------------threaded test program. Run this first---------------------------
> ------------ compile with -lpthread -lm flags --------------------------
> 
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <math.h>
> #include <pthread.h>
> #include <getopt.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/fcntl.h>
> #include <sys/time.h>
> #include <sys/utsname.h>
> 
> void *worker_thread(void *arg) 
> {
> 	sleep(60);
> }
> 
> 
> static pthread_attr_t thread_attr;
> #define NTHREADS 8
> 
> main()
> {
> 	int i;
> 	int fd;
> 	struct flock lock;
> 
> 	fd = open("/home/dmo/PTH/l", O_RDWR);
> 	if (fd == -1) {
> 		perror("open failed");
> 		exit(0);
> 	}
> 	lock.l_whence = SEEK_SET;
> 	lock.l_type = F_WRLCK;
> 	lock.l_start = 0;
> 	lock.l_len = 1;
> 
> 	if (fcntl(fd, F_SETLK, &lock) == -1) {
> 		perror("F_SETLK failed\n");
> 		exit(0);
> 	}
> 
> 	pthread_attr_init(&thread_attr);
> 	pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_DETACHED);
> 
> 	for (i = 0; i < NTHREADS; i++) {
> 		pthread_t worker_tid;
> 
> 		if (pthread_create(&worker_tid, &thread_attr, worker_thread,
> 					(void *)NULL) != 0) {
> 			perror("thread create failed");
> 			exit(1);
> 		}
> 	}
> 	/*sleep(30);*/
> }
> 
> ---------------------- The second test program ------------------------------
> ---------------------- This tests for the failure of the first --------------
> 
> 
> #include <unistd.h>
> #include <fcntl.h>
> 
> main()
> {
> 	int fd;
> 	struct flock lock;
> 
> 	fd = open("/home/dmo/PTH/l", O_RDWR);
> 	if (fd == -1) {
> 		perror("open failed");
> 		exit(0);
> 	}
> 	lock.l_whence = SEEK_SET;
> 	lock.l_type = F_WRLCK;
> 	lock.l_start = 0;
> 	lock.l_len = 1;
> 
> 	if (fcntl(fd, F_SETLK, &lock) == -1) {
> 		perror("F_SETLK failed\n");
> 		exit(0);
> 	}
> 	printf("lock succeeded\n");
> 	/*sleep(30);*/
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x 32 (office)
(503)-626-2436      (fax)
http://www.osdl.org/archive/markw/

