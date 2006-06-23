Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751988AbWFWURp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbWFWURp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWFWURp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:17:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:10165 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751988AbWFWURo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:17:44 -0400
Message-ID: <449C4C37.5020802@watson.ibm.com>
Date: Fri, 23 Jun 2006 16:16:55 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <449999D1.7000403@engr.sgi.com> <44999A98.8030406@engr.sgi.com> <44999F5A.2080809@watson.ibm.com> <4499D7CD.1020303@engr.sgi.com> <449C2181.6000007@watson.ibm.com> <449C30C1.6090802@engr.sgi.com> <449C3897.70001@watson.ibm.com> <449C4865.7040706@engr.sgi.com>
In-Reply-To: <449C4865.7040706@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>>
>>My results confirm the high overhead at these exit rates. In fact,
>>on the system I used, I see the 649% overhead for the 2200 exits/second case
>>even higher than yours) but the point is whether that exit rate
>>is a valid design criteria.
>> 
> 
> 
> Agreed. The indeed the deciding factor. The exit rate in the labs
> does not help answer this question. I need input from our fields.
> 

FWIW, I just spoke to some of the IBM folks working on Websphere (the
J2EE platform) and they've said that the exit rate is quite low since a thread pool
is used to reuse threads rather than have them exit. Also, I'm waiting to
hear from our db2 folks though I suspect its the same story there.

>>
>>>And, the per-thread group processing also increase the rate of ENOBUFS
>>>at the receiver.
>>>   
>>
>>Could you quantify please ? Also, pls list the exit rate at which
>>this happens.
>> 
> 
> 
> I have not posted it nor quantify it because i must bring down the errors
> count, or we (CSA) have to explore a different way. So any comparison
> on these number at this point does not really help. Again, if the exit rate
> is unrealistic, then i need to run a different set of testings. 


> What
> sleep_factor did you use? 

Each thread executed the following code:

void *slow_exit(void *arg)
{
        int i = (int) arg;
        usleep((n-i)*200);
}

and I varied the number within between
700 (resulting in exit rate of 694 in my data)
and 100 (resulting in the 2283 exit rate)


> Are those printf() in your new test program
> essential?

No. I dropped them.
The test program used is appended below. There were no
printfs on the non-failure paths.


> 
> If this type of exit rate can happen even once a day, the surge may cause
> loss of accounting data of other processes. Again, i do not have data
> to say either way yet. But i would rather spend time on working on
> the ENOBUFS error than running all different tests to argue on the
> per-TG switch.
> 

I suppose the ENOBUFS case has to be handled at userspace anyway
since it can potentially happen for high thread exit rate cases even if
only pid data is sent.

> Regards,
>  - jay
> 
> 
>


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <pthread.h>

int n;
int barrier=1;


void *slow_exit(void *arg)
{
    long i = (int) arg;
    usleep((n-i)*600);
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
                printf("Error creating thread %d %d\n", i, rc);
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

