Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267688AbUHEOLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267688AbUHEOLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHEOKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:10:52 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:27296 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S267690AbUHENsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:48:50 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 09:48:47 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408050031.21366.gene.heskett@verizon.net> <20040805004402.GA6304@cox.net>
In-Reply-To: <20040805004402.GA6304@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408050948.47535.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.11.172] at Thu, 5 Aug 2004 08:48:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 20:44, Chris Shoemaker wrote:
>On Thu, Aug 05, 2004 at 12:31:21AM -0400, Gene Heskett wrote:
>> On Wednesday 04 August 2004 23:46, Andrew Morton wrote:
>> >Gene Heskett <gene.heskett@verizon.net> wrote:
>> >>  The attachment this gentleman included specifically points to
>> >>  prune_dcache().  Thats nice.  It also means I'm not alone. 
>> >> See the 'prune_dcache() Oops, the saga continues' thread.
>> >
>> >Except he's running a 2.4 kernel.

I didn't take note of that. What triggerd my response was the 
prune_dcache() problem.  In my case we've taken a couple of than 
apart and the Opps is actually in the _dput() statement where 
the eas register contains a very small, but non-zero value, like 
maybe 0x00000820.  Thats a bit difficult as some of this code is 
marked as __inline, and can reach over 130 bytes between the 
labels we put into the srcs.  IMO, thats too much to inline 
if its used more than once, and it is.

And guess what, both prune_dcache() and _dput() are inlined...

>> >Is there any reason why I'm wrong in thinking that you have dodgy
>> >hardware?
>>
>> Well, it has, in the past week, ran memtest86-3a for 12 full
>> passes over the whole gig of ram with no errors.  This was the
>> longest test, I gave it a 2 hour, 5 pass test before I ever booted
>> linux the first time on this motherboard over 2 weeks ago now, a
>> new Biostar M7NCD-Pro, with an nforce2(3?) chipset.  I did that
>> because I was comeing from an older board whose memory had been
>> overstressed by a failing video card and I wanted to make sure
>> this new memory, nearly $210 worth of it, was good. I gave it
>> another, probably 4 hour test after the first couple of crashes,
>> which it also passed.  And it got worse as the kernel versions
>> incremented from 2.6.7.  I can have the same fault in
>> prune_dcache() while running a 2.6.7 kernel without an instant
>> lockup, but it will eventually die, maybe half an hour later. Move
>> to 2.6.7-mm1, which has a patch to fs/dcache.c that remains
>> untouched thru 2.6.8-rc2, and those kernels, if they lock up, do
>> it totally, often with nothing in the logs at all.  That was the
>> case today, on 2.6.8-rc3, which has a new dcache.c patch in it if
>> I read the release notes correctly.
>>
>> If this is dodgy hardware, give me something to take to tcwo.com
>> when I ask for an rma.  Not having M$ windows of any kind here, I
>> frankly haven't had the inclination to look at the cd's that came
>> with the board.  Should I?
>>
>> Or does linux have a hardware test suite I've not heard about?
>
>Gene,
>	I sympathize with you.  Back in March and April I was seeing
>oopses in prune_dcache() once every few days.  After tracing the asm
>down for a few of them, I found one that looked like a 3 bit flip
> and then one that looked like a single bit flip.  I memtested my
> RAM for days with no failure.  I tried cpuburn.  I looped over
> kernel compiles. I couldn't make it fail, but every day or two, as
> long as I wasn't trying, I'd get an oops, and more than %50 were in
> prune_dcache.  I believed that there was a correspondence with low
> memory conditions, but I never proved this.  I _added_ a memory
> module (keeping everything I had) and I compiled 2.6.7-rc3 on Jun
> 10th.  I haven't oopsed since.  (I think I may also have turned off
> PREEMP around this time, so that's why I suggested it earlier.)
>
>	FWIW, I've seen no fewer than 4 independent reports that looked
>suspiciously like yours and mine over the past 3 months.  Maybe we
> all have bad hardware, and memtest86 just isn't stressful enough to
> show it. The alternative is that there's some bug that has affected
> several versions of 2.6 (and maybe 2.4) that seems to hit in low
> memory conditions (e.g. as a result of a 4am cron.daily, or a large
> rsync).

That does seem to correlate slightly, but yesterdays was in the 
middle of the afternoon while I was elsewhere, and very little 
is cron related at that time of day.

>	If you're curious, search google groups for "+oops +prune_dcache
>group:linux.kernel", sort by date and look through the first 3 or 4
>pages.  You'll see the same story with the same oopses over and
> over. I know the few single bit flips are _probably_ bad hardware,
> but the more similarities I see, the more I wonder.

Me too, says he in a plaintive voice.

>	But, since my problems have completely gone away by adding more
> RAM, I haven't been motivated to track it down anymore.
>
>	Sorry I can't be more helpful.  Good luck.

This is a '3 slots for ram' board, and according to the docs, the 
Dual Channel DDR 400 banking scheme only works if the ram is in 
the 1st and 3rd slots, so thats where I put it.  memtest86 reports 
a ram bandwidth of around 1.2 Gb/sec, and an L1 cache bandwidth of 
around 12Gb/sec.  No L2 present.

I might add that the first time I ran memtest86, the bios was 
missconfigured, at factory defaults, and was running the athlon 2800 
at 3200, and the memory bus at over 450 mhz.  No problem, but I did 
find an FSB and multiplier setting that gave a 400Mb bus, and which 
says the athlon-XP is a 2800+, so I figure that should be correct.

The defaults didn't always want to post, but gave no other problems 
once it had.

If I put another stick in the last, center slot, how does the 
hardware accept that?  I'd have to go get one as the 256's in the 
old board are known dodgy.  Would this incipient Oom condition not 
be handled correctly?  If thats the cause, then maybe that portion 
of the code needs looked at, by experts the likes of which I don't 
pretend to be.  But with a Gig of ram, I don't recall it ever 
using any swap.  But it's perilously close to that right now 
according to top:

top - 08:58:30 up  9:59,  5 users,  load average: 1.21, 1.31, 1.16
Tasks: 100 total,   2 running,  97 sleeping,   0 stopped,   1 zombie
Cpu(s):  5.6% us,  2.6% sy, 91.4% ni,  0.0% id,  0.0% wa,  0.3% hi,  0.0% si
Mem:   1036020k total,  1018644k used,    17376k free,   230960k buffers
Swap:  3857104k total,        0k used,  3857104k free,   119552k cached

mmm, I wonder who the zombie is.  Ahh, it's ~/bin/its-daylight.  
It's a script that cron triggered, and which changes the mode of 
the heyu/xtend stuff for daytime operations.  Its (a bash script)
apparently hung looking for a response it didn't get.  I have 3 
of those at various times of the day and I've never gotten email 
from that one.  The mode change does occur though...  FWIW heyu 
has been fixed, the distro version has a severe scope problem 
from a missing '}' which was not caught by the compiler, but by 
a tool I wrote years ago for os9 that I've ported to linux!   The 
heyu author ): didn't seem to be interested in fixing it either.

I'll go take a look at it after I've sent this, but it does bring 
up a sore point.  linux doesn't get this right, os9 did.  zombies 
are killable by os9, it simply takes it out of the execution queue, 
and reclaims all resources used back into the free pool, no 
questions asked or expected.  We shouldn't have to reboot just to 
kill a fscking zombie...

In any event, PREEPMT is now off, if this takes a dump, then the 
hi-mem support gets turned off and PREEMPT back on.  One thing at a time.

Thanks for the discussion, it was "enlightening" :-)

>-chris

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
