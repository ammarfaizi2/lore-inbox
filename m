Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbUKVT5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbUKVT5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbUKVT4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:56:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:50625 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262582AbUKVTu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:50:58 -0500
Message-ID: <41A242C1.10600@sgi.com>
Date: Mon, 22 Nov 2004 13:49:21 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] Re: scalability of signal delivery for Posix Threads
References: <41A20AF3.9030408@sgi.com> <20041122160705.GG25636@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041122160705.GG25636@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Mon, Nov 22, 2004 at 09:51:15AM -0600, Ray Bryant wrote:
> 
>>Since signals are sent much more often than sigaction() is called, it would
>>seem to make more sense to make sigaction() take a heavier weight lock of
>>some kind (to update the signal handler decription) and to have the signal
>>delivery mechanism take a lighter weight lock.  Making 
>>current->sighand->siglock a rwlock_t really doesn't improve the situation
>>much, since cache line contention is just a severe in that case (if not 
>>worse) than it is with the current definition.
> 
> 
> What about RCU or seqlock?
> 

Well, the sighand->siglock is taken so many places in the kernel (>200 times)
that RCUing its usage looks like a daunting change to make.

In principle, I guess a seqlock could be made to work.  The idea would be that
we'd want to get a consistent copy of the sighand structure in the presence
of very rare updates.  Once again, I'd have to modify all of those code
paths mentioned above.

Since a seqlock was created AFAIK as an alternate to a brlock, and the
global/local locking structure I described before is more or less equivalent
to a brlock, I think we are thinking along similar lines.

For me, converting spinlock_irqsave(&p->sighand->siglock) to
spinlock_irqsave(&p->siglock) and then checking to make sure that
only task local data is updated in the critical section is an easier
way to go than modifying each of the code paths to deal with the
"failure" case for a seqlock.  But I could be proven wrong.

Anyway, Andi makes a good point -- if I can fast patch SIGPROF handling,
then I may have a more localized change, and that is a good thing [tm].

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
