Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTEZUzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTEZUzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:55:04 -0400
Received: from plg2.math.uwaterloo.ca ([129.97.140.200]:60373 "EHLO
	plg2.math.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262245AbTEZUzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:55:02 -0400
Date: Mon, 26 May 2003 17:09:34 -0400
From: Richard C Bilson <rcbilson@plg2.math.uwaterloo.ca>
Message-Id: <200305262109.RAA23875@plg2.math.uwaterloo.ca>
To: linux-kernel@vger.kernel.org
Subject: setitimer 1 usec fails
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In trying the latest development kernel, I've noticed that calling
setitimer with a 1 usec delay (the shortest possible delay) results in
the timer never going off.  2 usec is ok but 1 is not, so I suspect
that somehow things are being rounded off incorrectly.  The attached
program demonstrates the problem on 2.5.69, but runs correctly on a
2.4.20 kernel.

I have only had the opportunity to try this on a single architecture
(ia64), so if anyone can convince me that it's a platform-specific
problem I'll be happy to take my gripe to the ia64 list.  I've tried to
figure out how the usecs are converted to jiffies, but the code is
sufficiently convoluted that I thought I'd throw it out in the hope of
finding someone who understands the situation a little better.

- Richard

// When run, this program should print "handled alarm" from within the
// signal handler, and "out of sigsuspend" right after.  It works on
// 2.4.20 or if MY_TIMER_USEC is >= 2, but not on 2.5.69 with
// MY_TIMER_USEC = 1.

#define MY_TIMER_USEC 1

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/time.h>

void
alarm_handler( int x )
{
  printf( "handled alarm\n" );
  return;
}

int
main()
{
  struct itimerval it = { { 0, 0 }, { 0, MY_TIMER_USEC } };
  sigset_t mask;
  struct sigaction act;

  act.sa_handler = alarm_handler;
  act.sa_flags = 0;
  sigemptyset( &act.sa_mask );
  if( sigaction(SIGALRM, &act, 0) ) {
    perror( "sigaction" );
    exit( 1 );
  }
  
  if( setitimer(ITIMER_REAL, &it, 0) ) {
    perror( "setitimer" );
    exit( 1 );
  }
  
  sigemptyset( &mask );
  sigsuspend( &mask );
  
  printf( "out of sigsuspend\n" );
  return 0;
}

-- 
Richard C. Bilson, Research Assistant   | School of Computer Science
rcbilson@plg.uwaterloo.ca               | University of Waterloo
http://plg.uwaterloo.ca/~rcbilson       | 200 University Avenue West
Office: DC 3548F Ph: (519)888-4567x4822 | Waterloo, Ontario, CANADA N2L 3G1
