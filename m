Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTA3SLg>; Thu, 30 Jan 2003 13:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbTA3SLg>; Thu, 30 Jan 2003 13:11:36 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:57766 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267503AbTA3SLd>;
	Thu, 30 Jan 2003 13:11:33 -0500
Message-ID: <3E396CF1.5000300@colorfullife.com>
Date: Thu, 30 Jan 2003 19:20:33 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Andrea Arcangeli <andrea@suse.de>, Richard Henderson <rth@twiddle.net>,
       linux-kernel@vger.kernel.org
Subject: Re:  frlock and barrier discussion
Content-Type: multipart/mixed;
 boundary="------------080904080605080309030800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080904080605080309030800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen wrote:

[snip - memory barrier for fr_write_begin]

>Using mb() is more paranoid than necessary. 


What about the memory barrier in fr_read_begin?
If I understand the Intel documentation correctly, then i386 doesn't need them:
"Writes by a single processor are observed in the same order by all processors"

I think "smp_read_barrier_depends()" (i.e. a nop for i386) is sufficient. Attached is a test app - could someone try it? I don't have access to a SMP system right now.


What about permitting arch overrides for the memory barriers? E.g. ia64 has acquire and release memory barriers - it doesn't map to the Linux wmb()/rmb() scheme.

--
	Manfred 













--------------080904080605080309030800
Content-Type: text/plain;
 name="frlock.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="frlock.cpp"

/*
 * frlock: test for Intel memory ordering.
 * Copyright (C) 1999,2003 by Manfred Spraul.
 * 
 * Redistribution of this file is permitted under the terms of the GNU 
 * Public License (GPL)
 * $Header: /pub/home/manfred/cvs-tree/movopt/frlock.cpp,v 1.2 2003/01/26 10:41:39 manfred Exp $
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <assert.h>

static volatile int g_val1;
static volatile int g_val2;
static volatile int g_seq1;
static volatile int g_seq2;

static volatile int start;
#define MB()	__asm__ __volatile__ ("lock;addl $0,(%%esp)\n\t" \
					:/* no output*/ \
					:/* no input*/:"cc","memory")

#define DELAY()		do { int i; for(i=0;i<1000;i++); } while(0)

void* threadfnc(void* param)
{
	while(!start);
	if(1 == (int)param)
		goto cpu1;
	if(2 == (int)param)
		goto cpu2;
	assert(0);
cpu1:
	{	// reader:
		for(;;) {
			int x1,x2,val1,val2;

			x1 = g_seq1;
			val1 = g_val1;
			val2 = g_val2;
			x2 = g_seq2;
			if (x1 == x2) {
				if (val1 != val2) {
					printf("Bad! memory ordering violation with %d/%d: %d/%d.\n", x1, x2, val1, val2);
				}
			}
	    	}
	}
cpu2:
	{	// writer:
	    	int target = 0;
		for (;;) {

			// write 1:
			target++;
			g_seq1 = target;
			g_val1 = target;
			g_val2 = target;
			g_seq2 = target;
			DELAY();

			// write 2:
			target++;
			g_seq1 = target;
			g_val1 = target;
			MB();
			g_val2 = target;
			g_seq2 = target;
			DELAY();

			// write 3:
			target++;
			g_seq1 = target;
			g_val2 = target;
			g_val1 = target;
			g_seq2 = target;
			DELAY();

			// write 4:
			target++;
			g_seq1 = target;
			g_val2 = target;
			MB();
			g_val1 = target;
			g_seq2 = target;
			DELAY();
			


			// write 5:
			target++;
			g_seq1 = target;
			g_val1 = target;
			MB(); MB();
			g_val2 = target;
			g_seq2 = target;
			DELAY();

			// write 6:
			target++;
			g_seq1 = target;
			g_val1 = target;
			MB(); DELAY();
			g_val2 = target;
			g_seq2 = target;
			DELAY();

			// write 7:
			target++;
			g_seq1 = target;
			g_val2 = target;
			MB(); MB();
			g_val1 = target;
			g_seq2 = target;
			DELAY();

			// write 8:
			target++;
			g_seq1 = target;
			g_val2 = target;
			MB(); DELAY();
			g_val1 = target;
			g_seq2 = target;
			DELAY();
		}
	}
}

void start_thread(int id)
{
	pthread_t thread;
	int res;

	res = pthread_create(&thread,NULL,threadfnc,(void*)id);
	if(res != 0)
		assert(false);
}



int main()
{
	printf("movopt:\n");
	start_thread(1);
	start_thread(2);
	printf(" starting, please wait.\n");
	fflush(stdout);
	start = 1;
	for(;;) sleep(1000);
}

--------------080904080605080309030800--

