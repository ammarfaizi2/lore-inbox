Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281049AbRKCWEN>; Sat, 3 Nov 2001 17:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281051AbRKCWEE>; Sat, 3 Nov 2001 17:04:04 -0500
Received: from relay.planetinternet.be ([194.119.232.24]:57610 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S281049AbRKCWD6>; Sat, 3 Nov 2001 17:03:58 -0500
Date: Sat, 3 Nov 2001 22:04:35 +0100
From: Kurt Roeckx <Q@ping.be>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011103220435.A11159@ping.be>
In-Reply-To: <506556532.1004787679@[195.224.237.69]> <Pine.LNX.4.21.0111031813390.9415-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0111031813390.9415-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Sat, Nov 03, 2001 at 06:35:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 06:35:44PM +0000, Riley Williams wrote:
> server	127.127.1.0		# local clock
> fudge	127.127.1.0 stratum 10	
> 
> The second server line specifies 127.127.1.0 which is the address that
> ntp associates with the local RTC clock.

>From refclock_local:
 * This is a hack to allow a machine to use its own system clock as a
 * reference clock

This just calls gettimeofday() indirectly.

It's the system clock, not the RTC.  Afaik, there is no support
for the RTC clock.

> >>  2. My experience with the xntpd driver suggests that if no better
> >>     reference is available and the RTC is one of the listed clocks,
> >>     then it ALWAYS adjusts the time to match the RTC, irrespective
> >>     of the time difference between them.
> 
> > ... you are assuming that the RTC doesn't get adjusted first (to
> > match the system clock)!
> 
> If it does, what adjusts it?

ntpd asks the kernel to write the time to the RTC.  I think it
does that from the moment it's sycnhed.  If it would be reading
and writing to the RTC, you could have a problem.

> >>  3. AFAICT, if xntpd writes to the RTC, then it has achieved true
> >>     synchronisation to a reference clock other than the RTC.
> 
> > I thought the original poster was claiming that the /kernel/
> > wrote to the RTC, which would explain the behaviour I'm seeing.
> 
> The kernel itself never writes to the RTC, and that is one of Linus's
> decisions with which I am in 100% agreeance (and one thing I hate about
> Windows). In fact, the kernel itself also doesn't read from the RTC
> either, but leaves that to userspace.

The kernel does write to the RTC if told to do so, every 11
minutes.  This is broken because it doesn't even know what hour
it should be writing, so it doesn't write it.

In arch/i386/kernel/time.c/do_timer_interrupt():

        /*
         * If we have an externally synchronized Linux clock, then update
         * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
         * called as close as possible to 500 ms before the new second starts.
         */
        if ((time_status & STA_UNSYNC) == 0 &&
            xtime.tv_sec > last_rtc_update + 660 &&
            xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
            xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
                if (set_rtc_mmss(xtime.tv_sec) == 0)
                        last_rtc_update = xtime.tv_sec;
                else
                        last_rtc_update = xtime.tv_sec - 600; /* do it again in
60 s */
        }

Kurt

