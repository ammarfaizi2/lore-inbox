Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVABAnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVABAnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 19:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVABAnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 19:43:50 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:23724 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261204AbVABAnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 19:43:47 -0500
Message-ID: <41D743BE.3060207@yahoo.com.au>
Date: Sun, 02 Jan 2005 11:43:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.5isms
References: <20041231230624.GA29411@andromeda> <41D60C35.9000503@yahoo.com.au> <m1acrt7bqy.fsf@muc.de>
In-Reply-To: <m1acrt7bqy.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> 
>>Justin Pryzby wrote:
>>
>>>Hi all, I have more 2.5isms for the list.  ./fs/binfmt_elf.c:
>>>  #ifdef CONFIG_X86_HT
>>>                  /*
>>>                   * In some cases (e.g. Hyper-Threading), we want to avoid L1
>>>                   * evictions by the processes running on the same package. One
>>>                   * thing we can do is to shuffle the initial stack for them.
>>>                   *
>>>                   * The conditionals here are unneeded, but kept in to make the
>>>                   * code behaviour the same as pre change unless we have
>>>                   * hyperthreaded processors. This should be cleaned up
>>>                   * before 2.6
>>>                   */
>>>                  if (smp_num_siblings > 1)
>>>                          STACK_ALLOC(p, ((current->pid % 64) << 7));
>>>  #endif
>>>
>>
>>Can we just kill it? Or do it unconditionally? Or maybe better yet, wrap
>>it properly in arch code?
> 
> 
> You can't kill it without ruining performance on older HT CPUs.
> I would just keep it, it fixes the problem perhaps with a small amount of 
> code. A more generalized #ifdef may be a good idea (NEED_STACK_RANDOM)
> may be a good idea, but it is not really a pressing need. Enabling 
> it unconditionally may be an option, although it will make it harder
> to repeat test runs on non hyperthreaded CPUs.

Interesting. Yeah something like Arjan posted looks better then... having
CONFIG_X86_HT in generic code is obviously pretty ugly.

I'm curious about a couple of points though. First, is that it is basically
just adding a cache colouring to the stack, right? In that case why do only
older HT CPUs have bad performance without it? And wouldn't it possibly make
even non HT CPUs possibly slightly more efficient WRT caching the stacks of
multiple processes?

Second, on what workloads does performance suffer, can you remember? I wonder
if natural variations in the stack pointer as the program runs would mitigate
the effect of this on all but micro benchmarks?

But even if that were so so, it seems simple enough that I don't have any
real problem with keeping it of course.

Thanks,
Nick
