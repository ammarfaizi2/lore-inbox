Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVCNIYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVCNIYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCNIYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:24:43 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:44449 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261337AbVCNIYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:24:39 -0500
Message-ID: <42354A3F.4030904@yahoo.com.au>
Date: Mon, 14 Mar 2005 19:24:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> <20050311203427.052f2b1b.akpm@osdl.org> <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com> <20050314070230.GA24860@elte.hu> <42354562.1080900@yahoo.com.au> <20050314081402.GA26589@elte.hu>
In-Reply-To: <20050314081402.GA26589@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>while writing the ->break_lock feature i intentionally avoided
>>>overhead in the spinlock fastpath. A better solution for the bug you
>>>noticed is to clear the break_lock flag in places that use
>>>need_lock_break() explicitly.
>>
>>What happens if break_lock gets set by random contention on the lock
>>somewhere (with no need_lock_break or cond_resched_lock)? Next time it
>>goes through a lockbreak will (may) be a false positive.
> 
> 
> yes, and that's harmless. Lock contention is supposed to be a relatively
> rare thing (compared to the frequency of uncontended locking), so all
> the overhead is concentrated towards the contention case, not towards
> the uncontended case. If the flag lingers then it may be a false
> positive and the lock will be dropped once, the flag will be cleared,
> and the lock will be reacquired. So we've traded a constant amount of
> overhead in the fastpath for a somewhat higher, but still constant
> amount of overhead in the slowpath.
> 

Yes that's the tradeoff. I just feel that the former may be better,
especially because the latter can be timing dependant (so you may get
things randomly "happening"), and the former is apparently very low
overhead compared with the cost of taking the lock. Any numbers,
anyone?

> 
>>>One robust way for that seems to be to make the need_lock_break() macro
>>>clear the flag if it sees it set, and to make all the other (internal)
>>>users use __need_lock_break() that doesnt clear the flag. I'll cook up a
>>>patch for this.
>>>
>>
>>If you do this exactly as you describe, then you'll break
>>cond_resched_lock (eg. for the copy_page_range path), won't you?
> 
> 
> (cond_resched_lock() is an 'internal' user that will use
> __need_lock_break().)
> 

Off the top of my head, this is what it looks like:

spin_lock(&dst->lock);

spin_lock(&src->lock);
for (lots of stuff) {
	if (need_lock_break(src->lock) || need_lock_break(dst->lock))
		break;
}
spin_unlock(&src->lock);

cond_resched_lock(&dst->lock);

Right? Now currently the src->lock is broken, but your change would break
the cond_resched_lock here, it will not trigger because need_lock_break
clears dst->lock... oh I see, the spinning CPU will set it again. Yuck :(

