Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVJDIoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVJDIoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 04:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVJDIoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 04:44:05 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:40761 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964789AbVJDIoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 04:44:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=sYAfFk5gsKUC5y4Cc3Wg7umP/CC/lq7/Xp3KJ7/+ku02ZfPCV+IutpzuU1lBEOBYz7zgoBZb61mQ4dtBPwgU2X6MhJ9la381LwqBoLwtYQkO7qhuGK1DQCmtKFD1UQcI2AqwxThEvL0Q1OpO7pn5+W2KuZIBgbDoJ8JXr9g6b2o=
Date: Tue, 4 Oct 2005 17:43:57 +0900
From: Tejun Heo <htejun@gmail.com>
To: viro@ftp.linux.org.uk, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6] fs: error case fix in __generic_file_aio_read
Message-ID: <20051004084357.GA28132@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hello, guys.

 When __generic_file_aio_read() hits an error during reading, it
reports the error iff nothing has successfully been read yet.  This is
different from how other read/write functions deal with error
condition - when an error occurs, if nothing has been read/written,
report the error code; otherwise, report the amount of bytes
successfully transferred upto that point.

 This corner case can be exposed by performing readv(2) with the
following iov.

 iov[0] = len0 @ ptr0
 iov[1] = len1 @ NULL (or any other invalid pointer)
 iov[2] = len2 @ ptr2

 When file size is enough, performing above readv(2) results in

 len0 bytes from file_pos @ ptr0
 len2 bytes from file_pos + len0 @ ptr2

 And the return value is len0 + len2.  Test program is attached to
this mail.

 This patch makes __generic_file_aio_read()'s error handling identical
to other functions.

 Thanks.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1030,8 +1030,8 @@ __generic_file_aio_read(struct kiocb *io
 			desc.error = 0;
 			do_generic_file_read(filp,ppos,&desc,file_read_actor);
 			retval += desc.written;
-			if (!retval) {
-				retval = desc.error;
+			if (desc.error) {
+				retval = retval ?: desc.error;
 				break;
 			}
 		}

--OXfL5xGRrasGEqWY
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="testreadv.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/uio.h>
#include <errno.h>
#include <string.h>

int main(int argc, char **argv)
{
	const char *path;
	struct stat stbuf;
	size_t len0, len1;
	void *buf0, *buf1;
	struct iovec iov[3];
	int fd, i;
	ssize_t ret;

	if (argc < 2) {
		fprintf(stderr, "Usage: testreadv path (better be a "
			"small text file)\n");
		return 1;
	}
	path = argv[1];

	if (stat(path, &stbuf) < 0) {
		perror("stat");
		return 1;
	}

	len0 = stbuf.st_size / 2;
	len1 = stbuf.st_size - len0;

	if (!len0 || !len1) {
		fprintf(stderr, "Dude, file is too small\n");
		return 1;
	}

	if ((fd = open(path, O_RDONLY)) < 0) {
		perror("open");
		return 1;
	}

	if (!(buf0 = malloc(len0)) || !(buf1 = malloc(len1))) {
		perror("malloc");
		return 1;
	}

	memset(buf0, 0, len0);
	memset(buf1, 0, len1);

	iov[0].iov_base = buf0;
	iov[0].iov_len = len0;
	iov[1].iov_base = NULL;
	iov[1].iov_len = len1;
	iov[2].iov_base = buf1;
	iov[2].iov_len = len1;

	printf("vector ");
	for (i = 0; i < 3; i++)
		printf("%p:%zu ", iov[i].iov_base, iov[i].iov_len);
	printf("\n");

	ret = readv(fd, iov, 3);
	if (ret < 0)
		perror("readv");

	printf("readv returned %zd\nbuf0 = [%s]\nbuf1 = [%s]\n",
	       ret, (char *)buf0, (char *)buf1);

	return 0;
}

--OXfL5xGRrasGEqWY--
