Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVCUVoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVCUVoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVCUVmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:42:33 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:13956 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261968AbVCUVKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:10:37 -0500
To: jfs-discussion@lists.sourceforge.net,
       Dave Kleikamp <shaggy@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: [CHECKER] writes not always synchronous on JFS with O_SYNC?
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: Mon, 21 Mar 2005 13:10:43 -0800
Message-ID: <87vf7kr9gs.fsf@benpfaff.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  We've been running some tests on JFS and other file systems
and believe we've found an issue whereby O_SYNC does not always
cause data to be committed synchronously.  On Linux 2.6.11, we
found that the program appended below causes
/mnt/sbd0/0006/0010/0029/0033 to contain all zeros, despite the
use of O_SYNC on the write calls and the fsyncs on the
directories.  It seems to be pretty sensitive to the existence of
the rmdir calls: if I omit one of them, the data does get
written.

Note that /dev/sbd0 is essentially a ramdisk that we've developed
for testing this kind of thing: it allows a snapshot of a disk's
momentary contents to be copied out, so that we don't have to do
a reboot.

Can you confirm this?

Thanks,

Ben.

----------------------------------------------------------------------

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <assert.h>
#include <unistd.h>

#define CHECK(ret) if(ret < 0) {perror(0); assert(0);}
#define MAX_SIG_WRITE (20)
typedef unsigned int signature_t;

typedef struct write_s {
	off_t off;
	size_t len;
	char buf[MAX_SIG_WRITE * sizeof(signature_t)];
	off_t size; // file size;
	signature_t sig; // file sig;
} write_t;

write_t writes[] = {
	{0, 4,{-23, -69, 101, -119, }, 4, 228307655},
	{1023, 8,{63, -3, -104, -45, 4, -110, -59, 88, }, 1031, 4168021214},
	{4093, 12,{98, 11, -106, 98, 79, -107, -88, 102, 1, 100, -6, 85, }, 4105, 2386671457},
	{32755, 20,{-83, 49, -128, -96, 90, -7, 13, 69, 62, 127, -99, 125, 7, 53, -70, 62, -113, 63, 72, -104, }, 32775, 2170096179},
	{1073741793, 40,{-69, -57, -42, 80, -70, 54, 127, 17, -113, 34, 72, 31, 27, 5, -28, -18, -73, -79, -1, -52, -106, 8, 86, 100, 72, 28, 98, -27, -52, -104, -65, 3, 56, 51, 68, -66, 65, -87, 62, 51, }, 1073741833, 255668987},
};

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

int test_write(const char *pathname, unsigned i)
{
	int fd = open(pathname, O_WRONLY | O_SYNC);
	CHECK(fd);
	int ret = pwrite(fd, writes[i].buf, 
			 writes[i].len, writes[i].off);
	CHECK(ret);
	ret = close(fd);
	CHECK(ret);
	return ret;
}

void test_fsync(const char* pathname)
{
	int fd, ret;
	fd = open(pathname, 0);
	CHECK(fd);
	ret = fsync(fd);
	CHECK(ret);
	ret = close(fd);
	CHECK(ret);
}

void test_creat(const char* pathname, mode_t m)
{
	int fd, ret;
	fd = creat(pathname, m);
	CHECK(fd);
	ret = close(fd);
	CHECK(ret);
}

int main(int argc, char *argv[])
{
	int ret, fd;
	systemf("umount /dev/sbd0");
	systemf("sbin/mkfs.jfs -q /dev/sbd0 4096");
	systemf("sbin/fsck.jfs -a -p /dev/sbd0");
	systemf("mount -t jfs /dev/sbd0 /mnt/sbd0 ");
	systemf("umount /dev/sbd0");
	systemf("mount -t jfs /dev/sbd0 /mnt/sbd0 ");
	
	ret = mkdir("/mnt/sbd0/0006", 511);
	CHECK(ret);
	ret = mkdir("/mnt/sbd0/0006/0010", 511);
	CHECK(ret);
	ret = mkdir("/mnt/sbd0/0014", 511);
	CHECK(ret);
	ret = mkdir("/mnt/sbd0/0015", 511);
	CHECK(ret);
	ret = mkdir("/mnt/sbd0/0015/0016", 511);
	CHECK(ret);
	ret = mkdir("/mnt/sbd0/0006/0010/0017", 511);
	CHECK(ret);
	ret = rmdir("/mnt/sbd0/0015/0016");
	CHECK(ret);
	ret = mkdir("/mnt/sbd0/0006/0010/0017/0021", 511);
	CHECK(ret);
	ret = rmdir("/mnt/sbd0/0014");
	CHECK(ret);
	ret = rmdir("/mnt/sbd0/0015");
	CHECK(ret);
	ret = test_creat("/mnt/sbd0/0006/0028", 511);
	CHECK(ret);
	ret = test_write("/mnt/sbd0/0006/0028", 0);
	CHECK(ret);
	ret = mkdir("/mnt/sbd0/0006/0010/0029", 511);
	CHECK(ret);
	ret = test_creat("/mnt/sbd0/0006/0010/0029/0033", 511);
	CHECK(ret);
	ret = test_write("/mnt/sbd0/0006/0010/0029/0033", 0);
	CHECK(ret);
	ret = test_fsync("/mnt/sbd0/0006/0010/0029");
	CHECK(ret);
	ret = test_fsync("/mnt/sbd0/0006/0010");
	CHECK(ret);
	ret = test_fsync("/mnt/sbd0/0006");
	CHECK(ret);
	ret = test_fsync("/mnt/sbd0");
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
