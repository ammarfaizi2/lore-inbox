Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbTCKRze>; Tue, 11 Mar 2003 12:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbTCKRze>; Tue, 11 Mar 2003 12:55:34 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:397 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261579AbTCKRzZ>; Tue, 11 Mar 2003 12:55:25 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 Mar 2003 10:15:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Niels Provos <provos@citi.umich.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030311043202.GK2225@citi.citi.umich.edu>
Message-ID: <Pine.LNX.4.50.0303111013020.1855-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <20030311043202.GK2225@citi.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, Niels Provos wrote:

> On Mon, Mar 10, 2003 at 12:15:25PM -0800, Davide Libenzi wrote:
> > The LT epoll is by all means the fastest poll available and can be used
> > wherever poll can be used. To test it I also ported thttpd to LT
> > epoll and, so far, it didn't puke on my face. Niels and Marius also wrote
> > a nice event library :
> [...]
> > that uses LT epoll, as long as poll and select. The usage pattern of an LT
> I compared the performance of LT epoll using libevent against other
> event mechanisms: select, poll and kqueue.
>
> You can find the results at
>
>   http://www.monkey.org/~provos/libevent/

Niels, can you publish inside the libevent web site the library that has
epoll inside ( possibly with the changes I made to epoll_create() ) ? I'm
including the test application, so other can repeat tests if they want.




- Davide





/*
 * Copyright 2003 Niels Provos <provos@citi.umich.edu>
 * All rights reserved.
 *
 *
 * Mon 03/10/2003 - Modified by Davide Libenzi <davidel@xmailserver.org>
 *
 *     Added chain event propagation to improve the sensitivity of
 *     the measure respect to the event loop efficency.
 *
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *      This product includes software developed by Niels Provos.
 * 4. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <sys/signal.h>
#include <sys/resource.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

#include <event.h>


static int count, writes, fired;
static int *pipes;
static int num_pipes, num_active, num_writes;
static struct event *events;



void
read_cb(int fd, short which, void *arg)
{
	int idx = (int) arg, widx = idx + 1;
	struct event *ev = &events[idx];
	u_char ch;

	count += read(fd, &ch, sizeof(ch));
	if (writes) {
		if (widx >= num_pipes)
			widx -= num_pipes;
		write(pipes[2 * widx + 1], "e", 1);
		writes--;
		fired++;
	}
}

struct timeval *
run_once(void)
{
	int *cp, i, space;
	static struct timeval ts, te;

	for (cp = pipes, i = 0; i < num_pipes; i++, cp += 2) {
		event_del(&events[i]);
		event_set(&events[i], cp[0], EV_READ | EV_PERSIST, read_cb, (void *) i);
		event_add(&events[i], NULL);
	}

	event_loop(EVLOOP_ONCE | EVLOOP_NONBLOCK);

	fired = 0;
	space = num_pipes / num_active;
	space = space * 2;
	for (i = 0; i < num_active; i++, fired++)
		write(pipes[i * space + 1], "e", 1);

	count = 0;
	writes = num_writes;

	gettimeofday(&ts, NULL);
	do {
		event_loop(EVLOOP_ONCE | EVLOOP_NONBLOCK);
	} while (count != fired);
	gettimeofday(&te, NULL);

	timersub(&te, &ts, &te);

	return (&te);
}

int
main (int argc, char **argv)
{
	struct rlimit rl;
	int i, c;
	struct timeval *tv;
	int *cp;
	extern char *optarg;

	num_pipes = 100;
	num_active = 1;
	num_writes = num_pipes;
	while ((c = getopt(argc, argv, "n:a:w:")) != -1) {
		switch (c) {
		case 'n':
			num_pipes = atoi(optarg);
			break;
		case 'a':
			num_active = atoi(optarg);
			break;
		case 'w':
			num_writes = atoi(optarg);
			break;
		default:
			fprintf(stderr, "Illegal argument \"%c\"\n", c);
			exit(1);
		}
	}

	rl.rlim_cur = rl.rlim_max = num_pipes * 2 + 50;
	if (setrlimit(RLIMIT_NOFILE, &rl) == -1) {
		perror("setrlimit");
		exit(1);
	}

	events = calloc(num_pipes, sizeof(struct event));
	pipes = calloc(num_pipes * 2, sizeof(int));
	if (events == NULL || pipes == NULL) {
		perror("malloc");
		exit(1);
	}

	memset(events, 0, num_pipes * sizeof(struct event));

	event_init();

	for (cp = pipes, i = 0; i < num_pipes; i++, cp += 2) {
		if (pipe(cp) == -1) {
			perror("pipe");
			exit(1);
		}
	}

	for (i = 0; i < 25; i++) {
		tv = run_once();
		if (tv == NULL)
			exit(1);
		fprintf(stdout, "%ld\n",
			tv->tv_sec * 1000000L + tv->tv_usec);
	}

	exit(0);
}

