Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWFVSEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWFVSEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWFVSEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:04:00 -0400
Received: from muan.mtu.ru ([195.34.34.229]:60170 "EHLO muan.mtu.ru")
	by vger.kernel.org with ESMTP id S932341AbWFVSD7 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:03:59 -0400
Subject: [RFC] [PATCH] generic_file_buffered_write - deadlock on vectored
	write?
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <Linux-Kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-1mw3QmWx7ypl9z6L/q1u"
Date: Thu, 22 Jun 2006 21:59:01 +0400
Message-Id: <1150999141.6414.39.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1mw3QmWx7ypl9z6L/q1u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

Preparing a patch for "batched" write we found a suspicious place in
generic_file_buffered_write. The attached patch contains detailed
description. Please, take a look.

--=-1mw3QmWx7ypl9z6L/q1u
Content-Disposition: attachment; filename=writev-deadlock-fix.patch
Content-Type: text/x-patch; name=writev-deadlock-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


generic_file_buffered_write prefaults in user pages in order to avoid deadlock
on copying from the same page as write goes to.

However, it looks like there is a problem when write is vectored:
fault_in_pages_readable brings in current segment or its part (maxlen).
OTOH, filemap_copy_from_user_iovec is called to copy number of bytes (bytes) which
may exceed current segment, so filemap_copy_from_user_iovec switches 
to the next segment which is not brought in yet. Pagefault is generated.
That causes the deadlock if pagefault is for the same page write goes to:
page being written is locked and not uptodate,
pagefault will deadlock trying to lock locked page.

If the above is unclear, 
the following program illustrates that:

#include <stdio.h>
#include <sys/uio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

char buf0[2048];
char *buf1;

int main(int argc, char **argv)
{
	int fd;
	struct iovec vec[2];

	vec[0].iov_base = buf0;
	vec[0].iov_len = 2048;

	fd = open(argv[1], O_RDWR);
	if (fd == -1) {
		printf("failed to open \"%s\": %s\n", argv[1], strerror(errno));
		return 0;
	}
	buf1 = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd, 0);
	if (buf1 == (char *)MAP_FAILED) {
		printf("failed to mmap \"%s\": %s\n", argv[1], strerror(errno));
		return 0;
	}
	vec[1].iov_base = buf1;
	vec[1].iov_len = 2048;

	if (writev(fd, vec, 2) != 4096) {
		printf("failed to writev \"%s\": %s\n", argv[1], strerror(errno));
		return 0;
	}

	munmap(buf1, 4096);
	close(fd);
	
	return 0;
}

The proposed fix is to never write to a page from more than one segment. 




diff -puN mm/filemap.c~writev-deadlock-fix mm/filemap.c
--- linux-2.6.17-rc6-mm1/mm/filemap.c~writev-deadlock-fix	2006-06-22 21:12:51.000000000 +0400
+++ linux-2.6.17-rc6-mm1-root/mm/filemap.c	2006-06-22 21:15:44.000000000 +0400
@@ -2103,8 +2103,9 @@ generic_file_buffered_write(struct kiocb
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
-			bytes = count;
+		maxlen = cur_iov->iov_len - iov_base;
+		if (bytes > maxlen)
+			bytes = maxlen;
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2112,10 +2113,7 @@ generic_file_buffered_write(struct kiocb
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		maxlen = cur_iov->iov_len - iov_base;
-		if (maxlen > bytes)
-			maxlen = bytes;
-		fault_in_pages_readable(buf, maxlen);
+		fault_in_pages_readable(buf, bytes);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {

_

--=-1mw3QmWx7ypl9z6L/q1u--

