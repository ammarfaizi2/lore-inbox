Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWFTNtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWFTNtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWFTNtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:49:36 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:53862 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750862AbWFTNtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:49:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6fs+IZfI4zTEqD1lMtRhtv5AX344LfX7V88Few5Ye300tS4Tqgvv6IypH8hc0vdbdNbxVBimgzvukS9AnZps4/RkIQQVP/BnlboY+ezXDssq4eB9Mn0eUcWwUJLAKAABDJHw9/LY0o9EL3HaJkcJR9ejN/Oi1KRBZPE+wvfkFtI=  ;
Message-ID: <4497F9F1.8060708@yahoo.com.au>
Date: Tue, 20 Jun 2006 23:36:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Dave Olson <olson@unixfolk.com>, ccb@acm.org,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>	 <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>	 <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>	 <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au>	 <20060620083305.GB7899@elte.hu> <4497C1BC.9090601@yahoo.com.au>	 <20060620095135.GC11037@elte.hu>  <4497D4FF.6000706@yahoo.com.au> <1150808692.2891.194.camel@laptopd505.fenrus.org>
In-Reply-To: <1150808692.2891.194.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Correct me if I'm wrong, but... a read-lock requires at most a single
>>cacheline transfer per lock acq and a single per release, no matter the
>>concurrency on the lock (so long as it is read only).
>>
>>A spinlock is going to take more. If the hardware perfectly round-robins
>>the cacheline, it will take lockers+1 transfers per lock+unlock.
> 
> 
> This is a bit too simplistic view; shared cachelines are cheap, it's
> getting the cacheline exclusive (or transitioning to/from exclusive)
> that is the expensive part...

Taking the lock is going to transiation the cacheline to exclusive. If
the next locker tries to take the lock, they transfer the cacheline and
exclusive access and fail. If they have already tried to take the lock
earlier, they might only request a readonly state, but it still requires
a cacheline transfer (which is the expensive part).

The only way it is simplistic is that hardware will be unfair and give
the same, or "close" requesters priority for some time, so the cacheline
stays close.

At some point, when it gets transferred away, there is no guarantee that
the spinlock will be unlocked. Quite likely the opposite, if there is
large contention for it and/or its cacheline.

> 
> (note that our spinlocks are fixed nowadays to only do the slowpath side
> of things for read, eg allow shared cachelines there)

To put it another way, when 1 CPU takes or releases the lock, the cachelines
of 11 others are invalidated. In a perfect round-robin, if 12 queue up at the
same time, 1 will go through and 11 will fail (= 12 cacheline transfers). So
in this situation, the reader lock has a factor of 12 better acquisition
throughput.

Now the situation is simplistic (all queueing at the same time, perfectly
fair hardware), but the cacheline transfer costs are accurate *for this
situation*.

So I think rwlocks do have a fundamental advantage over spinlocks (aside
from the multiple concurrent readers advantage, although the two properties
are obviously fundamentally related). It is yet to be shown whether that is
actually the cause of Peter's performance improvement, but that is my
guess.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
