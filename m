Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424644AbWKPVYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424644AbWKPVYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424641AbWKPVYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:24:23 -0500
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:20997 "EHLO
	sentry.sandia.gov") by vger.kernel.org with ESMTP id S1424644AbWKPVYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:24:22 -0500
X-Server-Uuid: 90CB8AE7-3E4E-4A99-82E1-C9C733D7F589
Subject: Re: splice/vmsplice performance test results
From: "Jim Schutt" <jaschut@sandia.gov>
To: "Jens Axboe" <jens.axboe@oracle.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061116202529.GH7164@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov>
 <20061116202529.GH7164@kernel.dk>
Date: Thu, 16 Nov 2006 14:24:09 -0700
Message-ID: <1163712249.2672.43.camel@sale659.sandia.gov>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27)
X-TMWD-Spam-Summary: TS=20061116212412; SEV=2.2.0; DFV=B2006111609;
 IFV=2.0.4,4.0-9; AIF=B2006111609; RPD=5.02.0004; ENG=IBF; RPDID=NA;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2006111609_5.02.0004_4.0-9
X-WSS-ID: 694209702JC4090179-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 21:25 +0100, Jens Axboe wrote:
> On Thu, Nov 16 2006, Jim Schutt wrote:
> > Hi,
> > 

> > 
> > My test program can do one of the following:
> > 
> > send data:
> >  A) read() from file into buffer, write() buffer into socket
> >  B) mmap() section of file, write() that into socket, munmap()
> >  C) splice() from file to pipe, splice() from pipe to socket
> > 
> > receive data:
> >  1) read() from socket into buffer, write() buffer into file
> >  2) ftruncate() to extend file, mmap() new extent, read() 
> >       from socket into new extent, munmap()
> >  3) read() from socket into buffer, vmsplice() buffer to 
> >      pipe, splice() pipe to file (using the double-buffer trick)
> > 
> > Here's the results, using:
> >  - 64 KiB buffer, mmap extent, or splice
> >  - 1 MiB TCP window
> >  - 16 GiB data sent across network
> > 
> > A) from /dev/zero -> 1) to /dev/null : 857 MB/s (6.86 Gb/s)
> > 
> > A) from file      -> 1) to /dev/null : 472 MB/s (3.77 Gb/s)
> > B) from file      -> 1) to /dev/null : 366 MB/s (2.93 Gb/s)
> > C) from file      -> 1) to /dev/null : 854 MB/s (6.83 Gb/s)
> > 
> > A) from /dev/zero -> 1) to file      : 375 MB/s (3.00 Gb/s)
> > A) from /dev/zero -> 2) to file      : 150 MB/s (1.20 Gb/s)
> > A) from /dev/zero -> 3) to file      : 286 MB/s (2.29 Gb/s)
> > 
> > I had (naively) hoped the read/vmsplice/splice combination would 
> > run at the same speed I can write a file, i.e. at about 450 MB/s
> > on my setup.  Do any of my numbers seem bogus, so I should look 
> > harder at my test program?
> 
> Could be read-ahead playing in here, I'd have to take a closer look at
> the generated io patterns to say more about that. Any chance you can
> capture iostat or blktrace info for such a run to compare that goes to
> the disk? 

I can try.  Do you prefer iostat or blktrace, or would you like both?
Can you point me at some instructions?

> Can you pass along the test program?

Inserted inline below.

> 
> > Or is read+write really the fastest way to get data off a
> > socket and into a file?
> 
> splice() should be just as fast of course, and more efficient. Not a lot
> of real-life performance tuning has gone into it yet, so I would not be
> surprised if we need to smoothen a few edges.
> 

I'm glad I can help a little here.

-- Jim

Here's a splice.h I'm using, based on your example:
-----------------------

/* Implement splice syscall support for glibc versions that don't
 * have it.
 */

#ifndef __do_splice_syscall_h__
#define __do_splice_syscall_h__

#include <sys/syscall.h>
#include <unistd.h>

#if defined(__i386__)

/* From kernel tree include/asm-i386/unistd.h
 */
#ifndef __NR_splice
#define __NR_splice   313
#endif
#ifndef __NR_vmsplice
#define __NR_vmsplice 316
#endif

#elif defined(__x86_64__)

/* From kernel tree include/asm-x86_64/unistd.h
 */
#ifndef __NR_splice
#define __NR_splice   275
#endif
#ifndef __NR_vmsplice
#define __NR_vmsplice 278
#endif

#else
#error unsupported architecture
#endif

/* From kernel tree include/linux/pipe_fs_i.h
 */
#define SPLICE_F_MOVE	(0x01)	 /* move pages instead of copying */
#define SPLICE_F_NONBLOCK (0x02) /* don't block on the pipe splicing
(but */
				 /* we may still block on the fd we splice */
				 /* from/to, of course */
#define SPLICE_F_MORE   (0x04)	 /* expect more data */
#define SPLICE_F_GIFT   (0x08)	 /* pages passed in are a gift */

#ifndef SYS_splice
#define SYS_splice __NR_splice
#endif
#ifndef SYS_vmsplice
#define SYS_vmsplice __NR_vmsplice
#endif


#ifndef _LARGEFILE64_SOURCE
#error need -D_LARGEFILE64_SOURCE
#endif

static inline
int splice(int fd_in, off64_t *off_in, int fd_out, off64_t *off_out,
	   size_t len, unsigned int flags)
{
	return syscall(SYS_splice, fd_in, off_in,
		       fd_out, off_out, len, flags);
}

struct iovec;

static inline
int vmsplice(int fd, const struct iovec *iov,
	     unsigned long nr_segs, unsigned int flags)
{
	return syscall(SYS_vmsplice, fd, iov, nr_segs, flags);
}


#endif /* __do_splice_syscall_h__ */

------------------

And here's the test program itself:


/* Copyright 2006 Sandia Corporation.
 *
 * This file is free software; you can redistribute it and/or modify
 * it under the terms of version 2 of the GNU General Public License,
 * as published by the Free Software Foundation.
 */

/* Compile with -DHAVE_SPLICE_SYSCALL if you _know_ your kernel
 * has splice/vmsplice support.
 */

#ifndef _LARGEFILE64_SOURCE
#error need -D_LARGEFILE64_SOURCE
#endif


#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <sys/sendfile.h>

#include <netdb.h>
#include <sys/socket.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <resolv.h>

#define ALIGN(value,size) (((value) + (size) - 1) & ~((size) - 1))

/* Once glibc implements splice(), SYS_splice will be defined in 
 * system headers.  Until then we need to use our own stuff to access
 * these syscalls in new kernels.
 */
#ifdef HAVE_SPLICE_SYSCALL
#ifndef SYS_splice
#include <splice.h>
#endif
#endif

#define OPTION_FLAGS "b:c:hl:m:op:tw:"

const char usage[] = "\n\
dnd [OPTION] ... <file> \n\
\n\
	Performs a timed disk-network-disk data transfer, using TCP/IP \n\
	as the network protocol. \n\
\n\
	When dnd is invoked with \"-c <remote-host>\", it connects to \n\
	<remote-host> and sends the contents of <file>.  Otherwise, it \n\
	accepts a connection and writes the data received over the \n\
	connection into <file>.  On the sender side, timing starts just \n\
	before the first byte is read from the file, and stops just after \n\
	the last byte of data is sent.  On the receiver side, timing starts \n\
	just before the first byte is received, and stops just after the \n\
	last byte is synced to disk. \n\
\n\
	-b <bsz> \n\
		Use a buffer of size <bsz> bytes to move data.  The default \n\
		value is 65536 bytes. The value for <bsz> may be suffixed \n\
		with one of the following multipliers: \n\
		  k	*1000 \n\
		  M	*1000*1000 \n\
		  G	*1000*1000*1000 \n\
		  Ki	*1024 \n\
		  Mi	*1024*1024 \n\
		  Gi	*1024*1024*1024 \n\
	-c <remote-host> \n\
		Connect to <rhost> to send the data in <file>. \n\
		If not specified, listen for connections and receive data \n\
		into <file>. \n\
	-h \n\
		Print this message. \n\
	-l <sz> \n\
		Limit the transfer to at most <sz> bytes.  The value for \n\
		  <sz> may be suffixed as for the '-b' option.  Valid only \n\
		  if the '-c' option is also present.\n\
	-m <method> \n\
		Select one of the following methods: \n\
		mmap	Use mmap system call on the file descriptor and \n\
			  read/write system calls on the socket descriptor. \n\
		rw	Use read/write system calls on both the file \n\
			  descriptor and the socket descriptor. (Default) \n\
		sendfile \n\
			Use the sendfile system call to send data. \n\
		splice	Use the splice system call. Currently only supports \n\
			  a splice from the file to the socket. \n\
		vmsplice \n\
			Use the read system call to receive data from the \n\
			  socket into memory, and the vmsplice system call \n\
			  to move the data into the file. \n\
	-o \n\
		If writing to <file> and it already exists, overwrite its \n\
		data and truncate it to the total number of bytes received.\n\
	-p <port> \n\
		Either listen on <port>, or attempt to connect to \n\
		<remote_host>:<port>.  The default port is 13931. \n\
	-t \n\
		If writing to <file> and it already exists, truncate it \n\
		to zero length before writing to it.\n\
	-w <wsz> \n\
		Use a TCP window size of <wsz> bytes, which may be suffixed \n\
		as for <bsz> above.  The default value is 131072 bytes.\n\
\n\
";


enum method {MMAP, RW, SENDFILE, SPLICE, VMSPLICE};

struct options {
	enum method use;

	unsigned int truncate:1;
	unsigned int overwrite:1;
	unsigned int readfile:1;

	uint64_t limit;
	int win_size;
	size_t buf_size;
	unsigned short def_port;

	char *host_str;
	char *file;
	char *buf;
	void *private;
};

typedef uint64_t (*move_function)(const struct options *opts,
				  int from_fd, int to_fd);

union pipe_fd {
	int fda[2];
	struct {
		int r;
		int w;
	} fd;
};

static struct options dnd_opts = {
	.use = RW,
	.buf_size = 64 * 1024,
	.win_size = 128 * 1024,
	.def_port = 13931
};

uint64_t dt_usec(struct timeval *start, struct timeval *stop)
{
	uint64_t dt;

	dt = stop->tv_sec - start->tv_sec;
	dt *= 1000000;
	dt += stop->tv_usec - start->tv_usec;
	return dt;
}

static
uint64_t suffix(const char *str)
{
	uint64_t s = 1;

	switch (*str) {
	case 'k':
		s *= 1000;
		break;
	case 'K':
		if (*(str+1) == 'i')
			s *= 1024;
		break;
	case 'M':
		if (*(str+1) == 'i')
			s *= 1024*1024;
		else
			s *= 1000*1000;
		break;
	case 'G':
		if (*(str+1) == 'i')
			s *= 1024*1024*1024;
		else
			s *= 1000*1000*1000;
		break;
	}

	return s;
}

int open_file(const struct options *opts)
{
	int fd, err;
	mode_t o_mode = 0644;
	int o_flags = O_LARGEFILE;

	if (opts->use == MMAP)
		o_flags |= O_RDWR;
	else {
		if (opts->readfile)
			o_flags |= O_RDONLY;
		else
			o_flags |= O_WRONLY;
	}

	if (!opts->readfile) {
		o_flags |= O_CREAT;
		if (opts->truncate)
			o_flags |= O_TRUNC;
		else if (!opts->overwrite)
			o_flags |= O_EXCL;
	}
	fd = open64(opts->file, o_flags, o_mode);
	if (fd < 0) {
		perror("Open data file");
		exit(EXIT_FAILURE);
	}
	return fd;
}

int connect_to(const struct options *opts, struct sockaddr_in6 *saddr)
{
	int fd;
	int optval;
	socklen_t optlen;
	int err;

	struct hostent *tgt;

	/* Turn on IPv6 resolver action - gethostbyname() will always
	 * return IPv6 addresses.
	 */
	res_init();
	_res.options |= RES_USE_INET6;

	tgt = gethostbyname(opts->host_str);
	if (!tgt) {
		herror("gethostbyname/IPv6");
		exit(EXIT_FAILURE);
	}
	if (tgt->h_addrtype != AF_INET6) {
		fprintf(stderr, 
			"Error: got non-IPv6 address from gethostbyname!\n");
		exit(EXIT_FAILURE);
	}
#if 1
	{
		char buf[INET6_ADDRSTRLEN+1] = {0,};
		char **ptr;

		printf("connecting to host: %s\n", opts->host_str);
		printf("  canonical name: %s\n", tgt->h_name);
		ptr = tgt->h_aliases;
		while (*ptr) {
			printf("  alias: %s\n", *ptr);
			++ptr;
		}
		ptr = tgt->h_addr_list;
		while (*ptr) {
			if (!inet_ntop(tgt->h_addrtype, *ptr,
				       buf, INET6_ADDRSTRLEN+1)) {
				perror("inet_ntop/IPv6");
				exit(EXIT_FAILURE);
			}
			printf("  address: %s\n", buf);
			++ptr;
		}
	}
#endif
	fd = socket(PF_INET6, SOCK_STREAM, 0);
	if (fd == -1) {
		perror("Open IPv6 socket");
		exit(EXIT_FAILURE);
	}

	optval = opts->win_size;
	optlen = sizeof(optval);
	err = setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &optval, optlen);
	if (err) {
		perror("Set IPv6 socket SO_SNDBUF");
		exit(EXIT_FAILURE);
	}
	optlen = sizeof(optval);
	err = getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &optval, &optlen);
	if (err) {
		perror("Get IPv6 socket SO_SNDBUF");
		exit(EXIT_FAILURE);
	}
	if (optval != opts->win_size)
		printf("TCP send window size: requested %d actual %d\n",
		       opts->win_size, optval);

	saddr->sin6_family = AF_INET6;
	saddr->sin6_port = htons(opts->def_port);
	saddr->sin6_addr = *(struct in6_addr *)tgt->h_addr_list[0];

	err = connect(fd, (struct sockaddr *)saddr, sizeof(*saddr));
	if (err) {
		perror("Connect to remote host");
		exit(EXIT_FAILURE);
	}

	optval = 1;
	optlen = sizeof(optval);
	err = setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &optval, optlen);
	if (err) {
		perror("Set IPv6 socket TCP_NODELAY");
		exit(EXIT_FAILURE);
	}
	return fd;
}

int listen_for(const struct options *opts, struct sockaddr_in6 *saddr)
{
	int fd, lfd;
	int optval;
	socklen_t optlen;
	int err;

	lfd = socket(PF_INET6, SOCK_STREAM, 0);
	if (lfd == -1) {
		perror("Open IPv6 socket");
		exit(EXIT_FAILURE);
	}
	optval = 1;
	err = setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR,
			 &optval, sizeof(optval));
	if (err) {
		perror("Set IPv6 socket SO_REUSEADDR");
		exit(EXIT_FAILURE);
	}

	optval = opts->win_size;
	optlen = sizeof(optval);
	err = setsockopt(lfd, SOL_SOCKET, SO_RCVBUF, &optval, optlen);
	if (err) {
		perror("Set IPv6 socket SO_RCVBUF");
		exit(EXIT_FAILURE);
	}
	optlen = sizeof(optval);
	err = getsockopt(lfd, SOL_SOCKET, SO_RCVBUF, &optval, &optlen);
	if (err) {
		perror("Get IPv6 socket SO_RCVBUF");
		exit(EXIT_FAILURE);
	}
	if (optval != opts->win_size)
		printf("TCP receive window size: requested %d actual %d\n",
		       opts->win_size, optval);

	saddr->sin6_family = AF_INET6;
	saddr->sin6_port = htons(opts->def_port);
	saddr->sin6_addr = in6addr_any;

	err = bind(lfd, (struct sockaddr *)saddr, sizeof(*saddr));
	if (err) {
		perror("Bind IPv6 address");
		exit(EXIT_FAILURE);
	}
	err = listen(lfd, 1);
	if (err) {
		perror("Listen on IPv6 address");
		exit(EXIT_FAILURE);
	}
	fd = accept(lfd, NULL, 0);
	if (fd < 0) {
		perror("Accept new connection");
		exit(EXIT_FAILURE);
	}
	close(lfd);

	optval = 1;
	optlen = sizeof(optval);
	err = setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &optval, optlen);
	if (err) {
		perror("Set IPv6 socket TCP_NODELAY");
		exit(EXIT_FAILURE);
	}
	return fd;
}

int wait_on_connection(const struct options *opts)
{
	int sock_fd, err;
	struct sockaddr_in6 saddr;
	socklen_t saddr_len = sizeof(saddr);
	char buf[INET6_ADDRSTRLEN+1];

	if (opts->host_str)
		sock_fd = connect_to(opts, &saddr);
	else
		sock_fd = listen_for(opts, &saddr);

	err = getpeername(sock_fd, (struct sockaddr *)&saddr, &saddr_len);
	if (err) {
		perror("getpeername");
		exit(EXIT_FAILURE);
	}
	if (saddr.sin6_family != AF_INET6) {
		fprintf(stderr, 
			"Error: got non-IPv6 address from getpeername!\n");
		exit(EXIT_FAILURE);
	}
	if (!inet_ntop(AF_INET6, &saddr.sin6_addr,
		       buf, INET6_ADDRSTRLEN+1)) {
		perror("inet_ntop/IPv6");
		exit(EXIT_FAILURE);
	}
	printf("Connected to %s port %d\n",
	       buf, (int)ntohs(saddr.sin6_port));

	return sock_fd;
}

void setup_mmap(struct options *opts, int fd)
{
	struct stat64 sb;
	size_t pg_sz = sysconf(_SC_PAGESIZE);

	opts->buf_size = ALIGN(opts->buf_size, pg_sz);

	/* We'll just get the file size here so we don't time it later...
	 */
	if (fstat64(fd, &sb) < 0) {
		perror("Stat data file");
		exit(EXIT_FAILURE);
	}
	opts->private = malloc(sizeof(off64_t));
	if (!opts->private) {
		perror("Allocating private data");
		exit(EXIT_FAILURE);
	}
	*((off64_t *)opts->private) = sb.st_size;
}

uint64_t mmap_send(const struct options *opts, int fd, int sd)
{
	size_t bufl = opts->buf_size;
	off64_t fsz = *((off64_t *)opts->private);

	uint64_t bytes = 0;
	ssize_t n;
	size_t m, l;
	char *mem;
	int err;

	if (opts->limit && opts->limit < (uint64_t)fsz)
		fsz = opts->limit;

again:
	mem = mmap64(NULL, bufl, PROT_READ, MAP_SHARED, fd, bytes);
	if (mem == MAP_FAILED) {
		fprintf(stderr, "mmap %llu @ offset %llu: %s\n",
			(unsigned long long)bufl,
			(unsigned long long)bytes, strerror(errno));
		exit(EXIT_FAILURE);
	}
#ifdef USE_MADVISE
	err = madvise(mem, bufl, MADV_WILLNEED);
	if (err && errno != EAGAIN) {
		perror("madvise");
		exit(EXIT_FAILURE);
	}
#endif
	if (bytes + bufl < (uint64_t)fsz)
		l = bufl;
	else
		l = fsz - bytes;

	m = 0;
	while (l) {

	again2:
		n = write(sd, mem + m, l);
		if (n < 0) {
			if (errno == EINTR)
				goto again2;
			perror("write");
			exit(EXIT_FAILURE);
		}
		bytes += n;
		m += n;
		l -= n;
	}
	err = munmap(mem, bufl);
	if (err < 0) {
		fprintf(stderr, "munmap %llu: %s\n",
			(unsigned long long)bufl, strerror(errno));
		exit(EXIT_FAILURE);
	}
	if (bytes == (uint64_t)fsz)
		return bytes;

	goto again;
}

uint64_t mmap_recv(const struct options *opts, int sd, int fd)
{
	size_t bufl = opts->buf_size;

	uint64_t bytes = 0;
	ssize_t n;
	size_t m, l;
	char *mem;
	int err;

again:
	l = bufl;

	err = ftruncate64(fd, bytes + bufl);
	if (err < 0) {
		fprintf(stderr, "ftruncate to %llu: %s\n",
			(unsigned long long)bytes + bufl, strerror(errno));
		exit(EXIT_FAILURE);
	}
	mem = mmap64(NULL, bufl, PROT_WRITE, MAP_SHARED, fd, bytes);
	if (mem == MAP_FAILED) {
		fprintf(stderr, "mmap %llu @ offset %llu: %s\n",
			(unsigned long long)bufl,
			(unsigned long long)bytes, strerror(errno));
		exit(EXIT_FAILURE);
	}

	m = 0;
	while (l) {

	again2:
		n = read(sd, mem + m, l);
		if (n < 0) {
			if (errno == EINTR)
				goto again2;
			perror("Read");
			exit(EXIT_FAILURE);
		}
		if (n == 0) {
			err = munmap(mem, bufl);
			if (err < 0) {
				fprintf(stderr, "munmap %llu: %s\n",
					(unsigned long long)bufl,
					strerror(errno));
				exit(EXIT_FAILURE);
			}
			err = ftruncate64(fd, bytes);
			if (err < 0) {
				fprintf(stderr, "ftruncate to %llu: %s\n",
					(unsigned long long)bytes,
					strerror(errno));
				exit(EXIT_FAILURE);
			}
			fdatasync(fd);
			return bytes;
		}
		bytes += n;
		m += n;
		l -= n;
	}
	err = munmap(mem, bufl);
	if (err < 0) {
		fprintf(stderr, "munmap %llu: %s\n",
			(unsigned long long)bufl, strerror(errno));
		exit(EXIT_FAILURE);
	}
	goto again;
}

void setup_rw(struct options *opts)
{
	opts->buf = malloc(opts->buf_size);
	if (!opts->buf) {
		perror("Allocating data buffer");
		exit(EXIT_FAILURE);
	}
}

uint64_t read_write(const struct options *opts, int rfd, int wfd)
{
	char *buf = opts->buf;
	size_t bufl = opts->buf_size;

	uint64_t bytes = 0;
	ssize_t n, m, l;

again:
	if (opts->limit && bufl > opts->limit - bytes)
		bufl = opts->limit - bytes;

	l = read(rfd, buf, bufl);
	if (l < 0) {
		if (errno == EINTR)
			goto again;
		perror("Read");
		exit(EXIT_FAILURE);
	}
	if (l == 0 || (opts->limit && opts->limit == bytes)) {
		if (opts->readfile)
			close(wfd);
		else {
			ftruncate64(wfd, bytes);
			fdatasync(wfd);
		}
		return bytes;
	}

	m = 0;
	while (l) {

	again2:
		n = write(wfd, buf + m, l);
		if (n < 0) {
			if (errno == EINTR)
				goto again2;
			perror("Write");
			exit(EXIT_FAILURE);
		}
		m += n;
		l -= n;
	}
	bytes += m;
	goto again;
}

uint64_t sendfile_send(const struct options *opts, int fd, int sd)
{
	size_t bufl = opts->buf_size;

	uint64_t bytes = 0;
	off64_t os = 0;
	ssize_t l;

again:
	if (opts->limit && bufl > opts->limit - bytes)
		bufl = opts->limit - bytes;

	l = sendfile64(sd, fd, &os, bufl);
	if (l < 0) {
		perror("sendfile from file");
		exit(EXIT_FAILURE);
	}
	if (l == 0) {
		close(sd);
		return bytes;
	}
	bytes += l;

	goto again;
}

/* At least for now (as of 2.6.18-rc5), splice seems to hang if you
 * try to splice more data than the pipe can handle, rather than doing
 * what it can and returning what that was.  So, coerce user buffer down
 * to maximum pipe buffer size.
 */
#ifndef MAX_SPLICE_SIZE
#define MAX_SPLICE_SIZE (64 * 1024)
#endif

void setup_splice(struct options *opts)
{
	union pipe_fd *p;
	size_t pg_sz = sysconf(_SC_PAGESIZE);

	p = malloc(sizeof(union pipe_fd));
	if (!p) {
		perror("allocate pipe fds");
		exit(EXIT_FAILURE);
	}
	if (pipe(p->fda) < 0) {
		perror("opening pipe");
		exit(EXIT_FAILURE);
	}
	opts->private = p;

	if (opts->buf_size > MAX_SPLICE_SIZE)
		opts->buf_size = MAX_SPLICE_SIZE;

	opts->buf_size = ALIGN(opts->buf_size, pg_sz);
}

#ifdef HAVE_SPLICE_SYSCALL
uint64_t splice_send(const struct options *opts, int fd, int sd)
{
	union pipe_fd *p = opts->private;
	size_t bufl = opts->buf_size;

	uint64_t bytes = 0;
	ssize_t n, l;

again:
	if (opts->limit && bufl > opts->limit - bytes)
		bufl = opts->limit - bytes;

	l = splice(fd, NULL, p->fd.w, NULL, bufl, 
		   SPLICE_F_MORE | SPLICE_F_MOVE);
	if (l < 0) {
		perror("splice from file");
		exit(EXIT_FAILURE);
	}
	if (l == 0) {
		close(sd);
		return bytes;
	}

	while (l) {

		n = splice(p->fd.r, NULL, sd, NULL, l,
			   SPLICE_F_MORE | SPLICE_F_MOVE);
		if (n < 0) {
			perror("splice to socket");
			exit(EXIT_FAILURE);
		}
		l -= n;
		bytes += n;
	}
	goto again;
}
#else
move_function splice_send = NULL;
#endif

/* vmsplice moves pages backing a user address range to a pipe.
However,
 * you don't want the application changing data in that address range
 * after the pages have been moved to the pipe, but before they have
been
 * consumed at their destination.
 *
 * The solution is to double buffer: 
 *   load buffer A, vmsplice to pipe
 *   load buffer B, vmsplice to pipe
 * When the B->splice->pipe call completes, there can no longer be any
 * references in the pipe to the pages backing buffer A, since it is now
 * filled with references to the pages backing buffer B.  So, it is safe
 * to load new data into buffer A.
 */
void setup_vmsplice(struct options *opts)
{
	union pipe_fd *p;
	size_t pg_sz = sysconf(_SC_PAGESIZE);

	p = malloc(sizeof(union pipe_fd));
	if (!p) {
		perror("allocate pipe fds");
		exit(EXIT_FAILURE);
	}
	if (pipe(p->fda) < 0) {
		perror("opening pipe");
		exit(EXIT_FAILURE);
	}
	opts->private = p;

	if (opts->buf_size > MAX_SPLICE_SIZE)
		opts->buf_size = MAX_SPLICE_SIZE;

	opts->buf_size = ALIGN(opts->buf_size, pg_sz);

	opts->buf = malloc(2*opts->buf_size + pg_sz);
	if (!opts->buf) {
		perror("Allocating data buffer");
		exit(EXIT_FAILURE);
	}
	opts->buf = (char *)ALIGN((unsigned long)opts->buf,
				  (unsigned long)pg_sz);
}

#ifdef HAVE_SPLICE_SYSCALL
uint64_t vmsplice_recv(const struct options *opts, int sd, int fd)
{
	union pipe_fd *p = opts->private;
	struct iovec iov;

	uint64_t bytes = 0;
	ssize_t n, m, l;
	unsigned i = 1;

again:
	i = (i + 1) & 1;
	iov.iov_base = opts->buf + i * opts->buf_size;

again2:
	l = read(sd, iov.iov_base, opts->buf_size);
	if (l < 0) {
		if (errno == EINTR)
			goto again2;
		perror("Read");
		exit(EXIT_FAILURE);
	}
	if (l == 0) {
		fdatasync(fd);
		return bytes;
	}

	while (l) {
		iov.iov_len = l;

		n = vmsplice(p->fd.w, &iov, 1, 0);
		if (n < 0) {
			perror("vmsplice to pipe");
			exit(EXIT_FAILURE);
		}

		while (n) {
			m = splice(p->fd.r, NULL, fd, NULL, n, SPLICE_F_MORE);
			if (m < 0) {
				perror("splice to file");
				exit(EXIT_FAILURE);
			}
			n -= m;

			l -= m;
			bytes += m;
			iov.iov_base += m;
		}
	}
	goto again;
}
#else
move_function vmsplice_recv = NULL;
#endif

uint64_t move(const struct options *opts, int fd, int sd,
	      move_function do_send, move_function do_recv)
{
	uint64_t bytes;

	if (opts->readfile) {
		if (do_send)
			bytes = do_send(opts, fd, sd);
		else
			goto no_support;
	}
	else {
		if (do_recv)
			bytes = do_recv(opts, sd, fd);
		else
			goto no_support;
	}
	return bytes;

no_support:
	fprintf(stderr, "Sorry, method not implemented.\n");
	exit(EXIT_FAILURE);
}

int main(int argc, char *argv[])
{
	int sd, fd;

	uint64_t byte_cnt;

	struct timeval start;
	struct timeval stop;
	uint64_t et_usec;

	move_function do_send;
	move_function do_recv;

	while (1) {
		char *next_char;
		int c = getopt(argc, argv, OPTION_FLAGS);
		if (c == -1)
			break;

		switch (c) {
		case 'b':
		{
			uint64_t sz = strtoull(optarg, &next_char, 0);
			sz *= suffix(next_char);
			dnd_opts.buf_size = sz;
			if ((uint64_t)dnd_opts.buf_size != sz) {
				fprintf(stderr,
					"Error: invalid buffer size\n");
				exit(EXIT_FAILURE);
			}
		}
			break;
		case 'c':
			dnd_opts.host_str = strdup(optarg);
			dnd_opts.readfile = 1;
			break;
		case 'h':
			printf("%s", usage);
			exit(EXIT_SUCCESS);
		case 'l':
		{
			uint64_t sz = strtoull(optarg, &next_char, 0);
			sz *= suffix(next_char);
			dnd_opts.limit = sz;
		}
			break;
		case 'm':
			if (strncmp(optarg, "mmap", 32) == 0)
				dnd_opts.use = MMAP;
			else if (strncmp(optarg, "rw", 32) == 0)
				dnd_opts.use = RW;
			else if (strncmp(optarg, "sendfile", 32) == 0)
				dnd_opts.use = SENDFILE;
			else if (strncmp(optarg, "splice", 32) == 0)
				dnd_opts.use = SPLICE;
			else if (strncmp(optarg, "vmsplice", 32) == 0)
				dnd_opts.use = VMSPLICE;
			else {
				fprintf(stderr, 
					"Error: unknown method '%s'\n",
					optarg);
				exit(EXIT_FAILURE);
			}
			break;
		case 'o':
			dnd_opts.overwrite = 1;
                        break;
		case 'p':
		{
			unsigned long port = strtoul(optarg, NULL, 0);
			dnd_opts.def_port = port;
			if (dnd_opts.def_port == 0 ||
			    (unsigned long)dnd_opts.def_port != port) {
				fprintf(stderr,
					"Error: invalid port\n");
				exit(EXIT_FAILURE);
			}
		}
			break;
		case 't':
			dnd_opts.truncate = 1;
			break;
		case 'w':
 		{
			uint64_t wsz = strtoull(optarg, &next_char, 0);
			wsz *= suffix(next_char);
			dnd_opts.win_size = wsz;
			if ((uint64_t)dnd_opts.win_size != wsz) {
				fprintf(stderr,
					"Error: invalid window size\n");
				exit(EXIT_FAILURE);
			}
		}
			break;
		}
	}
	if (dnd_opts.limit && !dnd_opts.readfile) {
		fprintf(stderr, "Error: can only limit transfer as sender!\n"
			"  (I.e., when also using '-c' option.)\n");
		exit(EXIT_FAILURE);
	}
	if (dnd_opts.truncate && dnd_opts.overwrite) {
		fprintf(stderr, "Error: cannot both overwrite "
			"and truncate data file!\n");
		exit(EXIT_FAILURE);
	}
	if (argc == 1) {
		printf("%s", usage);
		exit(EXIT_SUCCESS);
	}
	if (optind+1 != argc) {
		fprintf(stderr, "Error: need a filename\n");
		exit(EXIT_FAILURE);
	}
	dnd_opts.file = strdup(argv[optind]);

	fd = open_file(&dnd_opts);
	sd = wait_on_connection(&dnd_opts);

	switch (dnd_opts.use) {
	case MMAP:
		printf("Using mmap with read/write calls\n");
		setup_mmap(&dnd_opts, fd);
		do_send = mmap_send;
		do_recv = mmap_recv;
		break;
	case RW:
		printf("Using read/write calls\n");
		setup_rw(&dnd_opts);
		do_send = read_write;
		do_recv = read_write;
		break;
	case SENDFILE:
		printf("Using sendfile calls\n");
		do_send = sendfile_send;
		do_recv = NULL;
		break;
	case SPLICE:
		printf("Using splice calls\n");
		setup_splice(&dnd_opts);
		do_send = splice_send;
		do_recv = NULL;
		break;
	case VMSPLICE:
		printf("Using vmsplice with read/write calls\n");
		setup_vmsplice(&dnd_opts);
		do_send = NULL;
		do_recv = vmsplice_recv;
		break;
	}
	printf("Buffer size %u bytes\n", (unsigned)dnd_opts.buf_size);

	gettimeofday(&start, NULL);

	byte_cnt = move(&dnd_opts, fd, sd, do_send, do_recv);

	gettimeofday(&stop, NULL);
	et_usec = dt_usec(&start, &stop);

	printf("\n%s %llu KiB in %.3f sec: %.3f MB/s (%.3f Gb/s)\n\n",
	       (dnd_opts.readfile ? "Sent" : "Received"),
	       (unsigned long long)byte_cnt/1024, (1.e-6 * et_usec),
	       ((float)byte_cnt/et_usec),
	       8*((float)byte_cnt/et_usec)/1000);

	exit(EXIT_SUCCESS);
}




