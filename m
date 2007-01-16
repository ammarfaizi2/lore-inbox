Return-Path: <linux-kernel-owner+w=401wt.eu-S1751201AbXAPOtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbXAPOtr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXAPOtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:49:46 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:46711 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbXAPOtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:49:46 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=riQl6Iz1K0IZFexI5AetP2pY3xTbkoTZZo+G/9AdPPMg4IWqCmGztv9fEC7lvUny90uqFvVQnI94lds/I+tdD3NWtrv74Ve1GtdgvtWCKBWjDO0dyvr/4L4e51/7A7X3bZC19WIKoQJfkV3y/zo8PaHshOcrWCFuh9GjiS7zvio=
Message-ID: <ceccffee0701160649w5e401cf9i433f61beeb26e2b1@mail.gmail.com>
Date: Tue, 16 Jan 2007 15:49:45 +0100
From: "Linux Portal" <linportal@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Simple utility to measure disk random access time
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And a few graphs here: http://linux.inet.hr/how_fast_is_your_disk.html

Comments welcome!

#define _LARGEFILE64_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>
#include <signal.h>
#include <sys/fcntl.h>
#include <sys/ioctl.h>
#include <linux/fs.h>

#define BLOCKSIZE 512
#define TIMEOUT 30

int count;
time_t start;

void done()
{
	time_t end;

	time(&end);

	if (end < start + TIMEOUT) {
		printf(".");
		alarm(1);
		return;
	}

	if (count) {
	  printf(".\nResults: %d seeks/second, %.2f ms random access time\n",
		 count / TIMEOUT, 1000.0 * TIMEOUT / count);
	}
	exit(EXIT_SUCCESS);
}

void handle(const char *string, int error)
{
	if (error) {
		perror(string);
		exit(EXIT_FAILURE);
	}
}

int main(int argc, char **argv)
{
	char buffer[BLOCKSIZE];
	int fd, retval;
	unsigned long numblocks;
	off64_t offset;

	setvbuf(stdout, NULL, _IONBF, 0);

	printf("Seeker v2.0, 2007-01-15, "
	       "http://linux.inet.hr/how_fast_is_your_disk.html\n");

	if (argc != 2) {
		printf("Usage: seeker <raw disk device>\n");
		exit(EXIT_SUCCESS);
	}

	fd = open(argv[1], O_RDONLY);
	handle("open", fd < 0);

	retval = ioctl(fd, BLKGETSIZE, &numblocks);
	handle("ioctl", retval == -1);
	printf("Benchmarking %s [%luMB], wait %d seconds",
	       argv[1], numblocks / 2048, TIMEOUT);

	time(&start);
	srand(start);
	signal(SIGALRM, &done);
	alarm(1);

	for (;;) {
		offset = (off64_t) numblocks * random() / RAND_MAX;
		retval = lseek64(fd, BLOCKSIZE * offset, SEEK_SET);
		handle("lseek64", retval == (off64_t) -1);
		retval = read(fd, buffer, BLOCKSIZE);
		handle("read", retval < 0);
		count++;
	}
	/* notreached */
}
