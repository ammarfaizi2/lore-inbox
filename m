Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVHQGLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVHQGLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVHQGLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:11:37 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:29068 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1750837AbVHQGLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:11:37 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Christoph Lameter <clameter@engr.sgi.com>
Date: Wed, 17 Aug 2005 08:08:57 +0200
MIME-Version: 1.0
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <4302F098.11683.53787EA@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.62.0508161116270.7101@schroedinger.engr.sgi.com>
References: <1124151001.8630.87.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.95.0+V=3.95+U=2.07.102+R=04 July 2005+T=107623@20050817.060247Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2005 at 11:25, Christoph Lameter wrote:

> You mentioned that the NTP code has some issues with time interpolation 
> at the KS. This is due to the NTP layer not being aware of actual time 
> differences between timer interrupts that the interpolator knows about. If 
> the NTP layer would be aware of the actual intervals measured by the 
> timesource (or interpolator) then presumably time could be adjusted in a 
> more accurate way.

Hi,

whatever the implementation is, at some point there must exist an interface go get 
and set "normal time", free of any jumps and jitter. That "frontend time" will be 
used a a base of correction. Basically that means time should be as monotonic and 
jitter free as possible for any measurement interval you like.

Otherwise when extrapolating the time-error, it (NTP) will try to overcompensate 
(or undercompensate), making the whole thing instable.

Here's a sample from some ancient NTP distribution (pre-nanosecond), but you'll 
get the idea what to check:

more util/jitter.c
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

Regards,
Ulrich

