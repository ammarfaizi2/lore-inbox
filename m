Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSFDPWu>; Tue, 4 Jun 2002 11:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSFDPWt>; Tue, 4 Jun 2002 11:22:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:24075 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312962AbSFDPWs>; Tue, 4 Jun 2002 11:22:48 -0400
Message-ID: <3CFCCD91.4020308@evision-ventures.com>
Date: Tue, 04 Jun 2002 16:24:17 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de> <20020604142327.GN1105@suse.de> <3CFCC467.7060702@evision-ventures.com> <20020604145528.GQ1105@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Jun 04 2002, Martin Dalecki wrote:
> 
>>Jens Axboe wrote:
>>
>>>Neil,
>>>
>>>I tried converting umem to see how it fit together, this is what I came
>>>up with. This does use a queue per umem unit, but I think that's the
>>>right split anyways. Maybe at some point we can use the per-major
>>>statically allocated queues...
>>
>>>/*
>>>+ * remove the queue from the plugged list, if present. called with
>>>+ * queue lock held and interrupts disabled.
>>>+ */
>>>+inline int blk_remove_plug(request_queue_t *q)
>>
>>
>>Jens - I have noticed some unlikely() tag "optimizations" in
>>tcq code too.
>>Please tell my, why do you attribute this exported function as inline?
>>I "hardly doubt" that it will ever show up on any profile.
>>Contrary to popular school generally it only pays out to unroll vector code
>>on modern CPUs not decision code like the above.
> 
> 
> I doubt it matters much in this case. But it certainly isn't called
> often enough to justify the inline, I'll uninline later.
> 
> WRT the unlikely(), if you have the hints available, why not pass them
> on?

Well it's kind like the answer to the question: why don't do it all in hand
optimized assembler? Or in other words - let's give the GCC guys good
reasons for more hard work. But more seriously:

Things like unlikely() tricks and other friends seldomly really
pay off if applied randomly. But they can:

1. Have quite contrary effects to what one would expect due to
the fact that one is targetting a single instruction set but in
reality multiple very different CPU archs or even multiple archs.

2. Changes/improvements to the compiler.

My personal rule of thumb is - don't do something like the
above unless you did:

1. Some real global profiling.
2. Some real CPU cycle counting on the micro level.
3. You really have too. (This should be number 1!)

Unless one of the above cases applies there is only one rule
for true code optimization, which appears to be generally
valid: Write tight code. It will help small and old
systems which usually have quite narrow memmory constrains
and on bigger systems it will help keeping the intruction
caches and internal instruction decode more happy.

Think for example about hints for:

1. AMD's and P4's internal instruction predecode/CISC-RISC translation.
Small functions will give immediately the information - "hey buddy
you saw this code already once...". But inlined stuff will still
trash the predecode engines along the single execution.
2. Think on the fly instruction set translation (Transmeta).
Its rather pretty obvious that a small function is acutally more likely
to be more palatable to software like that...
3. Even the Cyrix486 contained already very efficient mechanism to make
call instructions nearly zero cost in terms of instruction
cycles. (Think return address stack and hints for branch prediction.)

Of corse the above is all valid for decission code, which is the case here,
but not necessarily for tight loops of vectorized operations...

