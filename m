Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVECRCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVECRCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 13:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVECRCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 13:02:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22748 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261378AbVECRCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 13:02:35 -0400
Date: Tue, 3 May 2005 10:02:24 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       paulus@samba.org, schwidefsky@de.ibm.com, mahuja@us.ibm.com,
       donf@us.ibm.com, mpm@selenic.com, benh@kernel.crashing.org
Subject: Re: [RFC][PATCH] new timeofday-based soft-timer subsystem
Message-ID: <20050503170224.GA2776@us.ibm.com>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com> <20050429233546.GB2664@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429233546.GB2664@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc3-mm2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.2005 [16:35:46 -0700], Nishanth Aravamudan wrote:
> * john stultz <johnstul@us.ibm.com> [2005-0429 15:45:47 -0700]:
> 
> > All,
> >         This patch implements the architecture independent portion of
> > the time of day subsystem. For a brief description on the rework, see
> > here: http://lwn.net/Articles/120850/ (Many thanks to the LWN team for
> > that clear writeup!)
> 
> I have been working closely with John to re-work the soft-timer subsytem
> to use the new timeofday() subsystem. The following patch attempts to
> being this process. I would greatly appreciate any comments.

I am not sure if anyone has looked at this patch closely, but I have
noticed one issue: My code assumes that all the rounding will be done
internally (rounding up on addition to find to the nearest
timerinterval); however, current interfaces do much of the rounding
before passing on structures on to the soft-timer subsystem, because the
jiffies-based one always rounds down.

This is most clear in sys_nanosleep(). Without any modifications to the
syscall, but with my patch applied, one will see around 5 millisecond
sleeps for a 1 millisecond request. This occurs, I believe, because
jiffies_to_timespec() rounds up once, we add one if there is any value
and then in internally I round up once more. If I rewrite
sys_nanosleep() to use schedule_timeout_nsecs() and thus never convert
from nanoseconds, I see 2 millisecond sleeps for 1 millisecond requests,
which is much closer (and accurate, as our granularity is slightly
greater than 1 millisecond and we are interruptiing at HZ=1000 slightly
more often than ever millisecond). This seems to be the right solution,
but then there is another issue: the restart_block used by
sys_nanosleep() only allows for 4 unsigned long arguments, when, in
fact, nanoseconds are a 64-bit quantity in the kernel. As long as the
nanosleep() request is no more than around 4 seconds, we should be ok
using unsigned longs. But anything longer will simply truncate
currently. I am not certain of a clean way to modify the restart_block
to incorporate a 64-bit quantity, as it is used by other interfaces as
well.

I still need to update the other version of nanosleep() (nsleep() and
posix) before I post an updated patch. Just wanted to let everyone know
of the issue.

Thanks,
Nish
