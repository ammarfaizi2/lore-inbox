Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbTA3SRb>; Thu, 30 Jan 2003 13:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTA3SRb>; Thu, 30 Jan 2003 13:17:31 -0500
Received: from [195.223.140.107] ([195.223.140.107]:40321 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267575AbTA3SRZ>;
	Thu, 30 Jan 2003 13:17:25 -0500
Date: Thu, 30 Jan 2003 19:26:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: frlock and barrier discussion
Message-ID: <20030130182622.GR18538@dualathlon.random>
References: <3E396CF1.5000300@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E396CF1.5000300@colorfullife.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 07:20:33PM +0100, Manfred Spraul wrote:
> Stephen wrote:
> 
> [snip - memory barrier for fr_write_begin]
> 
> >Using mb() is more paranoid than necessary. 
> 
> 
> What about the memory barrier in fr_read_begin?
> If I understand the Intel documentation correctly, then i386 doesn't need 
> them:
> "Writes by a single processor are observed in the same order by all 
> processors"
> 
> I think "smp_read_barrier_depends()" (i.e. a nop for i386) is sufficient. 

I don't see what you mean, there is no dependency we can rely on between
the read of the sequence number and the critical section reads, the
critical section reads has nothing to do with the sequence number reads
and the frlock itself.

> Attached is a test app - could someone try it? I don't have access to a SMP 
> system right now.
> 
> 
> What about permitting arch overrides for the memory barriers? E.g. ia64 has 
> acquire and release memory barriers - it doesn't map to the Linux 
> wmb()/rmb() scheme.
> 
> --
> 	Manfred 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 

> /*
>  * frlock: test for Intel memory ordering.
>  * Copyright (C) 1999,2003 by Manfred Spraul.
>  * 
>  * Redistribution of this file is permitted under the terms of the GNU 
>  * Public License (GPL)
>  * $Header: /pub/home/manfred/cvs-tree/movopt/frlock.cpp,v 1.2 2003/01/26 10:41:39 manfred Exp $
>  */
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <pthread.h>
> #include <assert.h>
> 
> static volatile int g_val1;
> static volatile int g_val2;
> static volatile int g_seq1;
> static volatile int g_seq2;
> 
> static volatile int start;
> #define MB()	__asm__ __volatile__ ("lock;addl $0,(%%esp)\n\t" \
> 					:/* no output*/ \
> 					:/* no input*/:"cc","memory")
> 
> #define DELAY()		do { int i; for(i=0;i<1000;i++); } while(0)
> 
> void* threadfnc(void* param)
> {
> 	while(!start);
> 	if(1 == (int)param)
> 		goto cpu1;
> 	if(2 == (int)param)
> 		goto cpu2;
> 	assert(0);
> cpu1:
> 	{	// reader:
> 		for(;;) {
> 			int x1,x2,val1,val2;
> 
> 			x1 = g_seq1;
> 			val1 = g_val1;
> 			val2 = g_val2;
> 			x2 = g_seq2;
> 			if (x1 == x2) {
> 				if (val1 != val2) {
> 					printf("Bad! memory ordering violation with %d/%d: %d/%d.\n", x1, x2, val1, val2);
> 				}
> 			}
> 	    	}
> 	}
> cpu2:
> 	{	// writer:
> 	    	int target = 0;
> 		for (;;) {
> 
> 			// write 1:
> 			target++;
> 			g_seq1 = target;
> 			g_val1 = target;
> 			g_val2 = target;
> 			g_seq2 = target;
> 			DELAY();
> 
> 			// write 2:
> 			target++;
> 			g_seq1 = target;
> 			g_val1 = target;
> 			MB();
> 			g_val2 = target;
> 			g_seq2 = target;
> 			DELAY();
> 
> 			// write 3:
> 			target++;
> 			g_seq1 = target;
> 			g_val2 = target;
> 			g_val1 = target;
> 			g_seq2 = target;
> 			DELAY();
> 
> 			// write 4:
> 			target++;
> 			g_seq1 = target;
> 			g_val2 = target;
> 			MB();
> 			g_val1 = target;
> 			g_seq2 = target;
> 			DELAY();
> 			
> 
> 
> 			// write 5:
> 			target++;
> 			g_seq1 = target;
> 			g_val1 = target;
> 			MB(); MB();
> 			g_val2 = target;
> 			g_seq2 = target;
> 			DELAY();
> 
> 			// write 6:
> 			target++;
> 			g_seq1 = target;
> 			g_val1 = target;
> 			MB(); DELAY();
> 			g_val2 = target;
> 			g_seq2 = target;
> 			DELAY();
> 
> 			// write 7:
> 			target++;
> 			g_seq1 = target;
> 			g_val2 = target;
> 			MB(); MB();
> 			g_val1 = target;
> 			g_seq2 = target;
> 			DELAY();
> 
> 			// write 8:
> 			target++;
> 			g_seq1 = target;
> 			g_val2 = target;
> 			MB(); DELAY();
> 			g_val1 = target;
> 			g_seq2 = target;
> 			DELAY();
> 		}
> 	}
> }
> 
> void start_thread(int id)
> {
> 	pthread_t thread;
> 	int res;
> 
> 	res = pthread_create(&thread,NULL,threadfnc,(void*)id);
> 	if(res != 0)
> 		assert(false);
> }
> 
> 
> 
> int main()
> {
> 	printf("movopt:\n");
> 	start_thread(1);
> 	start_thread(2);
> 	printf(" starting, please wait.\n");
> 	fflush(stdout);
> 	start = 1;
> 	for(;;) sleep(1000);
> }



Andrea
