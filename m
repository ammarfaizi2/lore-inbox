Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVCNID7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVCNID7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVCNID7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:03:59 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:4203 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261330AbVCNIDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:03:55 -0500
Message-ID: <42354562.1080900@yahoo.com.au>
Date: Mon, 14 Mar 2005 19:03:46 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> <20050311203427.052f2b1b.akpm@osdl.org> <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com> <20050314070230.GA24860@elte.hu>
In-Reply-To: <20050314070230.GA24860@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Hugh Dickins <hugh@veritas.com> wrote:
> 
> 
>>@@ -187,6 +187,8 @@ void __lockfunc _##op##_lock(locktype##_
>> 			cpu_relax();					\
>> 		preempt_disable();					\
>> 	}								\
>>+	if ((lock)->break_lock)						\
>>+		(lock)->break_lock = 0;					\
> 
> 
> while writing the ->break_lock feature i intentionally avoided overhead
> in the spinlock fastpath. A better solution for the bug you noticed is
> to clear the break_lock flag in places that use need_lock_break()
> explicitly.
> 

What happens if break_lock gets set by random contention on the
lock somewhere (with no need_lock_break or cond_resched_lock)?
Next time it goes through a lockbreak will (may) be a false positive.

I think I'd prefer the additional lock overhead of Hugh's patch if
it gives better behaviour. I think. Any idea what the overhead actually
is?

> One robust way for that seems to be to make the need_lock_break() macro
> clear the flag if it sees it set, and to make all the other (internal)
> users use __need_lock_break() that doesnt clear the flag. I'll cook up a
> patch for this.
> 

If you do this exactly as you describe, then you'll break
cond_resched_lock (eg. for the copy_page_range path), won't you?

