Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131549AbQKVMCX>; Wed, 22 Nov 2000 07:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbQKVMCO>; Wed, 22 Nov 2000 07:02:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:37903 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131474AbQKVMBz>;
	Wed, 22 Nov 2000 07:01:55 -0500
Date: Wed, 22 Nov 2000 11:29:03 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>
Subject: [testcase] fsync/O_SYNC simple test cases
Message-ID: <20001122112903.E6516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The code below may be useful for doing simple testing of the O_SYNC
and f[data]sync code in the kernel.  It times various combinations of
updates-in-place and appends under various synchronisation mechanisms,
making it possible to see clearly whether fdatasync is skipping inode
updates for updates-in-place, for example.

--Stephen

synctest.c:


#include <assert.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <sys/fcntl.h>
#include <sys/stat.h>
#include <sys/vfs.h>
#include <sys/resource.h>

int iterations = 1000;

struct timeval last_stopwatch_time;

void stopwatch()
{
	struct timeval now;
	int delta;
	
	gettimeofday(&now, 0);
	delta = (now.tv_sec - last_stopwatch_time.tv_sec) * 1000000 +
		(now.tv_usec - last_stopwatch_time.tv_usec);
	printf ("Stopwatch: elapsed time %d.%03d seconds\n",
		delta / 1000000, (delta / 1000) % 1000);

	last_stopwatch_time = now;
}

int main()
{
	int fd, syncfd;
	int i;
	int err;
	char c;
	
	fd = open("syncfile", O_CREAT|O_TRUNC|O_RDWR, 0666);
	if (fd < 0) {
		perror("open");
		exit(1);
	}

	syncfd = open("syncfile", O_RDWR|O_SYNC, 0666);
	if (syncfd < 0) {
		perror("open");
		exit(1);
	}

	c = -1;
	err = pwrite(fd, &c, 1, 0);
	if (err != 1) {
		perror("pwrite");
		exit(1);
	}

	gettimeofday(&last_stopwatch_time, 0);
		
	/* First pass: do nothing but fsync */
	printf ("Performing %d fsyncs:\n", iterations);
	for (i=0; i<iterations; i++)
		fsync(fd);
	printf ("done. \n");
	stopwatch();
	
	/* Next pass: do nothing but fdatasync */
	printf ("Performing %d fdatasyncs:\n", iterations);
	for (i=0; i<iterations; i++)
		fdatasync(fd);
	printf ("done. \n");
	stopwatch();

	/* Next pass: do fsync with a file read in each pass to force an
	 * atime timestamp update */
	printf ("Performing %d atime fsyncs:\n", iterations);
	for (i=0; i<iterations; i++) {
		pread(fd, &c, 1, 0);
		fsync(fd);
	}
	printf ("done. \n");
	stopwatch();
	
	/* Next pass: do fdatasync with a file read in each pass to
	 * force an atime timestamp update */
	printf ("Performing %d atime fdatasyncs:\n", iterations);
	for (i=0; i<iterations; i++) {
		pread(fd, &c, 1, 0);
		fdatasync(fd);
	}
	printf ("done. \n");
	stopwatch();
	
	/* Next pass: do fdatasync with a file write in each pass: this
	 * should do a real sync of the data, but not of the inode. */
	printf ("Performing %d write fdatasyncs:\n", iterations);
	for (i=0; i<iterations; i++) {
		pwrite(fd, &c, 1, 0);
		fdatasync(fd);
	}
	printf ("done. \n");
	stopwatch();
	
	/* Next pass: do fdatasync with a file append in each pass: this
	 * should do a real sync of the data, and should also sync the
	 * inode for the new i_size. */
	printf ("Performing %d append fdatasyncs:\n", iterations);
	for (i=0; i<iterations; i++) {
		pwrite(fd, &c, 1, i);
		fdatasync(fd);
	}
	printf ("done. \n");
	stopwatch();
	
	/* Next pass: do fsync with a file write in each pass: this
	 * should do a real sync of the data and inode in each round,
	 * resulting in much head banging. */
	printf ("Performing %d write fsyncs:\n", iterations);
	for (i=0; i<iterations; i++) {
		pwrite(fd, &c, 1, 0);
		fsync(fd);
	}
	printf ("done. \n");
	stopwatch();
	
	/* Next pass: do O_SYNC writes. */
	printf ("Performing %d O_SYNC writes:\n", iterations);
	for (i=0; i<iterations; i++) {
		pwrite(syncfd, &c, 1, 0);
	}
	printf ("done. \n");
	stopwatch();
	
	/* Next pass: do O_SYNC appends. */
	ftruncate(syncfd, 0);
	fsync(syncfd);
	printf ("Performing %d O_SYNC appends:\n", iterations);
	for (i=0; i<iterations; i++) {
		pwrite(syncfd, &c, 1, i);
	}
	printf ("done. \n");
	stopwatch();
	
	return 0;
}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
