Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVASBXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVASBXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 20:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVASBXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 20:23:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:59337 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261536AbVASBWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 20:22:48 -0500
Subject: [PATCH - 2.6.10] generic_file_buffered_write handle partial DIO
	writes with multiple iovecs
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1106097764.3041.16.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 18 Jan 2005 17:22:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This is a patch to generic_file_buffered_write() to correctly
handle partial O_DIRECT writes (because of unallocated blocks)
when there is more than 1 iovec.  Without this patch, the code is
writing the wrong iovec (it writes the first iovec a 2nd time).

Included is a test program dio_bug.c that shows the problem by:
	writing 4k to offset 4k
	writing 4k to offset 12k
	writing 8k to offset 4k
The result is that 8k write writes the 1st 4k of the buffer twice.

$ rm f; ./dio_bug f
wrong value offset 8k expected 0x33 got 0x11
wrong value offset 10k expected 0x44 got 0x22

with patch
$ rm f; ./dio_bug f

Here's the patch:

--- linux-2.6.10.orig/mm/filemap.c	2005-01-18 15:32:52.531207134 -0800
+++ linux-2.6.10/mm/filemap.c	2005-01-18 15:32:09.252319333 -0800
@@ -1908,7 +1908,16 @@ generic_file_buffered_write(struct kiocb
 
 	pagevec_init(&lru_pvec, 0);
 
-	buf = iov->iov_base + written;	/* handle partial DIO write */
+	/*
+	 * handle partial DIO write.  Adjust cur_iov if needed.
+	 */
+	if (likely(nr_segs == 1))
+		buf = iov->iov_base + written;
+	else {
+		filemap_set_next_iovec(&cur_iov, &iov_base, written);
+		buf = iov->iov_base + iov_base;
+	}
+
 	do {
 		unsigned long index;
 		unsigned long offset;
 

Here is the test program:
#define _GNU_SOURCE
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/uio.h>

main(int argc, char **argv)
{
	int fd;
	char *buf;
	int i;
	struct iovec v[2];

	fd = open(argv[1], O_DIRECT|O_RDWR|O_CREAT, 0666);

	if (fd < 0) {
		perror("open");
		exit(1);
	}

	buf = valloc(8192);

	lseek(fd, 0x1000, SEEK_SET);
	memset(buf, 0x11, 2048);
	memset(buf+2048, 0x22, 2048);
	i = write(fd, buf, 4096);	/* 4k write of 0x11 and 0x22 at 4k */

	lseek(fd, 0x3000, SEEK_SET);
	memset(buf, 0x55, 2048);
	memset(buf+2048, 0x66, 2048);
	i = write(fd, buf, 4096);	/* 4k write of 0x55 and 0x66 at 12k */

	lseek(fd, 0x1000, SEEK_SET);
	i = read(fd, buf, 4096);
	memset(buf+4096, 0x33 , 2048);
	memset(buf+4096+2048, 0x44 , 2048);

	v[0].iov_base = buf;
	v[0].iov_len = 4096;
	v[1].iov_base = buf + 4096;
	v[1].iov_len = 4096;
	lseek(fd, 0x1000, SEEK_SET);
	i = writev(fd, v, 2);	/* 8k write of 0x11, 0x22, 0x33, 0x44 at 4k */

	lseek(fd, 0x2000, SEEK_SET);
	i = read(fd, buf, 4096);
	if (buf[0] != 0x33)
		printf("wrong value offset 8k expected 0x33 got 0x%x\n",
			buf[0]);
	if (buf[2048] != 0x44)
		printf("wrong value offset 10k expected 0x44 got 0x%x\n",
			buf[2048]);
	
}


