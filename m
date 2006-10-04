Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWJDVW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWJDVW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWJDVW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:22:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751140AbWJDVW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:22:58 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org> <4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org> <45240034.2040704@oracle.com>
	<20061004121645.fd2765e4.akpm@osdl.org>
	<x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 04 Oct 2006 17:22:46 -0400
In-Reply-To: <x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's message of "Wed, 04 Oct 2006 16:53:53 -0400")
Message-ID: <x494puj7p3t.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Jeff Moyer <jmoyer@redhat.com> adds:
jmoyer> Again, sorry that I didn't include a better description.  I've
jmoyer> attached my reproducer to this message.

Oops, forgot to attach it.

-Jeff

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int
make_sparse(const char *filename, off_t len)
{
	int fd;

	fd = open(filename, O_WRONLY | O_CREAT, 0644);
	if (fd < 0) {
		perror("open");
		return -1;
	}

	if (ftruncate(fd, 0) != 0) {
		perror("ftruncate");
		return -1;
	}
	if (ftruncate(fd, len) != 0) {
		perror("ftruncate");
		return -1;
	}

	close(fd);
	return 0;
}

int
main(int argc, char **argv)
{
	int fd, i, nr_pages, ret;
	off_t len;
	int page_size = getpagesize();
	char *buf;
	char *pattern;

	if (argc < 3) {
		printf("Usage: %s <filename> <size-in-megabytes>\n", argv[0]);
		exit(1);
	}

	/* convert length to megabytes */
	len = strtoul(argv[2], NULL, 10);
	len <<= 20;

	if (make_sparse(argv[1], len) < 0)
		exit(4);

	nr_pages = len / page_size;

	if ((ret = posix_memalign((void **)&buf, 1024, page_size)) != 0) {
		errno = ret;
		perror("posix_memalign");
		exit(2);
	}


	fd = open(argv[1], O_WRONLY | O_CREAT | O_DIRECT);
	if (fd < 0) {
		perror("open");
		exit(3);
	}

	memset(buf, 'b', page_size);
	for (i = 0; i < nr_pages; i++) {
		ret = write(fd, buf, page_size);
		if (ret < 0) {
			perror("write");
			exit(5);
		}
	}
	close(fd);

	/* now read the data back in and make sure it hit the disk! */
	pattern = malloc(page_size);
	if (!pattern) {
		perror("malloc");
		exit(1);
	}
	memset(pattern, 'b', page_size);

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror("open");
		exit(1);
	}

	while (i < len) {
		memset(buf, 0, sizeof(buf));
		ret = read(fd, buf, page_size);
		if (ret != page_size) {
			if (ret < 0)
				perror("read");
			else
				fprintf(stderr, "short read of %d\n", ret);
			exit(1);
		}
		if (memcmp(buf, pattern, page_size)) {
			fprintf(stderr, "Invalid Data!\n");
			exit(1);
		}
		i += page_size;
	}
	
	exit(0);
}
