Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVFMNbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVFMNbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVFMNbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:31:06 -0400
Received: from postman1.arcor-online.net ([151.189.20.156]:35836 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261550AbVFMNav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:30:51 -0400
Date: Mon, 13 Jun 2005 15:30:47 +0200
From: quade <quade@hsnr.de>
To: linux-kernel@vger.kernel.org
Cc: quade@hsnr.de
Subject: latency error (~2ms) with nanosleep
Message-ID: <20050613133047.GA11979@hsnr.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Playing around with the (simple) measurement of latency-times
I noticed, that the systemcall "nanosleep" has always a minimal
latency from about ~2ms (haven't run it all night, so...). It
seems to be a systematical error.

A short investigation shows, that "sys_nanosleep()" uses
schedule_timeout(), but schedule_timeout() is working exactly
as expected. Therefore I think it has something to do with
the scheduling?

Has someone an explanation for the ~2ms error?
If it is indeed a systematical error, does it make sense to
"adjust" (correct) this error in the systemcall "sys_nanosleep()"?

Find attached my small test program.

Juergen.

--AqsLC8rIMeq19msA
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="nano.c"

#include <stdio.h>
#include <time.h>
#include <sched.h>
#include <sys/time.h>

#define TAKTFREQ  600

static inline unsigned long long int rdtsc()
{
	unsigned long long int x;
	__asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
	return x;
}

// XXX - I know, there can be an overrun ...
static inline unsigned long time_in_usec( struct timeval *tv )
{
	return (tv->tv_sec*1000000)+tv->tv_usec;
}

int main( int argc, char **argv )
{
	int i;
	struct timespec delay;
	struct timeval tvstart, tvend;
	unsigned long start, end, timediff, maxdiff, shouldbetime;
	unsigned long mindiff;
#if 1
	struct sched_param SchedulingParameter;

	SchedulingParameter.sched_priority = 50;
	if( sched_setscheduler( 0, SCHED_RR, &SchedulingParameter )!= 0 ) {
		perror( "Set Scheduling Priority" );
		return -1;
	}
#endif

	for( shouldbetime=1000; shouldbetime<51000;shouldbetime+=1000 ) {
		mindiff = 0xffffffff;
		maxdiff = 0;
		for( i=0; i<30; i++ ) {
			delay.tv_sec  = 0;
			delay.tv_nsec = shouldbetime*1000; // in nsec
			gettimeofday(&tvstart,NULL);
			start = rdtsc();
			nanosleep( &delay, NULL );
			end = rdtsc();
			gettimeofday(&tvend,NULL);
#if 0
			printf("timdiff: %ld - %ld\n",
				(end-start)/TAKTFREQ,  // 600 MHz - in usec
				time_in_usec(&tvend)-time_in_usec(&tvstart));
#endif
			timediff = time_in_usec(&tvend)-time_in_usec(&tvstart);
			timediff -= shouldbetime;
			if( (timediff > maxdiff)&&i>0 )
				maxdiff = timediff;
			if( (timediff < mindiff)&&i>0 )
				mindiff = timediff;
		}
		//printf("%7.1ld-> max diff: %ld\n", shouldbetime, maxdiff );
		printf("%7.1ld %ld %ld\n", shouldbetime, maxdiff, mindiff );
	}
	return 0;
}

--AqsLC8rIMeq19msA--
