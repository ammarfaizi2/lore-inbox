Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVGLAmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVGLAmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVGLAls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:41:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4089 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262255AbVGLAjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 20:39:49 -0400
Message-ID: <42D310ED.2000407@mvista.com>
Date: Mon, 11 Jul 2005 17:38:05 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe> <176640000.1121107087@flay>
In-Reply-To: <176640000.1121107087@flay>
Content-Type: multipart/mixed;
 boundary="------------040507050602060605090700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040507050602060605090700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
>>>Lots of people have switched from 2.4 to 2.6 (100 Hz to 1000 Hz) with no impact in
>>>stability, AFAIK. (I only remember some weird warning about HZ with debian woody's
>>>ps).
>>>
>>
>>Yes, that's called "progress" so no one complained.  Going back is
>>called a "regression".  People don't like those as much.
> 
> 
> That's a very subjective viewpoint. Realize that this is a balancing
> act between latency and overhead ... and you're firmly only looking
> at one side of the argument, instead of taking a compromise in the
> middle ...
> 
> If I start arguing for 100HZ on the grounds that it's much more efficient,
> will that make 250/300 look much better to you? ;-)

I would like to interject an addition data point, and I will NOT be subjective. 
  The nature of the PIT is that it can _hit_ some frequencies better than 
others.  We have had complaints about repeating timers not keeping good time. 
These are not jitter issues, but drift issues.  The standard says we may not 
return early from a timer so any timer will either be on time or late.  The 
amount of lateness depends very much on the HZ value.  Here is what the values 
are for the standard CLOCK_TICK_RATE:

HZ  	TICK RATE	jiffie(ns)	second(ns)	 error (ppbillion)
  100	 1193180	10000000	1000000000	       0
  200	 1193180	 5000098	1000019600	   19600
  250	 1193180	 4000250	1000062500	   62500
  500	 1193180	 1999703	1001851203	 1851203
1000	 1193180	  999848	1000847848	  847848

The jiffie values here are exactly what the kernel uses and are based on the 
best one can do with the PIT hardware.

I am not suggesting any given default HZ, but rather an argumentation of the 
help text that goes with it.  For those who want timers to repeat at one second 
(or multiples there of) this is useful info.

For you enjoyment I have attached the program used to print this.  It allows you 
to try additional values...


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------040507050602060605090700
Content-Type: text/x-csrc;
 name="as.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as.c"



#define NSEC_PER_SEC  1000000000
//#define CLOCK_TICK_RATE /*100000000 */ 1193180
#define LATCH(CLOCK_TICK_RATE,HZ)  ((CLOCK_TICK_RATE + HZ/2) / HZ)
#define SH_DIV(NOM,DEN,LSH) (	((NOM / DEN) << LSH)			\
			     + (((NOM % DEN) << LSH) + DEN / 2) / DEN)
#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH(CLOCK_TICK_RATE,HZ), 8))
#define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))


struct {
	int hz;
	int clocktickrate;
} vals[] = {{100, 1193180}, {200, 1193180}, {250, 1193180}, {500, 1193180}, {1000, 1193180},{0,0}};

void do_it(int hz,int tickrate)
{
	int HZ = hz;
	int CLOCK_TICK_RATE = tickrate;
	int tick_nsec = TICK_NSEC;
	int ticks_per_sec = NSEC_PER_SEC/tick_nsec;
	int sec_size = ticks_per_sec * tick_nsec;
	int one_sec_p;
	int err;

	if (sec_size < NSEC_PER_SEC)
		sec_size += tick_nsec;
	one_sec_p = sec_size;
	err = one_sec_p - NSEC_PER_SEC;
	printf( "%4d\t%8d\t%8d\t%10d\t%8d\n",hz, tickrate, tick_nsec, 
		one_sec_p, err);
}
	
void bail(void)
{
	printf("run as: as [hz [clock_tick_rate]]\n");
	exit(1);
}

main(int argc, char** argv)
{
	int i = 0;
	int phz = 0;
	int pcr = vals[0].clocktickrate;

	if (argc > 1) { 
		phz = atoi(argv[1]);
		if (!phz)
			bail();
	}
	if (argc > 2) {
		pcr = atoi(argv[2]);
		if (!pcr)
			bail();
	}

	printf("HZ  \tTICK RATE\tjiffie(ns)\tsecond(ns)\t error (ppbillion)\n");
	while(vals[i].hz) {
		do_it(vals[i].hz, vals[i].clocktickrate);
		i++;
	}
	if (phz)
		do_it(phz, pcr);
}

--------------040507050602060605090700--
