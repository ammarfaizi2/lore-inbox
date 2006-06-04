Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750951AbWFDSlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWFDSlE (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 14:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWFDSlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 14:41:04 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:20097 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1750951AbWFDSlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 14:41:01 -0400
Message-ID: <448327ED.1040105@comcast.net>
Date: Sun, 04 Jun 2006 14:35:25 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Per-architecture randomization
References: <44825E42.5090902@comcast.net>	 <1149411968.3109.79.camel@laptopd505.fenrus.org>	 <44830703.3000905@comcast.net> <1149441301.3109.120.camel@laptopd505.fenrus.org>
In-Reply-To: <1149441301.3109.120.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Sun, 2006-06-04 at 12:14 -0400, John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>>
>> Arjan van de Ven wrote:
>>> On Sun, 2006-06-04 at 00:14 -0400, John Richard Moser wrote:
>>>> Pavel Machek recommended per-architecture randomization defaults when I
>>>> poked a (very hackish) patch up here.  As follow-up, I have taken out
>>>> the command line parameter code and used the infrastructure I wrote to
>>>> implement per-architecture randomization settings.
>>>>
>>>> Three #defines are needed per architecture, preferably in
>>>> include/asm-ARCH/processor.h or equivalent.  These defines are as follows:
>>>>
>>>>  STACK_ALIGN -- Alignment of the stack, typically 16 (bytes).
>>>>     If not defined, stack randomization is carried out to page
>>>>     granularity
>>>>  ARCH_RANDOM_STACK_BITS -- Bits of entropy to apply to the stack.
>>>>     If not defined, stack randomization is disabled by defining this
>>>>     as 0.
>>>>  ARCH_RANDOM_MMAP_BITS -- Bits of entropy to apply to the mmap() base.
>>>>     If not defined, mmap() randomization is disabled by defining this
>>>>     as 0.
>>>
>>> eh....
>>>
>>> I think you missed a few things..
>>> like
>>> 1) This is per architecture already for the most part!
>>>    arch_align_stack() is obvious per architecture already
>> Yes you write a new one for each individual architecture, to tweak a few
>> variables in it.  Not that having the same function with the same blob
>> of code with 1 or 2 numbers in it changed matters, since only 1 is
>> generated to code...
> 
> well stack alignment IS a per architecture property, and on some
> architectures it'll be more complex than a single one-liner (think about
> a 32 bit userspace needing different alignment than 64 bit as a simple
> example of this).

I did this already in the patch I sent with bits of entropy.  It's also
done with TASK_SIZE.  The alignment uses STACK_ALIGN and does the
calculations on the fly in the code.

Stack and mmap() VMA alignment is based on PAGE_SIZE.

> 
> It's a 2 or 3 line function for the simple cases like x86 so... why
> bother making it really complex.
> 

Yeah, my mmap() base randomization calculation now is 5 lines (not
including variable declarations, comments, or return), mmap_base() from
arch/i386/mm/mmap.c is 5 lines (not including etc etc),
arch_align_stack() is 5 lines (not including etc etc).

I guess slowing down process start-up by a few tens of nanoseconds is a
bit complex though.
> 
>>> Also you probably should explain what the advantage is over the existing
>>> per architecture approach. Just stating "it's per architecture" (as you
>>> suggest) doesn't cut it since it is per architecture already for the
>>> most part.
>> 1.  I can get away with exactly 1 mmap() randomization function, instead
>> of 1 function per architecture.
> 
> which needs to be there for other reasons anyway; VA space layout is a
> per architecture thing no matter what (just look at ia64 or ppc on how
> complex things can get), randomization within each region is, as a
> result of that, also a per architecture thing; with different rules for
> different part of the VA space sometimes (ia64/ppc64) or on the type of
> userspace that happens to be running (on all architectures that also
> have a compat arch)

I handled the different types of userspace already.  The solution is the
same solution x86-64 uses for TASK_SIZE.

Explain "randomization within each region."  I thought mmap()
randomization just shifted the mmap() base around at process start?

> 
>>   - Less code to maintain
> 
> we're talking less than a handful lines of code again, most of which is
> NOT shareable.
> 

The relevant parts are sharable.  I just moved this stuff out into
fs/exec.c:

/* Produce a random shift for mmap() base
 * The output of this function should always be page aligned*/
unsigned long mmap_base_random_factor() {
        unsigned long random_factor = 0;
        unsigned long random_bits = ARCH_RANDOM_MMAP_BITS;

        /*XXX:  Place a hook here to adjust mmap() randomization;
         * this hook will change the value of random_bits */

        if (random_bits > MAX_RANDOM_MMAP_BITS)
                random_bits = MAX_RANDOM_MMAP_BITS;

        /* randomize in range 2^random_bits * PAGE_SIZE */
        if (current->flags & PF_RANDOMIZE)
                random_factor = get_random_int() % (1 << random_bits);
        random_factor *= PAGE_SIZE;

        return PAGE_ALIGN(random_factor);
}

I'm pretty sure that last PAGE_ALIGN() is unnecessary.  The guts between
variable declaration and return are 5 lines of code.  Also, the
MAX_RANDOM_MMAP_BITS checks here can probably be removed until someone
decides to implement some sort of tunable, such as a LSM hook.  Even
then we should probably let the tunable do that check... well, that's a
design decision that could go either way.

Here's from arch/i386/mm/mmap.c:

static inline unsigned long mmap_base(struct mm_struct *mm)
{
        unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
        unsigned long random_factor = 0;

        random_factor = mmap_base_random_factor();

        if (gap < MIN_GAP)
                gap = MIN_GAP;
        else if (gap > MAX_GAP)
                gap = MAX_GAP;

        return PAGE_ALIGN(TASK_SIZE - gap - random_factor);
}

And from arch/x86_64/mm/mmap.c:

void arch_pick_mmap_layout(struct mm_struct *mm)
{
#ifdef CONFIG_IA32_EMULATION
        if (current_thread_info()->flags & _TIF_IA32)
                return ia32_pick_mmap_layout(mm);
#endif

        mm->mmap_base = TASK_UNMAPPED_BASE;

        if (current->flags & PF_RANDOMIZE) {
                unsigned long random_factor = 0;
                /* Add our randomness. */
                random_factor = mmap_base_random_factor();
                mm->mmap_base += random_factor;
        }
        mm->get_unmapped_area = arch_get_unmapped_area;
        mm->unmap_area = arch_unmap_area;
}

and from include/asm-x86_64/processor.h:

/*Random bits of stack and mmap() in IA-32*/
#define IA32_ARCH_RANDOM_STACK_BITS     19
#define IA32_ARCH_RANDOM_MMAP_BITS      8

/* Random bits of stack and mmap() in 64-bit mode.
 * 28 bits is 40 bits of VMA, which is 1TiB, roughly 1/128
 * of the address space. */
#define ARCH_RANDOM_STACK_BITS64        28
#define ARCH_RANDOM_MMAP_BITS64         28

/*Random bits of stack and mmap()*/
#define ARCH_RANDOM_STACK_BITS  (test_thread_flag(TIF_IA32) ? \
	IA32_ARCH_RANDOM_STACK_BITS : ARCH_RANDOM_STACK_BITS64)
#define ARCH_RANDOM_MMAP_BITS   (test_thread_flag(TIF_IA32) ? \
	IA32_ARCH_RANDOM_MMAP_BITS : ARCH_RANDOM_MMAP_BITS64)

Yes, this is the same solution as with TASK_SIZE (which is about 3 lines
above this...)

>>   - The entropy levels are #defined per arch instead of hard-coded into
>>     functions (more readable in the future)
> 
> that's a separate thing; if you want to use a define rather than an open
> coded value, fair enough, but make that a separate patch really;
> especially since that is basically a "one line to a header + one line
> code delta" which is then trivial to review for identity.
> 

Easy enough to do for mmap(); for the stack there's ... complexity.

>> 2.  I can get away with exactly 1 arch_align_stack() function, instead
>> of 1 per architecture.
> 
> I don't think that that is fundamentally possible, see above.

Did it already, for any STACK_ALIGN, any PAGE_SIZE, any level of
entropy, and for stacks that grow up and down.  The only situations that
I haven't handled are stacks that grow up and down at the same time, and
stacks that teleport data to other dimensional planes.

> 
>> 3.  Entropy levels are rather easy to adjust and tweak per-architecture
>>     or per-compile or per-execve().
> 
> this I don't get; you change a per arch thing to.. a per arch thing.
> 

I'm thinking ahead to the possibility of tweaking entropy via SELinux
policy.  Some of us out here would rather apply MASSIVE_LEVEL_OF_ENTROPY
to Gaim and Firefox and Apache and
TINY_ENTROPY_LEVEL_THAT_WONT_BREAK_ORACLE to Oracle.

The level of stack entropy was definitely not per-architecture; the
level of mmap()... well, you had code for it in 3 places (i386, x86_64,
x86_64 IA-32 emul) that I found.

> 
>> Part of the bulk stems from the fact that I didn't do randomization
>> based on range, but based on bits of entropy.  
> 
> I don't understand why you want to do that. It will make code a lot more
> complex, and at the same time it limits you to powers-of-two in
> practice.
> 

In practice if you can assume an attacker can reasonably break 17 bits
of entropy, then you can assume that he can possibly (but unlikely)
double his attack efficiency and break 18 bits.  You would want to step
it up to 20 bits or so to get a few steps beyond "unlikely" into "we are
pretty confident this is impossible."

A fraction of a bit helps as much as a fraction of a slice of bread
helps complete a sandwich.

That being said, let me shrink this code down a bit first and then I'll
worry about switching to ranges.  In any case it's not really any more
restrictive than what the kernel currently has-- everything is aligned
to powers-of-two already AND HARD CODED.

>> I became more comfortable
>> with looking at entropy based on entropy instead of period*entropy
>> mostly from reading through the PaX documents**.  
> 
> Using bits-of-entropy in documentation is fine, you can do fractions
> there as well for example. No objection from me on that, but it
> shouldn't have to complicate or limit the code. For code, "range" is a
> native principle much more than "bits of". 

Right now I'm not so sure how to deal with less-than-a-page stack
randomization ranges ;)  (Handling all possible situations)

Sure VMA is easy to randomize over range and PAGE_ALIGN; but what the
hell do I do about sub-page randomization if PAGE_SIZE > RANDOM_RANGE >
0?  Complain that someone broke me?

My current thinking on this follows two schools of thought:

 1.  Something is obviously broken.  Ignore it and don't randomize.

 2.  Randomize to RANDOM_RANGE, divide by STACK_ALIGN, multiply by
     STACK_ALIGN.  With integers this will align the result to
     STACK_ALIGN.

> 
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

iQIVAwUBRIMn6gs1xW0HCTEFAQK1+g//S87sCgbqxSdXD/HL2FCiLIDMIH708efb
y0xz0DKxnvuWhi5VlnJVcxDwSe+7lhVXp7khE9tRLGq46tQ2sHh+p8ZmwxhfdmQd
Bj7NQbk6zU+LXF1R7CqfI0N/FwS5R4te5KnZDe6oZbgvww/vL6bgj7oej+kYQXp1
fdQ4LEhMnqX4fD7C1XNw3cBm6cGtp2TugsiAvJl/yamllRNnJKuMS3Ut1ffA3Cqq
r7SfXmgGKaPIYKbk31b1KgC7kPWomP5D0K6mJPDth005TXiC4MbRGldTCCu6SQ6P
wATDlAPxl1XHxZ+vBqaRTm4bOrKi9zeSlKPnfe/ik/VvBVFiDfHaDJjJZURYvyE5
7/XAZqHoxcXly1wcqee17EXwcx8AnQTEr+wBCORF1cRnOIDsulT4bcBxYtD745z7
DtjCiZhNqCniHBUjUSijmiAHhp4aDyf3pzrmSZOPcTdSrknoFP3TXWksDXyA+qHr
S1Gl+OdbMcbrQv1o6bsi9LXXHLhoFgbfgaJKRutxGUV6V9nu3Iu/tzvVzAEqi1pv
phAD/Av1oqKB4AQ5aMFXdCzXQ309JGd3OgM7UxPabWJ0iVgn0i11PaZKY43ekTi6
faXQCPhTwD0CA72AcT7WkN4h1i5qbmEbLb0mjYFc0JliZkr4ogubeTaxggiifSwo
TO1w5wlWyGk=
=tezi
-----END PGP SIGNATURE-----
