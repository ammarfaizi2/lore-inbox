Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWETP2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWETP2a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 11:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWETP2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 11:28:30 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:17037 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964864AbWETP2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 11:28:30 -0400
Message-ID: <446F3483.40208@comcast.net>
Date: Sat, 20 May 2006 11:23:47 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org>
In-Reply-To: <1148132838.3041.3.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Fri, 2006-05-19 at 21:00 -0400, John Richard Moser wrote:
>> Any comments on this one?
>>
>> I'm trying to control the stack and heap randomization via command-line
>> parameters. 
> 
> why? this doesn't really sound like something that needs to be tunable
> to that extend; either it's on or it's off (which is tunable already),
> the exact amount should just be the right value. While I often disagree
> with the gnome desktop guys, they have some point when they say that
> if you can get it right you shouldn't provide a knob.

This is a "One Size Fits All" argument.

Oracle breaks with 256M stack/mmap() randomization, so does Linus' mail
client.  That's why we have 8M stack and 1M mmap().

On the other hand, some things[1][2][3] may give us the undesirable
situation where-- even on an x86-64 with real NX-bit love-- there's an
executable stack.  The stack randomization in this case can likely be
weakened by, say, 8 bits by padding your shellcode with 1-byte NOPs
(there's a zillion of these, like inc %eax) up to 4096 bytes.  This
leaves 1 success case for every 2047 fail cases.

Picture (for example) a Gaim bug, assuming Gaim has this sort of stack
issue[1].  Let us also assume that an attacker has an efficient way to
locate random, valid MSNIM, AIM, YIM, and ICQ users who are on-line (not
unreasonable, esp. since you can search YIM).  Let us also assume that
Linux happens to be the major desktop platform, and thus this kind of
security is worth our time in the first place.

Let an attacker distribute a worm via sending instant messages that
trigger this bug, with an initial attack spread of 10,000; that is, the
initial attacker attacks 10,000 users.  Given 1 attack per second, an
iteration is 2 hours 46 minutes.  Approximately 5 should be infected.

These 5 should now each attack 10,000 other users.  This means most
likely 50,000 un-infected are attacked (assuming overlap is negligible),
likely penetration is now 200.

Third iteration, 200 * 10,000 == 2,000,000 attacks.  Likely success
would be 1,000.

Third iteration is 10,000,000 attacks and 5,000 newly infected.

Fourth iteration is 500,000,000 and 250,000.

Fifth iteration is 2,500,000,000 and 1,250,000.

At this point we are 13 hours 50 minutes in, with 1.25 million hosts
infected.  IDS/IPS vendors should be releasing signatures by now;
anti-virus vendors should have new signatures out already.  Most people
will not get them for a few days, maybe a week; random distribution of
Linux perhaps has clam with freshclam running daily, but it's not
auto-scanning.

Around this time, someone should also have figured out what the worm is
attacking.  A patch will be issued by the next iteration; it doesn't
exist yet because this is a zero-day attack, exactly what randomization
is made to stop.  The patch will take 1-2 more days (5-15 more
iterations just about) to be built, tested, and distributed across all
major distributions; no guarantees that anyone will install it at first.


If we assume stack randomization across 256MiB, that's 65536 places that
the attacker has to overcome.  The first iteration probably doesn't get
anywhere; the attacker will likely have to attack 65536 times (18h12m @
1/S) to start, and then each iteration is that many attacks with 1
infection per attacker.  The fifth iteration is 90 hours (3 days 18
hours) away, and on average 16 nodes should be infected by this time.

It takes roughly 76 days to reach where 1.25 million infections in
theory.  This is on order of 130 times longer.  This is nice, because it
gives end users and developers more time to react, figure out what's
going on, correct the flaws, write patches, build patches, test patches,
and apply patches.  MORE TIME.

If we have a 64-bit address space we could easily place this where it
takes billions of attacks (literally, randomize over a 16TiB area; VMA
is 256TiB and the kernel cuts it down to what 80TiB?) before one is
likely to actually infect something, around 136 years per iteration.  At
this point we have left the realm of "giving the user more time to
react" and reached a situation where we can say this SHOULD never
actually happen.  "Should" because once every 136.0993 years, when the
moon reflects off the ionosphere just right to create a twin-moons
illusion, the stars twinkle in the right way, and the wind is blowing in
just the right direction, one person in the world falls to a successful
attack.

The reason I wrote (and am still working on) this patch is because I
neither want nor need you to agree with me on how much is enough.  What
won't hurt me will help me; but it might break Joe Enterprise's Oracle
server, or Linus' mail client.  Still, Joe Enterprise by default will
get a set-up that's insufficient for my needs, but won't break his
enterprise-critical apps unless he specifically asks it to.

In the future the command line parameter can die, in favor of SELinux
policy hooks.  SELinux will eventually be integrated with even basic
desktop distributions; it's no big deal to have the default policy
specify stack_random_bits and mmap_random_bits, as long as that policy
gets loaded before init (i.e. patch init so it loads the policy
immediately and reloads self; or use an initrd that loads the policy and
replaces itself with init).  At that time this can all just become
infrastructure for those policy controls, because this stuff is policy
if anything.


[1] https://launchpad.net/distros/ubuntu/+source/gaim/+bug/34129 (2.0
and 1.5 both!)
[2] https://launchpad.net/distros/ubuntu/+source/firefox/+bug/34131
[3]
https://launchpad.net/distros/ubuntu/+source/mozilla-thunderbird/+bug/34132


> (if we would put a knob on everything that is a value in the kernel we'd
> have five gazilion knobs)
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

iQIVAwUBRG80gQs1xW0HCTEFAQJWBw//ZEKuhF/lKpKfZvwfwRTc7cQ48NspJnoC
xTIk9o0EVwXdqRBVSXlPU8Dwe+d4OdtwhYy3LxWasE/ZdTbJJC59TSjNWKrf0noM
c0J9e4CTFZXRVZyHBr9LJCZZgkZA03GVOvqU1hmo/YmNrrh5y4Txq3JrZEunpbOS
r3fBSdx/2ARCU/oEYkKx+D67Ilng2+OaYjdBj9HcCpX77eyYExsn5h+kD8S+C9xP
u1Yz+sAyTqJFEB/rmzsjA3pdltluEFB3BRrbHVeWkx7cV3TohFPWuaoCWfW3Yr0n
QzdRjxfmaarFPNV/gbV4WhDdNX57huD7ggf4v3sCPV1tLeNFhxrfrTwO2Vm/7kC0
xg6ves7+7DbqsZx3KLwFGHeGnvtVlXoFd4J0a9T2vN72FQm1O3zwEJxOfx14DBlo
KbXpA9oxEMPuedSMEd3i6WcH9onuiVCBz3RcwpUPt9gMppKZf9DQIErmrmz7Rd/3
YJdyn3Kp1zr3TAumgAHCHHuLKXiJHVfvAUYpgemjBXWHWDRg7RI57b8TD3G1659i
l8db3ymNKeta4RwENSpj3R2Z1miLNA7tNoSW3FyfFJNvmfokv0h7fXTV0xn4JjHu
yeG6Vu+KWrGrt6oRtdPCaoGMOSpmuIvZMSfNkuwDHPANxVdc2LifXIU+I6t6s2qz
N8yCk9YulVA=
=CyQx
-----END PGP SIGNATURE-----
