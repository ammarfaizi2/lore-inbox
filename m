Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281011AbRKCSzz>; Sat, 3 Nov 2001 13:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281010AbRKCSzg>; Sat, 3 Nov 2001 13:55:36 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:19234 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S281008AbRKCSzd>; Sat, 3 Nov 2001 13:55:33 -0500
Posted-Date: Sat, 3 Nov 2001 18:35:44 GMT
Date: Sat, 3 Nov 2001 18:35:44 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <506556532.1004787679@[195.224.237.69]>
Message-ID: <Pine.LNX.4.21.0111031813390.9415-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex.

>> That sounds like a configuration error to me, and here's why.
>>
>>  1. One of the available reference clocks for xntpd is the local
>>     RTC, type 1 in the list of reference clock types, and that
>>     should ALWAYS be listed as one of the reference clocks to use,
>>     but with a higher stratum than any other reference clock used.

> Well, perhaps that's a difference between xntpd and ntpd - I am
> using the latter, version 4.1.0, from Debian testing.

I'm currently on RedHat 6.2 on the system in question, and I have the
xntp3-5.93-14.i386.rpm package installed. I can only comment on that as
a result.

> Manpage doesn't mention RTC, ntpdc doesn't seem to find it. I may
> well be out of sync with ntpd (pun fully intended) as I haven't
> looked at it for a while, but...

The following is the start of my /etc/ntp.conf file, so perhaps you can
compare it to yours and advise if it looks anywhere near similar...

===8<=== CUT ===>8===
# Remote systems I am authorised to synchronise to.
#
server	ntp4.cs.strath.ac.uk

#
# Undisciplined Local Clock. This is a fake driver intended for backup
# and when no outside source of synchronized time is available. The
# default stratum is usually 3, but in this case we elect to use stratum
# 10. Since the server line does not have the prefer keyword, this
# driver is never used for synchronization, unless no other other
# synchronization source is available. In case the local host is
# controlled by some external source, such as an external oscillator or
# another protocol, the prefer keyword would cause the local host to
# disregard all other synchronization sources, unless the kernel
# modifications are in use and declare an unsynchronized condition.
#
server	127.127.1.0		# local clock
fudge	127.127.1.0 stratum 10	

===8<=== CUT ===>8===

The lines starting with '#' are comments describing the reasons for the
choices in question, and this is the only interesting part of the
configuration file as far as this discussion is concerned.

The first server line specifies the clock source to be used when I'm
online, this one being at the University of Strathclyde in Scotland, and
is one that I have obtained permission to use. As nothing else is given,
it stands at stratum 2 (as obtained on request from the timeserver
itself).

The second server line specifies 127.127.1.0 which is the address that
ntp associates with the local RTC clock. The fudge line that follows
specifies that this is to stand at stratum 10, and thus that it is
considerably less reliable than the first server line. It therefore gets
ignored when the first listed server is available, and is only used if
nothing better can be contacted.

>>  2. My experience with the xntpd driver suggests that if no better
>>     reference is available and the RTC is one of the listed clocks,
>>     then it ALWAYS adjusts the time to match the RTC, irrespective
>>     of the time difference between them.

> ... you are assuming that the RTC doesn't get adjusted first (to
> match the system clock)!

If it does, what adjusts it?

>>  3. AFAICT, if xntpd writes to the RTC, then it has achieved true
>>     synchronisation to a reference clock other than the RTC.

> I thought the original poster was claiming that the /kernel/
> wrote to the RTC, which would explain the behaviour I'm seeing.

The kernel itself never writes to the RTC, and that is one of Linus's
decisions with which I am in 100% agreeance (and one thing I hate about
Windows). In fact, the kernel itself also doesn't read from the RTC
either, but leaves that to userspace.

> An alternative explanation I suppose is simply that nothing is
> writing to the RTC (not ntpd, not anything) except for the final
> clock command as the machine shuts down. Very simply the symptom is
> that both clocks are correct, I suspend the machine (without APM in
> the kernel), I resume it, reboot it, and now both clocks are wrong.

That's possible. However, I'd start by grep'ing your bootup and shutdown
scripts for lines containing the word 'clock' either on its own or as
part of a longer word, where those lines are not comments. If you have a
RedHat distribution, then...

 Q> find /etc -type f | xargs fgrep clock /dev/null | fgrep -v ':#'

...will give you a list of possibilities. Go through these and check
what each one is doing, and if any are SETTING the RTC, then comment
them out. Let me know whether that cures your problem. The reason for
this is that the standard RTC setting programmes are `clock` and
`hwclock` and either can be told to copy the current system time into
the RTC.

>> If you have the RTC as one of your reference clocks, then this
>> heuristic is not required as xntpd (at least) does the right thing
>> for you.

> OK I will go read the manpage even harder.

If it's not the above, please advise what you find.

Best wishes from Riley.

