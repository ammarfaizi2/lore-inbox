Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVCUFq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVCUFq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 00:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVCUFqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 00:46:25 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:58551 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261576AbVCUFqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 00:46:16 -0500
To: ext2-dev@lists.sourceforge.net
CC: mc@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: [CHECKER] ext3 bug in ftruncate() with O_SYNC?
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: Sun, 20 Mar 2005 21:46:16 -0800
Message-ID: <87y8chft5j.fsf@benpfaff.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  We're doing some checking on Linux file systems and found
what appears to be a bug in the Linux 2.6.11 implementation of
ext3: when ftruncate shrinks a file, using a file descriptor
opened with O_SYNC, the file size is not updated synchronously.
I've appended a test program that illustrates the problem.  After
this program runs, the file system shows a file with length 1031,
not 4 as would be expected if the ftruncate completed
synchronously.  (If I insert an fsync before closing the file,
the file length is correct.)

Does this look like a bug to you guys?

Thanks,

Ben.

----------------------------------------------------------------------

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <assert.h>

#define CHECK(ret) if(ret < 0) {perror(0); assert(0);}

int systemf(const char *fmt, ...)
{
	static char cmd[1024];

	va_list ap;
	va_start(ap, fmt);
	vsprintf(cmd, fmt, ap);
	va_end(ap);
	
	fprintf(stderr, "running cmd \"%s\"\n", cmd);
	return system(cmd);
}

main(int argc, char *argv[])
{
	int ret, fd;
	systemf("umount /dev/sbd0");
	systemf("sbin/mkfs.ext3 -F -j -b 1024 /dev/sbd0 2048");
	systemf("sbin/e2fsck.shared -y /dev/sbd0");
	systemf("mount -t ext3 /dev/sbd0 /mnt/sbd0 -o commit=65535");
	systemf("umount /dev/sbd0");
	systemf("mount -t ext3 /dev/sbd0 /mnt/sbd0 -o commit=65535");
	
	fd = open("/mnt/sbd0/0001", O_CREAT | O_RDWR | O_SYNC, 0700);
	CHECK(fd);
	ret = write(fd, "foobar", 6);
	CHECK(ret);
	ret = ftruncate(fd, 1031);
	CHECK(ret);
	ret = pwrite(fd, "bazzle", 6, 1031 - 6);
	CHECK(ret);
	ret = ftruncate(fd, 4);
	CHECK(ret);
        ret = close(fd);
        CHECK(ret);

#if 0
	{
		#include "../sbd/sbd.h"
		int sbd_fd = open("/dev/sbd0", O_RDONLY);
		ret = ioctl(sbd_fd, SBD_COPY_DISK, 1);
		CHECK(ret);
		close(sbd_fd);
	}
#else
	systemf("reboot -f -n");
#endif
	return 0;
}



-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org
