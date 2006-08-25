Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWHYFeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWHYFeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 01:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWHYFeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 01:34:00 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:4481 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030180AbWHYFd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 01:33:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KQtbY1aEOChCJ0BZP4eSUCfFcIe+wYd9cZUjlUmXPB//UAbrQ34mRY2RXMe9o1C3AWJLmBvjH+O7Eno5yxdf+kxb8do8zUpSGsrMEaEM1XKAtXutIjhyZaIiXPRrS2y6ZvGn9/UMmLDSEclVG31kFypv2nNF7Rx87y9sFcMH150=  ;
Message-ID: <44EE8BA8.2090706@yahoo.com.au>
Date: Fri, 25 Aug 2006 15:33:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, Edward Falk <efalk@google.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
References: <44ED157D.6050607@google.com>	<p7364gifx8o.fsf@verdi.suse.de> <20060824213828.5504b4de.akpm@osdl.org>
In-Reply-To: <20060824213828.5504b4de.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On 24 Aug 2006 08:45:11 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> 
>>Edward Falk <efalk@google.com> writes:
>>
>>
>>>Add spin_lock_string_flags and _raw_spin_lock_flags() to
>>>asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
>>>semantics on x86_64 as it does on i386 and does *not* have interrupts
>>>disabled while it is waiting for the lock.
>>
>>Did it fix anything for you?
>>
> 
> 
> It's the rendezvous-via-IPI problem.  Suppose we want to capture all CPUs
> in an IPI handler (TSC sync, for example).
> 
> - CPUa holds read_lock(&tasklist_lock)
> - CPUb is spinning in write_lock_irq(&taslist_lock)
> - CPUa enters its IPI handler and spins
> - CPUb never takes the IPI and we're dead.
> 
> Re-enabling interrupts while we spin will prevent that.  But I suspect that
> if we ever want to implement IPI rendezvous (and cannot use the
> stop_machine_run() thing) then we might still have problems.  A valid
> optimisation (which we use in some places) is:
> 
> 	local_irq_save(flags);
> 	<stuff>
> 	write_lock(lock);

Yes, or it may be taken inside a section that needs interrupts off for
correctness (eg. if it is holding an irq safe lock). And in the current
implementation I don't think the plain _irq variants reenable interrupts
because that would require reading the register.

Would it be sufficient to just do pair-wise rendezvous, where the
initiating CPU is in a known good state? For TSC sync it might be...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
