Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWEVR7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWEVR7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWEVR7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:59:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:32446 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751102AbWEVR7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:59:12 -0400
Message-ID: <4471FAD0.9060403@comcast.net>
Date: Mon, 22 May 2006 13:54:24 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net> <20060522170036.GD1893@elf.ucw.cz>
In-Reply-To: <20060522170036.GD1893@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Pavel Machek wrote:
> Hi!
> 
>>>>>> On the other hand, some things[1][2][3] may give us the undesirable
>>>>>> situation where-- even on an x86-64 with real NX-bit love-- there's an
>>>>>> executable stack.  The stack randomization in this case can likely be
>>>>>> weakened by, say, 8 bits by padding your shellcode with 1-byte NOPs
>>>>>> (there's a zillion of these, like inc %eax) up to 4096 bytes.  This
>>>>>> leaves 1 success case for every 2047 fail cases.
>>>>> Maybe we can add more bits of randomness when there's enough address
>>>>> space -- like in x86-64 case?
>>>> Yes but how many?  I set the max in my working copy (by the way, I
>>>> patched it into Ubuntu Dapper kernel, built, tested, it works) at 1/12
>>>> of TASK_SIZE; on x86-64, that's 128TiB / 12 -> 10.667TiB -> long_log2()
>>>> - -> 43 bits -> 8TiB of VMA, which becomes 31 bits mmap() and 39 bits stack.
>>>>
>>>> That's feasible, it's nice, it's fregging huge.  Can we justify it?  ...
>>>> well we can't justify NOT doing it without the ad hominem "We Don't Need
>>>> That Because It's Not Necessary", but that's not the hard part around here.
>>> Well, making it configurable and pushing hard decision to the user is
>>> not right approach, either. I believe we need different
>>> per-architecture defaults, not "make user configure it".
>> Yes, different per-architecture defaults is feasible with configuration
>> being possible.  I could replace 'int STACK_random_bits=19' with 'int
>> mmap_random_bits=ARCH_STACK_RANDOM_BITS_DEFAULT' and that would be
>> effective as long as the user doesn't touch it with command line or
>> SELinux or whatnot.
>>
>> It is still possible that ARCH_STACK_RANDOM_BITS_DEFAULT breaks things.
>>  The current kernel default broke emacs at first I heard; I believe
>> we
> 
> Well, fix emacs then. We definitely do not want 10000 settable knobs
> that randomly break things. OTOH per-architecture different randomness
> seems like good idea. And if Oracle breaks, fix it.
> 

Fix this, fix that.  In due time perhaps.  I'm pretty sure Linus isn't
going to break anything, esp. since his mail client breaks too.

>>  - Disable PF_RANDOMIZE for the binary.  (Already doable)
>>  - Decrease randomization system-wide.  (My patch lets you do this)
>>  - Decrease randomization for the binary to a point where it works.
>> (Adding SELinux hooks and policy to my patch would allow this)
> 
> Which immediately makes your patch obsolete.

How so?  My patch (the current fourth-generation copy I have here)
supplies effective infrastructure that makes it easy to change
per-architecture randomization or adjust randomization as per policy.
Currently all you can do is flip off PT_GNU_STACK to kill randomization
entirely; or live with the kernel defaults.  I'm progressing towards the
third bullet point above.

> 
>> Disabling randomization for the binary is much more fine-grained, but
>> opens up that binary for attacks.  Oracle breaks with high-order
>> entropy; we can disable randomization on Oracle and keep high-order
>> entropy, but now the database server is at risk.  This isn't the
>> greatest idea in the world either.
> 
> So fix Oracle. No need to invent serious infrastructure because Oracle
> is broken.

Yeah we tried this one already.  Linus said no.  Arjan said no.  They're
not insane, even though the people running Oracle on anything less than
a 64-bit server are (3GiB TASK_SIZE for a database server juggling
multi-gigabyte databases?  No thank you).

> 
>> It appears to me that the best solution is per-policy, but we should
>> leave even that up to the user.  This means make a sane default--
>> one
> 
> No. Current situation is okay as is. It does not need to be
> configurable, and it should not be.
> 

My issue is I want *more* randomization.  Linus won't give me more,
because it breaks Oracle/Emacs/some mail client/etc.  Over here I'm
running Ubuntu Dapper i386 on my laptop out of the box with the kernel
patched with 24 bits stack and 16 bits mmap() randomization fine
(default is 19 and 8); but I'm not running any of the handful of apps
that break.

Why should it NOT be configurable anyway?  If you don't configure it,
then it behaves just like it would if it wasn't configurable at all.
This is called "having sane defaults."

There's different people with different wants and needs.  I'm sure if
you look hard enough you'll find a group of people who want 256M stack
and 256M mmap() randomization on i386 (hint:  Adamantix, Hardened
Gentoo, anyone who swears by grsecurity); equally, if you look you'll
find people who feel 8M stack and 1M mmap() is fine even on x86-64
(hint:  Linus, Arjan, Fedora/RedHat).

You'll also find those of us who don't particularly care about tangible
benefit, and will crank up the protection on mathematical figures
provided there are no detrimental effects.  This would be me; nobody
comes near my house at night, in my whole life nobody has ever tried to
jigger with my door, it'd be 'safe' to leave it unlocked at night but I
still lock it.  Why?  Because I get the reasonable guarantee that
someone isn't going to just walk into my house with the twist of a knob,
and the only cost is turning a little piece of metal 90 degrees twice a
day (with the proper lock it can even be pushing a button to lock, and
the door automatically unlocks when I turn the knob from the inside).
It's not 16 unevenly keyed deadbolts I lock and unlock every time I open
my door.

Still, there's some merit to the argument:

  Attacks using our technique need only guess the libc text segment
  offset, reducing the search space to an entirely practical 16 bits.
  While our specific attack uses only a single entry-point in libc, the
  exploit technique is also applicable to chained return-to-libc
  attacks.

  Our implementation shows that buffer overfl ow attacks (as used by,
  e.g., the Slammer worm [11]) are as effective on code randomized by
  PaX ASLR as on non-randomized code. Experimentally, our attack takes
  on the average 216 seconds to obtain a remote shell.

    -- http://www.stanford.edu/~blp/papers/asrandom.pdf

(Now you know where I keep quoting 216 seconds from)

The paper works on 16 bits of randomization-- 256M of mmap()
randomization that PaX applies.  At a glance, it doesn't seem to take
into account finding the stack frames injected into the stack or heap--
both of which PaX and FC5's Exec Shield randomize the base of, and of
which mainline Linux randomizes the stack base on.

I would say that possibly randomization can be decreased by 1 to 1.5
bits with the assumption that the injected stack frames are about a page
long-- realisticly however, we could probably align system() pages to 32
or 48 bytes, knocking off 6-7 bits.  We're almost back to page-aligned
stack here, so let's use that assumption.

Right now we have 8 bits mmap() (1M) and 19 bits stack (8M), which we
can reduce to 8 and 11, total 19 bits for an attacker.  Assuming the
above report gives an accurate view of brute forcing i.e. Apache, we
just increased the complexity by 3 orders of magnitude-- should average
1728 seconds, or about 29 minutes.  This is still my sysadmin's lunch
break and nobody else is going to notice we're under attack.

If we increase to 16 bits mmap() (256M) and 24 bits stack (256M), which
can reduce to 16 and 16, this totals 32 bits for an attacker.  Under the
same assumptions, this is 16 orders of magnitude bigger (2^16 == 65536),
216 * 2^16 == 14,155,776 seconds (164 days).  This is about a 5 month
vacation for my sysadmin.

Like I said before, though, massive randomization breaks Oracle at
least, possibly other things.  We can't just slap it across the board here.

Interestingly, if we get this to an executable stack and shellcode
inject, 19 bits becomes 11 bits and our attack is 5 orders of magnitude
easier -- 216 / 2^5 == 6.75 seconds.  With 24 bits we can make it 16
bits, so it's still 216 seconds.  (Do you feel like sub-page
randomization is just about useless yet?  Not quite, but almost?  It's
more effective on ret2libc chaining attacks..)

So our absolute worst case is 7 seconds and we can make it about 3 and a
half minutes on i386.  If we have an NX stack-- which by the way SELinux
CAN enforce now (breaks Metacity on Fedora Core 5, but everything else
works; the policy could be changed here until someone fixes
Metacity..)-- then we move our worst case from 29 minutes to 164 days.
If we do this, however, we break things; and we can't just slap this
into the kernel and say "DURR FIX UR SHIT!"

> Per-architecture ammount of randomness would be welcome, I
> believe. That will force Oracle to fix their code, but that's okay,
> and you can use disable PF_RANDOMIZE for Oracle in meantime.

No, this would leave Oracle shipping binaries with PF_RANDOMIZE
(PT_GNU_STACK still?) disabled.  Also if PF_RANDOMIZE is still connected
to PT_GNU_STACK, then this means that randomization is turned off BY
MAKING THE STACK EXECUTABLE.  You should notice the obvious problem
here.  You should also understand that as long as they can simply switch
randomization off, they're not going to fix it; and as long as it breaks
Oracle/Emacs/anything, Linus is not going to impose non-disablable,
non-adjustable randomization.

> 								Pavel

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

iQIVAwUBRHH6zgs1xW0HCTEFAQLPMg//WTW47tVb1Xk7aQQ5kF0CWO3MjU/kE5rw
4M7kHd2sb1qGDYUIWIx1jIUAb4ce8AYFqPYEtMpeiqFics0nwK30E/U4BKxwcmzl
+bd8bNhfWY4aTGM+L6dzlW2CmKGotNtLZb2iwbRhfNpEeFHJHGCiANd82SLFmJbY
zT15qm+14O4TR9E0LHEHHQYIu2wCksv5dEG49dtUJqdf2MP4Zy66ZmVShUZOCtrq
Fbl4cZYqJO0qAbZL8tz+3VWIvLqDNcuVXZY4gQK1UB4Fp/3gV32OSc/hYDt+LD5F
xDcllnHW65bu+EknPyOO8e6/dorELsvfhfTckj361k8Q3ZcEdB2+W/+Nob03VTCL
I20CEQu4bcl+B7KxP8Y7y54FzC04gZ3og7ce0l6l6H/V0kZfQ6KXb9zfL/P/hIOM
+eKN1QEMdQDP9IkkFhUhu5MmDJeCS9FyApW5cw+erZWC/gNAzjJNSaZp3V/C6U0J
oLUDfah81tOrnHXATVhHCy+V3b+hu7WZM+baWwslkUYoq6uUd7a6knJK6wMVQhnz
BszM4wbxVLlYpPf/8SuxFiUpOHqGfbMjCVYtUW3y8zZ60HGP0ehzbQMMHY4LVZqt
zN95n6DF4nYn0SqwkSvZEOgtTX60AOqTP9QKMbpVgKyoTAH3TOE7kAxWwLUzuDHT
Cz8gA3ga0S0=
=K1fe
-----END PGP SIGNATURE-----
