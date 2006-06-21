Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbWFUTLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbWFUTLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWFUTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:11:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26269 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932680AbWFUTLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:11:14 -0400
Message-ID: <449999D1.7000403@engr.sgi.com>
Date: Wed, 21 Jun 2006 12:11:13 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com>
In-Reply-To: <4489EE7C.3080007@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
>Andrew Morton wrote:
>  
>>You see the problem - if one userspace package wants the tgid-stats and
>>another concurrently-running one does now, what do we do?  Just leave it
>>enabled and run a bit slower?
>>
>>If so, how much slower?  Your changelog says some potential users don't
>>need the tgid-stats, but so what?  I assume this patch is a performance
>>thing?  If so, has it been quantified?
>>    
>
>
>Here are some results from running a simple program (source below) that does
>10 iterations of creating and then destroying 1000 threads. On the side, another utility
>kept reading the pid (+tgid if present) stats from exiting tasks.
>  

I ran my testing using the same program posted by Shalilabh attached in his
posting.

System: SGI a350, a two cpus IA64 machine.
Kernel:  2.6.17-rc3 + delay-acct-taskstats patch set
       + tgid-disable_patch_shailabh + exit race patch_balbir +
csa_patch_jlan

I also modified the Decumentation/accounting/getdelay.c:
   - it repeatedly does recv() to retrieve data from kernel
   - instead of using printf() to display data received, i simply write
it to
     disk as it would be for an accounting daemon. Note that currently
both the
     BSD (or GNU) accounting and the CSA writes accounting data from kernel.
     As an effort of moving accounting system to userspace, the raw data
needs
     to be written to a raw file first before further processing.

In Shailabh's testing, he ran his 'mkthreads' 10 iterations of creating and
distroying 1000 threads.  I had to increase my test to 5000 iterations
in order
to receive meaningful data: 'mkthreads 1000 5000'.

I used Shailabh's per-tgid-disable patch to run my tests with per-tgid
enabled and disabled. I used 'sa' command of 'acct' package to report
results of 5 runs of 'mkthreads 1000 5000'.

>
>
>	Yes	No	Ovhd
>user	0.14	0.15	-6%
>system	1.61	1.54	+5%
>elapsed	2.01	1.94	+3%
>
>Yes = tgid stats printed on exit
>No = not printed
>Ovhd = (Yes-No)/No * 100
>  

Here are test results:

             Yes      No     Ovhd
user         1.77    0.44    302.27%
system       0.06    0.06      0.00%
elapsed    794.60  316.40    151.14%

Also, the results of five runs of per-tgid-disabled were very
consistent (3 runs of 0,44 seconds and 2 runs of 0.45), while
those of per-tgid-enabled varies (1.56, 1.99, 1.54, 2.21, 1.57).

The impact of per-tgid stats is too significant to ignore for
those who do not need the per-tgid stats data.

Another observation that i considered bad news is that all
10 runs produced 1 to 5 recv() error with errno=105 (ENOBUF).

Here I attach my csa_taskstats patch and my modified version of
exit_recv.c.

Regards,
 - jay


>So even in this extreme case where the per-tgid stats are indeed
>half of the total data, the overhead is not very significant.
>
>As pointed out earlier, more representative cases are
>- single threaded apps (e.g. make -jX) where the current
>taskstats interface already optimizes by not sending redundant per-tgid stats, or
>- server-type multithreaded apps where the exits are going to be relatively infrequent (due to
>reuse of thread pools) so the extra per-tgid output is not going to have much impact.
>
>I'd suggest we drop the idea of including this patch until we have data showing that
>the overhead is an issue.
>
>--Shailabh
>
>
>
>#include <stdio.h>
>#include <stdlib.h>
>#include <sys/types.h>
>#include <unistd.h>
>#include <pthread.h>
>
>int n;
>
>void *slow_exit(void *arg)
>{
>	int i = (int) arg;
>	usleep((n-i)*2);
>}
>
>int main(int argc, char *argv[])
>{
>	int i,rc, rep;
>	pthread_t *ppthread;
>	
>	n = 5 ;
>	if (argc > 1)
>		n = atoi(argv[1]);
>
>	rep = 10;
>	if (argc > 2)
>		rep = atoi(argv[2]);
>
>	ppthread = malloc(n * sizeof(pthread_t));
>	if (ppthread == NULL) {
>		printf("Memory allocation failure\n");
>		exit(-1);
>	}
>
>	while (rep) {
>		for (i=0; i<n; i++) {
>			rc = pthread_create(&ppthread[i], NULL,
>					    slow_exit, (void *)i);
>			if (rc) {
>				printf("Error creating thread %d\n", i);
>				exit(-1);
>			}
>		}
>		for (i=0; i<n; i++) {
>			rc = pthread_join(ppthread[i], NULL);
>			if (rc) {
>				printf("Error joining thread %d\n", i);
>				exit(-1);
>			}
>		}
>		rep--;
>	}
>}
>
>
>
>  

