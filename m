Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTLDUyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTLDUyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:54:21 -0500
Received: from main.gmane.org ([80.91.224.249]:39090 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262098AbTLDUyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:54:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: 2.6.0-test11 brings out gettimeofday() non-monotonicity
Date: Thu, 4 Dec 2003 20:54:08 +0000 (UTC)
Message-ID: <slrnbsv7ng.45b.psavo@varg.dyndns.org>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I (and several others) have had some problems on dual AMD platform with
time going backwards.
The 2.6.0-test11 -kernel seems to bring it forth very well. I can
trigger this behaviour _almost_ every time, simply by running 'updatedb'.

Result is that 'gettimeofday()' starts jumping backwards.
I used a program (from earlier gettimeofday() monotonicity discusion),
attached below.
- -
$ ./gtod-test | gawk '{ print $5; }' > avtime 
# about 30sec here, then ^C
$ sort avtime | uniq -c
     67 
      1 -
      4 -1:999988
     10 -1:999989
      3 -1:999990
      1 -1:999993
      8 -1:999996
     12 -1:999997
      4 -1:999998
  19611 -3:222832
      1 -3:222833
- -

On the other hand I recently heard from a developer that monotonic_clock
gave in some cases values of about 0xffffffff00000756, which to me looks
like a botched 64bit math. This was happening on UP, AMD board.

I've looked at the i386/kernel/time.co/do_gettimeofday(), but don't find
any fault with it.

- gettimeofday.c -
#include <stdio.h>
#include <sys/types.h>
#include <sys/time.h>

int main( void )
{
        int                     i = 0;

        while( 1 )
        {
                struct timeval          start;
                struct timeval          stop;
                struct timeval          diff;
                int                     rc1;
                int                     rc2;

                if( i++ % 1000000 == 0 )
                        printf( "% 12d: Iterations so far\n", i );

                rc1 = gettimeofday( &start, 0 );
                rc2 = gettimeofday( &stop, 0 );
                timersub( &stop, &start, &diff );

                if( rc1 < 0 || rc2 < 0 )
                        printf( " %12d: rc1=%d rc2=%d.   Failure!\n",
                                i,
                                rc1,
                                rc2
                        );

                if( diff.tv_sec >= 0 && diff.tv_usec >= 0 )
                        continue;

                printf( "% 12d: Time went backwards: %d:%06d\n",
                        i,
                        diff.tv_sec,
                        diff.tv_usec
                );

        }
}
- -

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

