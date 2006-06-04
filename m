Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750722AbWFDQUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWFDQUf (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFDQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:20:35 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:58537 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750722AbWFDQUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:20:34 -0400
Message-ID: <44830703.3000905@comcast.net>
Date: Sun, 04 Jun 2006 12:14:59 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Per-architecture randomization
References: <44825E42.5090902@comcast.net> <1149411968.3109.79.camel@laptopd505.fenrus.org>
In-Reply-To: <1149411968.3109.79.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Sun, 2006-06-04 at 00:14 -0400, John Richard Moser wrote:
>> Pavel Machek recommended per-architecture randomization defaults when I
>> poked a (very hackish) patch up here.  As follow-up, I have taken out
>> the command line parameter code and used the infrastructure I wrote to
>> implement per-architecture randomization settings.
>>
>> Three #defines are needed per architecture, preferably in
>> include/asm-ARCH/processor.h or equivalent.  These defines are as follows:
>>
>>  STACK_ALIGN -- Alignment of the stack, typically 16 (bytes).
>>     If not defined, stack randomization is carried out to page
>>     granularity
>>  ARCH_RANDOM_STACK_BITS -- Bits of entropy to apply to the stack.
>>     If not defined, stack randomization is disabled by defining this
>>     as 0.
>>  ARCH_RANDOM_MMAP_BITS -- Bits of entropy to apply to the mmap() base.
>>     If not defined, mmap() randomization is disabled by defining this
>>     as 0.
> 
> 
> eh....
> 
> I think you missed a few things..
> like
> 1) This is per architecture already for the most part!
>    arch_align_stack() is obvious per architecture already

Yes you write a new one for each individual architecture, to tweak a few
variables in it.  Not that having the same function with the same blob
of code with 1 or 2 numbers in it changed matters, since only 1 is
generated to code...

>    the mmap randomisation also happens in arch/<foo>/mm
>    and this is per arch by definition as well

Yeah, same thing,
> 2) you missed that the mmap randomization is *ON TOP OF*
>    the stack randomization. So while you say "1Mb" in your
>    doc in practice it is 8Mb

This is fuzzy.  mmap() randomization is only 1MiB in most cases.  It's
only 9MiB if you don't already need the stack address to perform an attack.

The classical ret2libc attack requires a stack frame to carry out.  Your
two choices for this are injecting the stack frame into the heap (which
is fixed position on Linux), or injecting it into the stack.  You may
not always have a way to get it into a known position on the heap, so
cracking the stack may be the only choice.

Once your problem involves figuring out where the stack is, then the
added complexity of figuring out the location of mmap() is only 1MiB.  I
would dare say the stack's per-page alignment is all that counts*, and
this gives 2048 states; the mmap() randomization gives 256 states
itself, totaling 524,288 states to crack.  If mmap() was by its own
8MiB, this would be 2048 states for mmap() per stack state, giving
4,194,304 states total.

*If you can load 1 page of attack data, you can probably get it down to
2048, assuming a system() stack frame is less than 16 bytes.  Note that
we can discard the Return Pointer and SFP from the stack frames; they
can be filled with garbage.  We may be able to discard the local
variables as well, since whatever data is there is overwritten anyway.
This leaves us aligning the "passed arguments" part to 16 byte
boundaries.  This leaves 8 bytes "/bin/sh" and 4 bytes pointer to where
we hope it lands, 12 bytes.  Pad with 4 more bytes and set SFP to the
bottom of where you think it'll land, and (if you guessed VMA alignment
correct) any sub-page randomization value leads to a successful attack.

Of course without PIE, you can in theory return to an address where
there's a 'call system' in the main executable and if stack pointer is
pointed in the right direction, it'll complete the call.  This of course
assumes that the code is 'get_system_from_got; call system;' and not
'get_system_from_got; build_stack_frame; call system;'.  If I remember
right, actually calling a function from PIC involves jumping into the
PLT at the proper offset into a strip of code that does the actual call,
rather than retrieving an address out of the GOT based on an offset.
That should make this attack feasible.

At any rate, with the PIE attack you still have to crack the stack
before you can go anywhere.  mmap() randomization is 1MiB, stack
randomization is 8MiB, both have to be cracked along the way.

If you load your stack frame into the heap and try to use RETP to hit
the function directly, you're going to need to break the stack; as you
said, this is 11.17 bits of randomization anyway (2304 possible positions).

If you load your stack frame into the heap and use the main executable
attack, you have a known RETP and SFP value to use and randomization is
pointless.

> 
> Also your patch is still full of XXX's and "other noise"... 

Yeah, that's why I did [RFC] instead of [PATCH] this time.  I jumped the
gun last time.

My patch is also full of infrastructure like "hey if we have entropy >
what we think is sane cut it off."  We don't need that for per-arch
randomization because we can assume the #define is sane, it's coming
from the kernel devs.  We need it for i.e. SELinux policy or command
line or /proc, but none of that is in this patch.

> Also you probably should explain what the advantage is over the existing
> per architecture approach. Just stating "it's per architecture" (as you
> suggest) doesn't cut it since it is per architecture already for the
> most part.

1.  I can get away with exactly 1 mmap() randomization function, instead
of 1 function per architecture.
  - Less code to maintain
  - The entropy levels are #defined per arch instead of hard-coded into
    functions (more readable in the future)
2.  I can get away with exactly 1 arch_align_stack() function, instead
of 1 per architecture.
  - Less code to maintain
  - STACK_ALIGN can be used to figure out sub-page alignment per
    architecture (more readable in the future)
3.  Entropy levels are rather easy to adjust and tweak per-architecture
    or per-compile or per-execve().  This just leaves adding code to do
    it, i.e. SELinux hooks.

> 
> If all you want to do is turn 
> -       if (current->flags & PF_RANDOMIZE)
> -               random_variable = get_random_int() % (8*1024*1024);
> 
> that 8 into a per architecture thing.. then your patch is awefully big
> and complex to just achieve that.

Yes, you're right.  I will work on making it smaller, it's around 300
lines of code from around 10-15 lines of code.

Part of the bulk stems from the fact that I didn't do randomization
based on range, but based on bits of entropy.  I became more comfortable
with looking at entropy based on entropy instead of period*entropy
mostly from reading through the PaX documents**.  It doesn't really
matter, the code will be a lot less complex if I write it per range; we
can always put /*28 bits of entropy on x86-64*/ in processor.h or whatnot.

**But notice the difference between 8MiB and 9MiB randomization is 0.17
bits of entropy; and the difference between 16MiB and 17MiB of entropy
is 0.09 bits.  The amount of added time between (entropy1) and
(entropy2) is 2^(entropy2 - entropy1) times the time it takes to break
(entropy1), with entropies in bits.  Raw ranges quickly become mostly
meaningless, except for use as big numbers to impress people who don't
really understand what they're dealing with.

Also like I said, a lot of my calculations are somewhat ugly.  I define
4 variables named to show what I'm calculating and then calculate them
together to get what I'm after; the kernel isn't elementary mathematics
in C, it doesn't need to lead the reader through steps.

I'll work on it a bit.  May post a new one today or tomorrow.

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
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

iQIVAwUBRIMHAQs1xW0HCTEFAQIBaA//WUjVz2WogaBrn0FNxDOyh59r/Bqp12E9
hqXIbnYwK4ZFWWI15Q2nFwKug9OzWrYDhPWRSa9j/mxuU9Qnfebxna3zNN43l+2F
f+VTPG6kMU9AzcMB7+LLGGMCJMk6djoJQUHH9zIK/zUdKz8xXW+tUBtsc0XYfYgq
iQ3+nBOpllxU0ORL8FMVjE1QooMTNSJKbd7u0QVms21aR7T0heNuKYGEC3AvpFv1
NAESyoaOBtEAj/q+xOSn4McMsiiKlKTQn0fQ6SeDnL0+TgJ4ACHKBsVpZeU3ic+T
HAwMEjpfgI6I8QuS+9diSiccJQWuiC4V8JzV1EgAMu1j3F4O6Sf8VhlOuFzdgQaj
1Ypq9HBWfDERPf3wrb/S7tnR6oDqDY3N8upH5kfYDt2veDADYtXw2MFaCkwVo2eD
Yx21MXlKm/+z3ddmMu9yRArxS4XSlwEelxUrx5HXwcMypImg46lTiiZ0QOCPMHzd
JmFPa0QhsSLtHGvpJHuU92FO4Y0rSMy6qHAv9flWuyOsnqMo9rWSSrjg90mZa5Ka
BYOzvfz3EZXElx/Esu1zz9+vH0mMkOESDG6O075pMzYbc0qh/KIFCSzFWlbjJdYj
S3K2c654GP2A94ibNamjS3FVRUZkwyGP65SHq2vTS9SuMztFwyRA29qQwEiV4Rwn
1OiSkiEw/d4=
=9myZ
-----END PGP SIGNATURE-----
