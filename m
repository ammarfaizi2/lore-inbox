Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTEZVtG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 17:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTEZVtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 17:49:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32252 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262261AbTEZVtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 17:49:02 -0400
Message-ID: <3ED28E95.6000701@mvista.com>
Date: Mon, 26 May 2003 15:00:53 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>,
       Richard C Bilson <rcbilson@plg2.math.uwaterloo.ca>
CC: linux-kernel@vger.kernel.org, Eric Piel <Eric.Piel@Bull.Net>
Subject: Re:  setitimer 1 usec fails
References: <20030526142555.67a79694.akpm@digeo.com>
In-Reply-To: <20030526142555.67a79694.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Spotted on lkml...
> 
> 
> 
> Begin forwarded message:
> 
> Date: Mon, 26 May 2003 17:09:34 -0400
> From: Richard C Bilson <rcbilson@plg2.math.uwaterloo.ca>
> To: linux-kernel@vger.kernel.org
> Subject: setitimer 1 usec fails
> 
> 
> In trying the latest development kernel, I've noticed that calling
> setitimer with a 1 usec delay (the shortest possible delay) results in
> the timer never going off.  2 usec is ok but 1 is not, so I suspect
> that somehow things are being rounded off incorrectly.  The attached
> program demonstrates the problem on 2.5.69, but runs correctly on a
> 2.4.20 kernel.
> 
> I have only had the opportunity to try this on a single architecture
> (ia64), so if anyone can convince me that it's a platform-specific
> problem I'll be happy to take my gripe to the ia64 list.  I've tried to
> figure out how the usecs are converted to jiffies, but the code is
> sufficiently convoluted that I thought I'd throw it out in the hope of
> finding someone who understands the situation a little better.

I am not sure, but this could be related to the HZ=1024 problem Eric 
Piel and I are trying to run down.  This is a rather bad choice for HZ 
due to round off error on the conversions to usec.  We THINK the 
right thing to do is to convert to nsec (this is for TICK_NSEC()), 
directly rather than first to usec and then to nsec.

The additional problem is that the ntp code attempts to correct for 
the roundoff error which makes for an always correcting wall clock 
(even without turning on ntp).  What is needed and what I am trying to 
find time to do, is to convert the ntp code to work from the nsec 
resolution of xtime rather from the old usec resolution.  Problem is I 
don't know the ntp code so it is a bit of a learning curve.

Help here is welcome!!

As a test, you might try your test with HZ=1000 (a number I recommend 
for ia64, if at all possible).

-g
> 
> - Richard
> 
> // When run, this program should print "handled alarm" from within the
> // signal handler, and "out of sigsuspend" right after.  It works on
> // 2.4.20 or if MY_TIMER_USEC is >= 2, but not on 2.5.69 with
> // MY_TIMER_USEC = 1.
> 
> #define MY_TIMER_USEC 1
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <signal.h>
> #include <sys/time.h>
> 
> void
> alarm_handler( int x )
> {
>   printf( "handled alarm\n" );
>   return;
> }
> 
> int
> main()
> {
>   struct itimerval it = { { 0, 0 }, { 0, MY_TIMER_USEC } };
>   sigset_t mask;
>   struct sigaction act;
> 
>   act.sa_handler = alarm_handler;
>   act.sa_flags = 0;
>   sigemptyset( &act.sa_mask );
>   if( sigaction(SIGALRM, &act, 0) ) {
>     perror( "sigaction" );
>     exit( 1 );
>   }
>   
>   if( setitimer(ITIMER_REAL, &it, 0) ) {
>     perror( "setitimer" );
>     exit( 1 );
>   }
>   
>   sigemptyset( &mask );
>   sigsuspend( &mask );
>   
>   printf( "out of sigsuspend\n" );
>   return 0;
> }
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

