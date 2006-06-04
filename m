Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751003AbWFDTQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWFDTQd (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 15:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFDTQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 15:16:33 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:7914 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750998AbWFDTQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 15:16:32 -0400
Message-ID: <44833040.2000007@comcast.net>
Date: Sun, 04 Jun 2006 15:10:56 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Per-architecture randomization
References: <44825E42.5090902@comcast.net>	 <1149411968.3109.79.camel@laptopd505.fenrus.org>	 <44830703.3000905@comcast.net>	 <1149441301.3109.120.camel@laptopd505.fenrus.org>	 <448327ED.1040105@comcast.net> <1149447406.3109.142.camel@laptopd505.fenrus.org>
In-Reply-To: <1149447406.3109.142.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Sun, 2006-06-04 at 14:35 -0400, John Richard Moser wrote:
> 
>> Stack and mmap() VMA alignment is based on PAGE_SIZE.
> 
> which breaks ppc64 for hugetlbs at least.
> 
>> Explain "randomization within each region."  I thought mmap()
>> randomization just shifted the mmap() base around at process start?
> 
> ia64 and iirc also ppc64 have different regions in the VA space for
> different types of mmaps. Hugetlb, executable, non-cachable etc etc.
> 

Whoa.

Looks like I need a little education on this subject before I can come
up with a solution to this one.

> 
>>>>   - Less code to maintain
>>> we're talking less than a handful lines of code again, most of which is
>>> NOT shareable.
>>>
>> The relevant parts are sharable.  I just moved this stuff out into
>> fs/exec.c:
> 
> ... and made it a lot more complex.
> 

My mm.h macros are a lot more complex, probably.  Although it would help
if you pointed out where "complexity" shows up; honestly for the most
part it looks clean and neat to me, besides a few rough edges and
excessive commenting.

>> Yes, this is the same solution as with TASK_SIZE (which is about 3 lines
>> above this...)
> 
> the rules for mmap_base vary per architecture, and even per binary time.
> In fact the meaning of it is very much free for the architecture to
> determine/use.

So the base can't just be randomized once?

>>>> 2.  I can get away with exactly 1 arch_align_stack() function, instead
>>>> of 1 per architecture.
>>> I don't think that that is fundamentally possible, see above.
>> Did it already, for any STACK_ALIGN, any PAGE_SIZE, any level of
>> entropy, and for stacks that grow up and down.  The only situations that
>> I haven't handled are stacks that grow up and down at the same time,
> 
> ok so you haven't dealt with ia64 yet ;)
> 

So far IA-64 sounds like "we designed this while on acid," but fair
enough.  Explain.

>>  and
>> stacks that teleport data to other dimensional planes.
> 
> and with stacks that need different alignment based on binary type (mips
> has 4 or so of those) or .. or ..

Use the same solution as TASK_SIZE, although 4 binary types is going to
become painful yes.  You can do it with a #define but I'm getting the
feeling that these parts may need per-architecture and per-binary-type
functions to sort it out (in the same way that there was an mmap_base()
for IA-32 and x86-64 in x86-64).

> 
> 
>> The level of stack entropy was definitely not per-architecture; 
> 
> no but it COULD be. I haven't looked at the ia64 randomization, but I'd
> not be surprised if it was different

VMA stack entropy was in fs/binfmt_elf.c and rather hard coded.

> 
> 
>>>> Part of the bulk stems from the fact that I didn't do randomization
>>>> based on range, but based on bits of entropy.  
>>> I don't understand why you want to do that. It will make code a lot more
>>> complex, and at the same time it limits you to powers-of-two in
>>> practice.
>>>
>> In practice if you can assume an attacker can reasonably break 17 bits
>> of entropy, then you can assume that he can possibly (but unlikely)
>> double his attack efficiency and break 18 bits.  You would want to step
>> it up to 20 bits or so to get a few steps beyond "unlikely" into "we are
>> pretty confident this is impossible."
> 
> I think you totally missed the point. *I DON'T CARE ABOUT "BITS OF
> ENTROPY" IN THE CODE*. The code cares about how much it is in actual
> bytes. Sure when talking about it in documents or analysis it may make
> sense to do the bits math. BUT NOT IN THE CODE.

I was only addressing the "it limits you to powers-of-two" part, not
code complexity.  The point was that strictly speaking it's not that
great to be able to do it more fine-grained.  This doesn't mean people
wouldn't want to (hey I may want my stack and mmap() to move around by a
gig on i386, it'll barely work and X will break half the time, but WHY
would I want to?).

> 
> That was my point, and all there was to it. You add complexity and
> limitations TO THE CODE for no good reason at all.
> 

I'll address those in the next pass.  It will involve a little integer
multiplication/division to provide proper sub-page alignment for the
stack; VMA alignment can use PAGE_ALIGN().

> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIMwPws1xW0HCTEFAQK5aQ//W9m6h2DbSXP0yrNRKGgv7SCzZDbacsds
eXubeG8l1OAnMmsDaAYgnX5g/aAb0md7xNi39CT5x4dgQiM+dyCX7TYIG/TaaN5+
lLLKt/xQZm73hUxk7s4pKiBN7OY8n5YwaEiP5JpfZZi/27KxV0DR8s1VDsRj8xGz
3uuEF6hsZXZZKIuG46pG6nwHphJNQkCZp6G8tZdQWC+LuclulB50PNxNMzUxe31S
13M7q81icGcbHnOvUvA7EHexa1Ru22VCl8NjTwogTwP/eIVcN/acE17EO/m/xfIz
g9JXCgeF+soIk3SQTydR70CZwGENxs/mrYTXksWMDRsGmOK2qg5pSo7sr4V98g5P
jF6x/044JAKWB/fmlEr5QxFCGFHuPSDSqeZHPiRWQnbn8nH2VB9aSRGK/mpx+rpJ
/xIZrJLndFc06CdLe71inrjlBIhAQ58XuSd5pGGmLiKmwXiOGCDaWS5Qb0YChV2i
hujNZ4AhuuPT9TiMhi842NR3Dd8NTy/mY1JlqUtao8ofnhQqf6GndDuwTrIn3TOL
lm6X7EBuVbhXggsnjnQiaK10k90qU5Pgy9eqJYL8vybbuLu5uOwlxsuBM4ceIUya
oyVxOYnySND2FpxhH55IfAnxTC2I1avd+V4vvuIc3hJEWUbugf6iUzX72/0rYo88
HL5S4HK8UbQ=
=zZEn
-----END PGP SIGNATURE-----
