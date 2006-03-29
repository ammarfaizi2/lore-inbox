Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWC2MaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWC2MaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWC2MaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:30:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34395 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751053AbWC2MaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:30:13 -0500
Date: Wed, 29 Mar 2006 14:30:22 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060329123022.GD8186@suse.de>
References: <20060329122841.GC8186@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20060329122841.GC8186@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 29 2006, Jens Axboe wrote:
> splice-in file
>         Splice file to stdout
> 
> splice-out
>         Splice stdin to file
> 
> splice-net hostname port
>         Splice stdin to hostname:port
> 
> Examples - splice copying a file can be done as:
> 
> # splice-in file | splice-out new_file
> 
> Sending a file over the network
> 
> # cat file | splice-net hostname port
> 
> and then have the other end run eg netcat -l -p port to receive the
> data.

Which I naturally forgot to attach, here they are.

-- 
Jens Axboe


--GPJrCs/72TxItFYR
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="splice-in.c"

/*
 * Splice argument file to stdout
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#if defined(__i386__)
#define __NR_splice	313
#elif defined(__x86_64__)
#define __NR_splice	275
#elif defined(__powerpc__) || defined(__powerpc64__)
#define __NR_splice	283
#else
#error unsupported arch
#endif

static inline int splice(int fdin, int fdout, size_t len, unsigned long flags)
{
	return syscall(__NR_splice, fdin, fdout, len, flags);
}

int main(int argc, char *argv[])
{
	struct stat sb;
	int fd;

	if (argc < 2) {
		printf("%s: infile\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	if (fstat(fd, &sb) < 0) {
		perror("stat");
		return 1;
	}

	do {
		int ret = splice(fd, STDOUT_FILENO, sb.st_size, 0);

		if (ret < 0) {
			perror("splice");
			break;
		} else if (!ret)
			break;

		sb.st_size -= ret;
	} while (1);

	close(fd);
	return 0;
}

--GPJrCs/72TxItFYR
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="splice-out.c"

/*
 * Splice stdout to file
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define SPLICE_SIZE	(64*1024)

#if defined(__i386__)
#define __NR_splice	313
#elif defined(__x86_64__)
#define __NR_splice	275
#elif defined(__powerpc__) || defined(__powerpc64__)
#define __NR_splice	283
#else
#error unsupported arch
#endif

static inline int splice(int fdin, int fdout, size_t len, unsigned long flags)
{
	return syscall(__NR_splice, fdin, fdout, len, flags);
}

int main(int argc, char *argv[])
{
	int fd;

	if (argc < 2) {
		printf("%s: outfile\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	do {
		int ret = splice(STDIN_FILENO, fd, SPLICE_SIZE, 0);

		if (ret < 0) {
			perror("splice");
			break;
		} else if (ret < SPLICE_SIZE)
			break;
	} while (1);

	close(fd);
	return 0;
}

--GPJrCs/72TxItFYR
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="splice-net.c"

/*
 * Splice stdin to net
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

#define SPLICE_SIZE	(64*1024)

#if defined(__i386__)
#define __NR_splice	313
#elif defined(__x86_64__)
#define __NR_splice	275
#elif defined(__powerpc__) || defined(__powerpc64__)
#define __NR_splice	283
#else
#error unsupported arch
#endif

static inline int splice(int fdin, int fdout, size_t len, unsigned long flags)
{
	return syscall(__NR_splice, fdin, fdout, len, flags);
}

int main(int argc, char *argv[])
{
	struct sockaddr_in addr;
	unsigned short port;
	int fd;

	if (argc < 3) {
		printf("%s: target port\n", argv[0]);
		return 1;
	}

	port = atoi(argv[2]);

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_port = htons(port);

	if (inet_aton(argv[1], &addr.sin_addr) != 1) {
		struct hostent *hent = gethostbyname(argv[1]);

		if (!hent) {
			perror("gethostbyname");
			return 1;
		}

		memcpy(&addr.sin_addr, hent->h_addr, 4);
	}

	printf("Connecting to %s/%d\n", argv[1], port);

	fd = socket(AF_INET, SOCK_STREAM, 0);
	if (fd < 0) {
		perror("socket");
		return 1;
	}

	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		perror("connect");
		return 1;
	}

	do {
		int ret = splice(STDIN_FILENO, fd, SPLICE_SIZE, 0);

		if (ret < 0) {
			perror("splice");
			break;
		} else if (!ret) {
			break;
		}
	} while (1);

	close(fd);
	return 0;
}

--GPJrCs/72TxItFYR--
