Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVCVEBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVCVEBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVCVDxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:53:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:48829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262354AbVCVDvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:51:51 -0500
Date: Mon, 21 Mar 2005 19:51:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: blp@cs.stanford.edu
Cc: mc@cs.stanford.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [CHECKER] ext3 bug in ftruncate() with O_SYNC?
Message-Id: <20050321195128.60839eea.akpm@osdl.org>
In-Reply-To: <87y8chft5j.fsf@benpfaff.org>
References: <87y8chft5j.fsf@benpfaff.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Pfaff <blp@cs.stanford.edu> wrote:
>
> Hi.  We're doing some checking on Linux file systems and found
> what appears to be a bug in the Linux 2.6.11 implementation of
> ext3: when ftruncate shrinks a file, using a file descriptor
> opened with O_SYNC, the file size is not updated synchronously.
> I've appended a test program that illustrates the problem.  After
> this program runs, the file system shows a file with length 1031,
> not 4 as would be expected if the ftruncate completed
> synchronously.  (If I insert an fsync before closing the file,
> the file length is correct.)
> 
> Does this look like a bug to you guys?
> 

The spec says "Write I/O operations on the file descriptor shall complete
as defined by synchronized I/O file integrity completion".

Is ftruncate a "write I/O operation"?  No.  Should ftruncate() honour
O_SYNC?  I'd say so, yes.  After all, an extending ftruncate is a
sort-of-write.

Unfortunately Linux doesn't pass the file* down to the
filesytem's ->truncate() handler, so the fs doesn't know that the
ftruncated fd was opened O_SYNC.  I don't think _any_ Linux filesystems get
this right.


> Ben.
> 
> ----------------------------------------------------------------------
> 
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdarg.h>
> #include <assert.h>
> 
> #define CHECK(ret) if(ret < 0) {perror(0); assert(0);}
> 
> int systemf(const char *fmt, ...)
> {
> 	static char cmd[1024];
> 
> 	va_list ap;
> 	va_start(ap, fmt);
> 	vsprintf(cmd, fmt, ap);
> 	va_end(ap);
> 	
> 	fprintf(stderr, "running cmd \"%s\"\n", cmd);
> 	return system(cmd);
> }
> 
> main(int argc, char *argv[])
> {
> 	int ret, fd;
> 	systemf("umount /dev/sbd0");
> 	systemf("sbin/mkfs.ext3 -F -j -b 1024 /dev/sbd0 2048");
> 	systemf("sbin/e2fsck.shared -y /dev/sbd0");
> 	systemf("mount -t ext3 /dev/sbd0 /mnt/sbd0 -o commit=65535");
> 	systemf("umount /dev/sbd0");
> 	systemf("mount -t ext3 /dev/sbd0 /mnt/sbd0 -o commit=65535");
> 	
> 	fd = open("/mnt/sbd0/0001", O_CREAT | O_RDWR | O_SYNC, 0700);
> 	CHECK(fd);
> 	ret = write(fd, "foobar", 6);
> 	CHECK(ret);
> 	ret = ftruncate(fd, 1031);
> 	CHECK(ret);
> 	ret = pwrite(fd, "bazzle", 6, 1031 - 6);
> 	CHECK(ret);
> 	ret = ftruncate(fd, 4);
> 	CHECK(ret);
>         ret = close(fd);
>         CHECK(ret);
> 
> #if 0
> 	{
> 		#include "../sbd/sbd.h"
> 		int sbd_fd = open("/dev/sbd0", O_RDONLY);
> 		ret = ioctl(sbd_fd, SBD_COPY_DISK, 1);
> 		CHECK(ret);
> 		close(sbd_fd);
> 	}
> #else
> 	systemf("reboot -f -n");
> #endif
> 	return 0;
> }
> 
> 
> 
> -- 
> Ben Pfaff 
> email: blp@cs.stanford.edu
> web: http://benpfaff.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
