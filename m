Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTKNL5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 06:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTKNL5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 06:57:16 -0500
Received: from smtp-2.hut.fi ([130.233.228.92]:27844 "EHLO smtp-2.hut.fi")
	by vger.kernel.org with ESMTP id S262422AbTKNL5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 06:57:14 -0500
Date: Fri, 14 Nov 2003 13:56:58 +0200
From: Pasi Savolainen <pasi.savolainen@hut.fi>
To: Tony Lindgren <tony@atomide.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       clepple@ghz.cc
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031114115658.GD479040@kosh.hut.fi>
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com> <20031104191504.GB1042@atomide.com> <20031104202104.GA408936@kosh.hut.fi> <20031104205547.GE1042@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031104205547.GE1042@atomide.com>
User-Agent: Mutt/1.4i
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (smtp-2.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [031104 23:00]:
> * Pasi Savolainen <pasi.savolainen@hut.fi> [031104 12:21]:
> > * Tony Lindgren <tony@atomide.com> [031104 21:24]:
> > > * john stultz <johnstul@us.ibm.com> [031104 10:43]:
> > > > On Mon, 2003-11-03 at 16:22, Tony Lindgren wrote:
> > > > I've received some reports that this patch causes time problems.
> > > > 
> > > > Have those issues been looked into further, or addressed? 
> > > 
> > > I've heard of timing problems if it's compiled in, but supposedly they don't
> > > happen when loaded as module.
> > 
> > Not happening since 2.6.0-test9. Don't know what really fixed it, but
> > they're just not there anymore.
> 
> Weird, John, is this true on your S2460 also?

Well I'll be damned. It took 18 days to show up. Though I've been
riding this baby heavy for about a week.
So I've gettimeofday() jumping backwards again.

# uname -a
Linux tienel 2.6.0-test9 #2 SMP Sun Oct 26 14:35:02 EET 2003 i686 GNU/Linux


It's this test I'm running (snipped from previous TSC desych
-conversation):

- -
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
