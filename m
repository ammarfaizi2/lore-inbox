Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbWFIV4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbWFIV4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWFIV4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:56:33 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:65238 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030552AbWFIV4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:56:32 -0400
Message-ID: <4489EE7C.3080007@watson.ibm.com>
Date: Fri, 09 Jun 2006 17:56:12 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: balbir@in.ibm.com, jlan@sgi.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org>
In-Reply-To: <20060609042129.ae97018c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> You see the problem - if one userspace package wants the tgid-stats and
> another concurrently-running one does now, what do we do?  Just leave it
> enabled and run a bit slower?
> 
> If so, how much slower?  Your changelog says some potential users don't
> need the tgid-stats, but so what?  I assume this patch is a performance
> thing?  If so, has it been quantified?


Here are some results from running a simple program (source below) that does
10 iterations of creating and then destroying 1000 threads. On the side, another utility
kept reading the pid (+tgid if present) stats from exiting tasks.


	Yes	No	Ovhd
user	0.14	0.15	-6%
system	1.61	1.54	+5%
elapsed	2.01	1.94	+3%

Yes = tgid stats printed on exit
No = not printed
Ovhd = (Yes-No)/No * 100

So even in this extreme case where the per-tgid stats are indeed
half of the total data, the overhead is not very significant.

As pointed out earlier, more representative cases are
- single threaded apps (e.g. make -jX) where the current
taskstats interface already optimizes by not sending redundant per-tgid stats, or
- server-type multithreaded apps where the exits are going to be relatively infrequent (due to
reuse of thread pools) so the extra per-tgid output is not going to have much impact.

I'd suggest we drop the idea of including this patch until we have data showing that
the overhead is an issue.

--Shailabh



#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <pthread.h>

int n;

void *slow_exit(void *arg)
{
	int i = (int) arg;
	usleep((n-i)*2);
}

int main(int argc, char *argv[])
{
	int i,rc, rep;
	pthread_t *ppthread;
	
	n = 5 ;
	if (argc > 1)
		n = atoi(argv[1]);

	rep = 10;
	if (argc > 2)
		rep = atoi(argv[2]);

	ppthread = malloc(n * sizeof(pthread_t));
	if (ppthread == NULL) {
		printf("Memory allocation failure\n");
		exit(-1);
	}

	while (rep) {
		for (i=0; i<n; i++) {
			rc = pthread_create(&ppthread[i], NULL,
					    slow_exit, (void *)i);
			if (rc) {
				printf("Error creating thread %d\n", i);
				exit(-1);
			}
		}
		for (i=0; i<n; i++) {
			rc = pthread_join(ppthread[i], NULL);
			if (rc) {
				printf("Error joining thread %d\n", i);
				exit(-1);
			}
		}
		rep--;
	}
}



