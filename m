Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280702AbRKGACV>; Tue, 6 Nov 2001 19:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280707AbRKGACM>; Tue, 6 Nov 2001 19:02:12 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:5990 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S280695AbRKGACE>; Tue, 6 Nov 2001 19:02:04 -0500
Posted-Date: Wed, 7 Nov 2001 00:00:40 GMT
Date: Wed, 7 Nov 2001 00:00:39 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <20011106111723.C26034@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0111062347080.16087-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

>>> That seems as very wrong solution.
>>>
>>> What about just making kernel only _read_ system clock, and
>>> never set it? That looks way cleaner to me.

>> It is cleaner. However, I feel that the RTC code should printk (at
>> least as KERN_DEBUG if not as KERN_NOTICE) whenever the RTC is
>> written to. It's too important a subsystem to be left hidden like
>> it currently is.

> This can be as well done in userland, enforced by whoever does rtc
> writes, no?

If some idiot writes a hwclock replacement that doesn't do logging, and
sets the rtc to the output from /dev/random, how does the kernel enforce
that it must log this to /var/log/messages other than by doing the
printk() itself?

> I propose kernel not to do any writes, so it is only userland left.
> And having printk() in kernel or syslog() in hwclock seems pretty
> much equivalent, with later prefered as it magically works on older
> kernels.

I think we're talking at cross-purposes here, so here's my proposal,
which I feel is the only one that actually makes sense:

 1. The /dev/rtc driver in the kernel is the ONLY code that can
    actually read or write to the RTC registers.

    Alternatively, this could be replaced with a sysctl() if that
    is preferred. The important thing is that there is only ONE way
    of performing this write.

 2. The kernel makes no internal reference to the /dev/rtc driver,
    and it is left to userland tools to sync to the RTC on boot,
    and at other times as required.

 3. Whenever the /dev/rtc driver writes to ANY of the RTC registers
    (whether to set the time, the alarm, or anything else), it logs
    this fact using printk at level KERN_DEBUG. The SYSLOG utility
    can be configured to ignore KERN_DEBUG messages, or to deal with
    them in any other way desired.

If I've demangling your comments correctly, then you've basically said
the same as I've said above. If not, can you please advise how you feel
this proposal should be altered.

Best wishes from Riley.

