Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVCKWH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVCKWH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVCKWH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:07:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51194 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261563AbVCKWHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:07:08 -0500
Message-ID: <42321687.2050502@mvista.com>
Date: Fri, 11 Mar 2005 14:07:03 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ted Phelps <phelps@gnusto.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more reliable system timer for SC1100 CPU
References: <200503111506.j2BF6EWh030442@laika.gnusto.com>
In-Reply-To: <200503111506.j2BF6EWh030442@laika.gnusto.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Phelps wrote:

First, procedure...  patches should be *.patch and not compressed.  If too long 
they need to be broken up.  Lately, folks have said they should be inline in the 
email text, but watch out for your mailer doing UGLY things with white space.

> Hello,
> 
> The attached patch is an attempt to work around the buggy timestamp
> counter on the NatSemi SC1100 CPU by using the on-board 27MHz
> high-resolution timer as an alternative time source.  It should,
> in theory, work with any of the SCx200 CPUs as well, though I have
> been unable to test this.  I have tested it fairly thoroughly with NTP
> on an SC1100 and it seems to behave sanely.
> 
> That said, there are three things about it that I'm not entirely
> comfortable with:
> 
> (1) The high-resolution timer is driven by a separate crystal than the
>     CPU's timer interrupt, and on the SC1100 I have access to, it's
>     consistently slower.  I've found that it is necessary to
>     periodically *decrement* the jiffies_64 counter in mark_offset in
>     order to make gettimeofday produce anything reasonable.  In
>     practice jiffies_64 is incremented again in do_timer before
>     anything else reads it, so the net effect is minimal.

I don't think this is what your seeing.  As I read the code, if an interrupt 
gets delayed and the next one is not, you will determine that you should 
decrement jiffies.  Interrupts DO get delayed.  This counter is only being used 
to cover the jiffie to jiffie time.  I suspect that any systemic errors such as 
different rocks are not really important (but drift needs to be accounted for, 
see below).

The better thing to do here is to figure some arbitrary start time when a 
jiffies edge is "close" to the actually interrupt time and use the counter time 
at that time as the "base" time.  Each jiffie you then bump this by the counts 
per jiffie.  (By the way, this should be calculated using TICK_NSEC (nsecs per 
tick) and NOT HZ.  TICK_NSEC accounts for the fact that the PIT does not produce 
exactly 1/HZ ticks.)

In addition to this, at each interrupt, to account for drift, I have been using 
code that, on each interrupt, checks if it is early (i.e.:
  base + ticks_per_jiffy > now) if so adjust base to make it on time.  If it is 
late, I keep the minimum amount it is late for several ticks and then adjust 
base to make it on time.  This ends up making small changes in "base" to account 
for any drift.  It also ends up ignoring occasional late times caused by normal 
interrupt latency.  If it is late by over a tick, jiffies is adjusted for the 
lost tick.  (All this code is in the high-res-timers patch, see signature.)

Do note this assumes (and IMHO rightly so) that the PIT is the system time gold 
standard.

George
> 
> (2) The 27MHz timer is accessed via the PCI bus, which is not
>     available when the system clock is initialized.  To work around
>     this, I've written the init function to always fail so that
>     loops_per_jiffy is computed using another timer (the TSC in my
>     case).  Once the high-resolution timer is accessible, the kernel
>     will switch to using it to compute gettimeofday and the monotonic
>     clock, but still use the original timer's delay function.  This
>     is somewhat kludgy, but I can't see a cleaner way.
> 
> (3) The timer depends on CONFIG_SCx200, which appears later in the
>     configuration hierarchy to the timers, and in an entirely
>     different part.  For now I've kept its Kconfig with the other
>     timers, but I'm not entirely happy with this choice.
>     
> The patch is against linux-2.6.11-mm2 as it relies on the
> 'determine-scx200-cb-address-at-run-time.patch' patch which has not
> made it into in the mainline.
> 
> Please CC me if you reply as I'm not subscribed to LKML.
> 
> Cheers,
> -Ted
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

