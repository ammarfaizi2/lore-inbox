Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUAOTnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUAOTnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:43:45 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:13317 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S262767AbUAOTng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:43:36 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200401141942.i0EJgKk07363@hofr.at>
Subject: Re: 2.6.0 SCHED_RR/SCHED_FIFO strangness .
In-Reply-To: <20040115012624.19da7712.akpm@osdl.org> from Andrew Morton at "Jan
 15, 2004 01:26:24 am"
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 14 Jan 2004 20:42:20 +0100 (CET)
CC: Der Herr Hofrat <der.herr@hofr.at>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Der Herr Hofrat <der.herr@hofr.at> wrote:
> >
> >  The strange thing is that SCHED_FIFO runs always return worse results than
> >   SCHED_RR runs under even moderate load (one find / in an endless loop, system
> >   otherwise idle) - any ideas what is causing this ?
> 
> Can you send us the entire test app?
>

The system I'm running on is IDE based NN 2.6.0 without any patches :
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2400+
stepping        : 1
cpu MHz         : 2002.899
 
to run this the tsc scaller needs to be taken from /proc/cpuinfo and passed
as an argument - to get microsecond resolution for SCHED_FIFO/SCHED_RR
comparison on this system I used 

./sched_jitter -s 2002 

to load the box a bit run

while : ; do find / > /dev/null 2>&1 ; done &

results from 5 runs atached below the code.
note that in all runs SCHED_FIFO shows low jitter and then rare events of
very high delay - to catch this reliably one needs to run quite long loops. 
Even with much longer loops I could not get these high values for SCHED_RR 
the average cases for SCHED_FIFO are better though.

hofrat

---sched_jitter.c---
#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
#include <fcntl.h>

#include <sys/types.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <asm/io.h>

void usage(void);

__inline__ unsigned long long int hwtime(void)
{
	unsigned long long int x;
	__asm__ __volatile__("rdtsc\n\t"
		:"=A" (x));
	return x;
}

void usage(void)
{
   printf("usage: sched_jitter -s tsc_scaler\n");
}

#define GRAPH_SIZE 1000

int main(int argc, char **argv)
{
	int i;

	char  *optstr = "hs:";
	char c;

	unsigned long long graph[3][GRAPH_SIZE];
	unsigned long long hwtime1,hwtime2,jitt;
	unsigned long long jitt_max[3];
	unsigned long scale = 1;
	unsigned long policy;
	unsigned long long n,loops;

	struct sched_param param;

	while ( (c = getopt(argc, argv, optstr)) != -1 ) {
		switch (c) {
		case 's':   /* tsc scaling factor */
			scale = strtol( optarg, NULL, 0);
			break;
		case 'h':   /* verbose */
			usage();
			exit(0);
		default:
			fprintf(stderr,"time: Unknown option \'-%c\', exitting.\n", c);
			fprintf(stderr,"   use \'time -h\' for help\n");
			exit(1);
		}
	}

	/* from linux/include/sched.h 
	 * #define SCHED_NORMAL            0
	 * #define SCHED_FIFO              1
	 * #define SCHED_RR                2
	 */
	memset(graph,0,sizeof(graph));

	/* just run with SCHED_FIFO and then SCHED_RR */
	for(policy=1;policy<3;policy++){
		param.sched_priority = sched_get_priority_max(policy);
//		param.sched_priority = sched_get_priority_min(policy);
		if(sched_setscheduler(getpid(),policy,&param)){
			printf("sched_setscheduler failed - exiting\n");
			exit(-1);
		} 
		jitt_max[policy]=0LL; 
		n=0LL;
		loops=1000000000LL;
		while(n < loops){
			unsigned long long index=0;
			hwtime2 = hwtime();
			hwtime1 = hwtime();
			jitt=hwtime1-hwtime2;
			index=jitt/scale;
			if(index > GRAPH_SIZE){
				printf("out of bounds value\n");
			} else {
				graph[policy][index] += 1;
			}
			if(jitt > jitt_max[policy]){
				jitt_max[policy]=jitt;
			}
			n++;
		}
	}

	/* dump data */
	for(policy=0;policy<3;policy++){
		if(jitt_max[policy]/scale < GRAPH_SIZE){
			printf("\nworst case delay in run with policy %ld = %lld us\n",
				policy,
				jitt_max[policy]/scale);
		} else {		
			printf("\nworst case delay in run with policy %ld = %lld us out of bounds - results are unreliable !\n",
				policy,
				jitt_max[policy]/scale);
		}
		printf("\n");
		for(i=0;i<GRAPH_SIZE ;i++){
			if(graph[policy][i])
				printf("%4d us: %16lld \n",i,graph[policy][i]);
		}
	}
	return 0;
}

output from 5 runs while running a endless find / loop to produce some load.

worst case delay in run with policy 1 = 207 us

   0 us:        999990261 
   1 us:              195 
   2 us:             9473 
   3 us:               50 
   4 us:                3 
   5 us:               11 
   6 us:                2 
  12 us:                2 
  15 us:                1 
  19 us:                1 
 207 us:                1 

worst case delay in run with policy 2 = 18 us

   0 us:        999990347 
   1 us:              178 
   2 us:             9360 
   3 us:              104 
   4 us:                5 
   6 us:                1 
  11 us:                1 
  12 us:                1 
  13 us:                2 
  18 us:                1 

worst case delay in run with policy 1 = 84 us

   0 us:        999990512 
   1 us:              155 
   2 us:             9239 
   3 us:               90 
  13 us:                1 
  15 us:                1 
  16 us:                1 
  84 us:                1 

worst case delay in run with policy 2 = 16 us

   0 us:        999991063 
   1 us:              167 
   2 us:             8668 
   3 us:               89 
   4 us:                4 
   6 us:                1 
  12 us:                2 
  13 us:                2 
  14 us:                1 
  15 us:                2 
  16 us:                1 

worst case delay in run with policy 1 = 156 us

   0 us:        999990506 
   1 us:              153 
   2 us:             9246 
   3 us:               86 
   4 us:                1 
  13 us:                4 
  15 us:                1 
 156 us:                3 

worst case delay in run with policy 2 = 31 us

   0 us:        999990810 
   1 us:              134 
   2 us:             8930 
   3 us:              105 
   5 us:               15 
   6 us:                1 
  11 us:                1 
  13 us:                2 
  14 us:                1 
  31 us:                1 

worst case delay in run with policy 1 = 168 us

   0 us:        999990419 
   1 us:              163 
   2 us:             9313 
   3 us:               96 
   4 us:                6 
   5 us:                1 
  13 us:                1 
 168 us:                1 

worst case delay in run with policy 2 = 18 us

   0 us:        999990337 
   1 us:              168 
   2 us:             9405 
   3 us:               82 
   4 us:                6 
  11 us:                1 
  18 us:                1 

worst case delay in run with policy 1 = 81 us

   0 us:        999990481 
   1 us:              145 
   2 us:             9292 
   3 us:               74 
   4 us:                3 
   6 us:                1 
  13 us:                1 
  14 us:                1 
  18 us:                1 
  81 us:                1 

worst case delay in run with policy 2 = 16 us

   0 us:        999990391 
   1 us:              217 
   2 us:             9313 
   3 us:               73 
  11 us:                2 
  12 us:                1 
  13 us:                1 
  15 us:                1 
  16 us:                1 
