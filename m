Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVLVQPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVLVQPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVLVQPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:15:42 -0500
Received: from main.gmane.org ([80.91.229.2]:20128 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965124AbVLVQPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:15:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: rcuref optimization
Date: Thu, 22 Dec 2005 11:18:36 -0500
Message-ID: <doejem$hse$1@sea.gmane.org>
References: <doc72s$g43$1@sea.gmane.org> <43AA6B17.4060504@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <43AA6B17.4060504@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Joe Seigh wrote:
> 
>> You can get rid of the requirement for atomic_inc_not_zero logic
>> if you use the logic I first proposed here in c.l.c++.m.
>> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=3E7C83DD.B126DE24%40xemaps.com 
>>
>> for weakptrs where the same kind of logic was required for the strong 
>> count.
>> This will allow you to use fetch_inc (e.g. LOCK INC on x86) instead of 
>> compare
>> and swap logic which might be more efficient on some processors.  You 
>> might
>> even be able to get rid of the the "unincrement" if you are pretty 
>> sure the
>> maximum number of increments won't put the refcount to zero.
>>
> 
> Clever idea.
> 
> I don't know... atomic_inc_not_zero is implemented very easily on the
> many architectures without SMP, and I think it *could* be implemented
> very nicely on ll/sc based architectures without using cmpxchg.
> 
> Lastly, your InterlockedIncrement and InterlockedDecrement are not
> actually atomic_inc (LOCK INC), but atomic_inc_return (XADD). Another
> primitive like atomic_inc_return_negative or something could be added
> to take advantages of status flags and use LOCK INC, but this will
> probably not be worthwhile for any architecture other than i386/x86-64
> (ie. it will be plain worse on most ll/sc and UP-only architectures
> once they get around to implementing atomic_inc_not_zero properly)

In other words, if you *don't* implement it, it will be plain worse
on architectures that do have native atomic_inc.  (sorry, couldn't resist :) )
> 
> Also, the extra logic and atomic op in the decrement-to-zero case
> takes a bit of shine off it even for i386. I'd say we should stick
> to what we have unless we see some really compelling numbers.

The extra atomic op should be on a somewhat infrequently executed path
if you're in a typical readers/writers situation, which I think is the
case.  Probably RCU lookups that return by reference rather than by value.

On the read side, the atomic increment might make a difference with less
conditional branches needed but it probably matters more what the overall
contribution to performance is.  If the refcount increment is only 1% of
overall cost then even if an atomic increment is 2 or 3 times faster than
the present scheme, it probably wouldn't matter that much.

That said, the refcount can be considered an opaque data type and if you
don't hard code the implementation into your api naming scheme, you can
use the present implementation and alter some platform implementations
later if it did look like there was an advantage.  E.g., go back to
rcuref_inc/dec and have them return success/fail instead of the value
of the refcount so you can keep it as an opaque data type.

I may even go add GC guarded refcounting to my atomic-ptr-plus project.
I hadn't done it before since I didn't have a good RCU for preemptive
user threads implementation and besides I already had atomically threadsafe
refcounted smart pointers that didn't depend on some other form of GC.
But it occurs to me that it will work fine with the proxy GC and with
the RCU+SMR where you might want to keep even longer term references
than would be feasible to use a hazard pointer for.


--
Joe Seigh

