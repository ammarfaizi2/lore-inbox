Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbTBKKAw>; Tue, 11 Feb 2003 05:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267355AbTBKKAw>; Tue, 11 Feb 2003 05:00:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:37270 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267349AbTBKKAu>;
	Tue, 11 Feb 2003 05:00:50 -0500
Date: Tue, 11 Feb 2003 02:10:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <ckolivas@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [BENCHMARK] 2.5.60 with contest
Message-Id: <20030211021054.0ea47494.akpm@digeo.com>
In-Reply-To: <200302112036.38710.ckolivas@yahoo.com.au>
References: <200302112036.38710.ckolivas@yahoo.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 10:10:28.0997 (UTC) FILETIME=[CDB06350:01C2D1B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <ckolivas@yahoo.com.au> wrote:
>
> interestingly dbench_load wouldnt give me a number because dbench never
> quite started - a whole swag of processes visible but not doing anything

Signal problems...

What dbench is doing is:

- Install a SIGCONT handler
- fork N times, children drop into a pause()
- parent does kill(0, SIGCONT);

It appears that the SIGCONT is not causing the children to drop out of the
pause().

Changing it to SIGINT makes it work.

The tarball is at http://samba.org/ftp/tridge/dbench/dbench-2.0.tar.gz

Here's the relevant snippet:

static double create_procs(int nprocs, void (*fn)(struct child_struct * ))
{
	int i, status;
	int synccount;

	signal(SIGCONT, sigcont);

	start_timer();

	synccount = 0;

	if (nprocs < 1) {
		fprintf(stderr,
			"create %d procs?  you must be kidding.\n",
			nprocs);
		return 1;
	}

	children = shm_setup(sizeof(struct child_struct)*nprocs);
	if (!children) {
		printf("Failed to setup shared memory\n");
		return end_timer();
	}

	memset(children, 0, sizeof(*children)*nprocs);

	for (i=0;i<nprocs;i++) {
		children[i].id = i;
		children[i].nprocs = nprocs;
	}

	for (i=0;i<nprocs;i++) {
		if (fork() == 0) {
			setbuffer(stdout, NULL, 0);
			nb_setup(&children[i]);
			children[i].status = getpid();
			pause();
			fn(&children[i]);
			_exit(0);
		}
	}

	do {
		synccount = 0;
		for (i=0;i<nprocs;i++) {
			if (children[i].status) synccount++;
		}
		if (synccount == nprocs) break;
		sleep(1);
	} while (end_timer() < 30);

	if (synccount != nprocs) {
		printf("FAILED TO START %d CLIENTS (started %d)\n", nprocs, synccount);
		return end_timer();
	}

	start_timer();
	kill(0, SIGCONT);


