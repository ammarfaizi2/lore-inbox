Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbUBCLUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 06:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUBCLUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 06:20:16 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:38634 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265992AbUBCLUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 06:20:05 -0500
Message-ID: <401F83C2.3000100@cyberone.com.au>
Date: Tue, 03 Feb 2004 22:19:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
References: <200401291917.42087.kernel@kolivas.org> <200402032152.46481.kernel@kolivas.org> <20040203105758.GA7783@elte.hu> <200402032207.38006.kernel@kolivas.org>
In-Reply-To: <200402032207.38006.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 3 Feb 2004 21:58, Ingo Molnar wrote:
>
>>* Con Kolivas <kernel@kolivas.org> wrote:
>>
>>>At least it appears Intel are well aware of the priority problem, but
>>>full priority support across logical cores is not likely. However I
>>>guess these new instructions are probably enough to work with if
>>>someone can do the coding.
>>>
>>these instructions can be used in the idle=poll code instead of rep-nop.
>>This way idle-wakeup can be done via the memory bus in essence, and the
>>idle threads wont waste CPU time. (right now idle=poll wastes lots of
>>cycles on HT boxes and is thus unusable.)
>>
>
>Thanks for explaining.
>
>
>>for lowprio tasks they are of little use, unless you modify gcc to
>>sprinkle mwait yields all around the 'lowprio code' - not very practical
>>i think.
>>
>
>Yuck!
>
>Looks like the kernel is the only thing likely to be smart enough to do this 
>correctly for some time yet. 
>
>Nick, any chance of seeing something like this in your sched domains? (that 
>would be the right way unlike my hacking sched.c directly for a specific 
>architecture).
>
>

Yeah it wouldn't be too difficult

Con Kolivas wrote:

>On Tue, 3 Feb 2004 21:58, Ingo Molnar wrote:
>
>>* Con Kolivas <kernel@kolivas.org> wrote:
>>
>>>At least it appears Intel are well aware of the priority problem, but
>>>full priority support across logical cores is not likely. However I
>>>guess these new instructions are probably enough to work with if
>>>someone can do the coding.
>>>
>>these instructions can be used in the idle=poll code instead of rep-nop.
>>This way idle-wakeup can be done via the memory bus in essence, and the
>>idle threads wont waste CPU time. (right now idle=poll wastes lots of
>>cycles on HT boxes and is thus unusable.)
>>
>
>Thanks for explaining.
>
>
>>for lowprio tasks they are of little use, unless you modify gcc to
>>sprinkle mwait yields all around the 'lowprio code' - not very practical
>>i think.
>>
>
>Yuck!
>
>Looks like the kernel is the only thing likely to be smart enough to do this 
>correctly for some time yet. 
>
>Nick, any chance of seeing something like this in your sched domains? (that 
>would be the right way unlike my hacking sched.c directly for a specific 
>architecture).
>
>

Yeah it wouldn't be too difficult Con. Basically you can add a flag to
a domain to enable some scheduling "quirk".

In this case you would add a flag to the domain which balances logical
cores in the physical CPU. You can then look up your lowest domain
with cpu_sched_domain(cpu). If the domain has the required flag set,
you can look at its ->span - which in this case would give you all
logical CPUs (siblings) on this package.

I need to actually do a bit more work and verification on the SMT
setup and make sure it plays nicely with non-ht systems, but after
that I'll probably look at this issue if someone hasn't beaten me to
it.

At the moment I've got my hands pretty full though so it might take
a while...

