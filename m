Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVJaQfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVJaQfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVJaQfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:35:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57548 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932432AbVJaQff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:35:35 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: EDAC - clean up atomic stuff
References: <1129902050.26367.50.camel@localhost.localdomain>
	<m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
	<1130772628.9145.35.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 31 Oct 2005 09:34:59 -0700
In-Reply-To: <1130772628.9145.35.camel@localhost.localdomain> (Alan Cox's
 message of "Mon, 31 Oct 2005 15:30:28 +0000")
Message-ID: <m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Gwe, 2005-10-28 at 10:33 -0600, Eric W. Biederman wrote:
>> A couple of questions
>> - Why a u32 for length and not just unsigned?
>
> Because it was loading it into a 32bit counter so the input was 32bit.
> Just habit really.

Since it wasn't an ABI or poking in hardware a fixed size type felt wrong.
It is more of an API and there fixed sized types (not buried in
typedefs) always seem wrong to me.

>> - Why is the x86_64 version clearing 32bit words and not 64bit words,
>>   that should be noticeably faster if we ever need to use that
>>   code.
>
> I doubt it makes much difference. I kept it 32bit to keep the split
> simple. It can certainly be optimised if someone wants to. I'd hope
> however ECC scrub is never a hot path!

If we ever implement background software scrubbing it might become
important.  On older chipsets you only know the chip select that
had problems so you may need to scrub 128MB just to fix one bit.
There are also things like background scrubbing to ensure single bit
errors don't accumulate.  On x86_64 I don't think either is currently
an issues as the chipsets implement the scrubbing for you.

The basic point still remains that touching a lot of memory is something
that could be reasonably done.  And having the code run relatively
fast keeps it from sucking performance from the rest of the system.

But I agree that on x86_64 this isn't a fastpath, or likely to become
one as the hardware doesn't need software scrubbing.

As long as we atomically dirty the cache line without changing data we
should be good for now.

>> - Is KM_BOUNCE_READ a safe atomic_kmap entry to be using?
>>   I'm not certain, but my gut feel is that scrubbing probably
>>   wants it's own kmap type. 
>>   I remember doing some looking when I first wrote this and thinking
>>   that KM_BOUNCE_READ looked safe and was good enough until the code
>>   got merged into the kernel.
>
> I was looking at that. I think it is but I'm not 100% sure or an expert
> on kmaps.

Ok.  If I recall correctly atomic kmaps have the rule that they are
per cpu, and you can't be interrupted when the map is taken, by
something else that will use the map.  But they are safe to use from
interrupt context.  As I recall the code needs to ensure that an
interrupt handler doesn't use the same buffer and that it isn't
preempted where another thread will use the buffer.  The preemption
angle is new since that piece of code was written.

Anyway thanks for picking this up.

Eric

