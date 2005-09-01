Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbVIAXib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbVIAXib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbVIAXib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:38:31 -0400
Received: from pat.uio.no ([129.240.130.16]:48085 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030538AbVIAXia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:38:30 -0400
Subject: Re: Change in NFS client behavior
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>, Rob Sims <lkml-z@robsims.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050831145545.GA8426@robsims.com>
References: <20050831145545.GA8426@robsims.com>
Content-Type: multipart/mixed; boundary="=-x60yO91/HTrJDwu/dQ1/"
Date: Thu, 01 Sep 2005 19:38:17 -0400
Message-Id: <1125617897.7627.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.917, required 12,
	autolearn=disabled, AWL 1.08, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-x60yO91/HTrJDwu/dQ1/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

on den 31.08.2005 Klokka 08:55 (-0600) skreiv Rob Sims:
> We have noticed when changing from kernel 2.4.23 to 2.6.8 that
> timestamps of files are not changed if opened for a write and nothing is
> written.  When using 2.4.23 timestamps are changed.  When using a local
> filesystem (reiserfs) with either kernel, timestamps are changed.
> Symptoms vary with the client, not the server.  See the script below.
> 
> When run on a 2.4.23 machine in an NFS mounted directory, output is
> "Good."  When run on a 2.6.8 or 2.6.12-rc4 machine in an NFS directory,
> output is "Error."
> 
> Is this a bug?  How do we revert to the 2.4/local fs behavior?  

This is a consequence of 2.6 NFS clients optimising away unnecessary
truncate calls. Whereas this is correct behaviour for truncate(), it
appears to be incorrect for open(O_TRUNC).

In fact, local filesystems like xfs and ext3 appear to have the opposite
problem: they change ctime if you call ftruncate(0) on the zero-length
file, as the attached test shows.

Cheers,
  Trond



--=-x60yO91/HTrJDwu/dQ1/
Content-Disposition: inline; filename=test.c
Content-Type: text/x-csrc; name=test.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	struct stat buf1, buf2, buf3;
	int fd;

	if (argc != 2) {
		printf("syntax: %s filename\n", argv[0]);
		exit(1);
	}
	fd = open(argv[1], O_CREAT|O_EXCL|O_WRONLY, 0644);
	if (fd == -1) {
		perror("open(%s, O_CREAT|O_EXCL|O_WRONLY) failed\n", argv[1]);
		exit(1);
	}
	if (fstat(fd, &buf1) == -1) {
		perror("fstat() failed\n");
		exit(1);
	}
	printf("File: %s, st_size = %lu, st_ctime = %s\n", argv[1],
			buf1.st_size,
			asctime(localtime(&buf1.st_ctime)));
	close(fd);
	sleep(2);
	fd = open(argv[1], O_TRUNC|O_WRONLY);
	if (fd == -1) {
		perror("open(%s, O_TRUNC|O_WRONLY) failed\n", argv[1]);
		exit(1);
	}
	if (fstat(fd, &buf2) == -1) {
		perror("fstat() failed\n");
		exit(1);
	}
	printf("File: %s, st_size = %lu, st_ctime = %s\n", argv[1],
			buf2.st_size,
			asctime(localtime(&buf2.st_ctime)));
	if (buf1.st_ctime == buf2.st_ctime)
		printf("Bad behaviour in open(%s, O_TRUNC)!\n", argv[1]);
	sleep(2);
	if (ftruncate(fd, 0) == -1) {
		perror("ftruncate(0) failed\n");
		exit(1);
	}
	if (fstat(fd, &buf3) == -1) {
		perror("fstat() failed\n");
		exit(1);
	}
	printf("File: %s, st_size = %lu, st_ctime = %s\n", argv[1],
			buf3.st_size,
			asctime(localtime(&buf3.st_ctime)));
	if (buf2.st_ctime != buf3.st_ctime)
		printf("Bad behaviour in ftruncate(0)!\n");
	close(fd);
	exit(0);
}

--=-x60yO91/HTrJDwu/dQ1/--

