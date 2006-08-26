Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWHZHwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWHZHwW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 03:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWHZHwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 03:52:22 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:16442 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S964919AbWHZHwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 03:52:22 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Martin Bligh <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org,
       Michael Davidson <md@google.com>
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave() 
In-reply-to: Your message of "Thu, 24 Aug 2006 08:53:39 MST."
             <44EDCB83.2010806@mbligh.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 Aug 2006 17:52:22 +1000
Message-ID: <2772.1156578742@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh (on Thu, 24 Aug 2006 08:53:39 -0700) wrote:
>Andrew Morton wrote:
>> On Thu, 24 Aug 2006 13:10:09 +1000
>> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>> 
>> 
>>>Edward Falk wrote:
>>>
>>>>Add spin_lock_string_flags and _raw_spin_lock_flags() to 
>>>>asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same 
>>>>semantics on x86_64 as it does on i386 and does *not* have interrupts 
>>>>disabled while it is waiting for the lock.
>>>>
>>>>This fix is courtesy of Michael Davidson
>>>
>>>So, what's the bug? You shouldn't rely on these semantics anyway
>>>because you should never expect to wait for a spinlock for so long
>>>(and it may be the case that irqs can't be enabled anyway).

AFAICT the first architecture that enabled interrupts while spinning
was IA64.  http://www.gelato.unsw.edu.au/archives/linux-ia64/0404/9161.html
I did that patch because large NUMA systems were suffering from cache
line bouncing on spinlocks which increased the time that interrupts
were disabled.  This effect tends not to show up on small systems, but
it does make a measurable difference for large systems.

An additional benefit of enabling interrupts in the contention path is
that it lets you get in with a profiler or debugger to track down
deadlock or long lock problems.  Enabling interrupts in the contention
path has no disadvantages and it increases system responsiveness and
availability.

