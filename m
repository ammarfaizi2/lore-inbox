Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVLGHXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVLGHXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 02:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbVLGHXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 02:23:43 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:8599 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932644AbVLGHXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 02:23:42 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 07 Dec 2005 08:23:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>
Message-ID: <43969BEF.23136.2E6BFD65@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0512061130410.1609@scrub.home>
References: <20051206072708.GA25129@elte.hu>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=113022@20051207.072010Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2005 at 11:35, Roman Zippel wrote:

> Hi,
> 
> On Tue, 6 Dec 2005, Ingo Molnar wrote:
> 
> > > > I'm thinking about moving the leap second handling to a timer, with the 
> > > > new timer system it would be easy to set a timer for e.g. 23:59.59 and 
> > > > then set the time. This way it would be gone from the common path and it 
> > > > wouldn't matter that much anymore whether it's used or not.
> > > 
> > > Will the timer solution guarantee consistent and exact updates?
> > 
> > it would still be dependent on system-load situations.
> 
> Interrupt-load, actually.
> 
> > It's an 
> > interesting idea to use a timer for that, but there is no strict 
> > synchronization between "get time of day" and "timer execution", so any 
> > timer-based leap-second handling would be fundamentally asynchronous. I 
> > dont think we want that, leap second handling should be a synchronous 
> > property of 'time'.
> 
> I'm not really sure what you're talking about. Could you please elaborate 
> on "fundamentally asynchronous" and "synchronous property of 'time'"?

It's always the same: A process busily reads time, and it wants to have it smooth 
(low jitter, preferrably constant jitter, small time increments):

/*
 * This program can be used to calibrate the clock reading jitter of a
 * particular CPU and operating system. It first tickles every element
 * of an array, in order to force pages into memory, then repeatedly calls
 * gettimeofday() and, finally, writes out the time values for later
 * analysis. From this you can determine the jitter and if the clock ever
 * runs backwards.
 */
#include <sys/time.h>
#include <stdio.h>

#define NBUF 20002

void
main()
{
        struct timeval ts, tr;
        struct timezone tzp;
        long temp, j, i, gtod[NBUF];

        gettimeofday(&ts, &tzp);

        /*
         * Force pages into memory
         */
        for (i = 0; i < NBUF; i ++)
                gtod[i] = 0;

        /*
         * Construct gtod array
         */
        for (i = 0; i < NBUF; i ++) {
                gettimeofday(&tr, &tzp);
                gtod[i] = (tr.tv_sec - ts.tv_sec) * 1000000 + tr.tv_usec;
        }

        /*
         * Write out gtod array for later processing with S
         */
        for (i = 0; i < NBUF - 2; i++) {
/*
                printf("%lu\n", gtod[i]);
*/
                gtod[i] = gtod[i + 1] - gtod[i];
                printf("%lu\n", gtod[i]);
        }

        /*
         * Sort the gtod array and display deciles
         */
        for (i = 0; i < NBUF - 2; i++) {
                for (j = 0; j <= i; j++) {
                        if (gtod[j] > gtod[i]) {
                                temp = gtod[j];
                                gtod[j] = gtod[i];
                                gtod[i] = temp;
                        }
                }
        }
        fprintf(stderr, "First rank\n");
        for (i = 0; i < 10; i++)
                fprintf(stderr, "%10ld%10ld\n", i, gtod[i]);
        fprintf(stderr, "Last rank\n");
        for (i = NBUF - 12; i < NBUF - 2; i++)
                fprintf(stderr, "%10ld%10ld\n", i, gtod[i]);
}

(Code taken from some 10 year old xntp source tree)
