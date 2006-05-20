Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWETRS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWETRS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 13:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWETRS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 13:18:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:31623 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751434AbWETRS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 13:18:27 -0400
Message-ID: <446F4E47.6000304@comcast.net>
Date: Sat, 20 May 2006 13:13:43 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net>
In-Reply-To: <446E6A3B.8060100@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



John Richard Moser wrote:
[...]

I've got a new working version over here, it's currently building over
on my laptop for test.  It looks a lot cleaner now, still a little messy
in some places for my tastes... a few functions I declare 2-5 more
variables in!

I also haven't fixed the arch_align_stack() in
arch/um/kernel/process_kern.c to match... and I'm getting tired of
maintaining 3 copies of what started as the same exact code and is
currently STILL the same exact code, just 15 times bigger!  Does anyone
have a good place to stick arch_align_stack()?  It can stay wrapped in
#ifndef like in arch/um/kernel/process_kern.c, because this method
should work for all architectures that don't '#define
arch_align_stack(x) (x)'.

>  - stack_random_bits is used to calculate how to shift the stack around.
>  If it's >8, then stack_random_bits - 8 is used to shift the page
> alignment of the stack.  if it's >0, then its value (or 8 if it's >8) is
> used to calculate the interval on which to align the randomly-placed
> stack pointer within the first page.  If it's 0, no randomization happens.
> 

At this point, it actually calculates how many bits go into sub-page
randomization with long_log2(PAGE_SIZE / 16) instead of just assuming 8.

[...]

> 
> 
> There's a few other things I want to get done, but I'll worry about
> those later.  They are:
> 
>  - Take care of the FIXME in that __init code in fs/exec.c to use
> architecture-specific #defines for the maximum values of these
> parameters, probably in asm-* somewhere.

Fixed.  We no longer care.  In arch/i386/mm/mmap.c; fs/binfmt_elf.c;
arch/i386/kernel/process.c; and arch/x86-64/kernel/process.c, we
calculate the maximum amount of entropy based on how many bits can be
done in (TASK_SIZE / 6).  This as an intended side effect also means
that IA-32 emulation on x86-64 results in proper reduction of entropy
(down to 256MiB ranges for stack and mmap())

>  - Add /proc controls to tweak system-wide randomization on new processes.

Arjan van de Ven raised a good point:

"(if we would put a knob on everything that is a value in the kernel
we'd have five gazilion knobs)"

We don't need /proc control for this; SELinux control should be enough.
 The kernel command line parameter could be removed as soon as SELinux
policy could adjust these settings; the default values when no
parameters are given are the settings the kernel uses now.

>  - Add LSM/SELinux hooks to let policy tweak randomization per-binary,
> so high-order randomization can be used except for with i.e. Oracle
> (which tries to mmap() 2GiB in at once and can thus die from VMA
> fragmentation).

Don't have these yet; although I put a couple /*XXX: */ comments in
where I feel these should go.

>  - Figure out exactly what affects what architecture, and which
> architectures react differently in terms of randomization; correct the
> calculations in these cases, i.e. if the stack can't be randomized
> within the page, stack_random_bits should apply to page randomization.
>  - Try getting randomization working in other architectures where it's
> not right now.  I don't see anything obvious to me that shows i.e. Sparc
> having randomization.. but I'm not much of a kernel hacker....


Really, really would be nice.... a little help here?  :)

>  - Get somebody to get some sort of heap randomization in here, and do
> the same deal.  Doesn't Fedora do heap randomization?

Anyone have an answer for this one?  I can't get Fedora Core 5 working
in Qemu (install DVD hangs as soon as it sees the hard drive) and I
can't find an FC5 LiveCD...

[...]

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

iQIVAwUBRG9ORQs1xW0HCTEFAQIvlA/+P8bLXdW2yqYewVgDJzYjsSsy/c0Fgzy+
2SY5sJjMMbS08+gfSqSbIRtAZf2N7iJLOxWP1JpwWoZxVj+QMSDWEEmt4552/bi1
00yMwQ6aFmF3nkCXwpj2mLiR8P8KFQJp4U0LPaOOlEt8/6OJgC+wbR2B0nm4rxFg
RRgaNeeenB95smfis54cu64EFyTwxlsNdW7H47Zgu7SBnNsmSAf2iZ3b5Gf4zTaA
PhH8syEMxH2SGwwkEumylDdmIUBw/5yzSIwmevp7wrG8SNHuaCE9LI1lR6bSubNu
84Wmiq4hv+kIYdm+9hdnOcC/27THKHCFq9JawMDnvcZMYQmvJDMiO++aHfRufhl7
wm0bAMfgObDVy+WJOyCfryGxb6DZv9xvktXfTj7xEtsRm8DWbGdbiivoOm6Kk7tc
PuEJJqOy2gHGPfM18RVYAfdspkYcc55VAJhwIMEux+ATLOf4Y30kaWi3VLP8pXLo
6m0pJFeaLKS+fAwXnc3PYWbzpCmrZAr8ZFamhfLlEnA/8i8siNQCw98WhEXIxUkI
wtUFnHFPhtC2QkDn/fNnbYpSMR+SQOOOBK7+u8U2WrCZEuaFif1Pq7XULGWSfHPq
RW3s/jzEjLc+ngvGEqrADIglde/ced4CrEhRHH4RQQrjn5DhseXh8euQ+3qG69wU
EQU3Fw0XQ/Y=
=yYp4
-----END PGP SIGNATURE-----
