Return-Path: <linux-kernel-owner+w=401wt.eu-S1161030AbXALICT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbXALICT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 03:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbXALICT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 03:02:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36335 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbXALICS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 03:02:18 -0500
Date: Fri, 12 Jan 2007 08:58:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
Message-ID: <20070112075816.GA23341@elte.hu>
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <45A73E90.7050805@bull.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Pierre Peiffer <pierre.peiffer@bull.net> wrote:

> [...] Any measure will be difficult to do with only FUTEX_WAIT/WAKE.

that's not a problem - just do such a measurement and show that it does 
/not/ impact performance measurably. That's what we want to know...

> (*) I'll try the volano bench, if I have time.

yeah. As an alternative, it might be a good idea to pthread-ify 
hackbench.c - that should replicate the Volano workload pretty 
accurately. I've attached hackbench.c. (it's process based right now, so 
it wont trigger contended futex ops)

	Ingo

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hackbench.c"

/* Test groups of 20 processes spraying to 20 receivers */
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/poll.h>

#define DATASIZE 100
static unsigned int loops = 100;
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

/* Sender sprays loops messages down each file descriptor */
static void sender(unsigned int num_fds,
                   int out_fd[num_fds],
                   int ready_out,
                   int wakefd)
{
        char data[DATASIZE];
        unsigned int i, j;

        ready(ready_out, wakefd);

        /* Now pump to every receiver. */
        for (i = 0; i < loops; i++) {
                for (j = 0; j < num_fds; j++) {
                        int ret, done = 0;

                again:
                        ret = write(out_fd[j], data + done, sizeof(data)-done);
                        if (ret < 0)
                                barf("SENDER: write");
                        done += ret;
                        if (done < sizeof(data))
                                goto again;
                }
        }
}

/* One receiver per fd */
static void receiver(unsigned int num_packets,
                     int in_fd,
                     int ready_out,
                     int wakefd)
{
        unsigned int i;

        /* Wait for start... */
        ready(ready_out, wakefd);

        /* Receive them all */
        for (i = 0; i < num_packets; i++) {
                char data[DATASIZE];
                int ret, done = 0;

        again:
                ret = read(in_fd, data + done, DATASIZE - done);
                if (ret < 0)
                        barf("SERVER: read");
                done += ret;
                if (done < DATASIZE)
                        goto again;
        }
}

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
        unsigned int i;
        unsigned int out_fds[num_fds];

        for (i = 0; i < num_fds; i++) {
                int fds[2];

                /* Create the pipe between client and server */
                fdpair(fds);

                /* Fork the receiver. */
                switch (fork()) {
                case -1: barf("fork()");
                case 0:
                        close(fds[1]);
                        receiver(num_fds*loops, fds[0], ready_out, wakefd);
                        exit(0);
                }

                out_fds[i] = fds[1];
                close(fds[0]);
        }

        /* Now we have all the fds, fork the senders */
        for (i = 0; i < num_fds; i++) {
                switch (fork()) {
                case -1: barf("fork()");
                case 0:
                        sender(num_fds, out_fds, ready_out, wakefd);
                        exit(0);
                }
        }

        /* Close the fds we have left */
        for (i = 0; i < num_fds; i++)
                close(out_fds[i]);

        /* Return number of children to reap */
        return num_fds * 2;
}

int main(int argc, char *argv[])
{
        unsigned int i, num_groups, total_children;
        struct timeval start, stop, diff;
        unsigned int num_fds = 20;
        int readyfds[2], wakefds[2];
        char dummy;

        if (argv[1] && strcmp(argv[1], "-pipe") == 0) {
                use_pipes = 1;
                argc--;
                argv++;
        }

        if (argc != 2 || (num_groups = atoi(argv[1])) == 0)
                barf("Usage: hackbench [-pipe] <num groups>\n");

        fdpair(readyfds);
        fdpair(wakefds);

        total_children = 0;
        for (i = 0; i < num_groups; i++)
                total_children += group(num_fds, readyfds[1], wakefds[0]);

        /* Wait for everyone to be ready */
        for (i = 0; i < total_children; i++)
                if (read(readyfds[0], &dummy, 1) != 1)
                        barf("Reading for readyfds");

        gettimeofday(&start, NULL);

        /* Kick them off */
        if (write(wakefds[1], &dummy, 1) != 1)
                barf("Writing to start them");

        /* Reap them all */
        for (i = 0; i < total_children; i++) {
                int status;
                wait(&status);
                if (!WIFEXITED(status))
                        exit(1);
        }

        gettimeofday(&stop, NULL);

        /* Print time... */
        timersub(&stop, &start, &diff);
        printf("Time: %lu.%03lu\n", diff.tv_sec, diff.tv_usec/1000);
        exit(0);
}

--XsQoSWH+UP9D9v3l--
