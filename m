Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVIHThK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVIHThK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVIHThK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:37:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:45316 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964964AbVIHThJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:37:09 -0400
Message-ID: <43209457.6060301@tmr.com>
Date: Thu, 08 Sep 2005 15:43:19 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jan.kiszka@googlemail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>	 <1125854398.23858.51.camel@localhost.localdomain>	 <p73aciqrev0.fsf@verdi.suse.de> <dfk5cp$19p$1@sea.gmane.org>	 <58d0dbf10509061005358dce91@mail.gmail.com>	 <dfkjav$lmd$1@sea.gmane.org>	 <58d0dbf105090612421dcd9d8d@mail.gmail.com> <431F2760.5060904@tmr.com> <58d0dbf10509071054175e82ff@mail.gmail.com>
In-Reply-To: <58d0dbf10509071054175e82ff@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka wrote:
> 2005/9/7, Bill Davidsen <davidsen@tmr.com>:
> 

>>Is there a technical reason ("hard to implement" is a practical reason)
>>why all stacks need to be the same size?
>>
> 
> 
> Because of
> 
> static inline struct thread_info *current_thread_info(void)
> {
>         struct thread_info *ti;
>         __asm__("andl %%esp,%0; ":"=r" (ti) : "" (~(THREAD_SIZE - 1)));
>         return ti;
> }
> [include/asm-i386/thread_info.h]
> 
> which assumes that it can "round down" the stack pointer and then will
> find the thread_info of the current context there. Only works for
> identically sized stacks. Note that this function is heavily used in
> the kernel, either directly or indirectly. You cannot avoid it.

Avoiding it isn't necessary, a config option to read a variable 
THREAD_SIZE would solve this part of it. I looked at the implications of 
this, and other than a slight overhead it looks as if the problem is 
where to put the size :-( I think it could be done given that all 
threads of a process would have the same size, but I am *not* suggesting 
that it should be done.
> 
> My current assessment regarding differently sized threads for
> ndiswrapper: not feasible with vanilla kernels.

Have to agree, it would take way more effort than it's worth, given that 
the need can be avoided by allowing user config of the stack size. It 
does look relatively easy to allow larger stack sizes, though. Wasn't 
there one driver so ill-behaved it wouldn't even run in an 8k stack?

Andi made the point that allocating server size memory in 4k blocks 
results in a lot of them, resulting in increased overhead in some 
places. Thinking about configuring the stack size, maybe it would be 
useful to make memory allocation block size independent of the hardware 
and let both be set over a wide range in config.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
