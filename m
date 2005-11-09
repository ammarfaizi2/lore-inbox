Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVKICNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVKICNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKICNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:13:46 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7139 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965156AbVKICNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:13:46 -0500
Message-ID: <43715B69.5040609@us.ibm.com>
Date: Tue, 08 Nov 2005 20:14:01 -0600
From: Andrew Theurer <habanero@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Theurer <habanero@us.ibm.com>, nickpiggin@yahoo.com.au,
       anton@samba.org, tbrian@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
References: <43715361.3070802@us.ibm.com>
In-Reply-To: <43715361.3070802@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:

>> I would also take a look at removing SD_WAKE_IDLE from the flags.
>> This flag should make balancing more aggressive, but it can have
>> problems when applied to a NUMA domain due to too much task
>> movement.
>
> Anton wrote:
> I was wondering how ppc64 ended up with different parameters in the NODE
> definitions (added SD_BALANCE_NEWIDLE and SD_WAKE_IDLE)    and it looks
> like it was Andrew :)
>
> http://lkml.org/lkml/2004/11/2/205

FWIW I changed all arch's, but most (except ppc) got changed back.  At 
the time we had data showing the more aggressive wake idle and newidle 
was good for things like OLTP.

Brian, do you have cpu util numbers and runqueue lengths for both tests?

>
> It looks like balancing was not agressive enough on his workload too.
> Im a bit uneasy with only ppc64 having the two flags though.

Brian wrote:

> We suspect the regression was introduced in the scheduler changes
> that went into 2.6.13-rc1.  However, the regression was hidden
> from us by a bug in include/asm-ppc64/topology.h that made ppc64
> look non-NUMA from 2.6.13-rc1 through 2.6.13-rc4.  That bug was
> fixed in 2.6.13-rc5.  Unfortunately the workload does not run to
> completion on 2.6.12 or 2.6.13-rc1.

Brian, I am not sure if you were thinking of a particular set of sched 
changes, but I suspect it might be one or more in the list below (my 
guess is the first and last).  Would it be possible to back out these 
change-sets from 2.6.13-rc5 and see if there is any difference?  FWIW, 
even if they do help, I am not suggesting, yet, that they should be 
reverted.  I am hoping there is some compromise that can work better in 
all situations.

-Andrew

commit cafb20c1f9976a70d633bb1e1c8c24eab00e4e80
Author: Nick Piggin <nickpiggin@yahoo.com.au>
Date:   Sat Jun 25 14:57:17 2005 -0700

    [PATCH] sched: no aggressive idle balancing
    
    Remove the very aggressive idle stuff that has recently gone into 2.6 - it is
    going against the direction we are trying to go.  Hopefully we can regain
    performance through other methods.
    
    Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

commit a3f21bce1fefdf92a4d1705e888d390b10f3ac6f
Author: Nick Piggin <nickpiggin@yahoo.com.au>
Date:   Sat Jun 25 14:57:15 2005 -0700

    [PATCH] sched: tweak affine wakeups
    
    Do less affine wakeups.  We're trying to reduce dbt2-pgsql idle time
    regressions here...  make sure we don't don't move tasks the wrong way in an
    imbalance condition.  Also, remove the cache coldness requirement from the
    calculation - this seems to induce sharp cutoff points where behaviour will
    suddenly change on some workloads if the load creeps slightly over or under
    some point.  It is good for periodic balancing because in that case have
    otherwise have no other context to determine what task to move.
    
    But also make a minor tweak to "wake balancing" - the imbalance tolerance is
    now set at half the domain's imbalance, so we get the opportunity to do wake
    balancing before the more random periodic rebalancing gets preformed.
    
    Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

commit 7897986bad8f6cd50d6149345aca7f6480f49464
Author: Nick Piggin <nickpiggin@yahoo.com.au>
Date:   Sat Jun 25 14:57:13 2005 -0700

    [PATCH] sched: balance timers
    
    Do CPU load averaging over a number of different intervals.  Allow each
    interval to be chosen by sending a parameter to source_load and target_load.
    0 is instantaneous, idx > 0 returns a decaying average with the most recent
    sample weighted at 2^(idx-1).  To a maximum of 3 (could be easily increased).
    
    So generally a higher number will result in more conservative balancing.
    
    Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

commit 99b61ccf0bf0e9a85823d39a5db6a1519caeb13d
Author: Nick Piggin <nickpiggin@yahoo.com.au>
Date:   Sat Jun 25 14:57:12 2005 -0700

    [PATCH] sched: less aggressive idle balancing
    
    Remove the special casing for idle CPU balancing.  Things like this are
    hurting for example on SMT, where are single sibling being idle doesn't really
    warrant a really aggressive pull over the NUMA domain, for example.
    
    Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>




