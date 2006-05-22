Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWEVQgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWEVQgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWEVQgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:36:48 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:47866 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750978AbWEVQgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:36:48 -0400
Message-ID: <4471E77F.1010704@comcast.net>
Date: Mon, 22 May 2006 12:31:59 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz>
In-Reply-To: <20060522083352.GA11923@elf.ucw.cz>
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
>>>>> On Fri, 2006-05-19 at 21:00 -0400, John Richard Moser wrote:
>>>>>> Any comments on this one?
>>>>>>
>>>>>> I'm trying to control the stack and heap randomization via command-line
>>>>>> parameters. 
>>>>> why? this doesn't really sound like something that needs to be tunable
>>>>> to that extend; either it's on or it's off (which is tunable already),
>>>>> the exact amount should just be the right value. While I often disagree
>>>>> with the gnome desktop guys, they have some point when they say that
>>>>> if you can get it right you shouldn't provide a knob.
>>>> This is a "One Size Fits All" argument.
>>>>
>>>> Oracle breaks with 256M stack/mmap() randomization, so does Linus' mail
>>>> client.  That's why we have 8M stack and 1M mmap().
>>>>
>>>> On the other hand, some things[1][2][3] may give us the undesirable
>>>> situation where-- even on an x86-64 with real NX-bit love-- there's an
>>>> executable stack.  The stack randomization in this case can likely be
>>>> weakened by, say, 8 bits by padding your shellcode with 1-byte NOPs
>>>> (there's a zillion of these, like inc %eax) up to 4096 bytes.  This
>>>> leaves 1 success case for every 2047 fail cases.
>>> Maybe we can add more bits of randomness when there's enough address
>>> space -- like in x86-64 case?
>> Yes but how many?  I set the max in my working copy (by the way, I
>> patched it into Ubuntu Dapper kernel, built, tested, it works) at 1/12
>> of TASK_SIZE; on x86-64, that's 128TiB / 12 -> 10.667TiB -> long_log2()
>> - -> 43 bits -> 8TiB of VMA, which becomes 31 bits mmap() and 39 bits stack.
>>
>> That's feasible, it's nice, it's fregging huge.  Can we justify it?  ...
>> well we can't justify NOT doing it without the ad hominem "We Don't Need
>> That Because It's Not Necessary", but that's not the hard part around here.
> 
> Well, making it configurable and pushing hard decision to the user is
> not right approach, either. I believe we need different
> per-architecture defaults, not "make user configure it".

Yes, different per-architecture defaults is feasible with configuration
being possible.  I could replace 'int STACK_random_bits=19' with 'int
mmap_random_bits=ARCH_STACK_RANDOM_BITS_DEFAULT' and that would be
effective as long as the user doesn't touch it with command line or
SELinux or whatnot.

It is still possible that ARCH_STACK_RANDOM_BITS_DEFAULT breaks things.
 The current kernel default broke emacs at first I heard; I believe we
started with 64KiB of stack randomization and then upped it to 8MiB when
emacs was fixed.  In this case we have 3 options:

 - Disable PF_RANDOMIZE for the binary.  (Already doable)
 - Decrease randomization system-wide.  (My patch lets you do this)
 - Decrease randomization for the binary to a point where it works.
(Adding SELinux hooks and policy to my patch would allow this)

Obviously decreasing randomization system-wide has other implications:
your entire system is as weak as the weakest link, even if that weakest
link is a privilege-restricted non-networked text editor.  Another
consideration is that Oracle breaks with high-order entropy; but Apache
is quickly brute-forceable even with high-order entropy (216 seconds an
average according to a paper about brute forcing PaX ASLR on i386).  We
increase the risk here to fit the need there... not good.

Disabling randomization for the binary is much more fine-grained, but
opens up that binary for attacks.  Oracle breaks with high-order
entropy; we can disable randomization on Oracle and keep high-order
entropy, but now the database server is at risk.  This isn't the
greatest idea in the world either.

Decreasing randomization as per policy on specific binaries is a
security win.  Apache is much safer with high-entropy ASLR; Oracle
breaks from it but lives with low-entropy ASLR and that's better than
nothing; most of the rest of the system doesn't really care and some
benefits some doesn't.  The only problem is somebody has to configure
that, putting load on the administrator.

It appears to me that the best solution is per-policy, but we should
leave even that up to the user.  This means make a sane default-- one
that shouldn't break anything, but supplies some kind of benefit-- and
only stray from that at the user's request.  This is why I wrote a
command line patch and am interested in SELinux policy controls for
randomization entropy.

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

iQIVAwUBRHHnfgs1xW0HCTEFAQJ/Tw//fYWCveTJdDvtAce8/Yesa/thMLRmoDZ8
s2DBL66gNb+Aw35d9Fir9H/K2OzCZhDgAyJcQoMS2qckRyDTYDAX4ygBipQqeTng
SpoECxrPogGNqzZ/H55/8ngv1pGaiRS9Ui82xv2z5J2AGHt413jp50wskDbmiuC0
yrosPds8ULiyDXumouictYE4/EY3L77b9b45xNAY5m2nhnnzjv9Z96J4MZuLSUP1
8lKMgEx0AWLv2N7ZtAVVbq5KnariHS2NgN5Y2R+7fcobrN+WezoDQGoqerYY9Fq5
WO/R+C1+LBb43bHAIW3EvKz39rIaBnQZN53RQACzNVepfg6txfKDPEvUDIJvTGne
tjgmvPLq5L0NRqHVG1ZjI5wDmj4GvIrpTVoEjFlUT4pfJzreI3Ene8bWrK6zrnPa
AFcw4LMpB1+Biki5GD3rXg4MTPY2v8RpwqvR3Pg+F/m/DQmvIP4NAIp3kFQAJfXr
daCRdr0K/iB8ZJb8l2i5sVUqbV7FZOLSMn4+0vJOGbfkCRy3yMCnMF7KdTkHCBAf
y96z6G+4AWAdVrmmJwYEEJYGTt10TNbISkxk8l40H1V044oX2AtiifX3zTWVO0IE
xAIoxH8eyopVB8KJk2msjBqLvpcryNAVsGA/ZvcxosKwcljyoLKIG0FsLE++XbvX
Qzyw3S+i40k=
=lEaM
-----END PGP SIGNATURE-----
