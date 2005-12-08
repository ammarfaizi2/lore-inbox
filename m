Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVLHQpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVLHQpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVLHQpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:45:38 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:5448 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932212AbVLHQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:45:37 -0500
Message-ID: <439862F9.6000407@ru.mvista.com>
Date: Thu, 08 Dec 2005 19:44:41 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] posix_fadvise bug (unexpected success on FIFO/pipe)
Content-Type: multipart/mixed;
 boundary="------------040405090707000405090104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040405090707000405090104
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello, all.
I have the following problem with posix_fadvise :
the system call succeeds on a pipe or FIFO, although it has to fail with 
ESPIPE (EINVAL on linux) return value.
Looks like a kernel bug.
I've attached a small test for posix_fadvise and a patch for linux 
kernel 2.6.14 that fixes the problem.
The patch makes posix_fadvise return ESPIPE on FIFO/pipe in order to be 
fully POSIX-compliant.
Please, take a look at these.
Thanks.

--------------040405090707000405090104
Content-Type: text/x-csrc;
 name="posix_fadvise_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="posix_fadvise_test.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>

int main()
{
	int retval, fd;

	if (mkfifo("fifo", 0666) < 0) {
		printf("create fifo error\n");
		return 1;
	}
	
	fd = open("fifo", O_RDWR);
	if (fd < 0) {
		printf("open fifo error\n");
		remove("fifo");
		return 1;
	}
	
	retval = posix_fadvise(fd, 0, 0, POSIX_FADV_NORMAL);
	if (retval) {
		printf("Expected fail - The fd argument is associated with a pipe or FIFO.\n");
		if (retval != ESPIPE)
			printf("Unexpected ERRNO %d (Expected %d)\n", retval, ESPIPE);
	} else
		printf("Unexpected success  - The fd argument is associated with a pipe or FIFO.\n");

	close(fd);
	remove("fifo");

	if (retval)
		return 0;
	return 1;
}

--------------040405090707000405090104
Content-Type: text/x-patch;
 name="fadv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fadv.patch"

--- a/mm/fadvise.c 2005-10-10 22:54:29.000000000 +0400
+++ b/mm/fadvise.c 2005-12-06 23:04:19.980711464 +0300
@@ -37,6 +37,11 @@
        if (!file)
                return -EBADF;
 
+       if (S_ISFIFO(file->f_dentry->d_inode->i_mode)) {
+               ret = -ESPIPE;
+               goto out;
+       }
+
        mapping = file->f_mapping;
        if (!mapping || len < 0) {
                ret = -EINVAL;


--------------040405090707000405090104--
