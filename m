Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVEYDty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVEYDty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 23:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVEYDty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 23:49:54 -0400
Received: from mail.timesys.com ([65.117.135.102]:56228 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262257AbVEYDts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 23:49:48 -0400
Message-ID: <4293F580.3010601@timesys.com>
Date: Tue, 24 May 2005 23:48:16 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Dietrich <sdietrich@mvista.com>
CC: Andrew Morton <akpm@osdl.org>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, mingo@elte.hu, hch@infradead.org,
       linux-kernel@vger.kernel.org, john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance
References: <4292DFC3.3060108@yahoo.com.au>	<20050524081517.GA22205@elte.hu>	<4292E559.3080302@yahoo.com.au>	<20050524090240.GA13129@elte.hu>	<4292F074.7010104@yahoo.com.au>	<1116957953.31174.37.camel@dhcp153.mvista.com>	<20050524224157.GA17781@nietzsche.lynx.com>	<1116978244.19926.41.camel@dhcp153.mvista.com>	<20050525001019.GA18048@nietzsche.lynx.com>	<1116981913.19926.58.camel@dhcp153.mvista.com>	<20050525005942.GA24893@nietzsche.lynx.com>	<1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
In-Reply-To: <4293DCB1.8030904@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2005 03:43:22.0625 (UTC) FILETIME=[E634C710:01C560DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Dietrich wrote:
> Andrew Morton wrote:
> 
>> Daniel Walker <dwalker@mvista.com> wrote:
>>  
>>
>>> I'm not going to ignore any of the discussion, but it would be nice to
>>> hear Andrew's, or Linus's specific objections..
>>>   
>>
>> This thing will be discussed on a patch-by-patch basis.  Contra this 
>> email
>> thread, we won't consider it from an all-or-nothing perspective.
>>
>> (That being said, it's already a mighty task to decrypt your way through
>> the maze-like implementation of spin_lock(), lock_kernel(),
>> smp_processor_id() etc, etc.  I really do wish there was some way we 
>> could
>> clean up/simplify that stuff before getting in and adding more 
>> source-level
>> complexity).
>>
>>  
>>
> The IRQ threads are actually a separate implementation.
> 
> IRQ threads do not depend on mutexes, nor do they depend
> on any of the more opaque general spinlock changes, so this
> stuff SHOULD be separated out, to eliminate the confusion..

There is the assumption a spinlock-mutex can provide
synchronization with interrupt processing.  The means
to effect this is by the interrupt payload running in
task context where it plays by the rules of a spinlock-mutex
(ie: block upon contention).

If the interrupt payload runs in exception context a
blocking spinlock-mutex by definition cannot be used for
synchronization.  Rather we are back to the raw_spinlock
which must also disable exception interrupts in tandem
with acquiring the raw_spinlock -- an attempt to acquire
the raw_spinlock in exception interrupt context must be
guaranteed to always succeed.

So there is a mutual design dependence between IRQ threads
and spinlock-mutexes in order to allow interrupt payload
processing to be pushed into kernel scheduleable task context.
This gives the benefit of minimizing the amount of time a
CPU spends in exception interrupt context and eliminates
the need for the spinlock-mutex to resort to disabling
interrupts in order to synchronize with payload execution.

> There was an original IRQ threads submission by
> John Cooper/ TimeSys, about a year ago, which Ingo
> subsequently rewrote.

I wasn't involved in that work.  The credit there goes to
Scott Wood.

> As a logical prerequisite to the Mutex stuff, the IRQ threads, if broken 
> out,
> could allow folks to test the water in the shallow end of the pool.

Dropping IRQ threads will require either a reversion to
all raw_spinlock usage or creation of a spinlock-mutex
version which disables interrupts for cases where code
must synchronize with exception interrupts.  Neither of
these sounds particularly attractive compared to the
IRQ thread mechanism.

I'd like to hear some technical arguments of why IRQ threads
are held with such suspicion.  Also it isn't the case prior
mechanisms are being obsoleted.   Exception context interrupt
processing and raw_spinlocks to synchronize with them are
still available and will be for those edge cases which
are not addressable via spinlock-mutexes.

-john


-- 
john.cooper@timesys.com
