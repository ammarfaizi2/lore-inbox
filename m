Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288827AbSAIFfE>; Wed, 9 Jan 2002 00:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288826AbSAIFey>; Wed, 9 Jan 2002 00:34:54 -0500
Received: from [202.135.142.194] ([202.135.142.194]:10503 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288829AbSAIFeo>; Wed, 9 Jan 2002 00:34:44 -0500
Date: Wed, 9 Jan 2002 14:32:42 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: kravetz@us.ibm.com, mingo@elte.hu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-Id: <20020109143242.013a0a31.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.40.0201082057560.936-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <20020108193904.A1068@w-mikek2.beaverton.ibm.com>
	<Pine.LNX.4.40.0201082057560.936-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002 21:05:23 -0800 (PST)
Davide Libenzi <davidel@xmailserver.org> wrote:
> Mike can you try the patch listed below on custom pre-10 ?
> I've got 30-70% better performances with the chat_s/c test.

I'd encourage you to use hackbench, which is basically "the part of chat_c/s
that is interesting".

And I'd encourage you to come up with a better name, too 8)

Cheers,
Rusty.

/* Simple scheduler test. */
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/poll.h>

static int use_pipes = 0;

static void barf(const char *msg)
{
	fprintf(stderr, "%s (error: %s)\n", msg, strerror(errno));
	exit(1);
}

static void fdpair(int fds[2])
{
	if (use_pipes) {
		if (pipe(fds) == 0)
			return;
	} else {
		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
			return;
	}
	barf("Creating fdpair");
}

/* Block until we're ready to go */
static void ready(int ready_out, int wakefd)
{
	char dummy;
	struct pollfd pollfd = { .fd = wakefd, .events = POLLIN };

	/* Tell them we're ready. */
	if (write(ready_out, &dummy, 1) != 1)
		barf("CLIENT: ready write");

	/* Wait for "GO" signal */
	if (poll(&pollfd, 1, -1) != 1)
		barf("poll");
}

static void reader(int ready_out, int wakefd, unsigned int loops, int fd)
{
	char dummy;
	unsigned int i;

	ready(ready_out, wakefd);

	for (i = 0; i < loops; i++) {
		if (read(fd, &dummy, 1) != 1)
			barf("READER: read");
	}
}

/* Start the server */
static void server(int ready_out, int wakefd,
		   unsigned int loops, unsigned int num_fds)
{
	unsigned int i;
	int write_fds[num_fds];
	unsigned int counters[num_fds];

	for (i = 0; i < num_fds; i++) {
		int fds[2];

		fdpair(fds);
		switch (fork()) {
		case -1: barf("fork()");
		case 0:
			close(fds[1]);
			reader(ready_out, wakefd, loops, fds[0]);
			exit(0);
		}
		close(fds[0]);
		write_fds[i] = fds[1];
		if (fcntl(write_fds[i], F_SETFL, O_NONBLOCK) != 0)
			barf("fcntl NONBLOCK");

		counters[i] = 0;
	}

	ready(ready_out, wakefd);

	for (i = 0; i < loops * num_fds;) {
		unsigned int j;
		char dummy;

		for (j = 0; j < num_fds; j++) {
			if (counters[j] < loops) {
				if (write(write_fds[j], &dummy, 1) == 1) {
					counters[j]++;
					i++;
				} else if (errno != EAGAIN)
					barf("write");
			}
		}
	}

	/* Reap them all */
	for (i = 0; i < num_fds; i++) {
		int status;
		wait(&status);
		if (!WIFEXITED(status))
			exit(1);
	}
	exit(0);
}

int main(int argc, char *argv[])
{
	unsigned int i;
	struct timeval start, stop, diff;
	unsigned int num_fds;
	int readyfds[2], wakefds[2];
	char dummy;
	int status;

	if (argv[1] && strcmp(argv[1], "-pipe") == 0) {
		use_pipes = 1;
		argc--;
		argv++;
	}

	if (argc != 2 || (num_fds = atoi(argv[1])) == 0)
		barf("Usage: hackbench2 [-pipe] <num pipes>\n");

	fdpair(readyfds);
	fdpair(wakefds);

	switch (fork()) {
	case -1: barf("fork()");
	case 0:
		server(readyfds[1], wakefds[0], 10000, num_fds);
		exit(0);
	}

	/* Wait for everyone to be ready */
	for (i = 0; i < num_fds+1; i++)
		if (read(readyfds[0], &dummy, 1) != 1)
			barf("Reading for readyfds");

	gettimeofday(&start, NULL);

	/* Kick them off */
	if (write(wakefds[1], &dummy, 1) != 1)
		barf("Writing to start them");

	/* Reap server */
	wait(&status);
	if (!WIFEXITED(status))
		exit(1);

	gettimeofday(&stop, NULL);

	/* Print time... */
	timersub(&stop, &start, &diff);
	printf("Time: %lu.%03lu\n", diff.tv_sec, diff.tv_usec/1000);
	exit(0);
}
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
