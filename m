Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272511AbRIQTNi>; Mon, 17 Sep 2001 15:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272593AbRIQTN2>; Mon, 17 Sep 2001 15:13:28 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:49931 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S272511AbRIQTNN>;
	Mon, 17 Sep 2001 15:13:13 -0400
Message-ID: <3BA64ADE.999E1402@worldwideweber.org>
Date: Mon, 17 Sep 2001 15:11:26 -0400
From: John Weber <john@worldwideweber.org>
Organization: WorldWideWeber
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: how to get cpu_khz?
In-Reply-To: <fa.ginsptv.1gg45b5@ifi.uio.no>
Content-Type: multipart/mixed;
 boundary="------------A6F6ED1253D36C9B112FA354"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A6F6ED1253D36C9B112FA354
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David Fries wrote:
> 
> I'm using the TSC of the Pentium processors to get some precise timing
> delays for writing to a eeprom (bit banging bus operations), and it
> works just fine, but the cpu_khz variable isn't exported to a kernel
> module, so I hardcoded in my module.  It works fine for that one
> system, but obviously I don't want to hard code it for the general
> case.  I guess I could write my own routine to figure out what the
> cpu_khz is, but it is already done, so how do I get access to it?

I don't know of any official way of doing this, but here's some 
code (written by aa) that accomplishes this.
--------------A6F6ED1253D36C9B112FA354
Content-Type: text/plain; charset=us-ascii;
 name="MHz.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MHz.c"

/*
 *  $Id: MHz.c,v 1.4 2001/05/21 18:58:01 davej Exp $
 *  This file is part of x86info.
 *  (C) 2001 Dave Jones.
 *
 *  Licensed under the terms of the GNU GPL License version 2.
 *
 * Estimate CPU MHz routine by Andrea Arcangeli <andrea@suse.de>
 * Small changes by David Sterba <sterd9am@ss1000.ms.mff.cuni.cz>
 *
 */

#include <stdio.h>
#include <sys/time.h>
#include <string.h>
#include <unistd.h>

__inline__ unsigned long long int rdtsc()
{
	unsigned long long int x;
	__asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
	return x;
}

void estimate_MHz()
{
	struct timezone tz;
        struct timeval tvstart, tvstop;
        unsigned long long int cycles[2]; /* gotta be 64 bit */
	unsigned int microseconds; /* total time taken */
	
	memset(&tz, 0, sizeof(tz));

	/* get this function in cached memory */
	gettimeofday(&tvstart, &tz);
	cycles[0] = rdtsc();
	gettimeofday(&tvstart, &tz);

	/* we don't trust that this is any specific length of time */
	usleep(1000000);
	
	cycles[1] = rdtsc();
	gettimeofday(&tvstop, &tz);
	microseconds = ((tvstop.tv_sec-tvstart.tv_sec)*1000000) +
		(tvstop.tv_usec-tvstart.tv_usec);

	printf("%lldMHz processor (estimate).\n",
		(cycles[1]-cycles[0])/microseconds);
}

int main(void)
{
	while (1) {
		estimate_MHz();
	}
	return (0);
}

--------------A6F6ED1253D36C9B112FA354--

