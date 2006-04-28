Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWD1OxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWD1OxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWD1OxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:53:24 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:23222 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030418AbWD1OxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:53:24 -0400
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Paulo Marques <pmarques@grupopie.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <44521BE6.8040500@grupopie.com>
References: <20060424150544.GL15613@skybase>
	 <20060428073358.GA15166@filer.fsl.cs.sunysb.edu>
	 <20060428083903.GA11819@osiris.boeblingen.de.ibm.com>
	 <1146216285.5138.1.camel@localhost>  <44521BE6.8040500@grupopie.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 28 Apr 2006 16:53:28 +0200
Message-Id: <1146236009.26676.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 14:43 +0100, Paulo Marques wrote:
> >>>>+++ linux-2.6-patched/drivers/s390/s390mach.c	2006-04-24 16:47:28.000000000 +0200
> >>>...
> >>>>+#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */
>                                  ^^^^^^^^^^^^^^^^^^^^
> 				Expression A
> 
> >>>I'm no s390 expert, but shouldn't the above use something like HZ?
> >>
> >>Using HZ here feels just wrong to me. MAX_IPD_TIME has nothing to do with the
> >>timer frequency. In this case it's used to tell if there were 30 machine
> >>checks within the last 5 minutes (in a usec granularity). It's just by
> >>accident that this could be expressed using HZ.
> >>(5 * 60 * USEC_PER_SEC) would probably look better...
>    ^^^^^^^^^^^^^^^^^^^^^^^
>    Expression B
> 
> I'm no s390 expert either, but just wanted to point out that expression 
> B is 10 times larger than expression A, so something's fishy here.

Indeed, 5*60*100*1000 is wrong. That should be 5*60*1000*1000. This must
have been the week of stupid bugs.. thanks for spotting this.

> > Using HZ would be wrong. The check that uses MAX_IPD_TIME compares it
> > against the result of a get_clock() call. That uses the TOD Clock
> > directly, there is no dependency on HZ.
> 
> Looking at include/asm-s390/timex.h:
> 
> #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
> 
> makes me wonder if this should be:
> 
> #define MAX_IPD_TIME	(5 * 60 * CLOCK_TICK_RATE) /* 5 minutes */

No. The CLOCK_TICK_RATE is a really strange beast. It sole purpose is to
satisfy the calculations in include/linux/jiffies.h. The value itself
has no meaning in regard to the TOD clock. 5*60*CLOCK_TICK_RATE
evaluates to about 358 seconds. Not what we want.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


