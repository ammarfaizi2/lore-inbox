Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVE2Nay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVE2Nay (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 09:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVE2Nay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 09:30:54 -0400
Received: from main.gmane.org ([80.91.229.2]:31430 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261303AbVE2Nak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 09:30:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joe Seigh" <jseigh_02@xemaps.com>
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
Date: Sun, 29 May 2005 09:29:37 -0400
Message-ID: <opsrjg3nmvehbc72@grunion>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005 21:04:37 -0400, Kyle Moffett <mrmacman_g4@mac.com>  
wrote:

> On May 27, 2005, at 18:31:38, David Nicol wrote:
>> On 5/26/05, john cooper <john.cooper@timesys.com> wrote:
>>
>>> given design.  Clearly we aren't buying anything to trade off
>>> a spinlock protecting the update of a single pointer with a
>>> blocking lock and associated context switching.
>>
>> On contention, and only on contention, we are faced with the question  
>> of what
>> to do.  Do we wait, or do we go away and come back later?  What  
>> information is
>> available to us to base the decision on?  We can't gather any more  
>> information,
>> because that would take longer than spin-waiting.  If the "spinaphore"  
>> told us,
>> on acquisition failure, how many other threads were asking for it, we
>> could implement
>> a tunable lock, that surrenders context when there are more than N
>> threads waiting for
>> the resource, and that otherwise waits its turn, or its chance,  as a  
>> compromise
>> and synthesis.
>
> Here is an example naive implementation which could perhaps be optimized  
> further
> for architectures based on memory and synchronization requirements.
>
> A quick summary:
> Each time the lock is taken and released, a "hold_time" is updated which  
> indicates
> the average time that the lock is held.  During contention, each CPU  
> checks the
> current average hold time and the number of CPUs waiting against a  
> predefined
> "context switch + useful work" time, and goes to sleep if it thinks it  
> has enough
> time to spare.

If you went with a bakery algorithm and could tolerate FIFO service order,  
you could use
the expected service time as the ticket increment value instead of 1.    
Before a thread
gets a ticket, it examines the expected queue wait time, the difference  
between the
current ticket and the next available ticket, to decide which increment to  
be applied
to the next ticket value.   The two possible increment values would be the  
uncontended
resource service time and that value plus thread suspend/resume  
overhead.   If the
expected wait time is greater than the latter, it uses the latter as the  
increment value
and suspends rather than spins.

Bakery algorithms have other nice properties.  The lock release  
(incrementing the
current ticket) doesn't require an interlocked operation, though the  
release memory
barrier and other memory barriers required to determine if there are any  
waiters may
make that somewhat moot.   The next  and current tickets could be kept in  
separate
cache lines.   And the get ticket interlocked operations are staggered  
out, unlike a
conventional spin lock where once the lock is released, *all* waiting  
processors
attempt to acquire the lock cache line exclusive all at once.   The slows  
down
the lock release since the cache line is guaranteed to be held by another  
processor
if there was lock contention.

Also bakery spin locks can be rather easily modified to be rwlocks with no  
extra
overhead to speak of.   Basically, you get rwlock capability for free.

-- 
Joe Seigh

