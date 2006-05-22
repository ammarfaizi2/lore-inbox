Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWEVCvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWEVCvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 22:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWEVCvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 22:51:19 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:64219 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964989AbWEVCvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 22:51:18 -0400
Message-ID: <44712605.4000001@comcast.net>
Date: Sun, 21 May 2006 22:46:29 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz>
In-Reply-To: <20060522010606.GC25434@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Pavel Machek wrote:
> On So 20-05-06 11:23:47, John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>>
>> Arjan van de Ven wrote:
>>> On Fri, 2006-05-19 at 21:00 -0400, John Richard Moser wrote:
>>>> Any comments on this one?
>>>>
>>>> I'm trying to control the stack and heap randomization via command-line
>>>> parameters. 
>>> why? this doesn't really sound like something that needs to be tunable
>>> to that extend; either it's on or it's off (which is tunable already),
>>> the exact amount should just be the right value. While I often disagree
>>> with the gnome desktop guys, they have some point when they say that
>>> if you can get it right you shouldn't provide a knob.
>> This is a "One Size Fits All" argument.
>>
>> Oracle breaks with 256M stack/mmap() randomization, so does Linus' mail
>> client.  That's why we have 8M stack and 1M mmap().
>>
>> On the other hand, some things[1][2][3] may give us the undesirable
>> situation where-- even on an x86-64 with real NX-bit love-- there's an
>> executable stack.  The stack randomization in this case can likely be
>> weakened by, say, 8 bits by padding your shellcode with 1-byte NOPs
>> (there's a zillion of these, like inc %eax) up to 4096 bytes.  This
>> leaves 1 success case for every 2047 fail cases.
> 
> Maybe we can add more bits of randomness when there's enough address
> space -- like in x86-64 case?
> 								Pavel

Yes but how many?  I set the max in my working copy (by the way, I
patched it into Ubuntu Dapper kernel, built, tested, it works) at 1/12
of TASK_SIZE; on x86-64, that's 128TiB / 12 -> 10.667TiB -> long_log2()
- -> 43 bits -> 8TiB of VMA, which becomes 31 bits mmap() and 39 bits stack.

That's feasible, it's nice, it's fregging huge.  Can we justify it?  ...
well we can't justify NOT doing it without the ad hominem "We Don't Need
That Because It's Not Necessary", but that's not the hard part around here.

I say that's the max, and let the kernel devs figure out where they
think it "should" be and the sysadmin define where he thinks it "needs
to" be, with policy.  For now I can toy with the hooks with the command
line-- I originally wanted that and /proc, but discarded that when Arjan
started talking about too many knobs.

For now I'm not going to simply roll out an
infrastructure-and-SELinux-hooks patch; one step at a time, plus I don't
know HTF to add an SELinux hook and policy control for it.  Maybe if I
can get a cleaned-up patch into -mm someone will pick it up and write an
SELinux hook for it.


On a side note, paxtest says FC5 has 19 bits of stack randomization
(Mainline does too-- 8MiB), and it can't seem to decide if it's 8 or 12
bits of mmap() (mainline has 8, paxtest detects 9 or 10....).  I was
sure they had more...

What they DO have that I'm waiting to see in mainline is a random heap
base.  'cat /proc/self/maps' changes things around for everything but
/bin/cat, that is nice.  This appears to shift around in 16MiB... (12 bits!)

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

iQIVAwUBRHEmBAs1xW0HCTEFAQLJaQ/7B8iKaI4PXp/cl/9jS2ssCkw8UdZdN0kF
xxTbLbKvBJwqeo64G0+3j6ZacRLgzRLaGGum5tLyaBWE02fAvNVGH/naAHbfY7Ks
yDPA8bgazlHKym5x/yNPZog2f5tOP0e3Hf3XLQx1yLqLR6Qjs8lLN8APVZVzq+pG
z3FFvdHlm9HLyM2qDw1nm+DtSPkTOU6ddbyYuWcYW1RUI02JlTf3uNeS00dHekK7
vGMBwVinbKOViCWFhGNACxB+sYShQ5L+m9vdb4lWht1npljcFKCIHarEcQZ1yIEp
RyvB5hMjF6YGBoyUgyTklw+FFtrY3xFdB1yt1e+oKABo1vJK+wmO7xujVa0VX4eP
ZW33OE0zo+NnTCXCIt8s7w9S8E2P6Vnn+IEaqseRl+Crhi0AZ/b9OXHBysdO2Ax/
YzUN0VKnaiWBSX92OPIp8oaKdtpf9VKoW5FG9dIGMb79ruykTtGA3s1Py2xswslZ
2dr9yflS8X7Mckws6iD3Uyx6RSUatjCXUHF/NMr9bOMVE0r8jvP/A0K/2TloKcGa
c7gMBjAI30J++/suyjdpg5zLGQSA9yWG/xnobjGCLi7IYTTNxtu8HASRiXnQfYJy
sOZcFbhN/CNJpVTHwHRykvM14wd38bIOis/qSGIJFjhJe5lm3v+cSh9u66Ta9AK+
wuJoJqntf3w=
=0o7I
-----END PGP SIGNATURE-----
