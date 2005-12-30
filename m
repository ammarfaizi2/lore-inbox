Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVL3CFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVL3CFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVL3CFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:05:19 -0500
Received: from smtp104.plus.mail.mud.yahoo.com ([68.142.206.237]:24760 "HELO
	smtp104.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750765AbVL3CFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:05:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KPlvd1EnGi9KfGKqgzkz2jWzEH9oTxg34PwEULp8aLc53nU1IVF4vfnWT4bqMkC87nmlGGObOoYI5QwMjkaqHA5nhZBfINcW6f7hJ3GjHcsCtCcxwu1AoNBY1Ztx9btabiNjH/VBLL+j6p9DQ/xscc4E9G9rU4KfdbglebO0IWo=  ;
Message-ID: <43B495D7.8080503@yahoo.com.au>
Date: Fri, 30 Dec 2005 13:05:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain> <1135685158.2926.22.camel@laptopd505.fenrus.org> <20051227131501.GA29134@elte.hu> <Pine.LNX.4.64.0512282222400.3309@localhost.localdomain> <20051229083333.GA31003@elte.hu> <43B3A5F2.5060903@yahoo.com.au> <Pine.LNX.4.64.0512291148560.3309@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512291148560.3309@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:

> I provided you with the demonstration last week:
> 

I didn't really find it convincing.

> - the non SMP (ARM version < 6) is using xchg.
> 
> - xchg on ARM version < 6 is always faster and smaller than any 
>   preemption disable.
> 

Maybe true, but as I said, if you have preemption enabled, then there
are far more preempt_xxx operations in other places than semaphores,
which impact both size and speed.

> - xchg on ARM is the same size as the smallest solution you may think of
>   when preemption is disabled and never slower (prove me otherwise? if 
>   you wish).
> 

I was going from your numbers where you said it was IIRC a cycle faster.

> - all xchg based primitives are "generic" code already.
> 

And yet there is a need for architecture specific code. Also having
xchg and a cmpxchg variants mean that you have two different sets of
possible interleavings of instructions, and xchg has much more subtle
cases as you demonstrated.

> And I think you didn't look at the overall patch set before talking 
> about "lots of ugliness", did you?  The fact is that the code, 

Yes I did and I think it is more ugly than my proposal would be.

> especially the core code, is much cleaner now than it was when 
> everything was seemingly "generic" since the current work on 
> architecture abstractions still allows optimizations in a way that is so 
> much cleaner and controlled than what happened with the semaphore code, 
> and the debugging code can even take advantage of it without polluting 
> the core code.
> 
> It happens that i386, x86_64 and ARM (if v6 or above) currently have 
> their own tweaks to save space and/or cycles in a pretty strictly 
> defined way.  The effort is currently spent on making sure if other 
> architectures want to use one of their own tricks for those they can do 
> it without affecting the core code which remains 95% of the whole thing 
> (which is not the case for semaphores), and the currently provided 
> architecture specific versions are _never_ bigger nor slower than any 
> generic version would be.  Otherwise what would be the point?  
> 

I don't think size is a great argument, because the operations should
be out of line anyway to save icache (your numbers showed a pretty
large increase when they're inlined)

And as for speed, I'm not arguing that you can't save a couple of
cycles, but I'm weighing that against the maintainability of a generic
implementation which has definite advantages. Wheras I don't think you
could demonstrate any real speed improvement for saving a few cycles
from slightly faster semaphore operations on CONFIG_PREEMPT kernels?

If someone ever did find the need for an arch specific variant that
really offers advantages, then there is nothing to stop tha being
added.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
