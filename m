Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265356AbUF2CCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUF2CCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 22:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUF2CCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 22:02:31 -0400
Received: from holomorphy.com ([207.189.100.168]:24997 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265356AbUF2CCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 22:02:15 -0400
Date: Mon, 28 Jun 2004 19:02:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com
Subject: Re: kiocb->private is too large for kiocb's on-stack
Message-ID: <20040629020208.GJ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com
References: <20040628080801.GO21066@holomorphy.com> <20040628011232.43acd3b8.akpm@osdl.org> <20040628082016.GP21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628082016.GP21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/* On Mon, Jun 28, 2004 at 01:12:32AM -0700, Andrew Morton wrote:
>> That's so much better than what we had before it ain't funny.
>> Was this runtime tested?

On Mon, Jun 28, 2004 at 01:20:16AM -0700, William Lee Irwin III wrote:
> Yes. Oracle exercises this, and it survives OAST.
> I'll write a dedicated userspace testcase for the aio operations and
> follow up with that.

This is pretty damn mindless but seems to pound on the stuff. Maybe
something better can be devised (e.g. passing msgs around in a ring).


-- wli */

#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>
#include <limits.h>
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <sys/epoll.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <linux/aio_abi.h>

#define die()								\
	do {								\
		int __err = errno;					\
		perror(__FUNCTION__);					\
		fprintf(stderr, "dead in %s() at %s:%d errno = %d\n",	\
			__FUNCTION__, __FILE__, __LINE__, __err);	\
		abort();						\
	} while (0)

pid_t gettid(void)
{
	return syscall(__NR_gettid);
}

long io_submit(aio_context_t context, long n, struct iocb **iocbs)
{
	return syscall(__NR_io_submit, context, n, iocbs);
}

long io_setup(unsigned n, aio_context_t *context)
{
	return syscall(__NR_io_setup, n, context);
}

long io_getevents(aio_context_t context, long min, long n,
				struct io_event *events, struct timespec *ts)
{
	return syscall(__NR_io_getevents, context, min, n, events, ts);
}

int epoll_add(int epfd, int fd, struct epoll_event *event)
{
	return epoll_ctl(epfd, EPOLL_CTL_ADD, fd, event);
}

static void *client(void *arg)
{
	int n = 0, *fds = arg;
	pthread_t id = pthread_self();

	while (1) {
		write(fds[1], &id, sizeof(pthread_t));
		read(fds[1], &id, sizeof(pthread_t));
		++n;
		if (!(n % (1 << 16)))
			printf("boo from %d\n", gettid());
	}
}

int main(int argc, char * const argv[])
{
	long i, j, k, nr_clients;
	pthread_t *clients;
	int *svs, epfd;
	struct epoll_event *events;
	aio_context_t context = 0;
	struct iocb *iocbs, **iocbps;
	struct io_event *io_events;
	pthread_t *bufs;

	if (argc != 2)
		return EXIT_FAILURE;
	nr_clients = strtol(argv[1], NULL, 0);
	if (nr_clients >= INT_MAX || nr_clients < 0)
		return EXIT_FAILURE;
	if ((size_t)nr_clients >= SIZE_MAX/sizeof(pthread_t))
		return EXIT_FAILURE;
	if ((size_t)nr_clients >= SIZE_MAX/(2*sizeof(int)))
		return EXIT_FAILURE;
	if ((size_t)nr_clients >= SIZE_MAX/(2*sizeof(struct iocb)))
		return EXIT_FAILURE;
	if ((size_t)nr_clients >= SIZE_MAX/(2*sizeof(struct iocb *)))
		return EXIT_FAILURE;
	if ((size_t)nr_clients >= SIZE_MAX/(2*sizeof(struct io_event)))
		return EXIT_FAILURE;
	if (!(bufs = calloc(nr_clients, 2*sizeof(pthread_t))))
		return EXIT_FAILURE;
	if (!(clients = calloc(nr_clients, sizeof(pthread_t)))) {
		die();
		goto free_bufs;
	}
	if (!(svs = calloc(nr_clients, 2*sizeof(int)))) {
		die();
		goto free_clients;
	}
	if (!(events = calloc(nr_clients, sizeof(struct epoll_event)))) {
		die();
		goto free_svs;
	}
	if (!(iocbs = calloc(nr_clients, 2*sizeof(struct iocb)))) {
		die();
		goto free_events;
	}
	if (!(iocbps = calloc(nr_clients, 2*sizeof(struct iocb *)))) {
		die();
		goto free_iocbs;
	}
	if (!(io_events = calloc(nr_clients, sizeof(struct io_event)))) {
		die();
		goto free_iocbps;
	}
	memset(clients, 0, sizeof(pthread_t)*nr_clients);
	memset(svs, 0, 2*sizeof(int)*nr_clients);
	memset(iocbs, 0, 2*sizeof(struct iocb)*nr_clients);
	memset(iocbps, 0, 2*sizeof(struct iocb *)*nr_clients);
	memset(io_events, 0, 2*sizeof(struct io_event)*nr_clients);
	if ((epfd = epoll_create(nr_clients)) < 0) {
		die();
		goto free_io_events;
	}
	if (io_setup(nr_clients, &context)) {
		die();
		goto free_io_events;
	}
	for (i = 0; i < nr_clients; ++i) {
		struct epoll_event event = {
			.events = EPOLLIN|EPOLLET,
			.data.ptr = &svs[2*i],
		};
		if (socketpair(AF_UNIX, SOCK_STREAM, 0, &svs[2*i])) {
			die();
		}
		if (epoll_add(epfd, svs[2*i], &event))
			die();
		if (pthread_create(&clients[i], NULL, client, &svs[2*i]))
			abort();
	}
	while (1) {
		struct timespec ts = { .tv_sec = 0, .tv_nsec = 0, };
		j = epoll_wait(epfd, events, nr_clients, 0);
		k = io_getevents(context, 1, nr_clients, io_events, &ts);
		for (i = 0; i < k; ++i) {
			struct iocb *cb =
				(struct iocb *)(unsigned long)io_events[i].obj;
			cb->aio_data = 0;
			if (cb->aio_lio_opcode == IOCB_CMD_PREAD)
				bufs[2*(cb - iocbs)+1] = bufs[2*(cb - iocbs)];
		}
		for (i = 0; i < j; ++i) {
			int m, n = ((int *)events[i].data.ptr - svs)/2;

			m = (n + 1) % nr_clients;
			bufs[2*i+1] = clients[m];
			iocbs[2*n].aio_lio_opcode = IOCB_CMD_PREAD;
			iocbs[2*n+1].aio_lio_opcode = IOCB_CMD_PWRITE;
			iocbs[2*n].aio_fildes = svs[2*n];
			iocbs[2*n+1].aio_fildes = svs[2*n];
			iocbs[2*n].aio_buf = (unsigned long)&bufs[2*i];
			iocbs[2*n+1].aio_buf = (unsigned long)&bufs[2*i+1];
			iocbs[2*n].aio_data = (unsigned long)&bufs[2*i];
			iocbs[2*n+1].aio_data = (unsigned long)&bufs[2*i+1];
			iocbs[2*n].aio_nbytes = sizeof(pthread_t);
			iocbs[2*n+1].aio_nbytes = sizeof(pthread_t);
			iocbs[2*n].aio_offset = 0;
			iocbs[2*n+1].aio_offset = 0;
			iocbps[2*i] = &iocbs[2*n];
			iocbps[2*i+1] = &iocbs[2*n+1];
		}
		if (j)
			io_submit(context, 2*j, iocbps);
	}
free_io_events:
	free(io_events);
free_iocbps:
	free(iocbps);
free_iocbs:
	free(iocbs);
free_events:
	free(events);
free_svs:
	free(svs);
free_clients:
	free(clients);
free_bufs:
	free(bufs);
	die();
}
