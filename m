Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131362AbRC0POd>; Tue, 27 Mar 2001 10:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131361AbRC0POY>; Tue, 27 Mar 2001 10:14:24 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:65509 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131353AbRC0POJ>; Tue, 27 Mar 2001 10:14:09 -0500
Message-Id: <l03130337b6e65e809070@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Mar 2001 16:13:17 +0100
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] OOM handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Of course, I realised that.  Actually, what the code does is take an
>> >> initial badness factor (the memory usage), then divide it using goodness
>> >> factors (some based on time, some purely arbitrary), both of which can be
>> >> considered dimensionless.  Also, at the end, the absolute value is not
>> >> considered - we simply look at the biggest one and kill it.  All
>> >> "denormalisation" does is scale all the values, it doesn't affect
>>which one
>> >> actually turns out biggest.
>> >
>> >So you should realize as well that the actual code implementing this
>> >all is by no means numerically stable...
>>
>> It probably isn't, no.  I'll take another look at it and do some dry runs
>> sometime, and see whether they come out as I expect.
>
>Well the output depends heavly on the actual memsize of the process,
>which IMHO isn't a good value for choosing killing candidates...
>Second there is the problem that it's not possible to wight
>the goodness values against each other. The unit
>remaining is Bit/sqr(seconds). Try to get a grasp on this.
>Please have a look at my patch. The function I'm using
>there is a simply wighted sum of two process parameters.

I just ran the following test case through my (Saturday) version of the code:

80MB Oracle process
1 hour CPU time
1 week uptime
UID = 50

The result was less than 1, which means Oracle (or virtually any other
process with an hour of CPU time and a week's uptime) would not get killed.

You're perfectly right about the numerical stability argument, though.
Integers are notoriously granular, so maybe an increase in resolution is
justified.  There's also an issue where an almost-new process (with
run_time under 1024 seconds) would be given infinitely large badness - that
needs fixing.  Jiffie wrap is worth taking account for, too.  The comments
accompanying the code are completely wrong - cpu_time is in units of 8
seconds, and run_time is in units of 1024 seconds, NOT seconds and minutes
as described.

HOWEVER, I just took a look at your patch from Sunday.  I have very serious
concerns about this, which I will try to explain below:

First, your code uses a hard and arbitrary priority level.  This is
arranged such that if the "bad process" (which I use as a euphemism to
indicate a runaway memory hog) is in any class other than "normal", all
"normal" processes MUST exit before the "bad process" will even be
considered.  As a test case:

Suppose you're running Sendmail as uid 25, which puts it in the "system"
class.  This is a multiuser system and there are a lot of interactive,
unprivileged users present.  You are also running RPC services as "service"
class, using UIDs between 100-500.  Now suppose that Sendmail springs a big
memory leak and swamps the available memory, causing OOM - Sendmail is now
the "bad process" I mentioned earlier.  The sysadmin isn't watching the
system closely enough to kill Sendmail manually, and in any case the system
is thrashing so hard he wouldn't be able to log in quickly.

With your code, all the interactive users would be systematically thrown
off the system (losing all their work - SIGKILL is not kind) and the RPC
services would be shut down.  Depending on the relative ages of Sendmail
and other system services, other essential system daemons may also be shut
down (since your code does not take memory usage into account).  Finally,
Sendmail itself is killed and the problem goes away.

In the same scenario, my version of the code would probably kill Sendmail
relatively early in the sequence, since it is the one hogging all the RAM.
A few of the larger interactive process might get killed, depending on
relative ages.  The major flaw in my code is that a sufficiently long-lived
process becomes virtually immortal, even if it happens to spring a serious
leak after this time - the flaw in yours is that system processes have *too
high* priority relative to others, *right from the beginning*.  Both
problems need addressing if either of our algorithms can be considered
acceptable.

Oh and BTW, I think Bit/sqr(seconds) is a perfectly acceptable unit for
"badness".  Think about it - it increases with pigginess and decreases with
longevity.  I really don't see a problem with it per se.

I'm going to be travelling tomorrow, so I've moved my VM work onto my
PowerBook and will consider OOM-kill-selection algorithms and
memory-accounting while I fly.  See you on the other side of the ocean, and
hopefully the fresh Canadian air will help me think about this clearly.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


