Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284731AbRLZSLO>; Wed, 26 Dec 2001 13:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284736AbRLZSLF>; Wed, 26 Dec 2001 13:11:05 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:47487 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S284731AbRLZSK4>; Wed, 26 Dec 2001 13:10:56 -0500
Posted-Date: Wed, 26 Dec 2001 16:22:44 GMT
Date: Wed, 26 Dec 2001 16:22:44 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley H Williams <rhw@MemAlpha.cx>
To: David Lang <david.lang@digitalinsight.com>
cc: Doug Ledford <dledford@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <Pine.LNX.4.40.0112240951030.24605-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.21.0112261601290.924-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

> so this just means that an eye needs to be kept on the non-dynamic
> syscalls and up the starting point for dynamic syscalls
> significantly before we run out of space for the non-dynamic ones.

How far in advance do you call "significantly"? I know of dedicated
systems still running Linux 1.2.12, and I use 2.0 series kernels on
some of my systems, so your solution is a non-starter in my book.

I'd say that there are only three options for safely dealing with
this problem...

 1. Allocate a fixed range for dynamic syscalls that can NEVER be
    used by static ones. If the static syscalls hit the bottom of
    it, they skip it and restart just above its top.

    Two variants of this have been proposed so far...

 	a.	Negative syscall numbers are dynamic.

 	b.	Syscall numbers with the MSB set are dynamic.

    ...and these are essentially variants on the same thing.

 2. Each syscall includes a flag stating whether it's a static
    or dynamic one, with separate jump tables for each. This
    would be something that is currently always the same state
    for existing static syscalls.

    One variant of this would be to redefine the syscall number
    as being two fields, with the MSB as the static/dynamic flag
    and the rest as the syscall number. This would incorporate
    option (1b) as a variant of this option.

 3. Have separate syscall entry points for static and dynamic
    syscalls.

...and anything else is at risk from the scenario referred to.

> running software that depends on features in a new kernel on a
> significantly older kernel is always questionable, if you software
> really needs to do that you need to watch for a bunch of things.

Very true, but not necessarily relevant.

>>> you miss the point, the syscall numbers will not nessasarily be
>>> consistant from boot to boot so if your code does not check for
>>> them it's seriously broken (and remember this is only for stuff
>>> in experimental status). The hope is that most if not all of the
>>> real checking can end up being done in glibc

>> No, I'm not missing the point. Try to follow with me here, this
>> isn't rocket science. *NOT* *ALL* *SOFTWARE* *IS* *OR* *WILL* *BE*
>> *USING* *DYNAMIC* *SYSCALLS*. Your scenario is fine if you want to
>> convert all existing software to dynamic syscalls. However, my
>> scenario specifically dealt with software that *DOES* *NOT* use
>> dynamic syscalls (and which doesn't need to because the syscalls it
>> *does* use have been allocated).
>>
>> Since people are having such a hard time with this, let me spell it
>> out in more detail. Assume the following scenario:
>>
>> Linux 2.4.17 + dynamic syscall patch. Dynamic syscalls start at 240.

Assume they finish at 255 for my comments below.

>> Linux 2.4.18 comes out, and now there are two *new* *official*
>> *statically* *allocated* syscalls at 240 and 241 (they are
>> SYSGETAMIBLKHEAD and SYSSETAMIBLKHEAD).

Preventing this would require that solution (1) has been implemented,
in which case the new syscalls would be 256 and 257 as 240 through 255
are reserved for the dynamic syscalls.

>> A new piece of software (or an existing one, doesn't matter) is
>> written to take advantage of the new syscalls. It uses the
>> *predefined* syscall numbers and is compiled against 2.4.18. It
>> relies upon -ENOSYS (as is typical for non-dynamic syscalls) to
>> indicate if the kernel doesn't support the intended syscalls.
>>
>> Now, someone without realizing the implications of what's going
>> on, runs this new program on a machine running the 2.4.17+dynamic
>> syscall patch.
>>
>> BOOM!
>>
>> So, to reiterate my points. This *IS* *NOT* *SAFE* unless either
>>
>>  A) the dynamic syscall number range is officially allocated
>>     *before* the patch goes into use to avoid these collisions
>>     later or
>>
>>  B) you switch *all* software to using dynamic syscalls (which
>>     does have a performance impact on the software and which
>>     would also require lots of work).

Best wishes from Riley.

