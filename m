Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSBZXQK>; Tue, 26 Feb 2002 18:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSBZXQA>; Tue, 26 Feb 2002 18:16:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11503 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288086AbSBZXPv>; Tue, 26 Feb 2002 18:15:51 -0500
Message-ID: <3C7C16AC.D08F8152@mvista.com>
Date: Tue, 26 Feb 2002 15:13:48 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] enable uptime display > 497 days on 32 bit
In-Reply-To: <Pine.LNX.4.33.0202261754030.14645-100000@gans.physik3.uni-rostock.de> <3C7BE53E.BB789BC6@mvista.com> <20020226135006.R12832@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Feb 26, 2002  11:42 -0800, george anzinger wrote:
> > Well, since you asked (thank you), the high-res-timers patch needs to
> > get the full 64-bit uptime to implement CLOCK_MONOTONIC.
> > This means that the 64-bit jiffies is used "often" in this code.
> > Unlike this patch, it keeps the 64-bit rational (i.e. always current)
> 
> Well, if you use the get_jiffies64() interface the 64-bit value is
> always coherent as well, and the direct access to the 32-bit value
> is monotonic.  While the high and low words of the 64-bit jiffies
> values may be incoherent at times, as long as you always access the
> 64-bit value with the get_jiffies64() interface it should be OK.
> 
> Do you think that doing a 64-bit add-with-carry to memory on each
> timer interrupt and doing multiple volatile reads is faster than
> doing a spinlock with an optional 32-bit increment?  

I think the memory cycle is "almost" free as we are also updating
jiffies which is in the same cache line, so, yes, in the overall scheme
of things the overhead of the additional add-with-carry is very small. 
On the read side of things, the issue is not so much the lock, but the
irq nature of it.  This will be VERY long, much longer than the double
load of the high order bits, again from the same cache line.

> Do you think
> there would be a lot of contention on this lock, given that you
> only need to lock when you need the full 64-bit value?

A question that arises is if you can use an independant lock.  For the
high-res code, we need to be coherent with the sub-jiffie part also, and
this is all updated in the interrupt code, so the lock, it would seem,
should be the one that is taken there, which is the xtime read/write irq
lock.  Again, it is the irq nature of things that is slow.

> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
