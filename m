Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWH2Nli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWH2Nli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWH2Nli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:41:38 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:14090 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964970AbWH2Nli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:41:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=tR7zeDJS+z+RC6dCGjIw/Avy4mbGpwvSstPXf821LgfWyfTZE7P9gbY3nA3hyf4xeHq9YmHQILci5D5fKgT4srYsWb4iZGAdlddCrr0nV2BviJivIH9jb8Mf9lnFGySOJvY1jzexlT/d12DTRMBXDFXdwre2eg6CBnL+fJx7Oi0=
Message-ID: <44F4440F.1090300@gmail.com>
Date: Tue, 29 Aug 2006 21:41:35 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: axboe@kernel.dk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: vmsplice can't work well
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens

I try to trace vmsplice and find it can't work in both ppc64 and i386, it always return -EFAULT because of the address of iovec.iov_base no matter it is page alignment or not, I don't know if I should file a bug for it, do you test it on i386 or ppc64?

This is the test program I used.

/*
* Use vmsplice to fill some user memory into a pipe. vmsplice writes
* to stdout, so that must be a pipe.
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <sys/poll.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <error.h>
#include <errno.h>

//#include "splice.h"
#if defined(__i386__)
#define __NR_splice 313
#define __NR_tee 315
#define __NR_vmsplice 316
#elif defined(__x86_64__)
#define __NR_splice 275
#define __NR_tee 276
#define __NR_vmsplice 277
#elif defined(__powerpc__) || defined(__powerpc64__)
#define __NR_splice 283
#define __NR_tee 284
#define __NR_vmsplice 285
#else
#error unsupported arch
#endif

#define SPLICE_SIZE 4096
#ifndef F_SETPSZ
#define F_SETPSZ 15 /* for pipes. */
#define F_GETPSZ 16 /* for pipes. */
#endif

#define ALIGN_BUF

#ifdef ALIGN_BUF
#define ALIGN_MASK (65535) /* 64k-1, should just be PAGE_SIZE - 1 */
#define ALIGN(buf) (void *) (((unsigned long) (buf) + ALIGN_MASK) & ~ALIGN_MASK)
#else
#define ALIGN_MASK (0)
#define ALIGN(buf) (buf)
#endif

#define min(a,b) (((a)>(b))?(b):(a))

static inline int xerror(const char * str)
{
	int err = errno;
	perror(str);
	return err;
}

static inline long vmsplice(int fd, const struct iovec *iov,
				unsigned long nr_segs, unsigned int flags)
{
	return syscall(__NR_vmsplice, fd, iov, nr_segs, flags);
}

int do_vmsplice(int fd, void *buffer, int len)
{
	struct pollfd pfd = { .fd = fd, .events = POLLOUT, };
	int written;
	struct iovec v;

	v.iov_base = buffer;
	v.iov_len = len;

	while (len) {
		/*
		 * in a real app you'd be more clever with poll of course,
		 * here we are basically just blocking on output room and
		 * not using the free time for anything interesting.
		 */
		if (poll(&pfd, 1, -1) < 0)
		return xerror("poll");

		written = vmsplice(fd, &v, 1, 0);
		printf("here: len = %d, written = %d\n", len, written);

		if (written <= 0)
			return xerror("vmsplice");
		fprintf(stderr, "written len = %d\n", written);

		len -= written;
	}

	return 0;
}

int main(int argc, char *argv[])
{
	unsigned char *buffer;
	struct stat sb;
	long page_size;
	int i, ret;

	if (fstat(STDOUT_FILENO, &sb) < 0)
		return xerror("stat");
	if (!S_ISFIFO(sb.st_mode)) {
		fprintf(stderr, "stdout must be a pipe\n");
		return 1;
	}

	page_size = sysconf(_SC_PAGESIZE);
	if (page_size < 0)
		return xerror("_SC_PAGESIZE");

	fprintf(stderr, "getpagesize = %d\n", getpagesize());
	fprintf(stderr, "page size: %d bytes\n", page_size);

	buffer = malloc(2 * 65536);
	buffer[0]='A';
	for (i = 1; i < 2 * SPLICE_SIZE; i++)
		buffer[i] = (i & 0xff);

	do {
		/*
		 * vmsplice the first half of the buffer into the pipe
		 */
		if (do_vmsplice(STDOUT_FILENO, buffer, SPLICE_SIZE))
			break;

		/*
		 * first half is now in pipe, but we don't quite know when
		 * we can reuse it.
		 */

		/*
		 * vmsplice second half
		 */
		//if (do_vmsplice(STDOUT_FILENO, buffer + SPLICE_SIZE, SPLICE_SIZE))
			// break;

		/*
		 * We still don't know when we can reuse the second half of
		 * the buffer, but we do now know that all parts of the first
		 * half have been consumed from the pipe - so we can reuse that.
		*/
	} while (0);

	free(buffer);

	return 0;
}

