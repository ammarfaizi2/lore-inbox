Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWFIWmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWFIWmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWFIWmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:42:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16043 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751424AbWFIWmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:42:03 -0400
Message-ID: <4489F93E.6070509@engr.sgi.com>
Date: Fri, 09 Jun 2006 15:42:06 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, jlan@sgi.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
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
>So even in this extreme case where the per-tgid stats are indeed
>half of the total data, the overhead is not very significant.
>
>As pointed out earlier, more representative cases are
>- single threaded apps (e.g. make -jX) where the current
>taskstats interface already optimizes by not sending redundant per-tgid stats, or
>  

How is it done?

In do_exit(), you have taskstats_exit_send(tsk, tidstats, tgidstats).
The tgid data would not be sent if
    not is_thread_group, or tgidstats is NULL.

The tgidstats is allocated within do_exit() also in
taskstats_exit_alloc(&tidstats, &tgidstats) and it seems to me
there is no flag to fail the memory allocation. Since tgidstats pointer
is valid, the data will be sent always.

Not filling up the tgid data fields would end up sending bunch of 0's
down to the userland.

>- server-type multithreaded apps where the exits are going to be relatively infrequent (due to
>reuse of thread pools) so the extra per-tgid output is not going to have much impact.
>  

I can expect to see our customers running highly multithreaded apps,
although i do not know whether those applications use the thread pools.

>I'd suggest we drop the idea of including this patch until we have data showing that
>the overhead is an issue.
>  

I do not have CSA kernel patch to test until some time next week to run
some tests. If we agree that it is a good idea to provide such an option, we
should proceed with that.

I found we should not mix tgid stats data and various subsystem stats
data defined in taststats struct together in our discussion. These are two
different things. On exit of each task, we would send one taskstats struct
data for the pid and also another taskstats struct for tgid. Within
the taskstats struct, we have data for delayacct, essential common
accting data (such as utime, stime, start_time, etc both BSD and CSA
would need), and data mostly used by CSA.
If we (including Andrew) decide to adopt taskstats as the common
accounting interface, we all need to live with taskstats struct. But, that
doea not mean we need to have both per-pid and per-tgid stats on every
process exit.

If you can show me how to not sending per-tgid with current patchset,
i would be very happy to drop this request.

Thanks!
 - jay

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

